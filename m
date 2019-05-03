Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CD8C43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BA32087F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 08:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HslgZ/Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfECIqG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 04:46:06 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:38827 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfECIpy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 04:45:54 -0400
Received: by mail-lj1-f173.google.com with SMTP id e18so4578560lja.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PKfHLwdp3HTpr4wDPj6GvUhL8qlD/m+3Q24qyqOWALo=;
        b=HslgZ/MzWn5IxKrjXJEqJGlMrBqXg/k6TgVIbdQUF3OvnAqOpGyKGx3JSrQwPefGW+
         ARHcvldzvsy7mCsjr1dX7CeMb7cYlJjeOIY60XnYkaH6K4Iu/TWJdstVwTw1SDIxAOlj
         4tWvNvxSLOPEqqmH4wN21PLRY0K2m/dqf11Q9mxx5p3pTXYFLxejRyFRT8va7P88zF4E
         1bdorqCZp3ZaVuljXhVum79ExOlMj5MaGNQWf9AjOEy9Yhkv8+JyMyC9dX11ZUYdyP8L
         3zNHRMMAWORm65GzBV+WNwpbEFKTFYb23p3y1CH+dQcfsGQshiLowVSN0nwuJUegQaIZ
         tl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKfHLwdp3HTpr4wDPj6GvUhL8qlD/m+3Q24qyqOWALo=;
        b=SgMTY1HvAOQqdy8EYL6KrNKUBKZaF2sZOGGX2GWYW1sj/PT3kGxPMFzAC2fV40+rAV
         8g7w+kAaDWWaHQxs0rRIgjoaGSceVX0ULYbpJEHZvRHzMFmk89qI+4NNoK0QcIiSO9JD
         2EDJ3FkhvcUyUtqYiZXOaa6Nj4/AxncfcBUCnFnPBJn6nLbeN12bSSDhHvNDUFH2xA6/
         sxnWK9C9QRzLpgO44F0UPgUoKXaD5Ti/+IeAGaOt4pUH0oTyksMTTttGN4cBnPbEDHBF
         Kmpk6NCtcN7dp4kKtpO+yqtwVr92AQ78Z8jqwjvcV4OjMxkHHwqTXcaB2ndYuMFgcQZq
         ShVg==
X-Gm-Message-State: APjAAAWURioeJu34vWxEqxRfm8T9OYOxdLlyTAQdl3No29WOgajkZT4y
        kLsnOOvff74vlf3/yygoBEHo7RUqxUQg0w==
X-Google-Smtp-Source: APXvYqwTZdr4n1KU74yDdw0gR2tQGNRvOu33eNPcs3o/KNcv8oe2xwaOGpauBjk+p11CYdGAlGG/Gg==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr4522810ljh.80.1556873152254;
        Fri, 03 May 2019 01:45:52 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id h26sm311360lfm.11.2019.05.03.01.45.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 01:45:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] a2dp: Update last used on open indication
Date:   Fri,  3 May 2019 11:45:47 +0300
Message-Id: <20190503084547.15743-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084547.15743-1-luiz.dentz@gmail.com>
References: <20190503084547.15743-1-luiz.dentz@gmail.com>
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

