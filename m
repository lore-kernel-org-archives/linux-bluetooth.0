Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CDCC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050A861285
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 19:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbhERTBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 15:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351807AbhERTBO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 15:01:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46058C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 11:59:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11so6044626pjm.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sSW+RyQ8Xex5bb4BksaMTfUcNVjBzcIKNLpeNMKZk5I=;
        b=FmFHMURZYcBaFjvK21PMWN2TS4tjNR3gv5fYg+Y/7A+fY49DBApbc4l45d8mb1+HvD
         HfFK/xCGvGvS4XRUDK07V61tBrJzh+WIXEzTO7pqUpI0jdq4areWxAz7YX1rhzIn4bhd
         4muZlWgnvHA46i3J88WoLXH5S5cneiiAZ8/Bd35WIUABXsbiet6+1yUZol8wYB20RDZp
         6HvwV72FpxLdoIHSw7Tg4kVSfsyL5Mxt9J/k2BiG2udjMBbTx1+3SyKufsBZWmQi0qNz
         CirMwpu5W/gLSbFg/aULcuydaDUMaJSMzqtBY0Gh4vFlRf4SL3OD44yeDlnj+Mpv57+p
         tYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sSW+RyQ8Xex5bb4BksaMTfUcNVjBzcIKNLpeNMKZk5I=;
        b=pAmQfrb2YVSFlic9IMyZIr1CXeBGE56AoNzM+6Yvtsofp4e7JocLm4+snablSncUd0
         HRy5HZoPmvJ9P114+w5tEBm7Q6EmLedUBbTPERMLyIBxYopKK59QkFGw6zuxKJKIJnqi
         /tEM7XW8hAuIbnjrAqkRgow6wLOk3uASX6yq/SMahsbpFzdJ51Bhp8cPYpo6KP1o2OTO
         A/D3fLUTuylApiMLuFG5n6BS9O4dMEFwN9qwykWewxSntvt/MUGOQJitv+yE+cyGW3Uw
         h+6K9h5x+SHD8C7DYQjNYYyhjLE0lr2FAfZZBXV3SgtVkEQYWpbnrFT+Y994yGlfcVPa
         NUhA==
X-Gm-Message-State: AOAM5329IAHSc7xR/Y4y+WL0RoF68Zcaa0thnICx5t/ja+6zpmcUDH5+
        DVjUyidE+HreWkqIrvMJWlqijvFVZ0ZC4Dzm
X-Google-Smtp-Source: ABdhPJxVcS6QNpnegrFtZrmMr54BgP9pF6CgzMLbt3X0dAvtDtoenRUdR1oqtIS6yHxc2hVxRn0E9A==
X-Received: by 2002:a17:90b:703:: with SMTP id s3mr7180527pjz.69.1621364387426;
        Tue, 18 May 2021 11:59:47 -0700 (PDT)
Received: from u0b6eedb2c9435b.ant.amazon.com ([73.96.106.178])
        by smtp.gmail.com with ESMTPSA id q18sm13111201pfj.131.2021.05.18.11.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:59:46 -0700 (PDT)
From:   Daniel Lenski <dlenski@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniel Lenski <dlenski@gmail.com>
Subject: [PATCH] Bluetooth: Add a new QCA_ROME device (0cf3:e500)
Date:   Tue, 18 May 2021 11:59:38 -0700
Message-Id: <20210518185938.322908-1-dlenski@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the 0cf3:e500 Bluetooth device (from a QCA9377 board) as a
QCA_ROME device. It appears to be functionally identical to another device
ID, also from a QCA9377 board, which was previously marked as QCA_ROME in
commit 0a03f98b98c2 ("Bluetooth: Add a new 04ca:3015 QCA_ROME device").

Without this patch, the WiFi side of the QCA9377 board is slow or unusable
when the Bluetooth side is in use.

See https://askubuntu.com/a/1137852 for another report of QCA_ROME fixing
this issue for this device ID.

/sys/kernel/debug/usb/devices:

T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e500 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
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

Signed-off-by: Daniel Lenski <dlenski@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d603ef39..ba339e074 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -270,6 +270,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe500), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe09f), .driver_info = BTUSB_QCA_ROME |
-- 
2.17.1

