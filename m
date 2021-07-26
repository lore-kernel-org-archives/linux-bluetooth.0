Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A39C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 21:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5087260F5D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 21:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhGZUbs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 16:31:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53262 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhGZUbr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 16:31:47 -0400
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16QLC6Zf016204;
        Tue, 27 Jul 2021 06:12:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Tue, 27 Jul 2021 06:12:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16QLC6LM016200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Jul 2021 06:12:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, LinMa <linma@zju.edu.cn>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] Bluetooth: defer cleanup of resources in hci_unregister_dev()
Message-ID: <e9b3eae8-df23-20b4-d920-ae348a7e4a16@i-love.sakura.ne.jp>
Date:   Tue, 27 Jul 2021 06:12:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
bt_host_release() which is called when all references to this unregistered
device (which is a kobject) are gone.

Link: https://syzkaller.appspot.com/bug?extid=a5df189917e79d5e59c9 [1]
Reported-by: syzbot <syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com>
Fixes: e305509e678b3a4a ("Bluetooth: use correct lock to prevent UAF of hdev object")
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_core.c          | 18 ++++++++++--------
 net/bluetooth/hci_sock.c          | 20 +++++++++++++-------
 net/bluetooth/hci_sysfs.c         |  7 -------
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..ea3a56995c8f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -438,6 +438,7 @@ int bt_procfs_init(struct net *net, const char *name,
 		   struct bt_sock_list *sk_list,
 		   int (*seq_show)(struct seq_file *, void *));
 void bt_procfs_cleanup(struct net *net, const char *name);
+void bt_host_release(struct device *dev);
 
 extern struct dentry *bt_debugfs;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2560ed2f144d..0ae8a4c40892 100644
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
@@ -4038,6 +4034,13 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	}
 
 	device_del(&hdev->dev);
+	hci_dev_put(hdev);
+}
+EXPORT_SYMBOL(hci_unregister_dev);
+
+void bt_host_release(struct device *dev)
+{
+	struct hci_dev *hdev = to_hci_dev(dev);
 
 	debugfs_remove_recursive(hdev->debugfs);
 	kfree_const(hdev->hw_info);
@@ -4063,11 +4066,10 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_blocked_keys_clear(hdev);
 	hci_dev_unlock(hdev);
 
-	hci_dev_put(hdev);
-
-	ida_simple_remove(&hci_index_ida, id);
+	ida_simple_remove(&hci_index_ida, hdev->id);
+	kfree(hdev);
+	module_put(THIS_MODULE);
 }
-EXPORT_SYMBOL(hci_unregister_dev);
 
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
index 9874844a95a9..5b55a12b344c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -80,13 +80,6 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 	hci_dev_put(hdev);
 }
 
-static void bt_host_release(struct device *dev)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	kfree(hdev);
-	module_put(THIS_MODULE);
-}
-
 static const struct device_type bt_host = {
 	.name    = "host",
 	.release = bt_host_release,
-- 
2.18.4

