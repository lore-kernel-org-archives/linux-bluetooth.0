Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733429CE9
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203588; cv=none; b=nesUDn3QUDv+FnzMvdYa3QtELQzjGjAmlOLrFrRDxgBkdH8Ub80/PXqrCvSuYyK+zldsQvB+DRtmVM6cVNOY53LJF2X9iCMu8Cn2a5myCG4ykA3zZdidPKSf8OyYYYHupAHYVMUw6AIxvGCjml2HHgmHyvMwHJZ+ahpEJBsfIhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203588; c=relaxed/simple;
	bh=uFSSyTR0o1nJgXu0IQQtJEsxcxKoUt32vJs7PeMihiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnC+ixlWui6GTN2uF/ZzTYbSXi6je936ZHCU0kC/Vgp9hraCJmvo0c18aDPernJ/yu+hdpdiW3PcJ7fnpIkzdEwxeaIgW0RuvbRHTKywQppiz17bZ8edsrbc9R+DlOVscHCOKZgb1zs5q6kur4cpensTRVN4acwja+4wt0yZEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8M8Nl5M; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8M8Nl5M"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3fcb2c718so2089384e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776203585; x=1776808385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V84+ZwERvzUaW0naC3PH1+/R0ntnOTd5149JB9mCJ/g=;
        b=P8M8Nl5Mj+4rNPXcqEadtHtVCpBwYqWAkGl57NBIOYbkoC5fsB38Sg2Hl5xsRUrow9
         +1PPJNsgxxsVvV6V3qIp8CNDaDk7JEbYOfXU5bXOsdgqt676qQ4+XiUM2d9iHC8s2+0Z
         A8ZdGOwkwZhzOgiMh6tT3fZdNhQWuGy8WjO2BHYS2pX+CkoxhnBLh3yWmAJ8J+dutRCs
         /MLgbjMV043KNHDAfCrWNBQeb8eIjoPxM0uU6vFHUPqif11IdOjkosbjc1d1Cn2Su7p7
         cO9P5EsR5nckOiVJIBHoK0VxySLMwbJ4sUS5ootQO2CeZeb4Cu+HiZU9O6o81ZCl31xw
         PJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776203585; x=1776808385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V84+ZwERvzUaW0naC3PH1+/R0ntnOTd5149JB9mCJ/g=;
        b=ghYDDF6cxHKsjdKtVR3ALlpF7WRrRMuuuIShnfjc9UvyV9e5afkda2LpOnn6HdCR4Y
         DJKTii860J72gaKuwPKd8rr9A2KNz8/4paZ3u1WRN+KKK/zGRfI6kbOeIt/z9T/ManyU
         XJddT+gFb0q6Ue8I3e/tYtG7zG1rlJCLZXXajuPs/JJGG3O2X8xyGAPuRyLoC84JGsdP
         O1QFW/CEVfBSjjZMy9vqicYxPjBDwRyheqrX1zD6qmtMzDWMdZaT+aoqAY8yEX3sku6l
         Mv/ELdN2E5S8d+IFj3rbZP3hfWkcLzmeDZD/QB3mCFg5t1nsl2rLc5bReWneKYJ5XZRU
         yH+Q==
X-Forwarded-Encrypted: i=1; AFNElJ99BwBiPiPk5ClBvfT1NBLWJsnN7XMw7cI+1+mucWC4cawzOKRdPC6TynNFEOrBqgLF7N0TYW1nRcHSh9ywoFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGO+43TtBI+16DF3MdKz6UecS1AyTrddCmZDE6aRyGq8YERace
	9YxUf2AI73NzS9iIQBEGLxy0dUBYOaYPE0qqjRjInh/f0bIzJ7r67uv4
X-Gm-Gg: AeBDieu0W0Q/B8qU9JwTOMfjDN6gVINHsL9dc+Lik2Vko85lozC38OERIAUfY1pKO+a
	oa3nexNHs3wN7hn37Kvqds0OfNaAnKur6zZPh7K62L63/l5mMLIHx3x20S9D74Yyz1cooaMqKRd
	TNxZEna1D55j3I2XAc/jhuTwo9sovWQnG1qqkL9VNP+2cHuslbV1/CuAWmUw7dhPGOXgVytJj+j
	oewu93vDNafhR+lPmVtzaut/TfRh5eMcfSYBqsCCzJovuJ3Dbg5qnNuS1M/g/55dpLkm03y9A/5
	Xqv7fJtgCBkJAINrhBq9bWXPUMP9oYgeG/zLkJ+GVsLa1u6u2AtcupunJCichCllDO0geHTqs+k
	/Yfa3q2dra8lSKz5ICra2elmTGhA4F6V+mF5ZLaoixuU0+54p2rMGPfXGb7L0/Xo9xcyncECM5F
	4lxRRRGxOxkHxJJWvBO9bhzjjjXO6oKXg/0uWouOui5RcW
X-Received: by 2002:a05:6512:3b0d:b0:5a4:d9:88a5 with SMTP id 2adb3069b0e04-5a400d988dbmr2724079e87.24.1776203584622;
        Tue, 14 Apr 2026 14:53:04 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e49541dd1sm36227421fa.24.2026.04.14.14.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:53:04 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: pav@iki.fi,
	pmenzel@molgen.mpg.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v5] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
Date: Wed, 15 Apr 2026 02:52:37 +0500
Message-ID: <20260414215237.17791-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
removed while the work was pending.  The hci_dev_lock is held across
hci_conn_valid() and all conn field accesses to prevent a concurrent
disconnect from invalidating the connection mid-use.

Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in connection params")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Changes in v5 (Pauli Virtanen, Luiz Augusto von Dentz):
- Keep hci_dev_lock held across hci_conn_valid() and all conn field reads
  (including conn->handle) to close the race window noted by Pauli
- Use conn->conn_timeout instead of HCI_CMD_TIMEOUT for the sync wait,
  matching hci_le_create_conn_sync() pattern
 
Changes in v4 (Luiz Augusto von Dentz, Sashiko/Gemini AI review):
- Use hci_conn_get()/hci_conn_put() to hold a reference while work is queued
- Use __hci_cmd_sync_status_sk() to wait for HCI_EV_LE_CONN_UPDATE_COMPLETE,
  then do params update + mgmt notification in the sync callback
- Use kzalloc_obj() per checkpatch recommendation
 
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

 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/hci_conn.c         | 105 +++++++++++++++++++++++++------
 net/bluetooth/l2cap_core.c       |  12 +---
 3 files changed, 89 insertions(+), 30 deletions(-)

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
index 11d3ad8d2551..fea0764b8ba3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -480,40 +480,107 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
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
+	u16 timeout;
+	u8 store_hint;
+	int err;
 
+	/* Verify connection is still alive and read conn fields under
+	 * the same lock to prevent a concurrent disconnect from freeing
+	 * or reusing the connection while we build the HCI command.
+	 */
 	hci_dev_lock(hdev);
 
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
 
-	hci_dev_unlock(hdev);
-
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
+	timeout			= conn->conn_timeout;
+
+	hci_dev_unlock(hdev);
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CONN_UPDATE,
+				       sizeof(cp), &cp,
+				       HCI_EV_LE_CONN_UPDATE_COMPLETE,
+				       timeout, NULL);
+	if (err)
+		return err;
+
+	/* Update stored connection parameters after the controller has
+	 * confirmed the update via the LE Connection Update Complete event.
+	 */
+	hci_dev_lock(hdev);
+
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
 
-	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
+	hci_dev_unlock(hdev);
 
-	if (params)
-		return 0x01;
+	mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type, store_hint,
+			    d->min, d->max, d->latency, d->to_multiplier);
 
-	return 0x00;
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

