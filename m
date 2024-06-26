Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4B18A946
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414161; cv=none; b=RiJvrRqZANoOIRNPmGTAe6cxsd5WM6A9C1AOysfqUb0k9ciKxYcLqiJdyToRSUAP/rOCeZGnE3J1jpcU5Lk4loFtJJ8/YkWFSanywS6Z6V5ghk/ud9xWjNyHYXz5VTA4fZjAwTjfYfDrRV5yIaKRxt7j7pCI70byNHdFuGOS4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414161; c=relaxed/simple;
	bh=JvRCmKudBZp8osyME6STdiyD9IPied7S/MLT0sqQwpA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Benm9eEY/HwAO1xB9pilTvdySYwZj+Qid2sEhDgGFnB2MV1ZurfXgD2zFNRgyRNCqocWy8QwWkP06ZtRHVt1w2c0Qd/t9NTZ4A+Wm4XZtDaBkfNHABbLYHNoiaUsX/5woFF+Vm3JapzqRV+2ewqtPWD+mj9b7+jBiW4jtO4UITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5Fa9ymO; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5Fa9ymO"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48f68565fe0so961022137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719414157; x=1720018957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udenrX245c88FgPuipcNos5kkd8VDEbmhpRG68qOaoo=;
        b=B5Fa9ymOQ4TRadnTR68ACAyeOeS+7LpitrEkfXLBczYIP3gBuSA/mRxNqdnVtu+buh
         qezuI9mX1zxJAzJCC3xH7eMBjlUOBEoQRLV1o8XQXYMRDHYrJaJyD/qNB7sWwKs5eRyW
         Bl7elA2Ai0UOoIeyqS5TGf04d0TNx/LjdZlbBq7iQlMytmd3Ah/X8eGCPbJRt4g0Kev0
         NP4dpiYdDU3f8FlODcumzW+xT3+dGp+YTUjd5VpkJfkV7HaW3CBhSZpWMwxb3yZ1Hv7Y
         V5KyUAJo+//7shYH041jJKTAgSWlXLJYf8hyOGxWOruwsN9LmOpiwIoX5VR+4xucxVzw
         7+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414157; x=1720018957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udenrX245c88FgPuipcNos5kkd8VDEbmhpRG68qOaoo=;
        b=W0MyKeyEDdpZ3fic9a4L5Q5NrIEpambp2y0PKxNLQBxO5bYUgd7ftH4xSyL59Or3Ph
         /hkmO3GJ7XdG2QSpS+5/XwQU/ebJI1v6BrAXRb5G4UA8TB2u/0fVrvHOU7gG5E5eXp+X
         xjtHpcjDv1nmwoPeQNgK8erbRGSnnIVcDejs+X2+jdUdafRjM0SgF6RowEL2Jc4LUf0U
         eZlNxDAPkzOcAkpRefpfJCbgW5jaddKkbDjNM0l4jxGaVvohDlVBXFwSRJYjrtHatxaA
         7PZa+BKCRVs1om80/MRTVUSUcBDjYNI8wcSZAogOjSmLttc6aCvaIXgoewbc0hmZxG9+
         aNqQ==
X-Gm-Message-State: AOJu0YzwLSItylgS/A+gXjYUb88dz8+btOcGl5Nty9asYA7SWAbZJqfH
	oVybeiDks47LjEKBJpoUY6PUdadhuEm4xvtr9WSVVZE6Mub9V37lgZyB4w==
X-Google-Smtp-Source: AGHT+IEhpfejsu3sKqpvp8AesYkIVs1cSG3AHXg88tLi0LTMykwbfWRzzstHVxWjWh8o5ADPeJi2OA==
X-Received: by 2002:a05:6102:41a8:b0:48f:3c66:5347 with SMTP id ada2fe7eead31-48f52a43d43mr12956491137.9.1719414157449;
        Wed, 26 Jun 2024 08:02:37 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48f5cd3cf91sm1203746137.13.2024.06.26.08.02.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:02:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] l2cap-tester: Add tests for multiple data packets over LE
Date: Wed, 26 Jun 2024 11:02:29 -0400
Message-ID: <20240626150229.103047-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626150229.103047-1-luiz.dentz@gmail.com>
References: <20240626150229.103047-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests which cover the TX/RX of multiple
packets (up to 32K) over LE credit based flow control:

L2CAP LE Client - Read 32k Success
L2CAP LE Client - Write 32k Success
---
 tools/l2cap-tester.c | 66 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index b6b879407115..e1487bc7fd75 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -58,6 +58,9 @@ struct l2cap_data {
 	uint16_t server_psm;
 	uint16_t cid;
 	uint8_t mode;
+	uint16_t mtu;
+	uint16_t mps;
+	uint16_t credits;
 	int expect_err;
 	int timeout;
 
@@ -545,6 +548,22 @@ static const struct l2cap_data le_client_connect_read_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_data le_client_connect_read_32k_success_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mtu = 672,
+	.mps = 251,
+	/* Given enough credits to complete the transfer without waiting for
+	 * more credits.
+	 * credits = round_up(data size / mtu) * round_up(mtu / mps)
+	 * credits = 49 * 3
+	 * credits = 147
+	 */
+	.credits = 147,
+	.read_data = l2_data_32k,
+	.data_len = sizeof(l2_data_32k),
+};
+
 static const struct l2cap_data le_client_connect_write_success_test = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -552,6 +571,22 @@ static const struct l2cap_data le_client_connect_write_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_data le_client_connect_write_32k_success_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mtu = 672,
+	.mps = 251,
+	/* Given enough credits to complete the transfer without waiting for
+	 * more credits.
+	 * credits = round_up(data size / mtu) * round_up(mtu / mps)
+	 * credits = 49 * 3
+	 * credits = 147
+	 */
+	.credits = 147,
+	.write_data = l2_data_32k,
+	.data_len = sizeof(l2_data_32k),
+};
+
 static const struct l2cap_data le_client_connect_tx_timestamping_test = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -1278,6 +1313,10 @@ static bool check_mtu(struct test_data *data, int sk)
 					strerror(errno), errno);
 			return false;
 		}
+
+		/* Take SDU len into account */
+		data->l2o.imtu -= 2;
+		data->l2o.omtu -= 2;
 	} else {
 		/* For non-LE CoC enabled kernels we need to fall back to
 		 * L2CAP_OPTIONS, so test support for it as well */
@@ -1673,9 +1712,20 @@ static void test_connect(const void *test_data)
 		if (l2data->shut_sock_wr)
 			host_disconnect_cb = client_l2cap_disconnect_cb;
 
-		bthost_add_l2cap_server(bthost, l2data->server_psm,
-					host_connect_cb, host_disconnect_cb,
-					data);
+		if (l2data->mtu || l2data->mps || l2data->credits)
+			bthost_add_l2cap_server_custom(bthost,
+							l2data->server_psm,
+							l2data->mtu,
+							l2data->mps,
+							l2data->credits,
+							host_connect_cb,
+							host_disconnect_cb,
+							data);
+		else
+			bthost_add_l2cap_server(bthost, l2data->server_psm,
+							host_connect_cb,
+							host_disconnect_cb,
+							data);
 	}
 
 	if (l2data->direct_advertising)
@@ -2534,11 +2584,17 @@ int main(int argc, char *argv[])
 				&le_client_connect_timeout_test_1,
 				setup_powered_client, test_connect_timeout);
 	test_l2cap_le("L2CAP LE Client - Read Success",
-					&le_client_connect_read_success_test,
-					setup_powered_client, test_connect);
+				&le_client_connect_read_success_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE Client - Read 32k Success",
+				&le_client_connect_read_32k_success_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE Client - Write Success",
 				&le_client_connect_write_success_test,
 				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE Client - Write 32k Success",
+				&le_client_connect_write_32k_success_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE Client - TX Timestamping",
 				&le_client_connect_tx_timestamping_test,
 				setup_powered_client, test_connect);
-- 
2.45.2

