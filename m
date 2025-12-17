Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0A30BF6E
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004112; cv=none; b=RKjIzJIqCtcjMInN5OtUelIGwPNnUWIJQ+eBJRf6gJEs4pPJbF7eFWu4emZP+kxbtscBRB7LQyQgl8bQiGeiLiyc781Q7iL00NrRHWd9qE9SdhYZC6nl0kdmbYQW8IyIbfnhTMvRR/+3QEH3At9+/5ublXwrY8aI/J0hJYiVj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004112; c=relaxed/simple;
	bh=cLvPVOoRoZkdN7wv09iRVFw0rtZEuGRQza72FFA8tmU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgj20gc6OgjKGwDDNxpt/gg97pakvBdc5KIsK/T8OT3/EpAkSrnCkJwU6Vzibi98aIE8dXEqJW6KHsGV0sr3YYmcyy2D71nEMrQ8MGjAMWaprTd60pu5EwJHXmU6TRovoKJA1aYzUwchpHMZ+gy61d4B+QBIyoN2xmsT+2oMTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWEgz/ji; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWEgz/ji"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9412cb281acso1257489241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766004107; x=1766608907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyOBk/yWc+zS8EeO8SeU6Yh50Mr4TtpU/gttKGwOBBI=;
        b=jWEgz/jiYA+dnAWfjEjXC27Keoe8Je3IRL8kybg6YML1HvzRL4C2HQNH+zdO1hkFK/
         VgWYlh2haNEuUVyPAaHdwL5ROKrvKt7G4zXjJ1t+6DYBf9AsTgPv1WWNlQnd+hJ14vSL
         33NN1jrGBUFre8lB7Jnp8bXm6psZLxtaYwdFTVU7FB+PmSE1UkD4McB7f/jTVdO2LItS
         5tnHCcvRa60feRUFLAqQ7HES45S0ralDoCRhfsAeojVExbM37XlidtpberTa6XXQtgd/
         C8TVtW4fB4RWbAndoHKvd3wZ2wXJi3VqUPglIU7pbVMHdOaSeliBAZ+uJkrgL4T1nRe9
         EfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766004107; x=1766608907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyOBk/yWc+zS8EeO8SeU6Yh50Mr4TtpU/gttKGwOBBI=;
        b=iavalY304r2gEni6nUW8RbjE9PKNFwZEM50hIKwBE13cXkJU3rAjxhD+KUMWAMEOWk
         xKnTRd7C8SqMqA3W+I0V+k1l0fsfBps33La3XA4BRDN29ZhZdbwYcnjzMeeDzSUIgJcW
         Zay3sArtIRxoPZj3kxTgsZzrEmv+fEnC0KnetYz/iU49HTQXVc+53juHSBkN4g4Rf5Vt
         hA2UDerPEd1UMFHc0A9N79Oo6t/YfVvtGn8BrWiDI5iQwc2BD0d7HWulZzHwO/4ilsKu
         m4il1HX61HN0hq5mRxZ+AV8yFVaOaXTwgh/O6HDvGrbJCEKEZth3pA9+j6EuDZ0n4RrY
         2ROA==
X-Gm-Message-State: AOJu0YyMSnYqnhs0VIyhzPNpZnZn3Zysj5gdzyCvRuBe9KOJL/jJtilQ
	Uhbk36rbM8VMTG88saMIJfZU0+2BjhqzD2BUlUhZpWK8yceyoXBgYjpCr23JSyfc
X-Gm-Gg: AY/fxX7muJmXAOu9ahNzYwGDJGpCgwut7WJaJ1j2qZu21RxHJQRiNf6tK8CJXr4eI68
	lGLwsbtMwVSnlMfSUkld5JH2h+WsPZ+S6QzId6K5KqxUMcBLgIrV2eRb7BzGp/1yIXUYE1JDRIs
	WkhhuCSDH4pOp8eaZIDcj4b62D+4WIa0Npxg7x5VfoPSPTyk+nyv3cFM+FYV4PJq3pXUcMsQPj6
	DOmk97XIMywKmgDqRLuud5vN8JZnDrnfAc6Ra731iYf1L3RGo8xPxSk3dS2FrlgU4Z6nE8g3Sx+
	HqGHz1bcB6f9043Ty79OzosnrKT6NFfCUMuKKgV520tKP3xRuB5q3hWD8TJ1GTUnepkR0wXq9iF
	nI8vOmZMN3jIINWbCYhScRZgHghwc7e/+Pq0XXIlOkxuAVyq+SXxCP0gQUcwoQHLqMP5V5bZlZz
	ALHRUOQeEOSM7buw==
X-Google-Smtp-Source: AGHT+IHF9KfrBxl3opFcTjsXwFoiwhfCdn5ez+8VZzk2E6IF3OYQxfXqMjdYvVZcWB2Jomm/G4hDRA==
X-Received: by 2002:a05:6102:4412:b0:5dd:7a30:ec0d with SMTP id ada2fe7eead31-5e827696929mr6473411137.2.1766004107137;
        Wed, 17 Dec 2025 12:41:47 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb057e3f0bsm119217137.4.2025.12.17.12.41.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 12:41:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] tools/l2cap-tester: Add tests for setting BT_PHY
Date: Wed, 17 Dec 2025 15:41:33 -0500
Message-ID: <20251217204133.282359-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217204133.282359-1-luiz.dentz@gmail.com>
References: <20251217204133.282359-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests that use setsockopt(BT_PHY):

L2CAP BR/EDR Client - Set PHY 1M
L2CAP BR/EDR Client - Set PHY 2M
L2CAP BR/EDR Client - Set PHY 3M
L2CAP BR/EDR Server - Set PHY 1M
L2CAP BR/EDR Server - Set PHY 2M
L2CAP BR/EDR Server - Set PHY 3M
L2CAP LE Client - Set PHY 1M
L2CAP LE Client - Set PHY 2M
L2CAP LE Client - Set PHY Coded
L2CAP LE Server - Set PHY 1M
L2CAP LE Server - Set PHY 2M
L2CAP LE Server - Set PHY Coded
L2CAP Ext-Flowctl Client - Set PHY 1M
L2CAP Ext-Flowctl Client - Set PHY 2M
L2CAP Ext-Flowctl Client - Set PHY Coded
L2CAP Ext-Flowctl Server - Set PHY 1M
L2CAP Ext-Flowctl Server - Set PHY 2M
L2CAP Ext-Flowctl Server - Set PHY Coded
---
 tools/l2cap-tester.c | 342 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 334 insertions(+), 8 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 4cb56e98078a..c3aa96f84ea0 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -109,6 +109,9 @@ struct l2cap_data {
 
 	/* Expected supported PHYs */
 	uint32_t phys;
+
+	/* Set PHY */
+	uint32_t phy;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -426,6 +429,35 @@ static const struct l2cap_data client_connect_phy_test_1 = {
 	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
 };
 
+static const struct l2cap_data client_connect_phy_1m_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.phys = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+	.phy = BT_PHY_BR_1M_1SLOT,
+};
+
+static const struct l2cap_data client_connect_phy_2m_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.phys = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+	.phy = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT),
+};
+
+static const struct l2cap_data client_connect_phy_3m_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.phys = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+	.phy = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+};
+
 static const struct l2cap_data client_connect_nval_psm_test_1 = {
 	.client_psm = 0x1001,
 	.expect_err = ECONNREFUSED,
@@ -573,6 +605,44 @@ static const struct l2cap_data l2cap_server_phy_test = {
 	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
 };
 
+static const struct l2cap_data l2cap_server_phy_1m_test = {
+	.server_psm = 0x1001,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.phys = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+	.phy = BT_PHY_BR_1M_1SLOT,
+};
+
+static const struct l2cap_data l2cap_server_phy_2m_test = {
+	.server_psm = 0x1001,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.phys = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+	.phy = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT),
+};
+
+static const struct l2cap_data l2cap_server_phy_3m_test = {
+	.server_psm = 0x1001,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.phys = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+	.phy = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+};
+
 static const struct l2cap_data le_client_connect_success_test_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -706,6 +776,33 @@ static const struct l2cap_data le_client_connect_phy_2m_coded_test_1 = {
 		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
 };
 
+static const struct l2cap_data le_client_set_phy_1m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX,
+};
+
+static const struct l2cap_data le_client_set_phy_2m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX,
+};
+
+static const struct l2cap_data le_client_set_phy_coded_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
+};
+
 static uint8_t nonexisting_bdaddr[] = {0x00, 0xAA, 0x01, 0x02, 0x03, 0x00};
 static const struct l2cap_data le_client_close_socket_test_1 = {
 	.client_psm = 0x0080,
@@ -807,6 +904,48 @@ static const struct l2cap_data le_server_phy_2m_coded_test = {
 		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
 };
 
+static const struct l2cap_data le_server_set_phy_1m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX,
+};
+
+static const struct l2cap_data le_server_set_phy_2m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX,
+};
+
+static const struct l2cap_data le_server_set_phy_coded_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
+};
+
 static const uint8_t ecred_connect_req[] = {	0x80, 0x00, /* PSM */
 						0x40, 0x00, /* MTU */
 						0x40, 0x00, /* MPS */
@@ -889,6 +1028,48 @@ static const struct l2cap_data ext_flowctl_server_phy_2m_coded_test = {
 		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
 };
 
+static const struct l2cap_data ext_flowctl_server_set_phy_1m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_server_set_phy_2m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_server_set_phy_coded_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
+};
+
 static const struct l2cap_data le_att_client_connect_success_test_1 = {
 	.cid = 0x0004,
 	.sec_level = BT_SECURITY_LOW,
@@ -1031,6 +1212,36 @@ static const struct l2cap_data ext_flowctl_client_phy_2m_coded_test_1 = {
 		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
 };
 
+static const struct l2cap_data ext_flowctl_client_set_phy_1m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_client_set_phy_2m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_client_set_phy_coded_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -1492,7 +1703,40 @@ static bool check_mtu(struct test_data *data, int sk)
 	return true;
 }
 
-static bool check_phys(struct test_data *data,int sk)
+static gboolean check_phy(gpointer args)
+{
+	int sk = PTR_TO_INT(args);
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	socklen_t len;
+
+	len = sizeof(data->phys);
+	data->phys = 0;
+
+	tester_print("Checking PHY...");
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &data->phys, &len) < 0) {
+		tester_warn("getsockopt(BT_PHY): %s (%d)",
+				strerror(errno), errno);
+		tester_test_failed();
+		goto done;
+	}
+
+	if (l2data->phy && l2data->phy != data->phys) {
+		tester_warn("phy 0x%08x != 0x%08x", l2data->phy, data->phys);
+		tester_test_failed();
+		goto done;
+	}
+
+	tester_test_passed();
+
+done:
+	shutdown(sk, SHUT_WR);
+
+	return FALSE;
+}
+
+static int check_phys(struct test_data *data, int sk)
 {
 	const struct l2cap_data *l2data = data->test_data;
 	socklen_t len;
@@ -1503,15 +1747,29 @@ static bool check_phys(struct test_data *data,int sk)
 	if (getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &data->phys, &len) < 0) {
 		tester_warn("getsockopt(BT_PHY): %s (%d)",
 				strerror(errno), errno);
-		return false;
+		return -errno;
 	}
 
 	if (l2data->phys && l2data->phys != data->phys) {
 		tester_warn("phys 0x%08x != 0x%08x", l2data->phys, data->phys);
-		return false;
+		return -EINVAL;
 	}
 
-	return true;
+	if (l2data->phy) {
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_PHY, &l2data->phy,
+						sizeof(l2data->phy)) < 0) {
+			tester_warn("setsockopt(BT_PHY): %s (%d)",
+					strerror(errno), errno);
+			return -errno;
+		}
+
+		/* Wait for the PHY to change */
+		g_idle_add(check_phy, INT_TO_PTR(sk));
+
+		return -EINPROGRESS;
+	}
+
+	return 0;
 }
 
 static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
@@ -1689,7 +1947,12 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	if (!check_phys(data, sk)) {
+	err = check_phys(data, sk);
+	if (err < 0) {
+		if (err == -EINPROGRESS) {
+			g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
+			return FALSE;
+		}
 		tester_test_failed();
 		return FALSE;
 	}
@@ -2405,7 +2668,7 @@ static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	int sk;
+	int sk, err;
 
 	sk = g_io_channel_unix_get_fd(io);
 
@@ -2414,7 +2677,12 @@ static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	if (!check_phys(data, sk)) {
+	err = check_phys(data, sk);
+	if (err < 0) {
+		if (err == -EINPROGRESS) {
+			g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
+			return FALSE;
+		}
 		tester_test_failed();
 		return FALSE;
 	}
@@ -2532,7 +2800,8 @@ static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
 	}
 
 	if (!l2data->expect_cmd) {
-		tester_test_passed();
+		if (!l2data->phy)
+			tester_test_passed();
 		return;
 	}
 
@@ -2547,6 +2816,9 @@ static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
 		goto failed;
 	}
 
+	if (l2data->phy)
+		return;
+
 	tester_test_passed();
 	return;
 
@@ -2771,6 +3043,15 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP BR/EDR Client - PHY",
 					&client_connect_phy_test_1,
 					setup_powered_client, test_connect);
+	test_l2cap_bredr("L2CAP BR/EDR Client - Set PHY 1M",
+					&client_connect_phy_1m_test,
+					setup_powered_client, test_connect);
+	test_l2cap_bredr("L2CAP BR/EDR Client - Set PHY 2M",
+					&client_connect_phy_2m_test,
+					setup_powered_client, test_connect);
+	test_l2cap_bredr("L2CAP BR/EDR Client - Set PHY 3M",
+					&client_connect_phy_3m_test,
+					setup_powered_client, test_connect);
 
 	test_l2cap_bredr("L2CAP BR/EDR Server - Success",
 					&l2cap_server_success_test,
@@ -2811,6 +3092,15 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP BR/EDR Server - PHY",
 				&l2cap_server_phy_test,
 				setup_powered_server, test_server);
+	test_l2cap_bredr("L2CAP BR/EDR Server - Set PHY 1M",
+				&l2cap_server_phy_1m_test,
+				setup_powered_server, test_server);
+	test_l2cap_bredr("L2CAP BR/EDR Server - Set PHY 2M",
+				&l2cap_server_phy_2m_test,
+				setup_powered_server, test_server);
+	test_l2cap_bredr("L2CAP BR/EDR Server - Set PHY 3M",
+				&l2cap_server_phy_3m_test,
+				setup_powered_server, test_server);
 
 	test_l2cap_bredr("L2CAP BR/EDR Ethtool Get Ts Info - Success", NULL,
 			setup_powered_server, test_l2cap_ethtool_get_ts_info);
@@ -2863,6 +3153,15 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP LE Client - PHY 2M/Coded",
 				&le_client_connect_phy_2m_coded_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_le_52("L2CAP LE Client - Set PHY 1M",
+				&le_client_set_phy_1m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le_52("L2CAP LE Client - Set PHY 2M",
+				&le_client_set_phy_2m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le_52("L2CAP LE Client - Set PHY Coded",
+				&le_client_set_phy_coded_test,
+				setup_powered_client, test_connect);
 
 	test_l2cap_le("L2CAP LE Client - Close socket 1",
 				&le_client_close_socket_test_1,
@@ -2896,6 +3195,15 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP LE Server - PHY 2M/Coded",
 					&le_server_phy_2m_coded_test,
 					setup_powered_server, test_server);
+	test_l2cap_le_52("L2CAP LE Server - Set PHY 1M",
+					&le_server_set_phy_1m_test,
+					setup_powered_server, test_server);
+	test_l2cap_le_52("L2CAP LE Server - Set PHY 2M",
+					&le_server_set_phy_2m_test,
+					setup_powered_server, test_server);
+	test_l2cap_le_52("L2CAP LE Server - Set PHY Coded",
+					&le_server_set_phy_coded_test,
+					setup_powered_server, test_server);
 
 	test_l2cap_le("L2CAP Ext-Flowctl Client - Success",
 				&ext_flowctl_client_connect_success_test_1,
@@ -2932,6 +3240,15 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP Ext-Flowctl Client - PHY 2M/Coded",
 				&ext_flowctl_client_phy_2m_coded_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_le_52("L2CAP Ext-Flowctl Client - Set PHY 1M",
+				&ext_flowctl_client_set_phy_1m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le_52("L2CAP Ext-Flowctl Client - Set PHY 2M",
+				&ext_flowctl_client_set_phy_2m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le_52("L2CAP Ext-Flowctl Client - Set PHY Coded",
+				&ext_flowctl_client_set_phy_coded_test,
+				setup_powered_client, test_connect);
 
 	test_l2cap_le("L2CAP Ext-Flowctl Server - Success",
 				&ext_flowctl_server_success_test,
@@ -2945,6 +3262,15 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP Ext-Flowctl Server - PHY 2M/Coded",
 				&ext_flowctl_server_phy_2m_coded_test,
 				setup_powered_server, test_server);
+	test_l2cap_le_52("L2CAP Ext-Flowctl Server - Set PHY 1M",
+				&ext_flowctl_server_set_phy_1m_test,
+				setup_powered_server, test_server);
+	test_l2cap_le_52("L2CAP Ext-Flowctl Server - Set PHY 2M",
+				&ext_flowctl_server_set_phy_2m_test,
+				setup_powered_server, test_server);
+	test_l2cap_le_52("L2CAP Ext-Flowctl Server - Set PHY Coded",
+				&ext_flowctl_server_set_phy_coded_test,
+				setup_powered_server, test_server);
 
 	test_l2cap_le("L2CAP LE ATT Client - Success",
 				&le_att_client_connect_success_test_1,
-- 
2.52.0

