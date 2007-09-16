Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: =?UTF-8?Q?konrad003?= <konrad003@tlen.pl>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Message-ID: <41f42627.4a25d8c3.46ed7733.d4785@o2.pl>
Date: Sun, 16 Sep 2007 20:34:27 +0200
Subject: [Bluez-devel] =?utf-8?q?Problem_with_A2DP_=26_HHB-750?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi. I've got Siemens HHB-750 bluetooth headphones and Dell Latitude X1 laptop with dell BT card:
Bus 002 Device 003: ID 413c:8103 Dell Computer Corp. Wireless 350 Bluetooth

Pairing is ok, connecting too, but it still skips (like buffering?). It depends on 'sbcbitpool' in config. For example for sbcbitpool=4 it skips every ~9 seconds. For sbcbitpool=32 it's about 300-500ms :(
I'm using Feodra 7 with kernel 2.6.22 (2.6.22.1-41.fc7).

There is a dump from a2dpd:
A2DPD[20:25:13.291]: init_ipc: Selected IPC: unix, addr=127.0.0.1, bcst=127.0.0.255, port=21453
A2DPD[20:25:13.300]: main: a2dpd [Aug 26 2007 22:40:04] starting ...
A2DPD[20:25:13.300]: main: (errno=13:Permission denied)a2dpd addr=00:08:C6:66:3C:9C timer=0 us [Aug 26 2007 22:40:04]
A2DPD[20:25:13.300]: a2dpd_signal_init: Getting on DBUS
A2DPD[20:25:13.304]: a2dpd_signal_init: Installing watch
A2DPD[20:25:13.315]: add_dbus_watch: Added watch 0 0x9312838 disabled
A2DPD[20:25:13.315]: add_dbus_watch: Added watch 1 0x9312860 enabled
A2DPD[20:25:13.315]: a2dpd_signal_init: Registering object path: /com/access/a2dpd
A2DPD[20:25:13.315]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[20:25:13.318]: a2dpd_signal_init: OK
A2DPD[20:25:13.318]: a2dpd_signal_init: OK
A2DPD[20:25:13.318]: a2dpd_register_sdp: Start
A2DPD[20:25:13.319]: add_avrtg: 
A2DPD[20:25:13.319]: add_a2source: 
A2DPD[20:25:13.322]: a2dpd_register_sdp: OK
A2DPD[20:25:13.322]: main_loop: 
A2DPD[20:25:13.322]: make_server_socket: 
A2DPD[20:25:13.322]: a2dp_make_listen_socket: (errno=13:Permission denied)Cannot bind socket 8 for psm 25
A2DPD[20:25:13.322]: main_loop: *** Cannot get AVDTP socket, incoming AVDTP connections are impossible ***
A2DPD[20:25:13.322]: a2dpd_signal_state: Started 00:08:C6:66:3C:9C
A2DPD[20:25:13.324]: bta2dpdevicenew: 
A2DPD[20:25:13.324]: a2dpd_signal_address_changed: 00:08:C6:66:3C:9C
A2DPD[20:25:13.324]: a2dpd_signal_set_socket: Signal socket set to 8
A2DPD[20:25:13.329]: a2dpd_signal_state: Disconnected 
A2DPD[20:25:13.329]: a2dp_alloc: 
A2DPD[20:25:13.329]: a2dp_alloc: (a2dp = 0x93161c0)
A2DPD[20:25:13.329]: a2dp_new: 00:08:C6:66:3C:9C, 44100
A2DPD[20:25:13.329]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[20:25:13.332]: alsa_new: 
A2DPD[20:25:13.332]: alsa_new: device=plughw:0,0, framerate=44100
A2DPD[20:25:13.332]: alsa_new: State ALSA_STATE_DISCONNECTED
A2DPD[20:25:13.332]: alsa_new: returning 0x9318358
A2DPD[20:25:13.332]: sco_new: 
A2DPD[20:25:13.332]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[20:25:13.332]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[20:25:13.332]: main_loop: Bluetooth Device Settings [44100 hz, 2 channels, 16 bits]
A2DPD[20:25:13.336]: a2dp_make_listen_socket: (errno=13:Permission denied)Cannot bind socket 10 for psm 23
A2DPD[20:25:13.336]: avrcp_new: Listening for AVRCP on socket -1
A2DPD[20:25:13.336]: avrcp_new: 0x9318468
A2DPD[20:25:17.132]: a2dp_reset_encoding_buffer: 
A2DPD[20:25:17.132]: pollfd_cb_sockfd: Client 10 got index 0
A2DPD[20:25:17.153]: stream_client_state_streamingsetup: PLAYBACK thread client_index=0, socket=10, id=0 started (44100 Hz, 2 channels, 16 bits, ring 65536, threshold 65536)
A2DPD[20:25:17.165]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[20:25:17.165]: a2dp_state_machine: Role is INITIATOR
A2DPD[20:25:17.174]: a2dp_state_machine: (errno=115:Operation now in progress)SDP connection on socket 11
A2DPD[20:25:17.174]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[20:25:17.174]: a2dpd_signal_state: Connecting 00:08:C6:66:3C:9C
A2DPD[20:25:18.135]: display_daemon_state: [16,16|16,16] playing disconnected clients=1 freq=358 cnt=343 (344/15) poll=469 latency=1189967118 sec.
A2DPD[20:25:18.159]: a2dp_state_machine: SDP connection terminated
A2DPD[20:25:18.243]: get_avdtp_psm: Parsing results
A2DPD[20:25:18.243]: get_avdtp_psm: Record
A2DPD[20:25:18.243]: get_avdtp_psm: Service Search OK
A2DPD[20:25:18.344]: get_avdtp_psm: Checking non spec audio
A2DPD[20:25:18.344]: a2dp_state_machine: Found psm 25
A2DPD[20:25:18.344]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[20:25:18.345]: a2dp_state_machine: Socket is 11
A2DPD[20:25:18.345]: a2dp_state_machine: (errno=115:Operation now in progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[20:25:18.915]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[20:25:18.916]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[20:25:18.916]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[20:25:19.106]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[20:25:19.106]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[20:25:19.106]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[20:25:19.106]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[20:25:19.106]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[20:25:19.136]: display_daemon_state: [16,16|16,16] playing disconnected clients=1 freq=761 cnt=1104 (761/0) poll=930 latency=1189967119 sec.
A2DPD[20:25:19.241]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[20:25:19.241]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[20:25:19.242]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[20:25:19.242]: a2dp_state_machine: cap_type=7, length=6
A2DPD[20:25:19.242]: a2dp_state_machine: media_type=0, codec=0
A2DPD[20:25:19.242]: a2dp_state_machine: A2DPD  Prefered bitpool 32
A2DPD[20:25:19.242]: a2dp_state_machine: Device Prefered bitpool 2 -> 48
A2DPD[20:25:19.242]: a2dp_state_machine: A2DPD  Selected bitpool 32
A2DPD[20:25:19.242]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[20:25:19.245]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[20:25:19.467]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[20:25:19.467]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[20:25:19.467]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[20:25:19.467]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[20:25:19.599]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[20:25:19.599]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[20:25:19.599]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[20:25:19.599]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[20:25:19.600]: a2dp_state_machine: Socket is 12
A2DPD[20:25:19.600]: a2dp_state_machine: (errno=115:Operation now in progress)State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[20:25:20.307]: a2dp_state_machine: Stream connected
[...]

Thanks in advance,
x202

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
