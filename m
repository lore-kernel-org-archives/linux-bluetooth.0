Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61186C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJUT6L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 15:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJUT5s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 15:57:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE6329B8B4
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 12:57:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d10so3554281pfh.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOq7eMmCKWR1anbCxSOfEtznn/rAq3lwaVUhOxv12Mg=;
        b=Zonji7vrON+bNuQLJfjYqXi/TJz58WnwPbQcxOqpN7VslpIAzpl4ypanl67TV7nwJr
         nCxltNsl2/0oDS4TwlNjd975BCs1u3Yf3kMYIikVMjRpFSiCN2Q9QKKO3IiS9kfikMit
         Gr42N6FNkLRgmGRP8IfmzBZA9E0dHk2vGO1N7yslG0+Ljm5avpA4Yrhwy/u/+q7k2AYL
         2x6zGy+a2OGXq0yHxamn/63v1xj4BBRF7yjjQ2oZzN3jpuMAZ5vUVbtE/M9Pm4x3GbLj
         0lbE3I8znHTSkMaDCJi4xOY+5CG1gBsl9KgU40Rp4wpgNx0ek7tLUNTMxWQTlsCSVFfy
         Fl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOq7eMmCKWR1anbCxSOfEtznn/rAq3lwaVUhOxv12Mg=;
        b=VsgOwmjfMDtfDW/3zMglqZJLaY7qav6inFDMIqfyLqLvvFmLcSpVsFdbkWFO5HS1ld
         arUXJETSbVV9xuu4/ihz8ZFbuEGHLLR2l+J92ll590+C6jfQcduuVwaorqyMu+0rbSCm
         mzMBEOTDtTNscW5qJ2IbN0nWm4cpdNmr8I6dW2pT+T97XYAdBoRU+ut9b3l92vfuygez
         /TShMuXG1KGl/7yhwXqWGRVjM8ywxQVhz99PmjmNs4/bWZJlCvDQim0qXM+D74mHPVRG
         WJTAv766Wl78s1p+YMGxzdehZknbs3R4qn/IYKHyQuS/lrCxwpmvdiyFQPBNQAyo+RFL
         iiow==
X-Gm-Message-State: ACrzQf3Vaevha/ObqN2mOiqV+8Ors1vYR8obL+5bK3Txmgxy1oUk51gW
        zlMTsrOmscHHIngIEYSOm2j86bvlbz4=
X-Google-Smtp-Source: AMsMyM5WsML9a+6u6Qz/jGHCOl0UDGnwYuTUAAluz2A+TOeIQPzI9BcB8ZwcDwq11XfnI45H4xRlLQ==
X-Received: by 2002:a63:fd58:0:b0:46b:41d:9d33 with SMTP id m24-20020a63fd58000000b0046b041d9d33mr17770552pgj.399.1666382265994;
        Fri, 21 Oct 2022 12:57:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027d8800b001743ba85d39sm15099665plm.110.2022.10.21.12.57.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:57:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] shared/bap: Merge PAC records of the same type/codec
Date:   Fri, 21 Oct 2022 12:57:43 -0700
Message-Id: <20221021195743.490649-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
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
 src/shared/bap.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c3c0d596fe91..109a5d28b1b4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -284,6 +284,12 @@ static void *iov_add_mem(struct iovec *iov, size_t len, const void *d)
 	return data;
 }
 
+static void *iov_append(struct iovec *iov, size_t len, const void *d)
+{
+	iov->iov_base = realloc(iov->iov_base, iov->iov_len + len);
+	return iov_add_mem(iov, len, d);
+}
+
 static void iov_free(void *data)
 {
 	struct iovec *iov = data;
@@ -2319,6 +2325,52 @@ static struct bt_ascs *bap_get_ascs(struct bt_bap *bap)
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
+		pac->data = iov_dup(data, 1);
+
+	/* Merge metadata into existing record */
+	if (pac->metadata)
+		ltv_merge(pac->metadata, metadata);
+	else
+		pac->metadata = iov_dup(metadata, 1);
+}
+
 static struct bt_bap_pac *bap_pac_new(struct bt_bap_db *bdb, const char *name,
 					uint8_t type,
 					struct bt_bap_codec *codec,
@@ -2328,6 +2380,15 @@ static struct bt_bap_pac *bap_pac_new(struct bt_bap_db *bdb, const char *name,
 {
 	struct bt_bap_pac *pac;
 
+	if (!qos) {
+		/* Check if there is already a PAC record for the codec */
+		pac = bap_pac_find(bdb, type, codec);
+		if (pac) {
+			bap_pac_merge(pac, data, metadata);
+			return pac;
+		}
+	}
+
 	pac = new0(struct bt_bap_pac, 1);
 	pac->bdb = bdb;
 	pac->name = name ? strdup(name) : NULL;
-- 
2.37.3

