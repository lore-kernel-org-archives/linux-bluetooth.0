Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3887C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCDD2183F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 14:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiNT1+My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbfAKOUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:20:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41520 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbfAKOUY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 09:20:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so6588547qkj.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jan 2019 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=zu85I6C66nnqk/ENq5KU126Ek2Bg8upKBzx3jkFwbqA=;
        b=KiNT1+MyCXHqyICmRNPZ/Lx+igao5nR75VlyvYYXvAial1BptLkhtoiywqx3vuHlHf
         aqo3bq14gN1LMV5gbPVRhx6L6ZBX5C8+/AAUqHudc7Mw0xLxmh8fG0k0/jKISLw3UW8g
         hGzdvqi5viH/Z2Cs///GqT0KbswG6vib50UmQxi8WfuwLwhU+t7+guKcrVwb1adljHbR
         ek4qSjctBpnqQNxylQStnwblcVfd1Y2E2Xxqe/5J2pyF2NU7HlhiexfkNCSPocx4WxC7
         pwj3d1cdbLwA2jOjr+knNLz/qAcpzOU5IEw0gTiQ//BJi6Mzgfo6IwzJ6eVeQ9SqHLcH
         Szjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=zu85I6C66nnqk/ENq5KU126Ek2Bg8upKBzx3jkFwbqA=;
        b=izDlHngWoKthT2Gjmx4AfUYwAsuLrtKSAxYdlpVF3Zf4IYYD8o3g4fHc/1m0YlK7po
         2vUmaFbmUe791iUgVb623UEyc4pWTWXgQYLbHb3mSY/ENTXqZTtpyEYTuD4Av41wgvr0
         Sl9s0Xs8Vcxkqx8W3eUaRnbUwFM3SyBLG++Q2ax4mKFsoYhcPtq98goREwIM98sO95f1
         fgY8d8P/OK37iYdZa6/FfozoQA6Rn1tsORUYtbHzJeXGt/0Us6NFNMgsDkZQXPPVw8Np
         vRMZIN4lXFlX0rYzIx8KHTpcJc17o0+MrS56WC56NMawUDhg23cBEdeMM8CfinjMOl10
         9b7w==
X-Gm-Message-State: AJcUukdAz2wMlpVX9C99FClC15ihR5O0ct+CcX97yFJhs+6DUOFegexc
        HYhM5mJ6OUFpZ0J6caLyS7q//pZeBIs=
X-Google-Smtp-Source: ALg8bN5awuSplAbZNscC2kv8w2xXeXL60WHUAWjuijfYWi5U4FGoKxQHQfx2ZTyGDZOHPHbOoSmnCg==
X-Received: by 2002:a37:8307:: with SMTP id f7mr12889337qkd.4.1547216422940;
        Fri, 11 Jan 2019 06:20:22 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id y70sm34673043qka.75.2019.01.11.06.20.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:20:22 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] unit: Fix fsanitize-address-use-after-scope with GCC 9
Date:   Fri, 11 Jan 2019 11:18:17 -0300
Message-Id: <20190111141817.25077-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190111141817.25077-1-luiz.dentz@gmail.com>
References: <20190111141817.25077-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Raw data payload must be copied since the declaration goes out of
scope:

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=202213
---
 unit/test-avctp.c |  2 +-
 unit/test-avdtp.c |  2 +-
 unit/test-avrcp.c |  2 +-
 unit/test-gatt.c  |  2 +-
 unit/test-hfp.c   |  2 +-
 unit/test-hog.c   | 10 +++++-----
 unit/test-sdp.c   |  6 +++---
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 60fd6ad71..e338acb07 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -66,7 +66,7 @@ struct context {
 #define raw_pdu(args...)					\
 	{							\
 		.valid = true,					\
-		.data = data(args),				\
+		.data = g_memdup(data(args), sizeof(data(args))), \
 		.size = sizeof(data(args)),			\
 	}
 
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 176852ae7..2fb6877f9 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -61,7 +61,7 @@ struct test_data {
 #define raw_pdu(args...) \
 	{							\
 		.valid = true,					\
-		.data = data(args),				\
+		.data = g_memdup(data(args), sizeof(data(args))), \
 		.size = sizeof(data(args)),			\
 	}
 
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 9ffd44cfd..ddde68d71 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -74,7 +74,7 @@ struct context {
 #define raw_pdu(args...)					\
 	{							\
 		.valid = true,					\
-		.data = data(args),				\
+		.data = g_memdup(data(args), sizeof(data(args))), \
 		.size = sizeof(data(args)),			\
 	}
 
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d8d007386..4a655b28f 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -86,7 +86,7 @@ struct context {
 #define raw_pdu(args...)					\
 	{							\
 		.valid = true,					\
-		.data = data(args),				\
+		.data = g_memdup(data(args), sizeof(data(args))), \
 		.size = sizeof(data(args)),			\
 	}
 
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index f2b9622c2..baf9e93c6 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -63,7 +63,7 @@ struct test_data {
 #define raw_pdu(args...)					\
 	{							\
 		.valid = true,					\
-		.data = data(args),				\
+		.data = g_memdup(data(args), sizeof(data(args))), \
 		.size = sizeof(data(args)),			\
 	}
 
diff --git a/unit/test-hog.c b/unit/test-hog.c
index 37d3abe3f..e257fbd88 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -69,11 +69,11 @@ struct context {
 
 #define data(args...) ((const unsigned char[]) { args })
 
-#define raw_pdu(args...)    \
-{      \
-	.valid = true,		\
-	.data = data(args), \
-	.size = sizeof(data(args)),\
+#define raw_pdu(args...)					\
+{								\
+	.valid = true,						\
+	.data = g_memdup(data(args), sizeof(data(args))),	\
+	.size = sizeof(data(args)),				\
 }
 
 #define false_pdu()	\
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 66da038cd..03501d021 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -60,14 +60,14 @@ struct test_data {
 #define raw_pdu(args...) \
 	{							\
 		.valid = true,					\
-		.raw_data = raw_data(args),			\
+		.raw_data = g_memdup(raw_data(args), sizeof(raw_data(args))), \
 		.raw_size = sizeof(raw_data(args)),		\
 	}
 
 #define raw_pdu_cont(cont, args...) \
 	{							\
 		.valid = true,					\
-		.raw_data = raw_data(args),			\
+		.raw_data = g_memdup(raw_data(args), sizeof(raw_data(args))), \
 		.raw_size = sizeof(raw_data(args)),		\
 		.cont_len = cont,				\
 	}
@@ -105,7 +105,7 @@ struct test_data_de {
 #define define_test_de_attr(name, input, exp) \
 	do {								\
 		static struct test_data_de data;			\
-		data.input_data = input;				\
+		data.input_data = g_memdup(input, sizeof(input));	\
 		data.input_size = sizeof(input);			\
 		data.expected = exp;					\
 		tester_add("/sdp/DE/ATTR/" name, &data,	NULL,		\
-- 
2.17.2

