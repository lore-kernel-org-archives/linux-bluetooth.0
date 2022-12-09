Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94861C001B2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 01:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLIBDX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIBDU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 20:03:20 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA675BC4
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 17:03:19 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f9so2519862pgf.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Dec 2022 17:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7Pmk33GqCmq3eGwtX1OLnE5weBn+sp6rMMlKRau3G0=;
        b=H4k1dRaHEDfgVZK94iPgyOFBFVwbtHZR/alnJI0EM38OENhgcInVTm6PUZ2P+3zReO
         9bMuqQ3NkkiW1lyBUysKOVLe31HY/45fV+cWFHonnXU9o26YNbBtpRWuXgQUQWWTDWFG
         pZR2NoH5TKvL9Sl2eCsXU7KmEASLG1WOdTy1K4D7cz0ezb32jsYUrV9ykrb1vcofSs/A
         CrTuX76TDkaaM7ddznIkNcK9SKSsgx3qsxLmGAcDNdTIVcXVFTXFwnhSkXahTD/sG4t4
         GVkhiXAyjqPHisn4yYDcwAD4wunvB4cncvdg3MhIR+dpuv2pzqP+B5y16Y/IBWtLqF0N
         kXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7Pmk33GqCmq3eGwtX1OLnE5weBn+sp6rMMlKRau3G0=;
        b=qUEAG7mZXZ023hnE2z9rhAGB/4g2ZWpKyD0nZDdvQ+4qbwqa8pYy/wZgKHvRp3WU7G
         lWfYsck0KfFK/Ry3LSPpsvarT60AZfpxHfmNwabQizAAJbEm7zyf9cWSC7ZYnYfuloLM
         BOV8GtCcKqRWrS54bfupAAjOZAGtkj7IkkzxWrwSiaqrIWZRcTeByPrDYGYiMFzUV5W8
         SCW+W6h4yS9Mppk0zPi0OomNY2F1dbNJC5BEAZn3977U0x28ojj+b2FN6WXki+OjJnLp
         RrNJBmcFtuHoInUhGXagp4x7G1646vzzqL74j0CCRwsGfkzERuJ+mnF+XMJXTCApIYfh
         ZULg==
X-Gm-Message-State: ANoB5pmKG6/LJqHMIzuvULyqCZEjLv6OUkR/6BYdT3oXxcRT8s7lNE8c
        MPGQTqS7G8ixsnLdVECKVmYWteVKqHQwCg==
X-Google-Smtp-Source: AA0mqf4Cp1j5qyC9w9qm8WO5pNyx3MX1mD9zn2RXADfDU9BSFIqXeaasi9ObMav3eEUneg8s+nmwXA==
X-Received: by 2002:aa7:8690:0:b0:577:501c:c154 with SMTP id d16-20020aa78690000000b00577501cc154mr3921211pfo.6.1670547798501;
        Thu, 08 Dec 2022 17:03:18 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79495000000b005746c3b2445sm100253pfk.151.2022.12.08.17.03.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:03:17 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/bap: Read PAC Sink/Source if respective location is found
Date:   Thu,  8 Dec 2022 17:03:12 -0800
Message-Id: <20221209010314.707606-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209010314.707606-1-luiz.dentz@gmail.com>
References: <20221209010314.707606-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If PAC Sink/Source has been found but not record has been recovered it
means an error must have occured so this attempt to read the records
once again.
---
 src/shared/bap.c | 146 +++++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 63 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 04ef4f44c1dd..391838a96c55 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2837,69 +2837,6 @@ static void read_sink_pac(struct bt_bap *bap, bool success, uint8_t att_ecode,
 	bap_parse_pacs(bap, BT_BAP_SINK, bap->rdb->sinks, value, length);
 }
 
-static void read_source_pac_loc(struct bt_bap *bap, bool success,
-				uint8_t att_ecode, const uint8_t *value,
-				uint16_t length, void *user_data)
-{
-	struct bt_pacs *pacs = bap_get_pacs(bap);
-
-	if (!success) {
-		DBG(bap, "Unable to read Source PAC Location: error 0x%02x",
-								att_ecode);
-		return;
-	}
-
-	gatt_db_attribute_write(pacs->source_loc, 0, value, length, 0, NULL,
-							NULL, NULL);
-}
-
-static void read_sink_pac_loc(struct bt_bap *bap, bool success,
-				uint8_t att_ecode, const uint8_t *value,
-				uint16_t length, void *user_data)
-{
-	struct bt_pacs *pacs = bap_get_pacs(bap);
-
-	if (!success) {
-		DBG(bap, "Unable to read Sink PAC Location: error 0x%02x",
-								att_ecode);
-		return;
-	}
-
-	gatt_db_attribute_write(pacs->sink_loc, 0, value, length, 0, NULL,
-							NULL, NULL);
-}
-
-static void read_pac_context(struct bt_bap *bap, bool success,
-				uint8_t att_ecode, const uint8_t *value,
-				uint16_t length, void *user_data)
-{
-	struct bt_pacs *pacs = bap_get_pacs(bap);
-
-	if (!success) {
-		DBG(bap, "Unable to read PAC Context: error 0x%02x", att_ecode);
-		return;
-	}
-
-	gatt_db_attribute_write(pacs->context, 0, value, length, 0, NULL,
-							NULL, NULL);
-}
-
-static void read_pac_supported_context(struct bt_bap *bap, bool success,
-					uint8_t att_ecode, const uint8_t *value,
-					uint16_t length, void *user_data)
-{
-	struct bt_pacs *pacs = bap_get_pacs(bap);
-
-	if (!success) {
-		DBG(bap, "Unable to read PAC Supproted Context: error 0x%02x",
-								att_ecode);
-		return;
-	}
-
-	gatt_db_attribute_write(pacs->supported_context, 0, value, length, 0,
-							NULL, NULL, NULL);
-}
-
 static void bap_pending_destroy(void *data)
 {
 	struct bt_bap_pending *pending = data;
@@ -2944,6 +2881,89 @@ static void bap_read_value(struct bt_bap *bap, uint16_t value_handle,
 	queue_push_tail(bap->pending, pending);
 }
 
+static void read_source_pac_loc(struct bt_bap *bap, bool success,
+				uint8_t att_ecode, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct bt_pacs *pacs = bap_get_pacs(bap);
+
+	if (!success) {
+		DBG(bap, "Unable to read Source PAC Location: error 0x%02x",
+								att_ecode);
+		return;
+	}
+
+	gatt_db_attribute_write(pacs->source_loc, 0, value, length, 0, NULL,
+							NULL, NULL);
+
+	/* Resume reading sinks if supported but for some reason is empty */
+	if (pacs->source && queue_isempty(bap->rdb->sources)) {
+		uint16_t value_handle;
+
+		if (gatt_db_attribute_get_char_data(pacs->source,
+						NULL, &value_handle,
+						NULL, NULL, NULL))
+			bap_read_value(bap, value_handle, read_source_pac, bap);
+	}
+}
+
+static void read_sink_pac_loc(struct bt_bap *bap, bool success,
+				uint8_t att_ecode, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct bt_pacs *pacs = bap_get_pacs(bap);
+
+	if (!success) {
+		DBG(bap, "Unable to read Sink PAC Location: error 0x%02x",
+								att_ecode);
+		return;
+	}
+
+	gatt_db_attribute_write(pacs->sink_loc, 0, value, length, 0, NULL,
+							NULL, NULL);
+
+	/* Resume reading sinks if supported but for some reason is empty */
+	if (pacs->sink && queue_isempty(bap->rdb->sinks)) {
+		uint16_t value_handle;
+
+		if (gatt_db_attribute_get_char_data(pacs->sink,
+						NULL, &value_handle,
+						NULL, NULL, NULL))
+			bap_read_value(bap, value_handle, read_sink_pac, bap);
+	}
+}
+
+static void read_pac_context(struct bt_bap *bap, bool success,
+				uint8_t att_ecode, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct bt_pacs *pacs = bap_get_pacs(bap);
+
+	if (!success) {
+		DBG(bap, "Unable to read PAC Context: error 0x%02x", att_ecode);
+		return;
+	}
+
+	gatt_db_attribute_write(pacs->context, 0, value, length, 0, NULL,
+							NULL, NULL);
+}
+
+static void read_pac_supported_context(struct bt_bap *bap, bool success,
+					uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct bt_pacs *pacs = bap_get_pacs(bap);
+
+	if (!success) {
+		DBG(bap, "Unable to read PAC Supproted Context: error 0x%02x",
+								att_ecode);
+		return;
+	}
+
+	gatt_db_attribute_write(pacs->supported_context, 0, value, length, 0,
+							NULL, NULL, NULL);
+}
+
 static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct bt_bap *bap = user_data;
-- 
2.37.3

