Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6031EB8FAF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 08:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjIFIsQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 04:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjIFIsP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 04:48:15 -0400
X-Greylist: delayed 959 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 01:47:58 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D876910C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tmJhS
        KuGPCps3pxGDV+8fu4pl00yW9H10nfqaenC7JE=; b=GrEg3Ib/QiFfcSBZD+X0Q
        3eaealIG7jQSXv61MY4HU4sE1EI7DOoHoL+q+Drlr8wyqot6OqesH2GY/fmHUGuu
        82wfXAuOUejiIwRhoZPZA8//bXz7npCuzAoNPfrY0yGzAlM+h+waDMIa0pxsdzaj
        3JLB9lTHzCJDXwexPT3kMA=
Received: from wangjingyang-redmi-book.. (unknown [223.160.128.242])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wBnN+X1OPhk9Rm5AQ--.29951S2;
        Wed, 06 Sep 2023 16:31:50 +0800 (CST)
From:   Jingyang Wang <wjy7717@126.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyang Wang <wjy7717@126.com>
Subject: [PATCH] Bluetooth: Add support ITTIM PE50-M75C
Date:   Wed,  6 Sep 2023 16:31:47 +0800
Message-Id: <20230906083147.25298-1-wjy7717@126.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnN+X1OPhk9Rm5AQ--.29951S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1ftFWxtFyUJr43CF4UArb_yoW5Xr1rp3
        Z5J3Z8Zr1Sgr1jg3sIkr18AayfW34xu342g3WDGw1fXFZ3Aan7JF1UArWfXr4vkr4fK3Z0
        qFnru3yrKr1UtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zinYFtUUUUU=
X-Originating-IP: [223.160.128.242]
X-CM-SenderInfo: 5zm1llirx6ij2wof0z/1tbiihrim1pEEuAerQAAs2
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

-Device(35f5:7922) from /sys/kernel/debug/usb/devices
P:  Vendor=35f5 ProdID=7922 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Jingyang Wang <wjy7717@126.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 499f4809fcdf..23590c9315ca 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -644,6 +644,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3804), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x35f5, 0x7922), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.34.1

