Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F22701BB
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018907; cv=pass; b=U1iju/Eurhg/8HklQHSEVs19eL3rLNeDHUfjKqj+2R8oz577XO15ezApAGebKc2CgBPpstK+rrbf3v18ryvuHtAyfR+5V5jOWtcmcz0+x9lnncXsZkhhxaVEHjstV/nkB8CvNX/An7RnB5FnYfnUmotD2h77jRzHwsvKR1/ohPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018907; c=relaxed/simple;
	bh=2b54GFGg3qKM7K86JTnmxiTk7ksLPuPjnlToaxVat1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA9m/QWpQS7/A5+OjH2WeCQgrPa12xaH3ZO9N984wAOeC4THZW7SgszK6Lo3IGz8zDbzwBTzYmpffH4EjEtVOayO3nfEBADyf0+r6qnezPXOCO0uasHgds3IK6edfUjrRVVoBaFittxrvsRxmnFIGmNoT80i5DLteqwceRba+9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=sYngZbOA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="sYngZbOA"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg83ZRmz107P;
	Sat,  6 Dec 2025 13:01:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZd0yfhOCHJsYVAwYjarx4lbaKdZxgHY+u+XuYghqXw=;
	b=sYngZbOACBnI2welpblcw7i7rpl9Nnuimk6pbNIfQKzgA3ANXks+zhYXgDi+Xrl1m8F+Pq
	eiMl6yMqpDRWj6GaM9PobknZVHPD4O3cGc9/DGoIRNF5vszvX8dihWa6nVzU1q7pWx/foR
	VXr8EkYhhO/+QHpj0z5MUz/lMt7/SSY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018902;
	b=UFSDseiuYQR70YAVHntC6XdLNkSQnq0U1Nm3tL4qUfNEw6kpGocinv5ujbk6qabsYhSBri
	X+2nLtyhPjSD9hXS8f5DOa/HJw2BbVfODY4wDhqOdBNDEL3STPrBjvVm7nD5paduCoR5Ka
	Q5OSCsGOI85qwC6H5MhsFz2OsKfQP2A=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZd0yfhOCHJsYVAwYjarx4lbaKdZxgHY+u+XuYghqXw=;
	b=IGTApJSAfCAio/n02sh7qArKvROFDi/A8YbZiMhoOHxFgRuX1JfCf1X/rOGvk9eo9zCPWv
	dmcVVS7PS3/X0WsocvMmvnLsYsU3h0znmeZiA5mcqHhTAq5cXKETRCmorpfTqWzLW638h1
	/ceaVBDjNCwWxLRxfQfpQUAuu9dwP3E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 08/11] test-gmap: test removing, adding, and changing role
Date: Sat,  6 Dec 2025 13:01:24 +0200
Message-ID: <7178b86115314eac2d438864c4dc2c72c7bb6921.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When role is changed the old characteristic is removed, which shifts the
attribute handles.
---
 unit/test-gmap.c | 89 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/unit/test-gmap.c b/unit/test-gmap.c
index 6102ce65d..ce9eeb8f9 100644
--- a/unit/test-gmap.c
+++ b/unit/test-gmap.c
@@ -32,6 +32,7 @@
 
 struct test_config {
 	uint8_t role;
+	uint8_t old_role;
 	uint32_t features;
 	const struct iovec *setup_data;
 	const size_t setup_data_len;
@@ -107,22 +108,22 @@ static void test_teardown(const void *user_data)
  * ATT: Read By Group Type Response (0x11) len 37
  *   Attribute data length: 6
  *   Attribute group list: 1 entries
- *   Handle range: 0x0001-0x000f
+ *   Handle range: 0x0001-0x000b
  *   UUID: Gaming Audio Service (0x1858)
  * ATT: Read By Group Type Request (0x10) len 6
- *   Handle range: 0x0006-0xffff
+ *   Handle range: 0x000c-0xffff
  *   Attribute group type: Primary Service (0x2800)
  * ATT: Error Response (0x01) len 4
  *   Read By Group Type Request (0x10)
  *   Handle: 0x0004
  *   Error: Attribute Not Found (0x0a)
  */
-#define GMAS_PRIMARY_SERVICE \
+#define GMAS_PRIMARY_SERVICE(base) \
 	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
 	IOV_DATA(0x11, 0x06, \
-		0x01, 0x00, 0x0f, 0x00, 0x58, 0x18), \
-	IOV_DATA(0x10, 0x10, 0x00, 0xff, 0xff, 0x00, 0x28), \
-	IOV_DATA(0x01, 0x10, 0x10, 0x00, 0x0a)
+		0x01 + base, 0x00, 0x0b + base, 0x00, 0x58, 0x18), \
+	IOV_DATA(0x10, 0x0c + base, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x0c + base, 0x00, 0x0a)
 
 
 /* ATT: Read By Group Type Request (0x10) len 6
@@ -145,9 +146,9 @@ static void test_teardown(const void *user_data)
  *   Handle: 0x0001
  *   Error: Attribute Not Found (0x0a)
  */
-#define GMAS_INCLUDE \
-	IOV_DATA(0x08, 0x01, 0x00, 0x0f, 0x00, 0x02, 0x28), \
-	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+#define GMAS_INCLUDE(base) \
+	IOV_DATA(0x08, 0x01 + base, 0x00, 0x0b + base, 0x00, 0x02, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x01 + base, 0x00, 0x0a)
 
 /* ATT: Read By Type Request (0x08) len 6
  *   Handle range: 0x0001-0x0003
@@ -182,15 +183,15 @@ static void test_teardown(const void *user_data)
  */
 #define IOV_CONTENT(data...)	data
 
-#define GMAS_FIND_CHRC(uuid) \
-	IOV_DATA(0x08, 0x01, 0x00, 0x0f, 0x00, 0x03, 0x28), \
+#define GMAS_FIND_CHRC(uuid, base) \
+	IOV_DATA(0x08, 0x01 + base, 0x00, 0x0b + base, 0x00, 0x03, 0x28), \
 	IOV_DATA(0x09, 0x07, \
-		0x02, 0x00, 0x02, 0x03, 0x00, 0x00, 0x2c, \
-		0x04, 0x00, 0x02, 0x05, 0x00, uuid), \
-	IOV_DATA(0x08, 0x05, 0x00, 0x0f, 0x00, 0x03, 0x28), \
-	IOV_DATA(0x01, 0x08, 0x05, 0x00, 0x0a), \
-	IOV_DATA(0x04, 0x06, 0x00, 0x0f, 0x00), \
-	IOV_DATA(0x01, 0x04, 0x06, 0x00, 0x0a)
+		0x02 + base, 0x00, 0x02, 0x03 + base, 0x00, 0x00, 0x2c, \
+		0x04 + base, 0x00, 0x02, 0x05 + base, 0x00, uuid), \
+	IOV_DATA(0x08, 0x05 + base, 0x00, 0x0b + base, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x05 + base, 0x00, 0x0a), \
+	IOV_DATA(0x04, 0x06 + base, 0x00, 0x0b + base, 0x00), \
+	IOV_DATA(0x01, 0x04, 0x06 + base, 0x00, 0x0a)
 
 #define UGG_UUID	0x01, 0x2c
 #define UGT_UUID	0x02, 0x2c
@@ -214,19 +215,19 @@ static void test_teardown(const void *user_data)
 	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
 
 
-#define GMAS_SETUP(uuid) \
+#define GMAS_SETUP(uuid, base) \
 	GMAS_MTU_FEAT, \
-	GMAS_PRIMARY_SERVICE, \
+	GMAS_PRIMARY_SERVICE(base), \
 	GMAS_SECONDARY_SERVICE, \
-	GMAS_INCLUDE, \
-	GMAS_FIND_CHRC(IOV_CONTENT(uuid)), \
+	GMAS_INCLUDE(base), \
+	GMAS_FIND_CHRC(IOV_CONTENT(uuid), base), \
 	GMAS_DATABASE_HASH
 
 /* GATT Discover All procedure */
-static const struct iovec setup_data_ugg[] = { GMAS_SETUP(UGG_UUID) };
-static const struct iovec setup_data_ugt[] = { GMAS_SETUP(UGT_UUID) };
-static const struct iovec setup_data_bgs[] = { GMAS_SETUP(BGS_UUID) };
-static const struct iovec setup_data_bgr[] = { GMAS_SETUP(BGR_UUID) };
+static const struct iovec setup_data_ugg[] = { GMAS_SETUP(UGG_UUID, 0) };
+static const struct iovec setup_data_ugt[] = { GMAS_SETUP(UGT_UUID, 0) };
+static const struct iovec setup_data_bgs[] = { GMAS_SETUP(BGS_UUID, 0) };
+static const struct iovec setup_data_bgr[] = { GMAS_SETUP(BGR_UUID, 0) };
 
 static void setup_complete_cb(const void *user_data)
 {
@@ -252,6 +253,13 @@ static void test_setup_server(const void *user_data)
 	data->gmap = bt_gmap_add_db(db);
 	bt_gmap_set_debug(data->gmap, print_debug, "gmap:", NULL);
 
+	if (data->cfg->old_role) {
+		bt_gmap_set_role(data->gmap, data->cfg->old_role);
+		bt_gmap_set_features(data->gmap, 0xffffffff);
+		bt_gmap_set_role(data->gmap, data->cfg->role);
+		bt_gmap_set_role(data->gmap, 0);
+	}
+
 	bt_gmap_set_role(data->gmap, data->cfg->role);
 	bt_gmap_set_features(data->gmap, data->cfg->features);
 
@@ -466,6 +474,29 @@ static void test_gmap_cl(void)
 #define SGGIT_CHA_ROLE	READ_ROLE(0x01)
 #define SGGIT_CHA_FEAT	READ_FEAT(0x01)
 
+const struct test_config cfg_read_ugg_re_add = {
+	.old_role = BT_GMAP_ROLE_UGG,
+	.role = BT_GMAP_ROLE_UGG,
+	.features = BT_GMAP_UGG_MULTIPLEX,
+	.setup_data = setup_data_ugg,
+	.setup_data_len = ARRAY_SIZE(setup_data_ugg),
+};
+
+#define SGGIT_CHA_FEAT_CHANGE \
+	READ_CHRC(IOV_CONTENT(0x0b + FEAT_HND), 0x01)
+
+static const struct iovec setup_data_ugg_change[] = {
+	GMAS_SETUP(UGG_UUID, 0x0b)
+};
+
+const struct test_config cfg_read_ugg_change = {
+	.old_role = BT_GMAP_ROLE_UGT,
+	.role = BT_GMAP_ROLE_UGG,
+	.features = BT_GMAP_UGG_MULTIPLEX,
+	.setup_data = setup_data_ugg_change,
+	.setup_data_len = ARRAY_SIZE(setup_data_ugg_change),
+};
+
 static void test_gmap_sr(void)
 {
 	/* Sec. 4.6.2 GMA Server */
@@ -484,6 +515,14 @@ static void test_gmap_sr(void)
 	define_test("GMAP/SR/SGGIT/CHA/BV-05-C [Characteristic GGIT - BGR "
 						"Features]",
 		test_setup_server, test_server, &cfg_read_bgr, SGGIT_CHA_FEAT);
+
+	define_test("GMAP/SR/SGGIT/CHA/BLUEZ-01-C [Re-add UGG Features]",
+		test_setup_server, test_server, &cfg_read_ugg_re_add,
+		SGGIT_CHA_FEAT);
+
+	define_test("GMAP/SR/SGGIT/CHA/BLUEZ-02-C [Change UGT -> UGG]",
+		test_setup_server, test_server, &cfg_read_ugg_change,
+		SGGIT_CHA_FEAT_CHANGE);
 }
 
 int main(int argc, char *argv[])
-- 
2.51.1

