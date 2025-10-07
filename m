Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959033A1D2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876345; cv=none; b=ENVgMS1cAZJh0uGtx732gmyp8PlZjGUcuqR7661EL1XU1EPJ0v5exhd5PjeFtXYpZAYw9VHmbYmB7bkhavKajfZ+Zp7/OzliOl/6iPE7bqPQ5GQ9w+rjb6LSMOKKDmJnexHQm+SqwPVeHo4f2Au+/FKz2+jLpRw0/PzVM7UeVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876345; c=relaxed/simple;
	bh=Rnf3ixJYLmYH3ak8lq+WxR2Lm5/OINZo3EyhClmtkt8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4Q69CWZmolsCo4/u+FWjtgCVXo2ICrjlYXZSP0JFAdmSZhziw3hqLBtXrtqbnLTm9z/fzcZ424XQAUmuZgeLtezt+ZrHdGW7UbjPEjr2qp4Ev4XK4/TLF3kl5qw2mysYm7DpLynA5Vs+yXDfmOxLHegalo+GCxCFvLvzFVdzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi7ydkzZ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi7ydkzZ"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d4018cb45fso3014575137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759876342; x=1760481142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2vvWmSsFqFxIrp/OGyrTp81ndaqIGu30fgcruBwND0=;
        b=Yi7ydkzZKt6kyBsUTwFdiDulYpYI9NZcmwdF6LkaUsDX0RhLIfHWy+W4BnJKki+W2r
         wsUZSTtth+tz31SeMudefxBiZqf1AS7/JzPrNxe3j7UX9jsLtCxUD1sF+eHdvPmP31kZ
         MZyw05xHcrp7Uun6CI6amooAKyiMEFK/5MM0X3+ApZXLTDI2wt1k6cK5Il7O6dWaZ/IH
         tQBXIqn9OIHkqExTePfi4FHPLs4P/LVMZjeDCwZrwT0j9kwEcepoQM2+1wsbfRU6xIVb
         1CoqXk/iPOpKfgChK0v6NuQns3XGyPjqp43LdC8LxNFKW0aHWGtXTOWURiPhkWKiC9fD
         Q57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876342; x=1760481142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2vvWmSsFqFxIrp/OGyrTp81ndaqIGu30fgcruBwND0=;
        b=A9wzWzFIRjGKWGZggZuoYNq0TGqkXfImR2yZ9FoKzpsR9zSR6Zgc1c38BPuqQ/DUcz
         IsPhdGCx/NUhwYpSCvDWEVNDs1LybVbaWhJFDlywBjHXAJMrsgScRivMz8LNIZIaZkZe
         bKsIeHNZhrqiJFOt7NCiQX1APzJ71MBCBfDIyor9FA77wFzWa6AzvsuIoGZB73qxYTDW
         o/3rem5kgaZF9Ukmz8uc1iGEcOj8YdxUjsAqhc4GEE48y7NI/oa3nsgzyXp6xbH5PtYJ
         jrNSNzZTDHqUXxK9jxr6rxsSJI3s29maXDcPUI5fLHfBWtZHoDbbwmHJMffcW2MwP7BO
         J6uw==
X-Gm-Message-State: AOJu0YysVH/VARuHc44NBfgSGk/GV9IWR2PORT9yjino7kI7/4hPnekY
	oyZ33vtC2QkpOgvUIMms83o/E2SR+e4HekYwY+Oafvw957vgMSL0Lmv+2X8dyDfS
X-Gm-Gg: ASbGnctOvuezj8b6subhLSI/BxZgGmXa8WluDz7qhQxYVb7600L+OvRdFIviJeRbbTT
	u/DuCnUwWsM2gbG60b5Ev7Zo2ftBZTLv35Sv0bHPSo/y6K/ru21NyyJKPmnH0bwiPWD42+cibmk
	a3TO/VctlbkXSt6l85dSlagBCNwoZo+8KBq4gWJ7w8+9/QIvcYiPf2y8o2Kg0Q+VIQSrcfThH8o
	kbxkKx9ndC5FqaglUzmPa4SYJT4QiA/j6QmWY6FzE5BIQK3dXaoIxjJ/o2MqQTXSSWmz9h0dk/9
	30mwZfwTsjUOsb7e3aMhLBopHK7kEOgg+KFtm6LLhMjmNR7L7uUnlqFhNj97gD6q5Q6B9DfX7aj
	MbeIRQVluspAAqIDHLqIxAStj2UYhARiWC4k40S9EPQ3oy5DOI0ZdjzyabyUVHz6d3VECii6XZF
	LPPPs9creMasmv9pB1mebyPBdi
X-Google-Smtp-Source: AGHT+IFfo7Zq68n5O+C8+ZKHV3t2QuVCzdBbBEzWNVPoKplWx6yFts2NbotVQw7GGMKXkwre1dfz0Q==
X-Received: by 2002:a05:6102:dcf:b0:533:ff66:698c with SMTP id ada2fe7eead31-5d5e22162camr551580137.2.1759876341743;
        Tue, 07 Oct 2025 15:32:21 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4da21c3sm3859567241.7.2025.10.07.15.32.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:32:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/8] Bluetooth: MGMT: Allow use of Set Device Flags without Add Device
Date: Tue,  7 Oct 2025 18:31:53 -0400
Message-ID: <20251007223155.1539954-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007223155.1539954-1-luiz.dentz@gmail.com>
References: <20251007223155.1539954-1-luiz.dentz@gmail.com>
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

