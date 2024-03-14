Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84E77627
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440502; cv=pass; b=SJuQHzaCz6a3DOtTjZMu4E7neVfMN4lt5Q8ZQstGdq5PcNJQmpEKGwV6jc6jW3N4HdqHlPmQMpHaLusN9eORIwLxA22d+OYPRnNNX8riWW/rP4dUdKTFncEBBuXtMkG/Iol0rcmu0U+CcZE4f76BZ8qWD8Eo5Kmbb0SxpIznPPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440502; c=relaxed/simple;
	bh=gxyYWf4Jg3YRpOtZpXSoGqJGHXP5LIfWNFG3g5de3Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFoBmRnN66utJNqTJNcAVr3Iqhqy1ixHLmF2oJP3U6n6B7ho5VSSKv9ZEhDtx/KTUF6OKmsbVCoJDitxtt1fc4O8vH9K98Jl+Bc+TTyugB4qgRso6Mf7g3WfnnDUPzph5Q6QSljyWSxh++SxRXMIokfF6X1vVDuec3/yPIHa9yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=gQCYfbKI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gQCYfbKI"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TwbLQ5zzGz49Pys;
	Thu, 14 Mar 2024 20:21:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710440495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAbbky+ehz5ZvmAaQPE9CHGLSR1jUv9VD7+Y1PmIYRU=;
	b=gQCYfbKIUFoHnUExTU5pgUr1fC7uLbxkTE7fT4jmDrNxNgPr5gbFSxBAP4DF4qN3JtW7uL
	wF0MOWggVlSloSA5Ud9esyvlGOBOph7tMPMSK71ukgkF7uhj/YEVdzglj6ClIZpdvvcADk
	l10E7LoJ4D2Dx01YhjM5qXS04A7IoS6WXfeLA9nXRoPCFQZQJYzeao+bXOW7NtnZ+A0oqH
	Nb8ZiO/PTtJw26wIKgQ5BLHTw5BXdUFl0zPKTWmEUNh0vdXkB0EellkVT393BlnwFlGsZ2
	8tzPCMBE9tlfEj+fySIurt0Rz5wXbRG4KBJTvF3+7xZtljsbY/w4uv1qp6gHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710440495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAbbky+ehz5ZvmAaQPE9CHGLSR1jUv9VD7+Y1PmIYRU=;
	b=eZ+pjaDq7LQHtUDiYKoY4cytUDNZgkmUzgMx703Y2q/qpK2RYMm5AKH1bkiLxdidofy435
	ZNDFKXH1cPDRGUrSiliYf0y9S8HpTUogaEiMIWGqY6ie2R3XP0PYPQ0tdo0QsE5ByXTise
	xoCa0O/Xsr2fuQwVsbJ78PXTp2eXyDMb7J8OoLkO9G4KG4wGwkwFk7NIAxDBxXNEqZJBdg
	c8CH3QiRmWH7IdigdZz97zDwfbVbXfNbp+iQwEhPwC43yeWqGsLovNCdYo76hAO4QWd/Hu
	Jgpxgse6WfNlgEQM0X/DkQeh5vQZOPp7i8xBYxi2K0y0Qat2LGzgIf+X6ZaucA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710440495; a=rsa-sha256;
	cv=none;
	b=ZCyPQmNcfn4iox9sWSgN9FPOqYsn4hkeI6I7dKqD+wX9aShniZXAWR1rBnTye+CTyrw1A/
	nbVWWZq/sCS4kSI/Ksx+56j0Vuc79oeMn8w29ww/d3HKE+uyL3Y8EaQkl+beAAGLvIXDB+
	wvH4/U5AlB8hx5jz8p50gKmN5OI8x19MB2sTKZ4BIHg/YhrGH5vswIIappDs23+Cl4KESW
	kpnR6F8nZKeef599CgJ4vr0kBCeZeISQSPCWlGd+jPLmwV/ywTa7BwhI/VlFhfSkc6ALCf
	Q5tGDO11jofPtB9DGNTexX91qvYQXeZWRsZr+vdAJzE3b90wY8BH4tv1XBXODA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 9/9] iso-tester: add test for BT_NO_ERRQUEUE_POLL
Date: Thu, 14 Mar 2024 20:21:18 +0200
Message-ID: <9bb9a9149e16541db487f1c1fe5496a432d3a5f6.1710440408.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710440408.git.pav@iki.fi>
References: <cover.1710440408.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test:

ISO Send - TX No Poll Timestamping
---
 tools/iso-tester.c   | 72 ++++++++++++++++++++++++++++++++++++++++++--
 tools/tester-utils.h |  3 ++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 08f8d0286..3a81f74bc 100644
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
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -1026,6 +1027,16 @@ static const struct iso_client_data connect_send_tx_msg_timestamping = {
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
@@ -2122,6 +2133,37 @@ static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
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
@@ -2144,7 +2186,29 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 
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
+		data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue,
+									data);
+	}
 
 	if (isodata->msg_timestamping)
 		so.flags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
@@ -3321,6 +3385,10 @@ int main(int argc, char *argv[])
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

