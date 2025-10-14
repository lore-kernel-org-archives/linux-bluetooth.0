Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94F306B04
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474061; cv=none; b=rgTiLE7bZdoQXtqohr1t+z1kdci/xF0zjsFcJgtv0SfDsKUrp5nfQyLRvz1Ermi2gt3YXDewp8liRdGNqn/XuN1mD9QvfRFutIZkI5lgdGA3ZJL1pZIkxxQGXt4T4gopFZIByJVROPAPV2llXshJsn/rTDXMyiELshke0qA7GYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474061; c=relaxed/simple;
	bh=7nHhBHZjobZO9tc5CXwqUs0K7TUrrVa0WVju8hL7Sqc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFVq1iRjQ8rwvBlKUg8Kty0fsNCOi5fZmIzNDIKTbeXh0FQd9ypKAEeb+H+SkT384T2/GmCf/X4H8oireO+nq6l1G1rpQjJoHwa0PX1Z829f6v4fffR1bw5pEt1HJSfzryvWTFh5e+pcY/skSQc8jMFImt1v2wlPyryN4+fIOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdEObHIn; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdEObHIn"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-59d576379b9so2316515137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760474058; x=1761078858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ov96oWwEYQbN9ntKJyLu8EaESUNNv2Y9yVqxW9k3YGI=;
        b=YdEObHInznxexbLhzlVIW6mCmI/eYk4/CVMT3+Me8Zrb5pUirkRUK1STRtCCO8rnou
         qJgH45T8wsCBSAYzOe5hNa+Qi1+mdssVwOY5jngojJJJvQZsoyjaxZOXIyDWrgHGk3S+
         p0H30EghWR6qyCDIRgS0JYaD4w2GqUziu45chz0SSeRHYF13dD7sPgIb/a/I5QTKaRXi
         bvkay95UEtkcTQbsEk/v6GkIEBJECWnau88YeyYYjpaJsnwIki2biOyRy1z+bkv7tiq3
         Tf3BjISaehKgf0h4MCW4vx40B+ZKL3+r1I3zZtdL63mInrgS2fhP5hSNira1h2WraNvO
         JmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474058; x=1761078858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov96oWwEYQbN9ntKJyLu8EaESUNNv2Y9yVqxW9k3YGI=;
        b=HgmI37pLi+g9eoyyfmB/cR0nLXh9RyqUfcvGKepUkG88Ln5FBi2rrEcy8gP6s56HSP
         3dtoXf3QmpZqSJoSBz7VK5cM7q9ZjvXEbHUKSU4oy3JhlnIpj4ndItlv2KoWclfjpEvG
         8XhIvPRi6VrWZMjGIKQiXpLUUQXjZdI/I3QfIrizmEDUydO6GzOyNvNjXTTSazentVxn
         BGOK+S5cmdxiVr5qePxAbKr9uUJ35qVeMyttzubRVt8RP8kXKwnvMTi/raz7SnPBQVRt
         1jBCXBHljZkLbI5BoL1jc2U1mldH/GBsdudPnmxOb0EBLh1NzFpBh4uYy3YAODvPvjGl
         B2sw==
X-Gm-Message-State: AOJu0YxvdruTpTXc0zA+3Lcl6HXUtITnxNsZuXxKd+7/cbudXhRHGOQG
	UB1M8HpY+PqMDDqLHRJ4TlKHeBetPc56znBGtckf8v+HQTeGOI20ZyE4hA0UtRmh
X-Gm-Gg: ASbGncs63CKNBNQzieGPsuecLJBd1PlohjBCXhPwY7ijVizHzkG1eyWEk2xV3pibqb7
	wBmnnoWk0FtZMhgrNhCJCNvmo2DXPTKp9LBHCU4v+3mX3rl+kQhIvf8c9pttcQxDMg0iYXsRCac
	T0sRjL3t1fBtpXatfOxZGYFve09fWlMuqMoKgHZ9D5ZNgXS40azV6WS6J1FoCYOTNoTM3W/g+YQ
	q6RfnBFYhuDMTq4V752ToNgJ5nzMVyGE05cpiVvI6/X/fJDOa3FViTxl4F3dt5qRM7cNXBaJgLs
	9J/qIryNi0p70mJ9aBP10qf4/wgQ7ng7oSUnLDi6cafl1gLt1dzXWuCKbkyC9Fd8JFnZ/8FfebK
	ZjMHFyOfAGr/wpEsvrDdPWumv4JSydeWMhJgG9+ZFuTphBXzb+oRKv7KIwxoWVy8Oyw==
X-Google-Smtp-Source: AGHT+IHHX+uPO7c6SkSCFGvprlqc72g9/gENcWY1MkvEH7v4Qytgbn8SwEguC1eLNG6m3Lffr3ucmg==
X-Received: by 2002:a05:6102:ccc:b0:5d5:f6ae:74b9 with SMTP id ada2fe7eead31-5d5f6ae75abmr6229717137.45.1760474057879;
        Tue, 14 Oct 2025 13:34:17 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80a456csm4434116e0c.14.2025.10.14.13.34.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:34:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/6] iso-tester: Add tests for PAST procedures
Date: Tue, 14 Oct 2025 16:33:57 -0400
Message-ID: <20251014203400.453454-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014203400.453454-1-luiz.dentz@gmail.com>
References: <20251014203400.453454-1-luiz.dentz@gmail.com>
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

