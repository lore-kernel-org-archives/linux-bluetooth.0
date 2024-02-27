Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942214F97B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071475; cv=none; b=KLQG4wqGrU4dq+cTUm5CP5TBUXz+haKNm/v/cd9B6brE02mwfI3cPtvz9HK4wXNYEvkTSecZ+OkhwTIAHmpwOCSIvD0K4QM6F9SL0N47vNs2KCmXVEb5Ft/pfA3N7GJEfSjeTxn8WLg4U8WrSsd3ujWXJO/ecC8PZSo2IPQThEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071475; c=relaxed/simple;
	bh=f15NgYgjF/ptbyvVweeFpySq69PVWc1MJLENQ4+4cpY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HP86o2BNQXemW3nYgDyn2mGZ/xw577fmDrV5unhMpOwr4Bsc074HJcTLh9hH1s7xmiOBUe7x1jGXUbwpw1flcMWv3nQ7Mex2Ylpws82RJgX9iGprPLBSnPtEr/jPPn3Jx4dvH9FsfMIaU41MjxtOaskLA0/CrtabWUq2ww76TrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+uHAcuc; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+uHAcuc"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4705082131bso739431137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 14:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071472; x=1709676272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz91EUhDI95zQJTR5d22mUz3GCLbPNzII5DPZId2eBo=;
        b=X+uHAcuckwhLeMrBrDZO+1ruZX6h9+j7QoBd/4BizlVyY2Deak3Cf01V3MUCbLYJLN
         fHY+GcNhxGq5hoU3eLm1jF2nBj3GMgnZJUlJeuib/D2+UoEU80EoJn3/Ly1nkx74dN+K
         oa+FH8/gotIH4xE0nzn6W+6SNQ4z7qTLivHh7LZHkSWaNa6p4/pf87Je2IZj2tXOPCnV
         1urOqbhOgb00viqMRb0foXFBV7SNrNauktrUWDptXGj5+4NudcG1vTX3F0MxB4fajcPA
         MPEf5ufPdYT2uf6/6UKgKiT0b7lMAXREpsBynxAhfzu5u3/4BeW4wIxikJ7Up5UFicZC
         ffuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071472; x=1709676272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz91EUhDI95zQJTR5d22mUz3GCLbPNzII5DPZId2eBo=;
        b=D+M5Plb5pkc9bhs/1oRZB7+MKpsFS8G/F/7wLf9NcdmsC2CNA/nYZ3E2cEASdCWdL6
         q7t5N8zpvjDC2CFiAGaDyQcLCMNNA7u+ZaH9OfSP4LDFozshJzr/nvWhMvz1TGPKHr/F
         +e0+fu+kjvi8NjCowgjdJIDMHZFmX5Ol4JxMNT91Bsw1IIhln+ad0ksxkf5Nv6eogECu
         yczPWiiS8BZzzyGmWPVRUb7Zbk7fJgWIZFaCsOvGTMLfYeskcm3dyqgMk4cv4oCEo6b3
         0D1d3Zr7wN0iuAvzB30FRh9u5Vmse0bpuPtVASTlT0WvinNniWF/dMb5nHGf0l/Bn+zE
         U4sg==
X-Gm-Message-State: AOJu0YzUf44LsXYoQvYGlE/oE0kZqevd45e1qbd4tI2v34Zq/lKSBL7h
	tz0Sf15SRF5Rl36eaPO7QkRqFmYirqbgQdX5I0i0RYqgq5840k7QWYQoKmE2
X-Google-Smtp-Source: AGHT+IHmUx9/MOr8g36rPb0buMQ+5cUnCnAEnmb6/uNzRRfq9psHJ4yyuenQiHwmgSnaNzn7SYv3og==
X-Received: by 2002:a05:6102:724:b0:470:4093:7008 with SMTP id u4-20020a056102072400b0047040937008mr8297030vsg.21.1709071470572;
        Tue, 27 Feb 2024 14:04:30 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id m6-20020ab07506000000b007d66052dcf9sm1180822uap.17.2024.02.27.14.04.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:04:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_sync: Fix overwriting request callback
Date: Tue, 27 Feb 2024 17:04:28 -0500
Message-ID: <20240227220428.2035718-1-luiz.dentz@gmail.com>
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

Fixes: 6a98e3836fa2 ("Bluetooth: Add helper for serialized HCI command execution")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 46 ++++++++++++++++++++++----------
 net/bluetooth/hci_event.c        | 18 ++++++-------
 net/bluetooth/hci_sync.c         | 21 ++++++++++++---
 5 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index da6aa6549b81..56fb42df44a3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -552,6 +552,7 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 	struct sk_buff		*req_skb;
+	struct sk_buff		*req_rsp;
 
 	void			*smp_data;
 	void			*smp_bredr_data;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 54d4189c198a..3ad74f76983b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2918,7 +2918,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 		case HCI_EV_LE_CONN_COMPLETE:
 		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
 		case HCI_EVT_LE_CIS_ESTABLISHED:
-			hci_cmd_sync_cancel(hdev, -ECANCELED);
+			hci_cmd_sync_cancel(hdev, ECANCELED);
 			break;
 		}
 	/* Cancel connect attempt if still queued/pending */
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
index 10aa59da735b..8a3d0d1f7871 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -32,6 +32,10 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	hdev->req_result = result;
 	hdev->req_status = HCI_REQ_DONE;
 
+	/* Free the request command so it is not used as response */
+	kfree_skb(hdev->req_skb);
+	hdev->req_skb = NULL;
+
 	if (skb) {
 		struct sock *sk = hci_skb_sk(skb);
 
@@ -39,7 +43,7 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		if (sk)
 			sock_put(sk);
 
-		hdev->req_skb = skb_get(skb);
+		hdev->req_rsp = skb_get(skb);
 	}
 
 	wake_up_interruptible(&hdev->req_wait_q);
@@ -187,8 +191,8 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hdev->req_status = 0;
 	hdev->req_result = 0;
-	skb = hdev->req_skb;
-	hdev->req_skb = NULL;
+	skb = hdev->req_rsp;
+	hdev->req_rsp = NULL;
 
 	bt_dev_dbg(hdev, "end: err %d", err);
 
@@ -5021,6 +5025,11 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 			hdev->sent_cmd = NULL;
 		}
 
+		if (hdev->req_skb) {
+			kfree_skb(hdev->req_skb);
+			hdev->req_skb = NULL;
+		}
+
 		clear_bit(HCI_RUNNING, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
@@ -5181,6 +5190,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
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

