Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451845DF4B;
	Sun, 11 Oct 2026 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751222; cv=pass; b=IrXTTePbKxpq6AkuImen9EosIumyB80HjVpc2aXE6ssW6swhuXEFPb5g2kPf4b+UYxFH9NppOgm77J3t+IM7NlqTpcI19vD6drCsGBGqyvcUYmtJaUCob55crl24Lb3Ute2zRd8I1H0eMG0f4N9xYFd4ko15UEbSwgIKskWUa0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751222; c=relaxed/simple;
	bh=MybfeYPTbUU02Wa0jHNtzZpgxfoQPqNgew/1G6qRyRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPYr+PvWyzf3yddEuMRDNkfZz5hlGQon+/dQaAjFCQile1ReJ0IfRyKzlizQgK89M9IjdDbQ2tmDiuT8BwK1C7eDo8zeBdHmWv1KL/dVdF0q9Dn4LFnlcS3tUZ99pwz7nE2SHRCh19h5mCOInrKJuSKJ7DPq9Uo2D/74qWgWPhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cTXTtZJ6; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cTXTtZJ6"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2st05vJ2zyjt;
	Sun, 11 Oct 2026 23:40:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbAksH1fEnwrG+XtkzDeOzkc3g21X0Z9YYkTInWo1/0=;
	b=cTXTtZJ6eoNa452fXRwtbT7M7CaKt2BCa49OJrkzNYOqtcA+VUZFOErWMJ2jvV/gG28iDu
	galllp43FngV8Sl0XUe++AlMUIKoiFQjmXyxVXlbHkEYiHCQiV7sVxXTvpugZLsxnrdsU0
	iaHK4n099FLwuRIyR37wErKU8Gem09U=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751209;
	b=Bp2Vj6ZgD2SgSvJU2wlI5Vk4gsSAwB+TvVaqwMFGOH78KL8IZcM08Nt07waUJNsV3NmXtn
	yszk1kH6zmB/muE2PUOa1aAIECVxxxNEpZBpJy0ffi1CBNH2W8k/3hLICc450wEaPd5Odo
	H6leYP6yXc8/rMwYMgVTs1Z1U6ykGPs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbAksH1fEnwrG+XtkzDeOzkc3g21X0Z9YYkTInWo1/0=;
	b=pC4ueB2J1zOWnVKhBgCPkQznpb11+Bj/8nNXfvSUiOJuC0S2CrUYjFMxKRRIskg5QiE5Nw
	FRqaLJ2yNfMkFo684I4Tjh0G1Sr4tPnfG5z5PbefhCakX39RrbJSt+h1rlyCyc25jRDpzV
	/olyFA5YtleQlRNZXVL6+fxfpYuIetk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_sync: add request wait hook for __hci_cmd_sync_sk
Date: Sun, 11 Oct 2026 23:39:54 +0300
Message-ID: <fda2d67929dd3888eecaf1faaa97b3f3c16829ed.1791750397.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791750397.git.pav@iki.fi>
References: <cover.1791750397.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support doing something after hci_sync request event wait is armed, but
before wait starts. Currently hci_req_sync_run() queues cmd_work, which
sets hdev->req_skb and arms the wait, but hci_sync does not see when
this occurs.

This is needed by BIS PAST (separate patch) to signal userspace when
kernel starts waiting for PAST Received.

Introduce new pending hdev->req_status state HCI_REQ_QUEUE. cmd_work
transitions QUEUE -> PEND after setting hdev->req_skb which is where
event wait starts.

Fire the wait hook when __hci_cmd_sync_sk() has started waiting for its
event, and if that fails. If no wait hook, start directly with PEND, to
avoid the extra req_wait_q wakeup.

Rename the function to __hci_cmd_sync_sk_run(), add small wrappers to
preserve old API.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_sync.h | 10 +++-
 net/bluetooth/hci_core.c         |  9 +++-
 net/bluetooth/hci_sync.c         | 87 +++++++++++++++++++++++++-------
 3 files changed, 86 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 59cb918d1405..71736690ea7f 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -9,8 +9,11 @@
 #define PTR_UINT(_ptr)			((uintptr_t)((void *)_ptr))
 
 #define HCI_REQ_DONE	  0
-#define HCI_REQ_PEND	  1
-#define HCI_REQ_CANCELED  2
+#define HCI_REQ_QUEUE	  BIT(0)
+#define HCI_REQ_PEND	  (HCI_REQ_QUEUE | BIT(1))
+#define HCI_REQ_CANCELED  BIT(2)
+
+#define HCI_REQ_PENDING(req_status) (!!((req_status) & HCI_REQ_PEND))
 
 #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
 #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
@@ -25,6 +28,9 @@ struct hci_request {
 	int			err;
 };
 
+typedef void (*hci_request_wait_start_t)(struct hci_dev *hdev, void *data,
+					 int err);
+
 typedef int (*hci_cmd_sync_work_func_t)(struct hci_dev *hdev, void *data);
 typedef void (*hci_cmd_sync_work_destroy_t)(struct hci_dev *hdev, void *data,
 					    int err);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 209244fd9391..b9214eaffd2a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4183,11 +4183,18 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(skb);
 	}
 
-	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
+	if (HCI_REQ_PENDING(READ_ONCE(hdev->req_status)) &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		hci_dev_lock(hdev);
+
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_get(hdev->sent_cmd);
+
+		if ((bt_cb(hdev->req_skb)->hci.req_flags & HCI_REQ_SKB) &&
+		    cmpxchg(&hdev->req_status, HCI_REQ_QUEUE,
+			    HCI_REQ_PEND) == HCI_REQ_QUEUE)
+			wake_up_interruptible(&hdev->req_wait_q);
+
 		hci_dev_unlock(hdev);
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index efbd2e5387c0..058daf1f16df 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -25,7 +25,7 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 {
 	bt_dev_dbg(hdev, "result 0x%2.2x", result);
 
-	if (READ_ONCE(hdev->req_status) != HCI_REQ_PEND)
+	if (!HCI_REQ_PENDING(READ_ONCE(hdev->req_status)))
 		return;
 
 	hdev->req_result = result;
@@ -155,13 +155,16 @@ static void hci_request_init(struct hci_request *req, struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->req_lock. */
-struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
-				  const void *param, u8 event, u32 timeout,
-				  struct sock *sk)
+static struct sk_buff *__hci_cmd_sync_sk_run(struct hci_dev *hdev, u16 opcode,
+					     u32 plen, const void *param,
+					     u8 event, u32 timeout,
+					     struct sock *sk,
+					     hci_request_wait_start_t wait_func,
+					     void *wait_data)
 {
 	struct hci_request req;
 	struct sk_buff *skb;
-	int err = 0;
+	long err = 0;
 
 	bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
 
@@ -169,29 +172,58 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hci_cmd_sync_add(&req, opcode, plen, param, event, sk);
 
-	WRITE_ONCE(hdev->req_status, HCI_REQ_PEND);
+	WRITE_ONCE(hdev->req_status, wait_func ? HCI_REQ_QUEUE : HCI_REQ_PEND);
 
 	err = hci_req_sync_run(&req);
-	if (err < 0)
+	if (err < 0) {
+		if (wait_func)
+			wait_func(hdev, wait_data, err);
 		return ERR_PTR(err);
+	}
+
+	if (wait_func) {
+		/* Sleep until we have started waiting for the event */
+		err = wait_event_interruptible_timeout(hdev->req_wait_q,
+						       READ_ONCE(hdev->req_status) != HCI_REQ_QUEUE,
+						       timeout);
+		if (err <= 0 || !HCI_REQ_PENDING(READ_ONCE(hdev->req_status)))
+			goto check_state;
+
+		wait_func(hdev, wait_data, 0);
+		wait_func = NULL;
+
+		timeout = err;
+	}
 
 	err = wait_event_interruptible_timeout(hdev->req_wait_q,
-					       READ_ONCE(hdev->req_status) != HCI_REQ_PEND,
+					       !HCI_REQ_PENDING(READ_ONCE(hdev->req_status)),
 					       timeout);
 
-	if (err == -ERESTARTSYS)
+check_state:
+	if (err == -ERESTARTSYS) {
+		if (wait_func)
+			wait_func(hdev, wait_data, -EINTR);
 		return ERR_PTR(-EINTR);
+	}
 
 	switch (READ_ONCE(hdev->req_status)) {
 	case HCI_REQ_DONE:
+		if (wait_func)
+			wait_func(hdev, wait_data, -EAGAIN);
 		err = -bt_to_errno(hdev->req_result);
 		break;
 
 	case HCI_REQ_CANCELED:
-		err = -hdev->req_result;
+		if (wait_func)
+			wait_func(hdev, wait_data, -ECANCELED);
+		err = -(long)hdev->req_result;
+		if (!IS_ERR_VALUE(err))
+			err = -ECANCELED;
 		break;
 
 	default:
+		if (wait_func)
+			wait_func(hdev, wait_data, -ETIMEDOUT);
 		err = -ETIMEDOUT;
 		break;
 	}
@@ -201,7 +233,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	skb = hdev->req_rsp;
 	hdev->req_rsp = NULL;
 
-	bt_dev_dbg(hdev, "end: err %d", err);
+	bt_dev_dbg(hdev, "end: err %ld", err);
 
 	if (err < 0) {
 		kfree_skb(skb);
@@ -216,6 +248,15 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	return skb;
 }
+
+/* This function requires the caller holds hdev->req_lock. */
+struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
+				  const void *param, u8 event, u32 timeout,
+				  struct sock *sk)
+{
+	return __hci_cmd_sync_sk_run(hdev, opcode, plen, param, event, timeout,
+				     sk, NULL, NULL);
+}
 EXPORT_SYMBOL(__hci_cmd_sync_sk);
 
 /* This function requires the caller holds hdev->req_lock. */
@@ -255,14 +296,17 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 EXPORT_SYMBOL(__hci_cmd_sync_ev);
 
 /* This function requires the caller holds hdev->req_lock. */
-int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
-			     const void *param, u8 event, u32 timeout,
-			     struct sock *sk)
+static int __hci_cmd_sync_status_sk_run(struct hci_dev *hdev, u16 opcode,
+					u32 plen, const void *param, u8 event,
+					u32 timeout, struct sock *sk,
+					hci_request_wait_start_t wait_func,
+					void *wait_data)
 {
 	struct sk_buff *skb;
 	u8 status;
 
-	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
+	skb = __hci_cmd_sync_sk_run(hdev, opcode, plen, param, event, timeout,
+				    sk, wait_func, wait_data);
 
 	/* If command return a status event, skb will be set to -ENODATA */
 	if (skb == ERR_PTR(-ENODATA))
@@ -281,6 +325,15 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	return status;
 }
+
+/* This function requires the caller holds hdev->req_lock. */
+int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
+			     const void *param, u8 event, u32 timeout,
+			     struct sock *sk)
+{
+	return __hci_cmd_sync_status_sk_run(hdev, opcode, plen, param, event,
+					    timeout, sk, NULL, NULL);
+}
 EXPORT_SYMBOL(__hci_cmd_sync_status_sk);
 
 int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
@@ -679,7 +732,7 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
+	if (HCI_REQ_PENDING(READ_ONCE(hdev->req_status))) {
 		hdev->req_result = err;
 		WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
 
@@ -697,7 +750,7 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
+	if (HCI_REQ_PENDING(READ_ONCE(hdev->req_status))) {
 		/* req_result is __u32 so error must be positive to be properly
 		 * propagated.
 		 */
-- 
2.56.0

