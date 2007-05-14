Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464867D6.8020505@jlab.org>
Date: Mon, 14 May 2007 09:44:54 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46465CE6.8090407@jlab.org>
	<CE5216C10C83944D9FD37B65CD33F3970CF4D4@mplex01.mpl.access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF4D4@mplex01.mpl.access-company.com>
Subject: Re: [Bluez-devel] RE :  A2DP reconnections and scanning
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

Frederic Dalleau wrote:
> What bitpool are you using? Try a smaller value.
> Are you still using rate=32000?

I've tried it both ways, 32000 and 44100.
I tried various values for bitpool with no change (except sound quality).

Below is the output from one of the loops. This output will repeat as 
long as the sound is playing as a2dpd disconnects and reconnects. to the 
headphones.

~Chris

A2DPD[09:37:40.090]: a2dp_transfer_raw: Wrote -1 not 613 bytes (sbc.len=100)
A2DPD[09:37:40.091]: transfer_outgoing_packets: Error in transfer 
(transfer=-1)
A2DPD[09:37:40.091]: a2dp_state_disconnect: State 
AVDTP_STATEX_STREAM_CLOSING
A2DPD[09:37:40.091]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[09:37:40.091]: a2dpd_signal_state: Connecting 00:19:1F:00:0A:4D
A2DPD[09:37:42.962]: get_socket_omtu: Socket 8 imtu=672, omtu=0, 
flush_to=65535
A2DPD[09:37:42.962]: pollfd_cb_avrcpfd: socket 12: Connection from 
4D:0A:00:1F:19:00, mtu=610 accepted at index 0
A2DPD[09:37:42.987]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_CLOSE)
A2DPD[09:37:42.987]: a2dp_state_machine: AVDTP_CLOSE success
A2DPD[09:37:42.987]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:37:42.988]: a2dp_disconnect:
A2DPD[09:37:42.988]: a2dp_stream_stop: Closing stream socket 10
A2DPD[09:37:42.988]: a2dp_stream_stop: Closed
A2DPD[09:37:42.988]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:37:42.988]: a2dp_disconnect: Closing ctl socket 11
A2DPD[09:37:42.988]: a2dp_disconnect: Closed
A2DPD[09:37:42.988]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:37:42.989]: a2dpd_signal_state: Disconnected
A2DPD[09:37:42.991]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:37:42.991]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:37:42.991]: a2dp_state_machine: (errno=115:Operation now in 
progress)SDP connection on socket 10
A2DPD[09:37:42.991]: a2dp_state_machine: State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:37:42.991]: a2dpd_signal_state: Connecting 00:19:1F:00:0A:4D
A2DPD[09:37:43.129]: a2dp_state_machine: SDP connection terminated
A2DPD[09:37:43.200]: get_avdtp_psm: Parsing results
A2DPD[09:37:43.200]: get_avdtp_psm: Record
A2DPD[09:37:43.200]: get_avdtp_psm: Service Search OK
A2DPD[09:37:43.216]: get_avdtp_psm: Checking non spec audio
A2DPD[09:37:43.216]: a2dp_state_machine: Found psm 25
A2DPD[09:37:43.216]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[09:37:43.216]: a2dp_state_machine: Socket is 10
A2DPD[09:37:43.216]: a2dp_state_machine: (errno=115:Operation now in 
progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[09:37:43.396]: avrcp_handle_message: AVRCP Receive failed
A2DPD[09:37:43.495]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[09:37:43.496]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[09:37:43.496]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[09:37:43.590]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[09:37:43.590]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[09:37:43.590]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[09:37:43.591]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[09:37:43.591]: a2dp_state_machine: State 
AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[09:37:43.634]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[09:37:43.634]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success 
for seid 1
A2DPD[09:37:43.634]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[09:37:43.634]: a2dp_state_machine: cap_type=7, length=6
A2DPD[09:37:43.634]: a2dp_state_machine: media_type=0, codec=0
A2DPD[09:37:43.634]: a2dp_state_machine: A2DPD  Prefered bitpool 53
A2DPD[09:37:43.634]: a2dp_state_machine: Device Prefered bitpool 2 -> 44
A2DPD[09:37:43.634]: a2dp_state_machine: A2DPD  Selected bitpool 44
A2DPD[09:37:43.634]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[09:37:43.635]: a2dp_state_machine: State 
AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[09:37:43.710]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[09:37:43.710]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[09:37:43.710]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[09:37:43.711]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[09:37:43.762]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[09:37:43.762]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[09:37:43.762]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[09:37:43.763]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_CONNECTING
A2DPD[09:37:43.764]: a2dp_state_machine: Socket is 11
A2DPD[09:37:43.764]: a2dp_state_machine: (errno=115:Operation now in 
progress)State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[09:37:43.986]: a2dp_state_machine: Stream connected
A2DPD[09:37:43.986]: get_socket_omtu: Socket 11 imtu=672, omtu=895, 
flush_to=65535
A2DPD[09:37:43.986]: a2dp_state_machine: State 
AVDTP_STATE_OPEN_START_STREAMING
A2DPD[09:37:43.987]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[09:37:43.987]: a2dpd_signal_state: Connected 00:19:1F:00:0A:4D
A2DPD[09:37:43.988]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[09:37:44.089]: a2dp_handle_avdtp_message: Read non command packet 
(msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[09:37:44.089]: a2dp_state_machine: AVDTP_START success
A2DPD[09:37:44.089]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[09:37:44.935]: a2dp_transfer_raw: Wrote -1 not 613 bytes (sbc.len=100)



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
