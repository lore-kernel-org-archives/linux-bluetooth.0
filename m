Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Fix RFCOMM bind issue
Date: Wed, 10 Oct 2012 22:09:27 +0530
Message-id: <1349887169-20880-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Problem: If we bind a particular RFCOMM channel with source address as
BDADDR_ANY, then we are able to bind the same RFCOMM channel with the
adapter address, which is incorrect.

Solution: Add check for comparing the stored source address and
given source address against BDADDR_ANY, so that irrespective of
BADADDR_ANY or any adapter address, a particular RFCOMM channel will
be allowed to bind only once.

Details:
Here given the steps to reproduce this issue:
Bind to a RFCOMM channel without the device address.
-sh-4.1# rctest -w -P 5
rctest[2920]: Waiting for connection on channel 5 ...

In another terminal, bind to same RFCOMM channel with a device address
-sh-4.1# rctest -w -P 5 -i hci0
rctest[2922]: Waiting for connection on channel 5 ...

Here we can see the binding is successful for both cases for the same
RFCOMM channel. After this fix, the binding for a particular RFCOMM
channel is allowed only once.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/rfcomm/sock.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 867a065..4add776 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -110,8 +110,16 @@ static struct sock *__rfcomm_get_sock_by_addr(u8 channel, bdaddr_t *src)
 	struct hlist_node *node;
 
 	sk_for_each(sk, node, &rfcomm_sk_list.head) {
-		if (rfcomm_pi(sk)->channel == channel &&
-				!bacmp(&bt_sk(sk)->src, src))
+		if (rfcomm_pi(sk)->channel != channel)
+			continue;
+
+		/* Exact match */
+		if (!bacmp(&bt_sk(sk)->src, src))
+			break;
+
+		/* BDADDR_ANY match */
+		if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY) ||
+		    !bacmp(src, BDADDR_ANY))
 			break;
 	}
 
-- 
1.7.9.5

