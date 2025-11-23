Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1405147C9B
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914653; cv=pass; b=jjGSxG5UY0IZWOcOA7uSI++/UVz5UFSW4naYlsZ2AiN+3LJ2Hu/4FGkVRprQ+tuw1rEPq7Nf1al69+KSevtAzzCBl+QOO8RNSkFrk7rhA6ZdGBrV7Tct1ZuENxcodhVso8FGb+HnKdyrYmerCrt6B6pqouYuwdvMXmiAltuzD7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914653; c=relaxed/simple;
	bh=fg0Y+VwuXrwVbzH7eLx6181FUJ8dhWJAUgVaE8bYlws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIGjSJnjFQ8b11V8dLRM1Pw0olxvuJIVGKP/b62eXwkpvitQiE7VoVnt2z8vyB4+jwde5rKNheYzrDf4BlzsD5OAonOUG3Fb6e8JvpemJIgBMSodIQLvh1QDEcP7BV/5YjspsJlmBrFGOqpB+hPIrg3bBb+Ypk7EzGURcl0ZpWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=EpvBvK6j; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="EpvBvK6j"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHQ02Myz108j;
	Sun, 23 Nov 2025 18:17:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yed8jVBZTqF7NlCeqC7Bi81psIlGVTgjeq263RiW1Xg=;
	b=EpvBvK6jwx235T3U3Mf/q6DEEi9zRfD01CZoJZBCyn1Ab6Y75HOYey/S+G1/Rv0EbH149j
	cKLJXdLSttZbJIy+m/11+qaVsqUlpoe6PGyFovSkbPPXjm6yWCjvXkWe98rgaTlur+1yHd
	VIJsoiB0qYebW09r5niRYCk3b/hyLVw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914642;
	b=T1gPff2SlWU5F4YYeUmJNxVfEM3x+SxMtlbvKie3d0yYwekRwMLHPg7Ess3Wkr7KUFsKK0
	tzpJ9MAd1FNWr10JORCG61rtzZ00NpF+fuIi3++4vc+13cuP3XoZMOdCKYrDtKDpKEe84R
	96mK+XCaiSBoTh8nu/zkhUs8h1je4L4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yed8jVBZTqF7NlCeqC7Bi81psIlGVTgjeq263RiW1Xg=;
	b=Sx2LEkXdoNOJHnazY7mLIlySeKgcrvS8IjxVCcEeQmznp55RLZFrpmOxshSzO1tRkk8s+q
	LMk+AeoeByd5QaHmL4WffceaOLZ/H169qj0TAbGhtSynkqSrWP+NIC5e9zibti6SQ+q/UA
	eWQpRWYwjlXZyO9r5Fs8Q6zbM1aJwc4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 02/10] test-tmap: add test for TMAP Service
Date: Sun, 23 Nov 2025 18:17:07 +0200
Message-ID: <28236b3539952fab7fad5382a8f1d42fbee22692.1763914558.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763914558.git.pav@iki.fi>
References: <cover.1763914558.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests on TMAP service for reading the role attribute.
---
 .gitignore       |   1 +
 Makefile.am      |   6 +
 unit/test-tmap.c | 378 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)
 create mode 100644 unit/test-tmap.c

diff --git a/.gitignore b/.gitignore
index c0aaafaea..48bf72a4a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,6 +118,7 @@ unit/test-hog
 unit/test-bap
 unit/test-bass
 unit/test-battery
+unit/test-tmap
 tools/mgmt-tester
 tools/smp-tester
 tools/gap-tester
diff --git a/Makefile.am b/Makefile.am
index d2e67012d..11e632c02 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -702,6 +702,12 @@ unit_test_vcp_SOURCES = unit/test-vcp.c $(btio_sources)
 unit_test_vcp_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
+unit_tests += unit/test-tmap
+
+unit_test_tmap_SOURCES = unit/test-tmap.c $(btio_sources)
+unit_test_tmap_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 unit_tests += unit/test-battery
 
 unit_test_battery_SOURCES = unit/test-battery.c
diff --git a/unit/test-tmap.c b/unit/test-tmap.c
new file mode 100644
index 000000000..481453112
--- /dev/null
+++ b/unit/test-tmap.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Pauli Virtanen. All rights reserved.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <fcntl.h>
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/io.h"
+#include "src/shared/tmap.h"
+
+struct test_config {
+	uint16_t role;
+};
+
+struct test_data {
+	struct gatt_db *db;
+	struct bt_gatt_server *server;
+	struct bt_gatt_client *client;
+	struct bt_tmap *tmap;
+	size_t iovcnt;
+	struct iovec *iov;
+	const struct test_config *cfg;
+};
+
+#define iov_data(args...) ((const struct iovec[]) { args })
+
+#define define_test(name, setup, function, _cfg, args...)	\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data data;			\
+		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.cfg = _cfg;				\
+		tester_add(name, &data, setup, function,	\
+				test_teardown);			\
+	} while (0)
+
+static void print_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	if (tester_use_debug())
+		tester_debug("%s%s", prefix, str);
+}
+
+static void test_teardown(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	bt_gatt_client_unref(data->client);
+
+	bt_gatt_server_unref(data->server);
+	util_iov_free(data->iov, data->iovcnt);
+
+	gatt_db_unref(data->db);
+
+	bt_tmap_unref(data->tmap);
+	tester_teardown_complete();
+}
+
+/* ATT: Exchange MTU Response (0x03) len 2
+ *   Server RX MTU: 64
+ * ATT: Exchange MTU Request (0x02) len 2
+ *    Client RX MTU: 64
+ * ATT: Read By Type Request (0x08) len 6
+ *   Handle range: 0x0001-0xffff
+ *   Attribute type: Server Supported Features (0x2b3a)
+ * ATT: Error Response (0x01) len 4
+ *   Read By Type Request (0x08)
+ *   Handle: 0x0001
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define TMAS_MTU_FEATURES \
+	IOV_DATA(0x02, 0x40, 0x00), \
+	IOV_DATA(0x03, 0x40, 0x00), \
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b), \
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+/* ATT: Read By Group Type Request (0x10) len 6
+ *   Handle range: 0x0001-0xffff
+ *   Attribute group type: Primary Service (0x2800)
+ * ATT: Read By Group Type Response (0x11) len 37
+ *   Attribute data length: 6
+ *   Attribute group list: 1 entries
+ *   Handle range: 0x0001-0x0003
+ *   UUID: Telephony and Media Audio (0x1855)
+ * ATT: Read By Group Type Request (0x10) len 6
+ *   Handle range: 0x0004-0xffff
+ *   Attribute group type: Primary Service (0x2800)
+ * ATT: Error Response (0x01) len 4
+ *   Read By Group Type Request (0x10)
+ *   Handle: 0x0004
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define TMAS_PRIMARY_SERVICE \
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x11, 0x06, \
+		0x01, 0x00, 0x03, 0x00, 0x55, 0x18), \
+	IOV_DATA(0x10, 0x04, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x04, 0x00, 0x0a)
+
+
+/* ATT: Read By Group Type Request (0x10) len 6
+ *   Handle range: 0x0001-0xffff
+ *   Attribute group type: Secondary Service (0x2801)
+ * ATT: Error Response (0x01) len 4
+ *   Read By Group Type Request (0x10)
+ *   Handle: 0x0001
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define TMAS_SECONDARY_SERVICE \
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a)
+
+/* ATT: Read By Type Request (0x08) len 6
+ *   Handle range: 0x0001-0x0003
+ *   Attribute group type: Include (0x2802)
+ * ATT: Error Response (0x01) len 4
+ *   Read By Group Type Request (0x10)
+ *   Handle: 0x0001
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define TMAS_INCLUDE \
+	IOV_DATA(0x08, 0x01, 0x00, 0x03, 0x00, 0x02, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+/* ATT: Read By Type Request (0x08) len 6
+ *   Handle range: 0x0001-0x0003
+ *   Attribute type: Characteristic (0x2803)
+ * ATT: Read By Type Response (0x09) len 57
+ * Attribute data length: 7
+ * Attribute data list: 8 entries
+ *   Handle: 0x0002
+ *   Value: 020300512b
+ *   Properties: 0x02
+ *     Read (0x02)
+ *   Value Handle: 0x0003
+ *   Value UUID: TMAP Role (0x2b51)
+ * ATT: Read By Type Request (0x08) len 6
+ *   Handle range: 0x0003-0x0004
+ *   Attribute type: Characteristic (0x2803)
+ * ATT: Error Response (0x01) len 4
+ *   Read By Type Request (0x08)
+ *   Handle: 0x0022
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define TMAS_FIND_CHRC \
+	IOV_DATA(0x08, 0x01, 0x00, 0x03, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x09, 0x07, \
+		0x02, 0x00, 0x02, 0x03, 0x00, 0x51, 0x2b), \
+	IOV_DATA(0x08, 0x03, 0x00, 0x03, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x03, 0x00, 0x0a)
+
+#define ROLE_HND	0x03, 0x00
+
+/* ACL Data TX: Handle 42 flags 0x00 dlen 11
+ *   ATT: Read By Type Request (0x08) len 6
+ *   Handle range: 0x0001-0xffff
+ *   Attribute type: Database Hash (0x2b2a)
+ * ATT: Error Response (0x01) len 4
+ *   Read By Type Request (0x08)
+ *   Handle: 0x0001
+ *   Error: Attribute Not Found (0x0a)
+ */
+#define TMAS_DATABASE_HASH \
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b), \
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+/* GATT Discover All procedure */
+static const struct iovec setup_data[] = {
+	TMAS_MTU_FEATURES,
+	TMAS_PRIMARY_SERVICE,
+	TMAS_SECONDARY_SERVICE,
+	TMAS_INCLUDE,
+	TMAS_FIND_CHRC,
+	TMAS_DATABASE_HASH,
+};
+
+static void setup_complete_cb(const void *user_data)
+{
+	tester_setup_complete();
+}
+
+static void test_setup_server(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct bt_att *att;
+	struct gatt_db *db;
+	struct io *io;
+
+	io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	g_assert(io);
+
+	tester_io_set_complete_func(setup_complete_cb);
+
+	db = gatt_db_new();
+	g_assert(db);
+
+	data->tmap = bt_tmap_add_db(db);
+	bt_tmap_set_debug(data->tmap, print_debug, "tmap:", NULL);
+
+	bt_tmap_set_role(data->tmap, data->cfg->role);
+
+	att = bt_att_new(io_get_fd(io), false);
+	g_assert(att);
+	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+
+	data->server = bt_gatt_server_new(db, att, 64, 0);
+	g_assert(data->server);
+	bt_gatt_server_set_debug(data->server, print_debug, "bt_gatt_server:",
+						NULL);
+
+	tester_io_send();
+
+	bt_att_unref(att);
+	gatt_db_unref(db);
+}
+
+static void test_complete_cb(const void *user_data)
+{
+	tester_test_passed();
+}
+
+static void test_server(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(test_complete_cb);
+
+	tester_io_send();
+}
+
+static void setup_ready_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	if (!success)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
+static void test_setup(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct bt_att *att;
+	struct gatt_db *db;
+	struct io *io;
+
+	io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	g_assert(io);
+
+	att = bt_att_new(io_get_fd(io), false);
+	g_assert(att);
+
+	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+
+	db = gatt_db_new();
+	g_assert(db);
+
+	data->client = bt_gatt_client_new(db, att, 64, 0);
+	g_assert(data->client);
+
+	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
+						NULL);
+
+	bt_gatt_client_ready_register(data->client, setup_ready_cb, data,
+						NULL);
+
+	bt_att_unref(att);
+	gatt_db_unref(db);
+}
+
+static void client_ready_cb(struct bt_tmap *tmap, void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	if (bt_tmap_get_role(tmap) != data->cfg->role) {
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
+static void test_client(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(NULL);
+
+	data->tmap = bt_tmap_attach(data->client, client_ready_cb, data);
+	g_assert(data->tmap);
+
+	bt_tmap_set_debug(data->tmap, print_debug, "tmap:", NULL);
+}
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0003 Type: TMAP Role (0x2b51)
+ * ATT: Read Response (0x0b) len 24
+ *   Value: _value
+ *   Handle: 0x0003 Type: TMAP Role (0x2b51)
+ */
+#define READ_ROLE(value...) \
+	IOV_DATA(0x0a, ROLE_HND), \
+	IOV_DATA(0x0b, value)
+
+#define CGGIT_CHA \
+	/* Step 1. in CGGIT/CHA skipped, should be unnecessary */ \
+	READ_ROLE(0x24, 0x00)
+#define CGGIT_CHA_RFU \
+	/* Step 1. in SGGIT/CHA skipped, should be unnecessary */ \
+	READ_ROLE(0x24, 0xff)
+
+const struct test_config cfg_read_role = {
+	.role = BT_TMAP_ROLE_UMS | BT_TMAP_ROLE_BMR,
+};
+
+static void test_tmap_cl(void)
+{
+	/* Sec. 4.5.1 TMA Client */
+	define_test("TMAP/CL/CGGIT/CHA/BV-01-C [TMAP Role Read Characteristic, "
+						"Client]",
+		test_setup, test_client, &cfg_read_role, CGGIT_CHA);
+	define_test("TMAP/CL/TMAS/BI-01-C [Client Ignores RFU Bits in TMAP "
+						"Role Characteristic]",
+		test_setup, test_client, &cfg_read_role, CGGIT_CHA_RFU);
+}
+
+#define SGGIT_CHA \
+	/* Step 1. in CGGIT/CHA skipped, should be unnecessary */ \
+	READ_ROLE(0x24, 0x00)
+
+static void test_tmap_sr(void)
+{
+	/* Sec. 4.5.2 TMA Server */
+	define_test("TMAP/SR/SGGIT/CHA/BV-01-C [Characteristic GGIT - "
+								"TMAP Role]",
+		test_setup_server, test_server, &cfg_read_role,
+		SGGIT_CHA);
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+	test_tmap_cl();
+	test_tmap_sr();
+
+	return tester_run();
+}
-- 
2.51.1

