Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/2] TODO: tools/btgatt-server has been introduced.
Date: Mon, 17 Nov 2014 08:08:12 -0800
Message-Id: <1416240492-6122-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1416240492-6122-1-git-send-email-armansito@chromium.org>
References: <1416240492-6122-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/TODO b/TODO
index fec0fa2..ca3779b 100644
--- a/TODO
+++ b/TODO
@@ -167,15 +167,6 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C2
 
-- Provide a tool for shared/gatt-server. This tool should demonstrate how a
-  shared/gatt-db can be used together with a shared/gatt-server to implement the
-  GATT server role. This should be written in a way so that it can be easily
-  used in conjunction with a remote instance of tools/btgatt-client (i.e. it
-  should listen for incoming connections, have similar verbose output, etc.)
-
-  Priority: Medium
-  Complexity: C2
-
 - Implement other low-priority ATT protocol operations for shared/gatt-server:
 
       Read Multiple Request
-- 
2.1.0.rc2.206.gedb03e5

