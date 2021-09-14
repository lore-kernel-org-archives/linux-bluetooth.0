Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D75C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Sep 2021 22:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F024610A6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Sep 2021 22:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhINWFY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhINWFX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Sep 2021 18:05:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B1C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 15:04:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t1so643900pgv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCJCT+JL811RTNNbUtRKCK0+WzKWeZ+Js3DCV4E4+iw=;
        b=hDhV6Hd4KpT6FTj3iTgqHnA9krCJoTg5TYUCkJ+XgdOf99SL3ofPYwMeZReRbc9sV3
         ToYZ4Nwe0d03B4fwbQ3gbKasFctofkJN03P08pz0dIoSJpgyUs+w8nktmbe414As9H8/
         P+72tXuEV/xMxQXCjP1h/VOxHDQRNt/Fy4TaoauIeggEu+e+iyPSI2cLW4qeEit1J0Ga
         92+YXhVfdA3gMkyG+n9HELk45pkbIgeDsbj/d1ZWUrk64WHuaGN9AlA0IPxa2TsXYo5n
         uCTec+HjoVNI5KSJKs1eEylXEGb/arfC8aQeFtSY4YOUVdzP5j6vNixuXzcqWS7UJAMm
         8COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCJCT+JL811RTNNbUtRKCK0+WzKWeZ+Js3DCV4E4+iw=;
        b=DQ1w2VMNHOm1ondNhVWoqAKzkXUxdy6PX/eFIm5HUmXxUIH7ZmbEStOGc0nVrUjs2G
         /Yrmt91x81jfs/DhsW+Px8IIFwqMZ4MKhHbl9ifkGSbg9B/WhfDVwj8yOGbkr8XTSlIL
         PSie1nXxqEgPbJLwapUWce+M620eOv4CEFIiEQUqXHIKkelA1bMCd6ZO8C0ZD4CKQu+C
         64w1Bm+vCi6/dKMNUIS9g1DsYgH59PC6UfveWzK2ONV87wwiUq4mBuVfR+hbdPoAsvxt
         5SXzNSAlLNUGjMCrNn4ku4Mb6c3KNaOVM6yBHNVj4kDEyxZ0QTB1rc7AvSgigyspfOlm
         9q9g==
X-Gm-Message-State: AOAM530Mk0LQegAxQK0SeFCorpgh/aCUDABwGFNqb8Hko5+TE3fm513s
        aCqp/02hTbS1aW111gn9DNZl7lPcqpk=
X-Google-Smtp-Source: ABdhPJx3/RXMpH1ERGIYfu4OgH2wzTq7qKOJ/jYgOr8yOI2Dtll1K5WqvEI3czV4SHusdN0/7g0+CA==
X-Received: by 2002:a63:77c5:: with SMTP id s188mr17388971pgc.123.1631657044834;
        Tue, 14 Sep 2021 15:04:04 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 21sm10966427pfh.103.2021.09.14.15.04.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:04:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sock: Replace use of memcpy_from_msg with bt_skb_sendmsg
Date:   Tue, 14 Sep 2021 15:04:03 -0700
Message-Id: <20210914220403.3848971-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_skb_sendmsg instead of allocating a different
buffer to be used with memcpy_from_msg which cause one extra copy.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sock.c | 100 +++++++++++++++------------------------
 1 file changed, 37 insertions(+), 63 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 55b0d177375b..31a2eefede3c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1505,7 +1505,8 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return err ? : copied;
 }
 
-static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf, size_t msglen)
+static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
+			struct sk_buff *skb)
 {
 	u8 *cp;
 	struct mgmt_hdr *hdr;
@@ -1515,31 +1516,31 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf,
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
 
@@ -1604,13 +1605,13 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf,
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
@@ -1619,10 +1620,10 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk, void *buf,
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
@@ -1631,21 +1632,13 @@ static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int f
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
@@ -1664,25 +1657,20 @@ static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int f
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
@@ -1690,13 +1678,11 @@ static int hci_logging_frame(struct sock *sk, void *buf, int len, unsigned int f
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
 
@@ -1708,7 +1694,6 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct hci_dev *hdev;
 	struct sk_buff *skb;
 	int err;
-	void *buf;
 	const unsigned int flags = msg->msg_flags;
 
 	BT_DBG("sock %p sk %p", sock, sk);
@@ -1722,13 +1707,9 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
 		return -EINVAL;
 
-	buf = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	if (memcpy_from_msg(buf, msg, len)) {
-		kfree(buf);
-		return -EFAULT;
-	}
+	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
+	if (IS_ERR_OR_NULL(skb))
+		return PTR_ERR(skb);
 
 	lock_sock(sk);
 
@@ -1738,39 +1719,33 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
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
 
@@ -1841,7 +1816,6 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 done:
 	release_sock(sk);
-	kfree(buf);
 	return err;
 
 drop:
-- 
2.31.1

