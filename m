Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Add item related to ATT PDU decoding issue
Date: Thu, 24 Feb 2011 18:21:33 -0300
Message-Id: <1298582493-28879-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index c69e7bb..0f336c8 100644
--- a/TODO
+++ b/TODO
@@ -119,6 +119,13 @@ ATT/GATT
   Priority: Medium
   Complexity: C2
 
+- Implement ATT PDU validation. Malformed PDUs can cause division by zero
+  when decoding PDUs. A proper error PDU should be returned for this case.
+  See decoding function in att.c file.
+
+  Priority: Medium
+  Complexity: C1
+
 - Agent for characteristics: Agent interface should be extended to support
   authorization per characteristic if the remote is not in the trusted list.
 
-- 
1.7.4.1

