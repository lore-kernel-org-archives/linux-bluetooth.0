Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Move SCO timeout constants into net/bluetooth/sco.c
Date: Fri, 11 Jul 2014 06:19:44 +0200
Message-Id: <1405052384-5981-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no external user of the SCO timeout constants and thus
move them into net/bluetooth/sco.c where they are actuallu used.

In addition just remove SCO_CONN_IDLE_TIMEOUT since it is unused.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/sco.h | 4 ----
 net/bluetooth/sco.c         | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index ab8b1ed550d2..f40ddb4264fc 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -28,10 +28,6 @@
 /* SCO defaults */
 #define SCO_DEFAULT_MTU		500
 
-#define SCO_CONN_TIMEOUT	(HZ * 40)
-#define SCO_DISCONN_TIMEOUT	(HZ * 2)
-#define SCO_CONN_IDLE_TIMEOUT	(HZ * 60)
-
 /* SCO socket address */
 struct sockaddr_sco {
 	sa_family_t	sco_family;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 9868ec7c7dc4..e6c7b636b901 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -72,6 +72,9 @@ struct sco_pinfo {
 };
 
 /* ---- SCO timers ---- */
+#define SCO_CONN_TIMEOUT	(HZ * 40)
+#define SCO_DISCONN_TIMEOUT	(HZ * 2)
+
 static void sco_sock_timeout(unsigned long arg)
 {
 	struct sock *sk = (struct sock *) arg;
-- 
1.9.3

