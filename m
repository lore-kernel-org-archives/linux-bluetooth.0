Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: update L2CAP SCO, and bluetooth.ko versions
Date: Tue,  8 Feb 2011 16:51:01 -0200
Message-Id: <1297191061-8246-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1297191061-8246-2-git-send-email-padovan@profusion.mobi>
References: <1297191061-8246-1-git-send-email-padovan@profusion.mobi>
 <1297191061-8246-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update to reflect the l2cap.ko sco.ko and bluetooth.ko modules merge.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/af_bluetooth.c |    2 +-
 net/bluetooth/l2cap_core.c   |    2 +-
 net/bluetooth/sco.c          |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index d1413d4..c258027 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -40,7 +40,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 
-#define VERSION "2.15"
+#define VERSION "2.16"
 
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d4cf883..51672ed 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -55,7 +55,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
-#define VERSION "2.15"
+#define VERSION "2.16"
 
 int disable_ertm;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index db40a35..3520938 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -50,7 +50,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/sco.h>
 
-#define VERSION "0.6"
+#define VERSION "0.7"
 
 static int disable_esco;
 
-- 
1.7.4

