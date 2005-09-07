Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] sbc and fixed-point progress
Message-ID: <C70061B183DE09419568AB2060C52A95C4A1B3@arion.intra.local>
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
Date: Wed, 7 Sep 2005 09:14:51 +0200

To select 32-bit need to define USE_FIXED32 along with USE_FIXED, I hope
it compiles this way, otherwise minor changes needed (it was compiling
before my last change). Scaling for STAGE1 and STAGE2 should be updated
in sbc_math.h in 32-bit section.
Btw, it took around 1 hour to do 4-subbands cause I managed to
"automate" it so it generates the code and the tables in one run of the
filter, but it might be no applicable to decoder, I'll send you the code
anyway :)

Regards,
      Victor.
=20

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: Wednesday, September 07, 2005 5:24 AM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress

Victor

> I've checked in code for 4-subbands encoder. I've tried it only on=20
> x86, but I do not expect any surprises on arm.

Again, this is very cool...

> It turned out (probably I should read the specs more carefully) that=20
> 4-subbands with the same bitpool are actually superior to 8-subbands=20
> in sound quality, producing 2 times higher bitrate

wow, I hadn't understood that. I always thought 4 subbands sounded
better just because my stereo headset is the sort of tinny in-the-ear
type and I figured 4 subbands was truncating high-end frequencies just
enough to make the sound less shrill.

> I've added the options to specify the number of subbands and use of=20
> joint stereo to sbcenc.

ok, good.

> Things to do (I'll spend some time on it):
> 1. Check if joint stereo works
> 2. Add command line arguments for bitpool, subbands, joint stereo,=20
> other? (thrifty flag is a bit obscure)

yes, "thrifty" was a quick hack

> 4. Check/tune the error introduced by fixed point conversion (this can

> be done comparing to old floating point implementation, cause current=20
> is using int32_t for subbands, which might introduce some error in the

> output stream)

how is 32 bit maths selected? I assume we have to tweak the source to
try it...

> 5. There are still some optimizations regarding memcopies....

yes... I've been struggling with this in the decoder...

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle
Practices Agile & Plan-Driven Development * Managing Projects & Teams *
Testing & QA Security * Process Improvement & Measurement *
http://www.sqe.com/bsce5sf
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
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
