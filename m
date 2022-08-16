Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64DEC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 21:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiHPVfb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 17:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbiHPVf3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 17:35:29 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85DA8B985
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 14:35:28 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id x10-20020a4a410a000000b004456a27110fso2009138ooa.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=aAt6P37pBqhIVywXLS+9ui3hd3o2tnrW2ZpidF50UMY=;
        b=g+iPAxCEX6ruLbw2ZXYnz50pKU3L59xjM+FcYtmKFrLeO+7zRmcz+yvFB04uZ23DjH
         J06cwcjSPFP08P5l8AUcgby2nDVXnGo9cNus83eCqogIORIwGHEyIwENLD1IX8Wm1xuB
         nJVuY24mAb0A2lMzAMBkFiGUdhUm6MostDnITX/xp39mhQvKNOtPmLFWU29sls7y9UGm
         2Ts6V4kz2mJ2rHQjHlTP9i9TUdhRO1urdPh89C/iwS0ebI0Pq6/6QZokGZE+vrp9WoSH
         R5KVq6N1XoOOCK41J7lT7mbgEoW8Wg6nK3NKfUGgRSmucxtvnckTSO+xCFZFq/MErJPl
         1rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=aAt6P37pBqhIVywXLS+9ui3hd3o2tnrW2ZpidF50UMY=;
        b=RZhrPApcFISat6Xf9R3fkQg5IFmWVaEWlk+zDj2rjdiyTseN0qLMor7LxvOuDdyHLo
         SiEGUUwhqFew18dooalmmdZdxDZfgyVCbTyi/hyL+2bYvpHzkYhroKbLWuSziAjdJBM+
         rwoaryjTm3Oy0LtB7/AqQKwVMVoAdeMBK7vZv2Lo1B4vMDJzuHLGZWHY9pJgnyXAVT1e
         I87G5ryIvoFFmgjqXgJoFoS2YfdK0NmxKfukqKaFV1ZSToaniS1pBsy6w6rRMJURC62z
         AgkNjIbMfPv88mbaNCKmNrJ2nUn+BlX+1w6pIquQh9FrgD7U04Gs40D5HOu3n5QbBLIa
         KhUA==
X-Gm-Message-State: ACgBeo22ILDVVjwsMAXF8s1grq58/hhqqN4LGY8fKgktfTrXlNH1BcV1
        j2HQsc6gRnwkxwmeFA7Ua+c=
X-Google-Smtp-Source: AA6agR4WCEEDY9RCncCuAbPFN/GBzwpZ2pzlzDroRwgjrq//CldY3aRd3l1kdgUN9A6gT1bKSeLu2g==
X-Received: by 2002:a4a:4b47:0:b0:428:f03a:56a6 with SMTP id q68-20020a4a4b47000000b00428f03a56a6mr6973116ooa.85.1660685727869;
        Tue, 16 Aug 2022 14:35:27 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l6-20020a056870f14600b0010c5005d427sm2325240oac.33.2022.08.16.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:35:27 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/2] Bluetooth: btusb: Add BT device 0cb8:c549 from RTW8852AE to tables
Date:   Tue, 16 Aug 2022 16:35:22 -0500
Message-Id: <20220816213523.5207-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816213523.5207-1-Larry.Finger@lwfinger.net>
References: <20220816213523.5207-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A new Bluetooth device for the Realtek RTW8852AE has been noted.

This device has the following lsusb output:

Bus 001 Device 003: ID 0cb8:c549 Opticis Co., Ltd Bluetooth Radio

The pertinent part of /sys/kernel/debug/usb/devices is as follows:

T: Bus=01 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#= 3 Spd=12 MxCh= 0
D: Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0cb8 ProdID=c549 Rev= 0.00
S: Manufacturer=Realtek
S: Product=Bluetooth Radio
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 15caa6469538..33e8ff6e0d13 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -426,6 +426,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x4006), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cb8, 0xc549), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852CE Bluetooth devices */
 	{ USB_DEVICE(0x04ca, 0x4007), .driver_info = BTUSB_REALTEK |
-- 
2.37.1

