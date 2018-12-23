Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D429C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DB221783
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7XMoOxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeLWKku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:40:50 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36511 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeLWKku (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:40:50 -0500
Received: by mail-wm1-f44.google.com with SMTP id p6so9630730wmc.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=YQiU8fcEsvx/VUy500Aj8TV6X3EszmeRpjRiKkgjfoo=;
        b=C7XMoOxBYWlwT7eY7MKhUbveLwlUzxAZ2n5a1l5sjnXyawLPkr+OKoXAVxQHsBjSF7
         DooEpnFbcx4mfeHFKHONGjIkwgRHO/b3FEQXxnLqqS/V4OhyTb3QoOeO3NfNzwjHRrAy
         SsRUtnB3X5y0KirMaMD2atsN0bj6xLy1UaW1aX7Qi7OagsnQjC2zoodrL5yPl8IGTb15
         5bvV9xqLy1zF3vMDt+dSwp9laFatGvrIyrVD6NYIyUaqUEP8K86OHituO9va9oe/V9Ma
         Ck4fYUn+KSzYwi0qcYd7eUx/5VbeXP/M2Xt57J/igpNNOcaIjaivHh946/wTZSOumZpc
         +viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=YQiU8fcEsvx/VUy500Aj8TV6X3EszmeRpjRiKkgjfoo=;
        b=Yw68UqvC4/endGhxhwmQ7FjW53VRZZylw0aCC2VAEO6r9mfAVtByCWw1bbXbQGbFFC
         2amFgpI8TgRfXUAsdti+BcK4n5n65aDFtfjb+Dr3eyr4Of5CQJMmvhlxaoqLEFVMm10E
         +WMzj0KG18/iqHDbQB/+dAZ6+SxHwXxkAh2sCwaFUf3eELvS/ND22VNp1IdOUG44PfE/
         cdyFBvk11C4aCnzmkN9Dru7P4GdqmLhQ6MMDdnEeOsqz755BhFc+oGddfmSX66yxYUnr
         YquLdj4leC/jiZz3dLn7Wk+xgqMhUo+aSvHnkFr5Q9mQ/zyH70e60LBxuitWOMlufY09
         glWA==
X-Gm-Message-State: AA+aEWaYz1Or9uY2WUziKyyTuB99mYtvcPEDdoMW29cSH9TAIxYH1sed
        fd/DkJLmkN9O0KiA9Eg0jZKVqMVPLzQ=
X-Google-Smtp-Source: ALg8bN79FZHT2643EJ3yC0OW0IsltGVA62PzPGfGuu8v5i0hIH6Rj3IYN1navHRBmJ1Or7UA6ZdLPA==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr9485793wma.114.1545561647947;
        Sun, 23 Dec 2018 02:40:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:47 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] a2dp-codecs: Fix codec id for ATRAC
Date:   Sun, 23 Dec 2018 11:40:15 +0100
Message-Id: <20181223104021.18620-5-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to Bluetooth Assigned Numbers for Audio/Video ATRAC has codec id 0x04.
See: https://www.bluetooth.com/specifications/assigned-numbers/audio-video
---
 profiles/audio/a2dp-codecs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 205491939..25959902c 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -25,7 +25,7 @@
 #define A2DP_CODEC_SBC			0x00
 #define A2DP_CODEC_MPEG12		0x01
 #define A2DP_CODEC_MPEG24		0x02
-#define A2DP_CODEC_ATRAC		0x03
+#define A2DP_CODEC_ATRAC		0x04
 #define A2DP_CODEC_VENDOR		0xFF
 
 #define SBC_SAMPLING_FREQ_16000		(1 << 3)
-- 
2.11.0

