Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9D38DFE
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIi2fuCB"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-206689895bfso160117fac.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 08:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704819355; x=1705424155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kaj4o1EzoBBTs91Tj2r6bhonyRaITOo+z7z+2TSNj40=;
        b=HIi2fuCBmmF+p5gL25tR4UwFwgM1QNSfl69wYrPqGuxqimKyqDnrJnDeb00dCinZUU
         SW0DEj/0BVO626to9q6+4HJyybWRmXMIhyLY6F6mzKwGQcvt+calW2HGpyBRfhi1j8Fk
         G0POeKjO4XOzVcaBuIfuoQDG+yEqu+X4ZMzFKzYvH5aDdMDsbojRN3xbKgzMAVjg+Zao
         ERLP5A6xeA5ns2/h+I4o77TgpCGV6MFI5kV8jxZoHGj32WEhORrgbC3moJAdYF/HvuTD
         BUKax9QESRn6U+8IgDUkXCUsr0FyaDdfkgcu4BbCcIh2jBWLSa+1snhakdBqNRqew9t3
         Yl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819355; x=1705424155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kaj4o1EzoBBTs91Tj2r6bhonyRaITOo+z7z+2TSNj40=;
        b=Hwf12DpENzqxPifjAadyT3QUDAKm2gG1h+9YYmOeOepbCgPiPfp2aJ4xAB85QaNB76
         GRd1tht0fWkNbRBeucsrVMlUZ4YhA5bQUi+QMygmJZyMW9aky2l3fKocem9r+Mqf5VBz
         T9koOMymI4Z2Jn3PQF4cSK2r//GiW3R8mRaj+JXvfXNpU7zIw0hT4gq3tcAU0t9MKVNL
         wFh6BbFPBxUJSXGikJ+KlwT8q56vUjQ9Cndvz1eILC4bM/Csn8bSuzCk/S6wVsToxyZG
         Pd2q1xPY8c4VAuDq6cAwaUhFn/kdmnByxhCAg+5nqaD+GC/Qq1LnMFuebnYx+mBtM7eo
         wK8w==
X-Gm-Message-State: AOJu0YzX1hIOOC92f6ahPBPy5FegV67e3JUQ64H9X6l9sZEsxvnVB36M
	0ITOBmXLtjwO/+CshAzChE0Ixu5ZPFA=
X-Google-Smtp-Source: AGHT+IEWL2sqYSSEgdhKWUmvCc8rWaw7BPW6UCSv8NkpTx4ZpSj+Utzwb7WJos0ljEo6C4tmpiv3ng==
X-Received: by 2002:a05:6871:5b1f:b0:203:10ab:f237 with SMTP id op31-20020a0568715b1f00b0020310abf237mr4774176oac.33.1704819354634;
        Tue, 09 Jan 2024 08:55:54 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bb39-20020a056871b22700b0020520aee37bsm533874oac.47.2024.01.09.08.55.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 08:55:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: hci_event: Rework hci_store_wake_reason
Date: Tue,  9 Jan 2024 11:55:52 -0500
Message-ID: <20240109165552.430359-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reworks the hci_store_wake_reason so it doesn't attempt to parse
the events inline and instead just become a helper for event callbacks
to call to when they are considered a valid event to wakeup.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 101 +++++++++++---------------------------
 1 file changed, 29 insertions(+), 72 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 22b22c264c2a..92e673903582 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3135,6 +3135,26 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_wakeup(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	/* If we are currently suspended and this is the first BT event seen,
+	 * save the wake reason associated with the event.
+	 */
+	if (!hdev->suspended || hdev->wake_reason)
+		return;
+
+	/* Default to remote wake. Values for wake_reason are documented in the
+	 * Bluez mgmt api docs.
+	 */
+	if (addr) {
+		hdev->wake_reason = MGMT_WAKE_REASON_REMOTE_WAKE;
+		bacpy(&hdev->wake_addr, addr);
+		hdev->wake_addr_type = addr_type;
+	} else {
+		hdev->wake_reason = MGMT_WAKE_REASON_UNEXPECTED;
+	}
+}
+
 static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
@@ -3146,6 +3166,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	hci_wakeup(hdev, &ev->bdaddr, BDADDR_BREDR);
+
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 	if (!conn) {
 		/* In case of error status and there is no connection pending
@@ -3306,6 +3328,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	hci_wakeup(hdev, &ev->bdaddr, BDADDR_BREDR);
+
 	if (hci_bdaddr_list_lookup(&hdev->reject_list, &ev->bdaddr,
 				   BDADDR_BREDR)) {
 		hci_reject_conn(hdev, &ev->bdaddr);
@@ -6266,6 +6290,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	u32 flags;
 	u8 *ptr;
 
+	hci_wakeup(hdev, bdaddr, bdaddr_type);
+
 	switch (type) {
 	case LE_ADV_IND:
 	case LE_ADV_DIRECT_IND:
@@ -7393,75 +7419,6 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 	return true;
 }
 
-static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
-				  struct sk_buff *skb)
-{
-	struct hci_ev_le_advertising_info *adv;
-	struct hci_ev_le_direct_adv_info *direct_adv;
-	struct hci_ev_le_ext_adv_info *ext_adv;
-	const struct hci_ev_conn_complete *conn_complete = (void *)skb->data;
-	const struct hci_ev_conn_request *conn_request = (void *)skb->data;
-
-	hci_dev_lock(hdev);
-
-	/* If we are currently suspended and this is the first BT event seen,
-	 * save the wake reason associated with the event.
-	 */
-	if (!hdev->suspended || hdev->wake_reason)
-		goto unlock;
-
-	/* Default to remote wake. Values for wake_reason are documented in the
-	 * Bluez mgmt api docs.
-	 */
-	hdev->wake_reason = MGMT_WAKE_REASON_REMOTE_WAKE;
-
-	/* Once configured for remote wakeup, we should only wake up for
-	 * reconnections. It's useful to see which device is waking us up so
-	 * keep track of the bdaddr of the connection event that woke us up.
-	 */
-	if (event == HCI_EV_CONN_REQUEST) {
-		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
-		hdev->wake_addr_type = BDADDR_BREDR;
-	} else if (event == HCI_EV_CONN_COMPLETE) {
-		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
-		hdev->wake_addr_type = BDADDR_BREDR;
-	} else if (event == HCI_EV_LE_META) {
-		struct hci_ev_le_meta *le_ev = (void *)skb->data;
-		u8 subevent = le_ev->subevent;
-		u8 *ptr = &skb->data[sizeof(*le_ev)];
-		u8 num_reports = *ptr;
-
-		if ((subevent == HCI_EV_LE_ADVERTISING_REPORT ||
-		     subevent == HCI_EV_LE_DIRECT_ADV_REPORT ||
-		     subevent == HCI_EV_LE_EXT_ADV_REPORT) &&
-		    num_reports) {
-			adv = (void *)(ptr + 1);
-			direct_adv = (void *)(ptr + 1);
-			ext_adv = (void *)(ptr + 1);
-
-			switch (subevent) {
-			case HCI_EV_LE_ADVERTISING_REPORT:
-				bacpy(&hdev->wake_addr, &adv->bdaddr);
-				hdev->wake_addr_type = adv->bdaddr_type;
-				break;
-			case HCI_EV_LE_DIRECT_ADV_REPORT:
-				bacpy(&hdev->wake_addr, &direct_adv->bdaddr);
-				hdev->wake_addr_type = direct_adv->bdaddr_type;
-				break;
-			case HCI_EV_LE_EXT_ADV_REPORT:
-				bacpy(&hdev->wake_addr, &ext_adv->bdaddr);
-				hdev->wake_addr_type = ext_adv->bdaddr_type;
-				break;
-			}
-		}
-	} else {
-		hdev->wake_reason = MGMT_WAKE_REASON_UNEXPECTED;
-	}
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
 #define HCI_EV_VL(_op, _func, _min_len, _max_len) \
 [_op] = { \
 	.req = false, \
@@ -7726,14 +7683,14 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb_pull(skb, HCI_EVENT_HDR_SIZE);
 
-	/* Store wake reason if we're suspended */
-	hci_store_wake_reason(hdev, event, skb);
-
 	bt_dev_dbg(hdev, "event 0x%2.2x", event);
 
 	hci_event_func(hdev, event, skb, &opcode, &status, &req_complete,
 		       &req_complete_skb);
 
+	/* Force hci_wakeup with NULL addr if no event callback had called it */
+	hci_wakeup(hdev, NULL, 0);
+
 	if (req_complete) {
 		req_complete(hdev, status, opcode);
 	} else if (req_complete_skb) {
-- 
2.43.0

