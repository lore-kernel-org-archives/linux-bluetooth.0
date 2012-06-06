Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Lock l2cap chan in sockopt
Date: Wed,  6 Jun 2012 17:43:28 +0300
Message-Id: <1338993808-30783-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a4bb27e..373ce9c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -275,6 +275,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
@@ -345,6 +346,8 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 	}
 
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+
 	return err;
 }
 
@@ -367,6 +370,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
@@ -442,6 +446,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 	}
 
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+
 	return err;
 }
 
@@ -471,6 +477,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 
 	BT_DBG("sk %p", sk);
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
@@ -556,6 +563,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 	}
 
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+
 	return err;
 }
 
@@ -577,6 +586,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
@@ -729,6 +739,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 	}
 
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+
 	return err;
 }
 
-- 
1.7.9.5

