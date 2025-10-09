Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D92848AF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045391; cv=none; b=EwFPQMDHXJiHIUG7qC4Yd5+c0iwF0UOdA2qXdE46q3hrKuKgo2TzrVIJc1DD/oT2vGYXE91oa3dkVWdprEIVKmBTFzWsZwcjf7fOZZwA+46EBIZKD0kDA0IXFPoTqP3onmItGjAz1kKTXHuaRXXfVAJ22HaC1xg5pNAthoZa1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045391; c=relaxed/simple;
	bh=7nHhBHZjobZO9tc5CXwqUs0K7TUrrVa0WVju8hL7Sqc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgrK5eKu/AIg58VPMswlHRWVlx558Q2rwxqV+ws2tmggA1px3tOXQ9B0zKLtSRukcQB13oaYJRuFmngxpzYZBpI/09s/5Fz4bHy4z4hA2E/2uApwLnw8XcMxV6gVSRUy27J2ZaoBMT8NB+Wn3Vvkyi/dsXSlQnw0WGC38VhpNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMpGD51G; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMpGD51G"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54aa30f4093so458607e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045387; x=1760650187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ov96oWwEYQbN9ntKJyLu8EaESUNNv2Y9yVqxW9k3YGI=;
        b=NMpGD51GuAfCThqCfXurxCQYpB+Stg3WhPXEZhX7f7OheRm0SSNBFjM5NTIztOsS1s
         1nrNQwP+1Pudlfb3As1eDGwfZ8Ol94pF6uCcWU8W48gezRI5HA7iEQehA6l1Ga99OqNI
         W71zYmKRshocZQIxnloKUk/w0ccsF0R2p9PewMsCq++JRlfqKKCZLXzCtWaag7UJ/5jX
         Zo++rjhFVWcVtwYaTzaGNokv4hZYay7qsXtIHGxeBDw1cIU0SrtEZN0dXkw6K+47ypw/
         VrHa4GGf2v2iK8+mdKMvsNf8XQ4JpkTwSVTbCL8G+Ib5pCwtgXgd6r97+/R7wfdvFDqy
         yOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045387; x=1760650187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov96oWwEYQbN9ntKJyLu8EaESUNNv2Y9yVqxW9k3YGI=;
        b=d8CDa55DEYGD9r4gxFYiFN0tpqzq8eUarCrRDmLyN68GMk4MwChI8mSdzdm0DF22ng
         NyPZvI4wmgO2gPOBYtA2P89qtqImr53uyk3E8bHqIYjaugdl4cPpgZDPCyN9u42qnXCi
         Q+txZXZKcSJS4gKNenKrlOIwoXHsCuDUfQ9cWOWXUvVcFAkyJeNuglhrUbTSqGh4P6XW
         H9D5E8ZWUdtaUpy3sXrca9HwLSJKtznH0ZJ7+zfjq6wd4KcZfPZcYsBadtrzcSLpaGsU
         VAlDlsKAlaKZGYRr6Ap7ynzad5+jOPEE2EhmZSFU4jO6hD9J4xtbF7N3h9UEATMPL0TE
         vGDg==
X-Gm-Message-State: AOJu0YznE09X7DzItb7Rv/+Nd5buuqxxK10QZ2tv0RmZ3UommODuNPbU
	kdSI+uzMEZ4F2oL2WvFfnyF1q+uNjeu4irjiDzfJftZj9mGJ23ZRbykI/OKUlAsa
X-Gm-Gg: ASbGncuJsTm9WrG0X6IkEmkAwd8Z61VDdjMgxuC29+7qDd4PB5aUq03SsAlJ1Vn1sj1
	u39C8xk3pGAsJWFqHEPRg8s5nLSTgrGOQgD3kOaZwMRH0zsQ/wUCmXHpgyBj2rPGjydpJk9nHAM
	jFuQ3GL6WpHrjnalZw7lw+JFC7O2kwA8hg9u3DQL06jTrF5D+wwjsDyCmUxUnf8po20dwWukEyA
	nY9JqWs2XK3bnoZUV/sR330DpXrLvkG+yd2TIDKHcnInEoydUNRNUd6j4Bug/JRpIXoNgEpXCc5
	eseX+Hx86ZLeeAapuLoGDF6a8MznW/KalxYpnw5Dn7enrs86f2qCeuBjgzBLi6hrGD8X7qJalvn
	RrJsrcxtXtuH6hIYAJ3VLkAoHgmPUM3TT0adpeuUwrOfE9ZRfKc9PP0IwUVYcSpphh3FNUbFRUc
	GtbSW2QUNfQvOnA0jT0Vbns9mj
X-Google-Smtp-Source: AGHT+IFT2miNt0+E1LDXA3S1q1qKmqf1vynh7VnB8rLtl8i8uqwJucDFsuQMp/yVYIgPVOJ6DRNTYg==
X-Received: by 2002:a05:6122:251d:b0:54a:92f1:f9e4 with SMTP id 71dfb90a1353d-554b8b9132amr3703499e0c.9.1760045387422;
        Thu, 09 Oct 2025 14:29:47 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.29.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:29:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/13] iso-tester: Add tests for PAST procedures
Date: Thu,  9 Oct 2025 17:29:21 -0400
Message-ID: <20251009212931.445719-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the following tests that test PAST procedures both as
a sender, either for colocated broadcast source or a third peer, and as
receiver:

ISO Broadcaster PAST Info - Success
ISO Broadcaster PAST Info RPA - Success
ISO Broadcaster PAST Sender - Success
ISO Broadcaster PAST Receiver - Success
---
 tools/iso-tester.c | 292 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 279 insertions(+), 13 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 0eeab4fd7108..4bf1a287bc68 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -488,6 +488,8 @@ struct iso_client_data {
 	const struct iovec *recv;
 	bool server;
 	bool bcast;
+	bool past;
+	bool rpa;
 	bool defer;
 	bool disconnect;
 	bool ts;
@@ -1381,6 +1383,28 @@ static const struct iso_client_data bcast_16_2_1_send = {
 	.base_len = sizeof(base_lc3_16_2_1),
 };
 
+static const struct iso_client_data past_16_2_1_send = {
+	.qos = QOS_OUT_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.past = true,
+	.rpa = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+};
+
+static const struct iso_client_data past_16_2_1 = {
+	.qos = QOS_OUT_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.past = true,
+	.big = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+};
+
 static const struct iso_client_data bcast_enc_16_2_1_send = {
 	.qos = QOS_OUT_ENC_16_2_1,
 	.expect_err = 0,
@@ -1446,6 +1470,16 @@ static const struct iso_client_data bcast_16_2_1_recv = {
 	.big = true,
 };
 
+static const struct iso_client_data past_16_2_1_recv = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.past = true,
+	.server = true,
+	.big = true,
+};
+
 static const struct iso_client_data bcast_16_2_1_recv2 = {
 	.qos = QOS_IN_16_2_1,
 	.expect_err = 0,
@@ -1594,6 +1628,7 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 {
 	struct test_data *data = user_data;
 	static uint8_t client_num;
+	const struct iso_client_data *isodata = data->test_data;
 
 	if (opcode != BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE)
 		return;
@@ -1606,7 +1641,8 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 	if (status)
 		tester_setup_failed();
 	else if (data->client_num == client_num) {
-		tester_setup_complete();
+		if (!isodata || !isodata->past)
+			tester_setup_complete();
 		client_num = 0;
 	}
 }
@@ -1641,6 +1677,8 @@ static void iso_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = user_data;
 	struct bthost *host;
+	const struct iso_client_data *isodata = data->test_data;
+	static uint8_t client_num;
 
 	tester_print("New client connection with handle 0x%04x", handle);
 
@@ -1649,6 +1687,14 @@ static void iso_new_conn(uint16_t handle, void *user_data)
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_add_iso_hook(host, data->handle, bthost_recv_data, data,
 				bthost_iso_disconnected);
+
+	if (!isodata->past || data->client_num == 1)
+		return;
+
+	client_num++;
+
+	if (client_num == data->client_num)
+		tester_test_passed();
 }
 
 static uint8_t iso_accept_conn(uint16_t handle, void *user_data)
@@ -1664,10 +1710,73 @@ static uint8_t iso_accept_conn(uint16_t handle, void *user_data)
 static void acl_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = user_data;
+	const struct iso_client_data *isodata = data->test_data;
 
 	tester_print("New ACL connection with handle 0x%04x", handle);
 
 	data->acl_handle = handle;
+
+	if (!isodata->past)
+		return;
+
+	tester_setup_complete();
+
+	if (!isodata->server) {
+		struct bthost *host;
+
+		host = hciemu_client_get_host(data->hciemu);
+		bthost_set_past_mode(host, data->acl_handle, 0x03);
+	}
+}
+
+static void setup_connect_recv(struct test_data *data, struct bthost *host)
+{
+	const uint8_t *bdaddr;
+
+	bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	bthost_set_connect_cb(host, acl_new_conn, data);
+	bthost_hci_connect(host, bdaddr, BDADDR_LE_PUBLIC);
+}
+
+static void setup_past_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *host = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Set device flags status 0x%02x", status);
+
+	setup_connect_recv(data, host);
+}
+
+static void setup_past_recv(struct test_data *data, struct bthost *host)
+{
+	struct mgmt_cp_add_device add;
+	struct mgmt_cp_set_device_flags set;
+
+	memset(&add, 0, sizeof(add));
+	bacpy(&add.addr.bdaddr,
+		(bdaddr_t *)hciemu_get_client_bdaddr(data->hciemu));
+	add.addr.type = BDADDR_LE_PUBLIC;
+	add.action = 0x01; /* Allow incoming connection */
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+				sizeof(add), &add, NULL, NULL, NULL);
+
+	memset(&set, 0, sizeof(set));
+	bacpy(&set.addr.bdaddr,
+		(bdaddr_t *)hciemu_get_client_bdaddr(data->hciemu));
+	set.addr.type = BDADDR_LE_PUBLIC;
+	set.current_flags = BIT(3);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
+				sizeof(set), &set, setup_past_complete, host,
+				NULL);
 }
 
 static void setup_powered_callback(uint8_t status, uint16_t length,
@@ -1716,18 +1825,17 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 				bthost_set_base(host, isodata->base,
 							isodata->base_len);
 
-			if (isodata->big)
+			if (isodata->big && (!isodata->past ||
+						i + 1 == data->client_num))
 				bthost_create_big(host, 1,
 						isodata->qos.bcast.encryption,
 						isodata->qos.bcast.bcode);
 
-		} else if (!isodata->send && isodata->recv) {
-			const uint8_t *bdaddr;
+			if (isodata->past)
+				setup_past_recv(data, host);
 
-			bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-			bthost_set_connect_cb(host, acl_new_conn, data);
-			bthost_hci_connect(host, bdaddr, BDADDR_LE_PUBLIC);
-		}
+		} else if (!isodata->send && isodata->recv)
+			setup_connect_recv(data, host);
 	}
 }
 
@@ -1739,7 +1847,7 @@ static void setup_powered(const void *test_data)
 
 	tester_print("Powering on controller");
 
-	if (!isodata || !isodata->bcast)
+	if (!isodata || !isodata->bcast || isodata->past)
 		mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 					sizeof(param), param,
 					NULL, NULL, NULL);
@@ -1750,7 +1858,16 @@ static void setup_powered(const void *test_data)
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
 
-	if (isodata && isodata->server && !isodata->bcast)
+	if (isodata && isodata->rpa) {
+		const uint8_t params[] = { 0x01,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,
+			  sizeof(params), params, NULL, NULL, NULL);
+	}
+
+	if (isodata && ((isodata->server && !isodata->bcast) || isodata->past))
 		mgmt_send(data->mgmt, MGMT_OP_SET_ADVERTISING,
 				data->mgmt_index, sizeof(param), param, NULL,
 				NULL, NULL);
@@ -1905,6 +2022,7 @@ static int create_iso_sock(struct test_data *data)
 		addr->iso_bc->bc_sid = isodata->sid;
 		err = bind(sk, (struct sockaddr *) addr, sizeof(*addr) +
 						sizeof(*addr->iso_bc));
+		free(addr);
 	} else {
 		addr = malloc(sizeof(*addr));
 		memset(addr, 0, sizeof(*addr));
@@ -1912,6 +2030,7 @@ static int create_iso_sock(struct test_data *data)
 		bacpy(&addr->iso_bdaddr, (void *) master_bdaddr);
 		addr->iso_bdaddr_type = BDADDR_LE_PUBLIC;
 		err = bind(sk, (struct sockaddr *) addr, sizeof(*addr));
+		free(addr);
 	}
 
 	if (err < 0) {
@@ -2520,6 +2639,9 @@ static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
 	const struct iso_client_data *isodata = data->test_data;
 	unsigned int count;
 
+	if (isodata->past && !data->handle)
+		return TRUE;
+
 	data->io_id[0] = 0;
 
 	tester_print("POLLOUT event received");
@@ -2533,6 +2655,8 @@ static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
 		iso_send_data(data, io);
 
 	if (isodata->bcast) {
+		if (isodata->past)
+			return FALSE;
 		tester_test_passed();
 		return FALSE;
 	}
@@ -2588,6 +2712,84 @@ static void trigger_force_suspend(void *user_data)
 					hook_set_event_mask, data);
 }
 
+static int iso_rebind_bcast_dst(struct test_data *data, int sk)
+{
+	struct hciemu_client *client;
+	const uint8_t *dst;
+	struct sockaddr_iso *addr = NULL;
+	int err;
+
+	client = hciemu_get_client(data->hciemu, 0);
+
+	/* Bind to local address */
+	addr = malloc(sizeof(*addr) + sizeof(*addr->iso_bc));
+	memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
+	addr->iso_family = AF_BLUETOOTH;
+
+	/* Bind to destination address in case of broadcast */
+	dst = hciemu_client_bdaddr(client);
+	if (!dst) {
+		tester_warn("No destination bdaddr");
+		free(addr);
+		return -ENODEV;
+	}
+
+	bacpy(&addr->iso_bc->bc_bdaddr, (void *) dst);
+	addr->iso_bc->bc_bdaddr_type = BDADDR_LE_PUBLIC;
+
+	err = bind(sk, (struct sockaddr *) addr, sizeof(*addr) +
+						sizeof(*addr->iso_bc));
+	if (err)
+		tester_warn("bind: %s (%d)", strerror(errno), errno);
+	else
+		tester_print("PAST in progress...");
+
+	free(addr);
+
+	return err;
+}
+
+static bool check_rpa(struct test_data *data, int sk)
+{
+	const struct iso_client_data *isodata = data->test_data;
+	struct sockaddr_iso addr;
+	socklen_t olen;
+	const uint8_t *src;
+
+	if (!isodata->rpa)
+		return true;
+
+	src = hciemu_get_central_bdaddr(data->hciemu);
+	if (!src) {
+		tester_warn("No source bdaddr");
+		return false;
+	}
+
+	olen = sizeof(addr);
+
+	memset(&addr, 0, olen);
+	if (getsockname(sk, (void *)&addr, &olen) < 0) {
+		tester_warn("getsockname: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	/* Compare socket source address (RPA) with central address, if they
+	 * match it means the RPA has not been set.
+	 */
+	if (!bacmp(&addr.iso_bdaddr, (bdaddr_t *)src)) {
+		char a1[18], a2[18];
+
+		ba2str(&addr.iso_bdaddr, a1);
+		ba2str((bdaddr_t *)src, a2);
+
+		tester_warn("rpa %s == %s id", a1, a2);
+		return false;
+
+	}
+
+	return true;
+}
+
 static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -2616,8 +2818,11 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 	if (!isodata->bcast) {
 		ret = check_ucast_qos(&qos, &isodata->qos,
 				      isodata->mconn ? &isodata->qos_2 : NULL);
-	} else if (!isodata->server)
+	} else if (!isodata->server) {
 		ret = check_bcast_qos(&qos, &isodata->qos);
+		if (ret && isodata->past)
+			ret = iso_rebind_bcast_dst(data, sk) == 0;
+	}
 
 	if (!ret) {
 		tester_warn("Unexpected QoS parameter");
@@ -2692,8 +2897,15 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 
 	if (err < 0)
 		tester_warn("Connect failed: %s (%d)", strerror(-err), -err);
-	else
+	else {
+		if (!check_rpa(data, sk)) {
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+
 		tester_print("Successfully connected");
+	}
 
 	if (err != isodata->expect_err) {
 		tester_warn("Expect error: %s (%d) != %s (%d)",
@@ -3025,6 +3237,17 @@ fail:
 	return err;
 }
 
+static gboolean test_listen_past(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *host;
+
+	host = hciemu_client_get_host(data->hciemu);
+	bthost_past_set_info(host, data->acl_handle);
+
+	return FALSE;
+}
+
 static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
 								GIOFunc *func)
 {
@@ -3070,7 +3293,18 @@ static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
 		host = hciemu_client_host(client);
 
 		bthost_set_cig_params(host, 0x01, 0x01, &isodata->qos);
-		bthost_create_cis(host, 257, data->acl_handle);
+		bthost_create_cis(host, 256, data->acl_handle);
+	} else if (isodata->past) {
+		if (!data->acl_handle) {
+			tester_print("ACL handle not set");
+			tester_test_failed();
+			return;
+		}
+
+		/* Wait for listen to take effect before initiating PAST
+		 * procedure.
+		 */
+		data->io_id[i] = g_timeout_add(250, test_listen_past, data);
 	}
 }
 
@@ -3518,6 +3752,18 @@ static void test_bcast(const void *test_data)
 	setup_connect(data, 0, iso_connect_cb);
 }
 
+static void test_past(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t num[1] = { 1 };
+	GIOFunc funcs[1] = { iso_accept2_cb };
+
+	if (data->client_num > 1)
+		setup_listen_many(data, 1, num, funcs);
+	else
+		setup_connect(data, 0, iso_connect_cb);
+}
+
 static void test_bcast_reconnect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3593,6 +3839,13 @@ static void test_bcast_recv2_defer(const void *test_data)
 	setup_listen_many(data, 2, num, funcs);
 }
 
+static void test_past_recv(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	setup_listen(data, 0, iso_accept_cb);
+}
+
 static void test_connect2_suspend(const void *test_data)
 {
 	test_connect2(test_data);
@@ -3980,6 +4233,15 @@ int main(int argc, char *argv[])
 
 	test_iso("ISO Broadcaster - Success", &bcast_16_2_1_send, setup_powered,
 							test_bcast);
+	test_iso("ISO Broadcaster PAST Info - Success", &past_16_2_1_send,
+							setup_powered,
+							test_past);
+	test_iso("ISO Broadcaster PAST Info RPA - Success", &past_16_2_1_send,
+							setup_powered,
+							test_past);
+	test_iso2("ISO Broadcaster PAST Sender - Success", &past_16_2_1,
+							setup_powered,
+							test_past);
 	test_iso("ISO Broadcaster Encrypted - Success", &bcast_enc_16_2_1_send,
 							setup_powered,
 							test_bcast);
@@ -4003,6 +4265,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster Receiver - Success", &bcast_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
+	test_iso("ISO Broadcaster PAST Receiver - Success",
+							&past_16_2_1_recv,
+							setup_powered,
+							test_past_recv);
 	test_iso("ISO Broadcaster Receiver SID auto - Success",
 							&bcast_16_2_1_recv_sid,
 							setup_powered,
-- 
2.51.0

