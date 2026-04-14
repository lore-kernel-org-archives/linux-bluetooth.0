Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE229256C6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192265; cv=none; b=t2HU3wMNpve08c9WziAUZM+Q0tbI/KxSdIQBhe8l4jtY0+QyCxO1cn2fnU8OefrF2uBng4meHryk4vWYQ8/IhCVlvS69YbBAxhHsDr1rSA2B/PZlcx73Ndal1XW/4am30QAgshvQyqtTbWza+gR7TejfIqmauozNJyeB5e55Rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192265; c=relaxed/simple;
	bh=TUuhefwC4aFl3YLHYKYGENQxDOTKPvM6Tps0ln9Nurg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETGJXsrKR5RqhgRYpNcaHXQhAwJeSLNsbFzOxdGX131IyOIvsmQ4mGWXvA1YMJKoOf/PrbZ7EBY4OkpDZ+reQqVPFLwzb5O1x1tqOT469cE+86D0APVZ30QRH78OzktCRZMVcltxsVrZafnKyfUP6AsYjhmOwxTgCF/NBKqkVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItE2W8Qy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItE2W8Qy"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so7988133e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776192262; x=1776797062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDSbhtw80z17ovEPSRK2tau26R2taQWyMreMp5Xkpwg=;
        b=ItE2W8QyZ1Rgt0IwxlxYp5sYLe1lGkUC6QvZJRhPdiVHaybsNWkFjxT8jipJgSdQld
         uoU9sB6V6Of85TGIRaMkxWTZziWK89yOVba+ZpCGBaZRwz40LYLybrDbXd/zLZ/1q7vp
         o3Ut3+4RjV049+S+CxqIizLYHzg6jt+u4ZZlbVhsE7szv7lh0+gpbyIP6LI+eWPC8iKb
         jAiTO7BxNxDHwVZs6PKGI9B1V8q93w+5tv3yG8fIku1+wIOCFOpDFMiNfNt8kvLtrKPV
         ohTxbwGW6s8TYYhttfHpjNYrsjVJ8xZaonWHnOAsxMvtp7bB7nQQ9fZ5ofKG0yf76TUS
         B8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776192262; x=1776797062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDSbhtw80z17ovEPSRK2tau26R2taQWyMreMp5Xkpwg=;
        b=FactfkNpo6gogBTOmHgJL6kI0ztZMZe1BbKozdAgVysY33JpWyUp5Kd1h+dzfG5bZJ
         e5WSkL/Jsyd+kHRSpuwyiWlg61KjjPTxs5GjNbZSGs3CnhCOjq4Prc203pnFxAcRAd++
         1v52drKLg74bBKp/fTzLjpuPTHvP0iiLLOahI/tocxnyk0IxGQc4X+45uIc+Mm7RnGjV
         O4Fkf2izudp+7hk5fyYi/q9aHJTyZOyIcXPybTdfZYOL3Tc2ysNRe3Brxk4Du29CcSI1
         e/UE5XjFKqAuSiA+9rPDRsPHIuVMVBMmxdEzwfORerq1WvyMbzOzJSOEXYkRbV/BHjom
         TSfg==
X-Forwarded-Encrypted: i=1; AFNElJ800MkKzS7WgqvrDAv4e3G2+E1BJZNvT0ZNQ9CP5Ow002iBzGwu+ezJKFIPlwwx/L4Asq7BnXsGW4X7QL5KZk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7OUN4qzkuOcc8+R2AmdQwVL1BNKWZ4CIqGzsVjDyaHVzQuMH
	xSDPNo+cKweGJrXRyBt379l0gCCkRC9r8lxzAkAjFCbzGc/Giro81T7p
X-Gm-Gg: AeBDiesa/Vh6miZpeKGyJGL5SKiuqEt31y0F967q5kTtSnuU2sh1CyEN+9w648V2GLq
	Z911AEhzlTuWeCOkea4TkpoCVvKIoomcWrNBuNE5i+hmAdj4RvIf84mm+0p9sONbBrG/ETc+TmX
	KJWltxskfletyQeJcpZFheOoaUy2iCVBcVY/Af1c5N0i45NmUBzFORdDHr9lqF4azAsJxOnCO7D
	NKwPxEHZvBiBRIqQDR13YfutleypOkofSI9goTlLOrLXzwD9ZB7PkGN0uN/Rfq4rBp4/A3TWCbb
	afPYwyB+5jgt9z/Lut0+Wl8FNo9Lgvemr+j1CBJMm7DUblmLwLv6Uh+Y9ByXHfO4tPEjxoz8QAN
	UYuCbKyet94uSK8fEDpRV/Uhs9bwnM+IBh9Ak4D+J4TtQA1RQQCMMpBRHmbcTTiG08GhQo+CHpd
	tr7He3vaaRx9BPkCCm0QYpzegl9Sinqh/pOuG8gjVPeYpq
X-Received: by 2002:a05:6512:b86:b0:5a3:ffe5:caec with SMTP id 2adb3069b0e04-5a3ffe5cbdcmr2436008e87.34.1776192261504;
        Tue, 14 Apr 2026 11:44:21 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3fe377e5dsm1436814e87.30.2026.04.14.11.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 11:44:20 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: pmenzel@molgen.mpg.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v4] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
Date: Tue, 14 Apr 2026 23:43:42 +0500
Message-ID: <20260414184415.17114-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a BLE peripheral sends an L2CAP Connection Parameter Update Request
the processing path is:

  process_pending_rx()          [takes conn->lock]
    l2cap_le_sig_channel()
      l2cap_conn_param_update_req()
        hci_le_conn_update()    [takes hdev->lock]

Meanwhile other code paths take the locks in the opposite order:

  l2cap_chan_connect()          [takes hdev->lock]
    ...
      mutex_lock(&conn->lock)

  l2cap_conn_ready()            [hdev->lock via hci_cb_list_lock]
    ...
      mutex_lock(&conn->lock)

This is a classic AB/BA deadlock which lockdep reports as a circular
locking dependency when connecting a BLE MIDI keyboard (Carry-On FC-49).

Fix this by making hci_le_conn_update() defer the HCI command through
hci_cmd_sync_queue() so it no longer needs to take hdev->lock in the
caller context.  The sync callback uses __hci_cmd_sync_status_sk() to
wait for the HCI_EV_LE_CONN_UPDATE_COMPLETE event, then updates the
stored connection parameters (hci_conn_params) and notifies userspace
(mgmt_new_conn_param) only after the controller has confirmed the update.

A reference on hci_conn is held via hci_conn_get()/hci_conn_put() for
the lifetime of the queued work to prevent use-after-free, and
hci_conn_valid() is checked before proceeding in case the connection was
removed while the work was pending.

Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in connection params")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Changes in v4 (Luiz Augusto von Dentz, Sashiko/Gemini AI review):
- Use hci_conn_get()/hci_conn_put() to hold a reference while work is queued
- Use __hci_cmd_sync_status_sk() to wait for HCI_EV_LE_CONN_UPDATE_COMPLETE,
  then do params update + mgmt notification in the sync callback — removes the
  need for hci_event.c changes and hci_sent_cmd_data()
- Use kzalloc_obj() per checkpatch recommendation
- Fix checkpatch alignment issues
 
Changes in v3 (Luiz Augusto von Dentz):
- Move hci_cmd_sync_queue into hci_le_conn_update itself instead of open-coding
  the deferral in l2cap_core.c
- Move conn_params update and mgmt_new_conn_param into
  hci_le_conn_update_complete_evt, using hci_sent_cmd_data to retrieve
  the originally requested parameters
 
Changes in v2 (Paul Menzel, Sashiko/Gemini AI review):
- Allocate before sending ACCEPTED response to avoid state mismatch on OOM
- Verify connection handle and address in sync callback against reuse race
- Expand commit message with implementation details

 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 98 +++++++++++++++++++++++++-------
 net/bluetooth/l2cap_core.c       | 12 +---
 3 files changed, 82 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bffb908c1e..aa600fbf9a53 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2495,7 +2495,7 @@ void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
 
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
-u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
+void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 		      __u8 ltk[16], __u8 key_size);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..c9cc18fab1f2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -480,40 +480,100 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	return hci_setup_sync_conn(conn, handle);
 }
 
-u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
-		      u16 to_multiplier)
+struct le_conn_update_data {
+	struct hci_conn *conn;
+	u16	min;
+	u16	max;
+	u16	latency;
+	u16	to_multiplier;
+};
+
+static int le_conn_update_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_dev *hdev = conn->hdev;
+	struct le_conn_update_data *d = data;
+	struct hci_conn *conn = d->conn;
 	struct hci_conn_params *params;
 	struct hci_cp_le_conn_update cp;
+	u8 store_hint;
+	int err;
 
+	/* Verify connection is still alive. */
 	hci_dev_lock(hdev);
-
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params) {
-		params->conn_min_interval = min;
-		params->conn_max_interval = max;
-		params->conn_latency = latency;
-		params->supervision_timeout = to_multiplier;
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock(hdev);
+		return -ECANCELED;
 	}
-
 	hci_dev_unlock(hdev);
 
 	memset(&cp, 0, sizeof(cp));
 	cp.handle		= cpu_to_le16(conn->handle);
-	cp.conn_interval_min	= cpu_to_le16(min);
-	cp.conn_interval_max	= cpu_to_le16(max);
-	cp.conn_latency		= cpu_to_le16(latency);
-	cp.supervision_timeout	= cpu_to_le16(to_multiplier);
+	cp.conn_interval_min	= cpu_to_le16(d->min);
+	cp.conn_interval_max	= cpu_to_le16(d->max);
+	cp.conn_latency		= cpu_to_le16(d->latency);
+	cp.supervision_timeout	= cpu_to_le16(d->to_multiplier);
 	cp.min_ce_len		= cpu_to_le16(0x0000);
 	cp.max_ce_len		= cpu_to_le16(0x0000);
 
-	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CONN_UPDATE,
+				       sizeof(cp), &cp,
+				       HCI_EV_LE_CONN_UPDATE_COMPLETE,
+				       HCI_CMD_TIMEOUT, NULL);
+	if (err)
+		return err;
+
+	/* Update stored connection parameters after the controller has
+	 * confirmed the update via the LE Connection Update Complete event.
+	 */
+	hci_dev_lock(hdev);
 
-	if (params)
-		return 0x01;
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (params) {
+		params->conn_min_interval = d->min;
+		params->conn_max_interval = d->max;
+		params->conn_latency = d->latency;
+		params->supervision_timeout = d->to_multiplier;
+		store_hint = 0x01;
+	} else {
+		store_hint = 0x00;
+	}
 
-	return 0x00;
+	hci_dev_unlock(hdev);
+
+	mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type, store_hint,
+			    d->min, d->max, d->latency, d->to_multiplier);
+
+	return 0;
+}
+
+static void le_conn_update_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct le_conn_update_data *d = data;
+
+	hci_conn_put(d->conn);
+	kfree(d);
+}
+
+void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
+			u16 to_multiplier)
+{
+	struct le_conn_update_data *d;
+
+	d = kzalloc_obj(*d);
+	if (!d)
+		return;
+
+	hci_conn_get(conn);
+	d->conn = conn;
+	d->min = min;
+	d->max = max;
+	d->latency = latency;
+	d->to_multiplier = to_multiplier;
+
+	if (hci_cmd_sync_queue(conn->hdev, le_conn_update_sync, d,
+			       le_conn_update_complete) < 0) {
+		hci_conn_put(conn);
+		kfree(d);
+	}
 }
 
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..aac2db1d6fbb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4706,16 +4706,8 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
 		       sizeof(rsp), &rsp);
 
-	if (!err) {
-		u8 store_hint;
-
-		store_hint = hci_le_conn_update(hcon, min, max, latency,
-						to_multiplier);
-		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
-				    store_hint, min, max, latency,
-				    to_multiplier);
-
-	}
+	if (!err)
+		hci_le_conn_update(hcon, min, max, latency, to_multiplier);
 
 	return 0;
 }
-- 
2.53.0

