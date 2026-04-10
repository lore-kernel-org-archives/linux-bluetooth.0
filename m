Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26C371D10
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802610; cv=none; b=uie+aiW8o5QZgrwmUljk6NHborfTcneLP6L7xCTOWbnAWmG743CSJZEUItO6d08+rbXFp1mzco+MWI0rSJM0o4RCXSxEjA+BNumx1xq3hncjzsP2bSen78ooGiuv4GtFi8Xi21BJswVfw8EwwmNS6vRsXipjnA3629ZLyUP012A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802610; c=relaxed/simple;
	bh=Q3YuX6ojbP6s1IWwxDjoZs3SIKMzF867hEvEWZx9y8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYEBiCasklZY9yOCnvWGCFkY6XsIApl05cC8+Mqq2NhucgMcE4TL50Szr7pyxGzSJc0RP2ihMSH+WlbtDpEfznkIswLuq5opDQ9MB3kXg8xHsHUITWrzgcz6EtxmlzvU26PrVP1bd6EAZTZeVX+orscolHcPRg0EiRaZChBxdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfZvw5Rn; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfZvw5Rn"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38df27b25e3so15238781fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 23:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775802606; x=1776407406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cgAfu309cYrD/5ag9qQuWbjQY22q9LkbBL15U/YGYGU=;
        b=sfZvw5RnFxsmtEsR6PuwK8JJufyvcnvoILKI+PrR15AGivVyPuuAix154RULvXCdst
         uIrjrHF4Qvzb/aK8IVTZdmfI2Sc0yYiXzBLP2bOyqZar+Mgm7qHVwXUIRGgpH29vtP4E
         Jx82xYRArPnvTKzloKuaw6aNg5VontY4Z4Vmecqj1lO8SMBED/MXarVZOkWqxz8fWR1t
         rZe1e5r0rRxiBubYACBbezSWiSghB2kAP1FSLBChJLmawJcFVkqqBTI4l/EojitK3djK
         mdt+6nEyKIIg2TcK/6YBniXkRg4V496+0K6lGqCog4WJK0sm++1vH479jU07HKDVnxkM
         jokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775802606; x=1776407406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgAfu309cYrD/5ag9qQuWbjQY22q9LkbBL15U/YGYGU=;
        b=AGJ8YfUjUhOnDgOapdNBhN5h8F8MZDwsiIOBXd1boaEjRCAa4srKTUBObYZWv/SB1q
         /IDJ1r3HmymCR6I8lMbauzIv2elp0MW1t2732x0na8z4duBf3iyquFnGtHcJPakh0vqH
         5LcEQKyjzG9tqMTvT21aJVeAN4HrB0pXy4uy9zdCWvZtn/DBnNIsk1TS8Wn4RNCrOvh/
         8Mo7H7EsvOxUKN1yVIcdz97fN5E1K18cURL2o0r/0Eo4IrUEhuurgGc0cQf0a0tpXArJ
         A83MUoc2WRb6AdlLhlxcUQQW+c7ai/BKcgX3zbepnetjT0UilGh7Arl4aw3ap9YiyRyY
         uqCA==
X-Forwarded-Encrypted: i=1; AJvYcCUaKNBfBFLXf6khJg6zIPRf3IP8j8gViGLfp+X8LLBsyY27Ik6rZZxLfl2brS4FATTUgH7lMKR8grvoe1kMj7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHHgr2zGnw7xyuBC7J0RAdwdXDnoFH5VActTjSXovQLxfIbxG
	eZckWzsLQmMnEJuU6IJAYwz4bXVarptLqAGGTi4YyvwoxDfkgJwv+WiY
X-Gm-Gg: AeBDievjEnEJTdlD33RmE1jrcxgicvelaw5wZLsgD0vWMeJs79bZ52gMU/nS4M74Dml
	4CkvdDobklCDSFR6FIbIuVXW6e4XHXjoaE2JTNns8tIHgK/H3KDpNaiOrySo1efPW21YH3DObJi
	htzDhB6Xd/ciHA6YcPpGXd2q9um2Sl3tox8Q2/iG8Gzj1BIhaO1oZn+wG+kfa6TzH+ikb3JxkF1
	0u36TnS1JL3bY4zrTK4AjccvvmCBbVRcKink3PBxCtvdjfWzWIqWW+5/xjyLiyw4T88EzzypTAR
	mkyulXfHUS0/Ny/HSnZw7AVvPwNcZF/21PXwHTCMKmbRyZJ8Irc7EhoxesrD/EOwC1OXNvsX4IW
	OInu+7VUr/O/Gwf/oQFDI6R9zFz4GAEqB8Em6xL4rfe28rBPQcvfhaowXbewD+Uq+CYYNFcJUPR
	31tKdApOK1KJKpUvnkYBAJ7yHiWovHITA6Ha8hdTRpMQiz
X-Received: by 2002:a05:651c:146b:b0:38e:23c9:2f5f with SMTP id 38308e7fff4ca-38e4bf7413emr4611021fa.26.1775802606003;
        Thu, 09 Apr 2026 23:30:06 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495aed16sm4141311fa.40.2026.04.09.23.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 23:30:05 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: pmenzel@molgen.mpg.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] Bluetooth: l2cap: defer conn param update to avoid  conn->lock/hdev->lock inversion
Date: Fri, 10 Apr 2026 11:30:01 +0500
Message-ID: <20260410063001.94728-1-mikhail.v.gavrilov@gmail.com>
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

Fix this by introducing l2cap_conn_param_update_sync() which is scheduled
via hci_cmd_sync_queue() to run on the hci_cmd_sync workqueue, outside
any of the involved locks.  The necessary connection parameters are
captured into a heap-allocated struct conn_param_update_data and the
sync callback performs the hci_conn_params update, sends the HCI LE
Connection Update command, and notifies mgmt of the new parameters.

To guard against a theoretical handle-reuse race (the connection could
drop and its handle be reassigned between queuing and execution), the
sync callback verifies the connection still exists and its destination
address matches the original request before proceeding.

The allocation is performed before sending the L2CAP_CONN_PARAM_ACCEPTED
response so that on OOM the peer receives a REJECTED response instead of
an inconsistent state where the peer applies new parameters but the local
controller does not.

Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in connection params")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

Changes in v2 (Paul Menzel, Sashiko/Gemini AI review):
- Allocate before sending ACCEPTED response to avoid state mismatch on OOM
- Verify connection handle and address in sync callback against reuse race
- Expand commit message with implementation details

 net/bluetooth/l2cap_core.c | 93 ++++++++++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..94dfef9df498 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4670,6 +4670,70 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 	return 0;
 }
 
+struct conn_param_update_data {
+	u16	handle;
+	bdaddr_t dst;
+	u8	dst_type;
+	u16	min;
+	u16	max;
+	u16	latency;
+	u16	to_multiplier;
+};
+
+static int l2cap_conn_param_update_sync(struct hci_dev *hdev, void *data)
+{
+	struct conn_param_update_data *d = data;
+	struct hci_conn *conn;
+	struct hci_conn_params *params;
+	struct hci_cp_le_conn_update cp;
+	u8 store_hint = 0x00;
+
+	/* Verify the connection is still alive and matches the original
+	 * request, since the handle could theoretically be reused after
+	 * a disconnect/reconnect cycle.
+	 */
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, d->handle);
+	if (!conn || bacmp(&conn->dst, &d->dst)) {
+		hci_dev_unlock(hdev);
+		return 0;
+	}
+
+	params = hci_conn_params_lookup(hdev, &d->dst, d->dst_type);
+	if (params) {
+		params->conn_min_interval = d->min;
+		params->conn_max_interval = d->max;
+		params->conn_latency = d->latency;
+		params->supervision_timeout = d->to_multiplier;
+		store_hint = 0x01;
+	}
+
+	hci_dev_unlock(hdev);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle		= cpu_to_le16(d->handle);
+	cp.conn_interval_min	= cpu_to_le16(d->min);
+	cp.conn_interval_max	= cpu_to_le16(d->max);
+	cp.conn_latency		= cpu_to_le16(d->latency);
+	cp.supervision_timeout	= cpu_to_le16(d->to_multiplier);
+	cp.min_ce_len		= cpu_to_le16(0x0000);
+	cp.max_ce_len		= cpu_to_le16(0x0000);
+
+	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
+
+	mgmt_new_conn_param(hdev, &d->dst, d->dst_type, store_hint,
+			    d->min, d->max, d->latency, d->to_multiplier);
+
+	return 0;
+}
+
+static void l2cap_conn_param_update_destroy(struct hci_dev *hdev, void *data,
+					    int err)
+{
+	kfree(data);
+}
+
 static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 					      struct l2cap_cmd_hdr *cmd,
 					      u16 cmd_len, u8 *data)
@@ -4677,6 +4741,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_conn_param_update_req *req;
 	struct l2cap_conn_param_update_rsp rsp;
+	struct conn_param_update_data *d;
 	u16 min, max, latency, to_multiplier;
 	int err;
 
@@ -4703,18 +4768,30 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	else
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_ACCEPTED);
 
+	if (!err) {
+		d = kmalloc(sizeof(*d), GFP_KERNEL);
+		if (!d) {
+			rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
+			err = -ENOMEM;
+		}
+	}
+
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
 		       sizeof(rsp), &rsp);
 
 	if (!err) {
-		u8 store_hint;
-
-		store_hint = hci_le_conn_update(hcon, min, max, latency,
-						to_multiplier);
-		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
-				    store_hint, min, max, latency,
-				    to_multiplier);
-
+		d->handle = hcon->handle;
+		bacpy(&d->dst, &hcon->dst);
+		d->dst_type = hcon->dst_type;
+		d->min = min;
+		d->max = max;
+		d->latency = latency;
+		d->to_multiplier = to_multiplier;
+
+		if (hci_cmd_sync_queue(hcon->hdev,
+				       l2cap_conn_param_update_sync, d,
+				       l2cap_conn_param_update_destroy) < 0)
+			kfree(d);
 	}
 
 	return 0;
-- 
2.53.0

