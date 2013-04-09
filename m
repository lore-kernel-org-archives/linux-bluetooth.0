Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 9 Apr 2013 20:02:16 +0800
Message-ID: <CANK1S=MG_kJ3DJmjV9nSbEW0E51ru_ukFsbHjx4fTMoYAMHv5A@mail.gmail.com>
Subject: Bluez 5.3: Failed to connect to speaker (Unable to select SEP)
From: Om Huang <dendrobium0093@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to use bluez-5.3 to connect to a Bluetooth speaker. My
computer is ubuntu-12.10 x86_64 with Linux 3.5.0. The bluez source was
downloaded from http://www.bluez.org/release-of-bluez-5-3/

I have read the previous thread "Bluez 5.2 A2DP: Unable to select SEP"
and thus enable source, sink and control in profiles/audio/manager.c.
I also enable gateway, socket and source in /etc/bluetooth/audio.conf.
I disable systemd in configure. And then make and make install.
Unfortunately, I still got an error "Unable to select SEP" when I try
to connect to my speaker. Any suggestion or idea? Thanks for any help.

Here is the log from bluetoothd.

bluetoothd[5137]: src/device.c:connect_profiles()
/org/bluez/hci0/dev_00_02_5B_00_FF_04
0000110B-0000-1000-8000-00805F9B34FB, client :1.189
bluetoothd[5137]: profiles/audio/manager.c:a2dp_sink_connect() path
/org/bluez/hci0/dev_00_02_5B_00_FF_04
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_ref() 0x1d0f3f0: ref=1
bluetoothd[5137]: profiles/audio/sink.c:sink_set_state() State changed
/org/bluez/hci0/dev_00_02_5B_00_FF_04: SINK_STATE_DISCONNECTED ->
SINK_STATE_CONNECTING
bluetoothd[5137]: profiles/audio/sink.c:sink_connect() stream creation
in progress
bluetoothd[5137]: src/adapter.c:connected_callback() hci0 device
00:02:5B:00:FF:04 connected eir_len 5
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP:
connected signaling channel to 00:02:5B:00:FF:04
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP
imtu=672, omtu=895
bluetoothd[5137]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[5137]: profiles/audio/avdtp.c:session_cb()
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_parse_resp() DISCOVER
request succeeded
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_discover_resp() seid 1
type 1 media 0 in use 0
bluetoothd[5137]: profiles/audio/avdtp.c:session_cb()
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_parse_resp()
GET_CAPABILITIES request succeeded
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_get_capabilities_resp()
seid 1 type 1 media 0
bluetoothd[5137]: profiles/audio/sink.c:discovery_complete() Discovery complete
bluetoothd[5137]: Unable to select SEP
bluetoothd[5137]: src/device.c:device_profile_connected() audio-sink
Input/output error (5)
bluetoothd[5137]: src/device.c:device_profile_connected() returning
response to :1.189
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_unref() 0x1d0f3f0: ref=0
bluetoothd[5137]: profiles/audio/avctp.c:avctp_connect_cb() AVCTP:
connected to 00:02:5B:00:FF:04
bluetoothd[5137]: profiles/audio/avctp.c:init_uinput() AVRCP: uinput
initialized for 00:02:5B:00:FF:04
bluetoothd[5137]: profiles/audio/avrcp.c:session_tg_init_control()
0x1d14010 version 0x0104
bluetoothd[5137]: src/device.c:device_profile_connected() audio-avrcp
Success (0)
bluetoothd[5137]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connected
bluetoothd[5137]: profiles/audio/avrcp.c:handle_vendordep_pdu() AVRCP
PDU 0x31, company 0x001958 len 0x0500
bluetoothd[5137]: profiles/audio/avdtp.c:connection_lost()
Disconnected from 00:02:5B:00:FF:04
bluetoothd[5137]: profiles/audio/sink.c:sink_set_state() State changed
/org/bluez/hci0/dev_00_02_5B_00_FF_04: SINK_STATE_CONNECTING ->
SINK_STATE_DISCONNECTED
bluetoothd[5137]: profiles/audio/avrcp.c:session_tg_destroy() 0x1d14010
bluetoothd[5137]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
bluetoothd[5137]: profiles/audio/avctp.c:avctp_disconnected() AVCTP:
closing uinput for 00:02:5B:00:FF:04
bluetoothd[5137]: profiles/audio/avdtp.c:avdtp_free() 0x1d0f3f0
bluetoothd[5137]: profiles/audio/avctp.c:avctp_confirm_cb() AVCTP:
incoming connect from 00:02:5B:00:FF:04
bluetoothd[5137]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[5137]: profiles/audio/avctp.c:avctp_connect_cb() AVCTP:
connected to 00:02:5B:00:FF:04
bluetoothd[5137]: profiles/audio/avctp.c:init_uinput() AVRCP: uinput
initialized for 00:02:5B:00:FF:04
bluetoothd[5137]: profiles/audio/avrcp.c:session_tg_init_control()
0x1d0c2f0 version 0x0104
bluetoothd[5137]: src/device.c:device_profile_connected() audio-avrcp
Success (0)
bluetoothd[5137]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connected
bluetoothd[5137]: profiles/audio/avrcp.c:handle_vendordep_pdu() AVRCP
PDU 0x31, company 0x001958 len 0x0500

Sincerely,
Om
