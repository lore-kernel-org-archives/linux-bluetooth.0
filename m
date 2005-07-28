Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bluez-devel] sbc and fixed-point progress
Message-ID: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local>
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
Date: Thu, 28 Jul 2005 15:14:48 +0200

Hello Brad,

FYI,

Yesterday I converted encoder to fixed point (I did it a dirty way, so
probably it doesn't have much of the value). I've converted each of the
tables with different precision in such a way that the operations
involving the tables (mults and adds) will not overflow 32 bit, and
where necessary I pre-shift intermediate results to prevent overlowing.
Currently the output  is a slightly noisy, but the purpose was to
estimate required performance. The result is, in the current
implementation, using fixed point it is just about to be enough to run
on 400Mhz arm combined with mp3 decoder (mp3 piped though mad mp3
decoder to sbc encoder to a2play). This means either something is wrong
:) or SBC codec should be heavily optimized (3 - 5 times ?) to make it
reasonable (memcopies is the first thing to optimize probably)...

Regards,
     Victor.


-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: Monday, July 04, 2005 6:03 AM
To: BlueZ Mailing List
Subject: [Bluez-devel] sbc and fixed-point progress

Guys,

just FYI...

I found a decent fixed point multiply that preshifts the values before
multiplying them. It keeps things in 32 bits. Most of the roundoff error
is taken care of in two additional terms. I think the result is
reasonable.
(http://www.accu.org/acornsig/public/caugers/volume2/issue6/fixedpoint.h
tml)

If you compile with fixed-point on, libsbc will run both the fixed and
floating point calculations and flag errors when they differ too much.
It seems to be working well and has helped me catch a couple of
fixed-point calculation problems.

I have the decoder almost finished but I probably need to split some
terms into integer and fixed-point components. Loading up=20
frame->sb_sample for example can have a big integer part but we want to
use most of the 32 bit fixed-point type for the fractional part.

Brad



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
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
