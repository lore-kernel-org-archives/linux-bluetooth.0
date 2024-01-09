Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0E33B79C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3XBfayw"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-598699c0f1eso882619eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822575; x=1705427375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5J3LZLGSVw58kOP8fmy/EScI22jcc989bNREYFBgZI=;
        b=a3XBfaywAJbWQSIbn3z6NdZIinf2GQlKQshqux9uEINfa7GnqLo2+S2oOuSCZFrwxj
         2RWiUN5Sllwg9oTKb/BDa9tRX0ezLcrD3kFrC6yOIASIvSumFgOgvXjjjM61XtKgM+t7
         j9sa6aQ6qwDpx/2gsJFsif+pa4/3FD3KC0m/qXzY5oWMy02pLDnH/G05LI67qUzeFYES
         yqh44m00jbGw6zEXcqfnQK4H2eaaN3r/R3HCW8KwAwMLBw5PLKMqsmlmLLdTWdmd8M0A
         2L8LO2SnrXr2s3YglS/60vcFoYPYqCgelE+NER04J9gqI9f9RI8Q8DjxpXd6CfGyHNM5
         siqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822575; x=1705427375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5J3LZLGSVw58kOP8fmy/EScI22jcc989bNREYFBgZI=;
        b=li8NSppbTHHNKnVFiNs7Ho9367agG8W8QVweE20UqqMqMMrnEj9NASvVabNzmdA/AL
         WnZtWdnqjndG3sd2ivOYPuWtm9TIJXoPmdtKxVeWlrk2RvEPIdcnZ41Z2uCbsw3nN7YG
         Sg5F++qIfsVoPv9ebGexT5dxyZ9kGPi4raFgzBu69DMPjFxzSRQWmEJfhQyFuWvn41Nu
         wuTpjSP4vPsXgwXld4IMe7nnhmTRGGx5SHQcYIlUsYdwXgR1sUOuXF6fTY0IMES2VTde
         daxt2L2Y3bODEpn25WjWtS6R/cNqieTI5vqGLrhnbcP2t64f9GQ+ggIKnhpRtVgQG2gX
         30JA==
X-Gm-Message-State: AOJu0YxAbBY18aKFTwdPoBjpbHnhKUwHHNrNydzuNkR0Q03L/QSnu4Yb
	fgcxT7YlYEVETBq9hF3bo/wiIbrUFSQ=
X-Google-Smtp-Source: AGHT+IG1VVjtYM11XgIcZIrR8JSivMPNLI5WVXTown8ieO9JUjkU7RDi9+5g2jBOGT+OPbVq20srvA==
X-Received: by 2002:a4a:48c4:0:b0:598:3e66:98e6 with SMTP id p187-20020a4a48c4000000b005983e6698e6mr3054908ooa.14.1704822575144;
        Tue, 09 Jan 2024 09:49:35 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id o184-20020a4a44c1000000b00595e66557e6sm476814ooa.6.2024.01.09.09.49.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:49:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: hci_conn: Only do ACL connections sequentially
Date: Tue,  9 Jan 2024 12:49:27 -0500
Message-ID: <20240109174928.488595-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109174928.488595-1-luiz.dentz@gmail.com>
References: <20240109174928.488595-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Dreßler <verdre@v0yd.nl>

Pretty much all bluetooth chipsets only support paging a single device at
a time, and if they don't reject a secondary "Create Connection" request
while another is still ongoing, they'll most likely serialize those
requests in the firware.

With commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
requests") we started adding some serialization of our own in case the
adapter returns "Command Disallowed" HCI error.

This commit was using the BT_CONNECT2 state for the serialization, this
state is also used for a few more things (most notably to indicate we're
waiting for an inquiry to cancel) and therefore a bit unreliable. Also
not all BT firwares would respond with "Command Disallowed" on too many
connection requests, some will also respond with "Hardware Failure"
(BCM4378), and others will error out later and send a "Connect Complete"
event with error "Rejected Limited Resources" (Marvell 88W8897).

We can clean things up a bit and also make the serialization more reliable
by using our hci_sync machinery to always do "Create Connection" requests
in a sequential manner.

This is very similar to what we're already doing for establishing LE
connections, and it works well there.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_sync.h |  4 ++
 net/bluetooth/hci_conn.c         | 69 ++++-------------------------
 net/bluetooth/hci_sync.c         | 74 ++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1cd212bb3789..0be0c1af7e74 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -439,6 +439,7 @@ enum {
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
+#define HCI_ACL_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
 /* HCI data types */
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 6efbc2152146..18f022f2a978 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -138,3 +138,7 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason);
 int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
+
+int hci_acl_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn);
+
+int hci_acl_create_conn(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a41d2693f4d8..8d2c2751455e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -179,64 +179,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	hci_dev_put(hdev);
 }
 
-static void hci_acl_create_connection(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct inquiry_entry *ie;
-	struct hci_cp_create_conn cp;
-
-	BT_DBG("hcon %p", conn);
-
-	/* Many controllers disallow HCI Create Connection while it is doing
-	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
-	 * Connection. This may cause the MGMT discovering state to become false
-	 * without user space's request but it is okay since the MGMT Discovery
-	 * APIs do not promise that discovery should be done forever. Instead,
-	 * the user space monitors the status of MGMT discovering and it may
-	 * request for discovery again when this flag becomes false.
-	 */
-	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-		/* Put this connection to "pending" state so that it will be
-		 * executed after the inquiry cancel command complete event.
-		 */
-		conn->state = BT_CONNECT2;
-		hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-		return;
-	}
-
-	conn->state = BT_CONNECT;
-	conn->out = true;
-	conn->role = HCI_ROLE_MASTER;
-
-	conn->attempt++;
-
-	conn->link_policy = hdev->link_policy;
-
-	memset(&cp, 0, sizeof(cp));
-	bacpy(&cp.bdaddr, &conn->dst);
-	cp.pscan_rep_mode = 0x02;
-
-	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
-	if (ie) {
-		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
-			cp.pscan_rep_mode = ie->data.pscan_rep_mode;
-			cp.pscan_mode     = ie->data.pscan_mode;
-			cp.clock_offset   = ie->data.clock_offset |
-					    cpu_to_le16(0x8000);
-		}
-
-		memcpy(conn->dev_class, ie->data.dev_class, 3);
-	}
-
-	cp.pkt_type = cpu_to_le16(conn->pkt_type);
-	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))
-		cp.role_switch = 0x01;
-	else
-		cp.role_switch = 0x00;
-
-	hci_send_cmd(hdev, HCI_OP_CREATE_CONN, sizeof(cp), &cp);
-}
-
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
 	BT_DBG("hcon %p", conn);
@@ -1700,10 +1642,17 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 
 	acl->conn_reason = conn_reason;
 	if (acl->state == BT_OPEN || acl->state == BT_CLOSED) {
+		int err;
+
 		acl->sec_level = BT_SECURITY_LOW;
 		acl->pending_sec_level = sec_level;
 		acl->auth_type = auth_type;
-		hci_acl_create_connection(acl);
+
+		err = hci_acl_create_conn(hdev, acl);
+		if (err) {
+			hci_conn_del(acl);
+			return ERR_PTR(err);
+		}
 	}
 
 	return acl;
@@ -2658,7 +2607,7 @@ void hci_conn_check_pending(struct hci_dev *hdev)
 
 	conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
 	if (conn)
-		hci_acl_create_connection(conn);
+		hci_acl_create_conn(hdev, conn);
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b146562a65fc..3d434e9d2a15 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6490,3 +6490,77 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 	return hci_cmd_sync_queue(hdev, _update_adv_data_sync,
 				  UINT_PTR(instance), NULL);
 }
+
+int hci_acl_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct inquiry_entry *ie;
+	struct hci_cp_create_conn cp;
+	int err;
+
+	BT_DBG("hcon %p", conn);
+
+	/* Many controllers disallow HCI Create Connection while it is doing
+	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
+	 * Connection. This may cause the MGMT discovering state to become false
+	 * without user space's request but it is okay since the MGMT Discovery
+	 * APIs do not promise that discovery should be done forever. Instead,
+	 * the user space monitors the status of MGMT discovering and it may
+	 * request for discovery again when this flag becomes false.
+	 */
+	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+		err = __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY_CANCEL, 0,
+					    NULL, HCI_CMD_TIMEOUT);
+		if (err)
+			bt_dev_warn(hdev, "Failed to cancel inquiry %d", err);
+	}
+
+	conn->state = BT_CONNECT;
+	conn->out = true;
+	conn->role = HCI_ROLE_MASTER;
+
+	conn->attempt++;
+
+	conn->link_policy = hdev->link_policy;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.bdaddr, &conn->dst);
+	cp.pscan_rep_mode = 0x02;
+
+	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+	if (ie) {
+		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
+			cp.pscan_rep_mode = ie->data.pscan_rep_mode;
+			cp.pscan_mode     = ie->data.pscan_mode;
+			cp.clock_offset   = ie->data.clock_offset |
+					    cpu_to_le16(0x8000);
+		}
+
+		memcpy(conn->dev_class, ie->data.dev_class, 3);
+	}
+
+	cp.pkt_type = cpu_to_le16(conn->pkt_type);
+	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))
+		cp.role_switch = 0x01;
+	else
+		cp.role_switch = 0x00;
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+				       sizeof(cp), &cp,
+				       HCI_EV_CONN_COMPLETE,
+				       HCI_ACL_CONN_TIMEOUT, NULL);
+
+	if (err == -ETIMEDOUT)
+		hci_abort_conn_sync(hdev, conn, HCI_ERROR_LOCAL_HOST_TERM);
+
+	return err;
+}
+
+static int acl_create_conn_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_acl_create_conn_sync(hdev, data);
+}
+
+int hci_acl_create_conn(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue(hdev, acl_create_conn_sync, conn, NULL);
+}
-- 
2.43.0

