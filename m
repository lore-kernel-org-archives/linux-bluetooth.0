Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alex Deymo <deymo@chromium.org>
Date: Tue, 7 May 2013 16:47:23 -0700
Message-ID: <CAGd9gwjqSiH3=JwR80VcuXf2Z7KA8zOsYFT9N5gAZgZnTfF2wQ@mail.gmail.com>
Subject: Audio sink stream remains suspended on reconnection
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!
I'm trying to debug a problem we have while playing audio on a Monster
ClarityHD. I can reproduce the following problem several times,
although not always. The procedures is the following:
1. Power on and put the Monster ClarityHD bluetooth speaker in discovery mode.
2. Using bluetoothctl: scan, pair, trust and connect the device.
3. Play some music and keep it playing. The music plays on the
bluetooth speakers.
4. Power off the bluetooth speakers. The device then shows as
disconnected shortly after.
5. Power on the bluetooth speakers again and attempt a "connect" from
the bluetoothctl.

Then the music play for a second or two back in the bluetooth speakers
and stops playing. I can see the audio traffic still going with btmon
even when the music is not getting out of the bluetooth speakers. The
music start and stop in the bluetooth speakers corresponds with the
START_CMD and SUSPEND events in the log bellow. The blank lines
represent a gap in time of 1 or 2 seconds.

Does anyone have any idea on what's going on?
It looks to me like the "SUSPEND request succeeded" of a previous
SUSPEND_CMD arrives just after "Received START_CMD" and the device
remains suspended, but I have no idea how to fix that =/

Thanks,
Alex.

bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP:
connected transport channel to 10:B7:F6:01:31:ED
bluetoothd[21017]: profiles/audio/avdtp.c:handle_transport_connect()
Flushable packets enabled
bluetoothd[21017]: profiles/audio/avdtp.c:handle_transport_connect()
sk 20, omtu 895, send buffer size 106496
bluetoothd[21017]: profiles/audio/a2dp.c:open_cfm() Source
0x7f2acd437a00: Open_Cfm
bluetoothd[21017]: profiles/audio/sink.c:stream_setup_complete()
Stream successfully created
bluetoothd[21017]: src/device.c:device_profile_connected() audio-sink
Success (0)
bluetoothd[21017]: src/device.c:device_profile_connected() returning
response to :1.1473
bluetoothd[21017]: profiles/audio/a2dp.c:setup_unref() 0x7f2acd43e3b0: ref=1
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
state changed: CONFIGURED -> OPEN
bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_CONNECTING
-> SINK_STATE_CONNECTED
bluetoothd[21017]:
profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3
State=TRANSPORT_STATE_REQUESTING Playing=0
bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_resp() START
request succeeded
bluetoothd[21017]: profiles/audio/a2dp.c:start_cfm() Source
0x7f2acd437a00: Start_Cfm
bluetoothd[21017]: /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3: fd(20) ready
bluetoothd[21017]: profiles/audio/transport.c:media_owner_remove()
Owner :1.1198 Request Acquire
bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
TRANSPORT_STATE_REQUESTING -> TRANSPORT_STATE_ACTIVE
bluetoothd[21017]: profiles/audio/a2dp.c:setup_unref() 0x7f2acd43e3b0: ref=0
bluetoothd[21017]: profiles/audio/a2dp.c:setup_free() 0x7f2acd43e3b0
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_unref() 0x7f2acd43ce70: ref=2
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
state changed: OPEN -> STREAMING
bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_CONNECTED ->
SINK_STATE_PLAYING
bluetoothd[21017]:
profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3 State=TRANSPORT_STATE_ACTIVE
Playing=1


bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received SUSPEND_CMD
bluetoothd[21017]: profiles/audio/a2dp.c:suspend_ind() Source
0x7f2acd437a00: Suspend_Ind
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
state changed: STREAMING -> OPEN
bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_PLAYING ->
SINK_STATE_CONNECTED
bluetoothd[21017]:
profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3 State=TRANSPORT_STATE_ACTIVE
Playing=0
bluetoothd[21017]:
profiles/audio/transport.c:media_transport_remove_owner() Transport
/org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3 Owner :1.1198
bluetoothd[21017]: profiles/audio/transport.c:media_owner_free() Owner :1.1198
bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
bluetoothd[21017]: profiles/audio/a2dp.c:a2dp_sep_unlock() SEP
0x7f2acd437a00 unlocked


bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received START_CMD
bluetoothd[21017]: profiles/audio/a2dp.c:start_ind() Source
0x7f2acd437a00: Start_Ind
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_ref() 0x7f2acd43ce70: ref=3
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
state changed: OPEN -> STREAMING
bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_CONNECTED ->
SINK_STATE_PLAYING
bluetoothd[21017]:
profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3 State=TRANSPORT_STATE_IDLE
Playing=1
bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_PENDING
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_unref() 0x7f2acd43ce70: ref=2


bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_resp() SUSPEND
request succeeded
bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
state changed: STREAMING -> OPEN
bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_PLAYING ->
SINK_STATE_CONNECTED
bluetoothd[21017]:
profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3
State=TRANSPORT_STATE_PENDING Playing=0
bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
TRANSPORT_STATE_PENDING -> TRANSPORT_STATE_IDLE
bluetoothd[21017]: profiles/audio/a2dp.c:suspend_cfm() Source
0x7f2acd437a00: Suspend_Cfm
