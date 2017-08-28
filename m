Return-Path: <vbabka@suse.cz>
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225
 _request_firmware+0x329/0x890
To: Richard Weinberger <richard@sigma-star.at>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
References: <2237498.dXpkGoRScD@blindfold>
 <C551B3EE-FC6F-4FDA-8B32-270AAC18D958@holtmann.org>
 <25498655.5hsXaGAV9U@blindfold>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0df95753-038b-42bd-c6d5-091d7d5bd741@suse.cz>
Date: Mon, 28 Aug 2017 13:50:10 +0200
MIME-Version: 1.0
In-Reply-To: <25498655.5hsXaGAV9U@blindfold>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/15/2017 01:41 PM, Richard Weinberger wrote:
> Marcel,
> 
> Am Dienstag, 15. August 2017, 12:22:27 CEST schrieb Marcel Holtmann:
>>> Is this known?
>>
>> It is not known, but it is also unclear why this happens. Basically the card
>> looses power and thus ends up in bootloader mode.
>>
> 
> Hm, maybe a BIOS issue?

Same here on a T460, also happens on resume from suspend to RAM. Looks
like a regression though. First instance I found in the logs is from
4.13-rc2. Looks like previously I've been running 4.11, and managed to
skip 4.12 on this laptop. Can check 4.12, though.

> Thanks,
> //richard
> 
