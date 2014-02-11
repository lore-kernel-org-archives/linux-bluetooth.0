Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] Bluetooth: Fix channel check when binding RFCOMM sock
Date: Tue, 11 Feb 2014 12:50:13 +0100
Message-ID: <1392119413-26341-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When binding RFCOMM socket we should only check if there is another
socket bound or listening on the same channel number. In other case,
it won't be possible to bind/listen on a channel in case we have
connection made to remote device on the same channel number.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/rfcomm/sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 00573fb..9912e23 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -331,6 +331,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 {
 	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
 	struct sock *sk = sock->sk;
+	struct sock *sk1;
 	int err = 0;
 
 	BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
@@ -352,7 +353,9 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 
 	write_lock(&rfcomm_sk_list.lock);
 
-	if (sa->rc_channel && __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
+	sk1 = __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr);
+	if (sa->rc_channel && sk1 && (sk1->sk_state == BT_BOUND ||
+						sk1->sk_state == BT_LISTEN)) {
 		err = -EADDRINUSE;
 	} else {
 		/* Save source address */
-- 
1.8.5.3

