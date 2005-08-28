Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001001c5ac1f$7920e610$0201a8c0@NBVICTOR>
From: "Victor Shcherbatyuk" <victor@win.tue.nl>
To: <bluez-devel@lists.sourceforge.net>
References: <C70061B183DE09419568AB2060C52A950E4492@arion.intra.local> <430EA45A.2030008@xmission.com> <002501c5ab5a$4844ec50$0201a8c0@NBVICTOR> <43114F3C.8000804@xmission.com>
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
Date: Mon, 29 Aug 2005 00:26:02 +0200

Brad,

I've merged the fixed and floating point code added 32-bit fixed point (not 
tested though), moved fixed point math to sbc_math.h. I've decided to use 
struct to keep hi and low parts of 64bit number, but now I'm stuck with make 
it alighned onto 4 bytes boundary (I've tried __attribute__ ((alighned (4), 
packed)) with the struct, but it does not help, apparently I'm missing 
something :) ), so currently everything is loaded byte-wise which is 
slow.... I'll try to ressolve the issue and then submit the changes...

Regards,
     Victor.


----- Original Message ----- 
From: "Brad Midgley" <bmidgley@xmission.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Sunday, August 28, 2005 07:44
Subject: Re: [Bluez-devel] sbc and fixed-point progress


> Victor,
>
> Sorry... reapplied. I had thought this was one of my own fixed-point 
> tests. Thanks for keeping an eye on it.
>
> BTW, I started unrolling the decoder on paper and there's a ton of room 
> for optimization. I'll rewrite it in floating point to start with.
>
> Brad
>
>> For some reason a piece of code from my initial patch is missing for cvs 
>> repository after the last updates... It is performance critical... I've 
>> attached the patch to bring it back. Or it was removed on purpose?
>>
>> Regards,
>>      Victor.
>>
>> ----- Original Message ----- From: "Brad Midgley" <bmidgley@xmission.com>
>> To: <bluez-devel@lists.sourceforge.net>
>> Sent: Friday, August 26, 2005 07:10
>> Subject: Re: [Bluez-devel] sbc and fixed-point progress
>>
>>
>>> Victor,
>>>
>>> How did you compute the floating point _anamatrix8[] and _sbc_proto_8[] 
>>> in sbc_tables.h? (I am trying to improve the 4-subband code based on 
>>> your 8-subband float and fixed code.)
>>>
>>> BTW, I pulled out the testcode for fixed-point decoding now that people 
>>> will compile with fixed point enabled and expect everything to work.
>>>
>>> thanks
>>> Brad
>>>
>>> Victor Shcherbatyuk wrote:
>>>
>>>> Brad,
>>>>
>>>> I ran one more test and instead of -n flag for a2play I changed magic 
>>>> 87 to magic 50, CPU usage dropped >2 times to ~8% on ARM9@400Mhz and 
>>>> sound is still smooth. That's how it was tested in first place which is 
>>>> close to 30 MIPS I guess...
>>>>
>>>> Regards,
>>>>     Victor.
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: bluez-devel-admin@lists.sourceforge.net on behalf of Victor 
>>>> Shcherbatyuk
>>>> Sent: Tue 8/23/2005 5:00 PM
>>>> To: bluez-devel@lists.sourceforge.net
>>>> Subject: RE: [Bluez-devel] sbc and fixed-point progress
>>>>  Hello Brad,
>>>>
>>>> I did some test runs on ARM9@400MHz, general fixed point encoder eats 
>>>> up ~40% of CPU time, while arm specific version  - ~20%. And in both 
>>>> cases it runs quite smooth. So the drops you had should have been 
>>>> caused by something else (unless you run some othe applications 
>>>> cuncurently).
>>>>
>>>>
>>>> Victor.
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: bluez-devel-admin@lists.sourceforge.net on behalf of Brad Midgley
>>>> Sent: Mon 8/22/2005 9:22 AM
>>>> To: bluez-devel@lists.sourceforge.net
>>>> Subject: Re: [Bluez-devel] sbc and fixed-point progress
>>>>  Victor
>>>>
>>>>
>>>>>> I do not have HW to test arm specific version real time, hope no 
>>>>>> suprises there, but I could have missed something when integrating it 
>>>>>> into sbc code (it decodes well, but how fast, I will try only monday 
>>>>>> evening).
>>>>>
>>>>>
>>>>>
>>>>> Ok, I'll load it on gumstix now and give it a try.
>>>>
>>>>
>>>>
>>>> This is almost perfect. On a 400mhz gumstix (pxa255), I'm able to send 
>>>> a 5-minute audio stream with only about three breaks in the audio 
>>>> (about 5 seconds each).
>>>>
>>>> I think it will work flawlessly in 4 subbands or if we can shorten a 
>>>> few of the ops from 64 to 32 bit.
>>>>
>>>> I committed what's there and used __arm__ for the conditional asm code.
>>>>
>>>>
>>>>>> Using a2play needs to tweak 87 magic number, otherwise it drops 
>>>>>> samples?
>>>>>
>>>>>
>>>>>
>>>>> yes, this is disappointing. We may need to find another way to get 
>>>>> reliable timing than setitimer.
>>>>>
>>>>> I did change the first usleep(10) to usleep(1000) and that *may* help 
>>>>> with this problem by ensuring that we always interrupt the usleep 
>>>>> syscall consistently. I don't have my hp headphones (the set that's 
>>>>> very sensitive to timing) handy to test.
>>>>
>>>>
>>>>
>>>> fwiw, I had to use the -n flag to a2play so it wouldn't use itimer at 
>>>> all. This flag tells a2play to just send the audio as fast as it can 
>>>> encode it.
>>>>
>>>> Brad
>>>>
>>>>
>>>> -------------------------------------------------------
>>>> SF.Net email is Sponsored by the Better Software Conference & EXPO
>>>> September 19-22, 2005 * San Francisco, CA * Development Lifecycle 
>>>> Practices
>>>> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & 
>>>> QA
>>>> Security * Process Improvement & Measurement * 
>>>> http://www.sqe.com/bsce5sf
>>>> _______________________________________________
>>>> Bluez-devel mailing list
>>>> Bluez-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>>
>>>>
>>>
>>>
>>> -------------------------------------------------------
>>> SF.Net email is Sponsored by the Better Software Conference & EXPO
>>> September 19-22, 2005 * San Francisco, CA * Development Lifecycle 
>>> Practices
>>> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & 
>>> QA
>>> Security * Process Improvement & Measurement * 
>>> http://www.sqe.com/bsce5sf
>>> _______________________________________________
>>> Bluez-devel mailing list
>>> Bluez-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
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
