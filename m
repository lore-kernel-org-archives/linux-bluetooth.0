Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: ATT protocol transactions timeout
Date: Tue, 19 Oct 2010 19:27:10 -0200
Message-Id: <1287523632-5966-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index b4682e8..d95932b 100644
--- a/TODO
+++ b/TODO
@@ -137,3 +137,10 @@ ATT/GATT
 
   Priority: Low
   Complexity: C2
+
+- gattrib needs to be extended to handle Attribute Protocol Transactions
+  timeout. See Volume 3, Part F, section 3.3.3 and Part G, section 4.14
+  for more information.
+
+  Priority: Low
+  Complexity: C2
-- 
1.7.3.1

