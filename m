Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <432beae0705122315rf180f5cj9c8a84a451f7cd04@mail.gmail.com>
Date: Sat, 12 May 2007 23:15:48 -0700
From: "Justin Patrin" <papercrane@gmail.com>
To: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF4D3@mplex01.mpl.access-company.com>
MIME-Version: 1.0
References: <432beae0705121846x7b181d3fm180205dfa783e975@mail.gmail.com>
	<432beae0705121900q237f835ahf6d2ac63c619415@mail.gmail.com>
	<CE5216C10C83944D9FD37B65CD33F3970CF4D3@mplex01.mpl.access-company.com>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RE :  Problems connecting to a bluetooth headset
Reply-To: papercrane@reversefold.com,
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

On 5/12/07, Frederic Dalleau <Frederic.Dalleau@access-company.com> wrote:
>
> > A2DPD[18:45:01.312]: a2dp_new: 00:03:89:C4:04:6F, 44100
> > A2DPD[18:45:01.312]: a2dp_new: State AVDTP_STATE_DISCONNECTED
>
> Hi,
>
> The default is not to connect until there is an audio stream.
> As long as a2dpd do not connect, the pairing wil not be requested.
> Start your media player with pcm.a2dpd as output and
> or try the following commands :
> a2dpd_ctl Connect
>

I did try doing a connect as well but had forgotten that part. Here's
the output from a2dpd when I try connecting.

A2DPD[22:57:27.590]: a2dpd_handler_func:
A2DPD[22:57:27.590]: a2dpd_dbus_Connect: Begin
A2DPD[22:57:27.590]: a2dpd_dbus_Connect: OK
A2DPD[22:57:27.590]: pollfd_cb_ctl_socket: Processing 'c' 99
A2DPD[22:57:27.590]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[22:57:27.590]: a2dp_state_machine: Role is INITIATOR
A2DPD[22:57:27.590]: a2dp_state_machine: (errno=115:Operation now in
progress)SDP connection on socket 10
A2DPD[22:57:27.590]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[22:57:27.590]: a2dpd_signal_state: Connecting 00:03:89:C4:04:6F
A2DPD[22:57:28.454]: a2dp_state_machine: SDP connection terminated
A2DPD[22:57:28.528]: get_avdtp_psm: Parsing results
A2DPD[22:57:28.528]: get_avdtp_psm: Record
A2DPD[22:57:28.528]: get_avdtp_psm: Service Search OK
A2DPD[22:57:28.557]: get_avdtp_psm: Checking non spec audio
A2DPD[22:57:28.557]: a2dp_state_machine: Found psm 25
A2DPD[22:57:28.557]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[22:57:28.557]: a2dp_state_machine: Socket is 10
A2DPD[22:57:28.557]: a2dp_state_machine: (errno=115:Operation now in
progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[22:57:28.786]: a2dp_state_machine: (errno=111:Connection
refused)CTL connection failed
A2DPD[22:57:28.786]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[22:57:28.786]: a2dp_disconnect:
A2DPD[22:57:28.786]: a2dp_stream_stop: Closing stream socket 0
A2DPD[22:57:28.786]: a2dp_stream_stop: Closed
A2DPD[22:57:28.786]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[22:57:28.786]: a2dp_disconnect: Closing ctl socket 10
A2DPD[22:57:28.786]: a2dp_disconnect: Closed
A2DPD[22:57:28.786]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[22:57:28.786]: a2dpd_signal_state: Disconnected


I've also tried to run vlc and got timeouts. I ran vlc with:
# vlc --aout alsa --alsadev a2dpd file.mp3
and I get a bunch of:
[00000302] alsa audio output error: write failed (Broken pipe)

and a2dpd outputs this:

A2DPD[23:08:33.811]: sco_new:
A2DPD[23:08:33.811]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[23:08:33.811]: sco_state_disconnect: Filtering state : already
disconnected
A2DPD[23:08:33.811]: main_loop: Bluetooth Device Settings [44100 hz, 2
channels, 16 bits]
A2DPD[23:08:33.812]: avrcp_new: Listening for AVRCP on socket 9
A2DPD[23:08:33.812]: avrcp_new: 0x80a73f0
A2DPD[23:08:52.620]: pollfd_cb_sockfd: Client 10 got index 0
A2DPD[23:08:52.620]: pollfd_cb_clients: Client 0: Error detected
(err=1, toc=1, err=0, hup=1)
A2DPD[23:08:52.620]: disconnect_client:
A2DPD[23:08:52.644]: pollfd_cb_sockfd: Client 10 got index 0
A2DPD[23:08:52.644]: stream_client_state_streamingsetup: PLAYBACK
thread client_index=0, socket=10, id=0 started (44100 Hz, 2 channels,
16 bits, ring 16384, threshold 16384)

and then this over and over:

A2DPD[23:08:52.872]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[23:08:52.872]: a2dp_state_machine: Role is INITIATOR
A2DPD[23:08:52.872]: a2dp_state_machine: (errno=115:Operation now in
progress)SDP connection on socket 11
A2DPD[23:08:52.872]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[23:08:52.872]: a2dpd_signal_state: Connecting 00:03:89:C4:04:6F
A2DPD[23:08:53.472]: a2dp_state_machine: SDP connection terminated
A2DPD[23:08:53.554]: get_avdtp_psm: Parsing results
A2DPD[23:08:53.554]: get_avdtp_psm: Record
A2DPD[23:08:53.554]: get_avdtp_psm: Service Search OK
A2DPD[23:08:53.586]: get_avdtp_psm: Checking non spec audio
A2DPD[23:08:53.586]: a2dp_state_machine: Found psm 25
A2DPD[23:08:53.586]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[23:08:53.587]: a2dp_state_machine: Socket is 11
A2DPD[23:08:53.587]: a2dp_state_machine: (errno=115:Operation now in
progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[23:08:53.852]: a2dp_state_machine: (errno=111:Connection
refused)CTL connection failed
A2DPD[23:08:53.852]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[23:08:53.852]: a2dp_disconnect:
A2DPD[23:08:53.852]: a2dp_stream_stop: Closing stream socket 0
A2DPD[23:08:53.852]: a2dp_stream_stop: Closed
A2DPD[23:08:53.852]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[23:08:53.852]: a2dp_disconnect: Closing ctl socket 11
A2DPD[23:08:53.852]: a2dp_disconnect: Closed
A2DPD[23:08:53.852]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[23:08:53.852]: a2dpd_signal_state: Disconnected


> But nothing will be heard if no media is sent.
>

And nothing was heard except for a few low beeps from the headset. So
it is getting *something*....I'll see if the manual has any info on
what the bleeps and bloops mean.

-- 
Justin Patrin

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
