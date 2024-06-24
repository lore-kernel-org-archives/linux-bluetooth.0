Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FB19B5B3
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240557; cv=none; b=Ec+kZIgTqloqo6lksSgjfIxa3OhXqrcc/3EhzzzJCIGJxc+BKuoXqa2hAPcun8+6Dq3cYvrdrUPMPalzxUE2PpMuGd/xlzw1xI2hxG9cyDLgxovsfmSplnGusOa5FMDH9YC89oL2zRN3d0UOtRwdfM7ckHNKYG7Wa7hDZj0CznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240557; c=relaxed/simple;
	bh=FkxhAje8JKfrzXA8t+A9owH6qfWjczxxZ0aHfG0a6vo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ojMm1JGuCf2f3Reyh/FJxgRwm8ILqGbrVeuiolqMTC2+vO8CXEyN2qMUsYmSL9Rth7vj2VprEWyuDAGxV3L0lPu+ZHXd5Lnv72pBoRhOCgUWwLNsxQTi7pZPPbjJKdCHxL3FKJYmn7NieC/jGR4XrMhwaUp7vrkcaKs68K+KMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkxgnZqh; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkxgnZqh"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48f409bd157so798953137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719240554; x=1719845354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H1+pxN7mCkGsgRjs28TTroiLmnBDqfqN7oRni2e9UiQ=;
        b=dkxgnZqhUGMiZI/zgc9sw55QhV3jH2yqP+ls1rYshGmMM8viXF8mvSxCc6Txp3BDkF
         Fyy/UznR1kRIS3E5wtUhvRyYXUvfuzAmodGVlnrKaWoOLQMdmCGeoM1/DLui+h0VNv0n
         s1l4AwByIrC//FbmDjsacouZtFyEwYaAPf/kKzOOmvHTqeG3FUXdQ26ekiQKeDm2gtLB
         eUI3YrbzyT9E2CW4OYQWmJvOaVqlELbGMev7axuyAK+giEt5FB7suj4HXFq3T/Z6rj/1
         n/XT+NUo2oirbhCTteIWRMAYaJs5/BdB9qnoNqtbLhnH7+o4QH9XKfLZiKD2BWycRmCJ
         KJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240554; x=1719845354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1+pxN7mCkGsgRjs28TTroiLmnBDqfqN7oRni2e9UiQ=;
        b=R3yuwzDWKymkCJQOvnUBAVZYC/32GiUI8+dW/PbynNP6SQSdziSDcRo/k/NYdrnhwN
         Kb46SiO7wplAOK6OpsFD1g2Zud4N/GrVIMMXKFBfNK3mg4C0HDHtuKwTR7HLCZHGAH+u
         N5VvJR7SEh7cHGLzaslWKxLPXdXpATZzqF5mHPx0S4V2Oj6Na3aTf6C81OCVN5kwfkVw
         wQ5qU47rA4PjPa5+u5DzYhm8pRHro20IJKddWLDt2lhKSxoKSs4CYHeEykoBcOQkoLk+
         fDlBMHWgFNJ5epELJxoSFgtQKNH4woXMYYyix3eO9fZCokZqoRkGSZs/9HARMS862Ua8
         6/Pw==
X-Gm-Message-State: AOJu0YwkO5AINBhL27EgUQWs5H8B9zdPQcsdMPxJC8LgnZS4F6hMw/u6
	69r6Ek3/o0B1UHVKdS9zG7EjXSTmcc1udSTXzAcDoTb3KqgBW3sEvdYsFx6D
X-Google-Smtp-Source: AGHT+IHf37xLhEDN5t3Q7raUCBWttmP1xBAsXnHTi0/cU/xpbPoEZiH5V8ztG0scynkrYe8SKMWV4g==
X-Received: by 2002:a67:e910:0:b0:48f:4c08:51ce with SMTP id ada2fe7eead31-48f52a5bde1mr3948785137.18.1719240553885;
        Mon, 24 Jun 2024 07:49:13 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48f48a08efdsm1039151137.9.2024.06.24.07.49.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:49:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: Fix double free in hci_req_sync_complete
Date: Mon, 24 Jun 2024 10:49:11 -0400
Message-ID: <20240624144911.3817479-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following race:

cpu1                       cpu2
====                       ====
                           sock_ioctl
                           sock_do_ioctl
                           hci_sock_ioctl
hci_rx_work                hci_dev_cmd
hci_event_packet           hci_req_sync
req_complete_skb           __hci_req_sync
hci_req_sync_complete

If hci_rx_work executes before __hci_req_sync releases req_skb, everything
is normal, otherwise it will result in double free of req_skb.

This replaces the usage of hci_req_sync with hci_cmd_sync_status.

Fixes: 45d355a926ab ("Bluetooth: Fix memory leak in hci_req_sync_complete()")
Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  2 +
 net/bluetooth/hci_core.c         | 72 ++++++++------------------------
 net/bluetooth/hci_sync.c         | 13 ++++++
 3 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index b49057bbdf23..20168732f20e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -38,6 +38,8 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u8 event, u32 timeout,
 			     struct sock *sk);
+int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
+			const void *param, u32 timeout);
 
 void hci_cmd_sync_init(struct hci_dev *hdev);
 void hci_cmd_sync_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d541cbb991eb..144e85ebfbdb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -63,50 +63,6 @@ DEFINE_MUTEX(hci_cb_list_lock);
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
 
-static int hci_scan_req(struct hci_request *req, unsigned long opt)
-{
-	__u8 scan = opt;
-
-	BT_DBG("%s %x", req->hdev->name, scan);
-
-	/* Inquiry and Page scans */
-	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-	return 0;
-}
-
-static int hci_auth_req(struct hci_request *req, unsigned long opt)
-{
-	__u8 auth = opt;
-
-	BT_DBG("%s %x", req->hdev->name, auth);
-
-	/* Authentication */
-	hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, 1, &auth);
-	return 0;
-}
-
-static int hci_encrypt_req(struct hci_request *req, unsigned long opt)
-{
-	__u8 encrypt = opt;
-
-	BT_DBG("%s %x", req->hdev->name, encrypt);
-
-	/* Encryption */
-	hci_req_add(req, HCI_OP_WRITE_ENCRYPT_MODE, 1, &encrypt);
-	return 0;
-}
-
-static int hci_linkpol_req(struct hci_request *req, unsigned long opt)
-{
-	__le16 policy = cpu_to_le16(opt);
-
-	BT_DBG("%s %x", req->hdev->name, policy);
-
-	/* Default link policy */
-	hci_req_add(req, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
-	return 0;
-}
-
 /* Get HCI device by index.
  * Device is held on return. */
 struct hci_dev *hci_dev_get(int index)
@@ -735,6 +691,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 {
 	struct hci_dev *hdev;
 	struct hci_dev_req dr;
+	__le16 policy;
 	int err = 0;
 
 	if (copy_from_user(&dr, arg, sizeof(dr)))
@@ -761,8 +718,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 	switch (cmd) {
 	case HCISETAUTH:
-		err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT, NULL);
+		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_AUTH_ENABLE,
+					    1, &dr.dev_opt, HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETENCRYPT:
@@ -773,19 +730,23 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 		if (!test_bit(HCI_AUTH, &hdev->flags)) {
 			/* Auth must be enabled first */
-			err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
-					   HCI_INIT_TIMEOUT, NULL);
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_WRITE_AUTH_ENABLE,
+						    1, &dr.dev_opt,
+						    HCI_CMD_TIMEOUT);
 			if (err)
 				break;
 		}
 
-		err = hci_req_sync(hdev, hci_encrypt_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT, NULL);
+		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_ENCRYPT_MODE,
+					    1, &dr.dev_opt,
+					    HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETSCAN:
-		err = hci_req_sync(hdev, hci_scan_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT, NULL);
+		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SCAN_ENABLE,
+					    1, &dr.dev_opt,
+					    HCI_CMD_TIMEOUT);
 
 		/* Ensure that the connectable and discoverable states
 		 * get correctly modified as this was a non-mgmt change.
@@ -795,8 +756,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		break;
 
 	case HCISETLINKPOL:
-		err = hci_req_sync(hdev, hci_linkpol_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT, NULL);
+		policy = cpu_to_le16(dr.dev_opt);
+
+		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_DEF_LINK_POLICY,
+					    2, &policy,
+					    HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETLINKMODE:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index eff648853ae1..ccad43f10415 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -280,6 +280,19 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 }
 EXPORT_SYMBOL(__hci_cmd_sync_status);
 
+int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
+			const void *param, u32 timeout)
+{
+	int err;
+
+	hci_req_sync_lock(hdev);
+	err = __hci_cmd_sync_status(hdev, opcode, plen, param, timeout);
+	hci_req_sync_unlock(hdev);
+
+	return err;
+}
+EXPORT_SYMBOL(hci_cmd_sync_status);
+
 static void hci_cmd_sync_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
-- 
2.45.2

