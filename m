Return-Path: <SRS0=6SjG=PV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBA4C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Jan 2019 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0348D2064C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Jan 2019 17:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3rvcK5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfAMRXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Jan 2019 12:23:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50411 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfAMRXq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Jan 2019 12:23:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so6719599wmd.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jan 2019 09:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=ampJB510FIqLBfL1cVEd7Brw46BxrFQXsMeYrCCseH8=;
        b=U3rvcK5UpQRn33ZfBYcOM4xwTWy/h8xlW2PO+vNpDLnPxM7zLvdkhrjNiVMB92XQ4W
         amdAVPnm5eSxgA1N5Za7v3CHao/LY7op3Pae064ZkCeXwiSmbh0sVsvbuXkPFJydOJ9T
         WgZgebPcHdYOqaJgpFY3ULHAWBlORGRHXs4zp4P9trfLrcp/VlkQqv4ixCvChlaLBLzU
         OZ+jfq5/tyti6DNOALgoHeb3jkGwL3gG1PU2Bgc3xIt+vrKcQWfbG577MAgyJbLgwz4b
         j2i8I6jBZbTO1fq09JunfMbftOJlqA6gOBXhPWNw4kAWy1fnwtPwffzW1Wswt0ePVn4y
         DDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ampJB510FIqLBfL1cVEd7Brw46BxrFQXsMeYrCCseH8=;
        b=e5V5GOECwmcmoz6l41UgXpxO9ruJo9+c5IR89J3BUpNArCm4CVaLJMV6GC/X7sklOV
         07yp4zrQch7qG3w9QiK9xf9CXRsaMN0m2YW4sFgHpLfON0KuhL55xuPMXQmKgWZy5ouz
         191xEQ2istrSBPvfDPn2dP860fMEP+0JBTcO+97o8dMB0ubMzJVEkrQESOeBY4pGl2YR
         zHR2rQUaIn1Z/RujDeFZCvRI5KxcogP1A2gF/D5ioSjUct9HS44ppIe8Q2u2/aPqBwXi
         r5FvjcgIfkFmj5eQPpzrwTKrub4zSDKtSmrv/f5mLeRTG3yfbo8RNe09xdCmStPfoD+i
         siCA==
X-Gm-Message-State: AJcUukcin/EX4H5wBOF47/FVYS/fjK+n93e++4dDqAEeW602HxCLre9g
        YskyeZDnxEgDtTd9/ajurTFL1znm
X-Google-Smtp-Source: ALg8bN5ph4p7IeFcWuKHet5juOZ8vEAvZuK4soPBPATiF6L4lzNebykNKjmdW+uAe79AInLCoOnzEQ==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr9412024wmh.87.1547400224193;
        Sun, 13 Jan 2019 09:23:44 -0800 (PST)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id s66sm20207317wmf.34.2019.01.13.09.23.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 09:23:42 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] btmon: Fix parsing A2DP FastStream codec configuration
Date:   Sun, 13 Jan 2019 18:23:20 +0100
Message-Id: <20190113172320.17586-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This codec is bi-directional, therefore both sink and source directions may
be present in configuration at same time.

Some Creative headsets send more frequency bits in configuration and when
both 41kHz and 48kHz are present then headset expects 48kHz. So adjust
FastStream frequency table as find_value_bit() takes first matched bit.
---
 monitor/a2dp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index ffdcbb962..42fe395a1 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -201,8 +201,10 @@ static const struct bit_desc faststream_direction_table[] = {
 };
 
 static const struct bit_desc faststream_sink_frequency_table[] = {
-	{  1, "44100" },
+	/* in config buffer, there may be more frequency bits
+	 * and 48kHz takes precedence over 41kHz */
 	{  0, "48000" },
+	{  1, "44100" },
 	{ }
 };
 
@@ -746,9 +748,9 @@ static bool codec_vendor_faststream_cfg(uint8_t losc, struct l2cap_frame *frame)
 
 	l2cap_frame_get_u8(frame, &cap);
 
-	print_field("%*cDirection: %s (0x%02x)", BASE_INDENT + 2, ' ',
-			find_value_bit(cap, faststream_direction_table),
-			cap);
+	/* FastStream codec is bi-directional */
+	print_field("%*cDirection: 0x%02x", BASE_INDENT + 2, ' ', cap);
+	print_value_bits(BASE_INDENT + 2, cap, faststream_direction_table);
 
 	l2cap_frame_get_u8(frame, &cap);
 
-- 
2.11.0

