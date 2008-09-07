Return-Path: <cyrus@holtmann.org>
Message-ID: <48C43D87.2040705@stephan.co.uk>
Date: Sun, 07 Sep 2008 21:45:59 +0100
From: Stephan de Georgio <sd@stephan.co.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Motorola DC800
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

Hi,

I recently purchased a Motorola HT820 headset and DC800 audio gateway 
which acts as a a2dp audio source to the headphones or sink music from a 
mobile phone/computer to your hifi.
I can make the computer stream music to the HT820 headset without 
problems, but I can't seem to stream any music to my hifi from the 
computer via the DC800.  When playing music to the DC800 the unit pairs 
with the computer and the LED on the front of the unit flashes as though 
the computer is connected to it, but no audio is heard from the speakers.

Below is the debug output from a2dpd.  Is there any other information 
which may help solve the problem that I can provide?

a2dpd -g -f /etc/bluetooth/a2dp.conf
A2DPD[21:29:11.491]: main: Config file /etc/bluetooth/a2dp.conf
A2DPD[21:29:11.492]: init_ipc: Selected IPC: unix, addr=127.0.0.1, 
bcst=127.0.0.255, port=21453
A2DPD[21:29:11.492]: main: a2dpd [Sep  3 2008 17:46:56] starting ...
A2DPD[21:29:11.492]: main: (errno=9:Bad file descriptor)a2dpd 
addr=00:07:A4:D5:49:6F timer=0 us [Sep  3 2008 17:46:56]
A2DPD[21:29:11.493]: a2dpd_signal_init: Getting on DBUS
A2DPD[21:29:11.496]: a2dpd_signal_init: Installing watch
A2DPD[21:29:11.497]: add_dbus_watch: Added watch 0 0xa007350 disabled
A2DPD[21:29:11.497]: add_dbus_watch: Added watch 1 0xa007ef8 enabled
A2DPD[21:29:11.497]: a2dpd_signal_init: Registering object path: 
/com/access/a2dpd
A2DPD[21:29:11.497]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[21:29:11.499]: a2dpd_signal_init: OK
A2DPD[21:29:11.499]: a2dpd_signal_init: OK
A2DPD[21:29:11.499]: a2dpd_register_sdp: Start
A2DPD[21:29:11.500]: add_avrtg:
A2DPD[21:29:11.501]: add_a2source:
A2DPD[21:29:11.505]: a2dpd_register_sdp: OK
A2DPD[21:29:11.505]: main_loop:
A2DPD[21:29:11.505]: make_server_socket:
A2DPD[21:29:11.505]: a2dpd_signal_state: Started 00:07:A4:D5:49:6F
A2DPD[21:29:11.505]: bta2dpdevicenew:
A2DPD[21:29:11.505]: a2dpd_signal_address_changed: 00:07:A4:D5:49:6F
A2DPD[21:29:11.505]: a2dpd_signal_set_socket: Signal socket set to 7
A2DPD[21:29:11.506]: a2dpd_signal_state: Disconnected
A2DPD[21:29:11.506]: a2dp_alloc:
A2DPD[21:29:11.506]: a2dp_alloc: (a2dp = 0xa00b898)
A2DPD[21:29:11.506]: a2dp_new: 00:07:A4:D5:49:6F, 44100
A2DPD[21:29:11.506]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[21:29:11.506]: alsa_new:
A2DPD[21:29:11.506]: alsa_new: device=plughw:0,0, framerate=44100
A2DPD[21:29:11.506]: alsa_new: State ALSA_STATE_DISCONNECTED
A2DPD[21:29:11.506]: alsa_new: returning 0xa00da30
A2DPD[21:29:11.506]: sco_new:
A2DPD[21:29:11.506]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[21:29:11.506]: sco_state_disconnect: Filtering state : already 
disconnected
A2DPD[21:29:11.506]: main_loop: Bluetooth Device Settings [44100 hz, 2 
channels, 16 bits]
A2DPD[21:29:11.507]: avrcp_new: Listening for AVRCP on socket 9
A2DPD[21:29:11.507]: avrcp_new: 0xa00db40
A2DPD[21:29:28.279]: a2dp_reset_encoding_buffer:
A2DPD[21:29:28.279]: pollfd_cb_sockfd: Client 10 got index 0
A2DPD[21:29:28.321]: stream_client_state_streamingsetup: PLAYBACK thread 
client_index=0, socket=10, id=0 started (44100 Hz, 2 channels, 16 bits, 
ring 65536, threshold 65536)
A2DPD[21:29:28.323]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[21:29:28.323]: a2dp_state_machine: Role is INITIATOR
A2DPD[21:29:28.346]: a2dp_state_machine: (errno=115:Operation now in 
progress)SDP connection on socket 11
A2DPD[21:29:28.346]: a2dp_state_machine: State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[21:29:28.346]: a2dpd_signal_state: Connecting 00:07:A4:D5:49:6F
A2DPD[21:29:31.896]: a2dp_state_machine: SDP connection terminated
A2DPD[21:29:32.072]: get_avdtp_psm: Parsing results
A2DPD[21:29:32.072]: get_avdtp_psm: Record
A2DPD[21:29:32.073]: get_avdtp_psm: Record
A2DPD[21:29:32.073]: get_avdtp_psm: Service Search OK
A2DPD[21:29:32.139]: get_avdtp_psm: Checking non spec audio
A2DPD[21:29:32.139]: a2dp_state_machine: Found psm 25
A2DPD[21:29:32.140]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[21:29:32.140]: a2dp_state_machine: Socket is 11
A2DPD[21:29:32.140]: a2dp_state_machine: (errno=115:Operation now in 
progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[21:29:32.457]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[21:29:32.457]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[21:29:32.462]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[21:29:32.754]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[21:29:32.754]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[21:29:32.755]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[21:29:32.755]: a2dp_state_machine: Getting capabilities for SEID=3
A2DPD[21:29:32.755]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[21:29:32.846]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[21:29:32.846]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success 
for seid 3
A2DPD[21:29:32.846]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[21:29:32.847]: a2dp_state_machine: cap_type=7, length=6
A2DPD[21:29:32.847]: a2dp_state_machine: media_type=0, codec=0
A2DPD[21:29:32.847]: a2dp_state_machine: A2DPD  Prefered bitpool 32
A2DPD[21:29:32.847]: a2dp_state_machine: Device Prefered bitpool 2 -> 53
A2DPD[21:29:32.847]: a2dp_state_machine: A2DPD  Selected bitpool 32
A2DPD[21:29:32.847]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[21:29:32.848]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[21:29:33.041]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[21:29:33.041]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[21:29:33.041]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[21:29:33.042]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[21:29:33.157]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[21:29:33.157]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[21:29:33.157]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[21:29:33.162]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_CONNECTING
A2DPD[21:29:33.170]: a2dp_state_machine: Socket is 12
A2DPD[21:29:33.170]: a2dp_state_machine: (errno=115:Operation now in 
progress)State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[21:29:33.616]: a2dp_state_machine: Stream connected
A2DPD[21:29:33.616]: get_socket_omtu: Socket 12 imtu=672, omtu=895, 
flush_to=65535
A2DPD[21:29:33.616]: a2dp_state_machine: State 
AVDTP_STATE_OPEN_START_STREAMING
A2DPD[21:29:33.623]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[21:29:33.623]: a2dpd_signal_state: Connected 00:07:A4:D5:49:6F
A2DPD[21:29:33.624]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[21:29:33.925]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[21:29:33.925]: a2dp_state_machine: AVDTP_START success
A2DPD[21:29:33.925]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[21:29:33.930]: a2dp_transfer_raw: Samples starting


Best regards,
Stephan


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
