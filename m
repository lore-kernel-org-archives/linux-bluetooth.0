Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF75C004C9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3B2075C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3Pyjkys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfECJpC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 05:45:02 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40873 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfECJpC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 05:45:02 -0400
Received: by mail-lj1-f177.google.com with SMTP id d15so4685207ljc.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PKfHLwdp3HTpr4wDPj6GvUhL8qlD/m+3Q24qyqOWALo=;
        b=Y3Pyjkys0IWiUa2RNNQEtYs2qZKLrYYwon6I+CBCbCqItFctFz8Yxy4xKHuvR7d2Gr
         cDHzSbaV3P4x93/5fxz5tzsZgA5XvJxXf7pndXQSCdI67WF34gb/kj5nkPG/hgwlCCMm
         jK/0jQdprnsOOrJ2USMpWgif8Y9dKHVVKmbMlHrk67PAR1GvYA2HHLAFPdZ/8lrmMA2/
         LRHiwTq3Y5LJzv8WLkeCinaDiAayfjv1tdHliBpNERPXOmBd3FIcT5WhrLfxk7uHZI8D
         pTFTNx2DERM6+Zw3DgZUjB2MzVAmAbqonCgYgfm2uV986/XpCMWANlPrgJ71hfXG2QtZ
         ZzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKfHLwdp3HTpr4wDPj6GvUhL8qlD/m+3Q24qyqOWALo=;
        b=koiKtilSHM6S8xBFsG05sYJ1iqO9AjyKMP/uVTEGLXxpLh4TPMlNC4UANVk+GtTE1k
         ktU1NLi0GeY62G9XLlJpbWzhc1ro1s6tTDMWlz9QigHxuvMEJRw5Fi88s6t+QvjWHSyo
         DQtX873AhklWJUw46sHa5tW1p85SaH08ebm1ZicVBlexV6EH4sHrTM83gALVbY5EoE13
         /Jxf4er/sY3J2z5ExpBVnqhJLz7q0W5XWijRIbOLd9az9j0ypx1lFRTNBa/oA+u9ahti
         zy9+n975dBAiX97QKJXDgiwpam4GsvFKk9636e8gA54pZsSESgYmkLFd4fkV2XMGPIW7
         HwLQ==
X-Gm-Message-State: APjAAAXgO7N2ZnRWY3gkV4/gWAit6dk/3ngY9HJwIe/enG8HXpn7JlLP
        ISzJWRetjgOUStQBpFnbj44sxZGAoK9EkQ==
X-Google-Smtp-Source: APXvYqzeG0/dT2D5oadLOOPCD908nnTBadOhW8QkE7rMUYqlGlcUeKnQVzF7YTj2jDPP2RUx8ODZjA==
X-Received: by 2002:a2e:6510:: with SMTP id z16mr4484238ljb.185.1556876699432;
        Fri, 03 May 2019 02:44:59 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id e19sm376455lfd.36.2019.05.03.02.44.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 02:44:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] a2dp: Update last used on open indication
Date:   Fri,  3 May 2019 12:44:53 +0300
Message-Id: <20190503094454.23774-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503094454.23774-1-luiz.dentz@gmail.com>
References: <20190503094454.23774-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates the last used endpoint also when receiving an open
request from the remote end.
---
 profiles/audio/a2dp.c | 55 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d0913b1ec..2ce7c06cb 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -836,32 +836,6 @@ static void getconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		DBG("Source %p: Set_Configuration_Cfm", sep);
 }
 
-static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
-				struct avdtp_stream *stream, uint8_t *err,
-				void *user_data)
-{
-	struct a2dp_sep *a2dp_sep = user_data;
-	struct a2dp_setup *setup;
-
-	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		DBG("Sink %p: Open_Ind", sep);
-	else
-		DBG("Source %p: Open_Ind", sep);
-
-	setup = a2dp_setup_get(session);
-	if (!setup)
-		return FALSE;
-
-	setup->stream = stream;
-
-	if (setup->reconfigure)
-		setup->reconfigure = FALSE;
-
-	finalize_config(setup);
-
-	return TRUE;
-}
-
 static bool match_remote_sep(const void *data, const void *user_data)
 {
 	const struct a2dp_remote_sep *sep = data;
@@ -916,6 +890,35 @@ static void update_last_used(struct a2dp_channel *chan,
 	store_last_used(chan, rsep);
 }
 
+static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
+
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Open_Ind", sep);
+	else
+		DBG("Source %p: Open_Ind", sep);
+
+	setup = a2dp_setup_get(session);
+	if (!setup)
+		return FALSE;
+
+	setup->stream = stream;
+
+	if (!err && setup->chan)
+		update_last_used(setup->chan, stream);
+
+	if (setup->reconfigure)
+		setup->reconfigure = FALSE;
+
+	finalize_config(setup);
+
+	return TRUE;
+}
+
 static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
-- 
2.20.1

