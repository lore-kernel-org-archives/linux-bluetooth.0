Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591F28383
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0o6fSsE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704980404;
	bh=6k6Fw/ZN8DSFiOozrrh/XjbQifPhuWOnF6C216jMUQM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=0o6fSsE8DuB31/dSt6Z9z6DnqyOfNDOi1+eqm8H5HckDE5P/zYVwSQKXCeU1oH93W
	 L6ZjxOFpMw3LNbV4fMwgMqqdrK3v8PDmJujUP8JXYjHA6hNqANAqKYLpifrb2SMI6f
	 YgKDxizK1kfWIgqEI36i9ZMVqktdpUL1ocd43bkLGVghHXj3Sf6p/XL54I8UTZuwBO
	 ITHskaARMe52ZprzqKp0IrOxQUsF5ea9ALx2khCS35f4FGFfGpHp1azbXZJfZD8N0w
	 Mnqet2ZtLe/fqDxdNnkfCJ0SSFsVso5Y1KByeo6XGGTSD7IcllRCJpxR1dOsUgBt6w
	 Z5ObuOeL+NO+A==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB0BD3781FE5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 13:40:04 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] unit/test-gatt: Add unordered setup db test
Date: Thu, 11 Jan 2024 14:39:55 +0100
Message-Id: <20240111133955.65686-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111133955.65686-1-frederic.danis@collabora.com>
References: <20240111133955.65686-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Verify that gatt_db_get_hash() does not crash when services are added
in an unordered way.
---
 unit/test-gatt.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index f92d860c4..e536cd908 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1908,6 +1908,60 @@ static struct gatt_db *make_test_spec_large_db_1(void)
 	return make_db(specs);
 }
 
+/*
+ * Tiny database which fits into a single minimum sized-pdu with services
+ * added in the following order to check ability to create hash db:
+ * - one secondary service at handle 0x0003,
+ * - one primary service at the max handle,
+ * - one primary service at handle 0x0001.
+ */
+
+static struct gatt_db *make_test_unordered_setup_db(void)
+{
+	const struct att_handle_spec specs[] = {
+		SECONDARY_SERVICE(0x0003, DEVICE_INFORMATION_UUID, 16),
+		CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
+						BT_ATT_PERM_READ |
+						BT_ATT_PERM_WRITE,
+						BT_GATT_CHRC_PROP_READ |
+						BT_GATT_CHRC_PROP_NOTIFY |
+						BT_GATT_CHRC_PROP_INDICATE |
+						BT_GATT_CHRC_PROP_EXT_PROP,
+						"BlueZ"),
+		DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ |
+						BT_ATT_PERM_WRITE, 0x00, 0x00),
+		DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
+							"Manufacturer Name"),
+		DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ, 0x01,
+									0x00),
+		CHARACTERISTIC_STR(GATT_CHARAC_SOFTWARE_REVISION_STRING,
+						BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ |
+						BT_GATT_CHRC_PROP_INDICATE,
+						"5.59"),
+		DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ
+			| BT_ATT_PERM_WRITE, 0x00, 0x00),
+
+		PRIMARY_SERVICE(0xFFFF - 9 + 1, GAP_UUID, 9),
+		INCLUDE(0x0003),
+		CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
+							BT_GATT_CHRC_PROP_READ,
+							"BlueZ Unit Tester"),
+		CHARACTERISTIC(0000B009-0000-0000-0123-456789abcdef,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_EXT_PROP, 0x09),
+		DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ, 0x01,
+									0x00),
+		CHARACTERISTIC(GATT_CHARAC_APPEARANCE, BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ, 0x00, 0x00),
+		PRIMARY_SERVICE(0x0001, DEVICE_INFORMATION_UUID, 1),
+		{ }
+	};
+
+	return make_db(specs);
+}
+
 static void test_client(gconstpointer data)
 {
 	create_context(512, data);
@@ -2345,10 +2399,22 @@ static const struct test_step test_indication_server_1 = {
 	.length = 0x03,
 };
 
+static void test_hash_db(gconstpointer data)
+{
+	struct context *context = create_context(512, data);
+
+	/* test that gatt_db_get_hash is able to manage unordered db and
+	 * doesn't crash
+	 */
+	gatt_db_get_hash(context->server_db);
+
+	context_quit(context);
+}
+
 int main(int argc, char *argv[])
 {
 	struct gatt_db *service_db_1, *service_db_2, *service_db_3;
-	struct gatt_db *ts_small_db, *ts_large_db_1;
+	struct gatt_db *ts_small_db, *ts_large_db_1, *ts_tail_db;
 
 	tester_init(&argc, &argv);
 
@@ -2357,6 +2423,7 @@ int main(int argc, char *argv[])
 	service_db_3 = make_service_data_3_db();
 	ts_small_db = make_test_spec_small_db();
 	ts_large_db_1 = make_test_spec_large_db_1();
+	ts_tail_db = make_test_unordered_setup_db();
 
 	/*
 	 * Server Configuration
@@ -4487,5 +4554,9 @@ int main(int argc, char *argv[])
 			raw_pdu(0xff, 0x00),
 			raw_pdu());
 
+	define_test_server("/robustness/hash-db",
+			test_hash_db, ts_tail_db, NULL,
+			{});
+
 	return tester_run();
 }
-- 
2.34.1

