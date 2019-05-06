Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D8C04AAD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6FE20830
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu20Oxzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfEFMnS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 08:43:18 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:41278 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfEFMnS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 08:43:18 -0400
Received: by mail-ed1-f43.google.com with SMTP id m4so15188210edd.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PKfHLwdp3HTpr4wDPj6GvUhL8qlD/m+3Q24qyqOWALo=;
        b=Iu20Oxzi/bL9Q76Musd5JChUOcO4XWF9JeE9E/ZF7GMgfYYp6kysghUjA/SOFVgIiJ
         bS7tSErcqOjC9JwI6fL3EAVtxvGDKiL5ZqsL0MwsO9e7Yxc/rIUuyvQhJWxKQGmDvyeq
         +2mzrJ4kHuDCj7jwhs3Px9OZYLE/fxFpIjPdgqJ7QuX8oR/6qVLCWlus6788d1nSRBhl
         cB63+Gy1Ie19kKrluSkBBf1E9P8sNNUyQUlG0dx12hfmADMtTu98dEmTUIs2zC4EiZqk
         WLLjXmI/bWQFv2Vjq9ekFfTv+OKXaGVHgzArBTL74o8lARgd8CJDZX+pXylV16qk640w
         DR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKfHLwdp3HTpr4wDPj6GvUhL8qlD/m+3Q24qyqOWALo=;
        b=NmhHHsLVieKBs91mPohXFpY1yHwBybPDksxN/VxRGVXvTg384ZRCTDDakYH2zzwNqs
         QRTZ4BYnI4+sXMbBlq4KMiW8SaqINuzN0miNc/GalDNGm0k+YPx1whBC7F46Dd5EI9G4
         ueHW+UtQOCCc78z2CMh2178h84XO6+wvytO/SrQ6eI7r2kqsvECjlmk+psOdfGCKqLdW
         JFvodZ3/noHtq+NjOpB4TxKF8mZS+n3PhkirdGb7kEZm4912AP5Cxd9xECyfpCmioulC
         6HPtrQwBiEaHoTRZ5VOnm8wCyqigTyF7QyeFz7SDHMhmRxiY/XF7sJs2iEm8kG493MPt
         UYoQ==
X-Gm-Message-State: APjAAAVzi6OShohNWaKfeZz//3HFipDgCVDHVpW/pa64nLlLdcKSnQfL
        VW7noA2nb8tZE6daNzyo5T+95PaszZs=
X-Google-Smtp-Source: APXvYqwHjBsOKiVPAtMkxa3uXLw9YWeMLHrOCwj/LSrfcgB0ntrXp7ywBXyanaQlgjwjOQrI8rCUbA==
X-Received: by 2002:a17:906:c799:: with SMTP id cw25mr19243112ejb.268.1557146596562;
        Mon, 06 May 2019 05:43:16 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id h27sm1025816edb.66.2019.05.06.05.43.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 05:43:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/6] a2dp: Update last used on open indication
Date:   Mon,  6 May 2019 15:43:07 +0300
Message-Id: <20190506124310.19151-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506124310.19151-1-luiz.dentz@gmail.com>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
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

