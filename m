Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63288CDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 06:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjJPGkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPGkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 02:40:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B43D9
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Oct 2023 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697438421; x=1728974421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwSQW3LRdbZL6YIdusgTJ6DCps8BH+4ZP7CuDA6wPnk=;
  b=N6RrqiIzzMu2T/nvbaixkEbX2jWh4+l2woLKcoalSPTcrGTDdCQuM2L3
   S5CpS5Or9or1F7jI5i112+mfccHWWEPx+pNN4WLZAMNGXekdhoWg73GU7
   7gzICd79EgLAXCrCuAtrT+WBclLs10OUtXP9zwTQLqogdda/k8kotgGgh
   YSiGyMp0ETyljYjOu5T0trkolZo+4x94Lb2pmHsBN5LHIY+/zLiXPC8X+
   lbZvIEHraP9eWHAo18J4CAwKN2ZmLEM3Wlp0BMpUXihMehnSSsh2mQuGJ
   ou6hymJaeHZZf4aRCuI1Pwtgb51dZ+dl8oNv+dkAmdmIjYrvZOPdsFLhy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382682015"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="382682015"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929246528"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="929246528"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2023 23:40:19 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH 2/2] shared/bap: Add support for Audio Locations
Date:   Mon, 16 Oct 2023 12:22:28 +0530
Message-Id: <20231016065228.424400-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016065228.424400-1-kiran.k@intel.com>
References: <20231016065228.424400-1-kiran.k@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support to provide Audio Locations for BAP Sink and Source Endpoints
---
 profiles/audio/media.c |  2 +-
 src/shared/bap.c       | 56 ++++++++++++++++++++++++++++++++----------
 src/shared/bap.h       |  6 +++--
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 51e3ab65d12d..d063bbf11cf9 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1250,7 +1250,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 
 	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
 				endpoint->cid, endpoint->vid, &endpoint->qos,
-				&data, metadata);
+				&data, metadata, endpoint->location);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
 		free(metadata);
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 925501c48d98..bee19039900f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -190,6 +190,7 @@ struct bt_bap_pac {
 	uint8_t type;
 	struct bt_bap_codec codec;
 	struct bt_bap_pac_qos qos;
+	uint32_t location;
 	struct iovec *data;
 	struct iovec *metadata;
 	struct bt_bap_pac_ops *ops;
@@ -368,6 +369,14 @@ static void pac_foreach(void *data, void *user_data)
 		meta->len = 0;
 }
 
+static void get_pac_loc(void *data, void *user_data)
+{
+	struct bt_bap_pac *pac = data;
+	uint32_t *location = user_data;
+
+	*location |= pac->location;
+}
+
 static void pacs_sink_read(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				uint8_t opcode, struct bt_att *att,
@@ -395,7 +404,15 @@ static void pacs_sink_loc_read(struct gatt_db_attribute *attrib,
 				void *user_data)
 {
 	struct bt_pacs *pacs = user_data;
-	uint32_t value = cpu_to_le32(pacs->sink_loc_value);
+	struct bt_bap_db *bdb = pacs->bdb;
+	uint32_t value;
+
+	queue_foreach(bdb->sinks, get_pac_loc, &pacs->sink_loc_value);
+	if (pacs->sink_loc_value)
+		value = cpu_to_le32(pacs->sink_loc_value);
+	else
+		/* Set default value */
+		value = cpu_to_le32(PACS_SNK_LOCATION);
 
 	gatt_db_attribute_read_result(attrib, id, 0, (void *) &value,
 							sizeof(value));
@@ -428,7 +445,15 @@ static void pacs_source_loc_read(struct gatt_db_attribute *attrib,
 				void *user_data)
 {
 	struct bt_pacs *pacs = user_data;
-	uint32_t value = cpu_to_le32(pacs->source_loc_value);
+	struct bt_bap_db *bdb = pacs->bdb;
+	uint32_t value;
+
+	queue_foreach(bdb->sources, get_pac_loc, &pacs->source_loc_value);
+	if (pacs->source_loc_value)
+		value = cpu_to_le32(pacs->source_loc_value);
+	else
+		/* Set default value */
+		value = cpu_to_le32(PACS_SRC_LOCATION);
 
 	gatt_db_attribute_read_result(attrib, id, 0, (void *) &value,
 							sizeof(value));
@@ -474,9 +499,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 
 	pacs = new0(struct bt_pacs, 1);
 
-	/* Set default values */
-	pacs->sink_loc_value = PACS_SNK_LOCATION;
-	pacs->source_loc_value = PACS_SRC_LOCATION;
+	pacs->sink_loc_value = 0;
+	pacs->source_loc_value = 0;
 	pacs->sink_context_value = PACS_SNK_CTXT;
 	pacs->source_context_value = PACS_SRC_CTXT;
 	pacs->supported_sink_context_value = PACS_SUPPORTED_SNK_CTXT;
@@ -2451,7 +2475,8 @@ static struct bt_bap_pac *bap_pac_new(struct bt_bap_db *bdb, const char *name,
 					struct bt_bap_codec *codec,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					uint32_t location)
 {
 	struct bt_bap_pac *pac;
 
@@ -2468,6 +2493,8 @@ static struct bt_bap_pac *bap_pac_new(struct bt_bap_db *bdb, const char *name,
 	if (qos)
 		pac->qos = *qos;
 
+	pac->location = location;
+
 	return pac;
 }
 
@@ -2679,7 +2706,8 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					uint8_t id, uint16_t cid, uint16_t vid,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					uint32_t location)
 {
 	struct bt_bap_db *bdb;
 	struct bt_bap_pac *pac, *pac_broadcast_sink;
@@ -2699,7 +2727,8 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 	codec.cid = cid;
 	codec.vid = vid;
 
-	pac = bap_pac_new(bdb, name, type, &codec, qos, data, metadata);
+	pac = bap_pac_new(bdb, name, type, &codec, qos, data, metadata,
+				location);
 
 	switch (type) {
 	case BT_BAP_SINK:
@@ -2716,7 +2745,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 			 */
 			pac_broadcast_sink = bap_pac_new(bdb, name,
 					BT_BAP_BCAST_SINK, &codec, qos,
-					data, metadata);
+					data, metadata, 0);
 			bap_add_broadcast_sink(pac_broadcast_sink);
 		}
 		break;
@@ -2737,10 +2766,11 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					uint8_t type, uint8_t id,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					uint32_t location)
 {
 	return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
-							data, metadata);
+						data, metadata, location);
 }
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
@@ -3256,7 +3286,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 		}
 
 		pac = bap_pac_new(bap->rdb, NULL, type, &p->codec, NULL, &data,
-								&metadata);
+							&metadata, 0);
 		if (!pac)
 			continue;
 
@@ -5481,7 +5511,7 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
 		return true;
 
 	pac_broadcast_source = bap_pac_new(bap->rdb, name, BT_BAP_BCAST_SOURCE,
-			NULL, NULL, NULL, NULL);
+			NULL, NULL, NULL, NULL, 0);
 	queue_push_tail(bap->rdb->broadcast_sources, pac_broadcast_source);
 
 	if (!pac_broadcast_source)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index ebe4dbf7d858..10e82f35e547 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -141,13 +141,15 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					uint8_t id, uint16_t cid, uint16_t vid,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata);
+					struct iovec *metadata,
+					uint32_t location);
 
 struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					uint8_t type, uint8_t id,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata);
+					struct iovec *metadata,
+					uint32_t location);
 
 struct bt_bap_pac_ops {
 	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-- 
2.34.1

