Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJzW9NCoE7xO=dMJEYkAVKk8QtQaopNkZb2JC51PbL3+-asPUQ@mail.gmail.com>
References: <CAJzW9NCoE7xO=dMJEYkAVKk8QtQaopNkZb2JC51PbL3+-asPUQ@mail.gmail.com>
From: Ben Klopfenstein <benklop@gmail.com>
Date: Thu, 31 Jan 2013 00:24:40 -0700
Message-ID: <CAJzW9NCgm7RLUhCkvqyEv2KtFztvEkD52x8y9+Aoi4qoQeGUtQ@mail.gmail.com>
Subject: Re: Cannot get bluetooth audio (A2DP or SCO) with an LG tone+ HBS-730 headset
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> My suspicion is that this headset, which supports some unusual
> features like the APT-X proprietary codec and multiple simultaneous
> A2DP connections from different devices may be sending some unexpected
> response. I'm not sure where to look next for this. Any suggestions
> what might be going on, or how to troubleshoot this further?

I took my own suggestion and determined how to put bluetoothd in debug
mode. The output is pretty interesting, but I still don't know enough
to really draw any serious conclusions from where it is having issues.
here is that log:

bluetoothd[9664]: plugins/mgmtops.c:mgmt_cod_changed() index 0
bluetoothd[9664]: audio/headset.c:headset_set_state() State changed
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC: HEADSET_STATE_DISCONNECTED
-> HEADSET_STATE_CONNECTING
bluetoothd[9664]: audio/media.c:headset_state_changed()
bluetoothd[9664]: audio/media.c:media_endpoint_async_call() Calling
SetConfiguration: name = :1.55 path = /MediaEndpoint/HFPAG
bluetoothd[9664]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[9664]: plugins/mgmtops.c:mgmt_event() Received 30 bytes
from management socket
bluetoothd[9664]: plugins/mgmtops.c:mgmt_device_connected() hci0
device 00:18:6B:15:AC:DC connected eir_len 11
bluetoothd[9664]: src/adapter.c:adapter_get_device() 00:18:6B:15:AC:DC
bluetoothd[9664]: audio/headset.c:headset_set_channel() Discovered
Handsfree service on channel 3
bluetoothd[9664]: audio/headset.c:rfcomm_connect()
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC: Connecting to
00:18:6B:15:AC:DC channel 3
bluetoothd[9664]: audio/headset.c:headset_connect_cb()
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC: Connected to
00:18:6B:15:AC:DC
bluetoothd[9664]: audio/headset.c:handle_event() Received AT+BRSF=155
bluetoothd[9664]: audio/headset.c:print_hf_features() HFP HF features:
"EC and/or NR function" "Call waiting and 3-way calling" "Voice
recognition activation" "Remote volume control"
bluetoothd[9664]: audio/headset.c:handle_event() Received AT+CIND=?
bluetoothd[9664]: audio/headset.c:handle_event() Received AT+CIND?
bluetoothd[9664]: audio/headset.c:handle_event() Received AT+CMER=3, 0, 0, 1
bluetoothd[9664]: audio/headset.c:event_reporting() Event reporting
(CMER): mode=3, ind=1
bluetoothd[9664]: audio/headset.c:hfp_slc_complete() HFP Service Level
Connection established
bluetoothd[9664]: audio/telephony.c:telephony_device_connected()
telephony-dummy: device 0x7fd3ac51a2d0 connected
bluetoothd[9664]: audio/headset.c:headset_set_state() State changed
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC: HEADSET_STATE_CONNECTING
-> HEADSET_STATE_CONNECTED
bluetoothd[9664]: audio/media.c:headset_state_changed()
bluetoothd[9664]: audio/headset.c:handle_event() Received AT+VGS=12
bluetoothd[9664]: audio/avdtp.c:avdtp_confirm_cb() AVDTP: incoming
connect from 00:18:6B:15:AC:DC
bluetoothd[9664]: audio/sink.c:sink_set_state() State changed
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC: SINK_STATE_DISCONNECTED ->
SINK_STATE_CONNECTING
bluetoothd[9664]: audio/headset.c:handle_event() Received AT+BTRH?
bluetoothd[9664]: audio/avdtp.c:avdtp_connect_cb() AVDTP: connected
signaling channel to 00:18:6B:15:AC:DC
bluetoothd[9664]: audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=895
bluetoothd[9664]: audio/headset.c:handle_event() Received
AT+XAPL=0000-0000-0100,7
bluetoothd[9664]: audio/headset.c:apple_command() Got Apple command:
AT+XAPL=0000-0000-0100,7
bluetoothd[9664]: audio/headset.c:handle_event() Received
AT+IPHONEACCEV=2,1,7,2,0
bluetoothd[9664]: audio/headset.c:apple_command() Got Apple command:
AT+IPHONEACCEV=2,1,7,2,0
bluetoothd[9664]: audio/headset.c:handle_event() Received AT+BIA=0,0,0,1,1,1,0
bluetoothd[9664]: Badly formated or unrecognized command: AT+BIA=0,0,0,1,1,1,0
bluetoothd[9664]: audio/avdtp.c:avdtp_ref() 0x7fd3ac52ad00: ref=2
bluetoothd[9664]: audio/avdtp.c:session_cb()
bluetoothd[9664]: audio/avdtp.c:avdtp_parse_resp() DISCOVER request succeeded
bluetoothd[9664]: audio/avdtp.c:avdtp_discover_resp() seid 5 type 1
media 0 in use 0
bluetoothd[9664]: audio/avdtp.c:avdtp_discover_resp() seid 3 type 1
media 0 in use 0
bluetoothd[9664]: audio/avdtp.c:avdtp_discover_resp() seid 2 type 1
media 0 in use 0
bluetoothd[9664]: audio/avdtp.c:avdtp_discover_resp() seid 1 type 1
media 0 in use 0
bluetoothd[9664]: audio/avdtp.c:session_cb()
bluetoothd[9664]: audio/avdtp.c:avdtp_parse_resp() GET_CAPABILITIES
request succeeded
bluetoothd[9664]: audio/avdtp.c:avdtp_get_capabilities_resp() seid 5
type 1 media 0
bluetoothd[9664]: audio/avdtp.c:session_cb()
bluetoothd[9664]: audio/avdtp.c:avdtp_parse_resp() GET_CAPABILITIES
request succeeded
bluetoothd[9664]: audio/avdtp.c:avdtp_get_capabilities_resp() seid 3
type 1 media 0
bluetoothd[9664]: audio/avdtp.c:session_cb()
bluetoothd[9664]: audio/avdtp.c:avdtp_parse_resp() GET_CAPABILITIES
request succeeded
bluetoothd[9664]: audio/avdtp.c:avdtp_get_capabilities_resp() seid 2
type 1 media 0
bluetoothd[9664]: audio/avdtp.c:session_cb()
bluetoothd[9664]: audio/avdtp.c:avdtp_parse_resp() GET_CAPABILITIES
request succeeded
bluetoothd[9664]: audio/avdtp.c:avdtp_get_capabilities_resp() seid 1
type 1 media 0
bluetoothd[9664]: audio/sink.c:discovery_complete() Discovery complete
bluetoothd[9664]: audio/avdtp.c:avdtp_ref() 0x7fd3ac52ad00: ref=3
bluetoothd[9664]: audio/a2dp.c:setup_ref() 0x7fd3ac529a60: ref=1
bluetoothd[9664]: audio/a2dp.c:a2dp_config() a2dp_config: selected SEP
0x7fd3ac5115a0
bluetoothd[9664]: audio/a2dp.c:setup_ref() 0x7fd3ac529a60: ref=2
bluetoothd[9664]: audio/avdtp.c:avdtp_set_configuration()
0x7fd3ac52ad00: int_seid=1, acp_seid=1
bluetoothd[9664]: audio/a2dp.c:setup_unref() 0x7fd3ac529a60: ref=1
bluetoothd[9664]: audio/avdtp.c:session_cb()
bluetoothd[9664]: audio/avdtp.c:avdtp_parse_resp() SET_CONFIGURATION
request succeeded
bluetoothd[9664]: audio/a2dp.c:setconf_cfm() Source 0x7fd3ac5115a0:
Set_Configuration_Cfm
bluetoothd[9664]: audio/avdtp.c:avdtp_sep_set_state() stream state
changed: IDLE -> CONFIGURED
bluetoothd[9664]: audio/avdtp.c:session_cb()
bluetoothd[9664]: audio/avdtp.c:avdtp_parse_resp() OPEN request succeeded
bluetoothd[9664]: audio/avdtp.c:avdtp_connect_cb() AVDTP: connected
transport channel to 00:18:6B:15:AC:DC
bluetoothd[9664]: audio/avdtp.c:handle_transport_connect() Flushable
packets enabled
bluetoothd[9664]: audio/avdtp.c:handle_transport_connect() sk 27, omtu
895, send buffer size 106496
bluetoothd[9664]: audio/a2dp.c:open_cfm() Source 0x7fd3ac5115a0: Open_Cfm
bluetoothd[9664]: audio/sink.c:stream_setup_complete() Stream
successfully created
bluetoothd[9664]: audio/a2dp.c:setup_unref() 0x7fd3ac529a60: ref=0
bluetoothd[9664]: audio/a2dp.c:setup_free() 0x7fd3ac529a60
bluetoothd[9664]: audio/avdtp.c:avdtp_unref() 0x7fd3ac52ad00: ref=2
bluetoothd[9664]: audio/avdtp.c:avdtp_sep_set_state() stream state
changed: CONFIGURED -> OPEN
bluetoothd[9664]: audio/sink.c:sink_set_state() State changed
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC: SINK_STATE_CONNECTING ->
SINK_STATE_CONNECTED
bluetoothd[9664]: audio/unix.c:server_cb() Accepted new client
connection on unix socket (fd=30)
bluetoothd[9664]: audio/transport.c:media_transport_acquire()
Transport /org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC/fd0: read lock
acquired
bluetoothd[9664]: audio/transport.c:media_transport_acquire()
Transport /org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC/fd0: write lock
acquired
bluetoothd[9664]: audio/transport.c:media_owner_create() Owner
created: sender=:1.55 accesstype=rw
bluetoothd[9664]: audio/headset.c:headset_set_state() State changed
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[9664]: audio/media.c:headset_state_changed()
bluetoothd[9664]: audio/transport.c:media_request_create() Request
created: method=Acquire id=1
bluetoothd[9664]: audio/transport.c:media_owner_add() Owner :1.55
Request Acquire
bluetoothd[9664]: audio/transport.c:media_transport_add() Transport
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC/fd0 Owner :1.55
bluetoothd[9664]: Operation not supported (95)
bluetoothd[9664]: audio/transport.c:media_transport_remove() Transport
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC/fd0 Owner :1.55
bluetoothd[9664]: audio/transport.c:media_transport_release()
Transport /org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC/fd0: read lock
released
bluetoothd[9664]: audio/transport.c:media_transport_release()
Transport /org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC/fd0: write lock
released
bluetoothd[9664]: audio/transport.c:media_request_reply() Request
Acquire Reply Input/output error
bluetoothd[9664]: audio/transport.c:media_owner_free() Owner :1.55
bluetoothd[9664]: audio/transport.c:media_owner_remove() Owner :1.55
Request Acquire
bluetoothd[9664]: audio/headset.c:headset_set_state() State changed
/org/bluez/9664/hci0/dev_00_18_6B_15_AC_DC:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[9664]: audio/media.c:headset_state_changed()
bluetoothd[9664]: audio/unix.c:client_cb() Unix client disconnected (fd=30)
bluetoothd[9664]: audio/unix.c:client_free() client_free(0x7fd3ac529a60)
bluetoothd[9664]: audio/avctp.c:avctp_confirm_cb() AVCTP: incoming
connect from 00:18:6B:15:AC:DC
bluetoothd[9664]: audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[9664]: audio/avctp.c:avctp_connect_cb() AVCTP: connected to
00:18:6B:15:AC:DC
bluetoothd[9664]: audio/avctp.c:init_uinput() AVRCP: uinput
initialized for 00:18:6B:15:AC:DC
bluetoothd[9664]: audio/avctp.c:avctp_set_state() AVCTP Connected
bluetoothd[9664]: audio/avctp.c:session_cb() Got 14 bytes of data for
AVCTP session 0x7fd3ac52b320
bluetoothd[9664]: audio/avctp.c:session_cb() AVCTP transaction 1,
packet type 0, C/R 0, IPID 0, PID 0x110E
bluetoothd[9664]: audio/avctp.c:session_cb() AV/C command 0x1,
subunit_type 0x09, subunit_id 0x0, opcode 0x00, 8 operands
bluetoothd[9664]: audio/avctp.c:session_cb() handler not found for 0x00
bluetoothd[9664]: audio/avrcp.c:avrcp_handle_vendor_reject() rejecting
AVRCP PDU 0x10, company 0x001958 len 0x0100
bluetoothd[9664]: audio/avctp.c:session_cb() Got 18 bytes of data for
AVCTP session 0x7fd3ac52b320
bluetoothd[9664]: audio/avctp.c:session_cb() AVCTP transaction 2,
packet type 0, C/R 0, IPID 0, PID 0x110E
bluetoothd[9664]: audio/avctp.c:session_cb() AV/C command 0x3,
subunit_type 0x09, subunit_id 0x0, opcode 0x00, 12 operands
bluetoothd[9664]: audio/avctp.c:session_cb() handler not found for 0x00
bluetoothd[9664]: audio/avrcp.c:avrcp_handle_vendor_reject() rejecting
AVRCP PDU 0x31, company 0x001958 len 0x0100

Thanks!

Ben
