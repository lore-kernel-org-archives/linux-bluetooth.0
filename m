Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5A4E82CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjI0VkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjI0VkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B1B11F
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3ae0135c4deso6985645b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850819; x=1696455619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwjHUPbdhZ0jdDmdOXswQrPccCOLqfWqLeXxUdDF1vI=;
        b=bjpzGu2kpSjpOpaeAOg1cr2mur8gVqmlTLc+/mzT1Cs2L2q3Q/A1/oq+kuYFdT5PFr
         t7kxDqcjiZYXALBGm72LQwBkJNNmrXUFcRZI8NRGoW/fa7ez+W6rU8Dv/HlpglIA4Sf3
         TxPD3PTIWQA2UjahlkUgM8u9n20oTdlVQE4eZRyIFTaLpQg774H1uPTUS+SKEEdOOWcl
         Jo3GXb+naeBki/5ODoIW5bcKVoA6SmqVir+80mwnfCNx2pSSOoEP9cXyd13gmZrIr1Dg
         XPjNuTEgsw7cZ9VwLpk21Jp8y9o6S52QyaUYiaPTGuZLY/LrScNHsePHWxAbWr5/BwbT
         foyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850819; x=1696455619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwjHUPbdhZ0jdDmdOXswQrPccCOLqfWqLeXxUdDF1vI=;
        b=TYUIFuQxCetPnMZXjj0pwiACMMCA6fyAr2jATast9A7l40aLfiL8VwwNv7PsDxHHQr
         KSbqrs9QYcBj5lmD6RG0yqA48DmiQRlzz9njZoDj6bYNvKSMWrRF4fVIUMqzQeJ+crU2
         CbmwSfAa1eTV15ysJmeDlk+v3cCseK9LhVHwWR3KrBZ1JQ3Kgg5OZJ5AvZ4HkIZtGdOH
         GodRiWUBr5kGT3Z0OqFOP5Dq4Qccp3JolR4W3ZIRp4d7a5B7pPaiiJGUm11zMOi9660p
         wg7D2jRo8vupeLhjteEHPzhUjXBELJLtOUAmA54U2A1L538qPFESCGTgUths+rGbfMDY
         xjxA==
X-Gm-Message-State: AOJu0YwciCKdNk7s64nUbwriNaKHvocmz1vxr9XhmS7dbBK2RpKmZJDN
        wRgMDGD3cOUAEnWTdmE5s8rKka9oLIcnXkVZ
X-Google-Smtp-Source: AGHT+IE5bhAc/lPnD08XP/J3IZax67fP1gziMhhMg4DYdh2IOkz9vcOp+dpNjgNbKkek3evsqvH8tQ==
X-Received: by 2002:a05:6808:23ca:b0:3a9:9bb6:811 with SMTP id bq10-20020a05680823ca00b003a99bb60811mr3603404oib.57.1695850819091;
        Wed, 27 Sep 2023 14:40:19 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 07/12] shared/bap: Add support content and contexts to bt_bap_pac_qos
Date:   Wed, 27 Sep 2023 14:39:58 -0700
Message-ID: <20230927214003.1873224-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for setting supported content and contexts on a per
PAC record basis which then is carried over to their respective PACS
attribute and notified properly when changed (added/removed).
---
 src/shared/bap.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/bap.h |   3 +
 2 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1c43680c2457..6400d1d69221 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2468,6 +2468,80 @@ static void bap_pac_free(void *data)
 	free(pac);
 }
 
+static void pacs_sink_location_changed(struct bt_pacs *pacs)
+{
+	uint32_t location = cpu_to_le32(pacs->sink_loc_value);
+
+	gatt_db_attribute_notify(pacs->sink_loc, (void *)&location,
+					sizeof(location), NULL);
+}
+
+static void pacs_add_sink_location(struct bt_pacs *pacs, uint32_t location)
+{
+	location |= pacs->sink_loc_value;
+
+	/* Check if location value needs updating */
+	if (location == pacs->sink_loc_value)
+		return;
+
+	pacs->sink_loc_value = location;
+
+	pacs_sink_location_changed(pacs);
+}
+
+static void pacs_supported_context_changed(struct bt_pacs *pacs)
+{
+	struct bt_pacs_context ctx;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ctx.snk = cpu_to_le16(pacs->supported_sink_context_value);
+	ctx.src = cpu_to_le16(pacs->supported_source_context_value);
+
+	gatt_db_attribute_notify(pacs->supported_context, (void *)&ctx,
+					sizeof(ctx), NULL);
+}
+
+static void pacs_add_sink_supported_context(struct bt_pacs *pacs,
+						uint16_t context)
+{
+	context |= pacs->supported_sink_context_value;
+
+	/* Check if context value needs updating */
+	if (context == pacs->supported_sink_context_value)
+		return;
+
+	pacs->supported_sink_context_value = context;
+
+	pacs_supported_context_changed(pacs);
+}
+
+static void pacs_context_changed(struct bt_pacs *pacs)
+{
+	struct bt_pacs_context ctx;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ctx.snk = cpu_to_le16(pacs->sink_context_value);
+	ctx.src = cpu_to_le16(pacs->source_context_value);
+
+	gatt_db_attribute_notify(pacs->context, (void *)&ctx, sizeof(ctx),
+					NULL);
+}
+
+static void pacs_add_sink_context(struct bt_pacs *pacs, uint16_t context)
+{
+	context |= pacs->supported_sink_context_value;
+
+	/* Check if context value needs updating */
+	if (context == pacs->sink_context_value)
+		return;
+
+	pacs->sink_context_value = context;
+
+	pacs_context_changed(pacs);
+}
+
 static void bap_add_sink(struct bt_bap_pac *pac)
 {
 	struct iovec iov;
@@ -2482,10 +2556,62 @@ static void bap_add_sink(struct bt_bap_pac *pac)
 
 	queue_foreach(pac->bdb->sinks, pac_foreach, &iov);
 
+	pacs_add_sink_location(pac->bdb->pacs, pac->qos.location);
+	pacs_add_sink_supported_context(pac->bdb->pacs,
+					pac->qos.supported_context);
+	pacs_add_sink_context(pac->bdb->pacs, pac->qos.context);
 	gatt_db_attribute_notify(pac->bdb->pacs->sink, iov.iov_base,
 				iov.iov_len, NULL);
 }
 
+static void pacs_source_location_changed(struct bt_pacs *pacs)
+{
+	uint32_t location = cpu_to_le32(pacs->source_loc_value);
+
+	gatt_db_attribute_notify(pacs->source_loc, (void *)&location,
+					sizeof(location), NULL);
+}
+
+static void pacs_add_source_location(struct bt_pacs *pacs, uint32_t location)
+{
+	location |= pacs->source_loc_value;
+
+	/* Check if location value needs updating */
+	if (location == pacs->source_loc_value)
+		return;
+
+	pacs->source_loc_value = location;
+
+	pacs_source_location_changed(pacs);
+}
+
+static void pacs_add_source_supported_context(struct bt_pacs *pacs,
+						uint16_t context)
+{
+	context |= pacs->supported_source_context_value;
+
+	/* Check if context value needs updating */
+	if (context == pacs->supported_source_context_value)
+		return;
+
+	pacs->supported_source_context_value = context;
+
+	pacs_supported_context_changed(pacs);
+}
+
+static void pacs_add_source_context(struct bt_pacs *pacs, uint16_t context)
+{
+	context |= pacs->supported_sink_context_value;
+
+	/* Check if context value needs updating */
+	if (context == pacs->sink_context_value)
+		return;
+
+	pacs->sink_context_value = context;
+
+	pacs_context_changed(pacs);
+}
+
 static void bap_add_source(struct bt_bap_pac *pac)
 {
 	struct iovec iov;
@@ -2500,6 +2626,11 @@ static void bap_add_source(struct bt_bap_pac *pac)
 
 	queue_foreach(pac->bdb->sinks, pac_foreach, &iov);
 
+	pacs_add_source_location(pac->bdb->pacs, pac->qos.location);
+	pacs_add_source_supported_context(pac->bdb->pacs,
+					pac->qos.supported_context);
+	pacs_add_source_context(pac->bdb->pacs, pac->qos.context);
+
 	gatt_db_attribute_notify(pac->bdb->pacs->source, iov.iov_base,
 				iov.iov_len, NULL);
 }
@@ -2685,13 +2816,48 @@ static void remove_streams(void *data, void *user_data)
 		bt_bap_stream_release(stream, NULL, NULL);
 }
 
+static void bap_pac_sink_removed(void *data, void *user_data)
+{
+	struct bt_bap_pac *pac = data;
+	struct bt_bap_pac_qos *qos = user_data;
+
+	qos->location |= pac->qos.location;
+	qos->supported_context |= pac->qos.supported_context;
+	qos->context |= pac->qos.context;
+}
+
 bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 {
 	if (!pac)
 		return false;
 
-	if (queue_remove_if(pac->bdb->sinks, NULL, pac))
+	if (queue_remove_if(pac->bdb->sinks, NULL, pac)) {
+		struct bt_pacs *pacs = pac->bdb->pacs;
+		struct bt_bap_pac_qos qos;
+
+		memset(&qos, 0, sizeof(qos));
+		queue_foreach(pac->bdb->sinks, bap_pac_sink_removed, &qos);
+
+		if (pacs->sink_loc_value != qos.location) {
+			pacs->sink_loc_value = qos.location;
+			pacs_sink_location_changed(pacs);
+		}
+
+		if (pacs->supported_sink_context_value !=
+				qos.supported_context) {
+			pacs->supported_sink_context_value =
+							qos.supported_context;
+			pacs_supported_context_changed(pacs);
+		}
+
+		if (pacs->sink_context_value != qos.context) {
+			pacs->sink_context_value = qos.context;
+			pacs_context_changed(pacs);
+		}
+
+
 		goto found;
+	}
 
 	if (queue_remove_if(pac->bdb->sources, NULL, pac))
 		goto found;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index e4eae86502f3..72d6022a32ec 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -131,6 +131,9 @@ struct bt_bap_pac_qos {
 	uint32_t pd_max;
 	uint32_t ppd_min;
 	uint32_t ppd_max;
+	uint32_t location;
+	uint16_t supported_context;
+	uint16_t context;
 };
 
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
-- 
2.41.0

