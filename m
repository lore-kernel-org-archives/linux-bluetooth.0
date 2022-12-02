Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA950C47088
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiLBAvF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLBAvB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:51:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B29CBA64
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:51:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3752384pjm.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59/tZYb95zry6qHeA7hmQRRZW9XVwhOq8Y0v9+IeSrg=;
        b=Su5SfNYO5bYvpPLuQraerHvjIt8jwrq+7ZIFOPM31DfrPCTdJnnK8j1P3oEr9gZFHE
         iBOTY9rrPSNxeYgQECoxsf6Q0BIjbmlkXrXNSI0r5pv4ehNTid2g6k5sfRa3oIuaQR1D
         E+Z/sbhZsEm48CHHbrb6xVGkEKRlMh7EaM+Vw7smDJWC6h83j3A4IgG2HINS499oCHs2
         6pK6UpAVkO5d+KVp7u+yOAgNghqV2ZqhkZDCUFCf54cR9VZC1rKo7hnJH+a+jc0hQAp8
         VuN2VsSbnbQZBuMlpBbSVk2XN53jNnrRO2589FtD7CJJs0iSD2RaHp8GmghrPBjWPQa0
         njsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59/tZYb95zry6qHeA7hmQRRZW9XVwhOq8Y0v9+IeSrg=;
        b=c+XV9uA2dlYh8EOqdR3n87W+k1TqE97Ujpg29Pvk6AfTenwNEMYOmPqL+rRvyBhLPW
         8p6bGGgcjAA4wtf3nym5gQyGBkXOe8pHDubdUK/NiUl1VaQMC3W+z29XuWScPBtrm4A2
         7CBM+7WpjXTpUNxbtP+2TQOIbTScrQAyjIGfUKxVrZo9c7x805w8t4zqzQGs3ApTJkZX
         qLnPb9zdXcWmUygLrsLmRE/Kry7fLuaxU3SyVNdL7WPCGwxpI1OCat9TdyA/8CvHVufL
         qPbYj3waqm40s75FYw1/5sbMeyV0T+qCZXkfoLevtkSpS+BDTl6//DIZB/gAS3auOwzf
         lfYw==
X-Gm-Message-State: ANoB5pmgkqpGUKf8j80mfEoTGkFjkGlqpPAtdlc6MwTgvBWsEiWNRYEI
        dlCfA28XFGZNuI1QLlaNv7VngdiRIoOITg==
X-Google-Smtp-Source: AA0mqf5Xzond2hYJMuRnoYpty/XEpePSd3vkb+RHzQgSk925qb0gFY/8rATEr6QTIra4JHuLr17lAA==
X-Received: by 2002:a17:902:8203:b0:186:e2c3:91c6 with SMTP id x3-20020a170902820300b00186e2c391c6mr19904432pln.27.1669942259630;
        Thu, 01 Dec 2022 16:50:59 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm4246005pln.139.2022.12.01.16.50.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:50:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/8] shared/bap: Merge PAC records of the same type/codec
Date:   Thu,  1 Dec 2022 16:50:49 -0800
Message-Id: <20221202005051.2401504-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221202005051.2401504-1-luiz.dentz@gmail.com>
References: <20221202005051.2401504-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to merge PAC records which contain the same type and
codec to simplify the matching with client endpoints so all
capabilities and metadata are match at once instead of for each PAC
record.
---
 src/shared/bap.c | 65 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f4812a4b9f51..59ef81d11882 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -262,6 +262,12 @@ static bool bap_db_match(const void *data, const void *match_data)
 	return (bdb->db == db);
 }
 
+static void *iov_append(struct iovec *iov, size_t len, const void *d)
+{
+	iov->iov_base = realloc(iov->iov_base, iov->iov_len + len);
+	return util_iov_push_mem(iov, len, d);
+}
+
 unsigned int bt_bap_pac_register(bt_bap_pac_func_t added,
 				bt_bap_pac_func_t removed, void *user_data,
 				bt_bap_destroy_func_t destroy)
@@ -2236,6 +2242,52 @@ static struct bt_ascs *bap_get_ascs(struct bt_bap *bap)
 	return bap->rdb->ascs;
 }
 
+static bool match_codec(const void *data, const void *user_data)
+{
+	const struct bt_bap_pac *pac = data;
+	const struct bt_bap_codec *codec = user_data;
+
+	return bap_codec_equal(&pac->codec, codec);
+}
+
+static struct bt_bap_pac *bap_pac_find(struct bt_bap_db *bdb, uint8_t type,
+					struct bt_bap_codec *codec)
+{
+	switch (type) {
+	case BT_BAP_SOURCE:
+		return queue_find(bdb->sources, match_codec, codec);
+	case BT_BAP_SINK:
+		return queue_find(bdb->sinks, match_codec, codec);
+	}
+
+	return NULL;
+}
+
+static void *ltv_merge(struct iovec *data, struct iovec *cont)
+{
+	uint8_t delimiter = 0;
+
+	iov_append(data, sizeof(delimiter), &delimiter);
+
+	return iov_append(data, cont->iov_len, cont->iov_base);
+}
+
+static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
+					struct iovec *metadata)
+{
+	/* Merge data into existing record */
+	if (pac->data)
+		ltv_merge(pac->data, data);
+	else
+		pac->data = util_iov_dup(data, 1);
+
+	/* Merge metadata into existing record */
+	if (pac->metadata)
+		ltv_merge(pac->metadata, metadata);
+	else
+		pac->metadata = util_iov_dup(metadata, 1);
+}
+
 static struct bt_bap_pac *bap_pac_new(struct bt_bap_db *bdb, const char *name,
 					uint8_t type,
 					struct bt_bap_codec *codec,
@@ -2742,14 +2794,21 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 
 		util_iov_pull_mem(&iov, meta->len);
 
+		DBG(bap, "PAC #%u: type %u codec 0x%02x cc_len %u meta_len %u",
+			i, type, p->codec.id, p->cc_len, meta->len);
+
+		/* Check if there is already a PAC record for the codec */
+		pac = bap_pac_find(bap->rdb, type, &p->codec);
+		if (pac) {
+			bap_pac_merge(pac, &data, &metadata);
+			continue;
+		}
+
 		pac = bap_pac_new(bap->rdb, NULL, type, &p->codec, NULL, &data,
 								&metadata);
 		if (!pac)
 			continue;
 
-		DBG(bap, "PAC #%u: type %u codec 0x%02x cc_len %u meta_len %u",
-			i, type, p->codec.id, p->cc_len, meta->len);
-
 		queue_push_tail(queue, pac);
 	}
 }
-- 
2.37.3

