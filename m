Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <002001c5b32d$7c610340$0201a8c0@NBVICTOR>
From: "Victor Shcherbatyuk" <victor@win.tue.nl>
To: <bluez-devel@lists.sourceforge.net>
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local> <001601c5b09c$df79dee0$0201a8c0@NBVICTOR> <4319C9B5.9060508@xmission.com>
Subject: Re: [Bluez-devel] sbc and fixed-point progress
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
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
Date: Tue, 6 Sep 2005 23:53:58 +0200

Brad,

I've checked in code for 4-subbands encoder. I've tried it only on x86, but 
I do not expect any surprises on arm.

It turned out (probably I should read the specs more carefully) that 
4-subbands with the same bitpool are actually superior to 8-subbands in 
sound quality, producing 2 times higher bitrate and taking more time to 
encode... (well if I look at the spec, the same bitpool is distributed over 
4 subbands or over 8 subbands -> 4 subbands have 2 times higher bitrate with 
the same bitpool...) I've tried this with Philips codec (there was a 
reference to it somewhere on the web) and our results look consistent...

I've added the options to specify the number of subbands and use of joint 
stereo to sbcenc.

Things to do (I'll spend some time on it):
1. Check if joint stereo works
2. Add command line arguments for bitpool, subbands, joint stereo, other? 
(thrifty flag is a bit obscure)
3. Check bit allocation (there is a difference still with the Philips codec)
4. Check/tune the error introduced by fixed point conversion (this can be 
done comparing to old floating point implementation, cause current is using 
int32_t for subbands, which might introduce some error in the output stream)
5. There are still some optimizations regarding memcopies....

Well, it will take some time.

Regards,
      Victor.

P.S. 32-bit fixed point probably is not working, straight forward 
implementation will not work (as it is now) unless some tricks are used...

----- Original Message ----- 
From: "Brad Midgley" <bmidgley@xmission.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Saturday, September 03, 2005 18:05
Subject: Re: [Bluez-devel] sbc and fixed-point progress


> Victor
>
> Excellent... I applied the patches.
>
> Brad
>
> Victor Shcherbatyuk wrote:
>> Brad,
>>
>> The patch includes restructured and cleaned up code for 8-subband fixed 
>> point encoder (I didn't touch a2play yet). I've removed some of your code 
>> (if you need it let me know), moved fixed tables to sbc_tables.h 
>> (manually), merged floating and fixed point filter code. Now all the math 
>> is in sbc_math.h, an option added for 32 bit fixed point, but I could not 
>> make it sound any good, it is uses ~0% cpu producing sound of 0 quality - 
>> looks fair, so if someone wants to experiment with it... :)
>>
>> I will do 4 subband encoder too. Can not promise any dates, depends how 
>> easy it goes...
>>
>> I've played with Philips codec and I've noticed one thing. With the same 
>> value of bitpool our codec produces bitrate half of what the Philips 
>> codec does... So, if I set bitpool 15 for the Philips codec it will 
>> produce the same bitrate and sound quality as our encoder produces with 
>> bitpool eq. 32 - something might be wrong with bitallocation?
>>
>> Regards,
>>      Victor.
>>
>> P.S. There is no real need in rmagnitude() as we can test the filter code 
>> for overflowing using an test app, supplying all kind of inputs and 
>> comparing its output with that of the floating point filer. I've done it 
>> and currently it does not overflow, later if we need more precision? we 
>> can tweak SCALE_STAGE1 and SCALE_STAGE2 to get maximum of precision 
>> without overflowing....
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle 
> Practices
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
