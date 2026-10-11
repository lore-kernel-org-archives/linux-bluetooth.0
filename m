Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FAF3D6CAA
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751242; cv=pass; b=Jx5RQuGSafcvwRnIwDaWwKedQ6afEUSAyAIkNDtKfmd0GvJbjGIxpD+OIhzct9sH6+ymOjFVqLryybA30Es3KNGUhVVIm2AsfY3MKw8Og2MBeosopwC6f3ZpOva5jB3GiCzzf+LOUD+70dKjQlZsmt7xsnwYmObTshdzCMYF5H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751242; c=relaxed/simple;
	bh=PWvn9QxdndpDSFKGjhMRE4TE13LEvEy3xDLKqIRaEcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kxv8MfFTxjnmy5HAX8khbIOuKFCwoy+WecWY9v2VVNmYXZpXbK8FBcJnfNxcgAzuQehXEEgHJdJt8lrdCTIGgZ+Q4CfE97AuQG07VMdeagd3Udrn72VvugFaqqClKefG4z8M6sbi5frGmEufuJ+ZyynkNFYiWlpcXzkuXIhbHxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=yprMjOFz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="yprMjOFz"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2stW30N1zyb7;
	Sun, 11 Oct 2026 23:40:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHBGMd8eLxub8W8qyJFR+meOZwsLAB8QnYiNedFv4IQ=;
	b=yprMjOFziyoacmqvQ71CKXVR0/YWBXGjWxrVoLdGVvvpDQyR48l2QIVI+lM5dfVkxqNtiZ
	I/uV3TVcciuGmk7z7ajeOU32wXxH1qpQJuNE1lhn/DN4DgQMBMZpT8KqlW7qNczWh1PUSI
	Ix/z612Vd122H/M9XhRVqgw3thpAyUM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751235;
	b=K/OuOP0EcV/3aTShUrUPrna6rhiKu8X/FvnZRnBoHxTFTDeltQfQLlHjjxGlYRUmInni93
	vFAyuLb+BWDUnuFRl8RDfOn7tYygT86gKDBOdd4mYySxGXLe/2u5yjLKMEUsTi2ZdGhuKQ
	agPic4JkJYWh8BYa/2uLSipR3U63Els=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHBGMd8eLxub8W8qyJFR+meOZwsLAB8QnYiNedFv4IQ=;
	b=I2adTsTWs+18KUquXEcfD3BnfPGtWBQsTCqhgmoy/H3igiROnikybANoiUDwvfi5GedDQ0
	yMTIz5E9AGxRA+OqO/bs70aEHp/QEF7g8feVmWP3qehu6sdn3c9+Z0Ee4ljRs5faGFkcax
	Z4ptNE9FiCyi1MQTpUVhll2Lvw1RYBA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/5] tools: iso-tester: test PAST listener readiness
Date: Sun, 11 Oct 2026 23:40:17 +0300
Message-ID: <b54aaffb448b62823fd471fa0858c128a64fd812.1791750393.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791750393.git.pav@iki.fi>
References: <cover.1791750393.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test POLLOUT notification after LE Set PAST Parameters completes, with
and without deferred setup. Query BT_ISO_PAST_POLLOUT and skip the tests
when listener readiness notifications are unavailable.

Add tests:

ISO Broadcaster PAST Listen Ready Receive - Success
ISO Broadcaster PAST Listen Ready Defer - Success

Assisted-by: opencode:gpt-6.1-sol
---
 tools/iso-tester.c | 198 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 6fa1bd007..ec6422c91 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -478,6 +478,7 @@ struct test_data {
 	bool suspending;
 	struct tx_tstamp_data tx_ts;
 	int seqnum;
+	bool past_params_complete;
 };
 
 struct iso_client_data {
@@ -1494,6 +1495,17 @@ static const struct iso_client_data past_16_2_1_recv = {
 	.big = true,
 };
 
+static const struct iso_client_data past_16_2_1_recv_defer = {
+	.qos = QOS_IN_16_2_1,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.past = true,
+	.server = true,
+	.defer = true,
+	.pa_bind = true,
+	.big = true,
+};
+
 static const struct iso_client_data bcast_16_2_1_recv2 = {
 	.qos = QOS_IN_16_2_1,
 	.expect_err = 0,
@@ -3909,6 +3921,184 @@ static void test_past_recv(const void *test_data)
 	setup_listen(data, 0, iso_accept_cb);
 }
 
+static bool past_listener_check(int sk, bool ready)
+{
+	struct pollfd pfd = {
+		.fd = sk,
+		.events = POLLIN | POLLOUT,
+	};
+	int err, new_sk;
+	socklen_t len;
+
+	if (poll(&pfd, 1, 0) < 0) {
+		tester_warn("poll: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	if (pfd.revents != (ready ? POLLOUT : 0)) {
+		tester_warn("Unexpected listener events: 0x%x", pfd.revents);
+		return false;
+	}
+
+	len = sizeof(err);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &err, &len) < 0 || err) {
+		tester_warn("Unexpected listener socket error");
+		return false;
+	}
+
+	new_sk = accept(sk, NULL, NULL);
+	if (new_sk >= 0) {
+		tester_warn("Accepted connection before PAST");
+		close(new_sk);
+		return false;
+	}
+
+	if (errno != EAGAIN && errno != EWOULDBLOCK) {
+		tester_warn("accept: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	return true;
+}
+
+static gboolean past_params_resume(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	GIOChannel *io = user_data;
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+
+	data->io_id[3] = 0;
+
+	if (!past_listener_check(g_io_channel_unix_get_fd(io), false)) {
+		tester_test_failed();
+		return FALSE;
+	}
+
+	if (!vhci_pause_input(vhci, false)) {
+		tester_warn("Can't resume controller input");
+		tester_test_failed();
+	}
+
+	return FALSE;
+}
+
+static bool past_params_complete(const void *param, uint16_t len,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct bt_hci_rsp_le_past_params *rp = param;
+
+	if (len != sizeof(*rp) || rp->status) {
+		tester_warn("PAST Parameters failed");
+		tester_test_failed();
+		return false;
+	}
+
+	data->past_params_complete = true;
+	return true;
+}
+
+static gboolean iso_past_ready(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *host;
+	int sk = g_io_channel_unix_get_fd(io);
+
+	data->io_id[0] = 0;
+
+	if (cond != G_IO_OUT || !data->past_params_complete ||
+					!past_listener_check(sk, true)) {
+		tester_warn("Unexpected PAST listener readiness");
+		tester_test_failed();
+		return FALSE;
+	}
+
+	tester_print("PAST listener ready");
+
+	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_accept_cb, NULL);
+	host = hciemu_client_get_host(data->hciemu);
+	bthost_past_set_info(host, data->acl_handle);
+
+	return FALSE;
+}
+
+static void test_past_ready(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct iso_client_data *isodata = data->test_data;
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+	GIOChannel *io;
+	socklen_t len;
+	int sk, past_pollout, err;
+
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
+	if (sk < 0) {
+		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+									errno);
+		tester_test_abort();
+		return;
+	}
+
+	len = sizeof(past_pollout);
+	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_PAST_POLLOUT,
+						&past_pollout, &len);
+	if (err < 0) {
+		err = -errno;
+		tester_warn("Can't get PAST POLLOUT support: %s (%d)",
+						strerror(-err), -err);
+
+		if (err == -ENOPROTOOPT)
+			tester_test_abort();
+		else
+			tester_test_failed();
+
+		close(sk);
+		return;
+	}
+
+	close(sk);
+
+	if (!past_pollout) {
+		tester_print("PAST POLLOUT is not supported");
+		tester_test_abort();
+		return;
+	}
+
+	if (!vhci_pause_input(vhci, true)) {
+		tester_warn("Can't pause controller input");
+		tester_test_failed();
+		return;
+	}
+
+	sk = listen_iso_sock(data, 0);
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
+	if (hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
+		BT_HCI_CMD_LE_PAST_PARAMS, past_params_complete, NULL) < 0) {
+		g_io_channel_unref(io);
+		tester_test_failed();
+		return;
+	}
+
+	data->step = isodata->defer ? 2 : 1;
+	data->io_id[0] = g_io_add_watch(io, G_IO_OUT | G_IO_ERR | G_IO_HUP,
+							iso_past_ready, NULL);
+	data->io_id[3] = g_timeout_add_full(G_PRIORITY_DEFAULT, 50,
+			past_params_resume, g_io_channel_ref(io), io_free);
+	g_io_channel_unref(io);
+}
+
 static void test_connect2_suspend(const void *test_data)
 {
 	test_connect2(test_data);
@@ -4332,6 +4522,14 @@ int main(int argc, char *argv[])
 							&past_16_2_1_recv,
 							setup_powered,
 							test_past_recv);
+	test_iso("ISO Broadcaster PAST Listen Ready Receive - Success",
+							&past_16_2_1_recv,
+							setup_powered,
+							test_past_ready);
+	test_iso("ISO Broadcaster PAST Listen Ready Defer - Success",
+							&past_16_2_1_recv_defer,
+							setup_powered,
+							test_past_ready);
 	test_iso("ISO Broadcaster Receiver SID auto - Success",
 							&bcast_16_2_1_recv_sid,
 							setup_powered,
-- 
2.56.0

