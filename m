Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Query on AVRCP PTS testing
Date: Wed, 10 Jun 2015 14:52:10 +0530
Message-id: <041c01d0a35e$eedcb780$cc962680$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

We have done some implementation for AVRCP 1.6 feature GetTotalNUmItems, for
which we are setting up complete testing setup for AVRCP.

As CT side, on linux box,
1. bluetoothd up and running 
2. Registered endpoint with test/simple-endpoint 
3. Running bluetoothctl with agent registered as default agent 
4. bluetooth player is also running and waiting for list of available player

On TG side, PTS test suite, triggered below related test cases, 
TC_CT_MCN_NP_BV_10_C 
or TC_CT_MCN_CB_BV_12_C 

We got the AVDTP channels connected, AVCTP connected, and PTS is waiting for
command set browsed player to select the player  

on CT side, bluez, before calling set_browsed player, bluetoothd exits
abnormally. I could not find it why is it so. 
captured bluetoothd logs;

bluetoothd[29843]: src/adapter.c:connected_callback() hci0 device
00:1B:DC:07:33:50 connected eir_len 25
bluetoothd[29843]: profiles/audio/a2dp.c:confirm_cb() AVDTP: incoming
connect from 00:1B:DC:07:33:50
bluetoothd[29843]: profiles/audio/source.c:source_set_state() State changed
/org/bluez/hci0/dev_00_1B_DC_07_33_50: SOURCE_STATE_DISCONNECTED ->
SOURCE_STATE_CONNECTING
bluetoothd[29843]: profiles/audio/sink.c:sink_set_state() State changed
/org/bluez/hci0/dev_00_1B_DC_07_33_50: SINK_STATE_DISCONNECTED ->
SINK_STATE_CONNECTING
bluetoothd[29843]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP:
connected signaling channel to 00:1B:DC:07:33:50
bluetoothd[29843]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672,
omtu=672
bluetoothd[29843]: profiles/audio/avctp.c:avctp_confirm_cb() AVCTP: incoming
connect from 00:1B:DC:07:33:50
bluetoothd[29843]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[29843]: profiles/audio/avctp.c:avctp_connect_cb() AVCTP:
connected to 00:1B:DC:07:33:50
bluetoothd[29843]: profiles/audio/avctp.c:init_uinput() AVRCP: uinput
initialized for 00:1B:DC:07:33:50
bluetoothd[29843]: profiles/audio/avrcp.c:controller_init() 0x84dd10 version
0x0104
bluetoothd[29843]: profiles/audio/player.c:media_player_controller_create()
/org/bluez/hci0/dev_00_1B_DC_07_33_50/player0
bluetoothd[29843]: profiles/audio/avrcp.c:target_init() 0x837fe0 version
0x0000
bluetoothd[29843]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connected
bluetoothd[29843]: profiles/audio/avctp.c:avctp_set_state() AVCTP Browsing
Connecting
bluetoothd[29843]: profiles/audio/avctp.c:avctp_connect_browsing_cb() AVCTP
Browsing: connected to 00:1B:DC:07:33:50
bluetoothd[29843]: profiles/audio/avctp.c:avctp_set_state() AVCTP Browsing
Connected
bluetoothd[29843]: profiles/audio/player.c:media_player_controller_create()
/org/bluez/hci0/dev_00_1B_DC_07_33_50/player1
bluetoothd[29843]: profiles/audio/player.c:media_player_set_type() Audio,
Video
bluetoothd[29843]: profiles/audio/player.c:media_player_set_subtype() Audio
Book
bluetoothd[29843]: profiles/audio/player.c:media_player_set_status() stopped
bluetoothd[29843]: profiles/audio/player.c:media_player_set_browsable() true
bluetoothd[29843]: profiles/audio/player.c:media_folder_create_item()
/Filesystem type folder uid 0
bluetoothd[29843]: profiles/audio/player.c:media_folder_create_item()
/org/bluez/hci0/dev_00_1B_DC_07_33_50/player1/Filesystem
bluetoothd[29843]: profiles/audio/player.c:media_folder_create_item()
/NowPlaying type folder uid 0
bluetoothd[29843]: profiles/audio/player.c:media_folder_create_item()
/org/bluez/hci0/dev_00_1B_DC_07_33_50/player1/NowPlaying
bluetoothd[29843]: profiles/audio/player.c:media_player_set_playlist()
/NowPlaying
bluetoothd[29843]: profiles/audio/player.c:media_player_set_name() Browsed
Player
bluetoothd[29843]: profiles/audio/player.c:media_player_destroy()
/org/bluez/hci0/dev_00_1B_DC_07_33_50/player0
bharat.panda@bharat-ubuntu:~/bluez_avrcp/bluez$

PTS log,

                - MTC: SDP Service record was successfully registered.
                - A2DP SRC SDP Service record successfully registered
                - A2DP SRCsuccessfully registered
                - MTC: IUT successfully responded to AVDTP CONNECT.
                - MTC: IUT successfully accepted AVCTP channel connection.
                - IUT disconnected AVDTP SIGNALING channel.
                - User canceled the current operation MMI.
                - AVCTP: Exiting AVCTP1 PTC
                - AVDTP: Exiting AVDTP1 PTC
                - CM_PTC_EXIT
                - MMI CM_EXIT
                - MTC: Test case ended
                -Final Verdict: INCONC
                
Any clue on this? Is there anything we missed in AVRCP setup?

Thanks
Best Regards
Bharat

