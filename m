Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45F18755.7040307@exon.dyndns.org>
Date: Fri, 09 Mar 2007 17:12:05 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] a2dpd produces choppy audio with Digitus dongle,
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I followed the suggestion to try alsaplayer instead of XMMS, and managed 
to get a2dpd working.  XMMS, aplay, ESD, and Xine all fail, but at least 
I can prove that things work in principle.

However, when I try using my Digitus DN-3008M1 instead of my D-Link 
DBT-120, the sound is choppy, alternating half a second of sound with at 
least a second of silence, making it unusable.

Does anyone know what causes the choppiness?  On the host side, the 
configuration is identical.  The Digitus dongle is a CSR chipset, which 
is supposed to be the good stuff:

hci0:   Type: USB
         BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
         HCI 18.2.1
         Chip version: BlueCore3-ROM
         Max key size: 128 bit
         SCO mapping:  HCI

Attached is a big chunk of the error messages a2dpd prints out.  It 
looks bad, but I don't have the faintest clue what it all means.

Thanks for any help,
Mat

A2DPD[16:42:52.033]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[16:42:52.033]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[16:42:52.033]: a2dp_disconnect:
A2DPD[16:42:52.033]: a2dp_stream_stop: Closing stream socket 13
A2DPD[16:42:52.033]: close_socket: Closing 13
A2DPD[16:42:52.033]: a2dp_stream_stop: Closed
A2DPD[16:42:52.033]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[16:42:52.033]: a2dp_disconnect: Closing ctl socket 12
A2DPD[16:42:52.034]: close_socket: Closing 12
A2DPD[16:42:52.034]: a2dp_disconnect: Closed
A2DPD[16:42:52.034]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[16:42:52.034]: a2dpd_signal_state: Disconnected
A2DPD[16:42:52.034]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[16:42:52.034]: a2dp_state_machine: Role is INITIATOR
A2DPD[16:42:52.034]: a2dp_state_machine: SDP connection on socket 12
A2DPD[16:42:52.034]: a2dp_state_machine: State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[16:42:52.034]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[16:42:55.158]: a2dp_state_machine: SDP connection terminated
A2DPD[16:42:55.234]: get_avdtp_psm: Parsing results
A2DPD[16:42:55.234]: get_avdtp_psm: Record
A2DPD[16:42:55.234]: get_avdtp_psm: Service Search OK
A2DPD[16:42:55.273]: get_avdtp_psm: Checking non spec audio
A2DPD[16:42:55.273]: a2dp_state_machine: Found psm 25
A2DPD[16:42:55.273]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[16:42:55.273]: a2dp_state_machine: Socket is 12
A2DPD[16:42:55.273]: a2dp_state_machine: State 
AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[16:42:55.362]: poll_error: POLLHUP detected on socket 14
A2DPD[16:42:55.362]: close_socket: Closing 14
A2DPD[16:42:55.477]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[16:42:55.533]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[16:42:55.533]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[16:42:55.581]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[16:42:55.581]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[16:42:55.581]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[16:42:55.614]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[16:42:55.614]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[16:42:55.685]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[16:42:55.685]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success 
for seid 1
A2DPD[16:42:55.685]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[16:42:55.685]: a2dp_state_machine: cap_type=7, length=6
A2DPD[16:42:55.685]: a2dp_state_machine: media_type=0, codec=0
A2DPD[16:42:55.685]: a2dp_state_machine: A2DPD  Prefered bitpool 32
A2DPD[16:42:55.685]: a2dp_state_machine: Device Prefered bitpool 2 -> 32
A2DPD[16:42:55.685]: a2dp_state_machine: A2DPD  Selected bitpool 32
A2DPD[16:42:55.685]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[16:42:55.704]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[16:42:58.000]: a2dp_state_machine: Too many answer for 
AVDTP_SET_CONFIGURATION
A2DPD[16:42:58.000]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[16:42:58.067]: a2dp_disconnect:
A2DPD[16:42:58.067]: a2dp_stream_stop: Closing stream socket -1
A2DPD[16:42:58.068]: a2dp_stream_stop: Closed
A2DPD[16:42:58.068]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[16:42:58.068]: a2dp_disconnect: Closing ctl socket 12
A2DPD[16:42:58.068]: close_socket: Closing 12
A2DPD[16:42:58.068]: a2dp_disconnect: Closed
A2DPD[16:42:58.068]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[16:42:58.068]: a2dpd_signal_state: Disconnected
A2DPD[16:42:58.069]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[16:42:58.069]: a2dp_state_machine: Role is INITIATOR
A2DPD[16:42:58.069]: a2dp_state_machine: SDP connection on socket 12
A2DPD[16:42:58.069]: a2dp_state_machine: State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[16:42:58.069]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[16:42:59.469]: a2dp_state_machine: SDP connection terminated
A2DPD[16:42:59.539]: get_avdtp_psm: Parsing results
A2DPD[16:42:59.539]: get_avdtp_psm: Record
A2DPD[16:42:59.539]: get_avdtp_psm: Service Search OK
A2DPD[16:42:59.581]: get_avdtp_psm: Checking non spec audio
A2DPD[16:42:59.581]: a2dp_state_machine: Found psm 25
A2DPD[16:42:59.581]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[16:42:59.582]: a2dp_state_machine: Socket is 12
A2DPD[16:42:59.582]: a2dp_state_machine: State 
AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[16:42:59.799]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[16:42:59.846]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[16:42:59.846]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[16:42:59.927]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[16:42:59.927]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[16:42:59.927]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[16:42:59.930]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[16:42:59.930]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[16:43:00.039]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[16:43:00.039]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success 
for seid 1
A2DPD[16:43:00.039]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[16:43:00.039]: a2dp_state_machine: cap_type=7, length=6
A2DPD[16:43:00.039]: a2dp_state_machine: media_type=0, codec=0
A2DPD[16:43:00.039]: a2dp_state_machine: A2DPD  Prefered bitpool 32
A2DPD[16:43:00.039]: a2dp_state_machine: Device Prefered bitpool 2 -> 32
A2DPD[16:43:00.039]: a2dp_state_machine: A2DPD  Selected bitpool 32
A2DPD[16:43:00.039]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[16:43:00.085]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[16:43:00.230]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[16:43:00.230]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[16:43:00.230]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[16:43:00.265]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[16:43:00.337]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[16:43:00.337]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[16:43:00.337]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[16:43:00.353]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_CONNECTING
A2DPD[16:43:00.353]: a2dp_state_machine: Socket is 13
A2DPD[16:43:00.353]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[16:43:00.600]: a2dp_state_machine: Stream connected
A2DPD[16:43:00.600]: get_socket_omtu: Socket 13 imtu=672, omtu=895, 
flush_to=65535
A2DPD[16:43:00.600]: a2dp_state_machine: State 
AVDTP_STATE_OPEN_START_STREAMING
A2DPD[16:43:00.637]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[16:43:00.637]: a2dpd_signal_state: Connected XX:XX:XX:XX:XX:XX
A2DPD[16:43:00.638]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[16:43:00.861]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[16:43:00.861]: a2dp_state_machine: AVDTP_START success
A2DPD[16:43:00.861]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[16:43:03.508]: a2dp_transfer_raw: Wrote -1 not 849 bytes (sbc.len=76)
A2DPD[16:43:03.508]: transfer_outgoing_packets: Error in transfer 
(transfer=-1)
A2DPD[16:43:03.508]: a2dp_state_disconnect: State 
AVDTP_STATEX_STREAM_CLOSING
A2DPD[16:43:03.561]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[16:43:03.562]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[16:43:05.736]: get_socket_omtu: Socket 9 imtu=672, omtu=0, 
flush_to=65535
A2DPD[16:43:05.737]: avrcp_state_machine: socket 14: Connection from 
DB:AF:82:89:03:00, mtu=610 accepted at index 0
A2DPD[16:43:06.011]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[16:43:06.011]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[16:43:06.011]: a2dp_disconnect:
A2DPD[16:43:06.011]: a2dp_stream_stop: Closing stream socket 13
A2DPD[16:43:06.011]: close_socket: Closing 13
A2DPD[16:43:06.011]: a2dp_stream_stop: Closed
A2DPD[16:43:06.011]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[16:43:06.011]: a2dp_disconnect: Closing ctl socket 12
A2DPD[16:43:06.011]: close_socket: Closing 12
A2DPD[16:43:06.011]: a2dp_disconnect: Closed
A2DPD[16:43:06.011]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[16:43:06.011]: a2dpd_signal_state: Disconnected
A2DPD[16:43:06.011]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[16:43:06.011]: a2dp_state_machine: Role is INITIATOR
A2DPD[16:43:06.011]: a2dp_state_machine: SDP connection on socket 12
A2DPD[16:43:06.011]: a2dp_state_machine: State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[16:43:06.011]: a2dpd_signal_state: Connecting XX:XX:XX:XX:XX:XX
A2DPD[16:43:08.917]: a2dp_state_machine: SDP connection terminated
A2DPD[16:43:08.988]: get_avdtp_psm: Parsing results
A2DPD[16:43:08.988]: get_avdtp_psm: Record
A2DPD[16:43:08.988]: get_avdtp_psm: Service Search OK

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
