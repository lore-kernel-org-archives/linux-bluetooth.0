Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 7/7] TODO: Add item to support characteristic authorization in the agent
Date: Tue, 22 Feb 2011 17:43:11 -0300
Message-Id: <1298407391-19260-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index c53339b..c69e7bb 100644
--- a/TODO
+++ b/TODO
@@ -119,6 +119,12 @@ ATT/GATT
   Priority: Medium
   Complexity: C2
 
+- Agent for characteristics: Agent interface should be extended to support
+  authorization per characteristic if the remote is not in the trusted list.
+
+  Priority: Low
+  Complexity: C1
+
 - gatttool should have the ability to wait for req responses before
   quitting (some servers require a small sleep even with cmd's). Maybe a
   --delay-exit or --timeout command line switch.
-- 
1.7.4.1

