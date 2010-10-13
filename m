Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Implement Server Characteristic Configuration
Date: Wed, 13 Oct 2010 13:37:13 -0300
Message-Id: <1286987833-25972-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1286460773-25436-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1286460773-25436-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 7939d9d..0a7b482 100644
--- a/TODO
+++ b/TODO
@@ -78,6 +78,14 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
+- Implement Server characteristic Configuration support in the attribute
+  server to manage characteristic value broadcasting. There is a single
+  instance of the Server Characteristic Configuration for all clients.
+  See Volume 3, Part G, section 3.3.3.4 for more information.
+
+  Priority: Low
+  Complexity: C1
+
 - Long reads/writes don't work (consisting of multiple request packets)
 
   Priority: Low
-- 
1.7.3.1

