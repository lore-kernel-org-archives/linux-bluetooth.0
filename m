Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B47FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Jul 2021 02:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2C360C40
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Jul 2021 02:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhGaCkh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:40:37 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56221 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGaCkh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 22:40:37 -0400
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16V2eNe9002799;
        Sat, 31 Jul 2021 11:40:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Sat, 31 Jul 2021 11:40:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16V2eNrB002790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 31 Jul 2021 11:40:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v3] Bluetooth: reorganize ioctls from hci_sock_bound_ioctl()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
References: <20210720104905.6870-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CABBYNZLt=fJTtdj9qvC22GkF_uYFe59D2bS3u61K14=Gq43Qbw@mail.gmail.com>
 <bb9ceb4d-9e5c-1487-233b-426bc58e9a91@i-love.sakura.ne.jp>
 <CABBYNZJnC-b0s5LW=zTLh4_bV44Uv2-6LXXy+vRAgQmxk=defg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e4277f3d-e725-273a-9537-f4fdc9539981@i-love.sakura.ne.jp>
Date:   Sat, 31 Jul 2021 11:40:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZJnC-b0s5LW=zTLh4_bV44Uv2-6LXXy+vRAgQmxk=defg@mail.gmail.com>
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
Changes in v3:
  Use helper function for each command to avoid re-evaluating
  the command over and over.

Changes in v2:
  Rename get_link_mode() to hci_get_link_mode() to avoid
  symbol name collision.
---
 include/net/bluetooth/hci_core.h |   3 +-
 net/bluetooth/hci_conn.c         |  52 +--------
 net/bluetooth/hci_sock.c         | 179 +++++++++++++++++++++++--------
 3 files changed, 139 insertions(+), 95 deletions(-)

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
index b04a5a02ecf3..edda31556f19 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -892,37 +892,157 @@ static int hci_sock_release(struct socket *sock)
 	return 0;
 }
 
-static int hci_sock_reject_list_add(struct hci_dev *hdev, void __user *arg)
+static struct hci_dev *validate_hdev_from_sock(struct sock *sk)
 {
-	bdaddr_t bdaddr;
+	struct hci_dev *hdev = hci_pi(sk)->hdev;
+
+	if (!hdev)
+		return ERR_PTR(-EBADFD);
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
+		return ERR_PTR(-EBUSY);
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
+		return ERR_PTR(-EOPNOTSUPP);
+	if (hdev->dev_type != HCI_PRIMARY)
+		return ERR_PTR(-EOPNOTSUPP);
+	return hdev;
+}
+
+static int hci_set_raw(struct sock *sk)
+{
+	struct hci_dev *hdev;
 	int err;
 
-	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
+	lock_sock(sk);
+	hdev = validate_hdev_from_sock(sk);
+	if (IS_ERR(hdev))
+		err = PTR_ERR(hdev);
+	else if (!capable(CAP_NET_ADMIN))
+		err = -EPERM;
+	else
+		err = -EOPNOTSUPP;
+	release_sock(sk);
+	return err;
+}
+
+static int hci_get_conn_info(struct sock *sk, void __user *arg)
+{
+	struct hci_dev *hdev;
+	struct hci_conn_info_req req;
+	struct hci_conn_info ci;
+	struct hci_conn *conn;
+	int err = 0;
+	char __user *ptr = arg + sizeof(req);
+
+	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
+	lock_sock(sk);
+	hdev = validate_hdev_from_sock(sk);
+	if (IS_ERR(hdev)) {
+		err = PTR_ERR(hdev);
+		goto out;
+	}
 	hci_dev_lock(hdev);
+	conn = hci_conn_hash_lookup_ba(hdev, req.type, &req.bdaddr);
+	if (conn) {
+		bacpy(&ci.bdaddr, &conn->dst);
+		ci.handle = conn->handle;
+		ci.type  = conn->type;
+		ci.out   = conn->out;
+		ci.state = conn->state;
+		ci.link_mode = hci_get_link_mode(conn);
+	} else {
+		err = -ENOENT;
+	}
+	hci_dev_unlock(hdev);
+ out:
+	release_sock(sk);
 
-	err = hci_bdaddr_list_add(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
+	if (!err)
+		err = copy_to_user(ptr, &ci, sizeof(ci)) ? -EFAULT : 0;
+	return err;
+}
+
+static int hci_get_auth_info(struct sock *sk, void __user *arg)
+{
+	struct hci_dev *hdev;
+	struct hci_auth_info_req req;
+	struct hci_conn *conn;
+	int err = 0;
+
+	if (copy_from_user(&req, arg, sizeof(req)))
+		return -EFAULT;
 
+	lock_sock(sk);
+	hdev = validate_hdev_from_sock(sk);
+	if (IS_ERR(hdev)) {
+		err = PTR_ERR(hdev);
+		goto out;
+	}
+	hci_dev_lock(hdev);
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req.bdaddr);
+	if (conn)
+		req.type = conn->auth_type;
+	else
+		err = -ENOENT;
 	hci_dev_unlock(hdev);
+ out:
+	release_sock(sk);
 
+	if (!err)
+		err = copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
 	return err;
 }
 
-static int hci_sock_reject_list_del(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_reject_list_add(struct sock *sk, void __user *arg)
 {
+	struct hci_dev *hdev;
 	bdaddr_t bdaddr;
-	int err;
+	int err = 0;
 
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
+	lock_sock(sk);
+	hdev = validate_hdev_from_sock(sk);
+	if (IS_ERR(hdev)) {
+		err = PTR_ERR(hdev);
+		goto out;
+	} else if (!capable(CAP_NET_ADMIN)) {
+		err = -EPERM;
+		goto out;
+	}
 	hci_dev_lock(hdev);
+	err = hci_bdaddr_list_add(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
+	hci_dev_unlock(hdev);
+ out:
+	release_sock(sk);
+	return err;
+}
 
-	err = hci_bdaddr_list_del(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
+static int hci_sock_reject_list_del(struct sock *sk, void __user *arg)
+{
+	struct hci_dev *hdev;
+	bdaddr_t bdaddr;
+	int err = 0;
 
-	hci_dev_unlock(hdev);
+	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
+		return -EFAULT;
 
+	lock_sock(sk);
+	hdev = validate_hdev_from_sock(sk);
+	if (IS_ERR(hdev)) {
+		err = PTR_ERR(hdev);
+		goto out;
+	} else if (!capable(CAP_NET_ADMIN)) {
+		err = -EPERM;
+		goto out;
+	}
+	hci_dev_lock(hdev);
+	err = hci_bdaddr_list_del(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
+	hci_dev_unlock(hdev);
+ out:
+	release_sock(sk);
 	return err;
 }
 
@@ -930,41 +1050,21 @@ static int hci_sock_reject_list_del(struct hci_dev *hdev, void __user *arg)
 static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 				unsigned long arg)
 {
-	struct hci_dev *hdev = hci_pi(sk)->hdev;
-
-	if (!hdev)
-		return -EBADFD;
-
-	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
-		return -EBUSY;
-
-	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
-		return -EOPNOTSUPP;
-
-	if (hdev->dev_type != HCI_PRIMARY)
-		return -EOPNOTSUPP;
-
 	switch (cmd) {
 	case HCISETRAW:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return -EOPNOTSUPP;
+		return hci_set_raw(sk);
 
 	case HCIGETCONNINFO:
-		return hci_get_conn_info(hdev, (void __user *)arg);
+		return hci_get_conn_info(sk, (void __user *)arg);
 
 	case HCIGETAUTHINFO:
-		return hci_get_auth_info(hdev, (void __user *)arg);
+		return hci_get_auth_info(sk, (void __user *)arg);
 
 	case HCIBLOCKADDR:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return hci_sock_reject_list_add(hdev, (void __user *)arg);
+		return hci_sock_reject_list_add(sk, (void __user *)arg);
 
 	case HCIUNBLOCKADDR:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return hci_sock_reject_list_del(hdev, (void __user *)arg);
+		return hci_sock_reject_list_del(sk, (void __user *)arg);
 	}
 
 	return -ENOIOCTLCMD;
@@ -975,15 +1075,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
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
@@ -1055,13 +1154,7 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 		return hci_inquiry(argp);
 	}
 
-	lock_sock(sk);
-
-	err = hci_sock_bound_ioctl(sk, cmd, arg);
-
-done:
-	release_sock(sk);
-	return err;
+	return hci_sock_bound_ioctl(sk, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.18.4


