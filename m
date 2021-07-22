Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DB7C6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8C46023B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhGVHC3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:02:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54745 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhGVHC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 03:02:28 -0400
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16M7gdCQ049608;
        Thu, 22 Jul 2021 16:42:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Thu, 22 Jul 2021 16:42:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16M7gXwu049549
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Jul 2021 16:42:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, LinMa <linma@zju.edu.cn>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] Bluetooth: reorganize functions from hci_sock_sendmsg()
Date:   Thu, 22 Jul 2021 16:42:08 +0900
Message-Id: <20210722074208.8040-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since userfaultfd mechanism allows sleeping with kernel lock held,
avoiding page fault with kernel lock held where possible will make
the module more robust. This patch just brings memcpy_from_msg() calls
to out of sock lock.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/bluetooth/hci_sock.c | 50 +++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index ef7fc3e9d471..7fac44fb771f 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1535,10 +1535,8 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return err ? : copied;
 }
 
-static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
-			struct msghdr *msg, size_t msglen)
+static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf, size_t msglen)
 {
-	void *buf;
 	u8 *cp;
 	struct mgmt_hdr *hdr;
 	u16 opcode, index, len;
@@ -1552,15 +1550,6 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 	if (msglen < sizeof(*hdr))
 		return -EINVAL;
 
-	buf = kmalloc(msglen, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (memcpy_from_msg(buf, msg, msglen)) {
-		err = -EFAULT;
-		goto done;
-	}
-
 	hdr = buf;
 	opcode = __le16_to_cpu(hdr->opcode);
 	index = __le16_to_cpu(hdr->index);
@@ -1657,11 +1646,10 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 	if (hdev)
 		hci_dev_put(hdev);
 
-	kfree(buf);
 	return err;
 }
 
-static int hci_logging_frame(struct sock *sk, struct msghdr *msg, int len)
+static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int flags)
 {
 	struct hci_mon_hdr *hdr;
 	struct sk_buff *skb;
@@ -1676,14 +1664,11 @@ static int hci_logging_frame(struct sock *sk, struct msghdr *msg, int len)
 	if (len < sizeof(*hdr) + 3)
 		return -EINVAL;
 
-	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = bt_skb_send_alloc(sk, len, flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return err;
 
-	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
-		err = -EFAULT;
-		goto drop;
-	}
+	memcpy(skb_put(skb, len), buf, len);
 
 	hdr = (void *)skb->data;
 
@@ -1753,19 +1738,28 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct hci_dev *hdev;
 	struct sk_buff *skb;
 	int err;
+	void *buf;
+	const unsigned int flags = msg->msg_flags;
 
 	BT_DBG("sock %p sk %p", sock, sk);
 
-	if (msg->msg_flags & MSG_OOB)
+	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	if (msg->msg_flags & ~(MSG_DONTWAIT|MSG_NOSIGNAL|MSG_ERRQUEUE|
-			       MSG_CMSG_COMPAT))
+	if (flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
 		return -EINVAL;
 
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	if (memcpy_from_msg(buf, msg, len)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
 	lock_sock(sk);
 
 	switch (hci_pi(sk)->channel) {
@@ -1776,13 +1770,13 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = -EOPNOTSUPP;
 		goto done;
 	case HCI_CHANNEL_LOGGING:
-		err = hci_logging_frame(sk, msg, len);
+		err = hci_logging_frame(sk, buf, len, flags);
 		goto done;
 	default:
 		mutex_lock(&mgmt_chan_list_lock);
 		chan = __hci_mgmt_chan_find(hci_pi(sk)->channel);
 		if (chan)
-			err = hci_mgmt_cmd(chan, sk, msg, len);
+			err = hci_mgmt_cmd(chan, sk, buf, len);
 		else
 			err = -EINVAL;
 
@@ -1801,14 +1795,11 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto done;
 	}
 
-	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = bt_skb_send_alloc(sk, len, flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		goto done;
 
-	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
-		err = -EFAULT;
-		goto drop;
-	}
+	memcpy(skb_put(skb, len), buf, len);
 
 	hci_skb_pkt_type(skb) = skb->data[0];
 	skb_pull(skb, 1);
@@ -1880,6 +1871,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 done:
 	release_sock(sk);
+	kfree(buf);
 	return err;
 
 drop:
-- 
2.18.4

