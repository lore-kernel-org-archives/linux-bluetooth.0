Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9110145B18
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118691; cv=none; b=dRBgk5Rni5wL/UFJ83fvPyjGxCwz7SSSF697IyCMjpKpeE0c7ohO6SUvnmVxP77GBRN97Ht+IPvXpnv4nppl400IZyhx2ffqVY3TcQOl2FX177KZyxQnWQM7h4xisaRCU/p+Itnsa61NtzeW1z8FtDe33YnKI9HTfWTs0s0cDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118691; c=relaxed/simple;
	bh=v7Fcntne7XvJljE41ZYuzxgCP1cWt3A0YpKT5dW3T+w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KEe8yd+ijk8HtKYx6B3KxMI8h/jCYw/+C8utG7ZAvGz6L1TtYQBED9wEvSZoEUEDNRWldukpSTkWyFSEntPPP0+umPGQxKhiEfMrbPtnQUaSZMqYUniMYNr1aQXCTe+ot+KMQaNxYRE6tG61oGn3C15lrXxiunk9glbCmRcR48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbJgvHsq; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbJgvHsq"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4c01076b9faso1120161e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 13:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708118687; x=1708723487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bgRiGZlqlzH2NX42+KuQe0n9p/7Mp084jzmcTTQBhc=;
        b=XbJgvHsqgJQ/GY737j/WFCAIF59HsGfECj08rIoHX9GLUs9a8lICfDYAAncybZ5Tud
         IhfVX8hmZZJGtGz6gLRqsA7M25Ry/7Pxj6BdhZMLCXp0Q6D2e2QFU5/+VqMNhBDfVDFy
         92AeBj3IPZ3tRFWxGDBrEKLfV4JEO9oZR3jHy8NMD6s8fnzeheWYrOIA71jrzddEJfts
         XZlGKCOu1H/aqOa4W7gRmsntW/zUnUwZLGpfUa5q4Rp100xb4ABwlqeXvWnkBQY6J+Oe
         BS/RoThQ9qMgaYH4sCUXXtQ0meuv9Ai3aW0Zy/wJwlfu2PnuUHtstyHrN+ZFgzQKxwS3
         e23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118687; x=1708723487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bgRiGZlqlzH2NX42+KuQe0n9p/7Mp084jzmcTTQBhc=;
        b=n1HFVEvjj2GmQ1kBXSX/yhk80hJgfmAdpAtMTiPbVwgZd0XlByIIpldHbjYTjkKf6Y
         yawmYHbwTHVY3Tzp/VKst+j5bhs0lAROXO3V7Edpu3zgerGNY6jhvL/Qa08Xdb72D0Q1
         20oMv4zG6LGsLOov3dyzXoA4QoHQQPMrfAp8pPWlHNU/4IpIYPnynLSamamwgzD3V+96
         Dsm5kl1rmSO27p3WPQxgQIWqU6WIUJw0cVWWKNSX22jLsf+Hrbqq1BOSxWXdofB6XHia
         htUTpsTpUtJIboKtV20UVvUVnSHBeFpcRODbsdswo/vRwcX9CXsmFlbMuhZ6JwMcqVEs
         3kqQ==
X-Gm-Message-State: AOJu0YxzjEkfhpwXWHUcMAIu2X5xCMLB6d8MEki+ZHmyJ9K8U83Z2c3s
	e9CtJWGknxQU1M/kX7Ig/NxHIn+7WjOVH2jrZB39hFxdxlqY5PLKjxFdZc+t
X-Google-Smtp-Source: AGHT+IERYEN6yNAxpA8TGZzxOW93s3ZhqYo1YgdAj63cfGIPNkn/1vx4MU/8tvnxxr9wI4JRmqVdRA==
X-Received: by 2002:a05:6122:2707:b0:4c7:5506:4ef2 with SMTP id ej7-20020a056122270700b004c755064ef2mr1313610vkb.2.1708118687442;
        Fri, 16 Feb 2024 13:24:47 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id dz14-20020a0561221aae00b004c038e766afsm102111vkb.34.2024.02.16.13.24.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:24:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix overwriting request callback
Date: Fri, 16 Feb 2024 16:24:45 -0500
Message-ID: <20240216212445.124544-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In a few cases the stack may generate commands as responses to events
which would happen to overwrite the sent_cmd, so this attempts to store
the request in req_skb so even if sent_cmd is replaced with a new
command the pending request will remain in stored in req_skb.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  |  2 +-
 net/bluetooth/hci_core.c  | 46 +++++++++++++++++++++++++++------------
 net/bluetooth/hci_event.c | 18 +++++++--------
 net/bluetooth/hci_sync.c  | 12 ++++++++++
 4 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 21e0b4064d05..1acc75a49bb0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2893,7 +2893,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * connection can be in BT_CONNECT at time.
 	 */
 	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
-		switch (hci_skb_event(hdev->sent_cmd)) {
+		switch (hci_skb_event(hdev->req_skb)) {
 		case HCI_EV_CONN_COMPLETE:
 		case HCI_EV_LE_CONN_COMPLETE:
 		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 34c8dca2069f..6ca4c0df9f9c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1522,8 +1522,8 @@ static void hci_cmd_timeout(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    cmd_timer.work);
 
-	if (hdev->sent_cmd) {
-		u16 opcode = hci_skb_opcode(hdev->sent_cmd);
+	if (hdev->req_skb) {
+		u16 opcode = hci_skb_opcode(hdev->req_skb);
 
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
 
@@ -2828,6 +2828,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	ida_destroy(&hdev->unset_handle_ida);
 	ida_free(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
+	kfree_skb(hdev->req_skb);
 	kfree_skb(hdev->recv_event);
 	kfree(hdev);
 }
@@ -3157,21 +3158,33 @@ int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
 EXPORT_SYMBOL(__hci_cmd_send);
 
 /* Get data from the previously sent command */
-void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
+static void *hci_cmd_data(struct sk_buff *skb, __u16 opcode)
 {
 	struct hci_command_hdr *hdr;
 
-	if (!hdev->sent_cmd)
+	if (!skb || skb->len < HCI_COMMAND_HDR_SIZE)
 		return NULL;
 
-	hdr = (void *) hdev->sent_cmd->data;
+	hdr = (void *)skb->data;
 
 	if (hdr->opcode != cpu_to_le16(opcode))
 		return NULL;
 
-	BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
+	return skb->data + HCI_COMMAND_HDR_SIZE;
+}
 
-	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
+/* Get data from the previously sent command */
+void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
+{
+	void *data;
+
+	/* Check if opcode matches last sent command */
+	data = hci_cmd_data(hdev->sent_cmd, opcode);
+	if (!data)
+		/* Check if opcode matches last request */
+		data = hci_cmd_data(hdev->req_skb, opcode);
+
+	return data;
 }
 
 /* Get data from last received event */
@@ -4072,17 +4085,19 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 	if (!status && !hci_req_is_complete(hdev))
 		return;
 
+	skb = hdev->req_skb;
+
 	/* If this was the last command in a request the complete
-	 * callback would be found in hdev->sent_cmd instead of the
+	 * callback would be found in hdev->req_skb instead of the
 	 * command queue (hdev->cmd_q).
 	 */
-	if (bt_cb(hdev->sent_cmd)->hci.req_flags & HCI_REQ_SKB) {
-		*req_complete_skb = bt_cb(hdev->sent_cmd)->hci.req_complete_skb;
+	if (skb && bt_cb(skb)->hci.req_flags & HCI_REQ_SKB) {
+		*req_complete_skb = bt_cb(skb)->hci.req_complete_skb;
 		return;
 	}
 
-	if (bt_cb(hdev->sent_cmd)->hci.req_complete) {
-		*req_complete = bt_cb(hdev->sent_cmd)->hci.req_complete;
+	if (skb && bt_cb(skb)->hci.req_complete) {
+		*req_complete = bt_cb(skb)->hci.req_complete;
 		return;
 	}
 
@@ -4199,8 +4214,11 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (hci_req_status_pend(hdev))
-		hci_dev_set_flag(hdev, HCI_CMD_PENDING);
+	if (hci_req_status_pend(hdev) &&
+	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
+		kfree_skb(hdev->req_skb);
+		hdev->req_skb = skb_clone(skb, GFP_KERNEL);
+	}
 
 	atomic_dec(&hdev->cmd_cnt);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6071a1226e1b..bffd2c7ff608 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4368,7 +4368,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 	 * (since for this kind of commands there will not be a command
 	 * complete event).
 	 */
-	if (ev->status || (hdev->sent_cmd && !hci_skb_event(hdev->sent_cmd))) {
+	if (ev->status || (hdev->req_skb && !hci_skb_event(hdev->req_skb))) {
 		hci_req_cmd_complete(hdev, *opcode, ev->status, req_complete,
 				     req_complete_skb);
 		if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
@@ -7170,10 +7170,10 @@ static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "subevent 0x%2.2x", ev->subevent);
 
 	/* Only match event if command OGF is for LE */
-	if (hdev->sent_cmd &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) == 0x08 &&
-	    hci_skb_event(hdev->sent_cmd) == ev->subevent) {
-		*opcode = hci_skb_opcode(hdev->sent_cmd);
+	if (hdev->req_skb &&
+	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 &&
+	    hci_skb_event(hdev->req_skb) == ev->subevent) {
+		*opcode = hci_skb_opcode(hdev->req_skb);
 		hci_req_cmd_complete(hdev, *opcode, 0x00, req_complete,
 				     req_complete_skb);
 	}
@@ -7541,10 +7541,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	/* Only match event if command OGF is not for LE */
-	if (hdev->sent_cmd &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) != 0x08 &&
-	    hci_skb_event(hdev->sent_cmd) == event) {
-		hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->sent_cmd),
+	if (hdev->req_skb &&
+	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) != 0x08 &&
+	    hci_skb_event(hdev->req_skb) == event) {
+		hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->req_skb),
 				     status, &req_complete, &req_complete_skb);
 		req_evt = event;
 	}
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 4a28aef2f01f..8acf62eb27dc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -39,6 +39,7 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		if (sk)
 			sock_put(sk);
 
+		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_get(skb);
 	}
 
@@ -4952,6 +4953,11 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 			hdev->sent_cmd = NULL;
 		}
 
+		if (hdev->req_skb) {
+			kfree_skb(hdev->req_skb);
+			hdev->req_skb = NULL;
+		}
+
 		clear_bit(HCI_RUNNING, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
@@ -5112,6 +5118,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 		hdev->sent_cmd = NULL;
 	}
 
+	/* Drop last request */
+	if (hdev->req_skb) {
+		kfree_skb(hdev->req_skb);
+		hdev->req_skb = NULL;
+	}
+
 	clear_bit(HCI_RUNNING, &hdev->flags);
 	hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
-- 
2.43.0

