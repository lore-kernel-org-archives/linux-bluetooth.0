Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACB25D21E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753724; cv=none; b=XzA9zbhuFoy2fl5ZQA5M5WT+4Ki1pBaPBdovD7cuLbB8z8DLT/nf3LDI5RpzrtwHfbL1Mab4uydwLGKPFPG0FFLTvZsS1JgM8z641BUiIsqvvSBZGByy1UZD01fiCUN3wcA5XiI1gHCxPQlVUzHRgs47lfc432NENmwqI33TZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753724; c=relaxed/simple;
	bh=HGwTOsm2pmkH3S8KdhDzC+KzOmB+RwMKncrzfKZkdEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKazFyhEVIyGnxJ9usxHRoquoGWQLfWtnRyMlRy2+PbTjluZX1HTPNBveuJDITM0M9/IIRBpQdnFX9g5b60+0L7Rh/kz7hgA+2baJ1vawawGvSt4sVCWdyds9Hy+uS4pH1qAjXqq12TecDubVtK+JCv2TV3pYAMUiuH2qH/WO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TftrYx2z; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TftrYx2z"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523fa0df55dso101851e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753720; x=1745358520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8/c1nUAScTYM19SpkZa9AtZQSFDjTJZDZxiF72dZCo=;
        b=TftrYx2ziJcc9Ggz9o1BoVu/mJM65ibCp818kNXPTIbOCJCM0IEW+L1rGiVsyanR62
         h8gjioBlCJWHDH11/sFbHeBf6FuYZ6tmanrgw2yc8eBV/wlI/0zC6f+8QWXVOWLyJbSa
         /xQHkUPQWoillAIUYxnNKpf+51TyjpLeonCetZ/AobVRcxK42V2e8yHznTsZwj8R77q+
         9EcVmZYbde8DK38UCEWhBsfw6nmmOzduoZETddefa1kX8zFeIun4/JScWDwXcX8bJUSl
         hwQJqG2GFxzd16n/wPJUhKUcY1ekVC7AipQ5nG4HGCpQ5pl7Hcg/bxtARTJqZbrJjrHj
         PUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753720; x=1745358520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8/c1nUAScTYM19SpkZa9AtZQSFDjTJZDZxiF72dZCo=;
        b=e3ADajr+n0UNaGqmA11vilFtWsuTBKIbsvgHhWy+Ls5W5j9IhKdU1j8ar6hobXpo54
         w2C3Mf9LkUpxv5dcgJgWMhuhdBGvugRCcUnHYdO0Xio6Ooa/GYzOyt8oBVJxQPv04iz9
         G/F6pfNmb5jwfuM5aJy/IrwxrH5vSVvlRmVKBlxnmClqkrJe9KpY4J4xgyEgcHVdZjEG
         QAtU/0gusq6Mp+OhTa4TPsbWA/Gs3uu3PaZFXqQnLnFjwtaLM3h9vdr/HEaL124QfyHM
         TZ7j5Su+rH5hp/Rx6ubIXyMxNfoF64fUJ8D+OAbTpcrEmvkIL4trj5A8uHczQKwUYWXg
         7Ukw==
X-Gm-Message-State: AOJu0Yymq8JJfvvMun+AlNS6jQhNR1u/xlXBj33PeD+HXtVzlrbMdiM5
	JiKXRq61n1EeT8OByFX5/zgUVXjV+B2UHkHbP77Yo9Vp5YII3IuKs5cq75nGMtw=
X-Gm-Gg: ASbGncun9iHyjAUZyU7IydQqMYTpyCuSx1548y4Mege1lGd7/3NCiB2k2ZdFAxQzPFH
	9VcVlIsZNtje7VP1/tA9v9aIgaRZIfp+J8O9PrscyKdPYHgaMsiT1omG7wkTVHIUCFiSR59HkFM
	v52N4UUrACzXdHwXe05PxAzqf/h68pkdQdlzg5PltDywqCWGGNgOfKA7VfoFRggYYNXl6aJTGu5
	yrCoYrEf06l1LjL+LTLlyuaWjm8OS2a+Q5DMx3fqNipmC+5zd8OBOTOIsE/qIY1aoNUGdmjEkiU
	jOINg6pSS72P3nWG/gNN4YV8xr7eaIrHQQSeGISYAzQvULYXJb2ScE2x0Sx0sEUTPORu7Vv34Ww
	8qvnsogMWrA==
X-Google-Smtp-Source: AGHT+IFm2D2u+BD659aW5yLK4LrIZ5q/QitX9mTLv3yttRpRCJ0P9ofitjF1unGX2mvoPaq19qsBkA==
X-Received: by 2002:a05:6122:3c8a:b0:524:2fe0:61bc with SMTP id 71dfb90a1353d-52908781d27mr1291452e0c.5.1744753719913;
        Tue, 15 Apr 2025 14:48:39 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abd74563sm2859321e0c.11.2025.04.15.14.48.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/3] Bluetooth: ISO: Fix not using SID from adv report
Date: Tue, 15 Apr 2025 17:48:34 -0400
Message-ID: <20250415214835.1678138-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214835.1678138-1-luiz.dentz@gmail.com>
References: <20250415214835.1678138-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Up until now it has been assumed that the application would be able to
enter the advertising SID in sockaddr_iso_bc.bc_sid, but userspace has
not access to SID since the likes of MGMT_EV_DEVICE_FOUND cannot carry
it, so it was left unset (0x00) which means it would be unable to
synchronize if the broadcast source is using a different SID e.g. 0x04:

> HCI Event: LE Meta Event (0x3e) plen 57
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0000
            Props: 0x0000
            Data status: Complete
          Address type: Random (0x01)
          Address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
          Primary PHY: LE 1M
          Secondary PHY: LE 2M
          SID: 0x04
          TX power: 127 dBm
          RSSI: -55 dBm (0xc9)
          Periodic advertising interval: 180.00 msec (0x0090)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1f
        06 16 52 18 5b 0b e1 05 16 56 18 04 00 11 30 4c  ..R.[....V....0L
        75 69 7a 27 73 20 53 32 33 20 55 6c 74 72 61     uiz's S23 Ultra
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 14748507 (0xe10b5b)
        Service Data: Public Broadcast Announcement (0x1856)
          Data[2]: 0400
        Unknown EIR field 0x30[16]: 4c75697a27732053323320556c747261
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00 (<- Invalid)
        Adv address type: Random (0x01)
        Adv address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000

So instead this changes now allow application to set HCI_SID_INVALID
which will make hci_le_pa_create_sync to wait for a report, update the
conn->sid using the report SID and only then issue PA create sync
command:

< HCI Command: LE Periodic Advertising Create Sync
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x04
        Adv address type: Random (0x01)
        Adv address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 64
        Advertising SID: 0x04
        Advertiser address type: Random (0x01)
        Advertiser address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 180.00 msec (0x0090)
        Advertiser clock accuracy: 0x05

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  |  2 ++
 net/bluetooth/hci_core.c  | 13 +++++-----
 net/bluetooth/hci_event.c | 16 +++++++++++-
 net/bluetooth/hci_sync.c  | 51 ++++++++++++++++++++++++++++++++++-----
 net/bluetooth/iso.c       |  9 +++++--
 5 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c3112ce39f67..eed0f3006639 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2070,6 +2070,8 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 
+	bt_dev_dbg(hdev, "dst %pMR type %d sid %d", dst, dst_type, sid);
+
 	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_SLAVE);
 	if (IS_ERR(conn))
 		return conn;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5eb0600bbd03..75da6f6e39c9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4057,10 +4057,13 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	err = hci_send_frame(hdev, skb);
-	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, -err);
-		return;
+	if (hci_skb_opcode(skb) != HCI_OP_NOP) {
+		err = hci_send_frame(hdev, skb);
+		if (err < 0) {
+			hci_cmd_sync_cancel_sync(hdev, -err);
+			return;
+		}
+		atomic_dec(&hdev->cmd_cnt);
 	}
 
 	if (hdev->req_status == HCI_REQ_PEND &&
@@ -4068,8 +4071,6 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
-
-	atomic_dec(&hdev->cmd_cnt);
 }
 
 static void hci_cmd_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea7ccafd055a..97f7c61007b8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6340,6 +6340,17 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 			info->secondary_phy &= 0x1f;
 		}
 
+		/* Check if PA Sync is pending and if the hci_conn SID has not
+		 * been set update it.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
+			struct hci_conn *conn;
+
+			conn = hci_conn_hash_lookup_create_pa_sync(hdev);
+			if (conn && conn->sid == HCI_SID_INVALID)
+				conn->sid = info->sid;
+		}
+
 		if (legacy_evt_type != LE_ADV_INVALID) {
 			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0,
@@ -7147,7 +7158,8 @@ static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
 
 	/* Only match event if command OGF is for LE */
 	if (hdev->req_skb &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 &&
+	   (hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 ||
+	    hci_skb_opcode(hdev->req_skb) == HCI_OP_NOP) &&
 	    hci_skb_event(hdev->req_skb) == ev->subevent) {
 		*opcode = hci_skb_opcode(hdev->req_skb);
 		hci_req_cmd_complete(hdev, *opcode, 0x00, req_complete,
@@ -7503,8 +7515,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	hci_dev_lock(hdev);
 	kfree_skb(hdev->recv_event);
 	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
+	hci_dev_unlock(hdev);
 
 	event = hdr->evt;
 	if (!event) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 99c116b056ce..231aff4d3b3d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6898,20 +6898,37 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct hci_conn *conn = data;
+	struct hci_conn *pa_sync;
+
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (!err)
-		return;
-
-	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-
 	if (err == -ECANCELED)
 		return;
 
 	hci_dev_lock(hdev);
 
-	hci_update_passive_scan_sync(hdev);
+	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
+	if (!hci_conn_valid(hdev, conn))
+		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
+
+	if (!err)
+		goto unlock;
+
+	/* Add connection to indicate PA sync error */
+	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
+				     HCI_ROLE_SLAVE);
+
+	if (IS_ERR(pa_sync))
+		goto unlock;
+
+	set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
+
+	/* Notify iso layer */
+	hci_connect_cfm(pa_sync, bt_status(err));
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -6925,9 +6942,23 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	if (!hci_conn_valid(hdev, conn))
 		return -ECANCELED;
 
+	if (conn->sync_handle != HCI_SYNC_HANDLE_INVALID)
+		return -EINVAL;
+
 	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
 		return -EBUSY;
 
+	/* Stop scanning if SID has been set and active scanning is enabled so
+	 * we use passive scanning which will be scanning using the allow list
+	 * which is programmed to contain only the connection address.
+	 */
+	if (conn->sid == HCI_SID_INVALID &&
+	    hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+		hci_scan_disable_sync(hdev);
+		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	}
+
 	/* Mark HCI_CONN_CREATE_PA_SYNC so hci_update_passive_scan_sync can
 	 * program the address in the allow list so PA advertisements can be
 	 * received.
@@ -6936,6 +6967,14 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 	hci_update_passive_scan_sync(hdev);
 
+	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
+	 * it.
+	 */
+	if (conn->sid == HCI_SID_INVALID)
+		__hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					 HCI_EV_LE_EXT_ADV_REPORT,
+					 conn->conn_timeout, NULL);
+
 	memset(&cp, 0, sizeof(cp));
 	cp.options = qos->bcast.options;
 	cp.sid = conn->sid;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3501a991f1c6..bd6b5cfb95fe 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -941,7 +941,7 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
 
-	if (sa->iso_bc->bc_sid > 0x0f)
+	if (sa->iso_bc->bc_sid > 0x0f && sa->iso_bc->bc_sid != HCI_SID_INVALID)
 		return -EINVAL;
 
 	iso_pi(sk)->bc_sid = sa->iso_bc->bc_sid;
@@ -2030,6 +2030,9 @@ static bool iso_match_sid(struct sock *sk, void *data)
 {
 	struct hci_ev_le_pa_sync_established *ev = data;
 
+	if (iso_pi(sk)->bc_sid == HCI_SID_INVALID)
+		return true;
+
 	return ev->sid == iso_pi(sk)->bc_sid;
 }
 
@@ -2076,8 +2079,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	if (ev1) {
 		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
-		if (sk && !ev1->status)
+		if (sk && !ev1->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
+			iso_pi(sk)->bc_sid = ev1->sid;
+		}
 
 		goto done;
 	}
-- 
2.49.0

