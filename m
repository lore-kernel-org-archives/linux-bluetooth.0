Return-Path: <cyrus@holtmann.org>
From: luiz.dentz@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Add Single Response Mode to TODO
Date: Fri, 18 Mar 2011 13:52:47 -0300
Message-Id: <1300467167-32442-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1300467167-32442-1-git-send-email-luiz.dentz@gmail.com>
References: <1300467167-32442-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 TODO |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index d2bbd1a..8330e71 100644
--- a/TODO
+++ b/TODO
@@ -24,3 +24,18 @@ General
 
   Priority: Medium
   Complexity: C2
+
+- Single Response Mode (SRM): The Single Response Mode header shall be used to
+  enable this mode, while the SRMP header may be used to alter the normal
+  processing of SRM for a single request/response exchange during the current
+  operation. The use of the SRMP header is optional; however, GOEP devices that
+  support SRM shall be able to receive and process this header. SRMP headers
+  should be used judiciously as this will impact the overall throughput of the
+  operation using SRM. Receipt of invalid or unexpected Single Response Mode or
+  SRMP header values shall be ignored by the receiving device.
+
+  When SRM is active the action of suspending a request can be notified using SRMP
+  “wait” option (0x01).
+
+  Priority: Low
+  Complexity: C4
-- 
1.7.1

