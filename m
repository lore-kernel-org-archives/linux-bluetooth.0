Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove fixed item from TODO
Date: Tue,  7 Dec 2010 19:20:37 -0300
Message-Id: <1291760437-32216-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read by UUID is already supported by attribute server and gatttool.
---
 TODO |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/TODO b/TODO
index 32d3a61..54fef16 100644
--- a/TODO
+++ b/TODO
@@ -79,11 +79,6 @@ ATT/GATT
   Priority: Medium
   Complexity: C2
 
-- GATT server: fix read by UUID (read by handle works)
-
-  Priority: Medium
-  Complexity: C2
-
 - gatttool: add an interactive command prompt mode. Many LE devices
   expect the connection to stay up a long time and disable advertising
   after a disconnection so it's inconvenient to use gatttool in the
-- 
1.7.3.2

