Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D323BCEF
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578572; cv=none; b=ZJziL+jdsrpyC+db+6B7zi+jZedmeGtyqK3kK0auF/rH7PvHT82Cz36zEyC9jGkUXrdnBJDJCYPMitPhwKPh2EzKRc7bDA62breH5MWyt8PcsWNXkkA038ijfLa3lw2p0eu1R3wR707+ZAXpv2M+jqGwtf6Suf5Ls4WmP1t9Uds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578572; c=relaxed/simple;
	bh=z1lakTarcKt3Mmp6Y+1YGnztfM1zq8lPJk+6sF2ywJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1ESaoTD7S2Sd/sCe8B2TgpxsGsB8dzyVm2ERjfbrgPdZqYyTZdSRCcd5Wc1czZDuMzGP9mwTfaqKPo45ipgH37UP3MXKg/NOxbL01PsMmQ7WXOaC5wYEwoc5r1xo9XtDbjDyFbO8CH1eRTD8NBNPUm2+TBwa54NuP/kir/VYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGycS7Z0; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGycS7Z0"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c40235c34so1754977a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578569; x=1750183369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJYg6T8CTn74jqqV2LJsX6sQnF71avoXNAL+QA5oG9Q=;
        b=BGycS7Z0e3QHj1ySwMEgqdq69NueJVA4UgqFLbM4x8kEmo5yTw+mlGUBTFybv+O5Q2
         jf7eQk4jrhKhvSNAAFjNCPt7leu6KkhFJ1zMLoc8eIuRmPbK8cWxohicXBduLFrF/Zfz
         SRuC4Onh/LxhJbS/lJAbNpIeow4xBx9hvCtFb49Pa0/dt/w3bxXf3MJIjSWJeWjt72e3
         9rs3hCyV/484ENWD+ZFPSTNMTI0sbFlEIXghMAD9wkktrjbU9dVINTNv/Sojt+4QRoLd
         Zk6Vf9S6VP5MsYuVf2JKK3hyAfcdCj96YxHMSpZf2RehlIa0vnyU0QNwIFWNnHk15xtr
         e9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578569; x=1750183369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJYg6T8CTn74jqqV2LJsX6sQnF71avoXNAL+QA5oG9Q=;
        b=oRB3jCLE2udq9po39s5uXJGYJ/AP4qu3mEDSeJFHn2uhGogn0XEepSQBjA6i/n7kVq
         YHrtsS6AqMtjWw07PBF6WvZBAOxg36Iu1/QgecfaypYyNX4DdiA8yBJzzwYz4oYuwLLe
         R1g4qUUH5IkeQBKYTVYAeX/tJOy36Z9IuRK4MFZC08DxDp9NMuysBssCFSdnCPm1zizr
         lgcNmOKaaf4cqRhUTzaqEgW+DoqOK9uAmaqqh8OBpDfs/jggH7uNJmPrgVYgibCWhdLG
         nrH2uQZ76XG0wGyiRxa6SBqpVh3kRzgB0fZG/O+iOGs9BHZ/tDsAvYVzGT/ICrFgiPu7
         nSyg==
X-Gm-Message-State: AOJu0YzniyfcGQBqjaEOR8TTijQ4vMUBp1bddUGxt90sSt9sbiK51wcn
	3+YoQz0oWh+bXKAAzHWSOI99qEFAph29xNSAc935o08O2TMA0yejRWr9PorMsQ==
X-Gm-Gg: ASbGncuWetfDNNRT3cLkkvU0fPdcrG+qJoV68/oiyvH9TkaW3Gn0kz8cgOgqIvHp2gs
	rQ4rdyEzCD3PGafuaEIYBusj2S3lD7ToDGdhpj4tYHxXZBq8fX9XMK3kqEegq+ugroptjzSiObF
	WvBcTs89rCzd8PBlki/SayJjV8WwKmYs3bvP8ua7y3AvHLdvkoYtT2XmMb21v+yhnRsbYzcl+YE
	zQw0uy0IPrVVZHftp4dJSkev2Z1KpZikuJ2hCVlUzbv2MOB7q0Brc3U3tePtE3+KgqY6jy+cFF4
	AfgNMHmDDcZVZTiAZSWDWODDqGMdRGMfvYk0XlPTK0iabF98prFjW4Nw4ptlyDVGiJvq8OINsAZ
	1IKS6svVDY3YnKTh8+t8tJg0Pjz5ZXnw=
X-Google-Smtp-Source: AGHT+IE83gAqatoRw16hYyCwCX+V/zj5LSHiJGg2g6FwkhhuojCWqUFSdjGSF+gqBT2pi/Q9cC0gOw==
X-Received: by 2002:a05:6830:2d83:b0:72b:9b1f:2e1d with SMTP id 46e09a7af769-73a056c7183mr400224a34.2.1749578568718;
        Tue, 10 Jun 2025 11:02:48 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7bb058b08sm44771137.21.2025.06.10.11.02.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:02:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] iso-tester: Add more tests for getpeername
Date: Tue, 10 Jun 2025 14:02:44 -0400
Message-ID: <20250610180244.1133512-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610180244.1133512-1-luiz.dentz@gmail.com>
References: <20250610180244.1133512-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests setting SID for broadcast source in adition to existing test
that was testing broadcast sink only, so this adds/updates the following
test:

ISO Broadcaster SID auto - Success
ISO Broadcaster SID 0x01 - Success
ISO Broadcaster Receiver SID auto - Success
ISO Broadcaster Receiver SID 0x01 - Success
---
 emulator/bthost.c   |  3 +-
 emulator/bthost.h   |  2 +-
 tools/iso-tester.c  | 74 ++++++++++++++++++++++++++++++++++++++++-----
 tools/mesh-tester.c |  2 +-
 tools/mgmt-tester.c |  4 +--
 5 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index f53b4382d6f9..7ab4533d12b4 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3467,7 +3467,7 @@ void bthost_set_scan_enable(struct bthost *bthost, uint8_t enable)
 							&cp, sizeof(cp));
 }
 
-void bthost_set_ext_adv_params(struct bthost *bthost)
+void bthost_set_ext_adv_params(struct bthost *bthost, uint8_t sid)
 {
 	const uint8_t interval_20ms[] = { 0x20, 0x00, 0x00 };
 	struct bt_hci_cmd_le_set_ext_adv_params cp;
@@ -3477,6 +3477,7 @@ void bthost_set_ext_adv_params(struct bthost *bthost)
 	cp.evt_properties = cpu_to_le16(0x0013);
 	memcpy(cp.min_interval, interval_20ms, sizeof(cp.min_interval));
 	memcpy(cp.max_interval, interval_20ms, sizeof(cp.max_interval));
+	cp.sid = sid;
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 							&cp, sizeof(cp));
 }
diff --git a/emulator/bthost.h b/emulator/bthost.h
index db640daff38a..456f631d51a0 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -113,7 +113,7 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
-void bthost_set_ext_adv_params(struct bthost *bthost);
+void bthost_set_ext_adv_params(struct bthost *bthost, uint8_t sid);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
 void bthost_set_pa_params(struct bthost *bthost);
 void bthost_set_pa_data(struct bthost *bthost, const uint8_t *data,
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 7bc0eb12c1c5..725fd3338c9f 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1412,6 +1412,26 @@ static const struct iso_client_data bcast_1_1_16_2_1_send = {
 	.base_len = sizeof(base_lc3_16_2_1),
 };
 
+static const struct iso_client_data bcast_16_2_1_send_sid = {
+	.qos = QOS_OUT_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+	.sid = 0xff,
+};
+
+static const struct iso_client_data bcast_16_2_1_send_sid1 = {
+	.qos = QOS_OUT_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+	.sid = 0x01,
+};
+
 static const struct iso_client_data bcast_16_2_1_recv = {
 	.qos = QOS_IN_16_2_1,
 	.expect_err = 0,
@@ -1439,6 +1459,16 @@ static const struct iso_client_data bcast_16_2_1_recv_sid = {
 	.sid = 0xff,
 };
 
+static const struct iso_client_data bcast_16_2_1_recv_sid1 = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+	.sid = 0x01,
+};
+
 static const struct iso_client_data bcast_enc_16_2_1_recv = {
 	.qos = QOS_IN_ENC_16_2_1,
 	.expect_err = 0,
@@ -1658,7 +1688,8 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 		host = hciemu_client_host(client);
 		bthost_set_cmd_complete_cb(host, client_connectable_complete,
 									data);
-		bthost_set_ext_adv_params(host);
+		bthost_set_ext_adv_params(host, isodata->sid != 0xff ?
+						isodata->sid : 0x00);
 		bthost_set_ext_adv_enable(host, 0x01);
 
 		if (!isodata)
@@ -1836,8 +1867,9 @@ end:
 
 static int create_iso_sock(struct test_data *data)
 {
+	const struct iso_client_data *isodata = data->test_data;
 	const uint8_t *master_bdaddr;
-	struct sockaddr_iso addr;
+	struct sockaddr_iso *addr;
 	int sk, err;
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK, BTPROTO_ISO);
@@ -1855,12 +1887,26 @@ static int create_iso_sock(struct test_data *data)
 		return -ENODEV;
 	}
 
-	memset(&addr, 0, sizeof(addr));
-	addr.iso_family = AF_BLUETOOTH;
-	bacpy(&addr.iso_bdaddr, (void *) master_bdaddr);
-	addr.iso_bdaddr_type = BDADDR_LE_PUBLIC;
+	if (isodata->bcast && isodata->sid) {
+		addr = malloc(sizeof(*addr) + sizeof(*addr->iso_bc));
+		memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
+		addr->iso_family = AF_BLUETOOTH;
+		bacpy(&addr->iso_bdaddr, (void *) master_bdaddr);
+		addr->iso_bdaddr_type = BDADDR_LE_PUBLIC;
+		addr->iso_bc->bc_bdaddr_type = BDADDR_LE_PUBLIC;
+		addr->iso_bc->bc_sid = isodata->sid;
+		err = bind(sk, (struct sockaddr *) addr, sizeof(*addr) +
+						sizeof(*addr->iso_bc));
+	} else {
+		addr = malloc(sizeof(*addr));
+		memset(addr, 0, sizeof(*addr));
+		addr->iso_family = AF_BLUETOOTH;
+		bacpy(&addr->iso_bdaddr, (void *) master_bdaddr);
+		addr->iso_bdaddr_type = BDADDR_LE_PUBLIC;
+		err = bind(sk, (struct sockaddr *) addr, sizeof(addr));
+	}
 
-	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+	if (err < 0) {
 		err = -errno;
 		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
 									errno);
@@ -2623,6 +2669,8 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 			tester_test_failed();
 			return FALSE;
 		}
+
+		tester_print("SID: 0x%02x", addr.bc.bc_sid);
 	}
 
 	len = sizeof(sk_err);
@@ -3886,14 +3934,24 @@ int main(int argc, char *argv[])
 							&bcast_1_1_16_2_1_send,
 							setup_powered,
 							test_bcast);
+	test_iso("ISO Broadcaster SID auto - Success", &bcast_16_2_1_send_sid,
+							setup_powered,
+							test_bcast);
+	test_iso("ISO Broadcaster SID 0x01 - Success", &bcast_16_2_1_send_sid1,
+							setup_powered,
+							test_bcast);
 
 	test_iso("ISO Broadcaster Receiver - Success", &bcast_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
-	test_iso("ISO Broadcaster Receiver SID 0xff - Success",
+	test_iso("ISO Broadcaster Receiver SID auto - Success",
 							&bcast_16_2_1_recv_sid,
 							setup_powered,
 							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver SID 0x01 - Success",
+							&bcast_16_2_1_recv_sid1,
+							setup_powered,
+							test_bcast_recv);
 	test_iso2("ISO Broadcaster Receiver2 - Success", &bcast_16_2_1_recv2,
 							setup_powered,
 							test_bcast_recv2);
diff --git a/tools/mesh-tester.c b/tools/mesh-tester.c
index d7b3b6f9b1db..848ccbe51a87 100644
--- a/tools/mesh-tester.c
+++ b/tools/mesh-tester.c
@@ -968,7 +968,7 @@ static void setup_bthost(void)
 	if (data->hciemu_type == HCIEMU_TYPE_LE ||
 			test->client_enable_adv) {
 		if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50) {
-			bthost_set_ext_adv_params(bthost);
+			bthost_set_ext_adv_params(bthost, 0x00);
 			bthost_set_ext_adv_enable(bthost, 0x01);
 		} else
 			bthost_set_adv_enable(bthost, 0x01);
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 030827cd51d1..a1d48152f23b 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6169,7 +6169,7 @@ static void setup_bthost(void)
 	if (data->hciemu_type == HCIEMU_TYPE_LE ||
 		test->client_enable_adv) {
 		if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50) {
-			bthost_set_ext_adv_params(bthost);
+			bthost_set_ext_adv_params(bthost, 0x00);
 			bthost_set_ext_adv_enable(bthost, 0x01);
 		} else
 			bthost_set_adv_enable(bthost, 0x01);
@@ -11724,7 +11724,7 @@ static void trigger_device_found(void *user_data)
 
 		bthost_set_adv_enable(bthost, 0x01);
 	} else if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50) {
-		bthost_set_ext_adv_params(bthost);
+		bthost_set_ext_adv_params(bthost, 0x00);
 		if (test->set_adv)
 			bthost_set_ext_adv_data(bthost, test->adv_data,
 							test->adv_data_len);
-- 
2.49.0

