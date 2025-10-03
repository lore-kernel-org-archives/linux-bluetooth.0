Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8524E4A1
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508265; cv=none; b=kbsUqhvq6IZDYFheoH5vXs4CxWDKWYP1bPTsNp4ZJ/LMxr4/NIJcFGoUJIyfYTQMleqnlqgjsDujMZ9Iv1IF2jnvLBMmoX2sWva6lETHUQHmcthr8J9CLJHBgvXVgnHmo/RUPk5usMpNsIZ878V/SUmy53s6RCyxdwZk8K8lDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508265; c=relaxed/simple;
	bh=VlEBFPSdDxQRIGkNnCu/m1VZ3G/+ruSZXYumU9JTvOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWmEJThvdcCYMr5c0LNCiyMBpgDIdAqlY+ohOqoG3OsuEnIQzK51Y+LspDZTi79QBZsZ5f0xjNl6hGGjSahcc3E7iHB/YH12v8K8bdBNpnQHFhk5OAm2XyECBE4cS+JRUaTyIhLvNA9CSxt5m6tDA2k88vs7H6B0CXshgy+LPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji8at+TZ; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji8at+TZ"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-574d36a8c11so959692137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759508261; x=1760113061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJFBjNzEzQRYGQ+lIH/FNTKEoayWFYaKZfb0gWVWjjw=;
        b=ji8at+TZA9r2DiyfHve4KgwokNYrVIEDL5BCpOuL/JlVLM10dYl/WQUGWWe0iaG1nY
         gBf+DB7+NM59vg2kkaQ0oJomliLkT9htTvRGk/+EUoVqhIt3vum/RtRylz03ZuCEEavI
         RAxR7LVBPcLY2ZRhE+bncKqCE6CXOu6Ry759mgHeaosAjopaI1T7sjjSjrGMUWxYs4TE
         19w647iTuL/+tWLcC5tIbrmwdSbYUqRN0QxtmDQqywC9qe6Cjnj8hOHFeoL47g0dlGD4
         zDXZhluzC8kN1Hymj8k8Vzzt2sKVf3Dd0pBHEYOlyX5lyDKmCSZaix1RQlgJBLg6eP4M
         /lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508261; x=1760113061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJFBjNzEzQRYGQ+lIH/FNTKEoayWFYaKZfb0gWVWjjw=;
        b=O3QZYeUfTp/oopcIwfSdrlIlPbqkb39EwJje5AE2pjTnsc8L6t82IxkOWLgN4fsVO/
         sOCHU3q2ynNNpCLlZ1BfIXW25RQH5tVMHj1MBZvnh2wE1WOZ9QQUZDwXpMryqci3BpGR
         jaA65pCZ/LLigqJ7Aw+vAgQ3n45CsGFhCYqaF121vI/MgO2J2BjD9DuZgF2FZRSEcniv
         rgcqJnfpNn+98JvlaSd46N87qGwXBwKJsiYstXUbntF9UEhhvq8b8I1XJ3QoRyYx+wl0
         URHXP5GUaJWXskNI7vUyEi6lkSVNO8MpwcqypU8KV0mejXwuMZZIu0g877rSSyW+lvXW
         XY+A==
X-Gm-Message-State: AOJu0Yx6w2s5Peb7ky4laW5AJr1y+OpWH8MpP9/PeE5Hi6Ut4VIGKgN6
	fBM4PlRZ5K7LCGXVEvPK4hpWOMLy1aez+FO97GmELgExVAtMs3KPVMvRbYmbYbqe
X-Gm-Gg: ASbGnctpqTUmYBcm1N7MOVeDSbZ1L8hsdfYHj/yzTIAqh8iUmrIWIJJS7ExKEedW+KF
	pL+p/LJ/4E4Xa5NVJ2dl32zHwt6FJB91fLaHK+QyJelj7VeSVDBv7aEA9692tU6aAPIR07v64Vy
	obttkbdPXKVoxe7FyIfYcrgoAVfem9eG8wg71v4b/6LbOjDSc1N3vfEwgC7tAlJrWygmUM/NSrx
	OLmeXkcpBCEbO5bdZBTjwEkvsOPh0zTzRTqRrrHPZm3l0VjEBK5o+Z5MzMIJIODxTBRFdxl4qlA
	kVfg4B0iqPmfGJNc71N+TINlghcx8GqkZ5hYQjQePQkp3iP7yyIB8bkKSZNDMnKHJ2iyEuNozth
	76m68GzUMtEG8/hOJSX3ZMteyt9HoVX+jqT90IF8jiR+y5YQkJL99COACYNlmS2h7xcp8B2Dw2q
	ssjE/rhNxgv2deIQ==
X-Google-Smtp-Source: AGHT+IGWq7Jq5wlS8u9gCWQ7siTGrcXURiWO9Wq5HYnbsZKHSWqVBrjL65M7HC30UOG+/EqE30S4wQ==
X-Received: by 2002:a05:6102:5086:b0:51f:66fc:53b8 with SMTP id ada2fe7eead31-5d41d10c1e6mr1321520137.25.1759508261179;
        Fri, 03 Oct 2025 09:17:41 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c4eb764sm1364253137.1.2025.10.03.09.17.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:17:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] iso-tester: Add tests for PAST procedures
Date: Fri,  3 Oct 2025 12:17:21 -0400
Message-ID: <20251003161721.508678-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003161721.508678-1-luiz.dentz@gmail.com>
References: <20251003161721.508678-1-luiz.dentz@gmail.com>
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
ISO Broadcaster PAST Sender - Success
ISO Broadcaster PAST Receiver - Success
---
 tools/iso-tester.c | 225 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 213 insertions(+), 12 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 0eeab4fd7108..08386f259b47 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -488,6 +488,7 @@ struct iso_client_data {
 	const struct iovec *recv;
 	bool server;
 	bool bcast;
+	bool past;
 	bool defer;
 	bool disconnect;
 	bool ts;
@@ -1381,6 +1382,27 @@ static const struct iso_client_data bcast_16_2_1_send = {
 	.base_len = sizeof(base_lc3_16_2_1),
 };
 
+static const struct iso_client_data past_16_2_1_send = {
+	.qos = QOS_OUT_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.past = true,
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
@@ -1446,6 +1468,16 @@ static const struct iso_client_data bcast_16_2_1_recv = {
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
@@ -1594,6 +1626,7 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 {
 	struct test_data *data = user_data;
 	static uint8_t client_num;
+	const struct iso_client_data *isodata = data->test_data;
 
 	if (opcode != BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE)
 		return;
@@ -1606,7 +1639,8 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 	if (status)
 		tester_setup_failed();
 	else if (data->client_num == client_num) {
-		tester_setup_complete();
+		if (!isodata || !isodata->past)
+			tester_setup_complete();
 		client_num = 0;
 	}
 }
@@ -1641,6 +1675,8 @@ static void iso_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = user_data;
 	struct bthost *host;
+	const struct iso_client_data *isodata = data->test_data;
+	static uint8_t client_num;
 
 	tester_print("New client connection with handle 0x%04x", handle);
 
@@ -1649,6 +1685,14 @@ static void iso_new_conn(uint16_t handle, void *user_data)
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
@@ -1664,10 +1708,73 @@ static uint8_t iso_accept_conn(uint16_t handle, void *user_data)
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
@@ -1716,18 +1823,17 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
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
 
@@ -1739,7 +1845,7 @@ static void setup_powered(const void *test_data)
 
 	tester_print("Powering on controller");
 
-	if (!isodata || !isodata->bcast)
+	if (!isodata || !isodata->bcast || isodata->past)
 		mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 					sizeof(param), param,
 					NULL, NULL, NULL);
@@ -1750,7 +1856,7 @@ static void setup_powered(const void *test_data)
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
 
-	if (isodata && isodata->server && !isodata->bcast)
+	if (isodata && ((isodata->server && !isodata->bcast) || isodata->past))
 		mgmt_send(data->mgmt, MGMT_OP_SET_ADVERTISING,
 				data->mgmt_index, sizeof(param), param, NULL,
 				NULL, NULL);
@@ -2520,6 +2626,9 @@ static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
 	const struct iso_client_data *isodata = data->test_data;
 	unsigned int count;
 
+	if (isodata->past && !data->handle)
+		return TRUE;
+
 	data->io_id[0] = 0;
 
 	tester_print("POLLOUT event received");
@@ -2533,6 +2642,8 @@ static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
 		iso_send_data(data, io);
 
 	if (isodata->bcast) {
+		if (isodata->past)
+			return FALSE;
 		tester_test_passed();
 		return FALSE;
 	}
@@ -2588,6 +2699,42 @@ static void trigger_force_suspend(void *user_data)
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
 static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -2616,8 +2763,11 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
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
@@ -3025,6 +3175,17 @@ fail:
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
@@ -3070,7 +3231,18 @@ static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
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
 
@@ -3518,6 +3690,18 @@ static void test_bcast(const void *test_data)
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
@@ -3593,6 +3777,13 @@ static void test_bcast_recv2_defer(const void *test_data)
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
@@ -3980,6 +4171,12 @@ int main(int argc, char *argv[])
 
 	test_iso("ISO Broadcaster - Success", &bcast_16_2_1_send, setup_powered,
 							test_bcast);
+	test_iso("ISO Broadcaster PAST Info - Success", &past_16_2_1_send,
+							setup_powered,
+							test_past);
+	test_iso2("ISO Broadcaster PAST Sender - Success", &past_16_2_1,
+							setup_powered,
+							test_past);
 	test_iso("ISO Broadcaster Encrypted - Success", &bcast_enc_16_2_1_send,
 							setup_powered,
 							test_bcast);
@@ -4003,6 +4200,10 @@ int main(int argc, char *argv[])
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

