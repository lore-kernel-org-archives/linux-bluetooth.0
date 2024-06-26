Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A41891DB
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414157; cv=none; b=A7GRJwUJ6yiicVfE2DzSCyART/Tz6vnSesXdclsQbC8x2SUlnQ1hGXidzhcyk11zzeDxlpoDoW0grt/4U0RjSK5Di4tRdOtdjVf6ZXJFz6P9V2OL0ZsonlvCMlIinM1t/S6wljD7dvLAWKnLiQg/WY0iuXsAt9lhb2po6KUS29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414157; c=relaxed/simple;
	bh=uOXJVWuH5fAqZM6wL3b57DttXCg1aabMz6oB+SrXCdA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P04ImznJEzR9WQPMj/EHMGBTIK25gOko0f+E4Je5/vjDxw5WcXkC5jhwau0m1i004ggC6jui7XIHlElfM7ie9FrZWwHnP8bmiZrUiwhiGadDGc+ITqFNYVds+r4mxVNn/Cg8fI6I5/WI1JfisKKT6tB1wAlse7zQrsyTDEgvjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRm00riZ; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRm00riZ"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48f5c2f066cso360633137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719414153; x=1720018953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=asiGyBu+ZM4SkXs/SSvZZtpNfzJbQq8Cupz0myeublI=;
        b=HRm00riZIX9WQZpnr/DpFFrZa8HdQWrfBiz+xOUQ8SWWoFA+6esPERbUZfVB4cjQWD
         L/OD+jOao5hFuq0NDKjoLQjNbOrMoXiV7681UkOnipfFrl8ttsJcT9a8E4j8IEH/NS61
         9h+OLg2NfpcKv0jtGWO/vBOLid5M8xRDN3Bu1PgpuhEBM8p4fi+zqbVCWjTW4IyR9pmr
         H3vTe35MoKdDF5TS/d7B2eOtJFLECPBV/SEFW+rfiTWHHK8lJCdnZEb0NBNzfRJY8pd3
         UT5zmyBjBGeS2sZjlOqnryFgasQpNvEHjSUv80o6zNdlsFWXYVcR/OxcPU5nMSNzZDBB
         EfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414153; x=1720018953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asiGyBu+ZM4SkXs/SSvZZtpNfzJbQq8Cupz0myeublI=;
        b=aTe3iL3PqbskcU+P+wCB/T5MR+Jw0TLozWwWQOZXxxSI2Hx+I4b/Wz9do6sg9nyZ+c
         dwxWFm+LipPE4+emmXkL7aGptHlmVu8qCXU1SJczK8X6VXhTu/N/3cEdemk+POczrthE
         kxTV3ZIkJshu9VCJB3rcTV89Hps95uh//q5ho7y0fH7fiqctqgUFRWWFYoyfFVqJXFP9
         b6DnKBehgMhFcW+czIbl9EFrxayFr8zybFkRBq7G8YxWbPmdgPDq5WRxzDLbKpIv4TLP
         hzai5cDhygaggqwNksnS0ei/9U+cpAsUdxTYOsKgxAdqgcnQ3w7MuYqFW4EHwx2XXofA
         D9WQ==
X-Gm-Message-State: AOJu0Yzhkmqkb4gxCIiQe34zixBFKwTysqxIJ/S4C+zXWlx5LKn5UavU
	1WL3rklfoTdAE1veo2+u1nFkEoi+7fJ/Vo5BgVLQmZWEUCvNVuEWy9OFmA==
X-Google-Smtp-Source: AGHT+IG3/6UHPChATIZRhwDaf6tfbR/v+oXHcBM7ee9kWOFfHBcH8xZk6G0KGomV4qTlQwczYW3thw==
X-Received: by 2002:a67:e941:0:b0:48f:19af:d2a8 with SMTP id ada2fe7eead31-48f690127dfmr5807732137.11.1719414153227;
        Wed, 26 Jun 2024 08:02:33 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48f5cd3cf91sm1203746137.13.2024.06.26.08.02.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:02:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] l2cap-tester: Add tests for multiple data packets
Date: Wed, 26 Jun 2024 11:02:27 -0400
Message-ID: <20240626150229.103047-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests which cover the TX/RX of multiple
packets (up to 32K):

L2CAP BR/EDR Client - Read 32k Success
L2CAP BR/EDR Client - Write 32k Success
L2CAP BR/EDR Server - Read 32k Success
L2CAP BR/EDR Server - Write 32k Success
---
 tools/l2cap-tester.c | 294 ++++++++++++++++++++++++++-----------------
 1 file changed, 180 insertions(+), 114 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index c34080654ed6..b6b879407115 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -45,6 +45,7 @@ struct test_data {
 	uint16_t handle;
 	uint16_t scid;
 	uint16_t dcid;
+	struct l2cap_options l2o;
 	int sk;
 	int sk2;
 	bool host_disconnected;
@@ -332,6 +333,16 @@ static const struct l2cap_data client_connect_pin_success_test = {
 
 static uint8_t l2_data[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
 
+const uint8_t l2_data_32k[32768] = { [0 ... 4095] =  0x00,
+				[4096 ... 8191] =  0x01,
+				[8192 ... 12287] =  0x02,
+				[12288 ... 16383] =  0x03,
+				[16384 ... 20479] =  0x04,
+				[20480 ... 24575] =  0x05,
+				[24576 ... 28671] =  0x06,
+				[28672 ... 32767] =  0x07,
+};
+
 static const struct l2cap_data client_connect_read_success_test = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -339,6 +350,13 @@ static const struct l2cap_data client_connect_read_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_data client_connect_read_32k_success_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.read_data = l2_data_32k,
+	.data_len = sizeof(l2_data_32k),
+};
+
 static const struct l2cap_data client_connect_write_success_test = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -346,6 +364,13 @@ static const struct l2cap_data client_connect_write_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_data client_connect_write_32k_success_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.write_data = l2_data_32k,
+	.data_len = sizeof(l2_data_32k),
+};
+
 static const struct l2cap_data client_connect_tx_timestamping_test = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -399,6 +424,16 @@ static const struct l2cap_data l2cap_server_read_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_data l2cap_server_read_32k_success_test = {
+	.server_psm = 0x1001,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.read_data = l2_data_32k,
+	.data_len = sizeof(l2_data_32k),
+};
+
 static const struct l2cap_data l2cap_server_write_success_test = {
 	.server_psm = 0x1001,
 	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
@@ -409,6 +444,16 @@ static const struct l2cap_data l2cap_server_write_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_data l2cap_server_write_32k_success_test = {
+	.server_psm = 0x1001,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.write_data = l2_data_32k,
+	.data_len = sizeof(l2_data_32k),
+};
+
 static const uint8_t l2cap_sec_block_rsp[] = {	0x00, 0x00,	/* dcid */
 						0x41, 0x00,	/* scid */
 						0x03, 0x00,	/* Sec Block */
@@ -1104,50 +1149,54 @@ static void test_basic(const void *test_data)
 	tester_test_passed();
 }
 
-static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static void received_data(struct test_data *tdata, const void *buf,
+					uint16_t len, const void *data,
+					uint16_t data_len)
 {
-	struct test_data *data = tester_get_data();
-	const struct l2cap_data *l2data = data->test_data;
-	char buf[1024];
-	int sk;
+	static struct iovec iov;
 
-	tester_debug("Client received data");
+	util_iov_append(&iov, buf, len);
 
-	sk = g_io_channel_unix_get_fd(io);
-	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
-		tester_warn("Unable to read %u bytes", l2data->data_len);
+	tester_debug("read: %d/%zu", len, iov.iov_len);
+
+	/* Check if all the data has been received */
+	if (iov.iov_len < data_len)
+		return;
+
+	--tdata->step;
+
+	if (iov.iov_len != data_len || memcmp(iov.iov_base, data, data_len))
 		tester_test_failed();
-		return FALSE;
-	}
-
-	if (memcmp(buf, l2data->read_data, l2data->data_len))
-		tester_test_failed();
-	else
+	else if (!tdata->step)
 		tester_test_passed();
 
-	return FALSE;
+	free(iov.iov_base);
+	iov.iov_base = NULL;
+	iov.iov_len = 0;
 }
 
-static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
+static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	char buf[1024];
 	int sk;
+	ssize_t len;
 
 	sk = g_io_channel_unix_get_fd(io);
-	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
-		tester_warn("Unable to read %u bytes", l2data->data_len);
+
+	len = read(sk, buf, sizeof(buf));
+	if (len < 0) {
+		tester_warn("Unable to read: %s (%d)", strerror(errno), errno);
 		tester_test_failed();
 		return FALSE;
 	}
 
-	if (memcmp(buf, l2data->read_data, l2data->data_len))
-		tester_test_failed();
-	else
-		tester_test_passed();
+	received_data(data, buf, len, l2data->read_data, l2data->data_len);
+
+	if (data->step)
+		return TRUE;
 
 	return FALSE;
 }
@@ -1158,36 +1207,7 @@ static void bthost_received_data(const void *buf, uint16_t len,
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 
-	tester_debug("BTHost received data: %u bytes", len);
-
-	--data->step;
-
-	if (len != l2data->data_len) {
-		tester_test_failed();
-		return;
-	}
-
-	if (memcmp(buf, l2data->write_data, l2data->data_len))
-		tester_test_failed();
-	else if (!data->step)
-		tester_test_passed();
-}
-
-static void server_bthost_received_data(const void *buf, uint16_t len,
-							void *user_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct l2cap_data *l2data = data->test_data;
-
-	if (len != l2data->data_len) {
-		tester_test_failed();
-		return;
-	}
-
-	if (memcmp(buf, l2data->write_data, l2data->data_len))
-		tester_test_failed();
-	else
-		tester_test_passed();
+	received_data(data, buf, len, l2data->write_data, l2data->data_len);
 }
 
 static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
@@ -1234,27 +1254,26 @@ static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
 static bool check_mtu(struct test_data *data, int sk)
 {
 	const struct l2cap_data *l2data = data->test_data;
-	struct l2cap_options l2o;
 	socklen_t len;
 
-	memset(&l2o, 0, sizeof(l2o));
+	memset(&data->l2o, 0, sizeof(data->l2o));
 
 	if (data->hciemu_type == HCIEMU_TYPE_LE &&
 				(l2data->client_psm || l2data->server_psm)) {
 		/* LE CoC enabled kernels should support BT_RCVMTU and
 		 * BT_SNDMTU.
 		 */
-		len = sizeof(l2o.imtu);
+		len = sizeof(data->l2o.imtu);
 		if (getsockopt(sk, SOL_BLUETOOTH, BT_RCVMTU,
-							&l2o.imtu, &len) < 0) {
+						&data->l2o.imtu, &len) < 0) {
 			tester_warn("getsockopt(BT_RCVMTU): %s (%d)",
 					strerror(errno), errno);
 			return false;
 		}
 
-		len = sizeof(l2o.omtu);
+		len = sizeof(data->l2o.omtu);
 		if (getsockopt(sk, SOL_BLUETOOTH, BT_SNDMTU,
-							&l2o.omtu, &len) < 0) {
+						&data->l2o.omtu, &len) < 0) {
 			tester_warn("getsockopt(BT_SNDMTU): %s (%d)",
 					strerror(errno), errno);
 			return false;
@@ -1262,8 +1281,9 @@ static bool check_mtu(struct test_data *data, int sk)
 	} else {
 		/* For non-LE CoC enabled kernels we need to fall back to
 		 * L2CAP_OPTIONS, so test support for it as well */
-		len = sizeof(l2o);
-		if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len) < 0) {
+		len = sizeof(data->l2o);
+		if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &data->l2o,
+						&len) < 0) {
 			 tester_warn("getsockopt(L2CAP_OPTIONS): %s (%d)",
 						strerror(errno), errno);
 			 return false;
@@ -1326,6 +1346,84 @@ static void l2cap_tx_timestamping(struct test_data *data, GIOChannel *io)
 	data->err_io_id = g_io_add_watch(io, G_IO_ERR, recv_errqueue, data);
 }
 
+static int l2cap_send(int sk, const void *data, size_t len, uint16_t mtu)
+{
+	struct iovec iov = { (void *)data, len };
+	int err;
+	size_t total = 0;
+
+	len = MIN(mtu, len);
+
+	while (iov.iov_len) {
+		size_t l = MIN(iov.iov_len, len);
+
+		err = write(sk, util_iov_pull_mem(&iov, l), l);
+		if (err < 0)
+			return -errno;
+
+		total += err;
+		tester_debug("write: %d/%zu", err, total);
+	}
+
+	return total;
+}
+
+static void l2cap_read_data(struct test_data *data, GIOChannel *io,
+							uint16_t cid)
+{
+	const struct l2cap_data *l2data = data->test_data;
+	struct bthost *bthost;
+	struct iovec iov = { (void *)l2data->read_data, l2data->data_len };
+	size_t len;
+
+	data->step = 0;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	g_io_add_watch(io, G_IO_IN, sock_received_data, NULL);
+
+	len = MIN(iov.iov_len, data->l2o.imtu);
+
+	while (iov.iov_len) {
+		size_t l = MIN(iov.iov_len, len);
+
+		bthost_send_cid(bthost, data->handle, cid,
+					util_iov_pull_mem(&iov, l), l);
+	}
+
+	++data->step;
+}
+
+static void l2cap_write_data(struct test_data *data, GIOChannel *io,
+							uint16_t cid)
+{
+	const struct l2cap_data *l2data = data->test_data;
+	struct bthost *bthost;
+	ssize_t ret;
+	int sk;
+	unsigned int count;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	data->step = 0;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_add_cid_hook(bthost, data->handle, cid, bthost_received_data,
+							NULL);
+
+	l2cap_tx_timestamping(data, io);
+
+	for (count = 0; count < l2data->repeat_send + 1; ++count) {
+		ret = l2cap_send(sk, l2data->write_data, l2data->data_len,
+							data->l2o.omtu);
+		if (ret != l2data->data_len) {
+			tester_warn("Unable to write all data: "
+					"%zd != %u", ret, l2data->data_len);
+			tester_test_failed();
+		}
+		++data->step;
+	}
+}
+
 static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1356,37 +1454,10 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	if (l2data->read_data) {
-		struct bthost *bthost;
-
-		bthost = hciemu_client_get_host(data->hciemu);
-		g_io_add_watch(io, G_IO_IN, client_received_data, NULL);
-
-		bthost_send_cid(bthost, data->handle, data->dcid,
-					l2data->read_data, l2data->data_len);
-
+		l2cap_read_data(data, io, data->dcid);
 		return FALSE;
 	} else if (l2data->write_data) {
-		struct bthost *bthost;
-		ssize_t ret;
-		unsigned int count;
-
-		data->step = 0;
-
-		bthost = hciemu_client_get_host(data->hciemu);
-		bthost_add_cid_hook(bthost, data->handle, data->dcid,
-					bthost_received_data, NULL);
-
-		l2cap_tx_timestamping(data, io);
-
-		for (count = 0; count < l2data->repeat_send + 1; ++count) {
-			ret = write(sk, l2data->write_data, l2data->data_len);
-			if (ret != l2data->data_len) {
-				tester_warn("Unable to write all data");
-				tester_test_failed();
-			}
-			++data->step;
-		}
-
+		l2cap_write_data(data, io, data->dcid);
 		return FALSE;
 	} else if (l2data->shut_sock_wr) {
 		g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
@@ -2087,31 +2158,10 @@ static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	if (l2data->read_data) {
-		struct bthost *bthost;
-
-		bthost = hciemu_client_get_host(data->hciemu);
-		g_io_add_watch(io, G_IO_IN, server_received_data, NULL);
-		bthost_send_cid(bthost, data->handle, data->dcid,
-					l2data->read_data, l2data->data_len);
-
-		g_io_channel_unref(io);
-
+		l2cap_read_data(data, io, data->dcid);
 		return FALSE;
 	} else if (l2data->write_data) {
-		struct bthost *bthost;
-		ssize_t ret;
-
-		bthost = hciemu_client_get_host(data->hciemu);
-		bthost_add_cid_hook(bthost, data->handle, data->scid,
-					server_bthost_received_data, NULL);
-
-		ret = write(sk, l2data->write_data, l2data->data_len);
-
-		if (ret != l2data->data_len) {
-			tester_warn("Unable to write all data");
-			tester_test_failed();
-		}
-
+		l2cap_write_data(data, io, data->scid);
 		return FALSE;
 	}
 
@@ -2405,10 +2455,18 @@ int main(int argc, char *argv[])
 					&client_connect_read_success_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - Read 32k Success",
+					&client_connect_read_32k_success_test,
+					setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client - Write Success",
 					&client_connect_write_success_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - Write 32k Success",
+					&client_connect_write_32k_success_test,
+					setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client - TX Timestamping",
 					&client_connect_tx_timestamping_test,
 					setup_powered_client, test_connect);
@@ -2437,10 +2495,18 @@ int main(int argc, char *argv[])
 					&l2cap_server_read_success_test,
 					setup_powered_server, test_server);
 
+	test_l2cap_bredr("L2CAP BR/EDR Server - Read 32k Success",
+					&l2cap_server_read_32k_success_test,
+					setup_powered_server, test_server);
+
 	test_l2cap_bredr("L2CAP BR/EDR Server - Write Success",
 					&l2cap_server_write_success_test,
 					setup_powered_server, test_server);
 
+	test_l2cap_bredr("L2CAP BR/EDR Server - Write 32k Success",
+					&l2cap_server_write_32k_success_test,
+					setup_powered_server, test_server);
+
 	test_l2cap_bredr("L2CAP BR/EDR Server - Security Block",
 					&l2cap_server_sec_block_test,
 					setup_powered_server, test_server);
-- 
2.45.2

