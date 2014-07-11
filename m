Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Remove unused SCO_DEFAULT_FLUSH_TO constant
Date: Fri, 11 Jul 2014 06:19:43 +0200
Message-Id: <1405052384-5981-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SCO_DEFAULT_FLUSH_TO constant has been defined, but it is not
used anywhere and so just remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/sco.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 42a0d089d715..ab8b1ed550d2 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -27,7 +27,6 @@
 
 /* SCO defaults */
 #define SCO_DEFAULT_MTU		500
-#define SCO_DEFAULT_FLUSH_TO	0xFFFF
 
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
-- 
1.9.3

