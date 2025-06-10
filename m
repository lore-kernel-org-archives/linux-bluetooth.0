Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E023C501
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568305; cv=none; b=AGl1ndK1iraWJVnu4Uw6wbtqM9X4TlifXRhixv+AFwwxOWhNoeYQUVket1QWNr/vcz0Oednc2C37+fMAmsa1Fhqb9wGksq2FbVgxWPnMrmiTkuB+J1NMfoMh5oXnIhZJ9rVnQA12Mtlg62Ww+ek2ym/L9wcErauQzcH/0RSV79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568305; c=relaxed/simple;
	bh=R0ZK0OGIe2j/FhtxEEJ8yuaAkHhHo+xDPxUZdlEU6q4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNe8Fq+0BbTc6ZYcM1f0PDGq4DbIp2AkxzrVynLxkDOCabuGV00dB7vcGlHRgHAqPttIthoJdDHB+8fKI8trJNvwq0U/PuJbuGrkvO7+f8tbAX0RhAXv1sEiIofcZKRCoCRKWT3XrE+jV5NA6fNlafWTa0h+jymQn/jmUGwgnu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X08rhuaP; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X08rhuaP"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e4043c5b7so47240377b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568302; x=1750173102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tW5VWmEDXM3LcDBNCQpZByqBQCxLeYuYSWVi2tT1RNc=;
        b=X08rhuaPTMEOqewIX97nJq0VKf/rQVFcRESi0qJQO3aLCeHThEQn0wkl8nMb4DKn20
         M0u04deLAeFGGpmpHrDHaQgvY6k9K4eg/Md1QZsl+i+CX1OSOd/gDxdS8C5nn9y6XiI2
         cUjaAfZDWiee0MpQZaRiP5olMuHV+DeL1gKMY3GyDWXZF2UYtYj5YdAu67QXgnkPeA+j
         OjkTOqsym3Rcwo3UPLuLqnRIQp1yBFkO1kKtQx1v2ktqYPlE0BlB9yzHSo5aGedmWU+Q
         RkNSjTUHXpa8lCCnstFNnL9iBDRSWqZI5pXHvp+yCHEZUXalcC+j3Q6LvxOSk5LYEDtK
         HyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568302; x=1750173102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW5VWmEDXM3LcDBNCQpZByqBQCxLeYuYSWVi2tT1RNc=;
        b=A6kf33z1DSC/6IklNs3yVZe8UTej6oOX2hl6MGcIHohKrnec2EDuVdwH1giVJA4/zU
         +ShZz07B9BSgL7y3Iej/duCAqEozrtud5dKyVwkOy+5SKktv+iJ+c2BndOEcPqmnGpsi
         tl4quUFEdYfYnrvTMdqiMp/HyEUVgctM2GlRHSSjd0hvwx5OHnB9KErW836SnkhyuqzQ
         /MqaaTgSe+FMom1Tx0hFI4P9d/loIAfj+FpgkVgaCWSbyhB6ShHocfutpHWtLtypC5k1
         mdkJBMvPvfkPsIMD4rK29+TZadY0z5qzRFncDXVdOAfCMgTcSOKtiXzMFD149B7MaseW
         bTRQ==
X-Gm-Message-State: AOJu0Ywt04NU2EdL6al+KNBZMOh2fi3jXFS5Wl/LucmZ0QKMH17mYYoJ
	Fzn5ScFRjRJoUGVwKIwrcXaxTwpneSrmGMjAnXrm2TBVzMQ4VHIogGeTWZEHDw==
X-Gm-Gg: ASbGncsQpvZcsRfDSniUNGa+wGQPhrHOHvG9KpPy+83XPBgnUjj0+iWN8tWnekG1IET
	RL2NkM4Or52oi7aRtPSpieQj8aT2sOErvTAlKqrrV1EDHeEksW4xVt47DFK+hPXUSA5V2EDHx2D
	Wt8drnyc8K00LTjjvQxQT1jnLB8oMtrnWD02Klx2jKXk//x2TcvLOHdgsSQ0ScpnlreD3qokFhZ
	0ecD76Ms3AMFgmVh35qWi6YkjjIy8EfOP1us6+tS57B08gjqHu1MbWKMpWhbrqexG/DIC6S4/YM
	vwuWv+OePfPqYkKK3WsJuE7r34WUIRGJrsvSkkUbtpopKMsCuu+l4rWxlfji1MVx7vBeJo7gHmg
	i16qpjzS1ysuhrL3L4ANmJrZDtoFIqcI=
X-Google-Smtp-Source: AGHT+IFJiYCD0CZP2ZhMz4UAWjuPgqep1cP8RZHt/FDXyvNkpgLq+I5gsRsE7VbYYNcLhpfk03KH/A==
X-Received: by 2002:a05:690c:620e:b0:710:e8a8:771d with SMTP id 00721157ae682-710f770f5e4mr241891307b3.24.1749568302101;
        Tue, 10 Jun 2025 08:11:42 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5311e245dd8sm520897e0c.34.2025.06.10.08.11.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:11:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] iso-tester: Add more tests for getpeername
Date: Tue, 10 Jun 2025 11:11:38 -0400
Message-ID: <20250610151138.1093270-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610151138.1093270-1-luiz.dentz@gmail.com>
References: <20250610151138.1093270-1-luiz.dentz@gmail.com>
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
 emulator/bthost.c   |  3 ++-
 emulator/bthost.h   |  2 +-
 tools/iso-tester.c  | 47 +++++++++++++++++++++++++++++++++++++++++++--
 tools/mesh-tester.c |  2 +-
 tools/mgmt-tester.c |  4 ++--
 5 files changed, 51 insertions(+), 7 deletions(-)

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
index 7bc0eb12c1c5..323ba6920ba3 100644
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
@@ -2623,6 +2654,8 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 			tester_test_failed();
 			return FALSE;
 		}
+
+		tester_print("SID: 0x%02x", addr.bc.bc_sid);
 	}
 
 	len = sizeof(sk_err);
@@ -3886,14 +3919,24 @@ int main(int argc, char *argv[])
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

