Return-Path: <linux-kernel-owner@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: [PATCH] bluetooth, regression: MSG_TRUNC fixes
Message-ID: <9f92cebe-284c-47b1-1e7d-1ed6581b20f4@nextfour.com>
Date: Wed, 24 Aug 2016 13:13:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Recent 4.8-rc changes to bluetooth MSG_TRUNC handling introduced regression; pairing finishes
but connecting profiles not. 

With the below fixes to MSG_TRUNC handling the connection is established normally.

--Mika


Signed-off-by: Mika Penttilä <mika.penttila@nextfour.com>
---

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index ece45e0..0b5f729 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -250,7 +250,7 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, siz
 
        skb_free_datagram(sk, skb);
 
-       if (msg->msg_flags & MSG_TRUNC)
+       if (flags & MSG_TRUNC)
                copied = skblen;
 
        return err ? : copied;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 6ef8a01..96f04b7 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1091,7 +1091,7 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr
 
        skb_free_datagram(sk, skb);
 
-       if (msg->msg_flags & MSG_TRUNC)
+       if (flags & MSG_TRUNC)
                copied = skblen;
 
        return err ? : copied;
