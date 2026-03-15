Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9534EEE7
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577427; cv=none; b=YT5AJTnRDr+AsOJ8VEtaurMqm7J1ociHhPMhQn8cgEP5lHY4HcPhwamQrmY1RLBENq1IIXEhJLvl/7mnaG4qgRfX69NDc1Yt76f19FkArj6id2RaLRKzSIsFrvNXTyAxizWYOg6zhCu+x5mFyFcZqYVeZ4Dc9jS9MEfOPZz8Bf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577427; c=relaxed/simple;
	bh=mTsAFaXacqnW48UkKN6ehxn0iOX+CEp8wT75dIpaAmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sA/d5r3Pfv5aryrztM9UVSOOsOhdgur4odZb2x6b7+YgIjYswKyJudc5gOWYyKOhOAXb3zZQSToxeHNH+542WMY9x3TAx37g/ddS6TjQ8vBf3Uw9OB6/ah8wDcjynACf/XeAfaSHYXuVSlkwSCvpGUaZY0E8ynzeunXaS3a60b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqOiWl3R; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqOiWl3R"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso1499380a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773577424; x=1774182224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev7olukrabSeI4uImqOW82xjRpOYvekb7Hyttgv7/9Q=;
        b=PqOiWl3RJkTIRK/FtDQ70zUr/hGR+DcqoR61LtGGrcdCgOHg1G9X7jhOXflZEt+aDs
         hFYfT82ZYD3SnGPXiQMqHcRIrLgUDCH9UnzpOzWba/NsvV2aJs9e3+yC7x5/8AMVTpX0
         BWuJCgh+9SY/Jr0Ayh2qgiyp7+dZPvUa7XDtTyoW7sbXbu2/jVLtn67D966VYVNNmHRe
         ZeHSvqpNXFBC+P7gaYUwQ8DlhqMWj6mEhtdv7YNq98J37kgEmOkCA1WUMk9eYoPSWEBE
         Ml+qOWglfLDpu89BxIaZhtuwySBCDh6CXVsgJLQ7WXyTc1Vnot0lTFZtImUcqks3i9b3
         io4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773577424; x=1774182224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev7olukrabSeI4uImqOW82xjRpOYvekb7Hyttgv7/9Q=;
        b=NznWA6viX6sh3g81EuNG+FZkx8XRh0EEsNY66cmBNHGfssIslroG0DdgBenUUqtKZ6
         fkyu13b6ixuKhTEupbzZ5d5uvFvW/6k6lncmfIHh3XHtDgwogEuFDZmiVn5/37YOJk4v
         qx6qLoAFeE038zmbGLfVcxl/1s0NTRudjOIh+fKsPCPD3LE+gp1UzK7Qlek3/dDRLIRw
         Cj14ZAgVIWomYQQFtWwb73HnC12PNSfy6GKHxqVrS3Z0CxcJ0R1+g22EzeHuIaZSJrh8
         5oDe3WarzAY/zmEqZqadFokv863sXfV3d1nwGoJvpE5j0aNnNDuqG2vCTIAKrx+ehX2C
         586Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaKC2uKTTIey3sIv/0WS9XDgvpfxoiVzanp3j1TU+jqYu4laxHDfO71bCtlsfOLyfv/AKIXLVRgPWrckm6jPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMgjhRSdL6uym78ORqPMDMhXpKjAny4VuTnBY3kls9gHltLHi
	j8s3JrUkERNVrDr6Cl18UEVTiq0txGYvBDhYoRXLXbAG5UDEYdqiflie
X-Gm-Gg: ATEYQzxP+6FRufsV4t7yWh/tvVenGHnYe79qQYL52VL7QEHW6ZEvgGyJO8/eT7gi79S
	gDqSKaY0r+L+/oMvWJbf3OknY01dklFxUjGNTahUKaUtST5MpjSt8WVhTjOpXuoNxA49BJW9lAW
	HeiCdJxzQYc46/hF6Q2p4Xs/giO3OWIu6InJOFe0fKHgezKiT2oqPf4Mc7ATfEh435iJImHdw+x
	KPSiglkbnOZhscLk7lW79l+NouKsIcPBW38cCPhkgVFnQZ9xRpqHC08ASNDJVTL3WcuDAd2ygV3
	BCw+3Paih2ql+tQBMWrQ8wX/++KUF3xYMCSueK9D11NSSIEATztWx7tBDU0a6IvrP+ItSymuNcl
	TjBmT3xz4Vo8g7TVktk0oznhu1cYYDGhzfwvEkvJFvFH7wiKsT0YCks3wi5jGN1ZJabWYwpVe6d
	Do5MnLHMbGrP32lH/H82W2Be2HemNL
X-Received: by 2002:a17:903:3850:b0:2ae:cb0e:fd5e with SMTP id d9443c01a7336-2aecb0f01cdmr103020325ad.23.1773577424164;
        Sun, 15 Mar 2026 05:23:44 -0700 (PDT)
Received: from lavm-prs74opxn5.. ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee1d8sm81749935ad.55.2026.03.15.05.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 05:23:43 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	hanguidong02@gmail.com,
	ziyuzhang201@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: annotate data-races around hdev->req_status
Date: Sun, 15 Mar 2026 20:07:26 +0800
Message-Id: <20260315120726.2772382-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__hci_cmd_sync_sk() sets hdev->req_status under hdev->req_lock:

    hdev->req_status = HCI_REQ_PEND;

However, several other functions read or write hdev->req_status without
holding any lock:

  - hci_send_cmd_sync() reads req_status in hci_cmd_work (workqueue)
  - hci_cmd_sync_complete() reads/writes from HCI event completion
  - hci_cmd_sync_cancel() / hci_cmd_sync_cancel_sync() read/write
  - hci_abort_conn() reads in connection abort path

Since __hci_cmd_sync_sk() runs on hdev->req_workqueue while
hci_send_cmd_sync() runs on hdev->workqueue, these are different
workqueues that can execute concurrently on different CPUs. The plain
C accesses constitute a data race.

Add READ_ONCE()/WRITE_ONCE() annotations on all concurrent accesses
to hdev->req_status to prevent potential compiler optimizations that
could affect correctness (e.g., load fusing in the wait_event
condition or store reordering).

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/hci_conn.c |  2 +-
 net/bluetooth/hci_core.c |  2 +-
 net/bluetooth/hci_sync.c | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4719dac07190..81c4df0ade0f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3095,7 +3095,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * hci_connect_le serializes the connection attempts so only one
 	 * connection can be in BT_CONNECT at time.
 	 */
-	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
+	if (conn->state == BT_CONNECT && READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
 		switch (hci_skb_event(hdev->sent_cmd)) {
 		case HCI_EV_CONN_COMPLETE:
 		case HCI_EV_LE_CONN_COMPLETE:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 31308c1de4ec..01f8ceeb1c0c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4126,7 +4126,7 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(skb);
 	}
 
-	if (hdev->req_status == HCI_REQ_PEND &&
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 121dbc8208ec..335ec52a8e99 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -25,11 +25,11 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 {
 	bt_dev_dbg(hdev, "result 0x%2.2x", result);
 
-	if (hdev->req_status != HCI_REQ_PEND)
+	if (READ_ONCE(hdev->req_status) != HCI_REQ_PEND)
 		return;
 
 	hdev->req_result = result;
-	hdev->req_status = HCI_REQ_DONE;
+	WRITE_ONCE(hdev->req_status, HCI_REQ_DONE);
 
 	/* Free the request command so it is not used as response */
 	kfree_skb(hdev->req_skb);
@@ -167,20 +167,20 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hci_cmd_sync_add(&req, opcode, plen, param, event, sk);
 
-	hdev->req_status = HCI_REQ_PEND;
+	WRITE_ONCE(hdev->req_status, HCI_REQ_PEND);
 
 	err = hci_req_sync_run(&req);
 	if (err < 0)
 		return ERR_PTR(err);
 
 	err = wait_event_interruptible_timeout(hdev->req_wait_q,
-					       hdev->req_status != HCI_REQ_PEND,
+					       READ_ONCE(hdev->req_status) != HCI_REQ_PEND,
 					       timeout);
 
 	if (err == -ERESTARTSYS)
 		return ERR_PTR(-EINTR);
 
-	switch (hdev->req_status) {
+	switch (READ_ONCE(hdev->req_status)) {
 	case HCI_REQ_DONE:
 		err = -bt_to_errno(hdev->req_result);
 		break;
@@ -194,7 +194,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		break;
 	}
 
-	hdev->req_status = 0;
+	WRITE_ONCE(hdev->req_status, 0);
 	hdev->req_result = 0;
 	skb = hdev->req_rsp;
 	hdev->req_rsp = NULL;
@@ -665,9 +665,9 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	if (hdev->req_status == HCI_REQ_PEND) {
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
 		hdev->req_result = err;
-		hdev->req_status = HCI_REQ_CANCELED;
+		WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
 
 		queue_work(hdev->workqueue, &hdev->cmd_sync_cancel_work);
 	}
@@ -683,12 +683,12 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	if (hdev->req_status == HCI_REQ_PEND) {
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
 		/* req_result is __u32 so error must be positive to be properly
 		 * propagated.
 		 */
 		hdev->req_result = err < 0 ? -err : err;
-		hdev->req_status = HCI_REQ_CANCELED;
+		WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
 
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
-- 
2.34.1

