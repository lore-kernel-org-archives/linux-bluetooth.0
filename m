Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272C2376E0
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745750699; cv=pass; b=uyPKe7QCLXMPvYa7B3qSOttfQBoEpcOjW4F+KktP8k6rB9fSDWI5Y98YqILxF65VnD60/TbCm5tDfEGGt77H6F2oMunLTCpN7IJSf32cniaBS71Xc6blSmAJ1X+zyT2Q+qHliJAbPWavbsHrLanybRQcU8YyvFiHshi3tVIncbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745750699; c=relaxed/simple;
	bh=CIFUk183Yl9bZ6PlEyw087s8V47fpGEyYlVSd2tVAc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G89063VhIrCSlgXkyOyIt6tmSq6VeUa4PkmUrPrsjKKyGfQFNpM6A4LUlzWKIXr8R0uQBuU6GxiPpF/yoAUomRm0M1tochZ4vq5YT4lQRQYcCt6Q3mWWoqq3nfktlnr3/dDI7Uu4lro1yO5jByZPQt2Vg0hKlFsl9bmUZzm4l4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=akHb+tk3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="akHb+tk3"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZljrW2HV3z49QJY;
	Sun, 27 Apr 2025 13:44:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745750683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f6AZj7XWYgdMwSQlxjGUdQ2NoZiGiGc7vvKhY8ypxVI=;
	b=akHb+tk3PbB50EjxLa83skLFJFGqijrFqQHDlrimMC8DAgS7RA4b5gbutBxhayP8pqK0Mo
	+DbxikbZxbczimA2tdBXv6zNEAB1ODITPdLhuDeg9YeQUVFZ7Vx+3229A5+i/z6tZCdspN
	bCftIsf6MDxrj57eE2pJV2OMOwES9g8tGgL4sJqFskpCTvt73ICugI0Og4Y59kb8Y1Jxnv
	c9Hx1P/7c7UdieU24AJD6FUBzZHJxQl6gAi97CrT6zu/00C/Hs54pLFclu1A4l6NJgXXgI
	Vd9ALChrM+oo3/T+upqt2zjEEpS4vz6QjDulvOI0c/Hhi6j6+2fW8AxwvGEktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745750683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f6AZj7XWYgdMwSQlxjGUdQ2NoZiGiGc7vvKhY8ypxVI=;
	b=WHxZ096STwUvaZSUqWx6/ZnpNRU6eDYwBM9pN87wGPSlyWvoD6amlNb0eNreCAAOWQrPkc
	wJnpsOK8pbSmo5pTy3ViAdEzOt7iD6IffygTRvby5wsfbQpklcS6lDLCzc2/aw2ugYwPzC
	qL6TG6raH/RC4GYtWOeJv8vizT0VSO/GinBPPuCHjCnwCVteNekioj7ARr1QOLXlljA61A
	1TpKoEfDAokTETdclo4oomzTiVg892YtNdATvMT5Ats97aRtiLzA2YRu0OgtO5Ods0bWYX
	TEZLpYcPNyvQlOffsc5GIkT5fqruSXAR0xOUCHBpMAFnI+U3XXrm1rEJoQfhlw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745750683; a=rsa-sha256;
	cv=none;
	b=VZLNJp/8zcNNrMM319WADpeJXzaasim9u3n2Fb6OkFdlTn86CfMKeRyAxePIYBJsGWgB8f
	kJR1cHqsUdeuLysO0xq20xu/nCZAMSjo57Cs60yVpMJqjlK5F9S3EcJ8eYZH5LfQfaSTR2
	+D5rFA8Ro7A4shcpHoMEKyeCME8k2bFNP+a7TKgOGctv91cO2q5IuGhxCpWb9l8X/UUi2z
	+YE118awHuWHLf6GQtN5P900RjhlccUnvwzCNrC7Qz9cBPLDo4mcbazNrP5uqiugwZQ4d+
	ZZDSeTuZNhLaEoeDQ7qQN2j1ZEwWEcbKdtdif8/m3iUj1fsuisK/DN20fZpSdw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/5] tools: add tests for RX timestamping
Date: Sun, 27 Apr 2025 13:44:35 +0300
Message-ID: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests:

ISO Receive - RX Timestamping
L2CAP BR/EDR Client - RX Timestamping
L2CAP BR/EDR Client - RX Timestamping 32k
L2CAP LE Client - RX Timestamping
L2CAP LE Client - RX Timestamping 32k
---
 tools/iso-tester.c   | 22 +++++++++++-
 tools/l2cap-tester.c | 60 ++++++++++++++++++++++++++++++++-
 tools/tester.h       | 80 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 63f6951e3..ff6418ce9 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1118,6 +1118,15 @@ static const struct iso_client_data listen_16_2_1_recv_pkt_status = {
 	.pkt_status = 0x02,
 };
 
+static const struct iso_client_data listen_16_2_1_recv_rx_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE),
+};
+
 static const struct iso_client_data defer_16_2_1 = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2148,7 +2157,7 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
 	int sk = g_io_channel_unix_get_fd(io);
-	unsigned char control[64];
+	unsigned char control[256];
 	ssize_t ret;
 	char buf[1024];
 	struct msghdr msg;
@@ -2202,6 +2211,9 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	if (isodata->so_timestamping & SOF_TIMESTAMPING_RX_SOFTWARE)
+		rx_timestamp_check(&msg);
+
 	if (memcmp(buf, isodata->recv->iov_base, ret))
 		tester_test_failed();
 	else
@@ -2224,6 +2236,10 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 		return;
 	}
 
+	if (rx_timestamping_init(g_io_channel_unix_get_fd(io),
+						isodata->so_timestamping))
+		return;
+
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_send_iso(host, data->handle, isodata->ts, sn++, 0,
 				isodata->pkt_status, isodata->recv, 1);
@@ -3704,6 +3720,10 @@ int main(int argc, char *argv[])
 						&listen_16_2_1_recv_pkt_status,
 						setup_powered, test_listen);
 
+	test_iso("ISO Receive - RX Timestamping",
+					&listen_16_2_1_recv_rx_timestamping,
+					setup_powered, test_listen);
+
 	test_iso("ISO Defer - Success", &defer_16_2_1, setup_powered,
 							test_defer);
 
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 41ef62578..9087d635d 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -357,6 +357,24 @@ static const struct l2cap_data client_connect_read_32k_success_test = {
 	.data_len = sizeof(l2_data_32k),
 };
 
+static const struct l2cap_data client_connect_rx_timestamping_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.read_data = l2_data,
+	.data_len = sizeof(l2_data),
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE),
+};
+
+static const struct l2cap_data client_connect_rx_timestamping_32k_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.read_data = l2_data_32k,
+	.data_len = sizeof(l2_data_32k),
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE),
+};
+
 static const struct l2cap_data client_connect_write_success_test = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -575,6 +593,27 @@ static const struct l2cap_data le_client_connect_read_32k_success_test = {
 	.data_len = sizeof(l2_data_32k),
 };
 
+static const struct l2cap_data le_client_connect_rx_timestamping_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.read_data = l2_data,
+	.data_len = sizeof(l2_data),
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE),
+};
+
+static const struct l2cap_data le_client_connect_rx_timestamping_32k_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mtu = 672,
+	.mps = 251,
+	.credits = 147,
+	.read_data = l2_data_32k,
+	.data_len = sizeof(l2_data_32k),
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE),
+};
+
 static const struct l2cap_data le_client_connect_write_success_test = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -1227,13 +1266,14 @@ static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
+	bool tstamp = l2data->so_timestamping & SOF_TIMESTAMPING_RX_SOFTWARE;
 	char buf[1024];
 	int sk;
 	ssize_t len;
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	len = read(sk, buf, sizeof(buf));
+	len = recv_tstamp(sk, buf, sizeof(buf), tstamp);
 	if (len < 0) {
 		tester_warn("Unable to read: %s (%d)", strerror(errno), errno);
 		tester_test_failed();
@@ -1430,6 +1470,10 @@ static void l2cap_read_data(struct test_data *data, GIOChannel *io,
 
 	data->step = 0;
 
+	if (rx_timestamping_init(g_io_channel_unix_get_fd(io),
+						l2data->so_timestamping))
+		return;
+
 	bthost = hciemu_client_get_host(data->hciemu);
 	g_io_add_watch(io, G_IO_IN, sock_received_data, NULL);
 
@@ -2535,6 +2579,14 @@ int main(int argc, char *argv[])
 					&client_connect_read_32k_success_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - RX Timestamping",
+					&client_connect_rx_timestamping_test,
+					setup_powered_client, test_connect);
+
+	test_l2cap_bredr("L2CAP BR/EDR Client - RX Timestamping 32k",
+				&client_connect_rx_timestamping_32k_test,
+				setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client - Write Success",
 					&client_connect_write_success_test,
 					setup_powered_client, test_connect);
@@ -2619,6 +2671,12 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client - Read 32k Success",
 				&le_client_connect_read_32k_success_test,
 				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE Client - RX Timestamping",
+				&le_client_connect_rx_timestamping_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE Client - RX Timestamping 32k",
+				&le_client_connect_rx_timestamping_32k_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE Client - Write Success",
 				&le_client_connect_write_success_test,
 				setup_powered_client, test_connect);
diff --git a/tools/tester.h b/tools/tester.h
index 4e7d7226b..bdfff356f 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -198,3 +198,83 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 
 	return data->count - data->pos;
 }
+
+static inline int rx_timestamp_check(struct msghdr *msg)
+{
+	struct cmsghdr *cmsg;
+	struct timespec now;
+	int64_t t = 0;
+
+	for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
+		struct scm_timestamping *tss;
+
+		if (cmsg->cmsg_level != SOL_SOCKET)
+			continue;
+		if (cmsg->cmsg_type != SCM_TIMESTAMPING)
+			continue;
+
+		tss = (struct scm_timestamping *)CMSG_DATA(cmsg);
+		t = TS_NSEC(&tss->ts[0]);
+		break;
+	}
+	if (!cmsg) {
+		tester_warn("RX timestamp missing");
+		return -EINVAL;
+	}
+
+	clock_gettime(CLOCK_REALTIME, &now);
+
+	if (TS_NSEC(&now) < t || TS_NSEC(&now) > t + SEC_NSEC(10)) {
+		tester_warn("RX timestamp bad time");
+		return -EINVAL;
+	}
+
+	tester_print("Got valid RX timestamp");
+	return 0;
+}
+
+static inline ssize_t recv_tstamp(int sk, void *buf, size_t size, bool tstamp)
+{
+	union {
+		char buf[2 * CMSG_SPACE(sizeof(struct scm_timestamping))];
+		struct cmsghdr align;
+	} control;
+	struct iovec data = {
+		.iov_base = buf,
+		.iov_len = size
+	};
+	struct msghdr msg = {
+		.msg_iov = &data,
+		.msg_iovlen = 1,
+		.msg_control = control.buf,
+		.msg_controllen = sizeof(control.buf),
+	};
+	ssize_t ret;
+
+	ret = recvmsg(sk, &msg, 0);
+	if (ret < 0 || !tstamp)
+		return ret;
+
+	if (rx_timestamp_check(&msg)) {
+		errno = EIO;
+		return -1;
+	}
+
+	return ret;
+}
+
+static inline int rx_timestamping_init(int fd, int flags)
+{
+	socklen_t len = sizeof(flags);
+
+	if (!(flags & SOF_TIMESTAMPING_RX_SOFTWARE))
+		return 0;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, len) < 0) {
+		tester_warn("failed to set SO_TIMESTAMPING");
+		tester_test_failed();
+		return -EIO;
+	}
+
+	return 0;
+}
-- 
2.49.0

