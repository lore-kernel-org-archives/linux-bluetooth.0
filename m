Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a72d33330702201537q4c10e56el8f82339427faf9aa@mail.gmail.com>
Date: Wed, 21 Feb 2007 00:37:46 +0100
From: "Ma Begaj" <derliebegott@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Headset connected, but no sound in XMMS, mplayer etc
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

my headset (jabra v250, mono headset with mic) is working with btsco,
but sound could be better and I wanted to try to use plugz. I have a
thinkpad with built in bluetooth.

I compiled sbc & plugz from latest cvs with bluez 3.9 and kernel
2.6.19.1, because cvs cannot be compiled with kernel 2.6.20.

I did everything as described on
http://bluetooth-alsa.sourceforge.net/build.html and everything was
ok. I started xmms, type in "a2dpd" for alsa device and I was asked
for a pin code. xmms was playing but I was not able to hear anything.
no application was able to play sound. This is the output of "a2dpd":

------------------------------------------

A2DPD[355.083]: main_loop: New client 11
A2DPD[355.083]: main_loop: Got index 0
A2DPD[355.084]: stream_client_state_streamingsetup: PLAYBACK thread
client_index=0, socket=11, id=0 started (44100 Hz, 2 channels, 16
bits)
A2DPD[355.085]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[355.115]: a2dp_state_machine: Role is INITIATOR
A2DPD[355.116]: a2dp_state_machine: (errno=115:Operation now in
progress)SDP connection on socket 12
A2DPD[355.116]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[355.117]: a2dpd_signal_state: Connecting 00:07:A4:28:E3:5C
A2DPD[360.127]: a2dp_state_machine: SDP connection terminated
A2DPD[360.169]: get_avdtp_psm: Service Search record empty.
A2DPD[360.169]: get_avdtp_psm: Service Search OK
A2DPD[360.198]: get_avdtp_psm: Checking non spec audio
A2DPD[360.198]: a2dp_state_machine: Found psm 25
A2DPD[360.198]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[360.198]: a2dp_state_machine: Socket is 12
A2DPD[360.198]: a2dp_state_machine: (errno=115:Operation now in
progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[360.229]: a2dp_state_machine: (errno=111:Connection refused)CTL
connection failed
A2DPD[360.229]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[360.237]: a2dp_disconnect:
A2DPD[360.237]: a2dp_stream_stop: Closing stream socket -1
A2DPD[360.237]: a2dp_stream_stop: Closed
A2DPD[360.237]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[360.237]: a2dp_disconnect: Closing ctl socket 12
A2DPD[360.237]: close_socket: Closing 12
A2DPD[360.237]: a2dp_disconnect: Closed
A2DPD[360.237]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[360.237]: a2dpd_signal_state: Disconnected
A2DPD[360.237]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[360.237]: a2dp_state_machine: Role is INITIATOR
A2DPD[360.237]: a2dp_state_machine: (errno=115:Operation now in
progress)SDP connection on socket 12
A2DPD[360.237]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[360.237]: a2dpd_signal_state: Connecting 00:07:A4:28:E3:5C
A2DPD[360.311]: a2dp_state_machine: SDP connection terminated
A2DPD[360.338]: get_avdtp_psm: Service Search record empty.
A2DPD[360.338]: get_avdtp_psm: Service Search OK
A2DPD[360.369]: get_avdtp_psm: Checking non spec audio
A2DPD[360.369]: a2dp_state_machine: Found psm 25
A2DPD[360.369]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[360.369]: a2dp_state_machine: Socket is 12
A2DPD[360.369]: a2dp_state_machine: (errno=115:Operation now in
progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT

--------------------------------------

and so on ...

I also tried to record sound with "rec -d a2dpd" but a2dpd did not react.


any ideas? thanks a lot.

M.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
