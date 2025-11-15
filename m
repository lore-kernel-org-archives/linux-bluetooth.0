Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEB29D26B
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211527; cv=pass; b=Y7k+XX3El7HDXgw7+XS3Of572kt0jCT/bTDb4fnWaDzWm99zVHfvDUqTTii7eFTUO3HmUvxZtH1QjnUQ3z1gXCzqgS2lndR2wapmGv3GX2p3r5efDMloP5fifbH+ibJlZvr7fSPNB2i5UX6R4CnmnGI4DUn3RKGaRjjknwIZa88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211527; c=relaxed/simple;
	bh=TCnD563jm7JFDsJileaJBHlIB+fqy4TuBCvR/bYjF5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEpBTdNC75S87WKQfrrrQ1VgQeLLJlxkTDdCLSHbQXtrnYZFhW8/LlUcnUd+UYtJl3KeL5XpvcpnTEk7L+eZTQ7m3Mk6pBaH4f/bi3z0x8cY7Ry1RGG7mtC9NzQHVHx65qYtEzmsLV+qcVFcvGvg4DUEQ9Vk02cNqcSqyEIpjjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=WJR+cRlP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="WJR+cRlP"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7vFs3HLxz105W;
	Sat, 15 Nov 2025 14:58:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763211521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWPWtkrBbwdZTkKoaGc+NPcq47xuVzFnsnPJpgR0EOY=;
	b=WJR+cRlPVeKZbKy87w2t1rgxRTcUq2h/xesaQ9MHJ8+UjG/i8ZpdmTFcai1Ps0t98Jhyxn
	hHxhc+Ql97kd7yynCQtfzBaYm5XftPkbNpkIUfprD9oGLu1u3VefN0yrSUjnwmgQwhLUS8
	53qnab3UF/wwJmYz7x+eAyHDpNkOVzY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763211521;
	b=glTdgGTCFYsWJtkCt9MehB0HM4s+gB2NM2yFbKP02s5aQImkyiIBeCe7lcwoIQ7sg/ycbH
	7+mN+vOj3fkY+5uXmTUMNXALAJRhZ+d2/A+q/pirP7N+KWkbdngaQHL4POI4vnw/7lt21E
	GfBE4bw2up63PnwbWrq/zVcxBtnpIUQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763211521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWPWtkrBbwdZTkKoaGc+NPcq47xuVzFnsnPJpgR0EOY=;
	b=EZoIMeLAHdyOUAlqRiCeHTuBkbmcfZ+JBhFnyBMg51gsNvaRqyEa8Mfp0CWpMliZLjTjiu
	mosP8JPK0BhfHAe2p9Eizd0Yh27ZtYAniUP9IF17zkx5YBmMZdGMvZOrtXgZNjBv7Rtgha
	sOMhHMZVeUJNANz/JTDPCRaXarVKipE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 6/6] test-bap: add audio configuration selection and streaming tests
Date: Sat, 15 Nov 2025 14:58:33 +0200
Message-ID: <a34e74e1b756158a4a7e7fc4949fb31660249fda.1763211509.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests from BAP.TS 4.10.

The tests testing (ii) configurations only test configuration selection
with L/R separately. Can be filled in later to use two simultaneous BAP.

The difference between CIS Establishment at QoS vs. Enable is not
properly simulated, so only one variant is added.
---

Notes:
    v4:
    - fix missing errno.h #include apparently needed on some platforms
    
    v3:
    - add most of the streaming tests

 unit/test-bap.c | 1475 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 1469 insertions(+), 6 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 1a35aaf4a..83457bc7b 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <fcntl.h>
+#include <errno.h>
 
 #include <glib.h>
 
@@ -34,8 +35,11 @@
 #include "src/shared/bap.h"
 #include "src/shared/lc3.h"
 
+#define FAIL_TEST() \
+	do { tester_warn("%s:%d: failed in %s", __FILE__, __LINE__, __func__); \
+		tester_test_failed(); } while (0)
+
 struct test_config {
-	struct bt_bap_pac_qos pqos;
 	struct iovec cc;
 	struct iovec base;
 	struct bt_bap_qos qos;
@@ -45,6 +49,12 @@ struct test_config {
 	uint8_t state;
 	bt_bap_state_func_t state_func;
 	uint8_t streams;
+	uint32_t snk_locations[4];
+	uint32_t src_locations[4];
+	struct bt_bap_pac_qos *pac_qos;
+	struct iovec *pac_caps;
+	const struct iovec *setup_data;
+	size_t setup_data_len;
 };
 
 struct test_data {
@@ -65,6 +75,7 @@ struct test_data {
 	struct queue *streams;
 	size_t iovcnt;
 	struct iovec *iov;
+	int fds[8][2];
 };
 
 struct notify {
@@ -106,6 +117,10 @@ static struct bt_bap_pac_qos lc3_qos = {
 		data.caps = &lc3_caps;				\
 		data.qos = &lc3_qos;				\
 		data.cfg = _cfg;				\
+		if (data.cfg && data.cfg->pac_caps)		\
+			data.caps = data.cfg->pac_caps;		\
+		if (data.cfg && data.cfg->pac_qos)		\
+			data.qos = data.cfg->pac_qos;		\
 		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
 		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
 		data.streams = queue_new(); \
@@ -342,6 +357,201 @@ static const struct iovec setup_data[] = {
 	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
 };
 
+static const struct iovec setup_data_no_location[] = {
+	/* ATT: Exchange MTU Response (0x03) len 2
+	 *   Server RX MTU: 64
+	 */
+	IOV_DATA(0x02, 0x40, 0x00),
+	/* ATT: Exchange MTU Request (0x02) len 2
+	 *    Client RX MTU: 64
+	 */
+	IOV_DATA(0x03, 0x40, 0x00),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute type: Server Supported Features (0x2b3a)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+	/*
+	 * ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute group type: Primary Service (0x2800)
+	 */
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	/*
+	 * ATT: Read By Group Type Response (0x11) len 37
+	 *   Attribute data length: 6
+	 *   Attribute group list: 2 entries
+	 *   Handle range: 0x0001-0x0013
+	 *   UUID: Published Audio Capabilities (0x1850)
+	 *   Handle range: 0x0014-0x0023
+	 *   UUID: Audio Stream Control (0x184e)
+	 */
+	IOV_DATA(0x11, 0x06,
+		0x01, 0x00, 0x13, 0x00, 0x50, 0x18,
+		0x14, 0x00, 0x23, 0x00, 0x4e, 0x18),
+	/* ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0024-0xffff
+	 *   Attribute group type: Primary Service (0x2800)
+	 */
+	IOV_DATA(0x10, 0x24, 0x00, 0xff, 0xff, 0x00, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0024
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x10, 0x24, 0x00, 0x0a),
+	/* ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute group type: Secondary Service (0x2801)
+	 */
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0x0023
+	 *   Attribute group type: Include (0x2802)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0x23, 0x00, 0x02, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0x0023
+	 *   Attribute type: Characteristic (0x2803)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0x23, 0x00, 0x03, 0x28),
+	/* ATT: Read By Type Response (0x09) len 57
+	 * Attribute data length: 7
+	 * Attribute data list: 8 entries
+	 *   Handle: 0x0002
+	 *   Value: 120300c92b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0003
+	 *   Value UUID: Sink PAC (0x2bc9)
+	 *   Handle: 0x0008
+	 *   Value: 120900cb2b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0009
+	 *   Value UUID: Source PAC (0x2bcb)
+	 *  Handle: 0x000e
+	 *  Value: 120f00cd2b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x000f
+	 *  Value UUID: Available Audio Contexts (0x2bcd)
+	 *  Handle: 0x0011
+	 *  Value: 121200ce2b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x0012
+	 *  Value UUID: Supported Audio Contexts (0x2bce)
+	 *  Handle: 0x0015
+	 *  Value: 121600c42b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x0016
+	 *  Value UUID: Sink ASE (0x2bc4)
+	 *   Handle: 0x001b
+	 *   Value: 121c00c52b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x001c
+	 *   Value UUID: Source ASE (0x2bc5)
+	 *   Handle: 0x0021
+	 *   Value: 182200c62b
+	 *   Properties: 0x18
+	 *     Write (0x08)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0022
+	 *   Value UUID: ASE Control Point (0x2bc6)
+	 */
+	IOV_DATA(0x09, 0x07,
+		/* keep same IDs as above, leaving holes */
+		0x02, 0x00, 0x12, 0x03, 0x00, 0xc9, 0x2b,
+		0x08, 0x00, 0x12, 0x09, 0x00, 0xcb, 0x2b,
+		0x0e, 0x00, 0x12, 0x0f, 0x00, 0xcd, 0x2b,
+		0x11, 0x00, 0x12, 0x12, 0x00, 0xce, 0x2b,
+		0x15, 0x00, 0x12, 0x16, 0x00, 0xc4, 0x2b,
+		0x1b, 0x00, 0x12, 0x1c, 0x00, 0xc5, 0x2b,
+		0x21, 0x00, 0x18, 0x22, 0x00, 0xc6, 0x2b),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0022-0x0023
+	 *   Attribute type: Characteristic (0x2803)
+	 */
+	IOV_DATA(0x08, 0x22, 0x00, 0x23, 0x00, 0x03, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0022
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x22, 0x00, 0x0a),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x04, 0x00, 0x07, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x05, 0x00, 0x07, 0x00),
+	/* ATT: Error Response */
+	IOV_DATA(0x01, 0x04, 0x05, 0x00, 0x0a),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x0a, 0x00, 0x0d, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x0a, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x0b, 0x00, 0x0d, 0x00),
+	/* ATT: Error Response */
+	IOV_DATA(0x01, 0x04, 0x0b, 0x00, 0x0a),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x17, 0x00, 0x1a, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x17, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x18, 0x00, 0x1a, 0x00),
+	/* ATT: Error Response */
+	IOV_DATA(0x01, 0x04, 0x1a, 0x00, 0x0a),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x1d, 0x00, 0x20, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x1d, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x1e, 0x00, 0x20, 0x00),
+	/* ATT: Error Response */
+	IOV_DATA(0x01, 0x04, 0x1e, 0x00, 0x0a),
+	/* ACL Data TX: Handle 42 flags 0x00 dlen 11
+	 *   ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute type: Database Hash (0x2b2a)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+};
+
 static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -357,7 +567,11 @@ static void test_setup(const void *user_data)
 	struct gatt_db *db;
 	struct io *io;
 
-	io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	if (!data->cfg || !data->cfg->setup_data)
+		io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	else
+		io = tester_setup_io(data->cfg->setup_data,
+						data->cfg->setup_data_len);
 	g_assert(io);
 
 	att = bt_att_new(io_get_fd(io), false);
@@ -471,11 +685,13 @@ static void test_setup_pacs(struct test_data *data)
 							"test-bap-snk",
 							BT_BAP_SINK, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							data->qos, data->caps,
+							NULL);
 		else
 			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
 							BT_BAP_SINK, LC3_ID,
-							NULL, data->caps, NULL);
+							data->qos, data->caps,
+							NULL);
 		g_assert(data->snk);
 	}
 
@@ -485,11 +701,13 @@ static void test_setup_pacs(struct test_data *data)
 							"test-bap-src",
 							BT_BAP_SOURCE, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							data->qos, data->caps,
+							NULL);
 		else
 			data->src = bt_bap_add_pac(data->db, "test-bap-src",
 							BT_BAP_SOURCE, LC3_ID,
-							NULL, data->caps, NULL);
+							data->qos, data->caps,
+							NULL);
 		g_assert(data->src);
 	}
 }
@@ -891,6 +1109,7 @@ static void test_bcast(const void *user_data)
 static void test_teardown(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
+	unsigned int i, j;
 
 	bt_bap_unregister(data->id);
 	bt_bap_unref(data->bap);
@@ -899,6 +1118,15 @@ static void test_teardown(const void *user_data)
 
 	util_iov_free(data->base, 1);
 
+	for (i = 0; i < ARRAY_SIZE(data->fds); ++i) {
+		for (j = 0; j < ARRAY_SIZE(data->fds[0]); ++j) {
+			if (data->fds[i][j] > 0) {
+				close(data->fds[i][j]);
+				data->fds[i][j] = -1;
+			}
+		}
+	}
+
 	bt_bap_remove_pac(data->snk);
 	bt_bap_remove_pac(data->src);
 	bt_bap_remove_pac(data->bsrc);
@@ -8792,6 +9020,1240 @@ static void test_bsrc_str(void)
 	test_bsrc_str_2b();
 }
 
+/*
+ * Configuration selection: check example cases for BAP AC.
+ */
+
+#define LC3_PAC_CAPS_NO_COUNT \
+	0x06, 0x00, 0x00, 0x00, 0x00, 0x0d, 0x03, 0x01, \
+	0xff, 0x00, 0x02, 0x02, 0x03, 0x05, 0x04, \
+	0x1a, 0x00, 0xf0, 0x00, 0x00
+
+#define UNKNOWN_PAC_CAPS \
+	0xff, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00
+
+#define DISC_SNK_ONLY(loc, caps) \
+	DISC_SRC_ASE(loc, 0, IOV_CONTENT(caps), UNKNOWN_PAC_CAPS)
+
+#define DISC_SNK_ONLY_NO_LOC(caps) \
+	DISC_SRC_ASE_NO_LOCATION(IOV_CONTENT(caps), UNKNOWN_PAC_CAPS)
+
+#define DISC_SRC_ONLY(loc, caps) \
+	DISC_SRC_ASE(0, loc, UNKNOWN_PAC_CAPS, IOV_CONTENT(caps))
+
+#define DISC_SRC_ONLY_NO_LOC(caps) \
+	DISC_SRC_ASE_NO_LOCATION(UNKNOWN_PAC_CAPS, IOV_CONTENT(caps))
+
+#define STR_SCC_DATA(challoc, codec_id...) \
+	/* NOTE: only channel allocation in CC for simplicity */ \
+	codec_id, 0x06, 0x05, 0x03, \
+	challoc & 0xff, (challoc >> 8) & 0xff, \
+	(challoc >> 16) & 0xff, (challoc >> 24) & 0xff
+
+#define STR_SNK_STREAMING(challoc, codec_id...)	\
+	SCC_SNK(STR_SCC_DATA(challoc, codec_id)), \
+	QOS_SNK(QOS_SRC_8_1_1_DATA), \
+	SNK_ENABLE, \
+	SNK_START_NOTIFY(0, 0)
+
+#define STR_SRC_STREAMING(challoc, codec_id...)	\
+	SCC_SRC(STR_SCC_DATA(challoc, codec_id)), \
+	QOS_SRC(QOS_SRC_8_1_1_DATA), \
+	SRC_ENABLE, \
+	SRC_START
+
+#define STR_SNK_STREAMING_LC3(challoc) \
+	STR_SNK_STREAMING(challoc, LC3_CODEC_ID_DATA)
+
+#define STR_SRC_STREAMING_LC3(challoc) \
+	STR_SRC_STREAMING(challoc, LC3_CODEC_ID_DATA)
+
+#define STR_SNK_STREAMING_VS(challoc) \
+	STR_SNK_STREAMING(challoc, VS_CODEC_ID_DATA)
+
+#define STR_SRC_STREAMING_VS(challoc) \
+	STR_SRC_STREAMING(challoc, VS_CODEC_ID_DATA)
+
+#define SCC_ASE2(id1, id2, ch1, ch2, codec_id...) \
+	IOV_DATA(SCC_PDU(2), \
+		SCC_PDU_ASE(id1, STR_SCC_DATA(ch1, codec_id)), \
+		SCC_PDU_ASE(id2, STR_SCC_DATA(ch2, codec_id))), \
+	IOV_DATA(0x1b, CP_HND, 0x01, 0x02, id1, 0x00, 0x00, id2, 0x00, 0x00)
+
+#define SCC_ASE3(id1, id2, id3, ch1, ch2, ch3, codec_id...) \
+	IOV_DATA(SCC_PDU(3), \
+		SCC_PDU_ASE(id1, STR_SCC_DATA(ch1, codec_id)), \
+		SCC_PDU_ASE(id2, STR_SCC_DATA(ch2, codec_id)), \
+		SCC_PDU_ASE(id3, STR_SCC_DATA(ch3, codec_id))), \
+	IOV_DATA(0x1b, CP_HND, 0x01, 0x03, id1, 0x00, 0x00, id2, 0x00, 0x00, \
+		id3, 0x00, 0x00)
+
+#define QOS_ASE2(id1, id2, cis1, cis2, _qos...)	 \
+	IOV_DATA(QOS_PDU(2), QOS_PDU_ASE(id1, cis1, _qos), \
+				QOS_PDU_ASE(id2, cis2, _qos)), \
+	IOV_DATA(0x1b, CP_HND, 0x02, 0x02, id1, 0x00, 0x00, id2, 0x00, 0x00)
+
+#define QOS_ASE3(id1, id2, id3, cis1, cis2, cis3, _qos...) \
+	IOV_DATA(QOS_PDU(3), QOS_PDU_ASE(id1, cis1, _qos), \
+		QOS_PDU_ASE(id2, cis2, _qos), \
+		QOS_PDU_ASE(id3, cis3, _qos)), \
+	IOV_DATA(0x1b, CP_HND, 0x02, 0x03, id1, 0x00, 0x00, id2, 0x00, 0x00, \
+		id3, 0x00, 0x00)
+
+#define ENABLE_ASE2(id1, id2) \
+	IOV_DATA(ENABLE_PDU(2), ENABLE_PDU_ASE(id1), ENABLE_PDU_ASE(id2)), \
+	IOV_DATA(0x1b, CP_HND, 0x03, 0x02, id1, 0x00, 0x00, id2, 0x00, 0x00)
+
+#define ENABLE_ASE3(id1, id2, id3) \
+	IOV_DATA(ENABLE_PDU(3), ENABLE_PDU_ASE(id1), ENABLE_PDU_ASE(id2), \
+		ENABLE_PDU_ASE(id3)), \
+	IOV_DATA(0x1b, CP_HND, 0x03, 0x03, id1, 0x00, 0x00, id2, 0x00, 0x00, \
+		id3, 0x00, 0x00)
+
+#define ENABLE_ASE4(id1, id2, id3, id4) \
+	IOV_DATA(ENABLE_PDU(4), ENABLE_PDU_ASE(id1), ENABLE_PDU_ASE(id2), \
+		ENABLE_PDU_ASE(id3), ENABLE_PDU_ASE(id4)), \
+	IOV_DATA(0x1b, CP_HND, 0x03, 0x03, id1, 0x00, 0x00, id2, 0x00, 0x00, \
+		id3, 0x00, 0x00, id4, 0x00, 0x00)
+
+#define START_ASE2(id1, id2) \
+	IOV_DATA(START_PDU(2), id1, id2), \
+	IOV_DATA(0x1b, CP_HND, 0x04, 0x02, id1, 0x00, 0x00, id2, 0x00, 0x00)
+
+#define STR_SNK_SRC_STREAMING(cis1, cis2, challoc1, challoc2, codec_id...) \
+	SCC_ASE2(SNK_ID(0), SRC_ID(0), challoc1, challoc2, codec_id), \
+	SCC_SNK_NOTIFY(0, STR_SCC_DATA(challoc1, codec_id)), \
+	SCC_SRC_NOTIFY(0, STR_SCC_DATA(challoc2, codec_id)), \
+	QOS_ASE2(SNK_ID(0), SRC_ID(0), cis1, cis2, QOS_SRC_8_1_1_DATA), \
+	QOS_SNK_NOTIFY(0, cis1, QOS_SRC_8_1_1_DATA), \
+	QOS_SRC_NOTIFY(0, cis2, QOS_SRC_8_1_1_DATA), \
+	ENABLE_ASE2(SNK_ID(0), SRC_ID(0)), \
+	SNK_ENABLE_NOTIFY(0, cis1),  \
+	SRC_ENABLE_NOTIFY(0, cis2), \
+	SNK_START_NOTIFY(0, cis1), \
+	START_ASE(SRC_ID(0)), \
+	SRC_START_NOTIFY(0, cis2)
+
+#define STR_SNK_SRC_STREAMING_LC3(cis1, cis2, challoc1, challoc2) \
+	STR_SNK_SRC_STREAMING(cis1, cis2, challoc1, challoc2, LC3_CODEC_ID_DATA)
+
+#define STR_SNK_SRC_STREAMING_VS(cis1, cis2, challoc1, challoc2) \
+	STR_SNK_SRC_STREAMING(cis1, cis2, challoc1, challoc2, VS_CODEC_ID_DATA)
+
+#define STR_SNK2_STREAMING(cis1, cis2, challoc1, challoc2, codec_id...) \
+	SCC_ASE2(SNK_ID(0), SNK_ID(1), challoc1, challoc2, codec_id), \
+	SCC_SNK_NOTIFY(0, STR_SCC_DATA(challoc1, codec_id)), \
+	SCC_SNK_NOTIFY(1, STR_SCC_DATA(challoc2, codec_id)), \
+	QOS_ASE2(SNK_ID(0), SNK_ID(1), cis1, cis2, QOS_SRC_8_1_1_DATA), \
+	QOS_SNK_NOTIFY(0, cis1, QOS_SRC_8_1_1_DATA), \
+	QOS_SNK_NOTIFY(1, cis2, QOS_SRC_8_1_1_DATA), \
+	ENABLE_ASE2(SNK_ID(0), SNK_ID(1)), \
+	SNK_ENABLE_NOTIFY(0, cis1),  \
+	SNK_ENABLE_NOTIFY(1, cis2),  \
+	SNK_START_NOTIFY(0, cis1), \
+	SNK_START_NOTIFY(1, cis2)
+
+#define STR_SNK2_STREAMING_LC3(cis1, cis2, challoc1, challoc2) \
+	STR_SNK2_STREAMING(cis1, cis2, challoc1, challoc2, LC3_CODEC_ID_DATA)
+
+#define STR_SNK2_STREAMING_VS(cis1, cis2, challoc1, challoc2) \
+	STR_SNK2_STREAMING(cis1, cis2, challoc1, challoc2, VS_CODEC_ID_DATA)
+
+#define STR_SRC2_STREAMING(cis1, cis2, challoc1, challoc2, codec_id...) \
+	SCC_ASE2(SRC_ID(0), SRC_ID(1), challoc1, challoc2, codec_id), \
+	SCC_SRC_NOTIFY(0, STR_SCC_DATA(challoc1, codec_id)), \
+	SCC_SRC_NOTIFY(1, STR_SCC_DATA(challoc2, codec_id)), \
+	QOS_ASE2(SRC_ID(0), SRC_ID(1), cis1, cis2, QOS_SRC_8_1_1_DATA), \
+	QOS_SRC_NOTIFY(0, cis1, QOS_SRC_8_1_1_DATA), \
+	QOS_SRC_NOTIFY(1, cis2, QOS_SRC_8_1_1_DATA), \
+	ENABLE_ASE2(SRC_ID(0), SRC_ID(1)), \
+	SRC_ENABLE_NOTIFY(0, cis1),  \
+	SRC_ENABLE_NOTIFY(1, cis2), \
+	START_ASE2(SRC_ID(0), SRC_ID(1)), \
+	SRC_START_NOTIFY(0, cis2), \
+	SRC_START_NOTIFY(1, cis2)
+
+#define STR_SRC2_STREAMING_LC3(cis1, cis2, challoc1, challoc2) \
+	STR_SRC2_STREAMING(cis1, cis2, challoc1, challoc2, LC3_CODEC_ID_DATA)
+
+#define STR_SNK2_SRC_STREAMING(cis1, cis2, cis3, ch1, ch2, ch3, codec_id...) \
+	SCC_ASE3(SNK_ID(0), SNK_ID(1), SRC_ID(0), ch1, ch2, ch3, codec_id), \
+	SCC_SNK_NOTIFY(0, STR_SCC_DATA(ch1, codec_id)), \
+	SCC_SNK_NOTIFY(1, STR_SCC_DATA(ch2, codec_id)), \
+	SCC_SRC_NOTIFY(0, STR_SCC_DATA(ch3, codec_id)), \
+	QOS_ASE3(SNK_ID(0), SNK_ID(1), SRC_ID(0), cis1, cis2, cis3, \
+			QOS_SRC_8_1_1_DATA), \
+	QOS_SNK_NOTIFY(0, cis1, QOS_SRC_8_1_1_DATA), \
+	QOS_SNK_NOTIFY(1, cis2, QOS_SRC_8_1_1_DATA), \
+	QOS_SRC_NOTIFY(0, cis3, QOS_SRC_8_1_1_DATA), \
+	ENABLE_ASE3(SNK_ID(0), SNK_ID(1), SRC_ID(0)),  \
+	SNK_ENABLE_NOTIFY(0, cis1), \
+	SNK_ENABLE_NOTIFY(1, cis2), \
+	SRC_ENABLE_NOTIFY(0, cis3), \
+	SNK_START_NOTIFY(0, cis1), \
+	SNK_START_NOTIFY(1, cis2), \
+	START_ASE(SRC_ID(0)), \
+	SRC_START_NOTIFY(0, cis3)
+
+#define STR_SNK2_SRC_STREAMING_LC3(cis1, cis2, cis3, ch1, ch2, ch3) \
+	STR_SNK2_SRC_STREAMING(cis1, cis2, cis3, ch1, ch2, ch3, \
+				LC3_CODEC_ID_DATA)
+
+#define STR_SNK2_SRC2_STREAMING(cis1, cis2, cis3, cis4, \
+				ch1, ch2, ch3, ch4, codec_id...) \
+	SCC_ASE3(SNK_ID(0), SNK_ID(1), SRC_ID(0), \
+		ch1, ch2, ch3, codec_id), \
+	SCC_ASE(SRC_ID(1), STR_SCC_DATA(ch4, codec_id)), \
+	SCC_SNK_NOTIFY(0, STR_SCC_DATA(ch1, codec_id)), \
+	SCC_SNK_NOTIFY(1, STR_SCC_DATA(ch2, codec_id)), \
+	SCC_SRC_NOTIFY(0, STR_SCC_DATA(ch3, codec_id)), \
+	SCC_SRC_NOTIFY(1, STR_SCC_DATA(ch4, codec_id)), \
+	QOS_ASE3(SNK_ID(0), SNK_ID(1), SRC_ID(0), \
+		cis1, cis2, cis3, QOS_SRC_8_1_1_DATA), \
+	QOS_ASE(SRC_ID(1), cis4, QOS_SRC_8_1_1_DATA), \
+	QOS_SNK_NOTIFY(0, cis1, QOS_SRC_8_1_1_DATA), \
+	QOS_SNK_NOTIFY(1, cis2, QOS_SRC_8_1_1_DATA), \
+	QOS_SRC_NOTIFY(0, cis3, QOS_SRC_8_1_1_DATA), \
+	QOS_SRC_NOTIFY(1, cis4, QOS_SRC_8_1_1_DATA), \
+	ENABLE_ASE4(SNK_ID(0), SNK_ID(1), SRC_ID(0), SRC_ID(1)), \
+	SNK_ENABLE_NOTIFY(0, cis1), \
+	SNK_ENABLE_NOTIFY(1, cis2), \
+	SRC_ENABLE_NOTIFY(0, cis3), \
+	SRC_ENABLE_NOTIFY(1, cis4), \
+	SNK_START_NOTIFY(0, cis1), \
+	SNK_START_NOTIFY(1, cis2), \
+	START_ASE2(SRC_ID(0), SRC_ID(1)), \
+	SRC_START_NOTIFY(0, cis3), \
+	SRC_START_NOTIFY(1, cis4)
+
+#define STR_SNK2_SRC2_STREAMING_LC3(cis1, cis2, cis3, cis4, \
+					ch1, ch2, ch3, ch4) \
+	STR_SNK2_SRC2_STREAMING(cis1, cis2, cis3, cis4, ch1, ch2, ch3, ch4, \
+				LC3_CODEC_ID_DATA)
+
+/* BAP.TS 4.10.1 configurations */
+#define DISC_AC1_0a	DISC_SNK_ONLY(0, LC3_PAC_CAPS(0x01))
+#define DISC_AC1_0b	DISC_SNK_ONLY(0, LC3_PAC_CAPS_NO_COUNT)
+#define DISC_AC1_0c	DISC_SNK_ONLY_NO_LOC(LC3_PAC_CAPS(0x01))
+#define DISC_AC1_0d	DISC_SNK_ONLY_NO_LOC(LC3_PAC_CAPS_NO_COUNT)
+
+#define STR_AC1_0a	DISC_AC1_0a, STR_SNK_STREAMING_LC3(0)
+#define STR_AC1_0b	DISC_AC1_0b, STR_SNK_STREAMING_LC3(0)
+#define STR_AC1_0c	DISC_AC1_0c, STR_SNK_STREAMING_LC3(0)
+#define STR_AC1_0d	DISC_AC1_0d, STR_SNK_STREAMING_LC3(0)
+
+#define DISC_AC1_1	DISC_SNK_ONLY(0x2, LC3_PAC_CAPS(0x01))
+#define DISC_AC1_1a	DISC_SNK_ONLY(0x2, LC3_PAC_CAPS(0x03))
+#define DISC_AC1_1b	DISC_SNK_ONLY(0x22, LC3_PAC_CAPS(0x01))
+#define DISC_AC1_1c	DISC_SNK_ONLY(0x22, LC3_PAC_CAPS(0x03))
+
+#define STR_AC1_1	DISC_AC1_1, STR_SNK_STREAMING_LC3(0x2)
+#define STR_AC1_1a	DISC_AC1_1a, STR_SNK_STREAMING_LC3(0x2)
+#define STR_AC1_1b	DISC_AC1_1b, STR_SNK_STREAMING_LC3(0x2)
+#define STR_AC1_1c	DISC_AC1_1c, STR_SNK_STREAMING_LC3(0x2)
+
+#define DISC_AC4_2	DISC_SNK_ONLY(0x44, LC3_PAC_CAPS(0x02))
+#define DISC_AC4_2a	DISC_SNK_ONLY(0x44, LC3_PAC_CAPS(0x03))
+#define DISC_AC4_2b	DISC_SNK_ONLY(0x444, LC3_PAC_CAPS(0x02))
+#define DISC_AC4_2c	DISC_SNK_ONLY(0x444, LC3_PAC_CAPS(0x03))
+
+#define STR_AC4_2	DISC_AC4_2, STR_SNK_STREAMING_LC3(0x44)
+#define STR_AC4_2a	DISC_AC4_2a, STR_SNK_STREAMING_LC3(0x44)
+#define STR_AC4_2b	DISC_AC4_2b, STR_SNK_STREAMING_LC3(0x44)
+#define STR_AC4_2c	DISC_AC4_2c, STR_SNK_STREAMING_LC3(0x44)
+
+#define DISC_AC2_0a	DISC_SRC_ONLY(0, LC3_PAC_CAPS(0x01))
+#define DISC_AC2_0b	DISC_SRC_ONLY(0, LC3_PAC_CAPS_NO_COUNT)
+#define DISC_AC2_0c	DISC_SRC_ONLY_NO_LOC(LC3_PAC_CAPS(0x01))
+#define DISC_AC2_0d	DISC_SRC_ONLY_NO_LOC(LC3_PAC_CAPS_NO_COUNT)
+
+#define STR_AC2_0a	DISC_AC2_0a, STR_SRC_STREAMING_LC3(0)
+#define STR_AC2_0b	DISC_AC2_0b, STR_SRC_STREAMING_LC3(0)
+#define STR_AC2_0c	DISC_AC2_0c, STR_SRC_STREAMING_LC3(0)
+#define STR_AC2_0d	DISC_AC2_0d, STR_SRC_STREAMING_LC3(0)
+
+#define DISC_AC2_1	DISC_SRC_ONLY(0x2, LC3_PAC_CAPS(0x01))
+#define DISC_AC2_1a	DISC_SRC_ONLY(0x2, LC3_PAC_CAPS(0x03))
+#define DISC_AC2_1b	DISC_SRC_ONLY(0x22, LC3_PAC_CAPS(0x01))
+#define DISC_AC2_1c	DISC_SRC_ONLY(0x22, LC3_PAC_CAPS(0x03))
+
+#define STR_AC2_1	DISC_AC2_1, STR_SRC_STREAMING_LC3(0x2)
+#define STR_AC2_1a	DISC_AC2_1a, STR_SRC_STREAMING_LC3(0x2)
+#define STR_AC2_1b	DISC_AC2_1b, STR_SRC_STREAMING_LC3(0x2)
+#define STR_AC2_1c	DISC_AC2_1c, STR_SRC_STREAMING_LC3(0x2)
+
+#define DISC_AC10_2	DISC_SRC_ONLY(0x44, LC3_PAC_CAPS(0x02))
+#define DISC_AC10_2a	DISC_SRC_ONLY(0x44, LC3_PAC_CAPS(0x03))
+#define DISC_AC10_2b	DISC_SRC_ONLY(0x444, LC3_PAC_CAPS(0x02))
+#define DISC_AC10_2c	DISC_SRC_ONLY(0x444, LC3_PAC_CAPS(0x03))
+
+#define STR_AC10_2	DISC_AC10_2, STR_SRC_STREAMING_LC3(0x44)
+#define STR_AC10_2a	DISC_AC10_2a, STR_SRC_STREAMING_LC3(0x44)
+#define STR_AC10_2b	DISC_AC10_2b, STR_SRC_STREAMING_LC3(0x44)
+#define STR_AC10_2c	DISC_AC10_2c, STR_SRC_STREAMING_LC3(0x44)
+
+/* BAP.TS 4.10.2 configurations */
+#define DISC_VS_AC1	DISC_SNK_ONLY(0x2, VS_PAC_CAPS(0x01))
+#define DISC_VS_AC4	DISC_SNK_ONLY(0x44, VS_PAC_CAPS(0x02))
+#define DISC_VS_AC2	DISC_SRC_ONLY(0x2, VS_PAC_CAPS_NO_COUNT)
+#define DISC_VS_AC10	DISC_SRC_ONLY(0x44, VS_PAC_CAPS(0x02))
+
+#define STR_VS_AC1	DISC_VS_AC1, STR_SNK_STREAMING_VS(0x2)
+#define STR_VS_AC4	DISC_VS_AC4, STR_SNK_STREAMING_VS(0x44)
+#define STR_VS_AC2	DISC_VS_AC2, STR_SRC_STREAMING_VS(0x2)
+#define STR_VS_AC10	DISC_VS_AC10, STR_SRC_STREAMING_VS(0x44)
+
+/* BAP.TS 4.10.3 configurations
+ * Assumed Channels/Locations applies only to Sink ASE, as it's supposed
+ * to test AC 3, 5, 7(i)
+ */
+#define DISC_AC3	DISC_SRC_ASE(0x1, 0x1, LC3_PAC_CAPS(0x01), \
+							LC3_PAC_CAPS(0x01))
+#define DISC_AC5	DISC_SRC_ASE(0x22, 0x2, LC3_PAC_CAPS(0x02), \
+							LC3_PAC_CAPS(0x01))
+#define DISC_AC7i	DISC_SRC_ASE(0x4, 0x4, LC3_PAC_CAPS(0x01), \
+							LC3_PAC_CAPS(0x01))
+
+#define STR_AC3		DISC_AC3, STR_SNK_SRC_STREAMING_LC3(0, 0, 0x1, 0x1)
+#define STR_AC5		DISC_AC5, STR_SNK_SRC_STREAMING_LC3(0, 0, 0x22, 0x2)
+#define STR_AC7i	DISC_AC7i, STR_SNK_SRC_STREAMING_LC3(0, 1, 0x4, 0x4)
+
+/* BAP.TS 4.10.4 configurations */
+#define DISC_VS_AC3	DISC_SRC_ASE(0x1, 0x1, VS_PAC_CAPS(0x01), \
+							VS_PAC_CAPS(0x01))
+#define DISC_VS_AC5	DISC_SRC_ASE(0x22, 0x2, VS_PAC_CAPS(0x02), \
+							VS_PAC_CAPS(0x01))
+#define DISC_VS_AC7	DISC_SRC_ASE(0x4, 0x4, VS_PAC_CAPS(0x01), \
+							VS_PAC_CAPS(0x01))
+
+#define STR_VS_AC3	DISC_VS_AC3, STR_SNK_SRC_STREAMING_VS(0, 0, 0x1, 0x1)
+#define STR_VS_AC5	DISC_VS_AC5, STR_SNK_SRC_STREAMING_VS(0, 0, 0x22, 0x2)
+#define STR_VS_AC7	DISC_VS_AC7, STR_SNK_SRC_STREAMING_VS(0, 1, 0x4, 0x4)
+
+/* BAP.TS 4.10.5 configurations */
+#define DISC_AC7ii_L	DISC_SRC_ONLY(0x01, LC3_PAC_CAPS(0x01))
+#define DISC_AC7ii_R	DISC_SRC_ONLY(0x10, LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.6 configurations */
+#define DISC_AC6i	DISC_SNK_ONLY(0x11, LC3_PAC_CAPS(0x01))
+#define DISC_VS_AC6i	DISC_SNK_ONLY(0x11, VS_PAC_CAPS(0x01))
+
+#define STR_AC6i	DISC_AC6i, STR_SNK2_STREAMING_LC3(0, 1, 0x01, 0x10)
+#define STR_VS_AC6i	DISC_VS_AC6i, STR_SNK2_STREAMING_VS(0, 1, 0x01, 0x10)
+
+/* BAP.TS 4.10.7 configurations */
+#define DISC_AC6ii_L		DISC_SNK_ONLY(0x01, LC3_PAC_CAPS(0x01))
+#define DISC_AC6ii_R		DISC_SNK_ONLY(0x10, LC3_PAC_CAPS(0x01))
+#define DISC_VS_AC6ii_L		DISC_SNK_ONLY(0x01, VS_PAC_CAPS(0x01))
+#define DISC_VS_AC6ii_R		DISC_SNK_ONLY(0x10, VS_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.8 configurations */
+#define DISC_AC9i		DISC_SRC_ONLY(0x11, LC3_PAC_CAPS(0x01))
+#define DISC_VS_AC9i		DISC_SRC_ONLY(0x11, VS_PAC_CAPS(0x01))
+
+#define STR_AC9i		DISC_AC9i, \
+				STR_SRC2_STREAMING_LC3(0, 1, 0x01, 0x10)
+
+/* BAP.TS 4.10.9 configurations */
+#define DISC_AC9ii_L		DISC_SRC_ONLY(0x01, LC3_PAC_CAPS(0x01))
+#define DISC_AC9ii_R		DISC_SRC_ONLY(0x10, LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.10 configurations */
+#define DISC_AC8i		DISC_SRC_ASE(0x11, 0x02, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+
+#define STR_AC8i		DISC_AC8i, STR_SNK2_SRC_STREAMING_LC3( \
+					0, 1, 0, 0x01, 0x10, 0x2)
+
+/* BAP.TS 4.10.11 configurations */
+#define DISC_AC8ii_L		DISC_SNK_ONLY(0x1, LC3_PAC_CAPS(0x01))
+#define DISC_AC8ii_R		DISC_SRC_ASE(0x10, 0x2, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.12 configurations */
+#define DISC_AC11i		DISC_SRC_ASE(0x11, 0x22, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+
+#define STR_AC11i		DISC_AC11i, STR_SNK2_SRC2_STREAMING_LC3( \
+					0, 1, 0, 1, 0x01, 0x10, 0x02, 0x20)
+
+/* BAP.TS 4.10.13 configurations */
+#define DISC_AC11ii_L		DISC_SRC_ASE(0x01, 0x02, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+#define DISC_AC11ii_R		DISC_SRC_ASE(0x10, 0x20, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+#define DISC_VS_AC11i_L		DISC_SRC_ASE(0x01, 0x02, \
+					VS_PAC_CAPS(0x01), VS_PAC_CAPS(0x01))
+#define DISC_VS_AC11i_R		DISC_SRC_ASE(0x10, 0x20, \
+					VS_PAC_CAPS(0x01), VS_PAC_CAPS(0x01))
+
+/* Expected bt_bap_select() results */
+
+static struct test_config cfg_str_ac1_0ab = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0, -1 },
+	.src_locations = { -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac1_0cd = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0, -1 },
+	.src_locations = { -1 },
+	.setup_data = setup_data_no_location,
+	.setup_data_len = ARRAY_SIZE(setup_data_no_location),
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac1_1 = {
+	.snk = true,
+	.src = true,
+	.streams = 1,  /* force 1 channel; caps support also AC 4 & 6(i) */
+	.snk_locations = { 0x2, -1 },
+	.src_locations = { -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac4_2 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x44, -1 },
+	.src_locations = { -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac2_0ab = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0, -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac2_0cd = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0, -1 },
+	.setup_data = setup_data_no_location,
+	.setup_data_len = ARRAY_SIZE(setup_data_no_location),
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac2_1 = {
+	.snk = true,
+	.src = true,
+	.streams = 1,
+	.snk_locations = { -1 },
+	.src_locations = { 0x2, -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac10_2 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x44, -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_vs_ac1 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x2, -1 },
+	.src_locations = { -1 },
+	.qos = LC3_QOS_8_1_1,
+	.vs = true,
+};
+
+static struct test_config cfg_str_vs_ac4 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x44, -1 },
+	.src_locations = { -1 },
+	.qos = LC3_QOS_8_1_1,
+	.vs = true,
+};
+
+static struct test_config cfg_str_vs_ac2 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x2, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.vs = true,
+};
+
+static struct test_config cfg_str_vs_ac10 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x44, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.vs = true,
+};
+
+static struct test_config cfg_str_ac3 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x1, -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac5 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x22, -1 },
+	.src_locations = { 0x2, -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac7i = {
+	.snk = true,
+	.src = true,
+	.streams = 2,
+	.snk_locations = { 0x4, -1 },
+	.src_locations = { 0x4, -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_vs_ac3 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x1, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.vs = true,
+};
+
+static struct test_config cfg_str_vs_ac5 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x22, -1 },
+	.src_locations = { 0x2, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.vs = true,
+};
+
+static struct test_config cfg_str_vs_ac7 = {
+	.snk = true,
+	.src = true,
+	.streams = 2,
+	.snk_locations = { 0x4, -1 },
+	.src_locations = { 0x4, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.vs = true,
+};
+
+static struct test_config cfg_str_ac7ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x1, -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac7ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x10, -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac6i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, 0x10, -1 },
+	.src_locations = { -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_vs_ac6i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, 0x10, -1 },
+	.src_locations = { -1 },
+	.qos = LC3_QOS_8_1_1,
+	.vs = true,
+};
+
+static struct test_config cfg_str_ac6ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac6ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x10, -1 },
+	.src_locations = { -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_vs_ac6ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { -1 },
+	.vs = true,
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_vs_ac6ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x10, -1 },
+	.src_locations = { -1 },
+	.vs = true,
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac9i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x1, 0x10, -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac9ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x1, -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac9ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x10, -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac8i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, 0x10, -1 },
+	.src_locations = { 0x2, -1 },
+	.qos = LC3_QOS_8_1_1,
+};
+
+static struct test_config cfg_str_ac8ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac8ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x10, -1 },
+	.src_locations = { 0x2, -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac11i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, 0x10, -1 },
+	.src_locations = { 0x2, 0x20, -1 },
+	.qos = LC3_QOS_8_1_1,
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac11ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x2, -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_ac11ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x10, -1 },
+	.src_locations = { 0x20, -1 },
+	/* TODO: no qos: only check select, not streaming */
+};
+
+/* Additional bt_bap_select() tests */
+
+#define DISC_MANY \
+	DISC_SRC_ASE(0x000000ff, 0, LC3_PAC_CAPS(0xf), UNKNOWN_PAC_CAPS)
+
+static struct iovec caps_select_snk_many =
+	LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY, 0x0a, 26, 240);
+
+static struct test_config cfg_str_many_2 = {
+	.snk = true,
+	.snk_locations = { 0x00000003, -1 },
+	.src_locations = { -1 },
+	.pac_caps = &caps_select_snk_many,
+	/* TODO: no qos: only check select, not streaming */
+};
+
+static struct test_config cfg_str_many_8 = {
+	.snk = true,
+	.streams = 8,
+	.snk_locations = { 0x0000000f, 0x000000f0, -1 },
+	.src_locations = { -1 },
+	.pac_caps = &caps_select_snk_many,
+	/* TODO: no qos: only check select, not streaming */
+};
+
+struct test_select_data {
+	struct test_data *data;
+	unsigned int num_src;
+	unsigned int num_snk;
+	uint32_t src_locations[4];
+	uint32_t snk_locations[4];
+	struct bt_bap_pac *rpac;
+	int stream_idx;
+};
+
+static void streaming_ucl_do_stream(struct bt_bap_stream *stream,
+						struct test_data *data)
+{
+	unsigned int idx = PTR_TO_UINT(bt_bap_stream_get_user_data(stream));
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
+	struct io *io;
+	int fd, fd2, ifd, ofd;
+	unsigned int result;
+	ssize_t err;
+	const char *dir;
+
+	io = bt_bap_stream_get_io(stream);
+	if (!io) {
+		FAIL_TEST();
+		return;
+	}
+
+	g_assert(qos->ucast.cis_id < ARRAY_SIZE(data->fds));
+
+	fd = io_get_fd(io);
+	fd2 = data->fds[qos->ucast.cis_id][1];
+	g_assert(fd == data->fds[qos->ucast.cis_id][0]);
+
+	/* NB: dummy data, LC3 packet encoding/decoding out of scope */
+
+	if (bt_bap_stream_get_dir(stream) == BT_BAP_SINK) {
+		dir = "-->";
+		ofd = fd;
+		ifd = fd2;
+	} else {
+		dir = "<--";
+		ofd = fd2;
+		ifd = fd;
+	}
+
+	tester_debug("streaming stream %p fd:%d %s %d", stream, fd, dir, fd2);
+
+	err = write(ofd, &idx, sizeof(idx));
+	g_assert(err == sizeof(idx));
+
+	/* write sentinel to catch if we read twice from same fd */
+	result = 0xaabbccdd;
+	err = write(ofd, &result, sizeof(result));
+	g_assert(err == sizeof(result));
+
+	err = read(ifd, &result, sizeof(result));
+	g_assert(err == sizeof(result));
+
+	tester_debug("stream %p: data %u = %u (%d left)",
+		stream, idx, result, data->id - 1);
+
+	if (result != idx) {
+		FAIL_TEST();
+		return;
+	}
+
+	if (data->id-- == 0) {
+		FAIL_TEST();
+		return;
+	}
+
+	/* All streams handled */
+	if (data->id == 0)
+		tester_test_passed();
+}
+
+static void streaming_ucl_connect(struct bt_bap_stream *stream)
+{
+	int fd;
+
+	tester_debug("connect stream %p", stream);
+
+	if (!bt_bap_stream_io_is_connecting(stream, &fd))
+		return;
+
+	if (!bt_bap_stream_set_io(stream, fd)) {
+		FAIL_TEST();
+		return;
+	}
+}
+
+static int streaming_ucl_create_io(struct bt_bap_stream *stream,
+						struct test_data *data)
+{
+	struct bt_bap_qos *qos[2] = {};
+	unsigned int i;
+	int err;
+
+	tester_debug("create io stream %p", stream);
+
+	if (bt_bap_stream_get_io(stream)) {
+		FAIL_TEST();
+		return -EINVAL;
+	}
+	if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
+		FAIL_TEST();
+		return -EINVAL;
+	}
+	if (bt_bap_stream_io_is_connecting(stream, NULL)) {
+		if (qos[0])
+			return qos[0]->ucast.cis_id;
+		return qos[1]->ucast.cis_id;
+	}
+
+	i = qos[0] ? qos[0]->ucast.cis_id : qos[1]->ucast.cis_id;
+
+	if (i == BT_ISO_QOS_CIG_UNSET) {
+		for (i = 0; i < ARRAY_SIZE(data->fds); ++i) {
+			if (data->fds[i][0] > 0)
+				continue;
+
+			if (qos[0])
+				qos[0]->ucast.cis_id = i;
+			if (qos[1])
+				qos[1]->ucast.cis_id = i;
+			break;
+		}
+	}
+
+	g_assert(i < ARRAY_SIZE(data->fds));
+	g_assert(data->fds[i][0] <= 0);
+	g_assert(data->fds[i][1] <= 0);
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC,
+							0, data->fds[i]);
+	g_assert(err == 0);
+
+	err = bt_bap_stream_io_connecting(stream, data->fds[i][0]);
+	if (err) {
+		FAIL_TEST();
+		return -EINVAL;
+	}
+
+	return i;
+}
+
+static void streaming_ucl_state(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	const struct queue_entry *entry;
+	struct bt_bap_qos qos = data->cfg->qos;
+	unsigned int id;
+
+	tester_debug("stream %p state %d -> %d", stream, old_state, new_state);
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_CONFIG:
+		qos.ucast.cig_id = 0;
+		qos.ucast.cis_id = streaming_ucl_create_io(stream, data);
+		id = bt_bap_stream_qos(stream, &qos, NULL, NULL);
+		g_assert(id);
+		break;
+	case BT_BAP_STREAM_STATE_QOS:
+		if (data->id-- == 0)
+			tester_test_failed();
+		if (data->id)
+			return;
+
+		/* All streams in QoS: proceed */
+		for (entry = queue_get_entries(data->streams);
+					entry; entry = entry->next) {
+			struct bt_bap_stream *s = entry->data;
+
+			if (data->cfg->state != BT_BAP_STREAM_STATE_ENABLING)
+				streaming_ucl_connect(s);
+
+			id = bt_bap_stream_enable(s, false, NULL,
+							NULL, NULL);
+			g_assert(id);
+
+			data->id++;
+		}
+		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		/* TODO: not correct to call bt_bap_stream_set_io() from this
+		 * callback
+		 */
+		if (data->cfg->state == BT_BAP_STREAM_STATE_ENABLING)
+			streaming_ucl_connect(stream);
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		streaming_ucl_do_stream(stream, data);
+		break;
+	}
+}
+
+static void test_select_cb(struct bt_bap_pac *pac, int err,
+			struct iovec *caps, struct iovec *metadata,
+			struct bt_bap_qos *qos, void *user_data)
+{
+	struct test_select_data *sdata = user_data;
+	struct test_data *data = sdata->data;
+	struct bt_bap_stream *stream;
+
+	if (!data->cfg->qos.ucast.target_latency) {
+		tester_warn("TODO: implement streaming test");
+		return;
+	}
+
+	data->id++;
+
+	stream = bt_bap_stream_new(data->bap, pac, sdata->rpac, qos, caps);
+	bt_bap_stream_lock(stream);
+
+	tester_debug("new stream %p", stream);
+
+	queue_push_tail(data->streams, stream);
+
+	if (!data->cfg->streams) {
+		qos->ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+		qos->ucast.cis_id = BT_ISO_QOS_CIG_UNSET;
+	} else {
+		/* All streams to separate CIS.
+		 *
+		 * There is no difference in PACS for AC 4 and AC 7(i), so which
+		 * one to use has to be specified OOB like this.
+		 */
+		qos->ucast.cig_id = 0;
+		qos->ucast.cis_id = sdata->stream_idx;
+	}
+
+	err = bt_bap_stream_config(stream, qos, caps, NULL, NULL);
+	if (!err) {
+		FAIL_TEST();
+		return;
+	}
+
+	bt_bap_stream_set_user_data(stream, UINT_TO_PTR(sdata->stream_idx));
+	sdata->stream_idx++;
+}
+
+static bool test_select_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+								void *user_data)
+{
+	struct test_select_data *sdata = user_data;
+	struct test_config *cfg = sdata->data->cfg;
+	int err, count = 0;
+
+	sdata->rpac = rpac;
+
+	err = bt_bap_select(sdata->data->bap, lpac, rpac, cfg->streams, &count,
+							test_select_cb, sdata);
+	if (err)
+		tester_test_failed();
+
+	return false;
+}
+
+static void bap_select_ready(struct bt_bap *bap, void *user_data)
+{
+	struct test_select_data sdata = {
+		.data = (void *)user_data,
+	};
+	struct test_config *cfg = sdata.data->cfg;
+	unsigned int i;
+
+	bt_bap_foreach_pac(bap, BT_BAP_SINK, test_select_pac, &sdata);
+	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, test_select_pac, &sdata);
+
+	for (i = 0; i < sdata.num_snk; ++i)
+		if (sdata.snk_locations[i] != cfg->snk_locations[i]) {
+			FAIL_TEST();
+			return;
+		}
+	if (i < ARRAY_SIZE(cfg->snk_locations) &&
+			cfg->snk_locations[i] != (uint32_t)-1) {
+		FAIL_TEST();
+		return;
+	}
+
+	for (i = 0; i < sdata.num_src; ++i)
+		if (sdata.src_locations[i] != cfg->src_locations[i]) {
+			FAIL_TEST();
+			return;
+		}
+	if (i < ARRAY_SIZE(cfg->src_locations) &&
+			cfg->src_locations[i] != (uint32_t)-1) {
+		FAIL_TEST();
+		return;
+	}
+
+	if (!sdata.data->cfg->qos.ucast.target_latency)
+		tester_test_passed();
+}
+
+static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			uint32_t location, struct bt_bap_pac_qos *qos,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
+{
+	struct test_select_data *sdata = cb_data;
+	struct test_data *data = sdata->data;
+	uint8_t buf[512];
+	struct iovec cc = { .iov_base = buf, .iov_len = 0 };
+	struct iovec metadata = { 0 };
+
+	if (bt_bap_pac_get_type(rpac) == BT_BAP_SINK) {
+		if (sdata->num_snk >= ARRAY_SIZE(sdata->snk_locations)) {
+			FAIL_TEST();
+			return -EINVAL;
+		}
+		tester_debug("select SNK 0x%08x", location);
+		sdata->snk_locations[sdata->num_snk++] = location;
+	} else {
+		if (sdata->num_src >= ARRAY_SIZE(sdata->src_locations)) {
+			FAIL_TEST();
+			return -EINVAL;
+		}
+		tester_debug("select SRC 0x%08x", location);
+		sdata->src_locations[sdata->num_src++] = location;
+	}
+
+	util_iov_push_mem(&cc, data->cfg->cc.iov_len, data->cfg->cc.iov_base);
+
+	/* Audio_Channel_Allocation */
+	util_iov_push_u8(&cc, 0x05);
+	util_iov_push_u8(&cc, 0x03);
+	util_iov_push_le32(&cc, location);
+
+	g_assert(cc.iov_len <= sizeof(buf));
+
+	cb(lpac, 0, &cc, &metadata, &data->cfg->qos, cb_data);
+	return 0;
+}
+
+static struct bt_bap_pac_ops test_select_pac_ops = {
+	.select = pac_select,
+};
+
+static void test_select(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct io *io;
+
+	data->id = 0;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(NULL);
+
+	data->db = gatt_db_new();
+	g_assert(data->db);
+
+	test_setup_pacs(data);
+
+	if (data->snk)
+		bt_bap_pac_set_ops(data->snk, &test_select_pac_ops, NULL);
+	if (data->src)
+		bt_bap_pac_set_ops(data->src, &test_select_pac_ops, NULL);
+
+	data->bap = bt_bap_new(data->db, bt_gatt_client_get_db(data->client));
+	g_assert(data->bap);
+
+	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
+
+	bt_bap_ready_register(data->bap, bap_select_ready, data, NULL);
+
+	bt_bap_state_register(data->bap, streaming_ucl_state, NULL, data, NULL);
+
+	bt_bap_attach(data->bap, data->client);
+}
+
+static void test_ucl_str(void)
+{
+	/*
+	 * TODO: QoS vs. Enabling variants not simulated
+	 *
+	 * TODO: test (ii) variants connecting both sides simultaneously,
+	 *	 currently CIS linking is not tested
+	 */
+
+	define_test("BAP/UCL/STR/BV-539-C [UCL, AC 2, Generic, QoS]",
+		test_setup, test_select, &cfg_str_ac2_1, STR_AC2_1);
+	define_test("BAP/UCL/STR/BV-580-C [UCL, AC 2, Generic, QoS, "
+					"Multi Channels]",
+		test_setup, test_select, &cfg_str_ac2_1, STR_AC2_1a);
+	define_test("BAP/UCL/STR/BV-581-C [UCL, AC 2, Generic, QoS, "
+					"Multi Location]",
+		test_setup, test_select, &cfg_str_ac2_1, STR_AC2_1b);
+	define_test("BAP/UCL/STR/BV-582-C [UCL, AC 2, Generic, QoS, "
+					"Multi Channels and Location]",
+		test_setup, test_select, &cfg_str_ac2_1, STR_AC2_1c);
+	define_test("BAP/UCL/STR/BV-560-C [UCL, AC 2, Generic, QoS, Mono]",
+		test_setup, test_select, &cfg_str_ac2_0ab, STR_AC2_0a);
+	define_test("BAP/UCL/STR/BV-561-C [UCL, AC 2, Generic, QoS, Mono, "
+					"Default Ch Count]",
+		test_setup, test_select, &cfg_str_ac2_0ab, STR_AC2_0b);
+	define_test("BAP/UCL/STR/BV-562-C [UCL, AC 2, Generic, QoS, Mono, "
+					"No PACS]",
+		test_setup, test_select, &cfg_str_ac2_0cd, STR_AC2_0c);
+	define_test("BAP/UCL/STR/BV-563-C [UCL, AC 2, Generic, QoS, Mono, "
+					"Default Ch Count, No PACS]",
+		test_setup, test_select, &cfg_str_ac2_0cd, STR_AC2_0d);
+
+	define_test("BAP/UCL/STR/BV-540-C [UCL, AC 10, Generic, QoS]",
+		test_setup, test_select, &cfg_str_ac10_2, STR_AC10_2);
+	define_test("BAP/UCL/STR/BV-583-C [UCL, AC 10, Generic, QoS, "
+					"Multi Channels]",
+		test_setup, test_select, &cfg_str_ac10_2, STR_AC10_2a);
+	define_test("BAP/UCL/STR/BV-584-C [UCL, AC 10, Generic, QoS, "
+					"Multi Location]",
+		test_setup, test_select, &cfg_str_ac10_2, STR_AC10_2b);
+	define_test("BAP/UCL/STR/BV-585-C [UCL, AC 10, Generic, QoS, "
+					"Multi Channels and Location]",
+		test_setup, test_select, &cfg_str_ac10_2, STR_AC10_2c);
+
+	define_test("BAP/UCL/STR/BV-541-C [UCL SRC, AC 1, Generic, QoS]",
+		test_setup, test_select, &cfg_str_ac1_1, STR_AC1_1);
+	define_test("BAP/UCL/STR/BV-586-C [UCL, AC 1, Generic, QoS, "
+					"Multi Channels]",
+		test_setup, test_select, &cfg_str_ac1_1, STR_AC1_1a);
+	define_test("BAP/UCL/STR/BV-587-C [UCL, AC 1, Generic, QoS, "
+					"Multi Location]",
+		test_setup, test_select, &cfg_str_ac1_1, STR_AC1_1b);
+	define_test("BAP/UCL/STR/BV-588-C [UCL, AC 1, Generic, QoS, "
+					"Multi Channels and Location]",
+		test_setup, test_select, &cfg_str_ac1_1, STR_AC1_1c);
+
+	define_test("BAP/UCL/STR/BV-564-C [UCL SRC, AC 1, Generic, QoS, Mono]",
+		test_setup, test_select, &cfg_str_ac1_0ab, STR_AC1_0a);
+	define_test("BAP/UCL/STR/BV-565-C [UCL SRC, AC 1, Generic, QoS, Mono, "
+					"Default Ch Count]",
+		test_setup, test_select, &cfg_str_ac1_0ab, STR_AC1_0b);
+	define_test("BAP/UCL/STR/BV-566-C [UCL SRC, AC 1, Generic, QoS, Mono, "
+					"No PACS]",
+		test_setup, test_select, &cfg_str_ac1_0cd, STR_AC1_0c);
+	define_test("BAP/UCL/STR/BV-567-C [UCL SRC, AC 1, Generic, QoS, Mono, "
+					"Default Ch Count, No PACS]",
+		test_setup, test_select, &cfg_str_ac1_0cd, STR_AC1_0d);
+
+	define_test("BAP/UCL/STR/BV-542-C [UCL SRC, AC 4, Generic, QoS]",
+		test_setup, test_select, &cfg_str_ac4_2, STR_AC4_2);
+	define_test("BAP/UCL/STR/BV-589-C [UCL, AC 4, Generic, QoS, "
+					"Multi Channels]",
+		test_setup, test_select, &cfg_str_ac4_2, STR_AC4_2a);
+	define_test("BAP/UCL/STR/BV-590-C [UCL, AC 4, Generic, QoS, "
+					"Multi Location]",
+		test_setup, test_select, &cfg_str_ac4_2, STR_AC4_2b);
+	define_test("BAP/UCL/STR/BV-591-C [UCL, AC 4, Generic, QoS, "
+					"Multi Channels and Location]",
+		test_setup, test_select, &cfg_str_ac4_2, STR_AC4_2c);
+
+	define_test("BAP/UCL/STR/BV-129-C [UCL SRC, AC 1, VS Codec]",
+		test_setup, test_select, &cfg_str_vs_ac1, STR_VS_AC1);
+	define_test("BAP/UCL/STR/BV-130-C [UCL SRC, AC 4, VS Codec]",
+		test_setup, test_select, &cfg_str_vs_ac4, STR_VS_AC4);
+	define_test("BAP/UCL/STR/BV-131-C [UCL, AC 2, VS Codec]",
+		test_setup, test_select, &cfg_str_vs_ac2, STR_VS_AC2);
+	define_test("BAP/UCL/STR/BV-132-C [UCL, AC 10, VS Codec]",
+		test_setup, test_select, &cfg_str_vs_ac10, STR_VS_AC10);
+
+	define_test("BAP/UCL/STR/BV-549-C [UCL, AC 3, Generic, QoS, QoS]",
+		test_setup, test_select, &cfg_str_ac3, STR_AC3);
+	define_test("BAP/UCL/STR/BV-550-C [UCL, AC 5, Generic, QoS, QoS]",
+		test_setup, test_select, &cfg_str_ac5, STR_AC5);
+	define_test("BAP/UCL/STR/BV-551-C [UCL, AC 7(i), Generic, QoS, QoS]",
+		test_setup, test_select, &cfg_str_ac7i, STR_AC7i);
+
+	define_test("BAP/UCL/STR/BV-229-C [UCL, AC 3, VS]",
+		test_setup, test_select, &cfg_str_vs_ac3, STR_VS_AC3);
+	define_test("BAP/UCL/STR/BV-230-C [UCL, AC 5, VS]",
+		test_setup, test_select, &cfg_str_vs_ac5, STR_VS_AC5);
+	define_test("BAP/UCL/STR/BV-231-C [UCL, AC 7, VS]",
+		test_setup, test_select, &cfg_str_vs_ac7, STR_VS_AC7);
+
+	/* TODO: combine these to a single test with two simultaneous BAP */
+	define_test("BAP/UCL/STR/BV-526-C [UCL, AC 7(ii), Generic] Left",
+		test_setup, test_select, &cfg_str_ac7ii_L, DISC_AC7ii_L);
+	define_test("BAP/UCL/STR/BV-526-C [UCL, AC 7(ii), Generic] Right",
+		test_setup, test_select, &cfg_str_ac7ii_R, DISC_AC7ii_R);
+
+	define_test("BAP/UCL/STR/BV-527-C [UCL, AC 6(i), Generic]",
+		test_setup, test_select, &cfg_str_ac6i, STR_AC6i);
+	define_test("BAP/UCL/STR/BV-296-C [UCL, AC 6(i), VS]",
+		test_setup, test_select, &cfg_str_vs_ac6i, STR_VS_AC6i);
+
+	/* TODO: combine these to a single test with two simultaneous BAP */
+	define_test("BAP/UCL/STR/BV-528-C [UCL, AC 6(ii), Generic] Left",
+		test_setup, test_select, &cfg_str_ac6ii_L, DISC_AC6ii_L);
+	define_test("BAP/UCL/STR/BV-528-C [UCL, AC 6(ii), Generic] Right",
+		test_setup, test_select, &cfg_str_ac6ii_R, DISC_AC6ii_R);
+
+	/* TODO: combine these to a single test with two simultaneous BAP */
+	define_test("BAP/UCL/STR/BV-329-C [UCL, AC 6(ii), VS] Left",
+		test_setup, test_select, &cfg_str_vs_ac6ii_L, DISC_VS_AC6ii_L);
+	define_test("BAP/UCL/STR/BV-329-C [UCL, AC 6(ii), VS] Right",
+		test_setup, test_select, &cfg_str_vs_ac6ii_R, DISC_VS_AC6ii_R);
+
+	define_test("BAP/UCL/STR/BV-529-C [UCL, AC 9(i), Generic]",
+		test_setup, test_select, &cfg_str_ac9i, STR_AC9i);
+
+	/* TODO: combine these to a single test with two simultaneous BAP */
+	define_test("BAP/UCL/STR/BV-530-C [UCL, AC 9(ii), Generic] Left",
+		test_setup, test_select,
+		&cfg_str_ac9ii_L, DISC_AC9ii_L);
+	define_test("BAP/UCL/STR/BV-530-C [UCL, AC 9(ii), Generic] Right",
+		test_setup, test_select,
+		&cfg_str_ac9ii_R, DISC_AC9ii_R);
+
+	define_test("BAP/UCL/STR/BV-531-C [UCL, AC 8(i), Generic]",
+		test_setup, test_select,
+		&cfg_str_ac8i, STR_AC8i);
+
+	/* TODO: combine these to a single test with two simultaneous BAP */
+	define_test("BAP/UCL/STR/BV-532-C [UCL, AC 8(ii), Generic] Left",
+		test_setup, test_select,
+		&cfg_str_ac8ii_L, DISC_AC8ii_L);
+	define_test("BAP/UCL/STR/BV-532-C [UCL, AC 8(ii), Generic] Right",
+		test_setup, test_select,
+		&cfg_str_ac8ii_R, DISC_AC8ii_R);
+
+	/* TODO: this one fails due to exceeding ATT MTU */
+	define_test("BAP/UCL/STR/BV-533-C [UCL, AC 11(i), Generic]",
+		test_setup, test_select, &cfg_str_ac11i, STR_AC11i);
+
+	/* TODO: combine these to a single test with two simultaneous BAP */
+	define_test("BAP/UCL/STR/BV-534-C [UCL, AC 11(ii), Generic] Left",
+		test_setup, test_select, &cfg_str_ac11ii_L, DISC_AC11ii_L);
+	define_test("BAP/UCL/STR/BV-534-C [UCL, AC 11(ii), Generic] Right",
+		test_setup, test_select, &cfg_str_ac11ii_R, DISC_AC11ii_R);
+
+	/* Custom tests: */
+	define_test("BAP/UCL/STR/BLUEZ-1 [UCL, Custom AC, 8 -> 2 Ch, Generic]",
+		test_setup, test_select, &cfg_str_many_2, DISC_MANY);
+	define_test("BAP/UCL/STR/BLUEZ-2 [UCL, Custom AC, 8 -> 4+4 Ch, "
+					"Generic]",
+		test_setup, test_select, &cfg_str_many_8, DISC_MANY);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -8802,6 +10264,7 @@ int main(int argc, char *argv[])
 	test_bsnk_scc();
 	test_bsnk_str();
 	test_bsrc_str();
+	test_ucl_str();
 
 	return tester_run();
 }
-- 
2.51.1

