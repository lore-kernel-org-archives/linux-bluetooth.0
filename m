Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Update TODO regarding bt_uuid_* functions
Date: Wed, 16 Mar 2011 22:36:54 -0300
Message-Id: <1300325814-6247-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/TODO b/TODO
index 1120ad9..3351ac9 100644
--- a/TODO
+++ b/TODO
@@ -17,18 +17,12 @@ Background
 General
 ==========
 
-- UUID128 handling: Create new functions to handle UUIDs on host order.
-  Functions should start with prefix "bt_uuid". In the first phase, attribute
-  server/client and gatttool code should be changed to use these new functions.
-  The idea is to keep the consistency for UUID-16, UUID-32 and UUID-128. SDP
-  functions store UUID-16 and UUID-32 on host order, however UUID-128 is stored
-  on network order/big endian. Attribute Protocol uses little endian, while
-  SDP uses big endian. The idea is always store the UUID values on host order
-  and use utility functions to convert to the proper byte order depending on
-  the protocol: ATT or SDP.
+- UUID handling: Use the new functions created for UUID handling in all parts
+  of BlueZ code.  Currently, the new bt_uuid_* functions are being used by
+  GATT-related code only.
 
   Priority: high
-  Complexity: C1
+  Complexity: C4
 
 - Rename glib-helper file to a more convenient name. The ideia is try to keep
   only sdp helpers functions. bt_* prefix shall be also changed.
-- 
1.7.1

