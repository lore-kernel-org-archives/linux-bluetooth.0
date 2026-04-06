Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57A1F5EA
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505655; cv=none; b=SIgie0F6i2bTPcR+TwK6qdK9Gw/V2xSAyJZPk8rxyJJX6uP3P8KFJL67w+oki68kdto9wzR5qnMSGehezNc6zMLXLwMWCwjLuUWPx4ziuBdM20ojk/iduFIw6h4BL/9RNgRjvDTX8J2qWII1Cz2QmaPBWzT2EXWlelIUaFiCk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505655; c=relaxed/simple;
	bh=7te3boQ4cHD8Mak9Y/Vbpptrs7BYdrmuu3AXndusFe8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cF0ZDAcsLwSZ5wYWXcrhOUju5KvYcHPQ27v5dvDcSQnOldXT5cAmh7w/pnIgKII6Cti03yCoLzt0nboVEaPHDNshyvmrr67toUC0zNnjeGdFkOXc/Pin3aHWN4WJJZZpyKbG4Rajkxe+7IdBq+P/IvECSVks2NyySfzC4uD1o54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy5fZGQQ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy5fZGQQ"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso4200640e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2026 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775505653; x=1776110453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tNJIAE3LZtFNmmMHnDbMKeruC4vSsCQSr3GzqYj4yo=;
        b=jy5fZGQQzR5YowF2kYPrwRMO+ZYDowKc7z+O9AYPlP1ma4Fzj13y8q77Mnrv9/ONeN
         b8ApBvQqQpdZfGC/iXe4WbWZx8kqeIqZI9yIpH42COtCC3odLRGtdz+uu5EkQY5mnuzI
         T1ztiikrNAhwXmO+nBXQUY7KGWNiQnjwWdr+m54GJDJoiElSqOa+1EvNoQ0DZpgNWq5B
         oV2MKZjHlo31qdG/Ac1kDdxxWP/LH8RiRt+DNcO8UwsW6NUUqN2Sh4BAKdKH+QZteG0h
         CWFSlZCdaZQN0wfWAFJSLSiGWokF48sR9xFRD7IYwWFrwzlZLjrf6Jav7XCgwVpsswDc
         ZSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505653; x=1776110453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tNJIAE3LZtFNmmMHnDbMKeruC4vSsCQSr3GzqYj4yo=;
        b=jDkM7rwaEnxCYO8wlkzit4ozkfiOIZKdVQ4UgPt2+OakL0gJySxbCbpOy1bWkk9Tql
         45fMK660OXu23bBJZqBycj6NT60jpnrXaedPqo2zFVYM2jip2WeiOLG6q/8OLnasEtj/
         fUKV2Oeje6tUes0ElSqKXMZXTwoL47eavW1Pk2Y6vG4R44LorVm8WG9NDg/913ynJUyA
         pWGzBhZeq2s18NRQlNSbfHjKz/jX3vj0+Cj9U2YjAZUJKa7uOzVzxK0+H2UY1x1LnV75
         3OwtOkBCGogYSlM3y1Tq7KW3ZzhpcpotQ+jVcSBYjSAMFu/MbN24qFYbKPOfLtHbqKFI
         5uHw==
X-Gm-Message-State: AOJu0YwIatMXTK4NFasgUsWUUuc6qzgHFDauTJ0RKnfP+z6G/WgW+mhc
	+3a+3G2Mq0QqvkZMCKRy2aR1GTb5eiCsvmWTwQHbxP1SAfaXIx/a0Ax0qQEZyYnU1e0=
X-Gm-Gg: AeBDiesTQGE20JTPr+JKh5wyR3fj7z7HgEIWzU/Ok/vqwUsjg2aOGO/nNernIT8VPLb
	x8L4txCO/xmvl1ootn0AGzjv2kRlOPN217yxIzzAZegeHvcVBP6drnYkS593kcsLs2OZhU49ig4
	K0hx6O9xzHkqY3s8FCDlOlpHXjJuk2m4CuiFonfuS5iZzZTHJ3aFvUUbv8XjjCc/bkDkL6Iznvh
	YRSYN5LbEu+mLdGEXRV9LF1HRCZrQYwt1f2HZRV+p4QOxn3Eosp+qSK5g0hzNrD723oPrmpqbBi
	uP23mBw+wAbK5dqvJd3eAGy+H+XQkUB76Diy5RYqIBWnp2RLB2gl7+WXizEu9Wm5HI25VC9H4Nj
	DosTVbo1Tsog5wTwEoGxfSIRqICPaO8cCAxgScMhYCzTZw+AhXtnv5dGJRhs1EHWleeXYU543oF
	qc1AYZcf++MZxBHvMnw7C2ippw0uaPhQ5ZYobUCJzPOxFkv0jwM1RBd0Y9R/z7pRjUKIbAObdPc
	IO/PT/KUJrr+dNr8g==
X-Received: by 2002:a05:6122:17a6:b0:56d:439d:d055 with SMTP id 71dfb90a1353d-56dab85b54bmr5476285e0c.4.1775505653049;
        Mon, 06 Apr 2026 13:00:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9b75dsm17542107e0c.12.2026.04.06.13.00.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:00:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Fix not loading local GATT DB from cache
Date: Mon,  6 Apr 2026 16:00:43 -0400
Message-ID: <20260406200043.3447321-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The local GATT DB maybe discover in previous connection and therefore
should be cached as well to be able to decode follow-up connections
where the discovery may not be visible.
---
 monitor/att.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index e76cb44d28f5..e8e0d499a826 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -412,12 +412,24 @@ static bool match_cache_id(const void *data, const void *match_data)
 	return !bacmp(&cache->id, id);
 }
 
-static void gatt_cache_add(struct packet_conn_data *conn, struct gatt_db *db)
+static void gatt_cache_add(struct packet_conn_data *conn, struct gatt_db *ldb,
+							struct gatt_db *rdb)
 {
 	struct gatt_cache *cache;
 	bdaddr_t id;
 	uint8_t id_type;
 
+	/* Attempt to cache local db if not empty */
+	if (!gatt_db_isempty(ldb)) {
+		cache = new0(struct gatt_cache, 1);
+		bacpy(&cache->id, (bdaddr_t *)conn->src);
+		cache->db = gatt_db_ref(ldb);
+		queue_push_tail(cache_list, cache);
+	}
+
+	if (gatt_db_isempty(rdb))
+		return;
+
 	if (!keys_resolve_identity(conn->dst, id.b, &id_type))
 		bacpy(&id, (bdaddr_t *)conn->dst);
 
@@ -429,7 +441,7 @@ static void gatt_cache_add(struct packet_conn_data *conn, struct gatt_db *db)
 
 	cache = new0(struct gatt_cache, 1);
 	bacpy(&cache->id, &id);
-	cache->db = gatt_db_ref(db);
+	cache->db = gatt_db_ref(rdb);
 	queue_push_tail(cache_list, cache);
 }
 
@@ -437,8 +449,7 @@ static void att_conn_data_free(struct packet_conn_data *conn, void *data)
 {
 	struct att_conn_data *att_data = data;
 
-	if (!gatt_db_isempty(att_data->rdb))
-		gatt_cache_add(conn, att_data->rdb);
+	gatt_cache_add(conn, att_data->ldb, att_data->rdb);
 
 	gatt_db_unref(att_data->rdb);
 	gatt_db_unref(att_data->ldb);
@@ -520,6 +531,10 @@ static void load_gatt_db(struct packet_conn_data *conn)
 		cache = queue_find(cache_list, match_cache_id, &id);
 		if (cache)
 			data->rdb = gatt_db_ref(cache->db);
+
+		cache = queue_find(cache_list, match_cache_id, &conn->src);
+		if (cache)
+			data->ldb = gatt_db_ref(cache->db);
 	}
 }
 
-- 
2.53.0

