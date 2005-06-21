Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
Message-ID: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Tue, 21 Jun 2005 17:28:36 +0200

Hello Brad,

I've tried recently to run a2play on arm (@~380), well no surprise here,
it looks like there is not enough cpu to deal with fp emulation. Later
I've modified a2play so it can play pre-encoded sbc (sbcend output) to
skip encoding part, but it still far from what I get when run it on PC.
I think there is a synchronization problem somewhere there, hear a lot
of clicks, drops and repetitions. I've tried it with 2 different pairs
of headphones, on Bluewalker and on HP's (iPAQ gadget), and while the
former sound not extremelly bad, the latter sound very crappy (there are
periods when they sound ok, but mostly they are out of sync?). So it
looks like it somehow connected with how the headphone handle timing?

I have a couple of questions:

1) Is there anyone buse with sbc fixed point convertion?
2) Is there anyone with similar problems (out-of-synch sound) and knows
how to solve it (or is it just about tuning the timer?)?

Thanks in advance.

Regards,
     Victor.

P.S. I run the same code on PC it sounds good, so should be something to
do with switching platforms?

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: Wednesday, June 15, 2005 19:50 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)

Claudio,

What is it you want to do?

We have prototypes for sending and receiving a2dp. For the desktop, we
need to adapt the a2dp sender to be an alsa plugin. Marcel has done some
work on that.

I've been trying to slim down the floating point operations in the sbc
library so the thing will run on an arm cpu.

see http://bluetooth-alsa.sf.net

Brad

Claudio Takahasi wrote:
> Hi folks,
>=20
> Is there anybody working on Advanced Audio Distribution Profile
(A2DP)?
>=20
>=20
> What are the available tools and software for linux/Bluez that provide

> audio streaming?
>=20
>=20
>=20
> Claudio.
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies

> from IBM. Find simple to follow Roadmaps, straightforward articles,=20
> informative Webcasts and more! Get everything you need to get up to=20
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
