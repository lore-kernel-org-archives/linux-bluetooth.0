Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7BCC63777
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4B92240A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeqEqAmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgKTUHa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgKTUHa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:07:30 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BDC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:30 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q34so8209739pgb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=5K2z/gPk9a04YuZK6k3j8tBO+dwk4PTXBCcUW0nAKAk=;
        b=jeqEqAmVbTjKTNLS37nRG2RZipo9BOsBMGDdpMds5zOfz2mRo7cL8z4cVL4+sTKeN7
         w8u8FG1imQyEdpgKGLR/46lK0PEk8JfVxfVUI+YmzgmFV/FhCqT3R4MR2Zk43qdO9nL8
         IIdHFo6srl+ZkqoqVZjCU/3fLVLXU2utYumAz3Vp19BPu7MqBtSCKmU6Zjx6/Ifncbbu
         7YIO19PkViq2vrQn2y8Fjdt3ZZ5WzLAzoa6yz0VNBlgDdN90tzGM4Xj+oI+ECBQ4poyy
         OqeS+mBh+rmAcAtVehn5oqGjPw2r3WpVrD+cv7eU+04KGrqJp6jrobC74tpDAHWFdvZl
         x/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=5K2z/gPk9a04YuZK6k3j8tBO+dwk4PTXBCcUW0nAKAk=;
        b=r/u/d6mOSvpBWCaZrpSpvlk1UBeFR7zIhK0ob23BHUUi7EVoqsyB0Sfjy0G4YgPvg0
         YG9tgm0y2hnS+5vxJXEY92/q85f2iFY+Lk1++M7MZO972H0eAWPKuAYzJ+9twITRlqKi
         81saF6NelcyxfqheC29qQB91aNGJ/nOC5K59yoD9I/488Ul2Bq/M310hxKshRRVBUUjg
         8ZWhVcbEhXwyhciFjjkraPOqcql0eYsneLpNcXnUzqwmH9xIyVelxsUdWhyUeCAUsaBs
         9kQdx+GqimVYNcOp+Deal8H2vQMRdfYjZFepql68c67FUC4S2DA2AYEwQCGfgfCMekW7
         ARsg==
X-Gm-Message-State: AOAM532iM2TyOovyo5n1/DlKyezO5D1BZIfELmGsPgtl9NcoeKOG+gZs
        1FQIwPwjYTvn2Zdiiv3KePQseXY/udCRzQ==
X-Google-Smtp-Source: ABdhPJyd1AipFHnGe///Gy3kFPpbFVKf4+d7XhwT86pHKqMcK8BgfXreLs0+5WHeSy/1Z30/zL5d/A==
X-Received: by 2002:a17:90a:a81:: with SMTP id 1mr11682011pjw.165.1605902849703;
        Fri, 20 Nov 2020 12:07:29 -0800 (PST)
Received: from han1-mobl3.jf.net (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id t5sm3979267pgt.15.2020.11.20.12.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:07:29 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     tedd.an@intel.com
Subject: [PATCH 2/6] monitor: Fix the unchecked return value
Date:   Fri, 20 Nov 2020 12:07:08 -0800
Message-Id: <20201120200712.491219-2-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201120200712.491219-1-tedd.an@intel.com>
References: <20201120200712.491219-1-tedd.an@intel.com>
Reply-To: tedd.an@intel.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the unchecked return value.
---
 monitor/a2dp.c  | 30 ++++++++++++++++++++----------
 monitor/l2cap.c |  3 +++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index ac2e1a228..f6e99ab26 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -364,7 +364,8 @@ static bool codec_mpeg12_cap(uint8_t losc, struct l2cap_frame *frame)
 	if (losc != 4)
 		return false;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	layer = (cap >> 8) & 0xe0;
 	crc = cap & 0x1000;
@@ -372,7 +373,8 @@ static bool codec_mpeg12_cap(uint8_t losc, struct l2cap_frame *frame)
 	mpf = cap & 0x0040;
 	freq = cap & 0x003f;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	vbr = cap & 0x8000;
 	bitrate = cap & 0x7fff;
@@ -414,7 +416,8 @@ static bool codec_mpeg12_cfg(uint8_t losc, struct l2cap_frame *frame)
 	if (losc != 4)
 		return false;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	layer = (cap >> 8) & 0xe0;
 	crc = cap & 0x1000;
@@ -422,7 +425,8 @@ static bool codec_mpeg12_cfg(uint8_t losc, struct l2cap_frame *frame)
 	mpf = cap & 0x0040;
 	freq = cap & 0x003f;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	vbr = cap & 0x8000;
 	bitrate = cap & 0x7fff;
@@ -466,19 +470,22 @@ static bool codec_aac_cap(uint8_t losc, struct l2cap_frame *frame)
 	if (losc != 6)
 		return false;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	type = cap >> 8;
 	freq = cap << 8;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	freq |= (cap >> 8) & 0xf0;
 	chan = (cap >> 8) & 0x0c;
 	bitrate = (cap << 16) & 0x7f0000;
 	vbr = cap & 0x0080;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	bitrate |= cap;
 
@@ -509,19 +516,22 @@ static bool codec_aac_cfg(uint8_t losc, struct l2cap_frame *frame)
 	if (losc != 6)
 		return false;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	type = cap >> 8;
 	freq = cap << 8;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	freq |= (cap >> 8) & 0xf0;
 	chan = (cap >> 8) & 0x0c;
 	bitrate = (cap << 16) & 0x7f0000;
 	vbr = cap & 0x0080;
 
-	l2cap_frame_get_be16(frame, &cap);
+	if (!l2cap_frame_get_be16(frame, &cap))
+		return false;
 
 	bitrate |= cap;
 
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index ca1997a0c..f16f82532 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -3243,6 +3243,9 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 		case L2CAP_MODE_LE_FLOWCTL:
 		case L2CAP_MODE_ECRED:
 			chan = get_chan(&frame);
+			if (!chan)
+				return;
+
 			if (!chan->sdu) {
 				if (!l2cap_frame_get_le16(&frame, &chan->sdu))
 					return;
-- 
2.25.4

