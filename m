Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A6C636CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 15:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF8B61244
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 15:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbhGTO3Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 10:29:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64091 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhGTOVd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 10:21:33 -0400
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16KF25Fe063944;
        Wed, 21 Jul 2021 00:02:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Wed, 21 Jul 2021 00:02:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16KF24b0063940
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Jul 2021 00:02:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v2] Bluetooth: reorganize ioctls from hci_sock_bound_ioctl()
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, LinMa <linma@zju.edu.cn>
References: <20210720104905.6870-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <39b677ce-dcbf-6393-6279-88ed3a9e570e@i-love.sakura.ne.jp>
Date:   Wed, 21 Jul 2021 00:02:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720104905.6870-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since userfaultfd mechanism allows sleeping with kernel lock held,
avoiding page fault with kernel lock held where possible will make
the module more robust. This patch just brings copy_{from,to}_user()
calls to out of hdev lock and sock lock.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Rename get_link_mode() to hci_get_link_mode() to avoid
  symbol name collision.

 include/net/bluetooth/hci_core.h |   3 +-
 net/bluetooth/hci_conn.c         |  52 +---------
 net/bluetooth/hci_sock.c         | 165 ++++++++++++++++++++-----------
 3 files changed, 109 insertions(+), 111 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a53e94459ecd..654677f59887 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1261,8 +1261,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg);
 int hci_get_dev_list(void __user *arg);
 int hci_get_dev_info(void __user *arg);
 int hci_get_conn_list(void __user *arg);
-int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
-int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
+u32 hci_get_link_mode(struct hci_conn *conn);
 int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2b5059a56cda..ea2b538537aa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1626,7 +1626,7 @@ void hci_conn_check_pending(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 }
 
-static u32 get_link_mode(struct hci_conn *conn)
+u32 hci_get_link_mode(struct hci_conn *conn)
 {
 	u32 link_mode = 0;
 
@@ -1683,7 +1683,7 @@ int hci_get_conn_list(void __user *arg)
 		(ci + n)->type  = c->type;
 		(ci + n)->out   = c->out;
 		(ci + n)->state = c->state;
-		(ci + n)->link_mode = get_link_mode(c);
+		(ci + n)->link_mode = hci_get_link_mode(c);
 		if (++n >= req.conn_num)
 			break;
 	}
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
index b04a5a02ecf3..ef7fc3e9d471 100644
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
+	ci->link_mode = hci_get_link_mode(conn);
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


