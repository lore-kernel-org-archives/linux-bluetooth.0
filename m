Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/5] TODO: remove 'fix MTU exchange' task
Date: Wed, 16 Mar 2011 07:25:08 -0400
Message-Id: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/TODO b/TODO
index 1120ad9..8b92808 100644
--- a/TODO
+++ b/TODO
@@ -136,11 +136,6 @@ ATT/GATT
   Priority: Medium
   Complexity: C2
 
-- GATT server: fix MTU exchange
-
-  Priority: Medium
-  Complexity: C2
-
 - Implement ATT PDU validation. Malformed PDUs can cause division by zero
   when decoding PDUs. A proper error PDU should be returned for this case.
   See decoding function in att.c file.
-- 
1.7.0.4

