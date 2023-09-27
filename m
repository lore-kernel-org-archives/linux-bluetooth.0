Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D773E7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjI0VyM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjI0VyL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:54:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E2211F
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:08 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fb64b5265so317310439f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851647; x=1696456447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwjHUPbdhZ0jdDmdOXswQrPccCOLqfWqLeXxUdDF1vI=;
        b=ZkHjZCKFw+XHeVxbpIkOwMZNSxvAF6nPRV6hiA5bVm4jgOsjuVXRTvExEla2s2+idU
         Je9DkRa470HvYVtgxZmiJ4Wa01kVY0tWYvOz1cbR8s7JKi0l7uFgIO6+DChl+4xTwmri
         /FtFMidJrw4O1/NodP4JRYFRPAovaV8XVzH5knCChFdYh0dyYK+6wntnl3dsGoqrANfe
         BCaYXBMFKwTE4EGdipRyoyRp11i7cPFrvm9iJ3HW1+GDcRD/jD6x+8SXe/xSFlE4nCqJ
         piMtEHO7WCwXEmpnnXpEbFim5KTM9/+5bTUrEmrhhEgyD38sBM9hwdLvb51fewEshuJd
         8kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851647; x=1696456447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwjHUPbdhZ0jdDmdOXswQrPccCOLqfWqLeXxUdDF1vI=;
        b=Z532YeZMQ0N0d0iwkt/ks3biSLRvuYWAhjD5BTiBrs6dvqzbVOO33pCmNYMM7eEcTI
         mHjmuTyPjYAv6nNatZbKdGiuCEoF0FJcKp0phWl5QNu1A+DaVRN9aj3jDiEnffn+CGau
         d+n1TTGJZHTuDKoL+43Xj6GhZbFgDDTLX1Lv0X1Ot9Vf9QM8ZfOkC8g2GhyXWcrGydew
         U7GmKROEYtf0CrYBR1S9NikXxTnrxUuIkxBmTsOyHtoXgj1RLdet1Irx5r4gH6pQ8BQd
         GXr+TfpTr6TDu7ze8xOcpz8nlvx76aQ/DGJZ9jCiF9abVkp+K9FlLL4+cGhkClx/SgRO
         Tqqg==
X-Gm-Message-State: AOJu0YyRKjRsv/n1+KH/nSWOhS/ax6cgMiaFk/gcw4SlmoTf0zJxUfDV
        qI2V8FI6ya3TEHySW7FSh1loK/3nkzEctc9M
X-Google-Smtp-Source: AGHT+IGiJnV+5DiGKlExSu2udJvZc821MhWqm7U6461Umm7zSqreNafrovAjE1AYqkixD1t1Jvk8tg==
X-Received: by 2002:a6b:e015:0:b0:790:f866:d717 with SMTP id z21-20020a6be015000000b00790f866d717mr3822401iog.10.1695851647518;
        Wed, 27 Sep 2023 14:54:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm4225331jaq.173.2023.09.27.14.54.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:54:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 07/12] shared/bap: Add support content and contexts to bt_bap_pac_qos
Date:   Wed, 27 Sep 2023 14:53:49 -0700
Message-ID: <20230927215354.1874835-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
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

