Return-Path: <ian@mnementh.co.uk>
Subject: Re: PATCH: Nokia HCI driver minor issues
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
References: <c9907efa-aff0-fa9e-7cdf-868e02203d95@mnementh.co.uk>
 <20170708104932.ig3ncqhznjodhqdc@earth>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <86ff7b23-1215-67c1-fee3-d2da93cce016@mnementh.co.uk>
Date: Sat, 8 Jul 2017 14:32:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170708104932.ig3ncqhznjodhqdc@earth>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/07/17 11:49, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Jul 07, 2017 at 11:03:28PM +0100, Ian Molton wrote:
>> I've collected a couple of patches together over the last week, they
>> might be of use.
>>
>> I'm not entirely certain the 2nd one is the *correct* fix, as I could
>> only test my (very similar) driver I've based off this one, but it WFM.
>>
>> --Ian
> 
> Please always send using get-send-email(1) mail style.

I always do when sending a patch thats final. This was just for comments.
>> -------------------------------------------------------------------
>> From 3e5182a84717acd5eadd645294a008bcf27201a0 Mon Sep 17 00:00:00 2001
>> From: Ian Molton <ian@mnementh.co.uk>
>> Date: Tue, 4 Jul 2017 15:01:46 +0100
>> Subject: [PATCH 1/3] Bluetooth: Nokia HCIUART driver should depend on H4
>>
>> 	The Nokia H4+ driver causes a build error if BT_HCIUART_H4
>> is not configured. Make it depend on this symbol.
>>
>>
>> Signed-off-by: Ian Molton <ian@mnementh.co.uk>
> 
> You are on an old branch. Current mainline selects BT_HCIUART_H4.

Wow, thats recent, yeah, mainline has that fixed *since* 4.12. FML :)

> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

I'll update and resend the other two patches - Thanks for the review!

-Ian
