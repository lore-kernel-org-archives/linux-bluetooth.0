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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32E261242
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhIOXhZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhIOXhX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 19:37:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A33CC061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:36:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n2so40195plk.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+TK1YvjA53I2APi/97L1aIxLqOAdfEStVTGEOp+IQnE=;
        b=OKFYYkolzGiZ8sVkUb+HKgX6GdIbzphAq+gDN+0oLvMtjpLkpBaAV90SU3rbipE2wF
         qxepu9u62lnLfxi/sj/XXOtmS+gCPdy9aOflV9l0c9SQS5EUgCicmYXxdaHedhIwSuPJ
         pXJUHoosTs52cMhWnF8OlOxJwpmEmEgpK+b+kXYCuMLI7cDFJGCqriuw375c6Fe7xUYN
         trQt9+GFWQZi0XeXMqXLgCUQYdtniKUlibq80F3rQe4RbIodvWm/NG86U3nWtMgGNiFi
         B20XW6L4PCpQn2Ahda0SvWar+sBqt8JYVqjC+LlJ3YQEXnHvAs6RY2fp3WqS2BVHIvoO
         58pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TK1YvjA53I2APi/97L1aIxLqOAdfEStVTGEOp+IQnE=;
        b=Xm4GZ+ExSD6OpMzCWeF4iPKSWGvUlGKFDiwzZLU4+kHGsmn6JaCVcWfP/qzFUCun/Q
         vzbBVlwPmmhCT/N3pdpcho/rya6z5whQNiAkAtih4Fvjlfj70TaGbO2O4/hmNaxy45Hx
         WBT/y9lwkGrLCR+0DL1UIhHP7CRnbhVy7ly41nwuqTZaam17kKm+BkOJ7xUVduY0rHb3
         dcJ5llp8jrblPU0ouJBswN98htWxDw+9m8B9k6OgIl2KNQvy8tin8Iasy2XWSOyPe0sQ
         KzDdq9P7avPmCBCsDrRe61+JjcZRsSB9PRdFmQO9oBN6Rkrt4Rzh/wdIfgJJEEGXAd/P
         kB/w==
X-Gm-Message-State: AOAM533l3mM9YXZ2QcQOx7DWgsAJ7ByEMVH8NvB6++t2fAUVm1/sB3Aq
        x5MaEVclOi3jEILDhJaePX/AGIN+bhg=
X-Google-Smtp-Source: ABdhPJyjWWJU9CEm3X3cb76dbITNADh2EgtupTriHCgB2r63kuN+yhU0GBUT9/ogP3YUjC7lKSUq8g==
X-Received: by 2002:a17:902:ceca:b0:13c:8366:deac with SMTP id d10-20020a170902ceca00b0013c8366deacmr1857118plg.68.1631748962782;
        Wed, 15 Sep 2021 16:36:02 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x13sm890980pff.70.2021.09.15.16.36.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:36:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: hci_sock: Replace use of memcpy_from_msg with bt_skb_sendmsg
Date:   Wed, 15 Sep 2021 16:35:58 -0700
Message-Id: <20210915233600.4129808-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915233600.4129808-1-luiz.dentz@gmail.com>
References: <20210915233600.4129808-1-luiz.dentz@gmail.com>
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
index e481eee8e61e..39309ef6af4a 100644
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

