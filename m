Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A42C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Jan 2022 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiAPNRG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Jan 2022 08:17:06 -0500
Received: from newmail.c0rporation.com ([82.165.56.171]:38368 "EHLO
        newmail.c0rporation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiAPNRF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Jan 2022 08:17:05 -0500
Received: from authenticated-user (newmail.c0rporation.com [82.165.56.171])
        by newmail.c0rporation.com (Postfix) with ESMTPA id 1F7C540214;
        Sun, 16 Jan 2022 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0rporation.com;
        s=dkim; t=1642339023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2xQ/kIvK3VmBHOR5a7f4hwbjy9cI2UKpi5DHWwpAdc=;
        b=cRf/kSN5AFpS/MfD05qmGWEQZTtIm9yR6fE+sSEAB2t7TqJWdwem1IyBxJnMt2+A8waYfr
        /Zsu3xcHUpyzuNtYcE2TTneP0CKd7otrbowgFqeVEa8XRNxVqf0vKTo0yCQ5siEEZQ14my
        YnpU+Bn6RrXyZvDIhEhuLuJ3WdgJcrRNVA/zXLXbRmGaMFsCKn3Lin92OHBmjZ4GObx3u/
        73eC2m/9J8n9A+DicqB3J5jdfx2Dx2+h8PAYnBQj1Go9kKo6Jns+ZEke4MDRQz/JoiKDQz
        vwJMl4sgU8EguEds2cvpiegYgZz9SfKOiNirpikfJV4pR2D7FPJPe+vIWizkRg==
Message-ID: <8563d31f-55a8-c100-8d13-26872ba62e24@c0rporation.com>
Date:   Sun, 16 Jan 2022 13:17:02 +0000
MIME-Version: 1.0
Content-Language: en-GB
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org
References: <a96af59d-089f-1018-74fc-355e96fcf0c3@c0rporation.com>
 <d2b50954-5303-a547-3be8-35e6c3208a1d@molgen.mpg.de>
From:   Jack Murray <kernel@c0rporation.com>
Subject: Re: [PATCH] bluetooth: Add support for EP-B3536 USB Bluetooth adapter
In-Reply-To: <d2b50954-5303-a547-3be8-35e6c3208a1d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ----
Authentication-Results: newmail.c0rporation.com;
        auth=pass smtp.auth=jack@c0rporation.com smtp.mailfrom=kernel@c0rporation.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It's actually EDUP (https://www.szedup.com/) that make it, not Teledyne 
(unless there's some link between the companies that I couldn't see). 
I'm happy to add EDUP to the commit message though if that's not going 
to cause any confusion by the names not matching?

On 16/01/2022 06:07, Paul Menzel wrote:
> Dear Jack,
>
>
> Am 15.01.22 um 22:30 schrieb Jack Murray:
>> From: Jack Murray <kernel@c0rporation.com>
>>
>> This patch adds support for the EP-B3536 USB bluetooth 5.1 adapter based
>
> Who manufactures that device? Is it Teledyne? 0x2550 is 9552 
> (decimal), and according to [1] that is Teledyne. Maybe, add that to 
> the commit message.
>
>> on the 8761B chipset. The existing driver and firmware work fine for 
>> this
>> device from what I can tell, so this patch just adds the 
>> vendor/product IDs
>> for it to the supported device list.
>>
>> Signed-off-by: Jack Murray <kernel@c0rporation.com>
>> ---
>>   drivers/bluetooth/btusb.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 60d2fce59a71..207c8289c5c2 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -436,6 +436,8 @@ static const struct usb_device_id 
>> blacklist_table[] = {
>>          /* Additional Realtek 8761BU Bluetooth devices */
>>          { USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
>> BTUSB_WIDEBAND_SPEECH },
>> +       { USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
>> + BTUSB_WIDEBAND_SPEECH }, >
>>          /* Additional Realtek 8821AE Bluetooth devices */
>>          { USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://www.usb.org/sites/default/files/vendor_ids082119_0.pdf
