Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sat, 10 Mar 2007 17:38:02 +0100
References: <45F18755.7040307@exon.dyndns.org> <45F1A3D5.7010801@xmission.com>
In-Reply-To: <45F1A3D5.7010801@xmission.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q7t8FFGJ3q3JmIg"
Message-Id: <200703101738.02535.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] a2dpd produces choppy audio with Digitus dongle,
	OK with D-Link
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_q7t8FFGJ3q3JmIg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

> > Does anyone know what causes the choppiness?
>
> did you try turning off all your other bluetooth equipment? if you have
> a headset or a pc that is switching between piconets then that comes
> through as gaps in the audio.
>
> i also had some similar trouble with the cvs code about 3 weeks ago but
> now it seems to be fine.

I have similar problems with choppy playback (just tried with sbc & plugz from 
today), at least occasionally. The log output looks similar to the original 
posters. Sometimes when I switch the headset on and start bluetooth and a2dpd 
it would play choppy sound and disconnect/reconnect all the time. The only 
way to fix that involves turning off the headset, so this might very well be 
a hardware bug. I found that as a workaround it works to turn the headset on 
first, then wait a few seconds, and then start a2dpd.

Did anyone run into this problem as well? The device is a Jabra BT 620s.

Bye,
 Robert

--Boundary-00=_q7t8FFGJ3q3JmIg
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="a2dpd.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="a2dpd.log"

A2DPD[17:11:17.594]: init_ipc: Selected IPC: unix, addr=127.0.0.1, bcst=127.0.0.255, port=21453
A2DPD[17:11:17.595]: make_daemon_process: a2dpd [Mar 10 2007 17:10:26] starting ...
A2DPD[17:11:17.598]: main: (errno=9:Bad file descriptor)a2dpd addr=XX:XX:XX:XX:XX:XX timer=4000 us [Mar 10 2007 17:10:34]
A2DPD[17:11:17.603]: a2dpd_signal_init: Getting on DBUS
A2DPD[17:11:17.605]: a2dpd_signal_init: Installing watch
A2DPD[17:11:17.605]: add_dbus_watch: Added watch 0 0x8099780 disabled
A2DPD[17:11:17.606]: add_dbus_watch: Added watch 1 0x80997a8 enabled
A2DPD[17:11:17.607]: a2dpd_signal_init: Registering object path: /com/access/a2dpd
A2DPD[17:11:17.607]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[17:11:17.608]: a2dpd_signal_init: OK
A2DPD[17:11:17.609]: a2dpd_register_sdp: OK
A2DPD[17:11:17.609]: add_avrtg:
A2DPD[17:11:17.610]: add_a2source:
A2DPD[17:11:17.611]: main_loop:
A2DPD[17:11:17.611]: make_server_socket:
A2DPD[17:11:17.612]: bta2dpdevicenew:
A2DPD[17:11:17.612]: a2dpd_signal_set_socket: Signal socket set to 12
A2DPD[17:11:17.614]: a2dpd_signal_state: Disconnected
A2DPD[17:11:17.614]: a2dp_alloc:
A2DPD[17:11:17.615]: a2dp_alloc: (a2dp = 0x809e728)
A2DPD[17:11:17.615]: a2dp_new: XX:XX:XX:XX:XX:XX, 44100
A2DPD[17:11:17.615]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[17:11:17.616]: alsa_new:
A2DPD[17:11:17.616]: alsa_new: Frame rate is 44100
A2DPD[17:11:17.621]: alsa_new: snd_pcm_open()==1
A2DPD[17:11:17.621]: alsa_new: snd_pcm_hw_params_malloc()==1
A2DPD[17:11:17.622]: alsa_new: snd_pcm_hw_params_any()==1
A2DPD[17:11:17.623]: alsa_new: snd_pcm_hw_params_set_access()==1
A2DPD[17:11:17.623]: alsa_new: snd_pcm_hw_params_set_format()==1
A2DPD[17:11:17.624]: alsa_new: snd_pcm_hw_params_set_rate()==1
A2DPD[17:11:17.624]: alsa_new: snd_pcm_hw_params_set_channels()==1
A2DPD[17:11:17.625]: alsa_new: snd_pcm_hw_params()==1
A2DPD[17:11:17.625]: alsa_new: snd_pcm_prepare()==1
A2DPD[17:11:17.626]: alsa_new: params freed
A2DPD[17:11:17.626]: alsa_new: returning 0x80996c8
A2DPD[17:11:17.627]: sco_new:
A2DPD[17:11:17.627]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[17:11:17.627]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[17:11:17.628]: main_loop: Bluetooth Device Settings [44100 hz, 2 channels, 16 bits]
A2DPD[17:11:17.630]: avrcp_new: Listening for AVRCP on socket 15
A2DPD[17:11:17.634]: avrcp_new: 0x80a8588
A2DPD[17:11:19.221]: get_socket_omtu: Socket 15 imtu=672, omtu=0, flush_to=65535
A2DPD[17:11:19.221]: avrcp_state_machine: socket 17: Connection from E7:A7:71:17:13:00, mtu=610 accepted at index 0
A2DPD[17:11:19.401]: main_loop: AVDTP Accepted E7:A7:71:17:13:00 on socket 18
A2DPD[17:11:19.401]: async_run_process: Command is dcop amarok player play
A2DPD[17:11:19.401]: async_run_process: argv[0] = dcop
A2DPD[17:11:19.401]: async_run_process: argv[1] = amarok
A2DPD[17:11:19.401]: async_run_process: argv[2] = player
A2DPD[17:11:19.401]: async_run_process: argv[3] = play
A2DPD[17:11:19.401]: async_run_process: argv[4] = NULL
A2DPD[17:11:19.401]: close_server_socket_on_fork: Closing server socket 9
A2DPD[17:11:19.402]: async_run_process: Forked dcop amarok player play
A2DPD[17:11:19.402]: a2dp_state_use_socket: Incoming socket 18 : used as control socket
A2DPD[17:11:19.402]: a2dp_ctl_use_socket: State AVDTP_STATE_IDLE
A2DPD[17:11:19.402]: a2dp_state_use_socket: Role is ACCEPTOR
A2DPD[17:11:19.402]: a2dp_state_use_socket: State AVDTP_STATE_IDLE
A2DPD[17:11:19.402]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:11:19.403]: display_daemon_state: File change detected
A2DPD[17:11:19.403]: a2dp_state_disconnect: State AVDTP_STATEX_DISCONNECTING
A2DPD[17:11:19.403]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[17:11:19.403]: a2dp_state_disconnect: State AVDTP_STATEX_DISCONNECTING
A2DPD[17:11:19.454]: a2dp_disconnect:
A2DPD[17:11:19.454]: a2dp_stream_stop: Closing stream socket 0
A2DPD[17:11:19.454]: a2dp_stream_stop: Closed
A2DPD[17:11:19.454]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[17:11:19.454]: a2dp_disconnect: Closing ctl socket 18
A2DPD[17:11:19.454]: close_socket: Closing 18
A2DPD[17:11:19.454]: a2dp_disconnect: Closed
A2DPD[17:11:19.454]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[17:11:19.454]: a2dpd_signal_state: Disconnected
call failed
A2DPD[17:12:41.987]: main_loop: New client 18
A2DPD[17:12:41.987]: main_loop: Got index 0
A2DPD[17:12:42.035]: stream_client_state_streamingsetup: PLAYBACK thread client_index=0, socket=18, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[17:12:42.035]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[17:12:42.036]: a2dp_state_machine: Role is INITIATOR
A2DPD[17:12:42.036]: a2dp_state_machine: SDP connection on socket 20
A2DPD[17:12:42.036]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[17:12:42.036]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:12:42.711]: a2dp_state_machine: SDP connection terminated
A2DPD[17:12:42.819]: get_avdtp_psm: Parsing results
A2DPD[17:12:42.819]: get_avdtp_psm: Record
A2DPD[17:12:42.819]: get_avdtp_psm: Service Search OK
A2DPD[17:12:42.851]: get_avdtp_psm: Checking non spec audio
A2DPD[17:12:42.851]: a2dp_state_machine: Found psm 25
A2DPD[17:12:42.851]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[17:12:42.851]: a2dp_state_machine: Socket is 20
A2DPD[17:12:42.851]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[17:12:43.139]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[17:12:43.143]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[17:12:43.144]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[17:12:43.351]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[17:12:43.351]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[17:12:43.351]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[17:12:43.352]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[17:12:43.352]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[17:12:43.459]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[17:12:43.459]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[17:12:43.459]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[17:12:43.459]: a2dp_state_machine: cap_type=7, length=6
A2DPD[17:12:43.459]: a2dp_state_machine: media_type=0, codec=0
A2DPD[17:12:43.461]: a2dp_state_machine: A2DPD  Prefered bitpool 53
A2DPD[17:12:43.461]: a2dp_state_machine: Device Prefered bitpool 2 -> 50
A2DPD[17:12:43.461]: a2dp_state_machine: A2DPD  Selected bitpool 50
A2DPD[17:12:43.461]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[17:12:43.499]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[17:12:43.668]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[17:12:43.668]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[17:12:43.668]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[17:12:43.668]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[17:12:43.725]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[17:12:43.725]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[17:12:43.725]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[17:12:43.751]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[17:12:43.752]: a2dp_state_machine: Socket is 21
A2DPD[17:12:43.752]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[17:12:44.050]: a2dp_state_machine: Stream connected
A2DPD[17:12:44.050]: get_socket_omtu: Socket 21 imtu=672, omtu=895, flush_to=65535
A2DPD[17:12:44.050]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[17:12:44.056]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[17:12:44.056]: a2dpd_signal_state: Connected XX:XX:XX:XX:XX:XX
A2DPD[17:12:44.056]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[17:12:44.288]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[17:12:44.288]: a2dp_state_machine: AVDTP_START success
A2DPD[17:12:44.288]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[17:12:46.644]: a2dp_transfer_raw: Wrote -1 not 797 bytes (sbc.len=112)
A2DPD[17:12:46.644]: transfer_outgoing_packets: Error in transfer (transfer=-1)
A2DPD[17:12:46.644]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[17:12:46.644]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[17:12:46.644]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:12:49.020]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[17:12:49.020]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[17:12:49.020]: a2dp_disconnect:
A2DPD[17:12:49.020]: a2dp_stream_stop: Closing stream socket 21
A2DPD[17:12:49.020]: close_socket: Closing 21
A2DPD[17:12:49.020]: a2dp_stream_stop: Closed
A2DPD[17:12:49.020]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[17:12:49.020]: a2dp_disconnect: Closing ctl socket 20
A2DPD[17:12:49.020]: close_socket: Closing 20
A2DPD[17:12:49.020]: a2dp_disconnect: Closed
A2DPD[17:12:49.020]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[17:12:49.021]: a2dpd_signal_state: Disconnected
A2DPD[17:12:49.021]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[17:12:49.021]: a2dp_state_machine: Role is INITIATOR
A2DPD[17:12:49.021]: a2dp_state_machine: SDP connection on socket 20
A2DPD[17:12:49.021]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[17:12:49.021]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:12:51.572]: a2dp_state_machine: SDP connection terminated
A2DPD[17:12:51.670]: get_avdtp_psm: Parsing results
A2DPD[17:12:51.670]: get_avdtp_psm: Record
A2DPD[17:12:51.670]: get_avdtp_psm: Service Search OK
A2DPD[17:12:51.710]: get_avdtp_psm: Checking non spec audio
A2DPD[17:12:51.710]: a2dp_state_machine: Found psm 25
A2DPD[17:12:51.711]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[17:12:51.711]: a2dp_state_machine: Socket is 20
A2DPD[17:12:51.711]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[17:12:51.955]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[17:12:51.984]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[17:12:51.984]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[17:12:52.049]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[17:12:52.049]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[17:12:52.049]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[17:12:52.056]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[17:12:52.056]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[17:12:52.101]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[17:12:52.101]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[17:12:52.101]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[17:12:52.101]: a2dp_state_machine: cap_type=7, length=6
A2DPD[17:12:52.101]: a2dp_state_machine: media_type=0, codec=0
A2DPD[17:12:52.101]: a2dp_state_machine: A2DPD  Prefered bitpool 53
A2DPD[17:12:52.101]: a2dp_state_machine: Device Prefered bitpool 2 -> 50
A2DPD[17:12:52.101]: a2dp_state_machine: A2DPD  Selected bitpool 50
A2DPD[17:12:52.101]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[17:12:52.104]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[17:12:52.179]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[17:12:52.179]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[17:12:52.179]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[17:12:52.180]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[17:12:52.244]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[17:12:52.244]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[17:12:52.244]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[17:12:52.271]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[17:12:52.271]: a2dp_state_machine: Socket is 21
A2DPD[17:12:52.271]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[17:12:52.451]: a2dp_state_machine: Stream connected
A2DPD[17:12:52.451]: get_socket_omtu: Socket 21 imtu=672, omtu=895, flush_to=65535
A2DPD[17:12:52.451]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[17:12:52.468]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[17:12:52.468]: a2dpd_signal_state: Connected XX:XX:XX:XX:XX:XX
A2DPD[17:12:52.469]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[17:12:52.557]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[17:12:52.557]: a2dp_state_machine: AVDTP_START success
A2DPD[17:12:52.557]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[17:12:54.875]: a2dp_transfer_raw: Wrote -1 not 797 bytes (sbc.len=112)
A2DPD[17:12:54.875]: transfer_outgoing_packets: Error in transfer (transfer=-1)
A2DPD[17:12:54.875]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[17:12:54.875]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[17:12:54.875]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:12:57.017]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[17:12:57.017]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[17:12:57.017]: a2dp_disconnect:
A2DPD[17:12:57.017]: a2dp_stream_stop: Closing stream socket 21
A2DPD[17:12:57.017]: close_socket: Closing 21
A2DPD[17:12:57.017]: a2dp_stream_stop: Closed
A2DPD[17:12:57.017]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[17:12:57.017]: a2dp_disconnect: Closing ctl socket 20
A2DPD[17:12:57.017]: close_socket: Closing 20
A2DPD[17:12:57.017]: a2dp_disconnect: Closed
A2DPD[17:12:57.018]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[17:12:57.018]: a2dpd_signal_state: Disconnected
A2DPD[17:12:57.018]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[17:12:57.018]: a2dp_state_machine: Role is INITIATOR
A2DPD[17:12:57.018]: a2dp_state_machine: SDP connection on socket 20
A2DPD[17:12:57.018]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[17:12:57.018]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:12:59.798]: a2dp_state_machine: SDP connection terminated
A2DPD[17:12:59.887]: get_avdtp_psm: Parsing results
A2DPD[17:12:59.888]: get_avdtp_psm: Record
A2DPD[17:12:59.888]: get_avdtp_psm: Service Search OK
A2DPD[17:12:59.930]: get_avdtp_psm: Checking non spec audio
A2DPD[17:12:59.930]: a2dp_state_machine: Found psm 25
A2DPD[17:12:59.930]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[17:12:59.930]: a2dp_state_machine: Socket is 20
A2DPD[17:12:59.930]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[17:13:00.205]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[17:13:00.245]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[17:13:00.245]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[17:13:00.326]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[17:13:00.326]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[17:13:00.326]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[17:13:00.333]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[17:13:00.333]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[17:13:00.379]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[17:13:00.379]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[17:13:00.379]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[17:13:00.379]: a2dp_state_machine: cap_type=7, length=6
A2DPD[17:13:00.379]: a2dp_state_machine: media_type=0, codec=0
A2DPD[17:13:00.379]: a2dp_state_machine: A2DPD  Prefered bitpool 53
A2DPD[17:13:00.379]: a2dp_state_machine: Device Prefered bitpool 2 -> 50
A2DPD[17:13:00.379]: a2dp_state_machine: A2DPD  Selected bitpool 50
A2DPD[17:13:00.379]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[17:13:00.385]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[17:13:00.455]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[17:13:00.455]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[17:13:00.455]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[17:13:00.465]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[17:13:00.505]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[17:13:00.505]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[17:13:00.505]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[17:13:00.518]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[17:13:00.518]: a2dp_state_machine: Socket is 21
A2DPD[17:13:00.519]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[17:13:00.679]: a2dp_state_machine: Stream connected
A2DPD[17:13:00.679]: get_socket_omtu: Socket 21 imtu=672, omtu=895, flush_to=65535
A2DPD[17:13:00.679]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[17:13:00.709]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[17:13:00.709]: a2dpd_signal_state: Connected XX:XX:XX:XX:XX:XX
A2DPD[17:13:00.709]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[17:13:00.792]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[17:13:00.793]: a2dp_state_machine: AVDTP_START success
A2DPD[17:13:00.793]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[17:13:03.076]: a2dp_transfer_raw: Wrote -1 not 797 bytes (sbc.len=112)
A2DPD[17:13:03.076]: transfer_outgoing_packets: Error in transfer (transfer=-1)
A2DPD[17:13:03.076]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[17:13:03.076]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[17:13:03.076]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:13:06.001]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[17:13:06.001]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[17:13:06.001]: a2dp_disconnect:
A2DPD[17:13:06.001]: a2dp_stream_stop: Closing stream socket 21
A2DPD[17:13:06.001]: close_socket: Closing 21
A2DPD[17:13:06.001]: a2dp_stream_stop: Closed
A2DPD[17:13:06.001]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[17:13:06.001]: a2dp_disconnect: Closing ctl socket 20
A2DPD[17:13:06.001]: close_socket: Closing 20
A2DPD[17:13:06.001]: a2dp_disconnect: Closed
A2DPD[17:13:06.001]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[17:13:06.002]: a2dpd_signal_state: Disconnected
A2DPD[17:13:06.002]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[17:13:06.002]: a2dp_state_machine: Role is INITIATOR
A2DPD[17:13:06.002]: a2dp_state_machine: SDP connection on socket 20
A2DPD[17:13:06.002]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[17:13:06.002]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:13:07.983]: a2dp_state_machine: SDP connection terminated
A2DPD[17:13:08.125]: get_avdtp_psm: Parsing results
A2DPD[17:13:08.125]: get_avdtp_psm: Record
A2DPD[17:13:08.125]: get_avdtp_psm: Service Search OK
A2DPD[17:13:08.155]: get_avdtp_psm: Checking non spec audio
A2DPD[17:13:08.155]: a2dp_state_machine: Found psm 25
A2DPD[17:13:08.155]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[17:13:08.155]: a2dp_state_machine: Socket is 20
A2DPD[17:13:08.155]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[17:13:08.368]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[17:13:08.378]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[17:13:08.379]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[17:13:08.457]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[17:13:08.457]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[17:13:08.457]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[17:13:08.461]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[17:13:08.462]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[17:13:08.520]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[17:13:08.520]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[17:13:08.520]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[17:13:08.520]: a2dp_state_machine: cap_type=7, length=6
A2DPD[17:13:08.520]: a2dp_state_machine: media_type=0, codec=0
A2DPD[17:13:08.520]: a2dp_state_machine: A2DPD  Prefered bitpool 53
A2DPD[17:13:08.520]: a2dp_state_machine: Device Prefered bitpool 2 -> 50
A2DPD[17:13:08.520]: a2dp_state_machine: A2DPD  Selected bitpool 50
A2DPD[17:13:08.520]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[17:13:08.521]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[17:13:08.595]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[17:13:08.595]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[17:13:08.595]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[17:13:08.618]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[17:13:08.670]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[17:13:08.670]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[17:13:08.670]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[17:13:08.705]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[17:13:08.706]: a2dp_state_machine: Socket is 21
A2DPD[17:13:08.706]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[17:13:08.899]: a2dp_state_machine: Stream connected
A2DPD[17:13:08.899]: get_socket_omtu: Socket 21 imtu=672, omtu=895, flush_to=65535
A2DPD[17:13:08.899]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[17:13:08.901]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[17:13:08.901]: a2dpd_signal_state: Connected XX:XX:XX:XX:XX:XX
A2DPD[17:13:08.901]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[17:13:09.007]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[17:13:09.007]: a2dp_state_machine: AVDTP_START success
A2DPD[17:13:09.007]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[17:13:11.382]: a2dp_transfer_raw: Wrote -1 not 797 bytes (sbc.len=112)
A2DPD[17:13:11.382]: transfer_outgoing_packets: Error in transfer (transfer=-1)
A2DPD[17:13:11.382]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[17:13:11.382]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[17:13:11.382]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:13:14.022]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[17:13:14.023]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[17:13:14.023]: a2dp_disconnect:
A2DPD[17:13:14.023]: a2dp_stream_stop: Closing stream socket 21
A2DPD[17:13:14.023]: close_socket: Closing 21
A2DPD[17:13:14.023]: a2dp_stream_stop: Closed
A2DPD[17:13:14.023]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[17:13:14.023]: a2dp_disconnect: Closing ctl socket 20
A2DPD[17:13:14.023]: close_socket: Closing 20
A2DPD[17:13:14.023]: a2dp_disconnect: Closed
A2DPD[17:13:14.023]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[17:13:14.023]: a2dpd_signal_state: Disconnected
A2DPD[17:13:14.023]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[17:13:14.023]: a2dp_state_machine: Role is INITIATOR
A2DPD[17:13:14.023]: a2dp_state_machine: SDP connection on socket 20
A2DPD[17:13:14.023]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[17:13:14.023]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:13:16.321]: a2dp_state_machine: SDP connection terminated
A2DPD[17:13:16.443]: get_avdtp_psm: Parsing results
A2DPD[17:13:16.443]: get_avdtp_psm: Record
A2DPD[17:13:16.443]: get_avdtp_psm: Service Search OK
A2DPD[17:13:16.474]: get_avdtp_psm: Checking non spec audio
A2DPD[17:13:16.474]: a2dp_state_machine: Found psm 25
A2DPD[17:13:16.474]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[17:13:16.475]: a2dp_state_machine: Socket is 20
A2DPD[17:13:16.475]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[17:13:16.711]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[17:13:16.750]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[17:13:16.750]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[17:13:16.801]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[17:13:16.801]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[17:13:16.801]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[17:13:16.806]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[17:13:16.806]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[17:13:17.061]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[17:13:17.061]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[17:13:17.061]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[17:13:17.061]: a2dp_state_machine: cap_type=7, length=6
A2DPD[17:13:17.061]: a2dp_state_machine: media_type=0, codec=0
A2DPD[17:13:17.063]: a2dp_state_machine: A2DPD  Prefered bitpool 53
A2DPD[17:13:17.063]: a2dp_state_machine: Device Prefered bitpool 2 -> 50
A2DPD[17:13:17.063]: a2dp_state_machine: A2DPD  Selected bitpool 50
A2DPD[17:13:17.063]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[17:13:17.081]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[17:13:17.350]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[17:13:17.350]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[17:13:17.350]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[17:13:17.382]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[17:13:17.553]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[17:13:17.553]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[17:13:17.553]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[17:13:17.581]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[17:13:17.582]: a2dp_state_machine: Socket is 21
A2DPD[17:13:17.582]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[17:13:18.148]: a2dp_state_machine: Stream connected
A2DPD[17:13:18.148]: get_socket_omtu: Socket 21 imtu=672, omtu=895, flush_to=65535
A2DPD[17:13:18.148]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[17:13:18.188]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[17:13:18.188]: a2dpd_signal_state: Connected XX:XX:XX:XX:XX:XX
A2DPD[17:13:18.188]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[17:13:18.709]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[17:13:18.709]: a2dp_state_machine: AVDTP_START success
A2DPD[17:13:18.709]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[17:13:20.291]: a2dp_transfer_raw: Wrote -1 not 797 bytes (sbc.len=112)
A2DPD[17:13:20.291]: transfer_outgoing_packets: Error in transfer (transfer=-1)
A2DPD[17:13:20.291]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[17:13:20.291]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[17:13:20.292]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:13:23.006]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[17:13:23.006]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[17:13:23.006]: a2dp_disconnect:
A2DPD[17:13:23.006]: a2dp_stream_stop: Closing stream socket 21
A2DPD[17:13:23.006]: close_socket: Closing 21
A2DPD[17:13:23.006]: a2dp_stream_stop: Closed
A2DPD[17:13:23.007]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[17:13:23.007]: a2dp_disconnect: Closing ctl socket 20
A2DPD[17:13:23.007]: close_socket: Closing 20
A2DPD[17:13:23.007]: a2dp_disconnect: Closed
A2DPD[17:13:23.007]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[17:13:23.007]: a2dpd_signal_state: Disconnected
A2DPD[17:13:23.007]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[17:13:23.007]: a2dp_state_machine: Role is INITIATOR
A2DPD[17:13:23.007]: a2dp_state_machine: SDP connection on socket 20
A2DPD[17:13:23.007]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[17:13:23.007]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[17:13:23.833]: sigint_handler: handling SIGINT
A2DPD[17:13:23.833]: alsa_destroy:
A2DPD[17:13:23.834]: alsa_destroy: OK
A2DPD[17:13:23.834]: a2dp_destroy: a2dp = 0xbfab3808
A2DPD[17:13:23.834]: a2dp_free: Disconnecting
A2DPD[17:13:23.834]: a2dp_disconnect:
A2DPD[17:13:23.834]: a2dp_stream_stop: Closing stream socket -1
A2DPD[17:13:23.834]: a2dp_stream_stop: Closed
A2DPD[17:13:23.834]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[17:13:23.834]: a2dp_disconnect: Closing ctl socket -1
A2DPD[17:13:23.834]: a2dp_disconnect: Closed
A2DPD[17:13:23.834]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[17:13:23.834]: a2dp_free: Freeing sbc
A2DPD[17:13:23.834]: a2dp_free: (a2dp = 0x809e728)
A2DPD[17:13:23.834]: a2dp_free: OK
A2DPD[17:13:23.834]: sco_destroy: sco = 0xbfab380c
A2DPD[17:13:23.834]: sco_free: Disconnecting
A2DPD[17:13:23.834]: sco_free: (sco = 0x80a7ba0)
A2DPD[17:13:23.834]: close_socket: Closing 15
A2DPD[17:13:23.834]: avrcp_destroy: Closing socket 17
A2DPD[17:13:23.834]: close_socket: Closing 17
A2DPD[17:13:23.834]: avrcp_destroy: 0x80a8588
A2DPD[17:13:23.834]: close_socket: Closing 18
A2DPD[17:13:23.834]: a2dpd_signal_set_socket: Signal socket set to -1
A2DPD[17:13:23.834]: close_socket: Closing 14
A2DPD[17:13:23.834]: close_socket: Closing 12
A2DPD[17:13:23.834]: close_socket: Closing 11
A2DPD[17:13:23.834]: a2dpd_unregister_sdp: OK
A2DPD[17:13:23.835]: a2dpd_signal_kill: OK
A2DPD[17:13:23.835]: main: Terminated succesfully

--Boundary-00=_q7t8FFGJ3q3JmIg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_q7t8FFGJ3q3JmIg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_q7t8FFGJ3q3JmIg--
