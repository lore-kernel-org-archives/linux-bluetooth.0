Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] sbc and fixed-point progress
From: Victor Shcherbatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <C70061B183DE09419568AB2060C52A95C4A1B3@arion.intra.local>
References: <C70061B183DE09419568AB2060C52A95C4A1B3@arion.intra.local>
Content-Type: text/plain
Message-Id: <1126127937.4064.37.camel@dt-shch>
Mime-Version: 1.0
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
Date: Wed, 07 Sep 2005 23:18:56 +0200

Brad,

Some more explanations to what was done up till now (so that I'm not the
only one who undestands it, I hope I''m not).

Encoder analysis filter consists of 2 multiply/accumulate parts, at
first, blocks (total of 8) of the incoming 16-bit audio samples are
multiplied with sbc_proto[] array and accumulated in t[] array, then
elements of t[] array are multiplied with anamatrix[] array and
accumulated in out[] array forming subband samples.

Now, to convert it to fixed point it was decided to use 64-bit result (2
32-bit variables) to hold the result of multiplication (result of
multiplication of N bit number by M bit number requires NxM result bits
to prevent overflowing).
All the table were scaled (multiplied by 2 ^ X) to fit 32 bit precisely
- that is to have maximum precision that fits into 32-bit variable.
Now, for the first multiply-accumulate stage, 16-bit pcm samples are
multiplied by 32-bit table values giving 48-bit result, there are up to
10 accumulates, which would require additional 4 bits on top of 48 to
keep the result, giving 52 bit. The result will be multiplied by
anamatrix[] at the second multiply-accumulate stage, and as we can only
multiply 32-bit numbers, 52 bits should be scaled down to 32 giving 20
as a scale constant. Now, multiplying 32-bit t[] value by 32-bit
anamatrix[] value, at the second stage,  would give 64 bits as result,
but we also have up to 10 accumulates that require additional 4 bits to
keep the result, so that the result of first multiply-accumulate stage
should be scaled not by 20, but 24 bits to give some room for
accumulates of the second stage- this gives 24 as a scale constant
(which is defined SCALEX_STAGE1).
The result of the second stage should be scaled down to restore normal
scaling. E.g., values of the sbc_proto[] were multiplied by 2^33 to fit
precisely 32-bit, then to get intermediate t[] values, output of first
stage was shilted 24-bit (equals dividing by 2^24), then values of
anamatrix[] were multiplied by 2^30 to fit 32-bit, so the result of the
second stage is 
2^33 * 2^30 / 2^24 = 2^39 "above" normal scale -> it should be scaled
down 39 bits -> by leaving out lower 32-bit and assigning to subband
sample output values higher 32-bit part of the second stage result
scaled down 7 bits (SCALEX_STAGE2) we restore the normal scale.

For the 32bit fixed point reasoning is the same, except that tables
values scaled down to fit 16 bit (or less) to preven oveflowing when
multiplied with 16 bit pcm samples.

Hope it makes it a bit clear... If not I should write a loger story :)

Regards,
     Victor.

On Wed, 2005-09-07 at 09:14 +0200, Victor Shcherbatyuk wrote:
> To select 32-bit need to define USE_FIXED32 along with USE_FIXED, I hope
> it compiles this way, otherwise minor changes needed (it was compiling
> before my last change). Scaling for STAGE1 and STAGE2 should be updated
> in sbc_math.h in 32-bit section.
> Btw, it took around 1 hour to do 4-subbands cause I managed to
> "automate" it so it generates the code and the tables in one run of the
> filter, but it might be no applicable to decoder, I'll send you the code
> anyway :)
> 
> Regards,
>       Victor.
>  
> 
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
> Midgley
> Sent: Wednesday, September 07, 2005 5:24 AM
> To: bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] sbc and fixed-point progress
> 
> Victor
> 
> > I've checked in code for 4-subbands encoder. I've tried it only on 
> > x86, but I do not expect any surprises on arm.
> 
> Again, this is very cool...
> 
> > It turned out (probably I should read the specs more carefully) that 
> > 4-subbands with the same bitpool are actually superior to 8-subbands 
> > in sound quality, producing 2 times higher bitrate
> 
> wow, I hadn't understood that. I always thought 4 subbands sounded
> better just because my stereo headset is the sort of tinny in-the-ear
> type and I figured 4 subbands was truncating high-end frequencies just
> enough to make the sound less shrill.
> 
> > I've added the options to specify the number of subbands and use of 
> > joint stereo to sbcenc.
> 
> ok, good.
> 
> > Things to do (I'll spend some time on it):
> > 1. Check if joint stereo works
> > 2. Add command line arguments for bitpool, subbands, joint stereo, 
> > other? (thrifty flag is a bit obscure)
> 
> yes, "thrifty" was a quick hack
> 
> > 4. Check/tune the error introduced by fixed point conversion (this can
> 
> > be done comparing to old floating point implementation, cause current 
> > is using int32_t for subbands, which might introduce some error in the
> 
> > output stream)
> 
> how is 32 bit maths selected? I assume we have to tweak the source to
> try it...
> 
> > 5. There are still some optimizations regarding memcopies....
> 
> yes... I've been struggling with this in the decoder...
> 
> Brad
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle
> Practices Agile & Plan-Driven Development * Managing Projects & Teams *
> Testing & QA Security * Process Improvement & Measurement *
> http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> This e-mail message contains information which is confidential and may be privileged. It is intended for use by the addressee only. If you are not the intended addressee, we request that you notify the sender immediately and delete or destroy this e-mail message and any attachment(s), without copying, saving, forwarding, disclosing or using its contents in any other way. TomTom N.V., TomTom International BV or any other company belonging to the TomTom group of companies will not be liable for damage relating to the communication by e-mail of data, documents or any other information.
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
