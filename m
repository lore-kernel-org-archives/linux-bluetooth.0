Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A021D278D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785621; cv=none; b=NFJD7wFdDEvhCQq0ejpY8sJK16nNDyxreV1XjcE0PnHQ5i/thEiqjEtR1QgZoiPL5YUkW/B5qPplcdhSWpLblgywyKiKvAXwy7pDvZMLyBSvAwYESRBDj/sguC/ofHfe4XB/afNIktdqsHVfDm3zclTEplBldlau5mww+Z4B170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785621; c=relaxed/simple;
	bh=P9UYFIm0r4hMTwWWB9cWRZjjSgXz2ITdgIOgMooOwvw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T7zX7zjLSShH/B7TQw1wqruf7QJSihxQDdtSbUZ6I+8ZrhZEjH/tZOychV3A/eIjr7G0G2uXXKJlVWJ09Vhexvw/DG923MgSTHI84g9uDuIaHXeGpAm7ILghaVz9BK4e5irdLOiE+qHqKWWPPNkzf/+0mw2Ce1wI9WUnHwOlphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZNJafxp; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZNJafxp"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5b22f97b7so6211143eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724785618; x=1725390418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ei8wPc+vZHo1/MEG4WE7GCMxNufKRbLT+Ky/Z6kQ/ao=;
        b=KZNJafxp2t/1EXluy62En4R/MvoUhmxMPdOT9n3SosdDLVSWJwCYdzQ6py4AyKFH0C
         ItxlZq7WFNzcnld3Q8i+/JllVf4Ep6KNvcTo4ikvO/9Xm9q3xFuXvNDuaV2bnm7wWn58
         WHyIE5hqrYjEla4hmuR7IQH6yllUgzG5i1/SEA84hRHVNXYRspTwC+dz1QPzcOIZNUDD
         uLUj3VKbz/MVFZ9I8UWGBVVOyYwUGUirv33azN+TEWChpNcaYWJtjdR8gBHNNzekprZv
         JQWly6xII7TF/LGTBQgqCR7fnMSuSDdd4PH561seO7Yx5yNRT2h6qzuvpaAJ8V1tW3oo
         9HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785618; x=1725390418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ei8wPc+vZHo1/MEG4WE7GCMxNufKRbLT+Ky/Z6kQ/ao=;
        b=B+DLG3tIHjxLqkvkEFzs1gAz7ElMcIXG7OUsflDB/1g/8xcUYQ79mz02AYW4hkKRMR
         Gcyyf6uIFtcMJGdWsWuVuHvyWXnLMI3Ste3IeDfZu6Rrkg2iOgetzs+JaE+tQjZ1QKaO
         u5hvLtBHc96Qhz+piuee/WBWlViu30VCa39R39Wslu9QIb0KfhwuD6vQntWRxR1VWQHx
         75sjq5VknBpIjyb3zxIxEEzNDz9+e1cX7ADOKWBQ55O1XvIXtA0MXgCzN9eTsFFe9vau
         3JrsXSpvbW+ByyGcqmVjnWDYPwKZeJ5IrN3v60PuHFR/jguaZaXSSYdN0mM80VW+fzIH
         HM9Q==
X-Gm-Message-State: AOJu0YyzJGljHN8YJNrvP8QaWXdX75dWDogo0w1DFpuJE3LJgs6Bbr89
	9hyZU3Vrlj4g48obXac/BlrJpoJIJNGWzKkEeVWHZL3AQ3fKyycOS4032A==
X-Google-Smtp-Source: AGHT+IGDLFF5taNWWWihlESpAh/wyyomQv1TbUefo0NwhVLwlsoxyZ1LofxEb9OQHJxIELpcQ3OSDA==
X-Received: by 2002:a05:6358:2486:b0:1b5:968f:e221 with SMTP id e5c5f4694b2df-1b5c3a3b6a8mr1683961755d.2.1724785617526;
        Tue, 27 Aug 2024 12:06:57 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce4da5d6sm1395092241.4.2024.08.27.12.06.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:06:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
Date: Tue, 27 Aug 2024 15:06:54 -0400
Message-ID: <20240827190655.675179-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts commit 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 which
breaks compatibility with commands like:

bluetoothd[46328]: @ MGMT Command: Load.. (0x0013) plen 74  {0x0001} [hci0]
        Keys: 2
        BR/EDR Address: C0:DC:DA:A5:E5:47 (Samsung Electronics Co.,Ltd)
        Key type: Authenticated key from P-256 (0x03)
        Central: 0x00
        Encryption size: 16
        Diversifier[2]: 0000
        Randomizer[8]: 0000000000000000
        Key[16]: 6ed96089bd9765be2f2c971b0b95f624
        LE Address: D7:2A:DE:1E:73:A2 (Static)
        Key type: Unauthenticated key from P-256 (0x02)
        Central: 0x00
        Encryption size: 16
        Diversifier[2]: 0000
        Randomizer[8]: 0000000000000000
        Key[16]: 87dd2546ededda380ffcdc0a8faa4597
@ MGMT Event: Command Status (0x0002) plen 3                {0x0001} [hci0]
      Load Long Term Keys (0x0013)
        Status: Invalid Parameters (0x0d)

Cc: stable@vger.kernel.org
Link: https://github.com/bluez/bluez/issues/875
Fixes: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  5 -----
 net/bluetooth/mgmt.c             | 25 +++++++------------------
 net/bluetooth/smp.c              |  7 -------
 3 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e449dba698f3..1a32e602630e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -186,7 +186,6 @@ struct blocked_key {
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 link_type;
 	u8 type;
 	u8 val[16];
 };
@@ -196,7 +195,6 @@ struct smp_ltk {
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 link_type;
 	u8 authenticated;
 	u8 type;
 	u8 enc_size;
@@ -211,7 +209,6 @@ struct smp_irk {
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
-	u8 link_type;
 	u8 val[16];
 };
 
@@ -219,8 +216,6 @@ struct link_key {
 	struct list_head list;
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
-	u8 bdaddr_type;
-	u8 link_type;
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4c20dbf92c71..240dd8cf7c7d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2833,8 +2833,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
-		/* Considering SMP over BREDR/LE, there is no need to check addr_type */
-		if (key->type > 0x08)
+		if (key->addr.type != BDADDR_BREDR || key->type > 0x08)
 			return mgmt_cmd_status(sk, hdev->id,
 					       MGMT_OP_LOAD_LINK_KEYS,
 					       MGMT_STATUS_INVALID_PARAMS);
@@ -7089,7 +7088,6 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
-		u8 addr_type = le_addr_type(irk->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_IRK,
@@ -7099,12 +7097,8 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			continue;
 		}
 
-		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
-		if (irk->addr.type == BDADDR_BREDR)
-			addr_type = BDADDR_BREDR;
-
 		hci_add_irk(hdev, &irk->addr.bdaddr,
-			    addr_type, irk->val,
+			    le_addr_type(irk->addr.type), irk->val,
 			    BDADDR_ANY);
 	}
 
@@ -7185,7 +7179,6 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type, authenticated;
-		u8 addr_type = le_addr_type(key->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_LTK,
@@ -7220,12 +7213,8 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			continue;
 		}
 
-		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
-		if (key->addr.type == BDADDR_BREDR)
-			addr_type = BDADDR_BREDR;
-
 		hci_add_ltk(hdev, &key->addr.bdaddr,
-			    addr_type, type, authenticated,
+			    le_addr_type(key->addr.type), type, authenticated,
 			    key->val, key->enc_size, key->ediv, key->rand);
 	}
 
@@ -9519,7 +9508,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
+	ev.key.addr.type = BDADDR_BREDR;
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
@@ -9570,7 +9559,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -9599,7 +9588,7 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(irk->link_type, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
@@ -9628,7 +9617,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(csrk->link_type, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4f9fdf400584..8b9724fd752a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1060,7 +1060,6 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
-		smp->remote_irk->link_type = hcon->type;
 		mgmt_new_irk(hdev, smp->remote_irk, persistent);
 
 		/* Now that user space can be considered to know the
@@ -1080,28 +1079,24 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->csrk) {
-		smp->csrk->link_type = hcon->type;
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
 	if (smp->responder_csrk) {
-		smp->responder_csrk->link_type = hcon->type;
 		smp->responder_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
 	}
 
 	if (smp->ltk) {
-		smp->ltk->link_type = hcon->type;
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
 	if (smp->responder_ltk) {
-		smp->responder_ltk->link_type = hcon->type;
 		smp->responder_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
@@ -1121,8 +1116,6 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
 				       smp->link_key, type, 0, &persistent);
 		if (key) {
-			key->link_type = hcon->type;
-			key->bdaddr_type = hcon->dst_type;
 			mgmt_new_link_key(hdev, key, persistent);
 
 			/* Don't keep debug keys around if the relevant
-- 
2.46.0

