Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D7C636C9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 10:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16335600D4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 10:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhGTKOf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:14:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52156 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbhGTKIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 06:08:54 -0400
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16KAnHBg046137;
        Tue, 20 Jul 2021 19:49:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 20 Jul 2021 19:49:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16KAnApQ046122
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Jul 2021 19:49:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, LinMa <linma@zju.edu.cn>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] Bluetooth: reorganize ioctls from hci_sock_bound_ioctl()
Date:   Tue, 20 Jul 2021 19:49:05 +0900
Message-Id: <20210720104905.6870-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since userfaultfd mechanism allows sleeping with kernel lock held,
avoiding page fault with kernel lock held where possible will make
the module more robust. This patch just brings copy_{from,to}_user()
calls to out of hdev lock and sock lock.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/net/bluetooth/hci_core.h |   3 +-
 net/bluetooth/hci_conn.c         |  50 +---------
 net/bluetooth/hci_sock.c         | 165 ++++++++++++++++++++-----------
 3 files changed, 108 insertions(+), 110 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a53e94459ecd..d9e55682b908 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1261,8 +1261,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg);
 int hci_get_dev_list(void __user *arg);
 int hci_get_dev_info(void __user *arg);
 int hci_get_conn_list(void __user *arg);
-int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
-int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
+u32 get_link_mode(struct hci_conn *conn);
 int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2b5059a56cda..41af11fadb74 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1626,7 +1626,7 @@ void hci_conn_check_pending(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 }
 
-static u32 get_link_mode(struct hci_conn *conn)
+u32 get_link_mode(struct hci_conn *conn)
 {
 	u32 link_mode = 0;
 
@@ -1701,54 +1701,6 @@ int hci_get_conn_list(void __user *arg)
 	return err ? -EFAULT : 0;
 }
 
-int hci_get_conn_info(struct hci_dev *hdev, void __user *arg)
-{
-	struct hci_conn_info_req req;
-	struct hci_conn_info ci;
-	struct hci_conn *conn;
-	char __user *ptr = arg + sizeof(req);
-
-	if (copy_from_user(&req, arg, sizeof(req)))
-		return -EFAULT;
-
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_ba(hdev, req.type, &req.bdaddr);
-	if (conn) {
-		bacpy(&ci.bdaddr, &conn->dst);
-		ci.handle = conn->handle;
-		ci.type  = conn->type;
-		ci.out   = conn->out;
-		ci.state = conn->state;
-		ci.link_mode = get_link_mode(conn);
-	}
-	hci_dev_unlock(hdev);
-
-	if (!conn)
-		return -ENOENT;
-
-	return copy_to_user(ptr, &ci, sizeof(ci)) ? -EFAULT : 0;
-}
-
-int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
-{
-	struct hci_auth_info_req req;
-	struct hci_conn *conn;
-
-	if (copy_from_user(&req, arg, sizeof(req)))
-		return -EFAULT;
-
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req.bdaddr);
-	if (conn)
-		req.type = conn->auth_type;
-	hci_dev_unlock(hdev);
-
-	if (!conn)
-		return -ENOENT;
-
-	return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
-}
-
 struct hci_chan *hci_chan_create(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b04a5a02ecf3..ff78b79ee09d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -892,82 +892,136 @@ static int hci_sock_release(struct socket *sock)
 	return 0;
 }
 
-static int hci_sock_reject_list_add(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_reject_list_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
-	bdaddr_t bdaddr;
-	int err;
-
-	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
-		return -EFAULT;
-
-	hci_dev_lock(hdev);
-
-	err = hci_bdaddr_list_add(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
-
-	hci_dev_unlock(hdev);
-
-	return err;
+	return hci_bdaddr_list_add(&hdev->reject_list, bdaddr, BDADDR_BREDR);
 }
 
-static int hci_sock_reject_list_del(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_reject_list_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
-	bdaddr_t bdaddr;
-	int err;
-
-	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
-		return -EFAULT;
-
-	hci_dev_lock(hdev);
+	return hci_bdaddr_list_del(&hdev->reject_list, bdaddr, BDADDR_BREDR);
+}
 
-	err = hci_bdaddr_list_del(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
+static int hci_get_conn_info(struct hci_dev *hdev, struct hci_conn_info_req *req,
+			     struct hci_conn_info *ci)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, req->type, &req->bdaddr);
+	if (!conn)
+		return -ENOENT;
+	bacpy(&ci->bdaddr, &conn->dst);
+	ci->handle = conn->handle;
+	ci->type  = conn->type;
+	ci->out   = conn->out;
+	ci->state = conn->state;
+	ci->link_mode = get_link_mode(conn);
+	return 0;
+}
 
-	hci_dev_unlock(hdev);
+static int hci_get_auth_info(struct hci_dev *hdev, struct hci_auth_info_req *req)
+{
+	struct hci_conn *conn;
 
-	return err;
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req->bdaddr);
+	if (!conn)
+		return -ENOENT;
+	req->type = conn->auth_type;
+	return 0;
 }
 
 /* Ioctls that require bound socket */
-static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
-				unsigned long arg)
+static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 {
-	struct hci_dev *hdev = hci_pi(sk)->hdev;
+	struct hci_dev *hdev;
+	union {
+		bdaddr_t bdaddr;
+		struct hci_conn_info_req conn_req;
+		struct hci_auth_info_req auth_req;
+	} u;
+	struct hci_conn_info ci;
+	int err = 0;
 
-	if (!hdev)
-		return -EBADFD;
+	if (cmd == HCIBLOCKADDR || cmd == HCIUNBLOCKADDR) {
+		if (copy_from_user(&u.bdaddr, arg, sizeof(u.bdaddr)))
+			err = -EFAULT;
+	} else if (cmd == HCIGETCONNINFO) {
+		if (copy_from_user(&u.conn_req, arg, sizeof(u.conn_req)))
+			err = -EFAULT;
+	} else if (cmd == HCIGETAUTHINFO) {
+		if (copy_from_user(&u.auth_req, arg, sizeof(u.auth_req)))
+			err = -EFAULT;
+	}
 
-	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
-		return -EBUSY;
+	lock_sock(sk);
 
-	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
-		return -EOPNOTSUPP;
+	hdev = hci_pi(sk)->hdev;
+	if (!hdev) {
+		err = -EBADFD;
+		goto out;
+	}
 
-	if (hdev->dev_type != HCI_PRIMARY)
-		return -EOPNOTSUPP;
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		err = -EBUSY;
+		goto out;
+	}
 
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (hdev->dev_type != HCI_PRIMARY) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	hci_dev_lock(hdev);
 	switch (cmd) {
 	case HCISETRAW:
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return -EOPNOTSUPP;
-
+			err = -EPERM;
+		else
+			err = -EOPNOTSUPP;
+		break;
 	case HCIGETCONNINFO:
-		return hci_get_conn_info(hdev, (void __user *)arg);
-
+		if (!err)
+			err = hci_get_conn_info(hdev, &u.conn_req, &ci);
+		break;
 	case HCIGETAUTHINFO:
-		return hci_get_auth_info(hdev, (void __user *)arg);
-
+		if (!err)
+			err = hci_get_auth_info(hdev, &u.auth_req);
+		break;
 	case HCIBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return hci_sock_reject_list_add(hdev, (void __user *)arg);
-
+			err = -EPERM;
+		else if (!err)
+			err = hci_sock_reject_list_add(hdev, &u.bdaddr);
+		break;
 	case HCIUNBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return hci_sock_reject_list_del(hdev, (void __user *)arg);
+			err = -EPERM;
+		else if (!err)
+			err = hci_sock_reject_list_del(hdev, &u.bdaddr);
+		break;
+	default:
+		err = -ENOIOCTLCMD;
 	}
+	hci_dev_unlock(hdev);
+
+ out:
+	release_sock(sk);
 
-	return -ENOIOCTLCMD;
+	if (!err) {
+		if (cmd == HCIGETCONNINFO) {
+			if (copy_to_user(arg + sizeof(u.conn_req), &ci, sizeof(ci)))
+				err = -EFAULT;
+		} else if (cmd == HCIGETAUTHINFO) {
+			if (copy_to_user(arg, &u.auth_req, sizeof(u.auth_req)))
+				err = -EFAULT;
+		}
+	}
+	return err;
 }
 
 static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
@@ -975,15 +1029,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 {
 	void __user *argp = (void __user *)arg;
 	struct sock *sk = sock->sk;
-	int err;
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
 
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
-		err = -EBADFD;
-		goto done;
+		release_sock(sk);
+		return -EBADFD;
 	}
 
 	/* When calling an ioctl on an unbound raw socket, then ensure
@@ -1055,13 +1108,7 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 		return hci_inquiry(argp);
 	}
 
-	lock_sock(sk);
-
-	err = hci_sock_bound_ioctl(sk, cmd, arg);
-
-done:
-	release_sock(sk);
-	return err;
+	return hci_sock_bound_ioctl(sk, cmd, (void __user *)arg);
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.18.4

