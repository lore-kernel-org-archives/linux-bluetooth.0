Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Hp bluetooth headset a2dp
Message-ID: <20050324172651.GA30134@externe.net>
References: <20050324165647.GA12921@externe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050324165647.GA12921@externe.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Mar 2005 12:26:51 -0500

On Thursday, 24 March 2005 at 11:56:47 (-0500), Guylhem Aznar wrote:
> I started to do something else, and now even after power cycling,
> relinking, it's not playing anymore.

More details - I was using a different test file, to try to record it
on the receiving end and compare it to the source (maybe there're
recongnisable patterns in the acceleration sequence?)

My test file was a metronome (tick tick tick etc.) at 11050 Mhz which
seems to have caused that problem. After refusing to play at that
frequency, it refuses everything else.  It seems to be able to play
again but only after power cycling.

With the bad mp3:

MPEG 2.5 layer III, 32 kbit/s, 11025 Hz mono
subbands =3D 0
allocation method =3D 0
channel_mode =3D 0
blocks =3D 0
sampling frequency =3D 0
bitpool =3D 0
frame len =3D 2
Using address: 00:0D:44:2A:09:00
Found A2DP Sink
Connected [imtu 672, omtu 672, flush_to 65535]
got capabilities response
headset does not support this frequency
sent set_config
set config rejected
couldn't locate the correct seid

Then afterwards:

subbands =3D 1
allocation method =3D 1
channel_mode =3D 2
blocks =3D 3
sampling frequency =3D 2
bitpool =3D 32
frame len =3D 72
Using address: 00:0D:44:2A:09:00
Found A2DP Sink
Connected [imtu 672, omtu 672, flush_to 65535]
got capabilities response
sent set_config
set config rejected
couldn't locate the correct seid

That's using the very same mp3 that was accepted before. I think it
may need to be told that this one was using a different frequency.

Regarding the 10 s metronome mp3, after playing it many many times I
realised that:
 - the audio was a little bit faster approx 50% of the time
 - it was a little big slower maybe 20% of the time, an normal 30%
 - it was changing during a playback session, with accelerations and
   decelerations. These changes of pace seems to follow a pattern : in
a 10 s sample, 2 sec to slow, 1 normal, 7 too fast - that's the most
frequent pattern I get, with rates of accelerations varying depending
on the samples.

However during a longer mp3 playback, I had phases of acceleration and
deceleration. I don't have a metronome mp3 longer than 10s, so I'm
unable to document that. However I hope this data will help fixing
a2play.


--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
