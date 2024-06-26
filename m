Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59E18A92A
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414158; cv=none; b=PwnK+Iy7u2blRd3yYxUlXmiket/iXsBmVxxSp/YLTjFUdnnUfKNCyzJDKE1nP+JLVsAg7uYZJMofwUHVwZE2s9Er+VKnMbWR27MURv40h0e303U+Gy1XWrrZ/1K8vgeNHMBM7LZQSsWJfBwEpbNxtbYLsdJp4lKKKm4/kzld6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414158; c=relaxed/simple;
	bh=WwqX7L15Fq+c1Q5yx3SsPTgWNleoDr+ubLQXUolgqDM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRBCoaUNqzXd7vkX4vsgrTpfvQS4Yl7Z4+47PgZcRFoHnUe+lcZhEYQNpy5DpN7BzxZI8Hq4ZCjiVQ0e4Q3LQHckoitlvSn3RGy9TUo13NUEbt/v4HsUPgMoNgwDmZL9Otn8Ytl+E61jyRCNb4VxUTqOhM5GfdftOZCRTLn75fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el3u6PB7; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el3u6PB7"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48f4cef1ea5so1266133137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719414156; x=1720018956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5isFdIVM8mV96ILq2nIbsSV5yhFrRvXtbiyDi/DtQs=;
        b=el3u6PB7Xg+rxbF5KrDousVRfrYkPkw+932taZcrJHfKVBTwr4ZLP0MzBefr2W6cDu
         DdeajIiD1OWq3JEaBz4HPQGDui8F4ebreET0u2Pinz1C83sQp/GY3oOIOk9Orp/PYWb7
         +6Wx+UkgGCxoOz8KNw3JZiLn0obot+bU7PcMsNkMx9yYP8KpEZlQP6ivX+d4zWVF84Sw
         jJas8lPeuCzFrzc/gyHZdwNv+4ZDBhd2xvwszDlHrzmGYNuWaRmhDImUIaqQYcAKaNAl
         /jcuPT2YTcLa3qRyq2WyZozfrN40fkBVY9hrD+FUw5xc+hpY0ijnK5/cyZnxHGwkyoYj
         0nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414156; x=1720018956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5isFdIVM8mV96ILq2nIbsSV5yhFrRvXtbiyDi/DtQs=;
        b=RdqsLAH0LKr1zTvIN9i6LPkRCRPS6Mqje99TWI1rIKarJKBXGTYjRZSk+8Ut4h0rZn
         Y5cSTnXYZURjWA/6NSmtUHpzsj+kzFjnC5YvENiI7If4x7B4hDlhUkbRykd8qYqRobVr
         3LNY0qNjuG+UPEE8VhDS/YhVyy/nk7L/flViHdCMD8jYaH4T5/br1u5xEgoT2Zi15mUx
         xOsj6teli0WVbKK145qRY+aM1yW18QlB9rpLl4RyscjHFVoliOSjwQ+RaoA/jtLhJ9Kl
         z1/RC9G1K2dqqMSgxHcr9ud2YTpmf2igu5m58Yque5+G3jGs8nX8gc9xorj1pgv3uGqs
         9xRQ==
X-Gm-Message-State: AOJu0YyAczJK31oSA+2pR6rzWHW5DCQPLcvL2isalFCOWUD/nXM7YcuL
	yvn+/4+Doa9bJWSY0c7bx1KUcETroOCbTD4qAaJpt+4YRgknxFEH65Q66w==
X-Google-Smtp-Source: AGHT+IGquN/1t8k4txln6F4unFLILtsndab42OjVvMjhctXLFXW7v+wa+jAJAZd6RLpmjwLWbZQu4A==
X-Received: by 2002:a67:bd0f:0:b0:48f:3930:4a82 with SMTP id ada2fe7eead31-48f4f09f918mr8984423137.23.1719414155519;
        Wed, 26 Jun 2024 08:02:35 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48f5cd3cf91sm1203746137.13.2024.06.26.08.02.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:02:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] bthost: Introduce bthost_add_l2cap_server_custom
Date: Wed, 26 Jun 2024 11:02:28 -0400
Message-ID: <20240626150229.103047-2-luiz.dentz@gmail.com>
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

This introduces bthost_add_l2cap_server_custom which can be used to
define custom values for MTU, MPS and credits.
---
 emulator/bthost.c | 29 ++++++++++++++++++++++-------
 emulator/bthost.h |  5 +++++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index d69e3d34ea3c..cc9bf7240531 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -195,6 +195,9 @@ struct l2cap_pending_req {
 
 struct l2cap_conn_cb_data {
 	uint16_t psm;
+	uint16_t mtu;
+	uint16_t mps;
+	uint16_t credits;
 	bthost_l2cap_connect_cb func;
 	bthost_l2cap_disconnect_cb disconn_func;
 	void *user_data;
@@ -2164,14 +2167,13 @@ static bool l2cap_le_conn_req(struct bthost *bthost, struct btconn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	rsp.mtu = 23;
-	rsp.mps = 23;
-	rsp.credits = 1;
-
 	cb_data = bthost_find_l2cap_cb_by_psm(bthost, psm);
-	if (cb_data)
+	if (cb_data) {
 		rsp.dcid = cpu_to_le16(conn->next_cid++);
-	else
+		rsp.mtu = cpu_to_le16(cb_data->mtu) ? : cpu_to_le16(23);
+		rsp.mps = cpu_to_le16(cb_data->mps) ? : cpu_to_le16(23);
+		rsp.credits = cpu_to_le16(cb_data->credits) ? : cpu_to_le16(1);
+	} else
 		rsp.result = cpu_to_le16(0x0002); /* PSM Not Supported */
 
 	l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_LE_CONN_RSP, ident, &rsp,
@@ -3511,7 +3513,8 @@ uint64_t bthost_conn_get_fixed_chan(struct bthost *bthost, uint16_t handle)
 	return conn->fixed_chan;
 }
 
-void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
+void bthost_add_l2cap_server_custom(struct bthost *bthost, uint16_t psm,
+				uint16_t mtu, uint16_t mps, uint16_t credits,
 				bthost_l2cap_connect_cb func,
 				bthost_l2cap_disconnect_cb disconn_func,
 				void *user_data)
@@ -3523,6 +3526,9 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 		return;
 
 	data->psm = psm;
+	data->mtu = mtu;
+	data->mps = mps;
+	data->credits = credits;
 	data->user_data = user_data;
 	data->func = func;
 	data->disconn_func = disconn_func;
@@ -3531,6 +3537,15 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 	bthost->new_l2cap_conn_data = data;
 }
 
+void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
+				bthost_l2cap_connect_cb func,
+				bthost_l2cap_disconnect_cb disconn_func,
+				void *user_data)
+{
+	bthost_add_l2cap_server_custom(bthost, psm, 0, 0, 0, func,
+					disconn_func, user_data);
+}
+
 void bthost_set_sc_support(struct bthost *bthost, bool enable)
 {
 	struct bt_hci_cmd_write_secure_conn_support cmd;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 0c488e32afd0..2c5b0d5164cc 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -136,6 +136,11 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 				bthost_l2cap_connect_cb func,
 				bthost_l2cap_disconnect_cb disconn_func,
 				void *user_data);
+void bthost_add_l2cap_server_custom(struct bthost *bthost, uint16_t psm,
+				uint16_t mtu, uint16_t mps, uint16_t credits,
+				bthost_l2cap_connect_cb func,
+				bthost_l2cap_disconnect_cb disconn_func,
+				void *user_data);
 
 void bthost_set_sc_support(struct bthost *bthost, bool enable);
 
-- 
2.45.2

