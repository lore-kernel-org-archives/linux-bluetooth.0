Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43096D8C.2020805@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local> <42E8F2B6.6090804@xmission.com> <001001c5a680$cfb641e0$0201a8c0@NBVICTOR>
In-Reply-To: <001001c5a680$cfb641e0$0201a8c0@NBVICTOR>
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
Date: Mon, 22 Aug 2005 00:15:40 -0600

Victor

> In the attachment is the patch to support fixed point encoding for 

This is great! If everything works I'm going to commit it as-is and we 
can tweak it later for 4 subbands etc.

> 8-subband sbc codec. To compie ARM specific version USE_FIXED_ARM should 
> be defined (currently in sbc/sbc.c should be in configuration?). It is 

If it seems ok, I'd like to just use '#ifdef __arm__' so it's automatic.

> possible I broke your fixed point tables cause I've changed gen_fixed.c, 
> but it should be easy fixable.

ok, the change should be fine

> Floating point implementation is optimized too, runs 30% faster on my 

wow, nice. Maybe this room for optimization is what Marcel was talking 
about.

> AthlonXP. General fixed point (long long) runs slower than floating on 
> my PC, which is strange...

interesting

> I do not have HW to test arm specific version 
> real time, hope no suprises there, but I could have missed something 
> when integrating it into sbc code (it decodes well, but how fast, I will 
> try only monday evening).

Ok, I'll load it on gumstix now and give it a try.

> Using a2play needs to tweak 87 magic number, otherwise it drops samples?

yes, this is disappointing. We may need to find another way to get 
reliable timing than setitimer.

I did change the first usleep(10) to usleep(1000) and that *may* help 
with this problem by ensuring that we always interrupt the usleep 
syscall consistently. I don't have my hp headphones (the set that's very 
sensitive to timing) handy to test.

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
