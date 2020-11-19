Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0ADC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 05:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC4F246EB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 05:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgKSFQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 00:16:01 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42089 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgKSFQA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 00:16:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D1956AD6;
        Thu, 19 Nov 2020 00:15:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 00:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadelwatson.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=AO2CRwjJdfu5W/mjJyJZANVItq
        JbZcykrD0Y22tWCgU=; b=USb7T/or/NtE5vWFhvMjip2wdD5GBFqefqF+VsWQ2w
        orrII4LW0zZvvUZ6cZY+pz0CzdjkZJ8CGHn8vgP6wtxUMyztasWN/O9725lXD821
        dpfU3aGAQXeQmRz6Gy9XJ/ab39TK4EPpYpInaTdf+CrNzCqRl+21zwqwXx7hFWBd
        vjm8r8ll5jmbLYC2kcdmjwQQiTb7OSsZEE64zKpIN/1TECYYsz3GU6H4DLSzuCPO
        3kgGLMDGwUyiLqjswWoj0oUFDBSAe8hxQp8X4qeJae9cp9Ahjh2+YXaed4rDWxSB
        mWaBkvceGFepjsZbPM6RFWCITWi5HYx5BrMs1Hio1cdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=AO2CRwjJdfu5W/mjJ
        yJZANVItqJbZcykrD0Y22tWCgU=; b=XVJUUjLxiYBaPGLdB9wNgtFs4wYkp0yw3
        IMrTdrP6OTygEvIJ3036RxOeT2oj2fx0uDIGNWLmX2vGHA+XxeygkOw45a6kmZqX
        89IoCBPw4LzATdlNiV5Pl4ahn6DamKaSZZm71KvteDi3JbRtcUuTu09uqHFgpv9r
        IQp8yoTWLjkcYrpV6mR/igUyeopkQxV30bhTtyz5RhWameLmDr3L33lKRus7DGGE
        ZGhn6F4KSq+iLO98Uk+EReocwZxb3lbUHHRtRqO1KDnGmu7pnQiHIs8eZWrFzF9/
        lXYOaigiWip8LxDU60TzgN8tGd+gJvDLxrvhZc29WKjRUpbgP/7bQ==
X-ME-Sender: <xms:j_-1X1b8CmZC_8XFeI1x0oP2xgZuqU2cuUQvWEf7gk9MQJtBGuZwQg>
    <xme:j_-1X8bQoMxN2C6hIpt4ps4e7DkXBkSIM_PI6t9jdPodaPd_RcPU3N0MypvosYVWN
    0l8exJlxamZ3DyOTgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvegruggvlhcuhggrthhsohhnuceotggruggvlhestggruggvlhif
    rghtshhonhdrtghomheqnecuggftrfgrthhtvghrnhepvdffvdefueevjeduudfgueeile
    efvddutdffjeeujeeggfefudektdejkedugeelnecukfhppeduuddurddvvddtrddvtddr
    vddtudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gtrgguvghlsegtrgguvghlfigrthhsohhnrdgtohhm
X-ME-Proxy: <xmx:j_-1X38g873V-4Mv8rLX34Phg0eXyGFrKzSchUEbq18X7c0wp3Nesw>
    <xmx:j_-1XzpcrqtCeOUCyh0dg0XkDOWo5AJRKfZ6dqj3h-zvnQQmPOF2zw>
    <xmx:j_-1Xwol1U13Rk6VUG6ASrrc9e78JnFOtWkRG-9zxW7DTgLaQEpZyw>
    <xmx:j_-1X3QuLjnfXxzrO5nW3iTfQMu8MEJ1BA3JQ2QX1xfRm4-YKfzS3Q>
Received: from localhost.localdomain (111-220-20-201.dyn.dodo.net.au [111.220.20.201])
        by mail.messagingengine.com (Postfix) with ESMTPA id 672FA3064AAE;
        Thu, 19 Nov 2020 00:15:57 -0500 (EST)
From:   Cadel Watson <cadel@cadelwatson.com>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     Cadel Watson <cadel@cadelwatson.com>
Subject: [PATCH] Bluetooth: btusb: Support 0bda:c123 Realtek 8822CE device
Date:   Thu, 19 Nov 2020 16:16:25 +1100
Message-Id: <20201119051625.2622105-1-cadel@cadelwatson.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some Lenovo Ideapad laptop models use the 0bda:c123 USB identifier for
their Bluetooth device, so load the appropriate firmware for Realtek
8822CE.

-Device(0bda:c123) from /sys/kernel/debug/usb/devices
T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=c123 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Cadel Watson <cadel@cadelwatson.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 71f62d532481..b515b17f4504 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -450,6 +450,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x1358, 0xc123), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xc123), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
-- 
2.29.2

