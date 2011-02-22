Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/7] TODO: Changed item related to ATT parsing for hcidump
Date: Tue, 22 Feb 2011 17:43:05 -0300
Message-Id: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/TODO b/TODO
index 1357db9..3617777 100644
--- a/TODO
+++ b/TODO
@@ -87,7 +87,8 @@ ATT/GATT
   Priority: Medium
   Complexity: C1
 
-- Add ATT/GATT parsing to hcidump
+- ATT/GATT parsing to hcidump. Partially implemented, missing to fix
+  multiple advertises in the same event and RSSI.
 
   Priority: Medium
   Complexity: C2
-- 
1.7.4.1

