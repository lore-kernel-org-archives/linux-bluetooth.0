Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CD280309
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434470; cv=pass; b=bDrCwuChxEOLUlG0X0R1l+jM7JvBqZ8yO2Hum25XZgTguSenhUSfVW15P657d2+bdYf1YmxEbXbc0LeLFnlTCnDQmVGKrp9KaN3l1yIn6yb2FcXyzCKzjFIIU8RXJzhx1YMFs6owMG2JaO7AQW8C1nfQD6yk4IazSZgwsJg61Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434470; c=relaxed/simple;
	bh=YtFWEjeL66GeM+lDiEl8C3Z/gpDrDlGoXlRY14yTN+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyOwK0vb2acMyIoQc4KR00hfBsdpRFDLyGR5FxB4GHdEPsqYw/F7k1nvQ7ZgfCkohT5FAbrh7gnkUtU02r9BPAWGmNZ9BZ7sNBSHnh5oJhVv/urFLj5qBhMI5oREMq6ZVu+o270L5RZaCueWBg4VXZIN74qy2TRv8dMHihfC+HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=lt29YQF3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="lt29YQF3"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJbX15c3xz10HW;
	Sat, 29 Nov 2025 18:41:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764434465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWXO0A6f1yfLhzYC38UnqK41SbonAR/BVdfoz0zZJXM=;
	b=lt29YQF34CZxQa/7l1IA0LLpGAXoH5euQEJlC0i/nDp+ANuljLfXzsYiEF03obd0G9aYeo
	n9+ORe6yaresT2W4irVH+yaXGdEFHcJvJo9C+LBJbHq3IhpSNzOhs0NucgPnoajj7700es
	do7v/IN5++lILELz3YWSd/zOxMdEFQc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764434465;
	b=TgdK63PcddHiu/91o2JAvfcCbpsyPRWf9G6qVfKsPf/rShVTXxgBkDpznHNfIUxu9gqyBd
	wW+axWaiD9whoGtb0snbWCpxLvfgKaWbnYTZB53J75hLZ8OLkos8/lKa5yYFNyJ8MxDpLj
	8PfjQijHO84l6mJ7eju+CMKLvp2FsGQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764434465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWXO0A6f1yfLhzYC38UnqK41SbonAR/BVdfoz0zZJXM=;
	b=YavDKuj2IKUXt0cT1wIQbt3Mi8704NCHp5emBQLoHhd6ThbPqMZlKeufimzLv7a4pUyQxF
	gri91qhU3gMdCd9rrituahSJNbo9uro5bJetCMHXHvbf/FuNpkm0T92XjVKEPe5CGzXdjU
	iHgmxITuH40ImsDdCVHy/mOdluf019k=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/4] sco-tester: add socket listen tests
Date: Sat, 29 Nov 2025 18:41:02 +0200
Message-ID: <11224a41e25e051345a67729f94f03552f9df751.1764434454.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
References: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic SCO server tests:

SCO CVSD Listen - Success
SCO CVSD Listen Defer - Success
SCO CVSD Listen Recv - Success
SCO CVSD Listen Send - Success
---

Notes:
    These catch
    
    WARNING: possible circular locking dependency detected
    BUG: sleeping function called from invalid context at net/core/sock.c:3756
    
    in sco_conn_ready()

 tools/sco-tester.c | 269 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 261 insertions(+), 8 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 660f36e07..3d6b59092 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
+#include <poll.h>
 #include <stdbool.h>
 
 #include <glib.h>
@@ -46,6 +47,7 @@ struct test_data {
 	bool enable_codecs;
 	bool disable_sco_flowctl;
 	int step;
+	uint16_t acl_handle;
 	uint16_t handle;
 	struct tx_tstamp_data tx_ts;
 };
@@ -70,6 +72,12 @@ struct sco_client_data {
 
 	/* Number of additional packets to send. */
 	unsigned int repeat_send;
+
+	/* Listen on SCO socket */
+	bool server;
+
+	/* Defer setup when accepting SCO connections */
+	bool defer;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -360,15 +368,45 @@ static const struct sco_client_data connect_send_no_flowctl_tx_timestamping = {
 	.repeat_send = 2,
 };
 
+static const struct sco_client_data listen_success = {
+	.server = true,
+	.expect_err = 0,
+};
+
+static const struct sco_client_data listen_defer_success = {
+	.server = true,
+	.defer = true,
+	.expect_err = 0,
+};
+
+static const struct sco_client_data listen_recv_success = {
+	.server = true,
+	.expect_err = 0,
+	.data_len = sizeof(data),
+	.recv_data = data,
+};
+
+static const struct sco_client_data listen_send_success = {
+	.server = true,
+	.expect_err = 0,
+	.data_len = sizeof(data),
+	.send_data = data,
+};
+
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
 {
+	struct test_data *data = user_data;
+
 	if (opcode != BT_HCI_CMD_WRITE_SCAN_ENABLE)
 		return;
 
 	tester_print("Client set connectable status 0x%02x", status);
 
+	if (--data->step)
+		return;
+
 	if (status)
 		tester_setup_failed();
 	else
@@ -401,10 +439,26 @@ static void bthost_sco_disconnected(void *user_data)
 	data->handle = 0x0000;
 }
 
+static void acl_new_conn(uint16_t handle, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_print("New ACL connection with handle 0x%04x", handle);
+
+	data->acl_handle = handle;
+
+	if (--data->step)
+		return;
+
+	tester_setup_complete();
+}
+
 static void sco_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = user_data;
+	const struct sco_client_data *scodata = data->test_data;
 	struct bthost *host;
+	struct iovec iov = { (void *)scodata->recv_data, scodata->data_len };
 
 	tester_print("New client connection with handle 0x%04x", handle);
 
@@ -413,6 +467,9 @@ static void sco_new_conn(uint16_t handle, void *user_data)
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_add_sco_hook(host, data->handle, bthost_recv_data, data,
 				bthost_sco_disconnected);
+
+	if (scodata->recv_data)
+		bthost_send_sco(host, data->handle, 0x00, &iov, 1);
 }
 
 static void setup_powered_callback(uint8_t status, uint16_t length,
@@ -421,6 +478,7 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 	struct test_data *data = tester_get_data();
 	const struct sco_client_data *scodata = data->test_data;
 	struct bthost *bthost;
+	const uint8_t *bdaddr;
 
 	if (status != MGMT_STATUS_SUCCESS) {
 		tester_setup_failed();
@@ -432,9 +490,20 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
 	bthost_write_scan_enable(bthost, 0x03);
+	data->step++;
 
-	if (scodata && (scodata->send_data || scodata->recv_data))
+	if (!scodata)
+		return;
+
+	if (scodata->send_data || scodata->recv_data || scodata->server)
 		bthost_set_sco_cb(bthost, sco_new_conn, data);
+
+	if (scodata->server) {
+		bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+		bthost_set_connect_cb(bthost, acl_new_conn, data);
+		bthost_hci_connect(bthost, bdaddr, BDADDR_BREDR);
+		data->step++;
+	}
 }
 
 static void setup_powered(const void *test_data)
@@ -871,8 +940,6 @@ static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
 static void sco_recv_data(struct test_data *data, GIOChannel *io)
 {
 	const struct sco_client_data *scodata = data->test_data;
-	struct iovec iov = { (void *)scodata->recv_data, scodata->data_len };
-	struct bthost *bthost;
 
 	data->step = 0;
 
@@ -880,14 +947,12 @@ static void sco_recv_data(struct test_data *data, GIOChannel *io)
 						scodata->so_timestamping))
 		return;
 
-	bthost = hciemu_client_get_host(data->hciemu);
 	g_io_add_watch(io, G_IO_IN, sock_received_data, NULL);
 
-	bthost_send_sco(bthost, data->handle, 0x00, &iov, 1);
 	++data->step;
 }
 
-static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
+static gboolean sco_connect(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -895,8 +960,6 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
-	data->io_id = 0;
-
 	sk = g_io_channel_unix_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
@@ -951,6 +1014,16 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->io_id = 0;
+	sco_connect(io, cond, user_data);
+	return FALSE;
+}
+
 static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1239,6 +1312,174 @@ static void test_sco_ethtool_get_ts_info(const void *test_data)
 				!data->disable_sco_flowctl);
 }
 
+static int listen_sco_sock(struct test_data *data)
+{
+	const struct sco_client_data *scodata = data->test_data;
+	struct sockaddr_sco addr;
+	const uint8_t *src;
+	int sk, err;
+
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK, BTPROTO_SCO);
+	if (sk < 0) {
+		err = -errno;
+		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+									errno);
+		return err;
+	}
+
+	src = hciemu_get_central_bdaddr(data->hciemu);
+	if (!src) {
+		tester_warn("No source bdaddr");
+		err = -ENODEV;
+		goto fail;
+	}
+
+	/* Bind to local address */
+	memset(&addr, 0, sizeof(addr));
+	addr.sco_family = AF_BLUETOOTH;
+	bacpy(&addr.sco_bdaddr, (void *) src);
+
+	err = bind(sk, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0) {
+		err = -errno;
+		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
+									errno);
+		goto fail;
+	}
+
+	if (scodata->defer) {
+		int opt = 1;
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &opt,
+							sizeof(opt)) < 0) {
+			tester_print("Can't enable deferred setup: %s (%d)",
+						strerror(errno), errno);
+			goto fail;
+		}
+	}
+
+	if (listen(sk, 10)) {
+		err = -errno;
+		tester_warn("Can't listen socket: %s (%d)", strerror(errno),
+									errno);
+		goto fail;
+	}
+
+	return sk;
+
+fail:
+	close(sk);
+	return err;
+}
+
+static bool sco_defer_accept(struct test_data *data, GIOChannel *io)
+{
+	int sk;
+	char c;
+	struct pollfd pfd;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd = sk;
+	pfd.events = POLLOUT;
+
+	if (poll(&pfd, 1, 0) < 0) {
+		tester_warn("poll: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	if (!(pfd.revents & POLLOUT)) {
+		if (read(sk, &c, 1) < 0) {
+			tester_warn("read: %s (%d)", strerror(errno), errno);
+			return false;
+		}
+	}
+
+	tester_print("Accept deferred setup");
+
+	return true;
+}
+
+static gboolean sco_accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct sco_client_data *scodata = data->test_data;
+	int sk, new_sk;
+	gboolean ret;
+	GIOChannel *new_io;
+
+	tester_debug("New connection");
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	new_sk = accept(sk, NULL, NULL);
+	if (new_sk < 0) {
+		tester_test_failed();
+		return false;
+	}
+
+	new_io = g_io_channel_unix_new(new_sk);
+	g_io_channel_set_close_on_unref(new_io, TRUE);
+
+	if (scodata->defer) {
+		if (scodata->expect_err < 0) {
+			g_io_channel_unref(new_io);
+			tester_test_passed();
+			return false;
+		}
+
+		if (!sco_defer_accept(data, new_io)) {
+			tester_warn("Unable to accept deferred setup");
+			tester_test_failed();
+			return false;
+		}
+	}
+
+	ret = sco_connect(new_io, cond, user_data);
+
+	g_io_channel_unref(new_io);
+	return ret;
+}
+
+static void setup_listen(struct test_data *data, GIOFunc func)
+{
+	struct hciemu_client *client;
+	struct bthost *host;
+	int sk;
+	GIOChannel *io;
+
+	sk = listen_sco_sock(data);
+	if (sk < 0) {
+		if (sk == -EPROTONOSUPPORT)
+			tester_test_abort();
+		else
+			tester_test_failed();
+		return;
+	}
+
+	io = g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	data->io_id = g_io_add_watch(io, G_IO_IN, func, NULL);
+	g_io_channel_unref(io);
+
+	tester_print("Listen in progress");
+
+	client = hciemu_get_client(data->hciemu, 0);
+	host = hciemu_client_host(client);
+
+	bthost_setup_sco(host, data->acl_handle, BT_VOICE_CVSD_16BIT);
+}
+
+static void test_listen(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	setup_listen(data, sco_accept_cb);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -1325,5 +1566,17 @@ int main(int argc, char *argv[])
 	test_sco_no_flowctl("SCO Ethtool Get Ts Info No Flowctl - Success",
 			NULL, setup_powered, test_sco_ethtool_get_ts_info);
 
+	test_sco("SCO CVSD Listen - Success", &listen_success,
+					setup_powered, test_listen);
+
+	test_sco("SCO CVSD Listen Defer - Success", &listen_defer_success,
+					setup_powered, test_listen);
+
+	test_sco("SCO CVSD Listen Recv - Success", &listen_recv_success,
+					setup_powered, test_listen);
+
+	test_sco("SCO CVSD Listen Send - Success", &listen_send_success,
+					setup_powered, test_listen);
+
 	return tester_run();
 }
-- 
2.51.1

