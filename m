Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035562DE6F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914417; cv=pass; b=bZEj4IepLh6VUYLQZTXdWd1lBd46/FWmSsBZPGLkGflBu681aLH5bb+GNBNep3QDEAvl0rKGxfaMLE8ILTIK48Of2ZyUIuoXSB9G2DDTPYdDNhoCvoWvUTx5iFKEtAUAce6A3vVM5xDZtKx/wHYwcpNWytuN7MxkL9xmAPAYmbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914417; c=relaxed/simple;
	bh=dEFdgsPcsokAEeFW5J5CnsVxZ9juWzypZilURxumI28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAOE8BxLKKD4zPXERehimujdRqUhhdAy9jjCxKRebMjQ/x3oA6ki7V6wHJl7roWmkMkfrZdSULsAseiea6eA+eXKClldamhZiOzv/JyP1X3T/rFKt4fn0nlPRkrYe2do1sk3TXx3BiFMIXlgqJH0PYhv4fbmEaLJyjzgoaNS0rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=TX1ldE9c; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="TX1ldE9c"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dW6rR1DbPzyZZ;
	Tue, 16 Dec 2025 21:46:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765914407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3FoOXYkEVlxdGXAFxdM1e5/PClQHPJ7fgZvZy09kIY=;
	b=TX1ldE9clEBPItogD8kzcHErr/IwVtddJLe8Z4lfDuTqgITl1sXQagSxLiliibMVzPHK4d
	ogd4eatzbXo+RJHhz2mmpvDEFaNuUlfDxnj17GnzEKfARHp+1HFuhWHPgIS1sxfAeuLmS3
	hH4YsCFKHmKxMpTAJs4ENm7spkZhQu4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765914407;
	b=FHOESGuZZiOs/ZF4gqBAn1WdyysGih4ba0hzOFH/Mbwx7H1L9iji7SgpwpHuwfqnoYvIwM
	/hVzpLSgawmn+C+rsLF+9ea009tJIYmXdTdqhomZcuLC/bpAydF8X07iqkbBTywn1Cox08
	u5/FkO9MCkvrbaOeujIa86Sipm3wMTc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765914407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3FoOXYkEVlxdGXAFxdM1e5/PClQHPJ7fgZvZy09kIY=;
	b=RUEc7tOfEp2Uz/le/MjHDalsNMFgiRLeqtyQcvg6A9docsEdFM6xWdnuGDBdLpPLVBbQG8
	Lb9bdW0IpsNunsl+22FQ4ujLxL/u0HWwCtaqSnMPJrcj0m/pR5P/YXRGxH2qvBf1LKAhF4
	QbkLDKM4x9G8srWwtn0H97UT742xVAA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] test-mcp: add tests for long value reading
Date: Tue, 16 Dec 2025 21:46:44 +0200
Message-ID: <559a1be7de7c006742bf80438550759fec118b79.1765914148.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
References: <977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add server tests for handling the Value Changed During Read Long error.

Add similar client tests.
---
 src/shared/mcp.c |   5 ++
 src/shared/mcp.h |   1 +
 unit/test-mcp.c  | 183 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index 9f8952af1..a25d7b5a2 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -2118,3 +2118,8 @@ bool bt_mcp_add_listener(struct bt_mcp *mcp, uint8_t ccid,
 	queue_push_tail(service->listeners, listener);
 	return true;
 }
+
+struct bt_gatt_client *bt_mcp_test_util_get_client(struct bt_mcp *mcp)
+{
+	return mcp->client;
+}
diff --git a/src/shared/mcp.h b/src/shared/mcp.h
index 937afb6d3..8179c0098 100644
--- a/src/shared/mcp.h
+++ b/src/shared/mcp.h
@@ -167,3 +167,4 @@ void bt_mcs_unregister_all(struct gatt_db *db);
 
 /* For tests: */
 void bt_mcs_test_util_reset_ccid(void);
+struct bt_gatt_client *bt_mcp_test_util_get_client(struct bt_mcp *mcp);
diff --git a/unit/test-mcp.c b/unit/test-mcp.c
index b05630185..7d922bb83 100644
--- a/unit/test-mcp.c
+++ b/unit/test-mcp.c
@@ -586,6 +586,31 @@ static void test_client(const void *user_data)
 	IOV_DATA(0x0a, HND(hnd)), \
 	IOV_DATA(0x0b, value)
 
+/* ATT: Read Blob Request (0x0c)
+ * ATT: Read Blob Response (0x0d)
+ */
+
+#define READ_BLOB_CHRC(hnd, off, value...) \
+	IOV_DATA(0x0c, HND(hnd), (off) & 0xff, (off) >> 8), \
+	IOV_DATA(0x0d, value)
+
+#define READ_BLOB_ERR_CHRC(hnd, off, err) \
+	IOV_DATA(0x0c, HND(hnd), (off) & 0xff, (off) >> 8), \
+	IOV_DATA(0x01, 0x0c, HND(hnd), err)
+
+#define BLOB_DATA_MTU_1(v) \
+	v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, \
+	v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, \
+	v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, \
+	v, v, v, v, v, v, v, v, v, v, v, v, v, v, v
+
+#define BLOB_DATA_MTU_3(v) \
+	v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, \
+	v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, \
+	v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, \
+	v, v, v, v, v, v, v, v, v, v, v, v, v
+
+
 /* ATT: Write Command (0x52) len 2
  */
 
@@ -1369,11 +1394,100 @@ const struct test_config cfg_cl_bluez_1_reread = {
 	.gmcs = false,
 };
 
+#define CL_BLUEZ_2_REREAD \
+	NOTIFY_CHRC(TRACK_CHG), \
+	READ_CHRC(TRACK_TITLE, BLOB_DATA_MTU_1('y')), \
+	/* Value change during long read */ \
+	READ_BLOB_ERR_CHRC(TRACK_TITLE, 0x40 - 1, 0x80), \
+	READ_CHRC(TRACK_DUR, 0xff, 0xff, 0xff, 0xff), \
+	READ_CHRC(TRACK_POS, 0xff, 0xff, 0xff, 0xff), \
+	READ_CHRC(PLAY_SPEED, 0x00), \
+	READ_CHRC(SEEK_SPEED, 0x00), \
+	READ_CHRC(PLAY_ORDER, 0x04), \
+	READ_CHRC(PLAY_ORDER_SUPP, 0x18, 0x00), \
+	READ_CHRC(CP_SUPP, SPLIT_INT32(0x01)), \
+	/* Track change notification -> reread */ \
+	NOTIFY_CHRC(TRACK_CHG), \
+	READ_CHRC(TRACK_TITLE, BLOB_DATA_MTU_1('x')), \
+	READ_BLOB_CHRC(TRACK_TITLE, 0x40 - 1, 'x', 'x', 'x'), \
+	READ_CHRC(TRACK_DUR, 0xff, 0xff, 0xff, 0xff), \
+	READ_CHRC(TRACK_POS, 0xff, 0xff, 0xff, 0xff), \
+	READ_CHRC(PLAY_SPEED, 0x00), \
+	READ_CHRC(SEEK_SPEED, 0x00), \
+	READ_CHRC(PLAY_ORDER, 0x04), \
+	READ_CHRC(PLAY_ORDER_SUPP, 0x18, 0x00), \
+	READ_CHRC(CP_SUPP, SPLIT_INT32(0x01)), \
+	IOV_NULL
+
+#define CL_BLUEZ_3_REREAD \
+	NOTIFY_CHRC(TRACK_TITLE, BLOB_DATA_MTU_3('y')), \
+	READ_CHRC(TRACK_TITLE, BLOB_DATA_MTU_1('y')), \
+	/* Changed during read -> notification -> reread */ \
+	READ_BLOB_ERR_CHRC(TRACK_TITLE, 0x40 - 1, 0x80), \
+	NOTIFY_CHRC(TRACK_TITLE, BLOB_DATA_MTU_3('x')), \
+	READ_CHRC(TRACK_TITLE, BLOB_DATA_MTU_1('x')), \
+	READ_BLOB_CHRC(TRACK_TITLE, 0x40 - 1, 'x', 'x', 'x'), \
+	IOV_NULL
+
+static void cl_reread_long_idle(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	if (data->step == 2)
+		tester_test_passed();
+}
+
+static void cl_reread_long_track_title(void *user_data, const uint8_t *value,
+								uint16_t length)
+{
+	struct test_data *data = user_data;
+	const char new_value[0x42] = { [0 ... 0x41] = 'x' };
+
+	if (strncmp((void *)value, "Title", length) == 0 && data->step == 0) {
+		data->step++;
+	} else if (data->step == 1 && length == 0x42 &&
+				!memcmp((void *)value, new_value, length)) {
+		data->step++;
+
+		/* Wait for all reads, to make sure there are no extra */
+		bt_gatt_client_idle_register(
+			bt_mcp_test_util_get_client(data->mcp),
+			cl_reread_long_idle, data, NULL);
+	} else {
+		FAIL_TEST();
+	}
+}
+
+const struct test_config cfg_cl_bluez_2_reread = {
+	.listener_cb = &(struct bt_mcp_listener_callback) {
+		.track_title = cl_reread_long_track_title,
+	},
+	.setup_data = setup_data_mcs,
+	.setup_data_len = ARRAY_SIZE(setup_data_mcs),
+	.gmcs = false,
+};
+
+const struct test_config cfg_cl_bluez_3_reread = {
+	.listener_cb = &(struct bt_mcp_listener_callback) {
+		.track_title = cl_reread_long_track_title,
+	},
+	.setup_data = setup_data_gmcs,
+	.setup_data_len = ARRAY_SIZE(setup_data_gmcs),
+	.gmcs = true,
+};
+
+
 static void testgroup_cl_extra(void)
 {
 	define_test("MCP/CL/BLUEZ-1 [Reread On Track Change, No Notify]",
 		test_setup, test_client,
 		&cfg_cl_bluez_1_reread, CL_BLUEZ_1_REREAD);
+	define_test("MCP/CL/BLUEZ-2 [Long Value Reread, Track Changed]",
+		test_setup, test_client,
+		&cfg_cl_bluez_2_reread, CL_BLUEZ_2_REREAD);
+	define_test("MCP/CL/BLUEZ-3 [Long Value Reread, Notify]",
+		test_setup, test_client,
+		&cfg_cl_bluez_3_reread, CL_BLUEZ_3_REREAD);
 }
 
 /*
@@ -1846,6 +1960,74 @@ static void testgroup_sr_mcp(void)
 	 */
 }
 
+
+static void sr_spn_value(struct test_data *data, struct iovec *buf, size_t size,
+								uint16_t uuid)
+{
+	/* Longer than MTU */
+	memset(buf->iov_base, 'x' + data->step, 0x42);
+	buf->iov_len = 0x42;
+
+	/* Long value changed during read */
+	if (data->step == 1) {
+		data->step--;
+		bt_mcs_changed(data->mcs, uuid);
+	}
+}
+
+static void sr_spn_media_player_name(void *data, struct iovec *buf, size_t size)
+{
+	sr_spn_value(data, buf, size, MCS_MEDIA_PLAYER_NAME_CHRC_UUID);
+}
+
+static void sr_spn_track_title(void *data, struct iovec *buf, size_t size)
+{
+	sr_spn_value(data, buf, size, MCS_TRACK_TITLE_CHRC_UUID);
+}
+
+const struct test_config cfg_mcs_sr_spn = {
+	.mcs_cb = &(struct bt_mcs_callback) {
+		.media_player_name = sr_spn_media_player_name,
+		.track_title = sr_spn_track_title,
+		.debug = mcs_debug,
+	},
+	.setup_data = setup_data_server_mcs,
+	.setup_data_len = ARRAY_SIZE(setup_data_server_mcs),
+	.gmcs = false,
+};
+
+#define MCS_SR_SPN_PROCEDURE(chrc) \
+	READ_CHRC(chrc, BLOB_DATA_MTU_1('y')), \
+	NOTIFY_CHRC(chrc, BLOB_DATA_MTU_3('x')), \
+	READ_BLOB_ERR_CHRC(chrc, 0x40 - 1, 0x80), \
+	READ_CHRC(chrc, BLOB_DATA_MTU_1('x')), \
+	READ_BLOB_CHRC(chrc, 0x40 - 1, 'x', 'x', 'x')
+
+#define MCS_SR_SPN_BV_01_C	MCS_SR_SPN_PROCEDURE(NAME)
+#define MCS_SR_SPN_BV_02_C	MCS_SR_SPN_PROCEDURE(TRACK_TITLE)
+
+static void test_sr_spn(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	data->step = 1;
+	test_server(data);
+}
+
+static void testgroup_sr_spn(void)
+{
+	/* Only the MCS tests. No point in GMCS as only svc uuid changes */
+
+	/* MCS.TS Sec 4.5 Update Characteristic - Oversized values */
+	define_test("MCS/SR/SPN/BV-01-C [Update Media Player Name - Oversized "
+								"Value]",
+		test_setup_server, test_sr_spn,
+		&cfg_mcs_sr_spn, MCS_SR_SPN_BV_01_C);
+	define_test("MCS/SR/SPN/BV-02-C [Update Track Title - Oversized Value]",
+		test_setup_server, test_sr_spn,
+		&cfg_mcs_sr_spn, MCS_SR_SPN_BV_02_C);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -1854,6 +2036,7 @@ int main(int argc, char *argv[])
 	testgroup_cl_extra();
 	testgroup_sr_sggit();
 	testgroup_sr_mcp();
+	testgroup_sr_spn();
 
 	return tester_run();
 }
-- 
2.51.1

