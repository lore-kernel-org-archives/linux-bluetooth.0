Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0327447
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446707; cv=none; b=Z94JKRA9htX8B2mM6vy2lCOJYrHKtKQVAGteJtGB1FfVvJo+82ulPSw2bC0ZoWIdTVZvfjGaA+gelaoxNgsa8foVd9B15B5C/cGVwQdJiL0yT0Cf0rBKIbvrqHxajMhLxKX8/YnaHUetttfYQZyIu+hswgFDKRZPzjr4HjZdHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446707; c=relaxed/simple;
	bh=jnCg1kAkNfZbgwhiD3cdPywllmq/5lrE2tL6NuAnT58=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ilG6Km/TxXEVa/+llVJ8FG8lQCiD3If0B635hA5oCxVEfknWWuS7bJwlUOWip5sdnUA64bXF6Q4WimPtul5k+VFHR2MsZKHEQ4nA1zYb44tJbXuD0EcMj6OI7OxnkBBlpsOt+09Jw2P0RuPQDxTGfVzob5HCMMzf0CUPKuRv/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHYzEe8w; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHYzEe8w"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c857f1c18cso559388e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 08:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708446704; x=1709051504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBjtOfYlMDEoFd1pIB8iTjT0LlWK/V0yia49T1AmMKY=;
        b=FHYzEe8waPCNeM/ecBf0p22X1kh6ricZlvxby5HSP11W7EhK0vSb45sR+7XDY6r9q4
         Ii5OhswQydQhkSpIGScW6DgkWyfu4szw65dOZFQaieQ+GAlrtexyYBUMofl8Q+YBQqhf
         ujpj8blmKZO6eAfmV/xNijZeRiDakVcpOhFaPO/oNt+8YfD1edMXpXoBzj9UU4hDy77d
         DY1AuZEWGUvmLw27kVFb4VUxQu24bbKNrYh7DNjx3QAG3N2OUb5rTM3lKdhvxcGp4zk1
         RRoFEH03dU5GqUsBOkWUdBefhh/IzOlPyi/DyyEQNWGDtfEfu8GtCRkhq0FjRtjfNOpl
         A8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708446704; x=1709051504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBjtOfYlMDEoFd1pIB8iTjT0LlWK/V0yia49T1AmMKY=;
        b=Zp1K4he4+Hi4HjkbEz6vMSUhlTTA2dQV2rPuczBByDEPwjLxdSkKOeoaOaKe5fR2kB
         JK9hQpv8MBjJFlsQv16CbKpvrrJwAukEcWN51veWmFnybPug0+RXuhWjyUj4hzFmw33f
         c76+SGUK5UcsysfOdRuGsqZ8tHdt0p63us/bEcBsoh0upKicbwCrvPt/ho4S2oDhlc59
         k8RQyOjafbj7z50J51hRbyvS+kswjC8/7xzYdXmPxxq051+IwtnfowCEaOSrGz7hh1/d
         EGz7PI+6PUQccRCRWzqvtjtlji4N/R1Y8vKwHEXiVcrgD6OobsJtatSqiqXsOIarucra
         H4bg==
X-Gm-Message-State: AOJu0Yy+dDLe1zPgcPW3yi5gKZjiHm2paKxSfvjUN/OYwQmEB4b4VlLj
	4eHXSWJGrcS2QfXeIJQEmVDZzlbz9cQK0kYFA7SBJtJU8qAZJPz/1s6Tc8+7
X-Google-Smtp-Source: AGHT+IF3kLeKX2DicUrDkxGfaYW3R7SS1Lc8lyg9gzEsixv03Vee/NH5v+F+URpNRT9bIw0JOcvXeA==
X-Received: by 2002:a1f:cc86:0:b0:4c0:e29:c438 with SMTP id c128-20020a1fcc86000000b004c00e29c438mr13174054vkg.8.1708446704145;
        Tue, 20 Feb 2024 08:31:44 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l75-20020a1ffe4e000000b004c9793bed42sm987788vki.37.2024.02.20.08.31.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 08:31:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix overwriting request callback
Date: Tue, 20 Feb 2024 11:31:41 -0500
Message-ID: <20240220163141.354936-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c  | 15 +++++++++++++
 4 files changed, 57 insertions(+), 24 deletions(-)

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
index 4a28aef2f01f..7306020ccda3 100644
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
 
@@ -4952,6 +4956,11 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 			hdev->sent_cmd = NULL;
 		}
 
+		if (hdev->req_skb) {
+			kfree_skb(hdev->req_skb);
+			hdev->req_skb = NULL;
+		}
+
 		clear_bit(HCI_RUNNING, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
@@ -5112,6 +5121,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
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

