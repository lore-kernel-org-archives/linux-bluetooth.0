Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Implement Server Characteristic Configuration
Date: Thu,  7 Oct 2010 11:12:53 -0300
Message-Id: <1286460773-25436-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 75a929c..d594592 100644
--- a/TODO
+++ b/TODO
@@ -18,6 +18,14 @@ Background
 ATT/GATT
 ========
 
+- Implement Server characteristic Configuration support in the attribute
+  server to manage characteristic value broadcasting. There is a single
+  instance of the Server Characteristic Configuration for all clients.
+  See Volume 3, Part G, section 3.3.3.4 for more information.
+
+  Priority: Low
+  Complexity: C1
+
 - Implement Client Characteristic Configuration support in the attribute
   server to manage indications and notications. This is a per client attribute
   to control how the client wants to receive reports of changes in a given
-- 
1.7.3.1

