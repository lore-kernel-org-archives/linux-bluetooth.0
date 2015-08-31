Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] TODO: Add item for agent queueing
Date: Mon, 31 Aug 2015 16:05:07 +0300
Message-Id: <1441026307-27322-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 TODO | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/TODO b/TODO
index 2945392..8c710ef 100644
--- a/TODO
+++ b/TODO
@@ -61,6 +61,12 @@ General
   Priority: Low
   Complexity: C2
 
+- Add queueing support for src/agent.c, currently if there is any request
+  pending the code fail with error EBUSY which is very inconvenient.
+
+  Priority: Low
+  Complexity: C2
+
 Low Energy
 ==========
 
-- 
2.4.3

