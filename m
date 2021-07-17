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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91D7C12002
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 00:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BEE613EB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 00:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhGQAKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Jul 2021 20:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhGQAKa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Jul 2021 20:10:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A541AC06175F
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jul 2021 17:07:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b12so10228119pfv.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jul 2021 17:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e9N3hJGAENUuaAGOz2QJA5JaeZQxij0ybumpM4rph0E=;
        b=AmSUdvOer3Sib3/D6riUuS6vYsOFi3363sl1+Butgwjt4DWqFg7yt0Z/BUgxpLH7OD
         gq+/PdxqBXzdT0Go1wH+428ZoD4xaBuULgNgJdg3/n5rvLYv7D+y4xYYymPdtJjNqrCK
         Vc35T4/A+C8oSMhVSES7iwy0d1MUghgYrSkiohBpbjg/5fRqpOQ4eRxSLXD+Xcmj8NW5
         dOTuaDGv28EPVGu0kVz1z5TllGISl36gWf0JGH3cnEqm1OjTiHBmLiHVItOYFHCcuGvs
         p8KKD7yuOhj1nqEyiKYaXvskKKttCxEOgWDpWoGgXl+iq/YLwJ4O7Ij1db2nUAsitu3I
         TYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e9N3hJGAENUuaAGOz2QJA5JaeZQxij0ybumpM4rph0E=;
        b=ohGfLsdTXsKwIWrUoDfq4w4rAKDcn5XF01MOOyRZCenpg6dsjbZU/Fgr3vq74tqL8t
         L/IeJUDj1m3ZuBKlEGzKgTOT+sorxWkKHmdmTp8Fdi4mLQu2TJ9XCf69MCJVjrXDQXCU
         3QwB/Nga5SpiOE/3SLWdWuJjPCwWLunO6AY7e2PPiwu+WJ1UnRg+aeX+2W0TzFaf+WAE
         ctUwJFEAd5AWZpEQkvR46qsLnxaf0aZt7i8s0thpk8XkfDeneNr/Pah9HX72rnAzbvyT
         11JyqeEOYMbR25ifxOh5ZLHS91HdawKksBTJFvmO6ESEiHZgxAAiNJ06d0b7od8PlWCc
         Jvdg==
X-Gm-Message-State: AOAM5330ttT/BV7GDTIpQiaGE0/vQXd4F+FOxyoPkeXNPK63Vvy9YGY+
        TwCbIwxzh1yfo5SOwo0BnIYV1UExFFOVXw==
X-Google-Smtp-Source: ABdhPJyf3njglnOGUNa5p/rkgIavIbzIPNpgDiIKbBD34DHkg6WTIbu8z4S9x0VfIvGSKypTY7FCDQ==
X-Received: by 2002:a63:a441:: with SMTP id c1mr6800285pgp.59.1626480452738;
        Fri, 16 Jul 2021 17:07:32 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k4sm9188365pjs.55.2021.07.16.17.07.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 17:07:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: hci_sock: Fix calling lock_sock when handling HCI_DEV_UNREG
Date:   Fri, 16 Jul 2021 17:07:31 -0700
Message-Id: <20210717000731.3836303-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes the reference of hci_dev to hci_pinfo since the reference
cannot prevent hdev to be freed hci_pinfo only keeps the index so in
case the device is unregistered and freed hci_dev_get will return NULL
thus prevent UAF.

On top of it commands cases where copy_from_user needs to be used are
now done without helding a reference to the hci_dev.

Link: https://syzkaller.appspot.com/bug?extid=a5df189917e79d5e59c9 [1]
Reported-by: syzbot <syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com>
Fixes: e305509e678b3a4a ("Bluetooth: use correct lock to prevent UAF of hdev object")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   6 +-
 net/bluetooth/hci_conn.c         |  24 ++---
 net/bluetooth/hci_sock.c         | 162 +++++++++++++++++++++++--------
 3 files changed, 137 insertions(+), 55 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8b63ef2ec31a..ddac4be91525 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1266,8 +1266,10 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg);
 int hci_get_dev_list(void __user *arg);
 int hci_get_dev_info(void __user *arg);
 int hci_get_conn_list(void __user *arg);
-int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
-int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
+int hci_get_conn_info(struct hci_dev *hdev, void __user *arg,
+		      struct hci_conn_info_req *req);
+int hci_get_auth_info(struct hci_dev *hdev, void __user *arg,
+		      struct hci_auth_info_req *req);
 int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9fbab563362..4345bcc05778 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1701,18 +1701,15 @@ int hci_get_conn_list(void __user *arg)
 	return err ? -EFAULT : 0;
 }
 
-int hci_get_conn_info(struct hci_dev *hdev, void __user *arg)
+int hci_get_conn_info(struct hci_dev *hdev, void __user *arg,
+		      struct hci_conn_info_req *req)
 {
-	struct hci_conn_info_req req;
 	struct hci_conn_info ci;
 	struct hci_conn *conn;
-	char __user *ptr = arg + sizeof(req);
-
-	if (copy_from_user(&req, arg, sizeof(req)))
-		return -EFAULT;
+	char __user *ptr = (char *)arg + sizeof(*req);
 
 	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_ba(hdev, req.type, &req.bdaddr);
+	conn = hci_conn_hash_lookup_ba(hdev, req->type, &req->bdaddr);
 	if (conn) {
 		bacpy(&ci.bdaddr, &conn->dst);
 		ci.handle = conn->handle;
@@ -1729,24 +1726,21 @@ int hci_get_conn_info(struct hci_dev *hdev, void __user *arg)
 	return copy_to_user(ptr, &ci, sizeof(ci)) ? -EFAULT : 0;
 }
 
-int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
+int hci_get_auth_info(struct hci_dev *hdev, void __user *arg,
+		      struct hci_auth_info_req *req)
 {
-	struct hci_auth_info_req req;
 	struct hci_conn *conn;
 
-	if (copy_from_user(&req, arg, sizeof(req)))
-		return -EFAULT;
-
 	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req.bdaddr);
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req->bdaddr);
 	if (conn)
-		req.type = conn->auth_type;
+		req->type = conn->auth_type;
 	hci_dev_unlock(hdev);
 
 	if (!conn)
 		return -ENOENT;
 
-	return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
+	return copy_to_user(arg, req, sizeof(*req)) ? -EFAULT : 0;
 }
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b04a5a02ecf3..3f104a3aca7e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -50,7 +50,7 @@ static atomic_t monitor_promisc = ATOMIC_INIT(0);
 
 struct hci_pinfo {
 	struct bt_sock    bt;
-	struct hci_dev    *hdev;
+	int               dev;
 	struct hci_filter filter;
 	__u8              cmsg_mask;
 	unsigned short    channel;
@@ -200,7 +200,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 	sk_for_each(sk, &hci_sk_list.head) {
 		struct sk_buff *nskb;
 
-		if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev)
+		if (sk->sk_state != BT_BOUND ||
+		    (hdev && hci_pi(sk)->dev != hdev->id))
 			continue;
 
 		/* Don't send frame to the socket it came from */
@@ -536,8 +537,8 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 
 	hdr = skb_push(skb, HCI_MON_HDR_SIZE);
 	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_OPEN);
-	if (hci_pi(sk)->hdev)
-		hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
+	if (hci_pi(sk)->dev >= 0)
+		hdr->index = cpu_to_le16(hci_pi(sk)->dev);
 	else
 		hdr->index = cpu_to_le16(HCI_DEV_NONE);
 	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
@@ -574,8 +575,8 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 
 	hdr = skb_push(skb, HCI_MON_HDR_SIZE);
 	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_CLOSE);
-	if (hci_pi(sk)->hdev)
-		hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
+	if (hci_pi(sk)->dev >= 0)
+		hdr->index = cpu_to_le16(hci_pi(sk)->dev);
 	else
 		hdr->index = cpu_to_le16(HCI_DEV_NONE);
 	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
@@ -762,16 +763,13 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 		/* Detach sockets from device */
 		read_lock(&hci_sk_list.lock);
 		sk_for_each(sk, &hci_sk_list.head) {
-			lock_sock(sk);
-			if (hci_pi(sk)->hdev == hdev) {
-				hci_pi(sk)->hdev = NULL;
+			bh_lock_sock_nested(sk);
+			if (hci_pi(sk)->dev == hdev->id) {
 				sk->sk_err = EPIPE;
 				sk->sk_state = BT_OPEN;
 				sk->sk_state_change(sk);
-
-				hci_dev_put(hdev);
 			}
-			release_sock(sk);
+			bh_unlock_sock(sk);
 		}
 		read_unlock(&hci_sk_list.lock);
 	}
@@ -861,7 +859,7 @@ static int hci_sock_release(struct socket *sock)
 
 	bt_sock_unlink(&hci_sk_list, sk);
 
-	hdev = hci_pi(sk)->hdev;
+	hdev = hci_dev_get(hci_pi(sk)->dev);
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			/* When releasing a user channel exclusive access,
@@ -892,82 +890,161 @@ static int hci_sock_release(struct socket *sock)
 	return 0;
 }
 
-static int hci_sock_reject_list_add(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_reject_list_add(struct sock *sk, void __user *arg)
 {
+	struct hci_dev *hdev;
 	bdaddr_t bdaddr;
 	int err;
 
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
+	hdev = hci_dev_get(hci_pi(sk)->dev);
+	if (!hdev)
+		return -EBADF;
+
 	hci_dev_lock(hdev);
 
 	err = hci_bdaddr_list_add(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
 
 	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 
 	return err;
 }
 
-static int hci_sock_reject_list_del(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_reject_list_del(struct sock *sk, void __user *arg)
 {
+	struct hci_dev *hdev;
 	bdaddr_t bdaddr;
 	int err;
 
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
+	hdev = hci_dev_get(hci_pi(sk)->dev);
+	if (!hdev)
+		return -EBADF;
+
 	hci_dev_lock(hdev);
 
 	err = hci_bdaddr_list_del(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
 
 	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 
 	return err;
 }
 
+static int hci_sock_get_conn_info(struct sock *sk, void __user *arg)
+{
+	struct hci_dev *hdev;
+	struct hci_conn_info_req req;
+	int ret;
+
+	if (copy_from_user(&req, arg, sizeof(req)))
+		return -EFAULT;
+
+	hdev = hci_dev_get(hci_pi(sk)->dev);
+	if (!hdev)
+		return -EBADF;
+
+	ret = hci_get_conn_info(hdev, arg, &req);
+
+	hci_dev_put(hdev);
+
+	return ret;
+}
+
+static int hci_sock_get_auth_info(struct sock *sk, void __user *arg)
+{
+	struct hci_dev *hdev;
+	struct hci_auth_info_req req;
+	int ret;
+
+	if (copy_from_user(&req, arg, sizeof(req)))
+		return -EFAULT;
+
+	hdev = hci_dev_get(hci_pi(sk)->dev);
+	if (!hdev)
+		return -EBADF;
+
+	ret = hci_get_auth_info(hdev, arg, &req);
+
+	hci_dev_put(hdev);
+
+	return ret;
+}
+
 /* Ioctls that require bound socket */
 static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 				unsigned long arg)
 {
-	struct hci_dev *hdev = hci_pi(sk)->hdev;
+	struct hci_dev *hdev = hci_dev_get(hci_pi(sk)->dev);
+	int ret;
 
 	if (!hdev)
 		return -EBADFD;
 
-	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
-		return -EBUSY;
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		ret = -EBUSY;
+		goto done;
+	}
 
-	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
-		return -EOPNOTSUPP;
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
 
-	if (hdev->dev_type != HCI_PRIMARY)
-		return -EOPNOTSUPP;
+	if (hdev->dev_type != HCI_PRIMARY) {
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
+
+	/* Commands may use copy_from_user which is unsafe while holding hdev as
+	 * it could be unregistered in the meantime.
+	 */
+	hci_dev_put(hdev);
+	hdev = NULL;
 
 	switch (cmd) {
 	case HCISETRAW:
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return -EOPNOTSUPP;
+			ret = -EPERM;
+		else
+			ret = -EOPNOTSUPP;
+		break;
 
 	case HCIGETCONNINFO:
-		return hci_get_conn_info(hdev, (void __user *)arg);
+		ret = hci_sock_get_conn_info(sk, (void __user *)arg);
+		break;
 
 	case HCIGETAUTHINFO:
-		return hci_get_auth_info(hdev, (void __user *)arg);
+		ret = hci_sock_get_auth_info(sk, (void __user *)arg);
+		break;
 
 	case HCIBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return hci_sock_reject_list_add(hdev, (void __user *)arg);
+			ret = -EPERM;
+		else
+			ret = hci_sock_reject_list_add(sk, (void __user *)arg);
+		break;
 
 	case HCIUNBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return hci_sock_reject_list_del(hdev, (void __user *)arg);
+			ret = -EPERM;
+		else
+			ret = hci_sock_reject_list_del(sk, (void __user *)arg);
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
 	}
 
-	return -ENOIOCTLCMD;
+done:
+	if (hdev)
+		hci_dev_put(hdev);
+
+	return ret;
 }
 
 static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
@@ -1110,7 +1187,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 	switch (haddr.hci_channel) {
 	case HCI_CHANNEL_RAW:
-		if (hci_pi(sk)->hdev) {
+		if (hci_pi(sk)->dev >= 0) {
 			err = -EALREADY;
 			goto done;
 		}
@@ -1145,7 +1222,10 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		if (capable(CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
-		hci_pi(sk)->hdev = hdev;
+		if (hdev) {
+			hci_pi(sk)->dev = hdev->id;
+			hci_dev_put(hdev);
+		}
 
 		/* Send event to monitor */
 		skb = create_monitor_ctrl_open(sk);
@@ -1157,7 +1237,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		break;
 
 	case HCI_CHANNEL_USER:
-		if (hci_pi(sk)->hdev) {
+		if (hci_pi(sk)->dev >= 0) {
 			err = -EALREADY;
 			goto done;
 		}
@@ -1236,7 +1316,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 */
 		hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
-		hci_pi(sk)->hdev = hdev;
+		hci_pi(sk)->dev = hdev->id;
+		hci_dev_put(hdev);
 
 		/* Send event to monitor */
 		skb = create_monitor_ctrl_open(sk);
@@ -1379,7 +1460,7 @@ static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
 
 	lock_sock(sk);
 
-	hdev = hci_pi(sk)->hdev;
+	hdev = hci_dev_get(hci_pi(sk)->dev);
 	if (!hdev) {
 		err = -EBADFD;
 		goto done;
@@ -1389,6 +1470,7 @@ static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
 	haddr->hci_dev    = hdev->id;
 	haddr->hci_channel= hci_pi(sk)->channel;
 	err = sizeof(*haddr);
+	hci_dev_put(hdev);
 
 done:
 	release_sock(sk);
@@ -1703,7 +1785,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct hci_mgmt_chan *chan;
-	struct hci_dev *hdev;
+	struct hci_dev *hdev = NULL;
 	struct sk_buff *skb;
 	int err;
 
@@ -1743,7 +1825,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto done;
 	}
 
-	hdev = hci_pi(sk)->hdev;
+	hdev = hci_dev_get(hci_pi(sk)->dev);
 	if (!hdev) {
 		err = -EBADFD;
 		goto done;
@@ -1832,6 +1914,9 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	err = len;
 
 done:
+	if (hdev)
+		hci_dev_put(hdev);
+
 	release_sock(sk);
 	return err;
 
@@ -2049,6 +2134,7 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 	sock->state = SS_UNCONNECTED;
 	sk->sk_state = BT_OPEN;
 
+	hci_pi(sk)->dev = -1;
 	bt_sock_link(&hci_sk_list, sk);
 	return 0;
 }
-- 
2.31.1

