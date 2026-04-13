Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791021CFEF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121701; cv=none; b=HAlcSfRSDl8/3dQ5A76tYA4RaKr3n0R7BfsFuucCBcNk+eMxGux+GQZTJJ3uo6ulQxABqe0rTqQH1iiyax0194+DkfZshHBceOZI6Dsbfmd0A1oorfEtPbL2OE6aYcgq6Z/o4IJDjTTdd1mcxqA/M9BSxxNoM3dmx2+RhC5Pdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121701; c=relaxed/simple;
	bh=7gJjAxPZZ+LznLVbDb2kIDdDaEyYVkZ2Kgszca5kc1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mc/MK39UT5tPXe2595Jp3RIdFJDhSJhXpVXgUQa39aQry904DlBDRY2Jmk6M18FTEjj8+ddV4nQbnAOm+3QvnVe6egB/OvNsdcZ+F5eH8Vbxv08za/5wUJ3Y8ZiEY5ZKii7KqB0yhAZFXc2//t7jRvI2xqCFpWHaCgFscW1zeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUU8Y2+p; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUU8Y2+p"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38de18126e7so48475271fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776121698; x=1776726498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmnyZF62oqV6eb+/UautTcNjJEaCfvEj8QjAI86pR6w=;
        b=LUU8Y2+pl9wggZjA8DyJJDlhcQvj7UlLDOp0kyAPP6QXxmd0RmNyneLvsDuQbulSsp
         xbAz77R0CGqVuztPzwtRgo0v5fDSz5chr2jE+3pARQevKa3qA9Hz3cGMLy7cWPKIcM1J
         cKUCJmgNKapQfpM3b+/D0aQ6r5m2DhfapddoMXbG6aRv4EnLlPdHAeS20OM61E+jKyvv
         keSKC98gU1du828Ii4XdmDUrUQgiH4zYM91hoveYrGHBQFGMF6xxm/N5dEkWj5kMNNtF
         j0IGIimAxnPKsMU+hyjlx+X7dOQ/E/5Tbs5Y6s3yRQo9cmk+ozXXAun2e14Cd7qGfP3B
         wcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776121698; x=1776726498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmnyZF62oqV6eb+/UautTcNjJEaCfvEj8QjAI86pR6w=;
        b=YqCj3If0XaL9nh/DAnEmYg35c2Ggewa5QVZkExbhj/6sccWEfH0zwTxaINxp3CRtRD
         45SV/CvhbC+B9Efd7xK0BSRTuXtk1K5IV6KJ9qXK0Tz4vZk3wHlJ6Bg8fRTxLyP8mwB6
         GIKHUaO/rlpVy9ROQgeQ2NtRr5SAOXB1zs/vp+AgwAgZxag6BuxWZKZHeVtHJBACXv78
         vzq8itcXgX/qPL6QwBeExkGBgIZ6Gl36vgxMX5Cbxz5d41TxGeFr3eJRcE2KrPDkpm5s
         jd+5cyWVY7IxeKLrSGo050O6w0j9dY9MNJB4Yb7eCP1yM4grmX9m1TvwRV6LwyClemIe
         P7wQ==
X-Forwarded-Encrypted: i=1; AFNElJ84GEoa2ShfjOmtVEy18gcz9fG+ssfaannqq91bKAV4YupnzQEWVyFZ6fLJfScoyxvNWB3nFMf0gf/aSkOh9ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1kJygutevsnqPcWHt02flKzVNPNMZfL5UikATn1Qi902GD0+
	DGttHBuUKxe3InnTHxoLOEcml5kxVDBIfh38GrK0V8hLZFHowgvtVjMHGYSMOp7H46PjtQ==
X-Gm-Gg: AeBDievx1CKCZVXjneCdI1btJMucaZvx/iD6LRtePWl7Pv3lHC6Ue5GXufbh4q03doa
	DmICeBf0ybEiQmTRwCwCK9zL7rgdQ1GcQL+qwNv8u6P6rrXYXRufMMMdI0jFOgw0AIORzweu/Rm
	vifVbcRr63TrYoK5Sn5/SHToEuBd9KhfqgIM6eYaDoGTOS94KC418rn9zYfKujVpEF8d8HblIV4
	0EXee3znmfufYA98QPNEAsojRASHtQZW8NoAtHOIPc6BMeOXPpNE7u2edyOoZKAoLUPVsHkWb/a
	dWEWXI1w9DwhB+ydqR10uumL0913x+33x6fPUkuZwm2/GGSJDok6FeNJJdnUzCMUDbQd3ZB5nI1
	MVxS0JPgaB+XkkAGdYzu62dNolaTFpyoZrugE1/lESOBGIB4GMXh5QLFYzJt5XFrR3ySVVwCjIT
	QVmvr49nl2IxVR9SJWyRinRjayojkw5f/gHA==
X-Received: by 2002:a2e:be1c:0:b0:38c:d92e:c7ca with SMTP id 38308e7fff4ca-38e4bb4fe4dmr45473971fa.0.1776121697435;
        Mon, 13 Apr 2026 16:08:17 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e492cedbcsm29587181fa.18.2026.04.13.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:08:16 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: pmenzel@molgen.mpg.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
Date: Tue, 14 Apr 2026 04:08:13 +0500
Message-ID: <20260413230813.21393-1-mikhail.v.gavrilov@gmail.com>
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
caller context.

The connection parameter storage (hci_conn_params update) and userspace
notification (mgmt_new_conn_param) are moved into
hci_le_conn_update_complete_evt() where they are handled when the
controller confirms the update, using hci_sent_cmd_data() to retrieve
the originally requested min/max interval values.

Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in connection params")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

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
 net/bluetooth/hci_conn.c         | 66 ++++++++++++++++++++++----------
 net/bluetooth/hci_event.c        | 33 ++++++++++++++++
 net/bluetooth/l2cap_core.c       | 12 +-----
 4 files changed, 81 insertions(+), 32 deletions(-)

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
index 11d3ad8d2551..207221560a02 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -480,40 +480,64 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
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
-	struct hci_conn_params *params;
+	struct le_conn_update_data *d = data;
+	struct hci_conn *conn;
 	struct hci_cp_le_conn_update cp;
 
 	hci_dev_lock(hdev);
-
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params) {
-		params->conn_min_interval = min;
-		params->conn_max_interval = max;
-		params->conn_latency = latency;
-		params->supervision_timeout = to_multiplier;
-	}
-
+	/* Verify connection is still alive. */
+	conn = hci_conn_valid(hdev, d->conn) ? d->conn : NULL;
 	hci_dev_unlock(hdev);
+	if (!conn)
+		return -ECANCELED;
 
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
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_UPDATE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static void le_conn_update_complete(struct hci_dev *hdev, void *data,
+					int err)
+{
+	kfree(data);
+}
 
-	if (params)
-		return 0x01;
+void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
+		        u16 to_multiplier)
+{
+	struct le_conn_update_data *d;
 
-	return 0x00;
+	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return;
+
+	d->conn = conn;
+	d->min = min;
+	d->max = max;
+	d->latency = latency;
+	d->to_multiplier = to_multiplier;
+
+	if (hci_cmd_sync_queue(conn->hdev, le_conn_update_sync, d,
+			       le_conn_update_complete) < 0)
+		kfree(d);
 }
 
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3ebc5e6d45d9..9df8fc762a84 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6065,6 +6065,8 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
 					    struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_update_complete *ev = data;
+	struct hci_cp_le_conn_update *sent;
+	struct hci_conn_params *params;
 	struct hci_conn *conn;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -6079,6 +6081,37 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
 		conn->le_conn_interval = le16_to_cpu(ev->interval);
 		conn->le_conn_latency = le16_to_cpu(ev->latency);
 		conn->le_supv_timeout = le16_to_cpu(ev->supervision_timeout);
+
+		/* Update stored connection parameters and notify userspace
+		 * using the parameters from the original HCI command.
+		 */
+		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_CONN_UPDATE);
+		if (sent) {
+			u8 store_hint;
+
+			params = hci_conn_params_lookup(hdev, &conn->dst,
+							conn->dst_type);
+			if (params) {
+				params->conn_min_interval =
+					le16_to_cpu(sent->conn_interval_min);
+				params->conn_max_interval =
+					le16_to_cpu(sent->conn_interval_max);
+				params->conn_latency =
+					le16_to_cpu(sent->conn_latency);
+				params->supervision_timeout =
+					le16_to_cpu(sent->supervision_timeout);
+				store_hint = 0x01;
+			} else {
+				store_hint = 0x00;
+			}
+
+			mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type,
+					    store_hint,
+					    le16_to_cpu(sent->conn_interval_min),
+					    le16_to_cpu(sent->conn_interval_max),
+					    le16_to_cpu(sent->conn_latency),
+					    le16_to_cpu(sent->supervision_timeout));
+		}
 	}
 
 	hci_dev_unlock(hdev);
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

