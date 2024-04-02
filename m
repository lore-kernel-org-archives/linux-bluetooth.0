Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC315A492
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076200; cv=pass; b=R6DtvUDYl9n4thNEV0ZnPJPAC7kWzSioE1UpTsG39QeFgbVxLw1HkMTLdBcjsQGAff/DRjH7wi1UlXUmXVWozao2ezlGA3cHtV9qLCHSAwj90k9xg6w4D0KHtY9F6hTmBGj1eYoT1tbDAqjBnfXTlREOvy8ziU8nyRAlxdiNH54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076200; c=relaxed/simple;
	bh=UM2Fz67RCP4hjwv+W/5Wwly1/4e3JvNMdgE9rA5csPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATc1OiXdb2OO976vi4I881f1AZiUJ9QOp0EeKy/jmjCpVdmihYIMOIdP9F5JyluXVmHZ+nBHphCIOiGp2m38fcRCGVyxQG2deMdxlNhBAhJX7OsXaLTGzQWKnhjHkRb+nqi2d7xNgkIsCKQ7JWLGdv9icoINgOsozaFcV0VhDdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rHZz3bQr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rHZz3bQr"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DGD4L24z101J;
	Tue,  2 Apr 2024 19:43:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yuwflCJA+C8UBEaIPa+SA4Nk22hoi/N4UIc6vVjIdY=;
	b=rHZz3bQrc2HZ0173Ykiai9XGJTK2odVP64QtCKx14Rdr4gHGS1BcTlx52BzjIAaYRE5BmD
	mWnf7iv875dI64aO62d6KhOlgMQuNLB75M24DRhuZ/r41D/uOJnVwzyc/QdvtDHKi4+gIK
	OdTZ9Ou/l71Rkp6sbaTAgUG9urBVqVs=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076197; a=rsa-sha256; cv=none;
	b=WBmFrJmpjqcgs6AjsfPpnVGB9t8fDfk1IYO20O4uzYIUZyTa6yPWq4sJGrJ5dmE6d52/OP
	kwnNU9Va/WiLqgZtnJnFPb+DUGcg6iAcaemVH4I6/Fza5zcdbdfK2+l/MvWx+pVBgkQMFr
	iBquE3ptp2hm40tG7RQDPN8MBRL1amQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yuwflCJA+C8UBEaIPa+SA4Nk22hoi/N4UIc6vVjIdY=;
	b=SPR9mdmzZtCeR/cn6/hWHA6dUCkJ1gmyEXhJqyFjVVQrt1vex9vVIX/lUGl7FjWLXYmLx4
	K+sz4C1BidiX/RNHaSC8Kq6P6vjL7ZXWioaIv+/4hC2yfQxqFS+kAIupxkDSOxRJgddqLF
	arg9s/SkDAC1EHXTnV9QtnpyKMf4o3A=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 8/8] iso-tester: add test for BT_NO_ERRQUEUE_POLL
Date: Tue,  2 Apr 2024 19:43:05 +0300
Message-ID: <8da26d408b2dee74922538f1739091ea9b6286b9.1712076170.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712076170.git.pav@iki.fi>
References: <cover.1712076170.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also test BT_NO_ERRQUEUE_POLL is experimental feature.

Add test:

ISO Send - TX No Poll Timestamping
---
 tools/iso-tester.c   | 121 ++++++++++++++++++++++++++++++++++++++++++-
 tools/tester-utils.h |   3 ++
 2 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index c12675a18..9e2877a37 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -467,7 +467,7 @@ struct test_data {
 	uint16_t handle;
 	uint16_t acl_handle;
 	struct queue *io_queue;
-	unsigned int io_id[3];
+	unsigned int io_id[4];
 	uint8_t client_num;
 	int step;
 	bool reconnect;
@@ -497,6 +497,7 @@ struct iso_client_data {
 	bool msg_timestamping;
 	unsigned int send_extra;
 	unsigned int send_extra_pre_ts;
+	bool no_errqueue_poll;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io);
@@ -632,6 +633,18 @@ static const uint8_t reset_iso_socket_param[] = {
 	0x00,						/* Action - disable */
 };
 
+static const uint8_t set_no_errqueue_poll_param[] = {
+	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
+	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
+	0x01,						/* Action - enable */
+};
+
+static const uint8_t reset_no_errqueue_poll_param[] = {
+	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
+	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
+	0x00,						/* Action - disable */
+};
+
 static void set_iso_socket_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -643,9 +656,21 @@ static void set_iso_socket_callback(uint8_t status, uint16_t length,
 	tester_print("ISO socket feature is enabled");
 }
 
+static void set_no_errqueue_poll_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_print("No Errqueue Poll feature could not be enabled");
+		return;
+	}
+
+	tester_print("No Errqueue Poll feature is enabled");
+}
+
 static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct iso_client_data *isodata = test_data;
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
@@ -661,6 +686,13 @@ static void test_pre_setup(const void *test_data)
 		  sizeof(set_iso_socket_param), set_iso_socket_param,
 		  set_iso_socket_callback, NULL, NULL);
 
+	if (isodata && isodata->no_errqueue_poll) {
+		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+			  sizeof(set_no_errqueue_poll_param),
+			  set_no_errqueue_poll_param,
+			  set_no_errqueue_poll_callback, NULL, NULL);
+	}
+
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
 					read_index_list_callback, NULL, NULL);
 }
@@ -668,11 +700,19 @@ static void test_pre_setup(const void *test_data)
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct iso_client_data *isodata = test_data;
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
 		  sizeof(reset_iso_socket_param), reset_iso_socket_param,
 		  NULL, NULL, NULL);
 
+	if (isodata && isodata->no_errqueue_poll) {
+		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+			  sizeof(reset_no_errqueue_poll_param),
+			  reset_no_errqueue_poll_param,
+			  NULL, NULL, NULL);
+	}
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -1028,6 +1068,16 @@ static const struct iso_client_data connect_send_tx_msg_timestamping = {
 	.msg_timestamping = true,
 };
 
+static const struct iso_client_data connect_send_tx_no_poll_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_TX_SOFTWARE),
+	.send_extra = 1,
+	.no_errqueue_poll = true,
+};
+
 static const struct iso_client_data listen_16_2_1_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2124,6 +2174,37 @@ static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+static gboolean iso_fail_errqueue(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_warn("Unexpected POLLERR");
+	tester_test_failed();
+
+	data->io_id[3] = 0;
+	return FALSE;
+}
+
+static gboolean iso_timer_errqueue(gpointer user_data)
+{
+	struct test_data *data = user_data;
+	GIOChannel *io;
+	gboolean ret;
+
+	io = queue_peek_head(data->io_queue);
+	g_assert(io);
+
+	ret = iso_recv_errqueue(io, G_IO_IN, data);
+	if (!ret) {
+		if (data->io_id[3])
+			g_source_remove(data->io_id[3]);
+		data->io_id[3] = 0;
+	}
+
+	return ret;
+}
+
 static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
@@ -2146,7 +2227,39 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue, data);
+	if (isodata->no_errqueue_poll) {
+		uint32_t flag = 1;
+
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_NO_ERRQUEUE_POLL,
+							&flag, sizeof(flag));
+		if (err < 0) {
+			tester_warn("setsockopt BT_NO_ERRQUEUE_POLL: %s (%d)",
+						strerror(errno), errno);
+			tester_test_failed();
+			return;
+		}
+
+		if (!data->io_queue)
+			data->io_queue = queue_new();
+		queue_push_head(data->io_queue, g_io_channel_ref(io));
+
+		data->io_id[2] = g_timeout_add(100, iso_timer_errqueue, data);
+		data->io_id[3] = g_io_add_watch(io, G_IO_ERR, iso_fail_errqueue,
+									data);
+	} else {
+		uint32_t flag = 0;
+
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_NO_ERRQUEUE_POLL,
+							&flag, sizeof(flag));
+		if (err >= 0) {
+			tester_warn("BT_NO_ERRQUEUE_POLL available");
+			tester_test_failed();
+			return;
+		}
+
+		data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue,
+									data);
+	}
 
 	if (isodata->msg_timestamping)
 		so.flags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
@@ -3346,6 +3459,10 @@ int main(int argc, char *argv[])
 			&connect_send_tx_msg_timestamping, setup_powered,
 			test_connect);
 
+	test_iso("ISO Send - TX No Poll Timestamping",
+			&connect_send_tx_no_poll_timestamping, setup_powered,
+			test_connect);
+
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
diff --git a/tools/tester-utils.h b/tools/tester-utils.h
index 617de842e..b6de084a4 100644
--- a/tools/tester-utils.h
+++ b/tools/tester-utils.h
@@ -89,6 +89,9 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 
 	ret = recvmsg(sk, &msg, MSG_ERRQUEUE);
 	if (ret < 0) {
+		if (ret == EAGAIN || ret == EWOULDBLOCK)
+			return data->count - data->pos;
+
 		tester_warn("Failed to read from errqueue: %s (%d)",
 							strerror(errno), errno);
 		return -EINVAL;
-- 
2.44.0

