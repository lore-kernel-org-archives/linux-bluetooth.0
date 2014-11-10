Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 11/11] TODO: Update shared/gatt-server items.
Date: Mon, 10 Nov 2014 09:07:27 -0800
Message-Id: <1415639247-14320-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1415639247-14320-1-git-send-email-armansito@chromium.org>
References: <1415639247-14320-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

shared/gatt-server has been introduced, so removed that item. Added new
items for remaining tasks.
---
 TODO | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/TODO b/TODO
index b5a9612..fec0fa2 100644
--- a/TODO
+++ b/TODO
@@ -120,6 +120,12 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C2
 
+- Use struct iovec to pass around byte buffers that will be sent over the wire,
+  instead of passing uint8_t and size_t parameters everywhere.
+
+  Priority: Medium
+  Complexity: C1
+
 - Introduce a handler interface to shared/gatt-client which can be used by the
   upper layer to determine when the link has been disconnected or an ATT
   protocol request times out.
@@ -155,12 +161,28 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C2
 
-- Introduce shared/gatt-server, which combined with shared/gatt-db, can be used
-  as a GATT server implementation.
+- Introduce a way for shared/gatt-server to check security permissions on the
+  current connection through bt_att.
 
   Priority: Medium
   Complexity: C2
 
+- Provide a tool for shared/gatt-server. This tool should demonstrate how a
+  shared/gatt-db can be used together with a shared/gatt-server to implement the
+  GATT server role. This should be written in a way so that it can be easily
+  used in conjunction with a remote instance of tools/btgatt-client (i.e. it
+  should listen for incoming connections, have similar verbose output, etc.)
+
+  Priority: Medium
+  Complexity: C2
+
+- Implement other low-priority ATT protocol operations for shared/gatt-server:
+
+      Read Multiple Request
+
+  Priority: Low
+  Complexity: C1
+
 - Implement the server portion of doc/gatt-api.txt using shared/gatt-server once
   it exists.
 
-- 
2.1.0.rc2.206.gedb03e5

