Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 22:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387294AbiBHWVy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386208AbiBHTnt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:49 -0500
X-Greylist: delayed 499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 11:43:48 PST
Received: from newmail.c0rporation.com (newmail.c0rporation.com [82.165.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9FC0612C0
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 11:43:48 -0800 (PST)
Received: from authenticated-user (newmail.c0rporation.com [82.165.56.171])
        by newmail.c0rporation.com (Postfix) with ESMTPA id CDF2446FF0;
        Tue,  8 Feb 2022 19:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0rporation.com;
        s=dkim; t=1644348928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVY9IGO7ISDGEFbcKCbFa2YRuFMmQqPIokzLf8BkOv0=;
        b=b/02mNvOERHeI9ANJWrkcWVlI+dNe1kvNN03lIFSDZCvF4rrI1avz/1tOok00ZsGoNGy3+
        7mGj4nrspUf896gI6eqhnUBfkscBapOBWziNMbNJPpgtHJlBfgWBucbBf27ZigDkzNbnxM
        0ds6snjfP/7Lw5wz4t80s12mi+q75SIzdnFZwGV912XN2boMvr/gyZncqo1YxlkhGvyM+R
        BXqimczJaLy12Jh/Av+MvQ4b4Rd4aJEY9ZWUtu9zvqQ2IdSdfccxFacMibSvWGnmmcWIJw
        pUNOZEZQPok2W1Gx043f3xlB5un5DgN6FEpeJ/o18Lob3e1alK+g4Ph4WJCbyg==
Message-ID: <b9f59454-caac-3b48-62a7-ee094aca7571@c0rporation.com>
Date:   Tue, 8 Feb 2022 19:35:27 +0000
MIME-Version: 1.0
Content-Language: en-GB
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
References: <a96af59d-089f-1018-74fc-355e96fcf0c3@c0rporation.com>
 <850EDEB4-7C93-4F8E-AC41-701766BBE801@holtmann.org>
From:   Jack Murray <kernel@c0rporation.com>
Subject: Re: [PATCH] bluetooth: Add support for EP-B3536 USB Bluetooth adapter
In-Reply-To: <850EDEB4-7C93-4F8E-AC41-701766BBE801@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: newmail.c0rporation.com;
        auth=pass smtp.auth=jack@c0rporation.com smtp.mailfrom=kernel@c0rporation.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sorry I'd forgotten all about this as I actually ended up returning the 
device since it didn't have sufficient range for what I wanted it for 
anyway, so I can't include the /sys/kernel/debug/usb/devices output. 
Here's an updated commit though if it's ok to merge without that.


From: Jack Murray <kernel@c0rporation.com>

This patch adds support for the EDUP EP-B3536 USB bluetooth 5.1 adapter 
based
on the Realtek 8761B chipset. The existing driver and firmware work fine 
for this
device from what I can tell, so this patch just adds the vendor/product IDs
for it to the supported device list.


Signed-off-by: Jack Murray <kernel@c0rporation.com>
---
   drivers/bluetooth/btusb.c | 2 ++
   1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 60d2fce59a71..207c8289c5c2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -436,6 +436,8 @@ static const struct usb_device_id blacklist_table[] = {
          /* Additional Realtek 8761BU Bluetooth devices */
          { USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
BTUSB_WIDEBAND_SPEECH },
+       { USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
+ BTUSB_WIDEBAND_SPEECH }, >
          /* Additional Realtek 8821AE Bluetooth devices */
          { USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },

On 07/02/2022 15:40, Marcel Holtmann wrote:
> Hi Jack,
>
>> This patch adds support for the EP-B3536 USB bluetooth 5.1 adapter based
>> on the 8761B chipset. The existing driver and firmware work fine for this
>> device from what I can tell, so this patch just adds the vendor/product IDs
>> for it to the supported device list.
>>
>> Signed-off-by: Jack Murray <kernel@c0rporation.com>
>> ---
>>   drivers/bluetooth/btusb.c | 2 ++
>>   1 file changed, 2 insertions(+)
> please send an updated version addressing the comments and include /sys/kernel/debug/usb/devices.
>
> Regards
>
> Marcel
>
