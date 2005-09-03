Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4319C9B5.9060508@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local> <001601c5b09c$df79dee0$0201a8c0@NBVICTOR>
In-Reply-To: <001601c5b09c$df79dee0$0201a8c0@NBVICTOR>
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
Date: Sat, 03 Sep 2005 10:05:09 -0600

Victor

Excellent... I applied the patches.

Brad

Victor Shcherbatyuk wrote:
> Brad,
> 
> The patch includes restructured and cleaned up code for 8-subband fixed 
> point encoder (I didn't touch a2play yet). I've removed some of your 
> code (if you need it let me know), moved fixed tables to sbc_tables.h 
> (manually), merged floating and fixed point filter code. Now all the 
> math is in sbc_math.h, an option added for 32 bit fixed point, but I 
> could not make it sound any good, it is uses ~0% cpu producing sound of 
> 0 quality - looks fair, so if someone wants to experiment with it... :)
> 
> I will do 4 subband encoder too. Can not promise any dates, depends how 
> easy it goes...
> 
> I've played with Philips codec and I've noticed one thing. With the same 
> value of bitpool our codec produces bitrate half of what the Philips 
> codec does... So, if I set bitpool 15 for the Philips codec it will 
> produce the same bitrate and sound quality as our encoder produces with 
> bitpool eq. 32 - something might be wrong with bitallocation?
> 
> Regards,
>      Victor.
> 
> P.S. There is no real need in rmagnitude() as we can test the filter 
> code for overflowing using an test app, supplying all kind of inputs and 
> comparing its output with that of the floating point filer. I've done it 
> and currently it does not overflow, later if we need more precision? we 
> can tweak SCALE_STAGE1 and SCALE_STAGE2 to get maximum of precision 
> without overflowing....


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
