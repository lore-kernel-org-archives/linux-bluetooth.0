Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 21 Jul 2007 17:52:21 -0500
From: Todd Troxell <xtat@rapidpacket.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070721225221.GA2092@rapidpacket.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Subject: [Bluez-devel] a2dpd: stream_client_send_pointer_resp:
	(errno=32:Broken pipe)Error while sending data
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm connecting latest CVS a2dpd to an Alpine KCA100BT.  It connects ok, pin
exchange ok, but when it starts to stream, I get:

A2DPD[16:37:05.324]: pollfd_cb_avrcpfd: socket 13: Connection from
31:98:D1:55:0C:00, mtu=610 accepted at index 0
A2DPD[16:37:06.288]: stream_client_send_pointer_resp: (errno=32:Broken
pipe)Error while sending data^M
A2DPD[16:37:06.288]: disconnect_client:

Full debug log is attached.  Let me know if you'd like any further data.

Thanks,
-- 
Todd Troxell
http://rapidpacket.com/~xtat

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alpine-kca100bt-a2dp.log"

A2DPD[16:36:52.780]: init_ipc: Selected IPC: unix, addr=127.0.0.1, bcst=127.0.0.255, port=21453
A2DPD[16:36:52.780]: make_daemon_process: a2dpd [Jul 17 2007 23:50:20] starting ...
A2DPD[16:36:52.780]: main: (errno=13:Permission denied)a2dpd addr=00:0C:55:D1:98:31 timer=0 us [Jul 17 2007 23:50:22]
A2DPD[16:36:52.780]: a2dpd_signal_init: Getting on DBUS
A2DPD[16:36:52.784]: a2dpd_signal_init: Installing watch
A2DPD[16:36:52.784]: add_dbus_watch: Added watch 0 0x80b4930 disabled
A2DPD[16:36:52.784]: add_dbus_watch: Added watch 1 0x80b4958 enabled
A2DPD[16:36:52.784]: a2dpd_signal_init: Registering object path: /com/access/a2dpd
A2DPD[16:36:52.784]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[16:36:52.785]: a2dpd_signal_init: OK
A2DPD[16:36:52.785]: a2dpd_signal_init: OK
A2DPD[16:36:52.785]: a2dpd_register_sdp: Start
A2DPD[16:36:52.785]: add_avrtg: 
A2DPD[16:36:52.787]: add_a2source: 
A2DPD[16:36:52.787]: a2dpd_register_sdp: OK
A2DPD[16:36:52.787]: main_loop: 
A2DPD[16:36:52.787]: make_server_socket: 
A2DPD[16:36:52.787]: a2dpd_signal_state: Started 00:0C:55:D1:98:31
A2DPD[16:36:52.787]: bta2dpdevicenew: 
A2DPD[16:36:52.787]: a2dpd_signal_address_changed: 00:0C:55:D1:98:31
A2DPD[16:36:52.787]: a2dpd_signal_set_socket: Signal socket set to 7
A2DPD[16:36:52.789]: a2dpd_signal_state: Disconnected 
A2DPD[16:36:52.789]: a2dp_alloc: 
A2DPD[16:36:52.789]: a2dp_alloc: (a2dp = 0x80b8280)
A2DPD[16:36:52.789]: a2dp_new: 00:0C:55:D1:98:31, 44100
A2DPD[16:36:52.789]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[16:36:52.789]: alsa_new: 
A2DPD[16:36:52.789]: alsa_new: device=plughw:0,0, framerate=44100
A2DPD[16:36:52.789]: alsa_new: State ALSA_STATE_DISCONNECTED
A2DPD[16:36:52.789]: alsa_new: returning 0x80ba418
A2DPD[16:36:52.789]: sco_new: 
A2DPD[16:36:52.789]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[16:36:52.789]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[16:36:52.789]: main_loop: Bluetooth Device Settings [44100 hz, 2 channels, 16 bits]
A2DPD[16:36:52.791]: avrcp_new: Listening for AVRCP on socket 9
A2DPD[16:36:52.791]: avrcp_new: 0x80ba558
A2DPD[16:36:58.900]: a2dp_reset_encoding_buffer: 
A2DPD[16:36:58.900]: pollfd_cb_sockfd: Client 10 got index 0
A2DPD[16:36:58.907]: stream_client_state_streamingsetup: PLAYBACK thread client_index=0, socket=10, id=0 started (44100 Hz, 2 channels, 16 bits, ring 65536, threshold 65536)
A2DPD[16:36:59.031]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[16:36:59.031]: a2dp_state_machine: Role is INITIATOR
A2DPD[16:36:59.031]: a2dp_state_machine: (errno=115:Operation now in progress)SDP connection on socket 11
A2DPD[16:36:59.031]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[16:36:59.031]: a2dpd_signal_state: Connecting 00:0C:55:D1:98:31
A2DPD[16:37:02.728]: a2dp_state_machine: SDP connection terminated
A2DPD[16:37:02.784]: get_avdtp_psm: Parsing results
A2DPD[16:37:02.784]: get_avdtp_psm: Record
A2DPD[16:37:02.784]: get_avdtp_psm: Service Search OK
A2DPD[16:37:02.819]: get_avdtp_psm: Checking non spec audio
A2DPD[16:37:02.819]: a2dp_state_machine: Found psm 25
A2DPD[16:37:02.819]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[16:37:02.819]: a2dp_state_machine: Socket is 11
A2DPD[16:37:02.819]: a2dp_state_machine: (errno=115:Operation now in progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[16:37:03.140]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[16:37:03.144]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[16:37:03.144]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[16:37:03.288]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[16:37:03.288]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[16:37:03.288]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[16:37:03.288]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[16:37:03.288]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[16:37:03.380]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[16:37:03.380]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[16:37:03.380]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[16:37:03.380]: a2dp_state_machine: cap_type=7, length=6
A2DPD[16:37:03.380]: a2dp_state_machine: media_type=0, codec=0
A2DPD[16:37:03.380]: a2dp_state_machine: A2DPD  Prefered bitpool 32
A2DPD[16:37:03.380]: a2dp_state_machine: Device Prefered bitpool 2 -> 60
A2DPD[16:37:03.380]: a2dp_state_machine: A2DPD  Selected bitpool 32
A2DPD[16:37:03.380]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[16:37:03.380]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[16:37:03.556]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[16:37:03.556]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[16:37:03.556]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[16:37:03.556]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[16:37:03.704]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[16:37:03.704]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[16:37:03.704]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[16:37:03.704]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[16:37:03.708]: a2dp_state_machine: Socket is 12
A2DPD[16:37:03.708]: a2dp_state_machine: (errno=115:Operation now in progress)State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[16:37:04.012]: a2dp_state_machine: Stream connected
A2DPD[16:37:04.012]: get_socket_omtu: Socket 12 imtu=672, omtu=895, flush_to=65535
A2DPD[16:37:04.012]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[16:37:04.012]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[16:37:04.012]: a2dpd_signal_state: Connected 00:0C:55:D1:98:31
A2DPD[16:37:04.013]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[16:37:04.248]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[16:37:04.248]: a2dp_state_machine: AVDTP_START success
A2DPD[16:37:04.248]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[16:37:04.248]: a2dp_transfer_raw: Samples starting
A2DPD[16:37:05.324]: get_socket_omtu: Socket 9 imtu=672, omtu=0, flush_to=65535
A2DPD[16:37:05.324]: pollfd_cb_avrcpfd: socket 13: Connection from 31:98:D1:55:0C:00, mtu=610 accepted at index 0
A2DPD[16:37:06.288]: stream_client_send_pointer_resp: (errno=32:Broken pipe)Error while sending data
A2DPD[16:37:06.288]: disconnect_client: 

[ctrl-c]

A2DPD[16:37:09.150]: sigint_handler: handling SIGINT
A2DPD[16:37:09.150]: main_loop: (errno=4:Interrupted system call)Poll ERROR
A2DPD[16:37:09.150]: a2dpd_signal_state: Ended 
A2DPD[16:37:09.150]: alsa_destroy: 
A2DPD[16:37:09.150]: alsa_state_disconnect: State ALSA_STATE_DISCONNECTED
A2DPD[16:37:09.150]: alsa_destroy: OK
A2DPD[16:37:09.150]: a2dp_destroy: a2dp = 0xbff37ba8
A2DPD[16:37:09.151]: a2dp_free: Disconnecting
A2DPD[16:37:09.151]: a2dp_disconnect: 
A2DPD[16:37:09.151]: a2dp_stream_stop: Closing stream socket 12
A2DPD[16:37:09.151]: a2dp_stream_stop: Closed
A2DPD[16:37:09.151]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[16:37:09.151]: a2dp_disconnect: Closing ctl socket 11
A2DPD[16:37:09.151]: a2dp_disconnect: Closed
A2DPD[16:37:09.151]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[16:37:09.151]: a2dp_free: Freeing sbc
A2DPD[16:37:09.151]: a2dp_free: (a2dp = 0x80b8280)
A2DPD[16:37:09.151]: a2dp_free: OK
A2DPD[16:37:09.151]: sco_destroy: sco = 0xbff37bac
A2DPD[16:37:09.151]: sco_free: Disconnecting
A2DPD[16:37:09.151]: sco_free: (sco = 0x80ba528)
A2DPD[16:37:09.151]: avrcp_destroy: Closing socket 13
A2DPD[16:37:09.151]: avrcp_destroy: 0x80ba558
A2DPD[16:37:09.151]: a2dpd_signal_set_socket: Signal socket set to -1
A2DPD[16:37:09.151]: a2dpd_unregister_sdp: Start
A2DPD[16:37:09.152]: a2dpd_unregister_sdp: OK
A2DPD[16:37:09.152]: a2dpd_signal_kill: OK
A2DPD[16:37:09.152]: main: Terminated succesfully

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--gBBFr7Ir9EOA20Yy--
