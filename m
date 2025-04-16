Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FFD2253A8
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833336; cv=none; b=o7jUPcfl+Ueqf7AXvhOXMmff4bZOI9V0E/6P2ak4weokP+o3Gb3q8mtZHmTnVtkWndd6xVW9nOlVZd5DOkiBv2v8j0bTv3cnePWD55Es6Stn5UxINBRhkNVvtaqWWnvwvRYPSNJjivE3CdsJJCQDOc5xlSQLk7NY0FkrvUYFEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833336; c=relaxed/simple;
	bh=wRhT4AdPU5EIaOJZDvmnouNPUQSbhXuIGhIefDVWwBg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVw64oKgCxiDB4FXPr/dlwwTHFCXrgD8PP61OOeSDH63N9YJ4DBWSq4tvsun+3U5X4wgXqmjNHwVdgqUpbDQdufsVjjAjJT39cFuEbnpvGoM5MECpIwEVhOvJIubqnYouk1hT6Bc4l1BxqzpM2bZJ+U/tV55wamj98lSISySdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv0WJOkP; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv0WJOkP"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523de5611a3so19182e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744833333; x=1745438133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCcU0PHneyNkLmixqYfJgoG5ao/saRUq/QJk1Fqu+Tg=;
        b=Vv0WJOkPT3GkftybRhtIvtB34GqOahRyv9jvb6RLK3FVmOMkqNcmzLRS198YS0d86F
         aSOFxJmNRnjkB9PsMd43x3tLPNb1qJbQyflHNPQioQtMqclBVhPInB4s13Rls0nplAFM
         W/Nv9xtMYRNDtusoDsMWR+IS+poxBaZh1aoMRzyvoEF0DXOhRGZtLYUMNhLXc+DfY4oN
         yyjzKkgwSoLO77l82zy6Vl5P/bsIq/ldXL1Jgchxm0hDEcdRtSHYfAG1uYn/VCRCRDNR
         3+frwb298q2ExLpFmugKJN1POtOyE3wEujJw0ky7E8bJKKx+/HW0h5IFsqS7W4CjLvkk
         HWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744833333; x=1745438133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCcU0PHneyNkLmixqYfJgoG5ao/saRUq/QJk1Fqu+Tg=;
        b=nylGvjBcpscyptzDwzFeS7Nn1+pOXwNXwJzEnnK33V2l39ffYxWcQYt9CQWCeTL3WZ
         oC0UVoWyAaEaoIW5R2dZYyl5eZP6BgaM3H/xSPNJfQF9SBxNT5UA2fg4L67VYQSwq/Xz
         5HJNiKoPGFocj5LOAlM8U6ZzwySfdj+CklsvVAHqapfIyR+ODcXYf2mSdOCz/ZQ00keQ
         l8hBoaKFA98wkJj/VQFBy+Ui6LU7IV8j112i2R5bm+PtyyZrYaGY6kV20jAAqX2n9x5s
         yd/oZHbCHEaAYGPaL1VFsAdlJMb0CdRYjJf5bslT69u5z1Hnrnwd/5zGe1a5X4UQ7MSE
         3caw==
X-Gm-Message-State: AOJu0YySwlsombTvClKiJOFFQLyQvHgxZdVHwSMCVrseDVAf6vtDzPWX
	JMg461nf3jGOsGUwYJ1H89MSMKX4irSCv6VsJfGUcY6fT9ALsnuiAE4D7r3J
X-Gm-Gg: ASbGncuGR+jdjaVaO6q2ye7UgrdLdgTQq06e5X8dXfyIWa0PCh9cW7uaSKqNOPzSyT5
	mLYSOMk9Dff2mWCa+++u90vwlB0EdZsOi4SslRJDeM950f9K6URz/wrkQ6zRCxsl/QF9z+cJtTO
	4BwS3vYkix05s8uWcHPh1NNxTasH7BeIyI8uH1i6wsNxdchDXQGulDJlYZlIbMyCeowTdcILkk2
	XdCVqQGaGLdp2miWTUv+Uex4H0DK8DNcTbLIqpR7MQpEgj5iCy+CU7MeI2yl8LMfahEhDEUd1IJ
	qNgWXxED0OvngvR/id02RXR6NqeeK5NRGbuLF1SIiLoaDcX2G6oa1UFwqA1m0UNHzPeo6mHto+V
	7HqW9CAN48A==
X-Google-Smtp-Source: AGHT+IECpkKxf0WboNfufh43HH2rB4iTqC3Pr9OCqLVsqmhN8EXszFw2KF0DShdMIoLfVOAWpJHUAg==
X-Received: by 2002:a05:6122:32c9:b0:527:bc6b:35bb with SMTP id 71dfb90a1353d-5290de8d3eamr2751542e0c.3.1744833332598;
        Wed, 16 Apr 2025 12:55:32 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87557281a80sm3243415241.27.2025.04.16.12.55.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:55:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/4] Bluetooth: ISO: Fix not using SID from adv report
Date: Wed, 16 Apr 2025 15:55:25 -0400
Message-ID: <20250416195526.1989143-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416195526.1989143-1-luiz.dentz@gmail.com>
References: <20250416195526.1989143-1-luiz.dentz@gmail.com>
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
no access to SID since the likes of MGMT_EV_DEVICE_FOUND cannot carry
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
index 6533e281ada3..08e060669c2b 100644
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
index df7d7bf32eb8..a58fd3bf8851 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4068,10 +4068,13 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -4079,8 +4082,6 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
-
-	atomic_dec(&hdev->cmd_cnt);
 }
 
 static void hci_cmd_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6d6061111ac5..105d1446c9dc 100644
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
@@ -7144,7 +7155,8 @@ static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
 
 	/* Only match event if command OGF is for LE */
 	if (hdev->req_skb &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 &&
+	   (hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 ||
+	    hci_skb_opcode(hdev->req_skb) == HCI_OP_NOP) &&
 	    hci_skb_event(hdev->req_skb) == ev->subevent) {
 		*opcode = hci_skb_opcode(hdev->req_skb);
 		hci_req_cmd_complete(hdev, *opcode, 0x00, req_complete,
@@ -7500,8 +7512,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	hci_dev_lock(hdev);
 	kfree_skb(hdev->recv_event);
 	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
+	hci_dev_unlock(hdev);
 
 	event = hdr->evt;
 	if (!event) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e56b1cbedab9..d00ff18f3be0 100644
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
 
+	/* Stop scanning if SID has not been set and active scanning is enabled
+	 * so we use passive scanning which will be scanning using the allow
+	 * list programmed to contain only the connection address.
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
index 2819cda616bc..7c0012ce1b89 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -941,7 +941,7 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
 
-	if (sa->iso_bc->bc_sid > 0x0f)
+	if (sa->iso_bc->bc_sid > 0x0f && sa->iso_bc->bc_sid != HCI_SID_INVALID)
 		return -EINVAL;
 
 	iso_pi(sk)->bc_sid = sa->iso_bc->bc_sid;
@@ -2029,6 +2029,9 @@ static bool iso_match_sid(struct sock *sk, void *data)
 {
 	struct hci_ev_le_pa_sync_established *ev = data;
 
+	if (iso_pi(sk)->bc_sid == HCI_SID_INVALID)
+		return true;
+
 	return ev->sid == iso_pi(sk)->bc_sid;
 }
 
@@ -2075,8 +2078,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
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

