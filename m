Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 03:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbiASDbD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jan 2022 22:31:03 -0500
Received: from omta002.cacentral1.a.cloudfilter.net ([3.97.99.33]:33269 "EHLO
        omta002.cacentral1.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240019AbiASDbB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jan 2022 22:31:01 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 22:31:01 EST
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id 9vrontM9Qyr5HA1Zfnq68M; Wed, 19 Jan 2022 03:23:51 +0000
Received: from cartman.1045.ca ([24.79.8.194])
        by cmsmtp with ESMTPA
        id A1ZcnCgSiUcbnA1ZdnZMNy; Wed, 19 Jan 2022 03:23:51 +0000
Authentication-Results: ; auth=pass (LOGIN) smtp.auth=link_outgoing@shaw.ca
X-Authority-Analysis: v=2.4 cv=OO00YAWB c=1 sm=1 tr=0 ts=61e78447
 a=R6DsPnAC7HDsLjZ8I5uN0A==:117 a=R6DsPnAC7HDsLjZ8I5uN0A==:17
 a=IkcTkHD0fZMA:10 a=DghFqjY3_ZEA:10 a=yNFEYGdLAAAA:8 a=UUniS0OLDGPSZ3FarLwA:9
 a=QEXdDO2ut3YA:10 a=Zh8OHTSCxmIxSlm4XFhg:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=1045.ca; s=mail;
        t=1642562628; bh=8fMNLoTykZeAeRqm/pDKipcwMCLaPQPP+Jjrd3BZhUY=;
        h=Date:To:From:Subject:From;
        b=lPbsM+HRUqP/9xuAC5EI7zMLExThOTvqfEtlHK9oqlwLECth5f1vNr6Qzw2IyWvRw
         i3/8NLXBv09AY+wt0hRDlaIHxXpR/8p69Mub7DC4xbwSxYATjZ9a9IC5LpWkXbuVaT
         mpI85dmYMHLD1vOqqAqkgFudXv2ND7kX/n/+DbuDh3YYBr1PSK98r+ugsHirK5VoVX
         UqGzIvxB2MvY8JB0fKaO+BbMOAUjGwo8hdgXbz8wtab88rSN7o2G/QAmbSAT0PLt+b
         gOYolB05+uTtTE3FVE2SrEbkVo1MlhFZeK2i5sWwZ+tm7n8HE8grW5Vs/dE7rLCtvZ
         +XHjFtYugUDmA==
Received: from [192.168.1.155] (bruce486DX.1045.ca [192.168.1.155])
        by cartman.1045.ca (Postfix) with ESMTPSA id 35925139AA8;
        Tue, 18 Jan 2022 21:23:47 -0600 (CST)
Message-ID: <c821e1bd-dcee-fa4b-93c3-29279756315d@1045.ca>
Date:   Tue, 18 Jan 2022 21:23:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org
From:   Bruce Link <bruce@1045.ca>
Subject: [PATCH] Bluetooth: Add support for Realtek 8761BU Bluetooth receivers
 of ID 2550:8761
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDFRrQ6WW1N/fGRv1RyCG0E9qIBoKuSrR2j1vZEc3j2cSHKMsvBo7EUmDCjJ4fw8zFW9vdHJolMCR+Ct2CXbEv/nwDBtPp17u7Zuyk5ASnO3TqqSvK87
 Ce/TXBNSOMKfIUNW4kuIKJcIwTjo6N00ekdQlClTumr+Sy6xBHXF8E5IEtqXEO0dAfGCYQvpl/A+KldbpIiInFwd/FKsrXTPKz8p02/EPohmfORb0M+WJDQr
 9XQ9WXT3C8YCT/TTSpNUk2fRhFGovK0cYPcpQrkZ4yzAfj+TbHDEf6eVKtJoggG3727UNFWBsJQpKXOMk0I5u+0R4XJru7MF/GTkkKO1rbQ=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for Realtek 8761BU Bluetooth receivers of ID 2550:8761 by
adding the appropriate ID to btusb.c to cause firmware to load.
e.g.: EDUP EP-B2536, MPOW BH519A, MPOW BH456A

Signed-off-by: Bruce Link <bruce@1045.ca>
---
N.B. I am able to successfully test this patch on my own system, but
cannot meet the requirement of 4 other systems due to lack of
availability. I hope this is acceptable given the small scope of the
patch.

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c30d131da784..16254681e162 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -482,6 +482,9 @@ static const struct usb_device_id blacklist_table[] = {
         /* Additional Realtek 8761BU Bluetooth devices */
         { USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
BTUSB_WIDEBAND_SPEECH },
+       { USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
+ BTUSB_WIDEBAND_SPEECH },
+

         /* Additional Realtek 8821AE Bluetooth devices */
         { USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },


