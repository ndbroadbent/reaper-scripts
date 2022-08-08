#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry-byebug'
require 'json'
require 'securerandom'

def generate_id
  # Matches ReaLearn format - 21 chars, e.g. a8ts43h_z51xUcP6VrQ_3
  SecureRandom.base64(16).gsub(
    %r{[/=+]}, '_'
  )[0...21]
end

ROW_PARAM = 0
RECORD_BUTTON_PARAM = 1
BACK_BUTTON_PARAM = 2
FORWARD_BUTTON_PARAM = 3

buttons_group_id = generate_id

config = {
  kind: 'Session',
  value: {
    version: '2.13.1',
    id: 'JS6vXA_o',
    letMatchedEventsThrough: true,
    controlDeviceId: '1',
    feedbackDeviceId: '1',
    defaultGroup: {},
    groups: [
      {
        id: buttons_group_id,
        name: 'Buttons'
      }
    ],
    defaultControllerGroup: {},
    mappings: [
      # Play/stop/metronome, etc.
      {
        id: '92-37JRiYZXCSirJw3k3Y',
        name: 'Stop',
        source: {
          channel: 15,
          number: 105,
          character: 1,
          isRegistered: false,
          is14Bit: false,
          oscArgIndex: 0
        },
        mode: {
          maxStepSize: 0.05,
          minStepFactor: 1,
          maxStepFactor: 5,
          buttonUsage: 'press-only'
        },
        target: {
          type: 16,
          fxAnchor: 'id',
          transportAction: 'stop',
          useProject: true,
          moveView: true,
          seekPlay: true,
          oscArgIndex: 0
        }
      },
      {
        id: 'k9KRdEZvR7zmIdgscmG6K',
        name: 'Play / Pause',
        source: {
          channel: 15,
          number: 106,
          character: 1,
          isRegistered: false,
          is14Bit: false,
          oscArgIndex: 0
        },
        mode: {
          maxStepSize: 0.05,
          minStepFactor: 1,
          maxStepFactor: 5,
          buttonUsage: 'press-only'
        },
        target: {
          type: 16,
          fxAnchor: 'id',
          transportAction: 'playPause',
          useProject: true,
          moveView: true,
          seekPlay: true,
          oscArgIndex: 0
        }
      },
      {
        id: 't0ikaC6_ss790JJRz4ovk',
        name: 'Toggle Metronome (Repeat button)',
        source: {
          channel: 15,
          number: 102,
          character: 1,
          isRegistered: false,
          is14Bit: false,
          oscArgIndex: 0
        },
        mode: {
          maxStepSize: 0.05,
          minStepFactor: 1,
          maxStepFactor: 5
        },
        target: {
          type: 0,
          commandName: '40364',
          invocationType: 0,
          fxAnchor: 'id',
          useProject: true,
          moveView: true,
          seekPlay: true,
          oscArgIndex: 0
        }
      },

      {
        id: generate_id,
        groupId: buttons_group_id,
        name: 'Row Buttons (1 to 8)',
        source: {
          channel: 0,
          number: 0,
          isRegistered: false,
          is14Bit: false,
          oscArgIndex: 0
        },
        mode: {
          maxSourceValue: 0.07874015748031496,
          maxStepSize: 0.05,
          minStepFactor: 1,
          maxStepFactor: 5
        },
        target: {
          fxAnchor: 'id',
          fxIndex: 1,
          fxGUID: '5CFB8AD0-A4B1-DF49-AFCD-15EAC2A76499',
          paramIndex: 0,
          useProject: true,
          moveView: true,
          seekPlay: true,
          oscArgIndex: 0,
          pollForFeedback: false
        },
        feedbackIsEnabled: false
      },

      {
        id: generate_id,
        groupId: buttons_group_id,
        name: 'Record Button',
        source: {
          channel: 15,
          number: 107,
          isRegistered: false,
          is14Bit: false,
          oscArgIndex: 0
        },
        mode: {
          maxStepSize: 0.05,
          minStepFactor: 1,
          maxStepFactor: 5
        },
        target: {
          fxAnchor: 'id',
          fxIndex: 1,
          fxGUID: '5CFB8AD0-A4B1-DF49-AFCD-15EAC2A76499',
          paramIndex: RECORD_BUTTON_PARAM,
          useProject: true,
          moveView: true,
          seekPlay: true,
          oscArgIndex: 0
        },
        feedbackIsEnabled: false
      },
      {
        id: generate_id,
        groupId: buttons_group_id,
        name: 'Back Button',
        source: {
          channel: 15,
          number: 103,
          isRegistered: false,
          is14Bit: false,
          oscArgIndex: 0
        },
        mode: {
          maxStepSize: 0.05,
          minStepFactor: 1,
          maxStepFactor: 5
        },
        target: {
          fxAnchor: 'id',
          fxIndex: 1,
          fxGUID: '5CFB8AD0-A4B1-DF49-AFCD-15EAC2A76499',
          paramIndex: BACK_BUTTON_PARAM,
          useProject: true,
          moveView: true,
          seekPlay: true,
          oscArgIndex: 0
        },
        feedbackIsEnabled: false
      },
      {
        id: generate_id,
        groupId: buttons_group_id,
        name: 'Forward Button',
        source: {
          channel: 15,
          number: 104,
          isRegistered: false,
          is14Bit: false,
          oscArgIndex: 0
        },
        mode: {
          maxStepSize: 0.05,
          minStepFactor: 1,
          maxStepFactor: 5
        },
        target: {
          fxAnchor: 'id',
          fxIndex: 1,
          fxGUID: '5CFB8AD0-A4B1-DF49-AFCD-15EAC2A76499',
          paramIndex: FORWARD_BUTTON_PARAM,
          useProject: true,
          moveView: true,
          seekPlay: true,
          oscArgIndex: 0
        },
        feedbackIsEnabled: false
      }
    ],
    parameters: {
      '10': { value: 0.2 }

    },
    instanceFx: {
      address: 'Focused'
    }
  }
}

value = config[:value]

(1..8).each do |track_row|
  row_buttons_group_id = generate_id
  row_leds_group_id = generate_id

  value[:groups] << {
    id: row_buttons_group_id,
    name: "Row #{track_row} - Pad Controls",
    activationType: 'expression',
    # Activates the mappings in the group when we press the corresponding row button
    # (Floating point numbers are a pain)
    eelCondition: "p[#{ROW_PARAM}] >= #{track_row * 0.1} && p[#{ROW_PARAM}] < #{(track_row + 1) * 0.1}"
  }

  value[:groups] << {
    id: row_leds_group_id,
    name: "Row #{track_row} - Pad LEDs",
    activationType: 'expression',
    # Activates the mappings in the group when we press the corresponding row button
    # (Floating point numbers are a pain)
    eelCondition: "p[#{ROW_PARAM}] >= #{track_row * 0.1} && p[#{ROW_PARAM}] < #{(track_row + 1) * 0.1}"
  }

  (1..8).each do |track_column|
    # --------------------------------------------
    # Control pad LEDs with MIDI CC feedback

    # ReaLearn params
    # slot (row) 1, track (column) 1 trigger = 100
    # slot (row) 1, track (column) 1 record = 101
    # slot (row) 1, track (column) 2 trigger = 120
    # slot (row) 1, track (column) 2 record = 121
    # slot (row) 1, track (column) 8 trigger = 240
    # slot (row) 1, track (column) 8 record = 241
    # slot (row) 2, track (column) 1 trigger = 260
    # slot (row) 2, track (column) 1 record = 261

    trigger_param_index = ((track_row - 1) * 160) + ((track_column - 1) * 20) + 100
    record_param_index = trigger_param_index + 1
    clear_and_delete_param_index = trigger_param_index + 11

    cc_channel = track_column + 44

    # Need a separate mapping just to read the record state and switch between
    # the two LED modes (record/play)
    record_state_id = generate_id
    record_state_mapping = {
      id: record_state_id,
      groupId: row_leds_group_id,
      name: "Track #{track_column}/#{track_row} Record State",
      source: {
        category: 'never',
        channel: 0,
        number: 45,
        character: 1,
        isRegistered: false,
        is14Bit: false,
        oscArgIndex: 0
      },
      mode: {
        maxStepSize: 0.05,
        minStepFactor: 1,
        maxStepFactor: 5,
        outOfRangeBehavior: 'min'
      },
      target: {
        trackGUID: '506EF9FC-16DF-40F3-A7CE-B5E7499D2833',
        fxAnchor: 'id',
        fxGUID: 'C0C18AB3-74E3-4A23-BA84-443031795E4D',
        paramIndex: record_param_index,
        useProject: true,
        moveView: true,
        seekPlay: true,
        oscArgIndex: 0
      },
      controlIsEnabled: false
    }

    record_status_id = generate_id
    record_status_mapping = {
      id: record_status_id,
      groupId: row_leds_group_id,
      name: "Track #{track_column}/#{track_row} Record LED",
      source: {
        channel: 0,
        number: cc_channel,
        character: 1,
        isRegistered: false,
        is14Bit: false,
        oscArgIndex: 0
      },
      mode: {
        maxStepSize: 0.05,
        minStepFactor: 1,
        maxStepFactor: 5,
        outOfRangeBehavior: 'min'
      },
      target: {
        trackGUID: '506EF9FC-16DF-40F3-A7CE-B5E7499D2833',
        fxAnchor: 'id',
        fxGUID: 'C0C18AB3-74E3-4A23-BA84-443031795E4D',
        paramIndex: record_param_index,
        useProject: true,
        moveView: true,
        seekPlay: true,
        oscArgIndex: 0
      },
      controlIsEnabled: false,
      activationType: 'target-value',
      eelCondition: 'y > 0', # Show red LED when recording
      mappingKey: record_state_id
    }

    trigger_status_mapping = {
      id: generate_id,
      groupId: row_leds_group_id,
      name: "Track #{track_column}/#{track_row} Trigger LED",
      source: {
        channel: 0,
        number: cc_channel,
        character: 1,
        isRegistered: false,
        is14Bit: false,
        oscArgIndex: 0
      },
      mode: {
        maxSourceValue: 0.08,
        maxStepSize: 0.05,
        minStepFactor: 1,
        maxStepFactor: 5,
        outOfRangeBehavior: 'min'
      },
      target: {
        trackGUID: '506EF9FC-16DF-40F3-A7CE-B5E7499D2833',
        fxAnchor: 'id',
        fxGUID: 'C0C18AB3-74E3-4A23-BA84-443031795E4D',
        paramIndex: trigger_param_index,
        useProject: true,
        moveView: true,
        seekPlay: true,
        oscArgIndex: 0
      },
      controlIsEnabled: false,
      activationType: 'target-value',
      eelCondition: 'y == 0', # Show green LED when playing but not recording
      mappingKey: record_state_id
    }

    value[:mappings] << record_state_mapping
    value[:mappings] << trigger_status_mapping
    value[:mappings] << record_status_mapping

    # --------------------------------------------
    # Buttons

    record_button_mapping = {
      id: generate_id,
      name: "Track #{track_column}/#{track_row} - Record",
      groupId: row_buttons_group_id,
      source: {
        channel: 0,
        number: cc_channel,
        character: 5,
        isRegistered: false,
        is14Bit: false,
        oscArgIndex: 0
      },
      mode: {
        type: 2,
        maxStepSize: 0.05,
        minStepFactor: 1,
        maxStepFactor: 1,
        minPressMillis: 200,
        maxPressMillis: 200,
        outOfRangeBehavior: 'min',
        fireMode: 'double'
      },
      target: {
        trackGUID: '506EF9FC-16DF-40F3-A7CE-B5E7499D2833',
        fxAnchor: 'id',
        fxGUID: 'C0C18AB3-74E3-4A23-BA84-443031795E4D',
        paramIndex: record_param_index,
        useProject: true,
        moveView: true,
        seekPlay: true,
        oscArgIndex: 0,
        pollForFeedback: false
      },
      feedbackIsEnabled: false,
      activationType: 'modifiers',
      modifierCondition1: {
        paramIndex: RECORD_BUTTON_PARAM, # When record button is pressed
        isOn: true
      },
      modifierCondition2: {
        paramIndex: BACK_BUTTON_PARAM, # When back button is not pressed
        isOn: false
      }
    }
    trigger_button_mapping = {
      id: generate_id,
      name: "Track #{track_column}/#{track_row} - Trigger",
      groupId: row_buttons_group_id,
      source: {
        channel: 0,
        number: cc_channel,
        character: 5,
        isRegistered: false,
        is14Bit: false,
        oscArgIndex: 0
      },
      mode: {
        type: 2,
        maxStepSize: 0.05,
        minStepFactor: 1,
        maxStepFactor: 1,
        minPressMillis: 200,
        maxPressMillis: 200,
        outOfRangeBehavior: 'min',
        fireMode: 'double'
      },
      target: {
        trackGUID: '506EF9FC-16DF-40F3-A7CE-B5E7499D2833',
        fxAnchor: 'id',
        fxGUID: 'C0C18AB3-74E3-4A23-BA84-443031795E4D',
        paramIndex: trigger_param_index,
        useProject: true,
        moveView: true,
        seekPlay: true,
        oscArgIndex: 0,
        pollForFeedback: false
      },
      feedbackIsEnabled: false,
      activationType: 'modifiers',
      modifierCondition1: {
        paramIndex: RECORD_BUTTON_PARAM, # When record button is not pressed
        isOn: false
      },
      modifierCondition2: {
        paramIndex: BACK_BUTTON_PARAM, # When back button is not pressed
        isOn: false
      }
    }
    clear_button_mapping = {
      id: generate_id,
      name: "Track #{track_column}/#{track_row} - Clear",
      groupId: row_buttons_group_id,
      source: {
        channel: 0,
        number: cc_channel,
        character: 5,
        isRegistered: false,
        is14Bit: false,
        oscArgIndex: 0
      },
      mode: {
        type: 2,
        maxStepSize: 0.05,
        minStepFactor: 1,
        maxStepFactor: 1,
        minPressMillis: 200,
        maxPressMillis: 200,
        outOfRangeBehavior: 'min',
        fireMode: 'double'
      },
      target: {
        trackGUID: '506EF9FC-16DF-40F3-A7CE-B5E7499D2833',
        fxAnchor: 'id',
        fxGUID: 'C0C18AB3-74E3-4A23-BA84-443031795E4D',
        paramIndex: clear_and_delete_param_index,
        useProject: true,
        moveView: true,
        seekPlay: true,
        oscArgIndex: 0,
        pollForFeedback: false
      },
      feedbackIsEnabled: false,
      activationType: 'modifiers',
      modifierCondition1: {
        paramIndex: RECORD_BUTTON_PARAM, # When record button is not pressed
        isOn: false
      },
      modifierCondition2: {
        paramIndex: BACK_BUTTON_PARAM, # When back button is pressed
        isOn: true
      }
    }

    value[:mappings] << record_button_mapping
    value[:mappings] << trigger_button_mapping
    value[:mappings] << clear_button_mapping
  end
end

File.open('output.json', 'w') do |f|
  f.puts JSON.pretty_generate(config)
end

puts 'Generated ReaLearn configuration JSON to output.json'
