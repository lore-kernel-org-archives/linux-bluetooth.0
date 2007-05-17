Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464C7616.9070900@nnytech.net>
Date: Thu, 17 May 2007 11:34:46 -0400
From: John Feig <feig@nnytech.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200705170207.52710.bluez-devel@huitl.de>	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
	<200705171521.38889.bluez-devel@huitl.de>
In-Reply-To: <200705171521.38889.bluez-devel@huitl.de>
Subject: [Bluez-devel]  Frequent headset disconnects
Reply-To: feig@nnytech.net,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hello,
I've been using the a2dpd app for a couple of weeks now, and really like 
it. I have a few issues though, with the main one being that after a 
couple of minutes of playback, my headphones (HT820) turn off, I turn 
them back on, and playback continues. I use these things long periods of 
time with my iPod and a Jabra a2dp adapter, I can listen for hours on an 
a2dp connection with those without interruption (aside from the 
occasional phone call). But within a couple of minutes using the a2dpd 
app (and amarok or mplayer), the connection gets really choppy, then 
drops out, and I have to turn _on_ my headphones. As you might guess, 
this is a show stopper for me, as I can't really enjoy listening to 
music wirelessly if I can't get through an entire song without turning 
my headphones back on.

Any ideas on why this is happening would be helpful, as right now, I 
don't even know where to start looking. Here's the output when it fails:

A2DPD[11:10:02.275]: a2dp_transfer_raw: Wrote -1 not 603 bytes (sbc.len=118)
A2DPD[11:10:02.275]: transfer_outgoing_packets: Error in transfer 
(transfer=-1)
A2DPD[11:10:02.275]: a2dp_state_disconnect: State 
AVDTP_STATEX_STREAM_CLOSING
A2DPD[11:10:02.275]: a2dp_state_machine: State 
AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[11:10:02.275]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[11:10:05.005]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[11:10:05.005]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[11:10:05.005]: a2dp_disconnect:
A2DPD[11:10:05.005]: a2dp_stream_stop: Closing stream socket 12
A2DPD[11:10:05.005]: a2dp_stream_stop: Closed
A2DPD[11:10:05.005]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[11:10:05.005]: a2dp_disconnect: Closing ctl socket 10
A2DPD[11:10:05.005]: a2dp_disconnect: Closed
A2DPD[11:10:05.005]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[11:10:05.005]: a2dpd_signal_state: Disconnected
A2DPD[11:10:05.005]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[11:10:05.005]: a2dp_state_machine: Role is INITIATOR
A2DPD[11:10:05.005]: a2dp_state_machine: SDP connection on socket 10
A2DPD[11:10:05.005]: a2dp_state_machine: State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[11:10:05.005]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[11:10:11.515]: a2dp_state_machine: SDP connection terminated
A2DPD[11:10:11.515]: a2dp_state_machine: (errno=110:Connection timed 
out)SDP connection failed
A2DPD[11:10:11.515]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[11:10:11.515]: a2dp_disconnect:
A2DPD[11:10:11.516]: a2dp_stream_stop: Closing stream socket -1
A2DPD[11:10:11.516]: a2dp_stream_stop: Closed
A2DPD[11:10:11.516]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[11:10:11.516]: a2dp_disconnect: Closing ctl socket -1
A2DPD[11:10:11.516]: a2dp_disconnect: Closed
A2DPD[11:10:11.516]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[11:10:11.516]: a2dpd_signal_state: Disconnected
A2DPD[11:10:11.523]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[11:10:11.524]: a2dp_state_machine: Role is INITIATOR
A2DPD[11:10:11.524]: a2dp_state_machine: SDP connection on socket 10
A2DPD[11:10:11.524]: a2dp_state_machine: State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[11:10:11.524]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F

Thank you, I appreciate your help,
John

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
