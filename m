Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9528E578
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427607; cv=none; b=FVwYkUWpXV63VU4hYGnuBwKhlLsFGWWUZh910UMzJFMTzxPB8qZUVOAAG/XKpKEzxbqtvYKef6o+zWc/CNnY1oSEHM0bA4O0Ha34t/aeEvA5U3V47EssLi6/5ARNXZhWVw4g/WEtkDQrIB02oFq2WKfambNZ0h+qwQkYNPv4BlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427607; c=relaxed/simple;
	bh=6VD5gyFoAOqfGuOKENAOfGP9CPwlGZS9E56CTopWbzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1h1bC0Z5kENx28hdmJDMTqlEOg644AebybvlMHr30PXeneqDyHqBgM7Axsqf/vLhaBcY15qoZrnBCuGj8yS2N/+0eDYisuHkpSGjmBZoUqiy14ZB23b4hSQlmrg206B7EVnKo9b7T/gHalzZP6DPoHmWfWPaRJoSdUgdIQh+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst087.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 20 Jun
 2025 16:53:07 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ v2 3/4] test-micp: remove unnecessary bt_micp allocation
Date: Fri, 20 Jun 2025 16:51:45 +0300
Message-ID: <20250620135146.243585-4-k.samburskiy@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620135146.243585-1-k.samburskiy@omp.ru>
References: <20250620135146.243585-1-k.samburskiy@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/20/2025 13:44:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 194234 [Jun 20 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: k.samburskiy@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	inp1wst087.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2
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
X-KSE-Antiphishing-Bases: 06/20/2025 13:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/20/2025 9:37:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Do not create bt_micp in test_server since it is not necessary for this
test. Also register bt_micp detached callback to unref and free
objects created by micp_get_session.
---
 unit/test-micp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/unit/test-micp.c b/unit/test-micp.c
index a7fc7fb32..87fde8ed0 100644
--- a/unit/test-micp.c
+++ b/unit/test-micp.c
@@ -33,12 +33,12 @@
 
 struct test_data_mics {
 	struct gatt_db *db;
-	struct bt_micp *micp;
 	struct bt_gatt_server *server;
 	struct bt_gatt_client *client;
 	struct queue *ccc_states;
 	size_t iovcnt;
 	struct iovec *iov;
+	unsigned int micp_id;
 };
 
 struct test_data_micp {
@@ -98,10 +98,10 @@ static void test_teardown_mics(const void *user_data)
 {
 	struct test_data_mics *data = (void *)user_data;
 
-	bt_micp_unref(data->micp);
 	bt_gatt_server_unref(data->server);
 	util_iov_free(data->iov, data->iovcnt);
 	gatt_db_unref(data->db);
+	bt_micp_unregister(data->micp_id);
 
 	queue_destroy(data->ccc_states, free);
 
@@ -269,6 +269,15 @@ done:
 	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
 }
 
+static void micp_attached(struct bt_micp *micp, void *user_data)
+{
+}
+
+static void micp_detached(struct bt_micp *micp, void *user_data)
+{
+	bt_micp_unref(micp);
+}
+
 static void test_server(const void *user_data)
 {
 	struct test_data_mics *data = (void *)user_data;
@@ -291,8 +300,9 @@ static void test_server(const void *user_data)
 	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
 					gatt_notify_cb, data);
 
-	data->micp = bt_micp_new(data->db, NULL);
-	g_assert(data->micp);
+	bt_micp_add_db(data->db);
+
+	data->micp_id = bt_micp_register(micp_attached, micp_detached, NULL);
 
 	data->server = bt_gatt_server_new(data->db, att, 64, 0);
 	g_assert(data->server);
-- 
2.34.1

