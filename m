Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46320AC6.9080200@jlab.org>
Date: Fri, 27 Apr 2007 10:37:58 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <463151D2.1040805@jlab.org> <4631762B.9060704@xmission.com>
	<CE5216C10C83944D9FD37B65CD33F3970CF4CD@mplex01.mpl.access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF4CD@mplex01.mpl.access-company.com>
Subject: Re: [Bluez-devel] RE :  Plugz, a2dpd, and a2dpd2 strangeness
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

carlin1 ~ # a2dpd -g
A2DPD[10:29:49.541]: init_ipc: Selected IPC: unix, addr=127.0.0.1, 
bcst=127.0.0.255, port=21453
A2DPD[10:29:49.541]: make_daemon_process: a2dpd [Apr 26 2007 17:07:32] 
starting ...
A2DPD[10:29:49.541]: main: (errno=9:Bad file descriptor)a2dpd 
addr=00:0D:E8:01:BB:A3 timer=999 us [Apr 26 2007 17:07:37]
A2DPD[10:29:49.541]: a2dpd_signal_init: Getting on DBUS
A2DPD[10:29:49.542]: a2dpd_signal_init: Installing watch
A2DPD[10:29:49.542]: add_dbus_watch: Added watch 0 0x809b8b8 disabled
A2DPD[10:29:49.542]: add_dbus_watch: Added watch 1 0x809b8e0 enabled
A2DPD[10:29:49.542]: a2dpd_signal_init: Registering object path: 
/com/access/a2dpd
A2DPD[10:29:49.542]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[10:29:49.542]: a2dpd_signal_init: OK
A2DPD[10:29:49.542]: a2dpd_signal_init: OK
A2DPD[10:29:49.542]: a2dpd_register_sdp: OK
A2DPD[10:29:49.542]: add_avrtg:
A2DPD[10:29:49.542]: add_a2source:
A2DPD[10:29:49.542]: main_loop:
A2DPD[10:29:49.542]: make_server_socket:
A2DPD[10:29:49.542]: bta2dpdevicenew:
A2DPD[10:29:49.542]: a2dpd_signal_address_changed: 00:0D:E8:01:BB:A3
A2DPD[10:29:49.543]: a2dpd_signal_set_socket: Signal socket set to 7
A2DPD[10:29:49.543]: a2dpd_signal_state: Disconnected
A2DPD[10:29:49.543]: a2dp_alloc:
A2DPD[10:29:49.543]: a2dp_alloc: (a2dp = 0x80a9290)
A2DPD[10:29:49.543]: a2dp_new: 00:0D:E8:01:BB:A3, 32000
A2DPD[10:29:49.543]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[10:29:49.543]: alsa_new:
A2DPD[10:29:49.543]: alsa_new: device=plughw:0,0, framerate=32000
A2DPD[10:29:49.543]: alsa_new: State ALSA_STATE_DISCONNECTED
A2DPD[10:29:49.543]: alsa_new: returning 0x80ab418
A2DPD[10:29:49.543]: sco_new:
A2DPD[10:29:49.543]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[10:29:49.543]: sco_state_disconnect: Filtering state : already 
disconnected
A2DPD[10:29:49.543]: main_loop: Bluetooth Device Settings [32000 hz, 2 
channels, 16 bits]
A2DPD[10:29:49.544]: avrcp_new: Listening for AVRCP on socket 9
A2DPD[10:29:49.544]: avrcp_new: 0x80ab528

***hit play***

A2DPD[10:29:53.502]: pollfd_cb_sockfd: Client 10 got index 0
A2DPD[10:29:53.502]: stream_client_state_streamingsetup: PLAYBACK thread 
client_index=0, socket=10, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[10:29:53.503]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[10:29:53.503]: a2dp_state_machine: Role is INITIATOR
A2DPD[10:29:53.503]: a2dp_state_machine: (errno=115:Operation now in 
progress)SDP connection on socket 11
A2DPD[10:29:53.503]: a2dp_state_machine: State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[10:29:53.503]: a2dpd_signal_state: Connecting 00:0D:E8:01:BB:A3
A2DPD[10:29:56.722]: a2dp_state_machine: SDP connection terminated
A2DPD[10:29:56.744]: get_avdtp_psm: Parsing results
A2DPD[10:29:56.744]: get_avdtp_psm: Record
A2DPD[10:29:56.744]: get_avdtp_psm: Service Search OK
A2DPD[10:29:56.761]: get_avdtp_psm: Checking non spec audio
A2DPD[10:29:56.761]: a2dp_state_machine: Found psm 25
A2DPD[10:29:56.761]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[10:29:56.761]: a2dp_state_machine: Socket is 11
A2DPD[10:29:56.761]: a2dp_state_machine: (errno=115:Operation now in 
progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[10:29:56.784]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[10:29:56.785]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[10:29:56.786]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[10:29:56.800]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[10:29:56.800]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[10:29:56.800]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[10:29:56.801]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[10:29:56.801]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[10:29:56.812]: get_socket_omtu: Socket 9 imtu=672, omtu=0, 
flush_to=65535
A2DPD[10:29:56.812]: pollfd_cb_avrcpfd: socket 12: Connection from 
A3:BB:01:E8:0D:00, mtu=610 accepted at index 0
A2DPD[10:29:56.814]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[10:29:56.814]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success 
for seid 1
A2DPD[10:29:56.814]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[10:29:56.814]: a2dp_state_machine: cap_type=7, length=6
A2DPD[10:29:56.814]: a2dp_state_machine: media_type=0, codec=0
A2DPD[10:29:56.814]: a2dp_state_machine: A2DPD  Prefered bitpool 32
A2DPD[10:29:56.814]: a2dp_state_machine: Device Prefered bitpool 2 -> 250
A2DPD[10:29:56.814]: a2dp_state_machine: A2DPD  Selected bitpool 32
A2DPD[10:29:56.814]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[10:29:56.815]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[10:29:56.834]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[10:29:56.834]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[10:29:56.834]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[10:29:56.835]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[10:29:56.851]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[10:29:56.851]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[10:29:56.851]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[10:29:56.852]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_CONNECTING
A2DPD[10:29:56.853]: a2dp_state_machine: Socket is 13
A2DPD[10:29:56.853]: a2dp_state_machine: (errno=115:Operation now in 
progress)State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[10:29:56.884]: a2dp_state_machine: Stream connected
A2DPD[10:29:56.884]: get_socket_omtu: Socket 13 imtu=672, omtu=678, 
flush_to=65535
A2DPD[10:29:56.884]: a2dp_state_machine: State 
AVDTP_STATE_OPEN_START_STREAMING
A2DPD[10:29:56.885]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[10:29:56.885]: a2dpd_signal_state: Connected 00:0D:E8:01:BB:A3
A2DPD[10:29:56.886]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[10:29:56.900]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[10:29:56.900]: a2dp_state_machine: AVDTP_START success
A2DPD[10:29:56.900]: a2dp_state_machine: State AVDTP_STATE_STREAMING

***ogg123 says it's playing; no sound except for occasional chirps; no 
new messages from a2dpd***

***hit stop***


A2DPD[10:30:22.184]: pollfd_cb_clients: Client 0: Error detected (err=0, 
toc=0, err=0, hup=1)

> What headset/adapter is it? Did you start hcidump before a2dpd?

Headset is Creative CB2530. I've had identical results from four 
different adapters including both Broadcom and CSR chipsets, currently 
using a DLink DBT-120.

Started hcidump before.

~Chris

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
