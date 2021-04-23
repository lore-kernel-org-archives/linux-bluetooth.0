Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3FFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 13:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF5B8613C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 13:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbhDWNTm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbhDWNTl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 09:19:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9ACC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 06:19:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso1220388wmi.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcJQOoJVR0w+m1G35oPVG6rseUmCfvmJllalTAfhUrw=;
        b=VVGB91oGuYuxt5PLZjZEPF/hUh7SI4RA7tW4qb+3W4cAw7w8+XhrU+NN1dsOsYGsQV
         WWumFkj8lnBf2fQdwBjtgdySpZcAl9fj9GAwEAf3A67rEFAgXPR9uFjPQ5k45TvsetwB
         m/Pa4B4iKWRrvemGFL4Jn0W/2QeUQZDRGhF5fHiPx24kwnBPQTGP3VxJheAgkKYlxs7m
         j4V0oku0/yZNfB1i2I5EkKCV4lhoGPU1Qx7j3eK0FhYlLPaEIpU0NUwQ0VU0qwf9vTeB
         DbBDw0WmsBzMfL2g5WOXpVunVym7/bPUTz2aCOV40zaagq7jFedfD3c/J18X+GRyN3XT
         NaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcJQOoJVR0w+m1G35oPVG6rseUmCfvmJllalTAfhUrw=;
        b=K63yOs1POnzcmpk1eWABEHAjySZGu1gfWGNZjCjmoow/3ZdnM+yF3EoP0XHVWU/bXC
         EUS8Lu/vkWcm7KmKUo8aRNuOZTghBiH9FISVMnwAyRgAAJqUf89LC+C7eG5z2iV5R+8x
         Ko+lnU8MGDNTDDyIAvhisGR0ih5LsLbcRumpZ2xO1fgqbkkaFQQoWaIdxLsUt7/kwM2W
         oRLlAaedolXp6OgyzkSFMFq506q/fIOLVPVPs43bw99Ayb+YktcfQMHUP/Fky0gC6aDZ
         xO5/koV+POX64bvZFZPJ6Wj+YOWlGq4y4fsB8oV4WFfln0Ul5TzYxF1oxB3CLBsdnXp3
         H3uw==
X-Gm-Message-State: AOAM531aslnf5/yAAmFWsnWdu7mZArJyDrfGltPJ0mJdpr1BnqqJ3CWw
        l/zIPJtcrVY51hSSjo3GwQS1CevZDw3mKA==
X-Google-Smtp-Source: ABdhPJzRagQEWPTwpSEgRHt7RQXFP3C3xGDhqPNbi2j8IwLzD0QeK3UNWBGEypr3snlIWX/9Gn3Czw==
X-Received: by 2002:a05:600c:35d1:: with SMTP id r17mr4215251wmq.71.1619183943103;
        Fri, 23 Apr 2021 06:19:03 -0700 (PDT)
Received: from localhost.localdomain (84.red-88-11-91.dynamicip.rima-tde.net. [88.11.91.84])
        by smtp.googlemail.com with ESMTPSA id b12sm37666783wmj.1.2021.04.23.06.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 06:19:02 -0700 (PDT)
From:   Ian Mackinnon <imackinnon@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Ian Mackinnon <imackinnon@gmail.com>
Subject: [PATCH] Load Broadcom firmware for Dell Bluetooth device 413c:8197.
Date:   Fri, 23 Apr 2021 15:18:52 +0200
Message-Id: <20210423131852.33631-1-imackinnon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove the btusb_table entry for 413c:8197 so the device is handled
by the later Dell vendor entry, which specifies patchram loading.

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8197 Rev= 1.12
S:  Manufacturer=Dell Computer Corp
S:  Product=DW380 Bluetooth Module
S:  SerialNumber=74E54354F609
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
---
 drivers/bluetooth/btusb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5cbfbd948f6..2d24231f898 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -119,9 +119,6 @@ static const struct usb_device_id btusb_table[] = {
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
-	/* Broadcom BCM20702A0 */
-	{ USB_DEVICE(0x413c, 0x8197) },
-
 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
 	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
 
-- 
2.25.1

