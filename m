Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F37C11F7C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A4E61921
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 07:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbhGLHpd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348593AbhGLHlH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 03:41:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAC3C022593;
        Mon, 12 Jul 2021 00:32:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z12so13273584qtj.3;
        Mon, 12 Jul 2021 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7516QFKCbONFu1K4UM0Mfb3rZBvmchK7pEHlv8tiP/s=;
        b=mszEFKbKWeSyvVifSeriXR9rZ/pP1xKlJ1f9aqWHLsS9QilBHOzMbxSVcxTYO/ORTX
         fKW3ZRa2hH9EoQETxAARImaA5+BbHDOQcsTyfTd8PiOZyCi4oo17USOvj1Dhu/ECKj4C
         7JokpZHgNdsGD5h3SkvSfmsAZ94tNbr1DYbNcCLc+PHMkllsCaRrEa5A3BcMUs1HfziK
         64rckuHCtvBWsAZfMhIiT8cA61vvdAI+81JcE6hRnYqzEJmERECBFI8sb+kYvNF30WW8
         l+Sxfj7224hfw66/kMH9fhkjt34rtKmufNox/qCDdf/KQ2x1fK4Fmpz5ud6EOHKOFlG1
         Md6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7516QFKCbONFu1K4UM0Mfb3rZBvmchK7pEHlv8tiP/s=;
        b=kcOL52n0GASLnG4YJt33cpVho87MhbiM0CEWg4ESrYXIcC0JH4is+pKShXI0R5iztd
         jurNpxU/H9mY3sewpQ2o+WQ4DAac1xUhj0k5LsYvgO+59NzPs2yWULM0ZTGk/u1FcAnL
         bISjYag7hOE6yFyInuxHNYhdMZ7gqbQl3+MUXTG+GkrVBn47nxtU6jrFjRsuQi/Bfy3i
         dp5Y0LboLmptmsQU4VbNfh80LL8CwanFm7T4Za6RCpoGMhteSYKg/cPGBrM1YScb0b3m
         mZEzFpDrTMr0AvJeKaxvqF/Q8xPcik0Pa8CR8TzrlqW+PKRIOgckA+/cgGpWih4eWAi0
         6Qlg==
X-Gm-Message-State: AOAM532j6ZD4TN53aRpTRS6M3hCECvrlnMRmZfTag1gaIkTU9F78X33G
        yHk2Sm6QQgsrmIil59BGKI3Fi1ZTvcN9RA==
X-Google-Smtp-Source: ABdhPJztwwA6gBbpAgnr9bsX/jzhs+KGYK2+qzRHsVjmFIVLg5t6C11wlA9R8SRUWkhQNIzXIiaSgQ==
X-Received: by 2002:ac8:74b:: with SMTP id k11mr19647039qth.19.1626075171270;
        Mon, 12 Jul 2021 00:32:51 -0700 (PDT)
Received: from localhost.localdomain ([194.110.112.30])
        by smtp.gmail.com with ESMTPSA id o18sm1654750qko.63.2021.07.12.00.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 00:32:50 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        matthias.bgg@gmail.com
Cc:     Forest Crossman <cyrozap@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btusb: Add support for LG LGSBWAC92/TWCM-K505D
Date:   Mon, 12 Jul 2021 02:32:20 -0500
Message-Id: <20210712073220.200414-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20201021030521.1121268-1-cyrozap@gmail.com>
References: <20201021030521.1121268-1-cyrozap@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The LG LGSBWAC92/TWCM-K505D/EAT64454801/EAT64454802 (it goes by many
names) is a combo WiFi/Bluetooth module that's used in several models of
LG TVs. It uses the MediaTek MT7668AUN, which is already supported in
btusb, but this device has a non-MediaTek VID:PID pair so to get it to
work we just need to add it to the list of devices to probe.

Device from /sys/kernel/debug/usb/devices:

T:  Bus=09 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=043e ProdID=3109 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
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
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---

Changes from v2:
 - Specify device with USB_DEVICE again, to match the other "Additional
   MediaTek Bluetooth devices".
 - Add BTUSB_WIDEBAND_SPEECH and BTUSB_VALID_LE_STATES flags to the
   driver_info, since this device would otherwise have them applied were
   it not for the non-MediaTek vendor ID.

Changes from v1:
 - Added /sys/kernel/debug/usb/devices info.
 - Specify device with USB_DEVICE_AND_INTERFACE_INFO instead of just
   USB_DEVICE.

---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..d644e704a460 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -410,6 +410,11 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Additional MediaTek MT7615E Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
 
+	/* Additional MediaTek MT7668 Bluetooth devices */
+	{ USB_DEVICE(0x043e, 0x3109), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+
 	/* Additional MediaTek MT7921 Bluetooth devices */
 	{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
-- 
2.20.1

