Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7E29826D
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960174; cv=none; b=NgJiukZ+TgDrIu1fdJabP5KpGPrtaGTsDt52lus+4XROVqzRUXLFhEb8ZNxCwl1smJ+vslDHk+pdnluOtn+9Q/v4I2xSLPpB0rieu/oiet6KfTsry/hJtIk8Spe4wJGxpBbCPoa1ngfctEE3aFnvHvn4myT8qAFA1f304fTKQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960174; c=relaxed/simple;
	bh=P4pv7VOuaetcVSFS+5Cc6q/GCPkOY5ZdWQrz/CqT4HI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoGQ5FwSz78N3QmZoo2xJumsVNAEoWYUUOmfGJJbBYzuUtz9n0YfOXF+PgPfbzW+05sJRZk2D6uQ76ZwvQdbyK+eBhzTUypNPlsQpIcy0PSTmKN+ru90tyr+cCAvV1xYqZMWen3CCoMrTfKN5TMjbN2fSUkWoWVA2hxMR4JQ2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 8 Jul
 2025 10:36:04 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ 08/11] src/shared: move null checks before dereferencing
Date: Tue, 8 Jul 2025 10:33:31 +0300
Message-ID: <20250708073334.2393559-9-i.iskakov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708073334.2393559-1-i.iskakov@omp.ru>
References: <20250708073334.2393559-1-i.iskakov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/08/2025 07:11:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 194600 [Jul 08 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: i.iskakov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 63 0.3.63
 9cc2b4b18bf16653fda093d2c494e542ac094a39
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	inp1wst013.omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/08/2025 07:12:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/8/2025 5:27:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

---
 src/shared/bap.c     | 14 ++++++++------
 src/shared/gatt-db.c |  5 ++++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 96fca595b..5b904af9b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2570,12 +2570,12 @@ static uint8_t bap_ucast_io_dir(struct bt_bap_stream *stream)
 
 static uint8_t bap_bcast_io_dir(struct bt_bap_stream *stream)
 {
-	uint8_t dir;
-	uint8_t pac_type = bt_bap_pac_get_type(stream->lpac);
-
 	if (!stream)
 		return 0x00;
 
+	uint8_t dir;
+	uint8_t pac_type = bt_bap_pac_get_type(stream->lpac);
+
 	if (pac_type == BT_BAP_BCAST_SINK)
 		dir = BT_BAP_BCAST_SOURCE;
 	else
@@ -6144,7 +6144,7 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 	struct bt_bap_endpoint *ep = NULL;
 	struct match_pac match;
 
-	if (!bap)
+	if (!bap || !lpac)
 		return NULL;
 
 	if (lpac->type == BT_BAP_BCAST_SOURCE) {
@@ -6153,7 +6153,7 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 		memset(&match.codec, 0, sizeof(match.codec));
 
 		bt_bap_foreach_pac(bap, BT_BAP_BCAST_SINK, match_pac, &match);
-		if ((!match.lpac) || (!lpac))
+		if (!match.lpac)
 			return NULL;
 
 		lpac = match.lpac;
@@ -6406,11 +6406,13 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	unsigned int id;
-	struct bt_bap *bap = stream->bap;
+	struct bt_bap *bap;
 
 	if (!stream || !stream->ops || !stream->ops->release)
 		return 0;
 
+	bap = stream->bap;
+
 	if (!bt_bap_ref_safe(bap))
 		return 0;
 
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8951079be..a4fa8aed9 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1391,12 +1391,15 @@ static void find_by_type(struct gatt_db_attribute *attribute, void *user_data)
 {
 	struct find_by_type_value_data *search_data = user_data;
 
+	if (!attribute)
+		return;
+
 	/* TODO: fix for read-callback based attributes */
 	if (search_data->value) {
 		if (search_data->value_len != attribute->value_len)
 			return;
 
-		if (!attribute || !attribute->value)
+		if (!attribute->value)
 			return;
 
 		if (memcmp(attribute->value, search_data->value,
-- 
2.34.1

