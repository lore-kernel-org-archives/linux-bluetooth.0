Return-Path: <cyrus@holtmann.org>
Message-ID: <4962778A.7000902@dtsp.co.nz>
Date: Tue, 06 Jan 2009 10:11:38 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
CC: ext Christian Hoene <hoene@uni-tuebingen.de>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] SBC Encoder program
References: <200812301246.25781.siarhei.siamashka@nokia.com> <200901051522.25993.siarhei.siamashka@nokia.com> <002701c96f43$dc833c90$9589b5b0$@de> <200901051718.44559.siarhei.siamashka@nokia.com>
In-Reply-To: <200901051718.44559.siarhei.siamashka@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Siarhei Siamashka wrote:
> On Monday 05 January 2009 16:42:39 ext Christian Hoene wrote:
>   
>>> There are some parts that look a bit redundant/suspicious:
>>>       
>>>> @@ -47,7 +47,7 @@ static ssize_t __read(int fd, void *buf, size_t
>>>> count) while (count > 0) {
>>>>                 len = read(fd, buf + pos, count);
>>>>                 if (len <= 0)
>>>> -                       return len;
>>>> +                       return pos > len ? pos : len;
>>>>
>>>>                 count -= len;
>>>>                 pos   += len;
>>>>         
>>> Is the ternary '?' operator really needed here? In this part of code we
>>> know for sure that 'len' is less or equal to zero, also 'pos ' is a
>>> positive number or zero. Having just 'return pos' should be enough.
>>>       
>> No. If read returns an error, the this error is passed to __read, too.
>>     
>
> I mean that 'return pos > len ? pos : len' and 'return pos' expressions are
> completely interexchangeable in this context.
>   

Is it trying to say: return pos > 0 ? pos : len;

That's slightly functionally different, but makes it make sense to have 
a ternary there :)  Dodgy to ignore the error though (when pos > 0).

