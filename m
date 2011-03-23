Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Add item related to authorization and authentication
Date: Wed, 23 Mar 2011 16:40:12 -0300
Message-Id: <1300909212-15709-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1300909212-15709-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1300909212-15709-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index b05cfc0..0e06f99 100644
--- a/TODO
+++ b/TODO
@@ -124,6 +124,15 @@ ATT/GATT
   Priority: Medium
   Complexity: C1
 
+- At the moment authentication and authorization is not supported at the
+  same time, read/write requirements in the attribute server needs to
+  be extended. According to Bluetooth Specification a server shall check
+  authentication and authorization requirements before any other check is
+  performed.
+
+  Priority: Medium
+  Complexity: C1
+
 - ATT/GATT parsing to hcidump. Partially implemented, missing to fix
   multiple advertises in the same event and RSSI.
 
-- 
1.7.4.1

