Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4652FEAE.1000602@nnytech.net>
Date: Tue, 22 May 2007 10:31:10 -0400
From: John Feig <feig@nnytech.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200705170207.52710.bluez-devel@huitl.de>	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>	<200705171521.38889.bluez-devel@huitl.de>	<464C7616.9070900@nnytech.net><d89ddf300705180613u5c24ed8brab0acf3f7ee65280@mail.gmail.com>
	<464DCCC4.90300@nnytech.net>
	<CE5216C10C83944D9FD37B65CD33F3970CF4E1@mplex01.mpl.access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF4E1@mplex01.mpl.access-company.com>
Content-Type: multipart/mixed; boundary="------------030504040905040008080502"
Subject: Re: [Bluez-devel] RE :  Frequent headset disconnects
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030504040905040008080502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Frederic Dalleau wrote:
> Hi,
> I did some recent changes and there are things to solve.
> I don't have access to a linux computer right now. 
> In your case, enclosing the write call in a while loop may help.
>
> do {
>             if ((written = write(a2dp->sk, a2dp->buf, a2dp->len)) != 
> a2dp->len) {
>                         // Return the error
>                         result = written;
>             }
> } while(written<0 && errno==EAGAIN);
>
> Remove the DBG call.
>
> However, it may burn cpu time if you don't wait a little before retrying.
>
>
> The best solution would be to find why the packet must be resent.
> Let us know if you get something.
>
> Frederic.
>   
Ok, I plugged that loop into the code and it seemed to be better at 
first, but the disconnects continue. See attachment. (Attachment 
contains output during failure, loops many times, probably only the 
first couple are of importance).

As you can see from the  line (errno=112:Host is down), the headphones 
are disconnected at this point, and I actually have to turn my 
headphones back on.

I should mention that I also use my bluetooth connection, 
simultaneously, with my phone for internet access, and the a2dpd seems 
to get upset whenever I try to grab data from the net. I figured that my 
bluetooth chip should be able to handle this, as I thought that the 
point of bluetooth was to be able to connect up to 7 devices to a single 
chip, and the one I have (integrated into my laptop) says that it is 
v2.0+EDR, which I figured would be plenty of bandwidth. I gave the ppp 
connection a baud rate of 115200, and set the bitpool at 53 (had to 
hardcode, but that's another topic of discussion) which is i think a 
baud rate of 763200. Now, when I had the bitpool set at 33, or 475200 
baud, the behavior was the same, and the headphones would get kicked off 
frequently.

So, I wonder, based on Brad's comment, if the "transfer=-1" is what 
causes the shutoff of my headphones. And, if that's the case, where 
should I go to change the value being written, and what should that 
value be? If I change the "-1" to some junk data, will that collect on 
the client side, and cause issues there, or could the headphone crashes 
be because of collected junk data?

Let me know what you guys think. And thanks for the help so far.
-John

--------------030504040905040008080502
Content-Type: text/plain;
 name="a2dpd.output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a2dpd.output.txt"

A2DPD[09:42:00.165]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=55283 us.
A2DPD[09:42:01.169]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=67757 us.
A2DPD[09:42:02.169]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=76054 us.
A2DPD[09:42:03.169]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=55938 us.
A2DPD[09:42:04.181]: a2dp_transfer_raw: Bandwith: 42210 (329 kbps) 53, latency=52015 us.
A2DPD[09:42:04.491]: transfer_outgoing_packets: Error in transfer (transfer=-1)
A2DPD[09:42:04.491]: a2dp_state_disconnect: State AVDTP_STATEX_STREAM_CLOSING
A2DPD[09:42:04.491]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CLOSING_WAIT
A2DPD[09:42:04.491]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:42:07.002]: a2dp_state_machine: Too many answer for AVDTP_CLOSE
A2DPD[09:42:07.002]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:42:07.006]: a2dp_disconnect:
A2DPD[09:42:07.006]: a2dp_stream_stop: Closing stream socket 12
A2DPD[09:42:07.006]: a2dp_stream_stop: Closed
A2DPD[09:42:07.006]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:42:07.006]: a2dp_disconnect: Closing ctl socket 10
A2DPD[09:42:07.006]: a2dp_disconnect: Closed
A2DPD[09:42:07.006]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:42:07.006]: a2dpd_signal_state: Disconnected
A2DPD[09:42:07.010]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:42:07.010]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:42:07.010]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:42:07.010]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:42:07.010]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:42:10.546]: a2dp_state_machine: SDP connection terminated
A2DPD[09:42:10.598]: get_avdtp_psm: Parsing results
A2DPD[09:42:10.598]: get_avdtp_psm: Record
A2DPD[09:42:10.598]: get_avdtp_psm: Service Search OK
A2DPD[09:42:10.628]: get_avdtp_psm: Checking non spec audio
A2DPD[09:42:10.628]: a2dp_state_machine: Found psm 25
A2DPD[09:42:10.628]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[09:42:10.628]: a2dp_state_machine: Socket is 10
A2DPD[09:42:10.628]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[09:42:30.655]: a2dp_state_machine: (errno=110:Connection timed out)CTL connection failed
A2DPD[09:42:30.655]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:42:30.655]: a2dp_disconnect:
A2DPD[09:42:30.655]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:42:30.655]: a2dp_stream_stop: Closed
A2DPD[09:42:30.655]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:42:30.655]: a2dp_disconnect: Closing ctl socket 10
A2DPD[09:42:30.655]: a2dp_disconnect: Closed
A2DPD[09:42:30.655]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:42:30.655]: a2dpd_signal_state: Disconnected
A2DPD[09:42:30.659]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:42:30.659]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:42:30.659]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:42:30.659]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:42:30.659]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:42:40.932]: a2dp_state_machine: SDP connection terminated
A2DPD[09:42:40.932]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:42:40.932]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:42:40.936]: a2dp_disconnect:
A2DPD[09:42:40.936]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:42:40.936]: a2dp_stream_stop: Closed
A2DPD[09:42:40.936]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:42:40.936]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:42:40.936]: a2dp_disconnect: Closed
A2DPD[09:42:40.936]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:42:40.936]: a2dpd_signal_state: Disconnected
A2DPD[09:42:40.940]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:42:40.940]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:42:40.940]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:42:40.940]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:42:40.940]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:42:51.196]: a2dp_state_machine: SDP connection terminated
A2DPD[09:42:51.196]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:42:51.196]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:42:51.200]: a2dp_disconnect:
A2DPD[09:42:51.200]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:42:51.200]: a2dp_stream_stop: Closed
A2DPD[09:42:51.200]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:42:51.200]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:42:51.200]: a2dp_disconnect: Closed
A2DPD[09:42:51.200]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:42:51.200]: a2dpd_signal_state: Disconnected
A2DPD[09:42:51.205]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:42:51.205]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:42:51.205]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:42:51.205]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:42:51.205]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:43:01.461]: a2dp_state_machine: SDP connection terminated
A2DPD[09:43:01.461]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:43:01.461]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:43:01.465]: a2dp_disconnect:
A2DPD[09:43:01.465]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:43:01.465]: a2dp_stream_stop: Closed
A2DPD[09:43:01.465]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:43:01.465]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:43:01.465]: a2dp_disconnect: Closed
A2DPD[09:43:01.465]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:43:01.465]: a2dpd_signal_state: Disconnected
A2DPD[09:43:01.469]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:43:01.469]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:43:01.469]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:43:01.469]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:43:01.469]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:43:11.722]: a2dp_state_machine: SDP connection terminated
A2DPD[09:43:11.722]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:43:11.722]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:43:11.726]: a2dp_disconnect:
A2DPD[09:43:11.726]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:43:11.726]: a2dp_stream_stop: Closed
A2DPD[09:43:11.726]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:43:11.726]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:43:11.726]: a2dp_disconnect: Closed
A2DPD[09:43:11.726]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:43:11.726]: a2dpd_signal_state: Disconnected
A2DPD[09:43:11.730]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:43:11.730]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:43:11.730]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:43:11.730]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:43:11.730]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:43:21.987]: a2dp_state_machine: SDP connection terminated
A2DPD[09:43:21.987]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:43:21.987]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:43:21.988]: a2dp_disconnect:
A2DPD[09:43:21.988]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:43:21.988]: a2dp_stream_stop: Closed
A2DPD[09:43:21.988]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:43:21.988]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:43:21.988]: a2dp_disconnect: Closed
A2DPD[09:43:21.988]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:43:21.988]: a2dpd_signal_state: Disconnected
A2DPD[09:43:21.994]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:43:21.994]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:43:21.994]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:43:21.994]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:43:21.994]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:43:32.254]: a2dp_state_machine: SDP connection terminated
A2DPD[09:43:32.254]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:43:32.254]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:43:32.254]: a2dp_disconnect:
A2DPD[09:43:32.254]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:43:32.254]: a2dp_stream_stop: Closed
A2DPD[09:43:32.254]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:43:32.254]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:43:32.254]: a2dp_disconnect: Closed
A2DPD[09:43:32.254]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:43:32.254]: a2dpd_signal_state: Disconnected
A2DPD[09:43:32.255]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:43:32.255]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:43:32.255]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:43:32.255]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:43:32.255]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:43:42.516]: a2dp_state_machine: SDP connection terminated
A2DPD[09:43:42.516]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:43:42.516]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:43:42.516]: a2dp_disconnect:
A2DPD[09:43:42.516]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:43:42.516]: a2dp_stream_stop: Closed
A2DPD[09:43:42.516]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:43:42.516]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:43:42.516]: a2dp_disconnect: Closed
A2DPD[09:43:42.516]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:43:42.516]: a2dpd_signal_state: Disconnected
A2DPD[09:43:42.516]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:43:42.516]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:43:42.516]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:43:42.516]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:43:42.516]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:43:48.232]: pollfd_cb_sockfd: Client 11 got index 0
A2DPD[09:43:48.232]: stream_client_state_streamingsetup: PLAYBACK thread client_index=0, socket=11, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[09:43:51.940]: stream_client_state_streaming: Did not receive pkt_hdr
A2DPD[09:43:51.940]: pollfd_cb_clients: Client 1: Error detected (err=1, toc=1, err=0, hup=1)
A2DPD[09:43:52.772]: a2dp_state_machine: SDP connection terminated
A2DPD[09:43:52.772]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:43:52.772]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:43:52.776]: a2dp_disconnect:
A2DPD[09:43:52.776]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:43:52.776]: a2dp_stream_stop: Closed
A2DPD[09:43:52.776]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:43:52.776]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:43:52.776]: a2dp_disconnect: Closed
A2DPD[09:43:52.776]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:43:52.776]: a2dpd_signal_state: Disconnected
A2DPD[09:43:52.780]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:43:52.780]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:43:52.780]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:43:52.780]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:43:52.780]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:44:03.037]: a2dp_state_machine: SDP connection terminated
A2DPD[09:44:03.037]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:44:03.037]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:44:03.041]: a2dp_disconnect:
A2DPD[09:44:03.041]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:44:03.041]: a2dp_stream_stop: Closed
A2DPD[09:44:03.041]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:44:03.041]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:44:03.041]: a2dp_disconnect: Closed
A2DPD[09:44:03.041]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:44:03.041]: a2dpd_signal_state: Disconnected
A2DPD[09:44:03.045]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:44:03.045]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:44:03.045]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:44:03.045]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:44:03.045]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:44:13.301]: a2dp_state_machine: SDP connection terminated
A2DPD[09:44:13.301]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:44:13.302]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:44:13.306]: a2dp_disconnect:
A2DPD[09:44:13.306]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:44:13.306]: a2dp_stream_stop: Closed
A2DPD[09:44:13.306]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:44:13.306]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:44:13.306]: a2dp_disconnect: Closed
A2DPD[09:44:13.306]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:44:13.306]: a2dpd_signal_state: Disconnected
A2DPD[09:44:13.310]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:44:13.310]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:44:13.310]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:44:13.310]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:44:13.310]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:44:23.566]: a2dp_state_machine: SDP connection terminated
A2DPD[09:44:23.566]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:44:23.566]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:44:23.571]: a2dp_disconnect:
A2DPD[09:44:23.571]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:44:23.571]: a2dp_stream_stop: Closed
A2DPD[09:44:23.571]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:44:23.571]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:44:23.571]: a2dp_disconnect: Closed
A2DPD[09:44:23.571]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:44:23.571]: a2dpd_signal_state: Disconnected
A2DPD[09:44:23.574]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:44:23.574]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:44:23.574]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:44:23.574]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:44:23.574]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:44:33.827]: a2dp_state_machine: SDP connection terminated
A2DPD[09:44:33.827]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:44:33.827]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:44:33.834]: a2dp_disconnect:
A2DPD[09:44:33.834]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:44:33.834]: a2dp_stream_stop: Closed
A2DPD[09:44:33.834]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:44:33.834]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:44:33.834]: a2dp_disconnect: Closed
A2DPD[09:44:33.834]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:44:33.834]: a2dpd_signal_state: Disconnected
A2DPD[09:44:33.834]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:44:33.834]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:44:33.835]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:44:33.835]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:44:33.835]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:44:44.097]: a2dp_state_machine: SDP connection terminated
A2DPD[09:44:44.097]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:44:44.097]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:44:44.098]: a2dp_disconnect:
A2DPD[09:44:44.098]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:44:44.098]: a2dp_stream_stop: Closed
A2DPD[09:44:44.098]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:44:44.098]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:44:44.098]: a2dp_disconnect: Closed
A2DPD[09:44:44.098]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:44:44.098]: a2dpd_signal_state: Disconnected
A2DPD[09:44:44.098]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:44:44.098]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:44:44.098]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:44:44.098]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:44:44.098]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:44:54.360]: a2dp_state_machine: SDP connection terminated
A2DPD[09:44:54.360]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:44:54.360]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:44:54.360]: a2dp_disconnect:
A2DPD[09:44:54.360]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:44:54.360]: a2dp_stream_stop: Closed
A2DPD[09:44:54.360]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:44:54.360]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:44:54.360]: a2dp_disconnect: Closed
A2DPD[09:44:54.360]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:44:54.360]: a2dpd_signal_state: Disconnected
A2DPD[09:44:54.361]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:44:54.361]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:44:54.361]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:44:54.361]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:44:54.361]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:04.617]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:04.617]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:45:04.617]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:04.621]: a2dp_disconnect:
A2DPD[09:45:04.621]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:04.621]: a2dp_stream_stop: Closed
A2DPD[09:45:04.621]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:04.621]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:04.621]: a2dp_disconnect: Closed
A2DPD[09:45:04.621]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:04.621]: a2dpd_signal_state: Disconnected
A2DPD[09:45:04.624]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:04.624]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:04.624]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:04.625]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:04.625]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:14.889]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:14.889]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:45:14.889]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:14.889]: a2dp_disconnect:
A2DPD[09:45:14.889]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:14.889]: a2dp_stream_stop: Closed
A2DPD[09:45:14.889]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:14.889]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:14.889]: a2dp_disconnect: Closed
A2DPD[09:45:14.889]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:14.889]: a2dpd_signal_state: Disconnected
A2DPD[09:45:14.890]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:14.890]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:14.890]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:14.890]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:14.890]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:25.142]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:25.142]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:45:25.142]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:25.146]: a2dp_disconnect:
A2DPD[09:45:25.146]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:25.146]: a2dp_stream_stop: Closed
A2DPD[09:45:25.146]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:25.146]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:25.146]: a2dp_disconnect: Closed
A2DPD[09:45:25.146]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:25.146]: a2dpd_signal_state: Disconnected
A2DPD[09:45:25.150]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:25.150]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:25.150]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:25.150]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:25.150]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:35.407]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:35.407]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:45:35.407]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:35.407]: a2dp_disconnect:
A2DPD[09:45:35.407]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:35.407]: a2dp_stream_stop: Closed
A2DPD[09:45:35.407]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:35.407]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:35.407]: a2dp_disconnect: Closed
A2DPD[09:45:35.407]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:35.407]: a2dpd_signal_state: Disconnected
A2DPD[09:45:35.415]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:35.415]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:35.415]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:35.415]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:35.415]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:45.671]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:45.671]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:45:45.671]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:45.679]: a2dp_disconnect:
A2DPD[09:45:45.679]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:45.679]: a2dp_stream_stop: Closed
A2DPD[09:45:45.679]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:45.679]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:45.679]: a2dp_disconnect: Closed
A2DPD[09:45:45.679]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:45.679]: a2dpd_signal_state: Disconnected
A2DPD[09:45:45.679]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:45.680]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:45.680]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:45.680]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:45.680]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:55.936]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:55.936]: a2dp_state_machine: (errno=112:Host is down)SDP connection failed
A2DPD[09:45:55.936]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:55.940]: a2dp_disconnect:
A2DPD[09:45:55.940]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:55.940]: a2dp_stream_stop: Closed
A2DPD[09:45:55.940]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:55.940]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:55.940]: a2dp_disconnect: Closed
A2DPD[09:45:55.940]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:55.940]: a2dpd_signal_state: Disconnected
A2DPD[09:45:55.944]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:55.944]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:55.944]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:55.944]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:55.944]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:55.960]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:55.960]: a2dp_state_machine: (errno=16:Device or resource busy)SDP connection failed
A2DPD[09:45:55.960]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:55.960]: a2dp_disconnect:
A2DPD[09:45:55.960]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:55.960]: a2dp_stream_stop: Closed
A2DPD[09:45:55.960]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:55.960]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:55.960]: a2dp_disconnect: Closed
A2DPD[09:45:55.960]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:55.960]: a2dpd_signal_state: Disconnected
A2DPD[09:45:55.964]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:55.964]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:55.964]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:55.964]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:55.964]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:55.980]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:55.980]: a2dp_state_machine: (errno=16:Device or resource busy)SDP connection failed
A2DPD[09:45:55.980]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:55.984]: a2dp_disconnect:
A2DPD[09:45:55.984]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:55.984]: a2dp_stream_stop: Closed
A2DPD[09:45:55.984]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:55.984]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:55.984]: a2dp_disconnect: Closed
A2DPD[09:45:55.984]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:55.984]: a2dpd_signal_state: Disconnected
A2DPD[09:45:55.984]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:55.984]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:55.984]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:55.984]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:55.984]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:56.000]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:56.000]: a2dp_state_machine: (errno=16:Device or resource busy)SDP connection failed
A2DPD[09:45:56.000]: a2dp_state_machine: State AVDTP_STATEX_DISCONNECTING
A2DPD[09:45:56.004]: a2dp_disconnect:
A2DPD[09:45:56.004]: a2dp_stream_stop: Closing stream socket -1
A2DPD[09:45:56.004]: a2dp_stream_stop: Closed
A2DPD[09:45:56.004]: a2dp_stream_stop: State AVDTP_STATE_IDLE
A2DPD[09:45:56.004]: a2dp_disconnect: Closing ctl socket -1
A2DPD[09:45:56.004]: a2dp_disconnect: Closed
A2DPD[09:45:56.004]: a2dp_disconnect: State AVDTP_STATE_DISCONNECTED
A2DPD[09:45:56.004]: a2dpd_signal_state: Disconnected
A2DPD[09:45:56.008]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[09:45:56.008]: a2dp_state_machine: Role is INITIATOR
A2DPD[09:45:56.008]: a2dp_state_machine: SDP connection on socket 10
A2DPD[09:45:56.008]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[09:45:56.008]: a2dpd_signal_state: Connecting 00:07:A4:B8:68:8F
A2DPD[09:45:56.480]: a2dp_state_machine: SDP connection terminated
A2DPD[09:45:56.557]: get_avdtp_psm: Parsing results
A2DPD[09:45:56.557]: get_avdtp_psm: Record
A2DPD[09:45:56.557]: get_avdtp_psm: Service Search OK
A2DPD[09:45:56.586]: get_avdtp_psm: Checking non spec audio
A2DPD[09:45:56.586]: a2dp_state_machine: Found psm 25
A2DPD[09:45:56.586]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[09:45:56.586]: a2dp_state_machine: Socket is 10
A2DPD[09:45:56.586]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[09:45:56.632]: pollfd_cb_avdtpfd: AVDTP Accepted 8F:68:B8:A4:07:00 on socket 12
A2DPD[09:45:56.632]: a2dpd_signal_command: new up
A2DPD[09:45:56.632]: async_run_process: Command is dcop amarok player play
A2DPD[09:45:56.632]: async_run_process: argv[0] = dcop
A2DPD[09:45:56.632]: async_run_process: argv[1] = amarok
A2DPD[09:45:56.632]: async_run_process: argv[2] = player
A2DPD[09:45:56.632]: async_run_process: argv[3] = play
A2DPD[09:45:56.632]: async_run_process: argv[4] = NULL
A2DPD[09:45:56.633]: close_server_socket_on_fork: Closing server socket 5
A2DPD[09:45:56.636]: async_run_process: Forked dcop amarok player play
A2DPD[09:45:56.636]: a2dp_state_use_socket: Incoming socket 12 : refused
A2DPD[09:45:56.636]: pollfd_cb_avdtpfd: State machine is busy, closing socket 12
A2DPD[09:45:56.848]: pollfd_cb_sockfd: Client 12 got index 1
A2DPD[09:45:56.848]: stream_client_state_streamingsetup: PLAYBACK thread client_index=1, socket=12, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[09:45:56.920]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[09:45:56.920]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[09:45:56.920]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[09:45:57.040]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[09:45:57.040]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[09:45:57.040]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[09:45:57.044]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[09:45:57.044]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[09:45:57.092]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[09:45:57.092]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[09:45:57.092]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[09:45:57.092]: a2dp_state_machine: cap_type=7, length=6
A2DPD[09:45:57.092]: a2dp_state_machine: media_type=0, codec=0
A2DPD[09:45:57.092]: a2dp_state_machine: A2DPD  Prefered bitpool 53
A2DPD[09:45:57.092]: a2dp_state_machine: Device Prefered bitpool 2 -> 33
A2DPD[09:45:57.092]: a2dp_state_machine: Requested bitpool is greater than perfered device max bitpool, this could be dangerous.
A2DPD[09:45:57.092]: a2dp_state_machine: A2DPD  Selected bitpool 53
A2DPD[09:45:57.092]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[09:45:57.096]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[09:45:57.180]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[09:45:57.180]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[09:45:57.180]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[09:45:57.180]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[09:45:57.244]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[09:45:57.244]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[09:45:57.244]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[09:45:57.244]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[09:45:57.248]: a2dp_state_machine: Socket is 13
A2DPD[09:45:57.248]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[09:45:57.396]: a2dp_state_machine: Stream connected
A2DPD[09:45:57.396]: get_socket_omtu: Socket 13 imtu=672, omtu=895, flush_to=65535
A2DPD[09:45:57.396]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[09:45:57.396]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[09:45:57.396]: a2dpd_signal_state: Connected 00:07:A4:B8:68:8F
A2DPD[09:45:57.396]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[09:45:57.512]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[09:45:57.512]: a2dp_state_machine: AVDTP_START success
A2DPD[09:45:57.512]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[09:45:57.528]: a2dp_transfer_raw: Bandwith: 12060 (94 kbps) 53, latency=69663 us.
A2DPD[09:45:58.320]: get_socket_omtu: Socket 9 imtu=672, omtu=0, flush_to=65535
A2DPD[09:45:58.320]: pollfd_cb_avrcpfd: socket 14: Connection from 8F:68:B8:A4:07:00, mtu=610 accepted at index 0
A2DPD[09:45:58.540]: a2dp_transfer_raw: Bandwith: 42210 (329 kbps) 53, latency=87989 us.
A2DPD[09:45:59.540]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=68058 us.
A2DPD[09:46:00.544]: a2dp_transfer_raw: Bandwith: 41004 (320 kbps) 53, latency=79954 us.
A2DPD[09:46:00.548]: stream_client_state_streaming: Did not receive pkt_hdr
A2DPD[09:46:00.548]: pollfd_cb_clients: Client 0: Error detected (err=1, toc=1, err=0, hup=1)
A2DPD[09:46:01.544]: a2dp_transfer_raw: Bandwith: 42210 (329 kbps) 53, latency=87707 us.
A2DPD[09:46:02.544]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=67696 us.
A2DPD[09:46:03.552]: a2dp_transfer_raw: Bandwith: 42210 (329 kbps) 53, latency=59922 us.
A2DPD[09:46:04.556]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=67187 us.
A2DPD[09:46:05.557]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=75673 us.
A2DPD[09:46:06.557]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=59607 us.
A2DPD[09:46:07.561]: a2dp_transfer_raw: Bandwith: 41607 (325 kbps) 53, latency=67858 us.


--------------030504040905040008080502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------030504040905040008080502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030504040905040008080502--
