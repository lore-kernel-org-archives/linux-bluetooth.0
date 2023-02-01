Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C38FC636D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 21:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjBAVQ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjBAVQ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 16:16:57 -0500
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 13:16:56 PST
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD5C6D5FE
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 13:16:55 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4P6ZHl6Cjsz9tC8
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 22:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
        t=1675285651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pehp1lZFQkpVsnHfdBd8UdfGETbWI7z1MARaSHIXVr4=;
        b=ilgiFOx87yZprRC7o78bAt07zHHkg8bpS1oqPrCHoliDD/T/KrqjEzALwXeGI15OuWcOvT
        XP+W9xOMDPoh3YLUrsF0zyVegJlefOyKej6AFWN6LH9tEI46oeCGXRitu01jtspO+4HHIk
        9NzYaE7fZfsYUiRYeMPvOfyMinDU23HfasSIJI2QZjZdYFsRXj38NITajCmiEB+4d/YF1l
        Mf0Ufjrr5U+K2Gylg6cC5d9M3K6nD8ZESXsPQZRYP/scna0Dfc22zcyOxSMVxGj05Hee5o
        4W/cBMBQYGzlBoIl5dLnu+f7hl1pUK8RoCXLeOlvIhFe3LETrjL+RZQZDiZA4Q==
Message-ID: <6950dd49-7436-ebef-eb88-940597472ce1@tavla.de>
Date:   Wed, 1 Feb 2023 22:07:30 +0100
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org
Content-Language: en-GB
From:   Martin Petzold <martin.petzold@tavla.de>
Subject: How to Automatically Re-Connect Bluetooth HID over GATT (HOG) Device
 when BlueZ Plugin "hog" is Disabled
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4P6ZHl6Cjsz9tC8
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Linux 5.10, BlueZ 5.55

I have a remote control which implements Bluetooth LE. If I use the 
default Bluetooth daemon, I am able to pair and trust using 
bluetoothctl. If the connection is lost after a while (or days) and a 
button on the remote control is pressed, the daemon re-connects 
automatically (because the device is paired). This is basically what I need.

But, I would also like to manually set notifying for characteristics 
(Report) on the HID service within my application (Java via d-bus). This 
is not possible anymore (also not via bluetoothctl) because the "hog" 
(or "input") plugin manages the input device and the related HID 
services are now hidden.

I then added "--noplugin=input,hog" to my Bluetooth daemon. Which is 
okay, because I don't need this support for Kernel HID. Great, now the 
HID services are available (also using bluetoothctl), but the peripheral 
does not re-connect automatically any more. I always have to connect 
manually first. I also have no signal on the d-bus when I press the 
button of the remote control, when it is disconnected.

How can I enable automatic re-connect for devices, when these plugins 
are disabled?

The only other way I was thinking of is to leave the "hog" plugin 
enabled and use the operating system HID interface. However, my 
application runs as non-root which makes it complicated and also I would 
like to have direct connection and control to my device.

Thanks,

Martin

