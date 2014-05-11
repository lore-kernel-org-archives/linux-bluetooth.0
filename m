Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Subject: Re: Bluez 5.18 on 3.12
From: David Eriksson <ftslc@me.com>
In-reply-to: <32A2EB6D-6B9E-419B-871F-F74A1DE2B806@latencyzero.com>
Date: Sun, 11 May 2014 15:16:08 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Message-id: <D5C353F7-D179-4777-86DD-9FD5D9654E9D@me.com>
References: <BC611432-5B36-4EA5-8667-082F55020330@me.com>
 <52C9C733-259A-427E-A857-9A291047620D@holtmann.org>
 <AE9E98E2-E507-43EC-9C1E-8464FB4F8F3C@me.com>
 <32A2EB6D-6B9E-419B-871F-F74A1DE2B806@latencyzero.com>
To: Rick Mann <rmann@latencyzero.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Keep me updated on your progress, I'm interested in doing similar things.

/d

On 09 May 2014, at 19:30, Rick Mann <rmann@latencyzero.com> wrote:

> Look in the doc/mgmt-api notes. It's a little cryptic. I was able to run BLE scanning commands. You can't put it into advertising mode via the mgmt API (you'll have to use hcitool), and becoming a peripheral requires writing a plug-in (I'm going to attempt that today).
> 
> On May 9, 2014, at 08:02 , David Eriksson <ftslc@me.com> wrote:
> 
>> Thanks for info Marcel,
>> 
>> Where can I read what's new/specific for the 1.4 release?  
>> 
>> I'm mainly after BLE, Hogp and passive scans.
>> 
>> 
>> best David
>> 
>> On 09 May 2014, at 13:06, Marcel Holtmann <marcel@holtmann.org> wrote:
>> 
>>> Hi David,
>>> 
>>>> Anyone here that have a feeling on how hard it would be to get bluez 5.18+ with mgmt api running on 3.12?
>>> 
>>> that should just work. Linux kernel 3.4 and later should be supported. I recommend at least kernel 3.9 to get mgmt API 1.3 which contains a bunch of fixes that we otherwise have to work around.
>>> 
>>> Unless you need features from mgmt API 1.4, then you need at least Linux kernel 3.13.
>>> 
>>> Regards
>>> 
>>> Marcel
>>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> -- 
> Rick
> 
> 
> 
