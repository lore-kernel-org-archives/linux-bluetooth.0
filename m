Return-Path: <cyrus@holtmann.org>
Message-ID: <556C4DD9.6050301@gmail.com>
Date: Mon, 01 Jun 2015 14:19:37 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v6 00/16] Bluetooth: Multi-advertising infrastructure
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com> <1432600463-7758-1-git-send-email-fgrandel@gmail.com> <064C8AD4-80B3-4E94-96E9-F40BDA0D38C7@holtmann.org> <55663161.2000508@gmail.com> <20150531012040.GA20436@t440s>
In-Reply-To: <20150531012040.GA20436@t440s>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 05/31/2015 03:20 AM, Johan Hedberg wrote:
> Hi Florian,
>
> On Wed, May 27, 2015, Florian Grandel wrote:
>>> Are multiple instances suppose to work with this patch set?
>>
>> No. There are a few remaining TODOs (documented in the code) for actual
>> multi-advertising. I mention these in the commit messages where applicable.
>>
>> The idea was to do the more complex changes in a functionally neutral
>> refactoring first as a safe starting point for functional changes (see my
>> conv. with Arman on the list).
>>
>> Of course I'm prepared to resolve those remaining TODOs in a second patch
>> set. I just think it is a good idea if I go full cycle once to avoid those
>> beginner's errors during the next iteration.
>>
>> If you think that there are no more fundamental flaws in that first patch
>> set then I can start with the second one now. What do you think?
>
> I was also under the impression that this set implemented the full
> multi-advertising feature (rather than being refactoring in preparation
> for it). I think a kernel release should contain the whole thing or
> nothing at all, which makes me now a bit doubtful of whether this can
> make it to 4.2.

 From my pov: no problem. I prefer us to test this patch really well and 
for everybody to really feel comfortable about its inclusion rather then 
rushing this into the next release.

> How soon can you send the follow-up set? It will essentially validate
> the work of your first set, so it'd be good to see and test it as soon
> as possible.

As I'm doing this in my spare time I cannot really give you a specific 
date but I think I'll be able to provide a patch set with the remaining 
functional changes for review within two weeks.

Regards,

Florian
