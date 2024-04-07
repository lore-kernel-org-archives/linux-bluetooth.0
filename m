Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817439FEC
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503130; cv=pass; b=YftmUSdYbzej6yOvZwS7hPQoG5qxl+uTBqjfFpJEvx/CAGHWQ2yOKnbRYYOv54WzG7eAV89WtkF8/ADZF/yxIb8R706Dm3UxmPWKohprYW26H5wuP6/HZDi9f6T7RJBQlkXzgi8cFifxj3mOP63nQskbyO3OvN+ykxz3g3msjyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503130; c=relaxed/simple;
	bh=+tLstDdicfRRHseZt+4NFiCFZytjP2/QzgxOd04EEjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvIBuZ03n4PWSkSpT4/6nveAmMz79MKj2sPgCJG2rUz/BP7jB1iTOVMRYCPHpOlhsgqds+JcAHBW785hUyaeA8AQ5sQ+gu7sQJdtfigIBpyZsN45kWuLvYvTYdfkRzc5tiggfiMDqIEm9KslYmLCDoWSMp+5naZGaCG6TQ3KX4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=llFNzOPa; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="llFNzOPa"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VCG8Q5mSvz49Q3T;
	Sun,  7 Apr 2024 18:18:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712503127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAI4YaUWJYHKqWTBza6Y8R7sdC/Fa0mza3ST+h24iSY=;
	b=llFNzOPaQXYpt3Y7rtWccb7sGplc7yjihuZRLflbN1hFRW4tz/oEoUIIUW7L/axHkT/dwA
	sQn5NywbQzQKucRa+ypoqcnuyuoS/P7yjFCJ2YxjNl3O6gcl0igKg8otLWS+avHatDa2xh
	/xGelQhFp/ToirwQMvMPk7AmNxueDbFSj/fDbiKlWq4m2xE6iy24U9oVE6RTT2meeIxwJD
	LGZoxlDEGDV2JSMwZj6q8wtlU9OqDPcAF9rn0Zi5VAw7J5jh1OKZOzfBTV88hrndhvgPIH
	EStYMs68trXWtWpkDqpH6LpC/usVi8OHBG74SFS4A1wj8IUqXF+1TrWYVM/TIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712503127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAI4YaUWJYHKqWTBza6Y8R7sdC/Fa0mza3ST+h24iSY=;
	b=h9E/S04Hrp2FdQ0asNjp+109hG/Gwp5cS/8RxnVkttml9i4YvhqqjQJG6nrVRtchKZzpL9
	r2dA9J6/H776mrSGGR246ILfHKSK/puX4H1utUgT5+8e5ONmLkXaepr+nvq52RrppvRKIw
	7bv2uzIx2MrQbqngbmxcFCxsVDG6hTk+r+bkfZYOzOCycnIWNnXG9ZGG3kwegjBwjeLArs
	Orssu2A+69koVchaVWfnRYHiMtN0sPaMQ47NHDaX7GloXNQnAWSf2IQqD7OslfZMYigfV9
	TOl2DPoYsbtvbY/0uKMpKQaaOcKLY39NvDEGi6HJEsneN4OIdsZ/rsfsixRmZw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712503127; a=rsa-sha256;
	cv=none;
	b=dwAbXSKZxpvkynVHaah4cQc0qeQKKLJiQ3URwIBvzMzihKAXKa5tW10yrqdqFgOp/NyUK7
	mkpG7PYB2zVG7pLCiqdJ4lQ5cU5yqvwNFDVy35SiZ6JWZYNVUIACnXCMn0SSZ1r802c3z9
	yD4cytk1D+cYnwVqYZx+GVHyd/SyI3+a2LfXIMoBDTSyLbjIMsQdr5FXtfJ6uUUcDv4GYf
	KITEiW+UHUDn+hOfp+5KVsocPYqw93bEDTMkmEGlnstyifh2Ea6iRHCFHUpyKPTjEOIVaL
	WurAcWWqIOUnESo0vPNmLS18gHtPjAvigxCgvQtYq1mlURMniWcLyRSr2b0fLA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/5] iso-tester: add test for BT_POLL_ERRQUEUE
Date: Sun,  7 Apr 2024 18:18:37 +0300
Message-ID: <1a56b2769c23485127587ab245b6b9e84cccdde3.1712503074.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712503073.git.pav@iki.fi>
References: <cover.1712503073.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also test BT_POLL_ERRQUEUE is experimental feature.

Add test:

ISO Send - TX No Poll Timestamping
---
 tools/iso-tester.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
 tools/tester.h     |   3 ++
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index c29fedd1d..046606068 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -470,7 +470,7 @@ struct test_data {
 	uint16_t handle;
 	uint16_t acl_handle;
 	struct queue *io_queue;
-	unsigned int io_id[3];
+	unsigned int io_id[4];
 	uint8_t client_num;
 	int step;
 	bool reconnect;
@@ -513,6 +513,9 @@ struct iso_client_data {
 	 * Used for testing TX timestamping OPT_ID.
 	 */
 	unsigned int repeat_send;
+
+	/* Disable BT_POLL_ERRQUEUE before enabling TX timestamping */
+	bool no_poll_errqueue;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io);
@@ -648,6 +651,18 @@ static const uint8_t reset_iso_socket_param[] = {
 	0x00,						/* Action - disable */
 };
 
+static const uint8_t set_poll_errqueue_param[] = {
+	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
+	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
+	0x01,						/* Action - enable */
+};
+
+static const uint8_t reset_poll_errqueue_param[] = {
+	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
+	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
+	0x00,						/* Action - disable */
+};
+
 static void set_iso_socket_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -659,9 +674,21 @@ static void set_iso_socket_callback(uint8_t status, uint16_t length,
 	tester_print("ISO socket feature is enabled");
 }
 
+static void set_poll_errqueue_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_print("Poll Errqueue feature could not be enabled");
+		return;
+	}
+
+	tester_print("Poll Errqueue feature is enabled");
+}
+
 static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct iso_client_data *isodata = test_data;
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
@@ -677,6 +704,13 @@ static void test_pre_setup(const void *test_data)
 		  sizeof(set_iso_socket_param), set_iso_socket_param,
 		  set_iso_socket_callback, NULL, NULL);
 
+	if (isodata && isodata->no_poll_errqueue) {
+		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+			  sizeof(set_poll_errqueue_param),
+			  set_poll_errqueue_param,
+			  set_poll_errqueue_callback, NULL, NULL);
+	}
+
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
 					read_index_list_callback, NULL, NULL);
 }
@@ -684,11 +718,19 @@ static void test_pre_setup(const void *test_data)
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct iso_client_data *isodata = test_data;
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
 		  sizeof(reset_iso_socket_param), reset_iso_socket_param,
 		  NULL, NULL, NULL);
 
+	if (isodata && isodata->no_poll_errqueue) {
+		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+			  sizeof(reset_poll_errqueue_param),
+			  reset_poll_errqueue_param,
+			  NULL, NULL, NULL);
+	}
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -1044,6 +1086,16 @@ static const struct iso_client_data connect_send_tx_cmsg_timestamping = {
 	.cmsg_timestamping = true,
 };
 
+static const struct iso_client_data connect_send_tx_no_poll_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_TX_SOFTWARE),
+	.repeat_send = 1,
+	.no_poll_errqueue = true,
+};
+
 static const struct iso_client_data listen_16_2_1_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2162,6 +2214,37 @@ static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
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
@@ -2182,7 +2265,39 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue, data);
+	if (isodata->no_poll_errqueue) {
+		uint32_t flag = 0;
+
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
+							&flag, sizeof(flag));
+		if (err < 0) {
+			tester_warn("setsockopt BT_POLL_ERRQUEUE: %s (%d)",
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
+		uint32_t flag = 1;
+
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
+							&flag, sizeof(flag));
+		if (err >= 0) {
+			tester_warn("BT_POLL_ERRQUEUE available");
+			tester_test_failed();
+			return;
+		}
+
+		data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue,
+									data);
+	}
 
 	if (isodata->cmsg_timestamping)
 		so &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
@@ -3407,6 +3522,11 @@ int main(int argc, char *argv[])
 			&connect_send_tx_cmsg_timestamping, setup_powered,
 			test_connect);
 
+	/* Test TX timestamping and disabling POLLERR wakeup */
+	test_iso("ISO Send - TX No Poll Timestamping",
+			&connect_send_tx_no_poll_timestamping, setup_powered,
+			test_connect);
+
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
diff --git a/tools/tester.h b/tools/tester.h
index 617de842e..b6de084a4 100644
--- a/tools/tester.h
+++ b/tools/tester.h
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

