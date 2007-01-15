Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 15 Jan 2007 02:57:20 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B+tqFOy0Q4xWRbN"
Message-Id: <200701150257.21542.bluez-devel@huitl.de>
Subject: [Bluez-devel] a2dpd: audio connection breaks every 300 seconds
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

--Boundary-00=_B+tqFOy0Q4xWRbN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have some problems using a2dpd. It works just fine for some time, but every 
300 seconds the sound starts choking. At this time, a2dpd prints this line:

A2DPD[155.135]: a2dp_transfer_raw: Wrote -1 not 603 bytes.

Then the sound stops for a short time while a2dpd re-establishes the 
connection and sound will be fine for another 300 seconds.

Restarting a2dpd does not reset the 300 seconds time interval, so the problem 
is probably not with a2dpd but bluez itself. Disabling WLAN does not help 
either.

Headset: Jabra BT 620s
System: Gentoo Linux with kernel 2.6.18-suspend2-r1
plugz: CVS (updated today)
bluez-utils: 3.7
bluez-libs: 3.7
Bluetooth: Thinkpad X41's internal USB bluetooth adapter
Sound is played by Amarok using the Xine engine with ALSA output. VLC playback 
has the same problem.


My .a2dpdrc:

[a2dpd]
rate=44100
enablereversestereo=1
cmdplay=dcop amarok player play
...
enableavrcp=1
enablerereadconfig=1
enableredirectalsa=0
address=00:13:17:71:A7:E7
alsaoutput=plughw:0,0
sbcbitpool=53


I attached the complete logfile. It was created by a slightly modified version 
of a2dpd that tries to resend the data several times (with 1/10/20 us 
delay) - to no avail.

Any ideas? Did anyone observe this problem as well? Is it specific to my 
headset?

Regards,
  Robert

--Boundary-00=_B+tqFOy0Q4xWRbN
Content-Type: text/plain; charset="us-ascii"; name="a2dpd-bluez-300seconds.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="a2dpd-bluez-300seconds.txt"

A2DPD[341.980]: make_daemon_process: (errno=2:No such file or directory)a2dpd [Jan 15 2007 01:00:14] starting ...
A2DPD[341.981]: init_uinput: (errno=2:No such file or directory)Cannot open /dev/input/uinput
A2DPD[341.981]: main: a2dpd addr=00:13:17:71:A7:E7 timer=4000 us [Jan 15 2007 01:00:10]
A2DPD[341.981]: a2dpd_signal_init:
A2DPD[341.983]: a2dpd_signal_init: (errno=2:No such file or directory)Getting on DBUS
A2DPD[341.989]: a2dpd_signal_init: OK
A2DPD[341.991]: a2dpd_signal_set_socket: Signal socket set to 9
A2DPD[341.992]: a2dpd_thread_handler: Registering object path: /com/access/a2dpd
A2DPD[341.993]: a2dpd_thread_handler: Acquiring service: com.access.a2dpd
A2DPD[341.994]: a2dpd_thread_handler: Failed to acquire service[2]: Connection ":1.33" is not allowed to own the service "com.access.a2dpd" due to security policies in the configuration file
A2DPD[341.995]: main_loop: New client 11
A2DPD[341.995]: main_loop: Got index 0
A2DPD[341.995]: poll_incoming_clients_sockets: PLAYBACK thread client_index=0, socket=11, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[341.996]: a2dpd_signal_state: Disconnected
A2DPD[341.997]: a2dp_alloc:
A2DPD[341.998]: a2dp_alloc: (a2dp = 0x808e848)
A2DPD[341.998]: a2dp_new: 00:13:17:71:A7:E7, 44100
A2DPD[341.999]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[341.999]: alsa_new:
A2DPD[342.000]: alsa_new: Frame rate is 44100
A2DPD[342.004]: avrcp_listener: avrcp: Accepting incoming connection
A2DPD[342.008]: alsa_new: snd_pcm_open()==1
A2DPD[342.011]: alsa_new: snd_pcm_hw_params_malloc()==1
A2DPD[342.012]: alsa_new: snd_pcm_hw_params_any()==1
A2DPD[342.013]: alsa_new: snd_pcm_hw_params_set_access()==1
A2DPD[342.013]: alsa_new: snd_pcm_hw_params_set_format()==1
A2DPD[342.014]: alsa_new: snd_pcm_hw_params_set_rate()==1
A2DPD[342.014]: alsa_new: snd_pcm_hw_params_set_channels()==1
A2DPD[342.015]: alsa_new: snd_pcm_hw_params()==1
A2DPD[342.015]: alsa_new: snd_pcm_prepare()==1
A2DPD[342.016]: alsa_new: params freed
A2DPD[342.017]: alsa_new: returning 0x8085768
A2DPD[342.018]: sco_new:
A2DPD[342.018]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[342.019]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[342.019]: a2dp_handler: Bluetooth Device Settings [44100 hz, 2 channels, 16 bits]
A2DPD[342.020]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[342.020]: a2dpd_signal_state: Connecting 00:13:17:71:A7:E7
A2DPD[342.021]: a2dp_state_machine: Role is INITIATOR
A2DPD[342.044]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[342.116]: a2dp_state_machine: SDP connection terminated
A2DPD[342.205]: get_avdtp_psm: Parsing results
A2DPD[342.205]: get_avdtp_psm: Record
A2DPD[342.206]: get_avdtp_psm: Service Search OK
A2DPD[342.259]: get_avdtp_psm: Checking non spec audio
A2DPD[342.260]: a2dp_state_machine: Found psm 25
A2DPD[342.262]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[342.267]: a2dp_state_machine: Socket is 15
A2DPD[342.267]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[342.433]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[342.434]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[342.441]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[342.528]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[342.528]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[342.528]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[342.528]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[342.528]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[342.592]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[342.592]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[342.592]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[342.592]: a2dp_state_machine: cap_type=7, length=6
A2DPD[342.592]: a2dp_state_machine: media_type=0, codec=0
A2DPD[342.592]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[342.592]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[342.668]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[342.668]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[342.668]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[342.668]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[342.723]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[342.723]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[342.723]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[342.723]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[342.723]: a2dp_state_machine: Socket is 16
A2DPD[342.723]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[342.892]: a2dp_state_machine: Stream connected
A2DPD[342.892]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[342.892]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[342.892]: a2dpd_signal_state: Connected 00:13:17:71:A7:E7
A2DPD[342.892]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[343.000]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[343.000]: a2dp_state_machine: AVDTP_START success
A2DPD[343.000]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[343.021]: a2dp_handler: File change detected
A2DPD[343.021]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[343.021]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[343.021]: a2dpd_signal_state: Connecting 00:13:17:71:A7:E7
A2DPD[343.021]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[343.336]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_CLOSE)
A2DPD[343.336]: a2dp_state_machine: AVDTP_CLOSE success
A2DPD[343.336]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[343.336]: a2dp_disconnect:
A2DPD[343.336]: a2dp_stream_stop:
A2DPD[343.336]: a2dp_stream_stop: Closing stream socket 16
A2DPD[343.336]: close_socket: Closing 16
A2DPD[343.336]: a2dp_stream_stop: Closed
A2DPD[343.336]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[343.336]: a2dp_disconnect: Closing ctl socket 15
A2DPD[343.336]: close_socket: Closing 15
A2DPD[343.336]: a2dp_disconnect: Closed
A2DPD[343.336]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[343.344]: a2dpd_signal_state: Disconnected
A2DPD[343.344]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[343.344]: a2dpd_signal_state: Connecting 00:13:17:71:A7:E7
A2DPD[343.344]: a2dp_state_machine: Role is INITIATOR
A2DPD[343.344]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[343.464]: a2dp_state_machine: SDP connection terminated
A2DPD[343.537]: get_avdtp_psm: Parsing results
A2DPD[343.537]: get_avdtp_psm: Record
A2DPD[343.537]: get_avdtp_psm: Service Search OK
A2DPD[343.576]: get_avdtp_psm: Checking non spec audio
A2DPD[343.576]: a2dp_state_machine: Found psm 25
A2DPD[343.576]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[343.576]: a2dp_state_machine: Socket is 15
A2DPD[343.576]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[343.888]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[343.888]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[343.888]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[343.988]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[343.988]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[343.988]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[343.988]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[343.988]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[344.034]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[344.034]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[344.034]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[344.034]: a2dp_state_machine: cap_type=7, length=6
A2DPD[344.034]: a2dp_state_machine: media_type=0, codec=0
A2DPD[344.034]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[344.034]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[344.112]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[344.112]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[344.112]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[344.116]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[344.168]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[344.169]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[344.169]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[344.169]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[344.176]: a2dp_state_machine: Socket is 16
A2DPD[344.176]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[344.344]: a2dp_state_machine: Stream connected
A2DPD[344.344]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[344.348]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[344.348]: a2dpd_signal_state: Connected 00:13:17:71:A7:E7
A2DPD[344.348]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[344.452]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[344.452]: a2dp_state_machine: AVDTP_START success
A2DPD[344.452]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[504.790]: main_loop: New client 17
A2DPD[504.790]: main_loop: Got index 1
A2DPD[504.790]: poll_incoming_clients_sockets: PLAYBACK thread client_index=1, socket=17, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[507.286]: poll_incoming_clients_sockets: Did not receive pkt_hdr
A2DPD[507.287]: poll_incoming_clients_sockets: Client 0: Error detected (err=1, toc=1, err=0, hup=1)
A2DPD[507.287]: close_socket: Closing 11
A2DPD[546.253]: a2dp_handler: Sound stream dry
A2DPD[555.102]: a2dp_transfer_raw: Wrote -1 not 603 bytes.
A2DPD[555.109]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 1)
A2DPD[555.113]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 2)
A2DPD[555.117]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 3)
A2DPD[555.121]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 4)
A2DPD[555.125]: a2dp_transfer_raw: Successfully recovered from previous sending error
A2DPD[555.166]: a2dp_transfer_raw: Wrote -1 not 603 bytes.
A2DPD[555.175]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 1)
A2DPD[555.181]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 2)
A2DPD[555.185]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 3)
A2DPD[555.190]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 4)
A2DPD[555.197]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 5)
A2DPD[555.201]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 6)
A2DPD[555.205]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 7)
A2DPD[555.211]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 8)
A2DPD[555.225]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 9)
A2DPD[555.234]: a2dp_transfer_raw: Wrote -1 not 603 bytes. (retry 10)
A2DPD[555.234]: a2dp_transfer_raw: Could not recover from previous sending error
A2DPD[555.234]: a2dp_handler: Error in transfer (transfer=-1)
A2DPD[555.234]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[555.234]: a2dpd_signal_state: Connecting 00:13:17:71:A7:E7
A2DPD[555.234]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[559.642]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_CLOSE)
A2DPD[559.642]: a2dp_state_machine: AVDTP_CLOSE success
A2DPD[559.642]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[559.646]: a2dp_disconnect:
A2DPD[559.646]: a2dp_stream_stop:
A2DPD[559.646]: a2dp_stream_stop: Closing stream socket 16
A2DPD[559.646]: close_socket: Closing 16
A2DPD[559.646]: a2dp_stream_stop: Closed
A2DPD[559.646]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[559.646]: a2dp_disconnect: Closing ctl socket 15
A2DPD[559.646]: close_socket: Closing 15
A2DPD[559.646]: a2dp_disconnect: Closed
A2DPD[559.646]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[559.650]: a2dpd_signal_state: Disconnected
A2DPD[559.650]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[559.650]: a2dpd_signal_state: Connecting 00:13:17:71:A7:E7
A2DPD[559.650]: a2dp_state_machine: Role is INITIATOR
A2DPD[559.650]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[559.782]: a2dp_state_machine: SDP connection terminated
A2DPD[559.932]: get_avdtp_psm: Parsing results
A2DPD[559.932]: get_avdtp_psm: Record
A2DPD[559.932]: get_avdtp_psm: Service Search OK
A2DPD[559.987]: get_avdtp_psm: Checking non spec audio
A2DPD[559.987]: a2dp_state_machine: Found psm 25
A2DPD[559.987]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[559.987]: a2dp_state_machine: Socket is 11
A2DPD[559.987]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[560.250]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[560.254]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[560.258]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[560.354]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[560.354]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[560.354]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[560.354]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[560.354]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[560.422]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[560.422]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[560.422]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[560.422]: a2dp_state_machine: cap_type=7, length=6
A2DPD[560.422]: a2dp_state_machine: media_type=0, codec=0
A2DPD[560.422]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[560.430]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[560.503]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[560.503]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[560.503]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[560.503]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[560.554]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[560.554]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[560.554]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[560.554]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[560.555]: a2dp_state_machine: Socket is 15
A2DPD[560.555]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[560.730]: a2dp_state_machine: Stream connected
A2DPD[560.730]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[560.734]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[560.734]: a2dpd_signal_state: Connected 00:13:17:71:A7:E7
A2DPD[560.734]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[560.838]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[560.838]: a2dp_state_machine: AVDTP_START success
A2DPD[560.838]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[581.567]: main_loop: New client 16
A2DPD[581.567]: main_loop: Got index 0
A2DPD[581.567]: poll_incoming_clients_sockets: PLAYBACK thread client_index=0, socket=16, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[584.035]: poll_incoming_clients_sockets: Did not receive pkt_hdr
A2DPD[584.035]: poll_incoming_clients_sockets: Client 1: Error detected (err=1, toc=1, err=0, hup=1)
A2DPD[584.035]: close_socket: Closing 17
A2DPD[605.041]: a2dp_handler: Sound stream dry

--Boundary-00=_B+tqFOy0Q4xWRbN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_B+tqFOy0Q4xWRbN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_B+tqFOy0Q4xWRbN--
