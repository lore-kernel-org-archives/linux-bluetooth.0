Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5E8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426046069E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 14:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhGXNXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 09:23:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56836 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhGXNXo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 09:23:44 -0400
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16OE3p8p052500;
        Sat, 24 Jul 2021 23:03:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 24 Jul 2021 23:03:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16OE3iAa052479
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 24 Jul 2021 23:03:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] Bluetooth: use helper function for monitor's open/close notifications
Date:   Sat, 24 Jul 2021 23:03:31 +0900
Message-Id: <20210724140331.3465-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_sock.c has many
hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED, NULL);
calls. Use helper functions and replace skb with sk.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/bluetooth/hci_sock.c | 96 ++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 59 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 786a06a232fd..fc2336855dab 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -295,6 +295,11 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 	read_unlock(&hci_sk_list.lock);
 }
 
+static void __hci_send_to_monitor(struct sk_buff *skb)
+{
+	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED, NULL);
+}
+
 /* Send frame to monitor socket */
 void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -350,8 +355,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	hdr->index = cpu_to_le16(hdev->id);
 	hdr->len = cpu_to_le16(skb->len);
 
-	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb_copy,
-			    HCI_SOCK_TRUSTED, NULL);
+	__hci_send_to_monitor(skb_copy);
 	kfree_skb(skb_copy);
 }
 
@@ -545,6 +549,16 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 	return skb;
 }
 
+static void hci_monitor_ctrl_open(struct sock *sk)
+{
+	struct sk_buff *skb = create_monitor_ctrl_open(sk);
+
+	if (skb) {
+		__hci_send_to_monitor(skb);
+		kfree_skb(skb);
+	}
+}
+
 static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 {
 	struct hci_mon_hdr *hdr;
@@ -583,6 +597,16 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 	return skb;
 }
 
+static void hci_monitor_ctrl_close(struct sock *sk)
+{
+	struct sk_buff *skb = create_monitor_ctrl_close(sk);
+
+	if (skb) {
+		__hci_send_to_monitor(skb);
+		kfree_skb(skb);
+	}
+}
+
 static struct sk_buff *create_monitor_ctrl_command(struct sock *sk, u16 index,
 						   u16 opcode, u16 len,
 						   const void *buf)
@@ -741,8 +765,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 		/* Send event to monitor */
 		skb = create_monitor_event(hdev, event);
 		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
+			__hci_send_to_monitor(skb);
 			kfree_skb(skb);
 		}
 	}
@@ -859,7 +882,6 @@ static int hci_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev;
-	struct sk_buff *skb;
 
 	BT_DBG("sock %p sk %p", sock, sk);
 
@@ -876,12 +898,7 @@ static int hci_sock_release(struct socket *sock)
 	case HCI_CHANNEL_USER:
 	case HCI_CHANNEL_CONTROL:
 		/* Send event to monitor */
-		skb = create_monitor_ctrl_close(sk);
-		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
-			kfree_skb(skb);
-		}
+		hci_monitor_ctrl_close(sk);
 
 		hci_sock_free_cookie(sk);
 		break;
@@ -1021,18 +1038,11 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	 * of a given socket.
 	 */
 	if (hci_sock_gen_cookie(sk)) {
-		struct sk_buff *skb;
-
 		if (capable(CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		/* Send event to monitor */
-		skb = create_monitor_ctrl_open(sk);
-		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
-			kfree_skb(skb);
-		}
+		hci_monitor_ctrl_open(sk);
 	}
 
 	release_sock(sk);
@@ -1114,7 +1124,6 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 	struct sockaddr_hci haddr;
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev = NULL;
-	struct sk_buff *skb;
 	int len, err = 0;
 
 	BT_DBG("sock %p sk %p", sock, sk);
@@ -1162,12 +1171,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 * notification. Send a close notification first to
 			 * allow the state transition to bounded.
 			 */
-			skb = create_monitor_ctrl_close(sk);
-			if (skb) {
-				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-						    HCI_SOCK_TRUSTED, NULL);
-				kfree_skb(skb);
-			}
+			hci_monitor_ctrl_close(sk);
 		}
 
 		if (capable(CAP_NET_ADMIN))
@@ -1176,12 +1180,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		hci_pi(sk)->hdev = hdev;
 
 		/* Send event to monitor */
-		skb = create_monitor_ctrl_open(sk);
-		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
-			kfree_skb(skb);
-		}
+		hci_monitor_ctrl_open(sk);
 		break;
 
 	case HCI_CHANNEL_USER:
@@ -1251,12 +1250,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 * a user channel socket. For a clean transition, send
 			 * the close notification first.
 			 */
-			skb = create_monitor_ctrl_close(sk);
-			if (skb) {
-				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-						    HCI_SOCK_TRUSTED, NULL);
-				kfree_skb(skb);
-			}
+			hci_monitor_ctrl_close(sk);
 		}
 
 		/* The user channel is restricted to CAP_NET_ADMIN
@@ -1267,12 +1261,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		hci_pi(sk)->hdev = hdev;
 
 		/* Send event to monitor */
-		skb = create_monitor_ctrl_open(sk);
-		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
-			kfree_skb(skb);
-		}
+		hci_monitor_ctrl_open(sk);
 
 		atomic_inc(&hdev->promisc);
 		break;
@@ -1359,21 +1348,11 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 				 * allow for a clean transition, send the
 				 * close notification first.
 				 */
-				skb = create_monitor_ctrl_close(sk);
-				if (skb) {
-					hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-							    HCI_SOCK_TRUSTED, NULL);
-					kfree_skb(skb);
-				}
+				hci_monitor_ctrl_close(sk);
 			}
 
 			/* Send event to monitor */
-			skb = create_monitor_ctrl_open(sk);
-			if (skb) {
-				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-						    HCI_SOCK_TRUSTED, NULL);
-				kfree_skb(skb);
-			}
+			hci_monitor_ctrl_open(sk);
 
 			hci_sock_set_flag(sk, HCI_MGMT_INDEX_EVENTS);
 			hci_sock_set_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
@@ -1559,8 +1538,7 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 		skb = create_monitor_ctrl_command(sk, index, opcode, len,
 						  buf + sizeof(*hdr));
 		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
+			__hci_send_to_monitor(skb);
 			kfree_skb(skb);
 		}
 	}
@@ -1715,7 +1693,7 @@ static int hci_logging_frame(struct sock *sk, struct msghdr *msg, int len)
 
 	hdr->opcode = cpu_to_le16(HCI_MON_USER_LOGGING);
 
-	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED, NULL);
+	__hci_send_to_monitor(skb);
 	err = len;
 
 	if (hdev)
-- 
2.18.4

