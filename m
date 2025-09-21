Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC434BA2E
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482185; cv=pass; b=ZqbuZt0GVP4rft5dypoIdlnZYoV0DaZXbRVKXg6sZh9igW1XlZems4Fh6EgT4tiXys7GhLUg3s9XEcgYgQa/KHPMQBjzhkcD7g5MgNBIrc6Mt9AMXjuzOybaAU4+EHTMClNUbhEluqjBj+dOjpr+LTQk75lUiAqUTs9UQRfeoQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482185; c=relaxed/simple;
	bh=8UtvLui3VPgPkB2DayLIovQMS3KlBvtLip9S08bWBd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnlVTgH6GOX+G6BfAcmsqAkmNuw2dy6nubkij+dFPJzBTggTs46nsflJVf7E2bg+grOH61JeB0gPgE+IkiZxnar1ldmO4m+okWFrXHSsg6YCgkWYLiETmD9rFoOIJZgMR2kfDh0XbPN3NHtSo7Jl6YqrrgBew/xdq+v+b02wO9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=kMJujSig; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="kMJujSig"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGF02znzz49QJh;
	Sun, 21 Sep 2025 22:16:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlNIOVEZcO1bNLLmIgp/NHukjNx6RClBCg6JgRk0A7w=;
	b=kMJujSignXS2FQVYmkjL8zev90QLR4SSrjv0D7ejYPMJ583YECRQ6bOipm442s85lggUuw
	QKRomhHtXchiAbYQmIqHe9jCFbRxV9a1K/9MvJ6g4UpLe83yDVc45k9KCL3h/KYCEd8Y/K
	pkIJXU1mLRTmPN2ZfVs0vVJNaxeiQ7f4qNS3jD7kgs2kwgmdPoLPfCrgr1YYvynFfU1+74
	nsEEmbjFnbmGXWnC8z1uPF2CHZcC/J6B18YoBJLV+ENGVXoyf1mtrfUAGJjh4n4zwUVkwn
	aFZ+pspbD+t9iz5KgawjqXE7za056wq21gM4pcfE7th8Ocacg2rx0V0kketajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlNIOVEZcO1bNLLmIgp/NHukjNx6RClBCg6JgRk0A7w=;
	b=UWjXZgUKhuTHt7xXWvJnJkfOoaHmcWWtZIVhvzL3DfhMGbTkrjUi5zUnigdgb1MTGF2oMt
	djKk3PboTLl8aoY+wTUoOQ+Q7tCA/vlHXZj8Oqu9VJZ0O3XnTn7st8a6qFl1wzHDupooG5
	mJjOhjgARNDltwEtrpfL5uL/QBsy3OYU5rv8YE++NXuUBYVDQ4nMSyWOen5Z1LkuiefrVW
	hzbrcJr9KwLPznikOMcqZlNyrapUu0p19x+ZmJNH8Rcz8v2laURhKIP4K0aRASCgD6rUJu
	8JYxJDiy2wz+ZuUI9R3iv8+KCfz3X9aAXl3vV2hbRlUuqTZ6j+/GjkoYB1/EjA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482180; a=rsa-sha256;
	cv=none;
	b=LIwXkaQg//Mx3hCt3xLfqRx9XSX3w464m7ls6xqrpPhfG19tGlZfXcU1XAcei+cB3FbnvO
	rnYGCUjxsGBEp6akJtUeh2CorNz18zNTy3jpvABR2wpPOvD9RiO3kzqEJeHPikt/dN8f/k
	jEvLApyFss2n10iDSNbJl58L2LmQwETBDmjt9c16i9CG4sUmLq200+ExbZk0Db9X+L3z+0
	2Dw8b+QPlytkYzRr+HIaFuvrZ82/31c4yVAFYIn1suT6ReYw1rKvTIEFzo1kDmRHx9wM6M
	RS23uf5/f9a36YVpcggcYoU5HdAVRW2MTD8jg+iIQFaoyPh0JmP8qQbfH39vSw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 17/24] Bluetooth: hci_sync: add helper for hdev locking across waits
Date: Sun, 21 Sep 2025 22:16:01 +0300
Message-ID: <a9e4e1c91a3b551f3ca57dfe816ed271e7da8c26.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hci_dev_lock/unlock_sync, for holding hdev->lock except when waiting
request completion on hdev->req_wait_q.

This makes writing hci_sync subroutines somewhat simpler, as the lock
needs to be acquired only on top level.  Routines will however still
have to recheck conditions after waits.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h |  2 ++
 include/net/bluetooth/hci_sync.h |  4 ++++
 net/bluetooth/hci_sync.c         | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1e9b27b3b108..10960462c5dd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -533,6 +533,8 @@ struct hci_dev {
 	struct sk_buff		*req_skb;
 	struct sk_buff		*req_rsp;
 
+	bool			req_hdev_locked;
+
 	void			*smp_data;
 	void			*smp_bredr_data;
 
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index e352a4e0ef8d..eabc423b210e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -188,3 +188,7 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
+
+void hci_dev_lock_sync(struct hci_dev *hdev);
+void hci_dev_unlock_sync(struct hci_dev *hdev);
+void hci_assert_lock_sync_held(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8fe2f5b73040..5391c1bb17f0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -20,6 +20,25 @@
 #include "aosp.h"
 #include "leds.h"
 
+void hci_dev_lock_sync(struct hci_dev *hdev)
+{
+	hci_dev_lock(hdev);
+	lockdep_assert(!hdev->req_hdev_locked);
+	hdev->req_hdev_locked = true;
+}
+
+void hci_dev_unlock_sync(struct hci_dev *hdev)
+{
+	lockdep_assert(hdev->req_hdev_locked);
+	hdev->req_hdev_locked = false;
+	hci_dev_unlock(hdev);
+}
+
+void hci_assert_lock_sync_held(struct hci_dev *hdev)
+{
+	lockdep_assert(lockdep_is_held(&hdev->lock) && hdev->req_hdev_locked);
+}
+
 static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 				  struct sk_buff *skb)
 {
@@ -159,6 +178,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 {
 	struct hci_request req;
 	struct sk_buff *skb;
+	bool locked = READ_ONCE(hdev->req_hdev_locked);
 	int err = 0;
 
 	bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
@@ -173,10 +193,16 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	if (err < 0)
 		return ERR_PTR(err);
 
+	if (locked)
+		hci_dev_unlock(hdev);
+
 	err = wait_event_interruptible_timeout(hdev->req_wait_q,
 					       hdev->req_status != HCI_REQ_PEND,
 					       timeout);
 
+	if (locked)
+		hci_dev_lock(hdev);
+
 	if (err == -ERESTARTSYS)
 		return ERR_PTR(-EINTR);
 
-- 
2.51.0

