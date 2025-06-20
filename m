Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961428C2AC
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427601; cv=none; b=pQK2CrSFzLys0NRzvN+Zv6BHXn2zI3msyPYl8oE8TKC458WkzHzp1uUQ2kIGlw3DLekcOyL2SwEBZ9jZ27L3uT0SghL/rMcI7c8zuUQCgKuWEQsfeYkfZwmAuGSsP/74O+upn2ubpE4pkj+4REzP1ZWhsDsxJj1F369Z2QM4YBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427601; c=relaxed/simple;
	bh=z9rGef7wWn0N2cQZEiyj2uW1ogYAUVT0jmq25P7Oty8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2DYziu8szNXsSgAt/5HdNJ7J5hqGsA+ukR2OlPXEQO1WkH41k0FDjogzMuhzkPRoqIqsPuaK7iqBzNtIm1SYrAuOyV8Evmy54pjvr0fCeizEIsqqfLl1aF1udVr5ChBOVQ7rCep1MY4JnMmGNu4lsJbAuPTwZIyWlDvA/jY3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst087.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 20 Jun
 2025 16:52:58 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ v2 2/4] test-vcp: remove unnecessary bt_vcp allocation
Date: Fri, 20 Jun 2025 16:51:44 +0300
Message-ID: <20250620135146.243585-3-k.samburskiy@omp.ru>
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
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194234 [Jun 20 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: k.samburskiy@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	inp1wst087.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
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

Do not create bt_vcp in test_server since it is not necessary for this
test. Also register bt_vcp detached callback to unref and free
objects created by vcp_get_session.
---
 unit/test-vcp.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/unit/test-vcp.c b/unit/test-vcp.c
index 6a61ea2c4..2a6e77eb0 100644
--- a/unit/test-vcp.c
+++ b/unit/test-vcp.c
@@ -33,11 +33,11 @@
 
 struct test_data {
 	struct gatt_db *db;
-	struct bt_vcp *vcp;
 	struct bt_gatt_server *server;
 	struct queue *ccc_states;
 	size_t iovcnt;
 	struct iovec *iov;
+	unsigned int vcp_id;
 };
 
 struct notify {
@@ -82,7 +82,6 @@ static void test_teardown(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
 
-	bt_vcp_unref(data->vcp);
 	bt_gatt_server_unref(data->server);
 	util_iov_free(data->iov, data->iovcnt);
 
@@ -90,6 +89,7 @@ static void test_teardown(const void *user_data)
 
 	queue_destroy(data->ccc_states, free);
 
+	bt_vcp_unregister(data->vcp_id);
 	tester_teardown_complete();
 }
 
@@ -163,6 +163,15 @@ done:
 							sizeof(value));
 }
 
+static void vcp_client_attached(struct bt_vcp *vcp, void *user_data)
+{
+}
+
+static void vcp_client_detached(struct bt_vcp *vcp, void *user_data)
+{
+	bt_vcp_unref(vcp);
+}
+
 static void test_server(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
@@ -185,8 +194,10 @@ static void test_server(const void *user_data)
 	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
 					gatt_notify_cb, data);
 
-	data->vcp = bt_vcp_new(data->db, NULL);
-	g_assert(data->vcp);
+	bt_vcp_add_db(data->db);
+
+	data->vcp_id = bt_vcp_register(vcp_client_attached,
+						vcp_client_detached, NULL);
 
 	data->server = bt_gatt_server_new(data->db, att, 64, 0);
 	g_assert(data->server);
-- 
2.34.1

