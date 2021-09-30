Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7440AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FB861994
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 20:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348020AbhI3Ufl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347824AbhI3Ufk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 16:35:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9FC06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 13:33:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u7so6000427pfg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvgxcGSodiz8i6InsCKmX/B34lsKCtEJkxsVLaETzIQ=;
        b=LS7bvmlQ3AwLz+29jhIJN+Ruw/2Aex1B0hEMAWwOB/vfv72LBsmwIpaSDTWpUbgmmx
         ulhcee6t4OJ4elchyGHVaE+3O1Znfw04Fcy54/5pscAMi5xm4kZo1jWCcfRIE/s54Q/s
         uYTYkC1qt8hvU8EKcKcDXMifYeBGe9ISzjj3+VJI4xUC6O2eipQvhR1yZHzU3JsNUluN
         oYI812yF8a7LNRqa5G2zmMiWe3X7rUZon7L5andbem3ETDvI8/O1nDJ0Xid54CMblyuM
         ZLUjvIrvzwQ6oC2elq47cLZe0vFCEmodcvuLlkFK8BvGgD5vH32ltldLrwftO/ukITGe
         dQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvgxcGSodiz8i6InsCKmX/B34lsKCtEJkxsVLaETzIQ=;
        b=ikmFE1n2DtQaztmT8FjI4CJqNTxdUCo5bILJyht6Q7ouj6qB5OFzTYerWho4Wec6z6
         63qW0JYR7Li6V4gpeolfWywEOQ7XYzlVdeMVpG8iCYXQiwI5KVcy01RDyASSIdrP8MG8
         etbrbIlgcZsJTOo10zdu7wyOYD22Ns0mNKXV4/3d6GaAKgk/YiZgBQ3R3I+cGqWITuCg
         Mv/G8roOpMcUUyUXyjDnX5L/zcVMMOVby8+Z9tMeX8LzGsFCyuXZbzLpuVpoDc1/pIvy
         Se9dEFhtShV9/lSvnW+pei4ryin/5r/RcM1V7qJHW3CUTGqonBgB5KP3/uWF8mVL2Cbi
         HThg==
X-Gm-Message-State: AOAM532Vjo9AU4Bcpcp5HMLgebgFh4jfjzS5Xw0IDG5eofKfyqXQTMJK
        ZJ9voT3h2xtmQJ4YFNMKQ8/YHtZwv3c=
X-Google-Smtp-Source: ABdhPJzqXzT2zuCr4ld+UWsOmwH3Jb76oMl5sEUKK+gnz/5sXfuWFwB+anJNwGrZhrjserbYKBmJfw==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr6458216pgl.67.1633034035679;
        Thu, 30 Sep 2021 13:33:55 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q20sm3969330pfc.57.2021.09.30.13.33.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 13:33:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND] Bluetooth: hci_sock: Replace use of memcpy_from_msg with bt_skb_sendmsg
Date:   Thu, 30 Sep 2021 13:33:52 -0700
Message-Id: <20210930203352.3378502-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_skb_sendmsg instead of allocating a different
buffer to be used with memcpy_from_msg which cause one extra copy.

Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sock.c | 100 +++++++++++++++------------------------
 1 file changed, 37 insertions(+), 63 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 99de17922bda..d0dad1fafe07 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1510,7 +1510,8 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return err ? : copied;
 }
 
-static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf, size_t msglen)
+static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
+			struct sk_buff *skb)
 {
 	u8 *cp;
 	struct mgmt_hdr *hdr;
@@ -1520,31 +1521,31 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf,
 	bool var_len, no_hdev;
 	int err;
 
-	BT_DBG("got %zu bytes", msglen);
+	BT_DBG("got %d bytes", skb->len);
 
-	if (msglen < sizeof(*hdr))
+	if (skb->len < sizeof(*hdr))
 		return -EINVAL;
 
-	hdr = buf;
+	hdr = (void *)skb->data;
 	opcode = __le16_to_cpu(hdr->opcode);
 	index = __le16_to_cpu(hdr->index);
 	len = __le16_to_cpu(hdr->len);
 
-	if (len != msglen - sizeof(*hdr)) {
+	if (len != skb->len - sizeof(*hdr)) {
 		err = -EINVAL;
 		goto done;
 	}
 
 	if (chan->channel == HCI_CHANNEL_CONTROL) {
-		struct sk_buff *skb;
+		struct sk_buff *cmd;
 
 		/* Send event to monitor */
-		skb = create_monitor_ctrl_command(sk, index, opcode, len,
-						  buf + sizeof(*hdr));
-		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+		cmd = create_monitor_ctrl_command(sk, index, opcode, len,
+						  skb->data + sizeof(*hdr));
+		if (cmd) {
+			hci_send_to_channel(HCI_CHANNEL_MONITOR, cmd,
 					    HCI_SOCK_TRUSTED, NULL);
-			kfree_skb(skb);
+			kfree_skb(cmd);
 		}
 	}
 
@@ -1609,13 +1610,13 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf,
 	if (hdev && chan->hdev_init)
 		chan->hdev_init(sk, hdev);
 
-	cp = buf + sizeof(*hdr);
+	cp = skb->data + sizeof(*hdr);
 
 	err = handler->func(sk, hdev, cp, len);
 	if (err < 0)
 		goto done;
 
-	err = msglen;
+	err = skb->len;
 
 done:
 	if (hdev)
@@ -1624,10 +1625,10 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf,
 	return err;
 }
 
-static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int flags)
+static int hci_logging_frame(struct sock *sk, struct sk_buff *skb,
+			     unsigned int flags)
 {
 	struct hci_mon_hdr *hdr;
-	struct sk_buff *skb;
 	struct hci_dev *hdev;
 	u16 index;
 	int err;
@@ -1636,21 +1637,13 @@ static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int f
 	 * the priority byte, the ident length byte and at least one string
 	 * terminator NUL byte. Anything shorter are invalid packets.
 	 */
-	if (len < sizeof(*hdr) + 3)
+	if (skb->len < sizeof(*hdr) + 3)
 		return -EINVAL;
 
-	skb = bt_skb_send_alloc(sk, len, flags & MSG_DONTWAIT, &err);
-	if (!skb)
-		return err;
-
-	memcpy(skb_put(skb, len), buf, len);
-
 	hdr = (void *)skb->data;
 
-	if (__le16_to_cpu(hdr->len) != len - sizeof(*hdr)) {
-		err = -EINVAL;
-		goto drop;
-	}
+	if (__le16_to_cpu(hdr->len) != skb->len - sizeof(*hdr))
+		return -EINVAL;
 
 	if (__le16_to_cpu(hdr->opcode) == 0x0000) {
 		__u8 priority = skb->data[sizeof(*hdr)];
@@ -1669,25 +1662,20 @@ static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int f
 		 * The message follows the ident string (if present) and
 		 * must be NUL terminated. Otherwise it is not a valid packet.
 		 */
-		if (priority > 7 || skb->data[len - 1] != 0x00 ||
-		    ident_len > len - sizeof(*hdr) - 3 ||
-		    skb->data[sizeof(*hdr) + ident_len + 1] != 0x00) {
-			err = -EINVAL;
-			goto drop;
-		}
+		if (priority > 7 || skb->data[skb->len - 1] != 0x00 ||
+		    ident_len > skb->len - sizeof(*hdr) - 3 ||
+		    skb->data[sizeof(*hdr) + ident_len + 1] != 0x00)
+			return -EINVAL;
 	} else {
-		err = -EINVAL;
-		goto drop;
+		return -EINVAL;
 	}
 
 	index = __le16_to_cpu(hdr->index);
 
 	if (index != MGMT_INDEX_NONE) {
 		hdev = hci_dev_get(index);
-		if (!hdev) {
-			err = -ENODEV;
-			goto drop;
-		}
+		if (!hdev)
+			return -ENODEV;
 	} else {
 		hdev = NULL;
 	}
@@ -1695,13 +1683,11 @@ static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int f
 	hdr->opcode = cpu_to_le16(HCI_MON_USER_LOGGING);
 
 	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED, NULL);
-	err = len;
+	err = skb->len;
 
 	if (hdev)
 		hci_dev_put(hdev);
 
-drop:
-	kfree_skb(skb);
 	return err;
 }
 
@@ -1713,7 +1699,6 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct hci_dev *hdev;
 	struct sk_buff *skb;
 	int err;
-	void *buf;
 	const unsigned int flags = msg->msg_flags;
 
 	BT_DBG("sock %p sk %p", sock, sk);
@@ -1727,13 +1712,9 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (len < 4 || len > hci_pi(sk)->mtu)
 		return -EINVAL;
 
-	buf = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	if (memcpy_from_msg(buf, msg, len)) {
-		kfree(buf);
-		return -EFAULT;
-	}
+	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 
 	lock_sock(sk);
 
@@ -1743,39 +1724,33 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		break;
 	case HCI_CHANNEL_MONITOR:
 		err = -EOPNOTSUPP;
-		goto done;
+		goto drop;
 	case HCI_CHANNEL_LOGGING:
-		err = hci_logging_frame(sk, buf, len, flags);
-		goto done;
+		err = hci_logging_frame(sk, skb, flags);
+		goto drop;
 	default:
 		mutex_lock(&mgmt_chan_list_lock);
 		chan = __hci_mgmt_chan_find(hci_pi(sk)->channel);
 		if (chan)
-			err = hci_mgmt_cmd(chan, sk, buf, len);
+			err = hci_mgmt_cmd(chan, sk, skb);
 		else
 			err = -EINVAL;
 
 		mutex_unlock(&mgmt_chan_list_lock);
-		goto done;
+		goto drop;
 	}
 
 	hdev = hci_hdev_from_sock(sk);
 	if (IS_ERR(hdev)) {
 		err = PTR_ERR(hdev);
-		goto done;
+		goto drop;
 	}
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = -ENETDOWN;
-		goto done;
+		goto drop;
 	}
 
-	skb = bt_skb_send_alloc(sk, len, flags & MSG_DONTWAIT, &err);
-	if (!skb)
-		goto done;
-
-	memcpy(skb_put(skb, len), buf, len);
-
 	hci_skb_pkt_type(skb) = skb->data[0];
 	skb_pull(skb, 1);
 
@@ -1846,7 +1821,6 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 done:
 	release_sock(sk);
-	kfree(buf);
 	return err;
 
 drop:
-- 
2.31.1

