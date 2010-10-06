Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Add attribute permission verification for attribute server
Date: Wed,  6 Oct 2010 17:34:42 -0300
Message-Id: <1286397282-11921-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 7ebbbe3..2cd141b 100644
--- a/TODO
+++ b/TODO
@@ -32,6 +32,13 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
+- Attribute server shall implement attribute permission verification,
+  returning an error code if necessary. See Volume 3, Part F, 3.2.5
+  for more information.
+
+  Priority: Low
+  Complexity: C2
+
 - Long reads/writes don't work (consisting of multiple request packets)
 
   Priority: Low
-- 
1.7.3.1

