Return-Path: <cyrus@holtmann.org>
Message-ID: <495A0225.7050007@nokia.com>
Date: Tue, 30 Dec 2008 13:12:37 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: marcel@holtmann.org
Subject: [patch] Fix rfcomm might_sleep issue
Content-Type: multipart/mixed;
 boundary="------------010202020403090800090907"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010202020403090800090907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is a patch to fix might_sleep issue that was found during testing.

-- 
Ville

--------------010202020403090800090907
Content-Type: text/x-patch;
 name="20081230-0001--BLUETOOTH-Remove-sleeping-functions-from-__rfcomm_.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="20081230-0001--BLUETOOTH-Remove-sleeping-functions-from-__rf";
 filename*1="comm_.patch"

>From a9bcfd0886bd6f54486a277b74247b32fd60f02f Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Tue, 30 Dec 2008 12:59:01 +0200
Subject: [PATCH] [BLUETOOTH] Remove sleeping functions from __rfcomm_dlc_close

This patch removes code paths that uses functions
that might sleep. In case of rfcomm_send_disc sock_lock()
in l2cap_sock_sendmsg() and in case of rfcomm_queue_disc()
alloc_skb(size, GFP_KERNEL).


Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/rfcomm/core.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ba537fa..5aad9c7 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -430,13 +430,8 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 	case BT_CONFIG:
 	case BT_CONNECT:
 		d->state = BT_DISCONN;
-		if (skb_queue_empty(&d->tx_queue)) {
-			rfcomm_send_disc(s, d->dlci);
-			rfcomm_dlc_set_timer(d, RFCOMM_DISC_TIMEOUT);
-		} else {
-			rfcomm_queue_disc(d);
-			rfcomm_dlc_set_timer(d, RFCOMM_DISC_TIMEOUT * 2);
-		}
+		rfcomm_queue_disc(d);
+		rfcomm_dlc_set_timer(d, RFCOMM_DISC_TIMEOUT * 2);
 		break;
 
 	default:
@@ -746,7 +741,7 @@ static int rfcomm_queue_disc(struct rfcomm_dlc *d)
 
 	BT_DBG("dlc %p dlci %d", d, d->dlci);
 
-	skb = alloc_skb(sizeof(*cmd), GFP_KERNEL);
+	skb = alloc_skb(sizeof(*cmd), GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
 
-- 
1.6.0.4


--------------010202020403090800090907--
