Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: ville.tervo@nokia.com
Subject: [PATCH] bluetooth: fix not setting security level when creating a rfcomm session
Date: Thu, 19 Aug 2010 14:06:10 +0300
Message-Id: <1282215970-32758-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This cause 'No Bonding' to be used if userspace has not yet been paired
with remote device since the l2cap socket used to create the rfcomm
session does not have any security level set.

Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
---
 net/bluetooth/rfcomm/core.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 7dca91b..08f5757 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -79,7 +79,10 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr);
 
 static void rfcomm_process_connect(struct rfcomm_session *s);
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err);
+static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
+							bdaddr_t *dst,
+							u8 sec_level,
+							int *err);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
 static void rfcomm_session_del(struct rfcomm_session *s);
 
@@ -402,7 +405,7 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 
 	s = rfcomm_session_get(src, dst);
 	if (!s) {
-		s = rfcomm_session_create(src, dst, &err);
+		s = rfcomm_session_create(src, dst, d->sec_level, &err);
 		if (!s)
 			return err;
 	}
@@ -680,7 +683,10 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 	rfcomm_session_put(s);
 }
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err)
+static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
+							bdaddr_t *dst,
+							u8 sec_level,
+							int *err)
 {
 	struct rfcomm_session *s = NULL;
 	struct sockaddr_l2 addr;
@@ -705,6 +711,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst
 	sk = sock->sk;
 	lock_sock(sk);
 	l2cap_pi(sk)->imtu = l2cap_mtu;
+	l2cap_pi(sk)->sec_level = sec_level;
 	if (l2cap_ertm)
 		l2cap_pi(sk)->mode = L2CAP_MODE_ERTM;
 	release_sock(sk);
-- 
1.7.0.4

