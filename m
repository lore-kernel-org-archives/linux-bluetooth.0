Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B5FC433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 00:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD166142A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 00:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhEAAiN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 20:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhEAAiN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 20:38:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2AC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 17:37:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l10-20020a17090a850ab0290155b06f6267so2597837pjn.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 17:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xaAqXVJt3IJ9Op/EuI3fxPeDdV4te1AM/AzwiU4Fafc=;
        b=l3uO2DIa1AUg+9Ge9nUuGCjkDSVharQ/SZXrWbkA8DUqa3XsayaHJwvl9/kd9GjlJc
         rwUGrtbKJr1b/kjimBVGGaDmSuSmy6ZkgKsdlx245waUByDcUzwFuMXdHpcavi3II2Rj
         otqgd7o9k1XeXiZquJIAxNiWCRgoq9QujABFFvk7OAskWE+K0KnT6dciFPCNUaS1jxrZ
         3ZlqGOjb3aT0DnFoTDtTpNKRt11hHX9R7f92oSQa5+/NR5GfQAWxy3UeNf5g5g0E76WR
         +KOFGfWj4aWVxGEjWZA5Yy5/m43YcG7ubg9B205Wqrqq2Y6JdiznYRH2Il8YUlDz5K1N
         kEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xaAqXVJt3IJ9Op/EuI3fxPeDdV4te1AM/AzwiU4Fafc=;
        b=sFTLI1hglGXdblChGlafjhArdBNCrMS2wmO6Won2gv177mDAHWsDHGHx4GFQy77oVL
         v0RQ3D7dsVxHzeYi6hnEcGqdrMsk2+3GYPSORKohYtV6wBm/yJGRkLsW9IYoQrdljpHa
         pq7a8wuyo3gAvVM0L+3ku5TgIkeqrXzH/cDelyROpqMw/srFiUoeYB8VpZBkSaevCpOs
         F39YCif/BCjpc7nYpJleYdC0FeWbWJbje3hEQ1IWLZUf/iPZZOU5feAnljvNcBYgAUP5
         A/zm51vAJ0l0k+7kGd7Li1U6lxdEExjPRGtK/A2O13o3yXxPWsW2MxkUqqy5hwKqGW8q
         D5IA==
X-Gm-Message-State: AOAM532yQwF+LxV8iaMxU01y7/A0rXjQSGQV1MXR2ddg3muWdEg7ce6b
        oNZdaYjr+H7e6CckqA3aBim/P/md/eeRwg==
X-Google-Smtp-Source: ABdhPJzWV6SEeeFk3P80PCOkUo7vCut8jViio7rvnllOnTaij2WwxDRUOcoWbUYCi6skZOsXRBGsZQ==
X-Received: by 2002:a17:90a:7063:: with SMTP id f90mr8875647pjk.95.1619829442740;
        Fri, 30 Apr 2021 17:37:22 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h76sm2198410pfe.161.2021.04.30.17.37.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 17:37:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] monitor/avdtp: Fix decoding of reject type
Date:   Fri, 30 Apr 2021 17:37:17 -0700
Message-Id: <20210501003717.7553-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210501003717.7553-1-luiz.dentz@gmail.com>
References: <20210501003717.7553-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Reject type was not being decoded, so this remove the early return and
leave the callback to decode it:

< ACL Data TX: Handle 42 flags 0x00 dlen 8
      Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 2 nosp 0
        Service Category: Reserved (0x00)
        Error code: BAD_ACP_SEID (0x12)
---
 monitor/avdtp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 9fe72d240..1393d1286 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -715,10 +715,6 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 		return true;
 	}
 
-	/* General Reject */
-	if ((hdr & 0x03) == 0x03)
-		return true;
-
 	switch (sig_id) {
 	case AVDTP_DISCOVER:
 		return avdtp_discover(avdtp_frame);
-- 
2.30.2

