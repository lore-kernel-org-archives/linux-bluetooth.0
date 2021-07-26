Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69156C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 23:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDE960F5D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 23:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhGZW4b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 18:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhGZW4a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 18:56:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA828C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 16:36:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mt6so15214385pjb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdL1L4Gck4gEoQmuUbrCGQ7x0nZFZbvsmhu8Fd6B5L0=;
        b=K4RKvMuKcbvQ1R8OYKxW6V9pCrgEeYTPk4V6SVnVAle+M7ipOdPoqe5gfVa6ZHut46
         hztqKbH8gS8JYWTnTSxHqxtjqQctQ1PFGQ0gaYSldMthSQXk+1zEHZMt4MuP0Ct/fQqc
         xgTgdUWlGLvNIacfYe2S5qL+TYoTE++1rJJwPEUoTd7Bmw9ENFaob0a/GA/r/mwLlx0t
         GzGq4RN3jScwCSwetPaIEjwXvKS8NMKP4MKL09ZXcWHgrGeNLmY7azaFqY7o7qo72XAV
         Qa4ZM6eusA6lFJYsKwjvBUkpnk2AyGXyEreiazMJTj2bEIoMiSFfdbMPHTsTQA+1c6tb
         /X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdL1L4Gck4gEoQmuUbrCGQ7x0nZFZbvsmhu8Fd6B5L0=;
        b=Ez3Ua1JGO/PULH2Gfa4uVJ9W7MTQiE1unqr7XLVsvoGQ9JvV0ImAZNUHM7ZNBBTVWY
         xcFaroEhokECOmVJY7qIBWZU/1XyF1i3wtHDO1E3AB1z/xAhccQsNVEfS0cqylDN9hur
         Dw90TuSmweltoebCtcu41DZgIgqvWtbTPoC/53KQ07W63azVYj7vEGONoaQH84vDXkS3
         ANn7hroSF2TmffMIy99kkaH0KIzPOLmv07DY248rFTzuskzjj5/3DhStSspl4f/uaPt5
         W7Ay/4/uHYD218bdajfTGt4IK/uxgXbmMlDT8qKURUx1kD/Ww7cFVg4izh8IodvaxBeC
         M3xA==
X-Gm-Message-State: AOAM530r5zy6FMCCZUcOVxEC2eNCAxsRHomSwI3c1wFPaJPz1aDS+fC/
        GCSAB30PqJ/Cesk00e8ltT7oSJRWwZg=
X-Google-Smtp-Source: ABdhPJz8HtrHCFn95A8ymAzDny0oLtIPrcGrgSU0M/9nNXpEZrRxMjROsLq95TmhjmVrpxh0bHOvlQ==
X-Received: by 2002:a17:902:ab91:b029:12b:8dae:b1ff with SMTP id f17-20020a170902ab91b029012b8daeb1ffmr16280949plr.52.1627342616026;
        Mon, 26 Jul 2021 16:36:56 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c14sm934979pgv.86.2021.07.26.16.36.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:36:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: defer cleanup of resources in hci_unregister_dev()
Date:   Mon, 26 Jul 2021 16:36:54 -0700
Message-Id: <20210726233654.1988081-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is hitting might_sleep() warning at hci_sock_dev_event()
due to calling lock_sock() with rw spinlock held [1].

It seems that history of this locking problem is a trial and error.

Commit b40df5743ee8aed8 ("[PATCH] bluetooth: fix socket locking in
hci_sock_dev_event()") in 2.6.21-rc4 changed bh_lock_sock() to lock_sock()
as an attempt to fix lockdep warning.

Then, commit 4ce61d1c7a8ef4c1 ("[BLUETOOTH]: Fix locking in
hci_sock_dev_event().") in 2.6.22-rc2 changed lock_sock() to
local_bh_disable() + bh_lock_sock_nested() as an attempt to fix
sleep in atomic context warning.

Then, commit 4b5dd696f81b210c ("Bluetooth: Remove local_bh_disable() from
hci_sock.c") in 3.3-rc1 removed local_bh_disable().

Then, commit e305509e678b3a4a ("Bluetooth: use correct lock to prevent UAF
of hdev object") in 5.13-rc5 again changed bh_lock_sock_nested() to
lock_sock() as an attempt to fix CVE-2021-3573.

This difficulty comes from current implementation that
hci_sock_dev_event(HCI_DEV_UNREG) is responsible for dropping all
references from sockets because hci_unregister_dev() immediately reclaims
resources as soon as returning from hci_sock_dev_event(HCI_DEV_UNREG).
But the history suggests that hci_sock_dev_event(HCI_DEV_UNREG) was not
doing what it should do.

Therefore, instead of trying to detach sockets from device, let's accept
not detaching sockets from device at hci_sock_dev_event(HCI_DEV_UNREG),
by moving actual cleanup of resources from hci_unregister_dev() to
hci_release_dev() which is called by bt_host_release when all references
to this unregistered device (which is a kobject) are gone.

Link: https://syzkaller.appspot.com/bug?extid=a5df189917e79d5e59c9 [1]
Reported-by: syzbot <syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com>
Fixes: e305509e678b3a4a ("Bluetooth: use correct lock to prevent UAF of hdev object")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Add hci_release_dev and make bt_host_release call it instead of making
bt_host_release public.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 17 +++++++++--------
 net/bluetooth/hci_sock.c         | 20 +++++++++++++-------
 net/bluetooth/hci_sysfs.c        |  2 +-
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a53e94459ecd..4abe3c494002 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1230,6 +1230,7 @@ struct hci_dev *hci_alloc_dev(void);
 void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 void hci_unregister_dev(struct hci_dev *hdev);
+void hci_release_dev(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
 int hci_reset_dev(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2560ed2f144d..2b78e1336c53 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3996,14 +3996,10 @@ EXPORT_SYMBOL(hci_register_dev);
 /* Unregister HCI device */
 void hci_unregister_dev(struct hci_dev *hdev)
 {
-	int id;
-
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
 
-	id = hdev->id;
-
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
@@ -4038,7 +4034,13 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	}
 
 	device_del(&hdev->dev);
+	hci_dev_put(hdev);
+}
+EXPORT_SYMBOL(hci_unregister_dev);
 
+/* Release HCI device */
+void hci_release_dev(struct hci_dev *hdev)
+{
 	debugfs_remove_recursive(hdev->debugfs);
 	kfree_const(hdev->hw_info);
 	kfree_const(hdev->fw_info);
@@ -4063,11 +4065,10 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_blocked_keys_clear(hdev);
 	hci_dev_unlock(hdev);
 
-	hci_dev_put(hdev);
-
-	ida_simple_remove(&hci_index_ida, id);
+	ida_simple_remove(&hci_index_ida, hdev->id);
+	kfree(hdev);
 }
-EXPORT_SYMBOL(hci_unregister_dev);
+EXPORT_SYMBOL(hci_release_dev);
 
 /* Suspend HCI device */
 int hci_suspend_dev(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b04a5a02ecf3..5c28ec051dd6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -759,19 +759,13 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 	if (event == HCI_DEV_UNREG) {
 		struct sock *sk;
 
-		/* Detach sockets from device */
+		/* Wake up sockets using this dead device */
 		read_lock(&hci_sk_list.lock);
 		sk_for_each(sk, &hci_sk_list.head) {
-			lock_sock(sk);
 			if (hci_pi(sk)->hdev == hdev) {
-				hci_pi(sk)->hdev = NULL;
 				sk->sk_err = EPIPE;
-				sk->sk_state = BT_OPEN;
 				sk->sk_state_change(sk);
-
-				hci_dev_put(hdev);
 			}
-			release_sock(sk);
 		}
 		read_unlock(&hci_sk_list.lock);
 	}
@@ -1103,6 +1097,18 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 	lock_sock(sk);
 
+	/* Allow detaching from dead device and attaching to alive device, if the caller wants to
+	 * re-bind (instead of close) this socket in response to hci_sock_dev_event(HCI_DEV_UNREG)
+	 * notification.
+	 */
+	hdev = hci_pi(sk)->hdev;
+	if (hdev && hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		hci_pi(sk)->hdev = NULL;
+		sk->sk_state = BT_OPEN;
+		hci_dev_put(hdev);
+	}
+	hdev = NULL;
+
 	if (sk->sk_state == BT_BOUND) {
 		err = -EALREADY;
 		goto done;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 9874844a95a9..ebf282d1eb2b 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -83,7 +83,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 static void bt_host_release(struct device *dev)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
-	kfree(hdev);
+	hci_release_dev(hdev);
 	module_put(THIS_MODULE);
 }
 
-- 
2.31.1

