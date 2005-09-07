Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431E5D6D.20901@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local> <001601c5b09c$df79dee0$0201a8c0@NBVICTOR> <4319C9B5.9060508@xmission.com> <002001c5b32d$7c610340$0201a8c0@NBVICTOR>
In-Reply-To: <002001c5b32d$7c610340$0201a8c0@NBVICTOR>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 06 Sep 2005 21:24:29 -0600

Victor

> I've checked in code for 4-subbands encoder. I've tried it only on x86, 
> but I do not expect any surprises on arm.

Again, this is very cool...

> It turned out (probably I should read the specs more carefully) that 
> 4-subbands with the same bitpool are actually superior to 8-subbands in 
> sound quality, producing 2 times higher bitrate

wow, I hadn't understood that. I always thought 4 subbands sounded 
better just because my stereo headset is the sort of tinny in-the-ear 
type and I figured 4 subbands was truncating high-end frequencies just 
enough to make the sound less shrill.

> I've added the options to specify the number of subbands and use of 
> joint stereo to sbcenc.

ok, good.

> Things to do (I'll spend some time on it):
> 1. Check if joint stereo works
> 2. Add command line arguments for bitpool, subbands, joint stereo, 
> other? (thrifty flag is a bit obscure)

yes, "thrifty" was a quick hack

> 4. Check/tune the error introduced by fixed point conversion (this can 
> be done comparing to old floating point implementation, cause current is 
> using int32_t for subbands, which might introduce some error in the 
> output stream)

how is 32 bit maths selected? I assume we have to tweak the source to 
try it...

> 5. There are still some optimizations regarding memcopies....

yes... I've been struggling with this in the decoder...

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
