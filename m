Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430EA45A.2030008@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress
References: <C70061B183DE09419568AB2060C52A950E4492@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A950E4492@arion.intra.local>
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
Date: Thu, 25 Aug 2005 23:10:50 -0600

Victor,

How did you compute the floating point _anamatrix8[] and _sbc_proto_8[] 
in sbc_tables.h? (I am trying to improve the 4-subband code based on 
your 8-subband float and fixed code.)

BTW, I pulled out the testcode for fixed-point decoding now that people 
will compile with fixed point enabled and expect everything to work.

thanks
Brad

Victor Shcherbatyuk wrote:
> Brad,
> 
> I ran one more test and instead of -n flag for a2play I changed magic 87 to magic 50, CPU usage dropped >2 times to ~8% on ARM9@400Mhz and sound is still smooth. That's how it was tested in first place which is close to 30 MIPS I guess...
> 
> Regards,
>     Victor.
> 
> 
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net on behalf of Victor Shcherbatyuk
> Sent: Tue 8/23/2005 5:00 PM
> To: bluez-devel@lists.sourceforge.net
> Subject: RE: [Bluez-devel] sbc and fixed-point progress
>  
> Hello Brad,
> 
> I did some test runs on ARM9@400MHz, general fixed point encoder eats up ~40% of CPU time, while arm specific version  - ~20%. And in both cases it runs quite smooth. So the drops you had should have been caused by something else (unless you run some othe applications cuncurently).
> 
> 
> Victor.
> 
> 
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net on behalf of Brad Midgley
> Sent: Mon 8/22/2005 9:22 AM
> To: bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] sbc and fixed-point progress
>  
> Victor
> 
> 
>>>I do not have HW to test arm specific version real time, hope no 
>>>suprises there, but I could have missed something when integrating it 
>>>into sbc code (it decodes well, but how fast, I will try only monday 
>>>evening).
>>
>>
>>Ok, I'll load it on gumstix now and give it a try.
> 
> 
> This is almost perfect. On a 400mhz gumstix (pxa255), I'm able to send a 
> 5-minute audio stream with only about three breaks in the audio (about 5 
> seconds each).
> 
> I think it will work flawlessly in 4 subbands or if we can shorten a few 
> of the ops from 64 to 32 bit.
> 
> I committed what's there and used __arm__ for the conditional asm code.
> 
> 
>>>Using a2play needs to tweak 87 magic number, otherwise it drops samples?
>>
>>
>>yes, this is disappointing. We may need to find another way to get 
>>reliable timing than setitimer.
>>
>>I did change the first usleep(10) to usleep(1000) and that *may* help 
>>with this problem by ensuring that we always interrupt the usleep 
>>syscall consistently. I don't have my hp headphones (the set that's very 
>>sensitive to timing) handy to test.
> 
> 
> fwiw, I had to use the -n flag to a2play so it wouldn't use itimer at 
> all. This flag tells a2play to just send the audio as fast as it can 
> encode it.
> 
> Brad
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
> 
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
