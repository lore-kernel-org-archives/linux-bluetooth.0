Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9292E228D
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848597; cv=none; b=fhF1lniF1KjdXSZlqrDT9j8kluxMiiRNkeqLSYYF8mzMzfdnZhqogbima2BWtgEsKusJc8i6WOQygGaYUh1EJqjBKgdwcXK0GPWL54Up67ZahoeQQR/AiSi3Psfa02d43ns614GHxYwM6mjFIXt6NwITsz+Ii4+uluUs3QQLl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848597; c=relaxed/simple;
	bh=Rnf3ixJYLmYH3ak8lq+WxR2Lm5/OINZo3EyhClmtkt8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyKy+dQDI3c/kXJGpHOjmPxQO3cKpZuHnw52y/P7wJbKV7P0cMSWUvwf23LHXt851xPPAC7li22IQkykVCH3vYphUkpTdanxz46LYx9pdUUywaIkNcV0p4KppyVOLUp9ZPVyKzDdfRrOZCzLqeqBMP1PQlyBx7Wg0TgK8+cnUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAbenNRg; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAbenNRg"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so3301104e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848594; x=1760453394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2vvWmSsFqFxIrp/OGyrTp81ndaqIGu30fgcruBwND0=;
        b=lAbenNRgW8VSbgrKD7hc5yG/qOGrVUYdHU9RXO/2FYaSu8eSjdVCimb8r54etHefQl
         yUu/jZDp5kOwEEUu2D5beKQscA0mvtYwMpN8AtlmXbMfw4Mg+SOqXvWZmDzzzsD/jCWt
         Mmbj687+0yB2JytUJU7m+prrC1brNZXyzX6PIRLB6pgp+IXj3BtUXP3gHJJQCdgqcjL0
         f304285joI72LCMupmBdwlWoUvGFx+Mfq/BJ/0qUKBhE9C232gme6KWsApXb2Shot7B7
         S+eKM4IbTpaajkCq38UDFkJC8EXcF/W8IfjgomqbU0YYVFOLRtZ4Dz3CzZGXcCpG6yzn
         IdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848594; x=1760453394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2vvWmSsFqFxIrp/OGyrTp81ndaqIGu30fgcruBwND0=;
        b=rZHAlWr0OU/hxnbUhnWsCFC1FUPUiegBVTkneloVKsAwsa+6RSEmTrUuG1zEJkCFFD
         ZFVwzZLnttDCANZ/P0jQY9SV/bvO8N9ou8Pefz1JlQv+NDb91TNpmmbzRlQXQSx3Yj5S
         NO9W/qKT212Y356jnXuJgkxldVhpdxSpz9EMyuoueZxs9m9hoVpRNFZN7jubQZiAVcPc
         9Xw7Ln/fA9PQAe2bba7H3Tlq9L5n5i2MriQjtzG6Hbgu8cXrAatuWtnKY4pQ+dvnLPLj
         JTtAbFcrM+RI1syzb21Vgw3ajtZXQyV9blkIK51h66Vlrz4KXw9ZWzNA8srSXIbj8dOH
         XYdA==
X-Gm-Message-State: AOJu0YynRfnfrLool6wnGLm6wcnR7nNCEIbAOzjy3HUcmymfTWxEvE8e
	90rCycRDRM4NtQ8ACoY0eAKj0zUOnCOjjM9Fyhc00ZR+wPA76R0XrSqfyvKOhA==
X-Gm-Gg: ASbGncvJuYQnQV7R5+jaBDtiQmtAniOEtlXHt/D9c/Me78upBr25PZUm5o63aruP1J+
	Qi16W1pjuZIAUtudeAGcdDf/gK4xY0EkseCsO20gFRYshEy6+P5bgdzPqS/GlDE0Xln40jO5oqS
	veK+bW+fjfwGXP/zHMWXBE3mdNl9jA1QPbHF9AiTzcLw8y1Ix3wO4IJWctvrddtIGRHdneKhF6u
	OqTIGQp1i4OPv0ffT9AeH5THPWNrRjfh5dSqLQavce5wnxbql4CLcE7EwR3siUZckLbWBtBYvxe
	eqhdUGlgRMnhgowYg5dMRt8SwKktCazwGqSBVsUuF9fwt3bcZd/7noNseZvgFnVh/XvhaCrMvfU
	qs/tc4RkP2q4sCtk6BQCqNpU7MgqTsUzGJZEu3stqh17id3/RIgDEJrrykRLJFy8FlKYHxlc7AO
	spQz4ZBAiHZdAQBg==
X-Google-Smtp-Source: AGHT+IEjiH96PSR5dkezIpHhniNO+WgxNN7DUOdQny8k9dqAAB9z+fUSza8Br3HnhjjxN6J4HYEY2A==
X-Received: by 2002:a05:6122:1349:b0:54a:a251:ad57 with SMTP id 71dfb90a1353d-5524eb1cfe8mr6165429e0c.16.1759848593537;
        Tue, 07 Oct 2025 07:49:53 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce64af0sm3731864e0c.8.2025.10.07.07.49.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:49:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/7] Bluetooth: MGMT: Allow use of Set Device Flags without Add Device
Date: Tue,  7 Oct 2025 10:49:29 -0400
Message-ID: <20251007144930.1378274-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007144930.1378274-1-luiz.dentz@gmail.com>
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In certain cases setting devices flags like HCI_CONN_FLAG_PAST it
shouldn't require to do Add Device first since it may not need to add
an auto-connect policy, so this instead just automatically creates
a hci_conn_params if one cannot be found using HCI_AUTO_CONN_DISABLED.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 148 ++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4b7cab707d69..02d52b413abf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5118,6 +5118,69 @@ static void device_flags_changed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_FLAGS_CHANGED, hdev, &ev, sizeof(ev), sk);
 }
 
+static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+	if (!conn)
+		return false;
+
+	if (conn->dst_type != type)
+		return false;
+
+	if (conn->state != BT_CONNECTED)
+		return false;
+
+	return true;
+}
+
+/* This function requires the caller holds hdev->lock */
+static struct hci_conn_params *hci_conn_params_set(struct hci_dev *hdev,
+						   bdaddr_t *addr, u8 addr_type,
+						   u8 auto_connect)
+{
+	struct hci_conn_params *params;
+
+	params = hci_conn_params_add(hdev, addr, addr_type);
+	if (!params)
+		return NULL;
+
+	if (params->auto_connect == auto_connect)
+		return params;
+
+	hci_pend_le_list_del_init(params);
+
+	switch (auto_connect) {
+	case HCI_AUTO_CONN_DISABLED:
+	case HCI_AUTO_CONN_LINK_LOSS:
+		/* If auto connect is being disabled when we're trying to
+		 * connect to device, keep connecting.
+		 */
+		if (params->explicit_connect)
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
+		break;
+	case HCI_AUTO_CONN_REPORT:
+		if (params->explicit_connect)
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
+		else
+			hci_pend_le_list_add(params, &hdev->pend_le_reports);
+		break;
+	case HCI_AUTO_CONN_DIRECT:
+	case HCI_AUTO_CONN_ALWAYS:
+		if (!is_connected(hdev, addr, addr_type))
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
+		break;
+	}
+
+	params->auto_connect = auto_connect;
+
+	bt_dev_dbg(hdev, "addr %pMR (type %u) auto_connect %u",
+		   addr, addr_type, auto_connect);
+
+	return params;
+}
+
 static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 len)
 {
@@ -5161,9 +5224,16 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 					le_addr_type(cp->addr.type));
 	if (!params) {
-		bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
-			    &cp->addr.bdaddr, le_addr_type(cp->addr.type));
-		goto unlock;
+		/* Create a new hci_conn_params if it doesn't exist */
+		params = hci_conn_params_set(hdev, &cp->addr.bdaddr,
+					     le_addr_type(cp->addr.type),
+					     HCI_AUTO_CONN_DISABLED);
+		if (!params) {
+			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
+				    &cp->addr.bdaddr,
+				    le_addr_type(cp->addr.type));
+			goto unlock;
+		}
 	}
 
 	supported_flags = hdev->conn_flags;
@@ -7550,68 +7620,6 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
-{
-	struct hci_conn *conn;
-
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
-	if (!conn)
-		return false;
-
-	if (conn->dst_type != type)
-		return false;
-
-	if (conn->state != BT_CONNECTED)
-		return false;
-
-	return true;
-}
-
-/* This function requires the caller holds hdev->lock */
-static int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr,
-			       u8 addr_type, u8 auto_connect)
-{
-	struct hci_conn_params *params;
-
-	params = hci_conn_params_add(hdev, addr, addr_type);
-	if (!params)
-		return -EIO;
-
-	if (params->auto_connect == auto_connect)
-		return 0;
-
-	hci_pend_le_list_del_init(params);
-
-	switch (auto_connect) {
-	case HCI_AUTO_CONN_DISABLED:
-	case HCI_AUTO_CONN_LINK_LOSS:
-		/* If auto connect is being disabled when we're trying to
-		 * connect to device, keep connecting.
-		 */
-		if (params->explicit_connect)
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-		break;
-	case HCI_AUTO_CONN_REPORT:
-		if (params->explicit_connect)
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-		else
-			hci_pend_le_list_add(params, &hdev->pend_le_reports);
-		break;
-	case HCI_AUTO_CONN_DIRECT:
-	case HCI_AUTO_CONN_ALWAYS:
-		if (!is_connected(hdev, addr, addr_type))
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-		break;
-	}
-
-	params->auto_connect = auto_connect;
-
-	bt_dev_dbg(hdev, "addr %pMR (type %u) auto_connect %u",
-		   addr, addr_type, auto_connect);
-
-	return 0;
-}
-
 static void device_added(struct sock *sk, struct hci_dev *hdev,
 			 bdaddr_t *bdaddr, u8 type, u8 action)
 {
@@ -7723,17 +7731,13 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
 	 */
-	if (hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type,
-				auto_conn) < 0) {
+	params = hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type,
+				     auto_conn);
+	if (!params) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 					MGMT_STATUS_FAILED, &cp->addr,
 					sizeof(cp->addr));
 		goto unlock;
-	} else {
-		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
-						addr_type);
-		if (params)
-			current_flags = params->flags;
 	}
 
 	cmd = mgmt_pending_new(sk, MGMT_OP_ADD_DEVICE, hdev, data, len);
-- 
2.51.0

