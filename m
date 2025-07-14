Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51031FDA94
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501895; cv=pass; b=IekK1i9q0z2UDMxlBvkGnEhKZ0K7yu07L7YNeAEIibPRpiea2GRr2lMdCkKW0Slg/hp8g85xZxIOmhRub3kx+/g+2Ez3dZ628eAFI8jWXrRVERhlLhnBhninzJ3FFNL414B3VtSIm/LBfVgS1Kmy2MryP6OdLO1IJIGYosAQ8Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501895; c=relaxed/simple;
	bh=BnJE6BCJiCKi9ahdTXfQe/LSCxMjGyEzTxxyIJbeKSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNl8jJir4DXI6dGprvJvuIMBS0pyQhnITWj8P7zuIa5EbB4tcdOfZOzD9Q5EipSXsSS4mIOJkCgRPSv2A4m3KOsfo678EtkpjdTdH2kIHbP7Sokoadrfii2uMguKTwn8Ai2nb0Iid03iBKOZM142PjK5e7ilaztURuKGgXMQWkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=FVMcXjX3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="FVMcXjX3"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bgkbR1RT0zyVd;
	Mon, 14 Jul 2025 17:04:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1752501891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q9FqoJ0N3ofCsSESWqPVLfk0nlfmV8KmWFyvRiH6ims=;
	b=FVMcXjX3nN0YRdO1mzlXu7guUYfK9HTauP/SXu65mwloCOXCcT4rsCcbKbsRe6PqtxkqVs
	4aIUF81VkQYg/dpmtVrvtUVr8e/ZZsNeE38mn7u1pdSnLQCbBV0zl9LMQSwREeSjMSA7sU
	Jc4UZqCGG7ASNVinl6ztrvYnfIK6ER4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1752501891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q9FqoJ0N3ofCsSESWqPVLfk0nlfmV8KmWFyvRiH6ims=;
	b=VHpsrEfwTj667ItVkGF3xd/raAGlcGiLJnKpEuoTiAK2OGAK7O+KsXn4SfY2CIJCUkQmU8
	iiSohYNe2mbK+fESd5cxmU/YhcvkpiOqYt0o+B59X2TfdEiVVgbHa16w7VKP/OzN6OPlhw
	qDQQA1Rhb66lZToW+DZb0BR2400pl2E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1752501891; a=rsa-sha256; cv=none;
	b=TBF8eAKYaDWYc4l06+D/GrhQhorjJzMyn2jOOL5wRGcEhKTrgIK/vZLIsw6lfABny7fd4X
	DAcZ+5HVo0LTPt6uY/fpEr2WuKAvsbCK4BxK+KitzoULYL+cWN6ru2UGMZdI5UVxY0u/+9
	rxIxwJv6sXmBMdukdRti45bmEk86Z/U=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] lib: tools: remove POLL_ERRQUEUE
Date: Mon, 14 Jul 2025 17:04:44 +0300
Message-ID: <2ffec6539fe38318c713b48985aaddda9671f258.1752501450.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This experimental feature did not land to mainline kernel, and probably
would need to be done differently.

Remove defines and tests for it.
---
 lib/bluetooth.h    |   2 -
 src/shared/util.c  |   2 -
 tools/iso-tester.c | 127 +--------------------------------------------
 3 files changed, 1 insertion(+), 130 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 9b6b54d5d..150679d72 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -253,8 +253,6 @@ enum {
 
 #define BT_ISO_BASE		20
 
-#define BT_POLL_ERRQUEUE	21
-
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
diff --git a/src/shared/util.c b/src/shared/util.c
index fa058170e..c2cf2bf72 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1677,8 +1677,6 @@ static const struct {
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
 	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
 		"BlueZ Experimental ISO Socket"},
-	{ "69518c4c-b69f-4679-8bc1-c021b47b5733",
-		"BlueZ Experimental Poll Errqueue"},
 	{ }
 };
 
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 56550882e..2c674171d 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -515,9 +515,6 @@ struct iso_client_data {
 	 * Used for testing TX timestamping OPT_ID.
 	 */
 	unsigned int repeat_send;
-
-	/* Disable BT_POLL_ERRQUEUE before enabling TX timestamping */
-	bool no_poll_errqueue;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io,
@@ -654,18 +651,6 @@ static const uint8_t reset_iso_socket_param[] = {
 	0x00,						/* Action - disable */
 };
 
-static const uint8_t set_poll_errqueue_param[] = {
-	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
-	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
-	0x01,						/* Action - enable */
-};
-
-static const uint8_t reset_poll_errqueue_param[] = {
-	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
-	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
-	0x00,						/* Action - disable */
-};
-
 static void set_iso_socket_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -677,26 +662,9 @@ static void set_iso_socket_callback(uint8_t status, uint16_t length,
 	tester_print("ISO socket feature is enabled");
 }
 
-static void set_poll_errqueue_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_print("Poll Errqueue feature could not be enabled");
-		return;
-	}
-
-	tester_print("Poll Errqueue feature is enabled");
-}
-
 static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct iso_client_data *isodata = test_data;
-
-	if (isodata && isodata->no_poll_errqueue) {
-		if (tester_pre_setup_skip_by_default())
-			return;
-	}
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
@@ -712,13 +680,6 @@ static void test_pre_setup(const void *test_data)
 		  sizeof(set_iso_socket_param), set_iso_socket_param,
 		  set_iso_socket_callback, NULL, NULL);
 
-	if (isodata && isodata->no_poll_errqueue) {
-		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
-			  sizeof(set_poll_errqueue_param),
-			  set_poll_errqueue_param,
-			  set_poll_errqueue_callback, NULL, NULL);
-	}
-
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
 					read_index_list_callback, NULL, NULL);
 }
@@ -726,19 +687,11 @@ static void test_pre_setup(const void *test_data)
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct iso_client_data *isodata = test_data;
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
 		  sizeof(reset_iso_socket_param), reset_iso_socket_param,
 		  NULL, NULL, NULL);
 
-	if (isodata && isodata->no_poll_errqueue) {
-		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
-			  sizeof(reset_poll_errqueue_param),
-			  reset_poll_errqueue_param,
-			  NULL, NULL, NULL);
-	}
-
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -1085,16 +1038,6 @@ static const struct iso_client_data connect_send_tx_cmsg_timestamping = {
 	.cmsg_timestamping = true,
 };
 
-static const struct iso_client_data connect_send_tx_no_poll_timestamping = {
-	.qos = QOS_16_2_1,
-	.expect_err = 0,
-	.send = &send_16_2_1,
-	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
-					SOF_TIMESTAMPING_TX_COMPLETION),
-	.repeat_send = 1,
-	.no_poll_errqueue = true,
-};
-
 static const struct iso_client_data listen_16_2_1_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2319,37 +2262,6 @@ static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-static gboolean iso_fail_errqueue(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	struct test_data *data = user_data;
-
-	tester_warn("Unexpected POLLERR");
-	tester_test_failed();
-
-	data->io_id[3] = 0;
-	return FALSE;
-}
-
-static gboolean iso_timer_errqueue(gpointer user_data)
-{
-	struct test_data *data = user_data;
-	GIOChannel *io;
-	gboolean ret;
-
-	io = queue_peek_head(data->io_queue);
-	g_assert(io);
-
-	ret = iso_recv_errqueue(io, G_IO_IN, data);
-	if (!ret) {
-		if (data->io_id[3])
-			g_source_remove(data->io_id[3]);
-		data->io_id[3] = 0;
-	}
-
-	return ret;
-}
-
 static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
@@ -2370,39 +2282,7 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	if (isodata->no_poll_errqueue) {
-		uint32_t flag = 0;
-
-		err = setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
-							&flag, sizeof(flag));
-		if (err < 0) {
-			tester_warn("setsockopt BT_POLL_ERRQUEUE: %s (%d)",
-						strerror(errno), errno);
-			tester_test_failed();
-			return;
-		}
-
-		if (!data->io_queue)
-			data->io_queue = queue_new();
-		queue_push_head(data->io_queue, g_io_channel_ref(io));
-
-		data->io_id[2] = g_timeout_add(100, iso_timer_errqueue, data);
-		data->io_id[3] = g_io_add_watch(io, G_IO_ERR, iso_fail_errqueue,
-									data);
-	} else {
-		uint32_t flag = 1;
-
-		err = setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
-							&flag, sizeof(flag));
-		if (err >= 0) {
-			tester_warn("BT_POLL_ERRQUEUE available");
-			tester_test_failed();
-			return;
-		}
-
-		data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue,
-									data);
-	}
+	data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue, data);
 
 	if (isodata->cmsg_timestamping)
 		so &= ~TS_TX_RECORD_MASK;
@@ -3763,11 +3643,6 @@ int main(int argc, char *argv[])
 			&connect_send_tx_cmsg_timestamping, setup_powered,
 			test_connect);
 
-	/* Test TX timestamping and disabling POLLERR wakeup */
-	test_iso("ISO Send - TX No Poll Timestamping",
-			&connect_send_tx_no_poll_timestamping, setup_powered,
-			test_connect);
-
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
-- 
2.50.1

