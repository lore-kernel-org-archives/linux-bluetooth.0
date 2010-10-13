Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] TODO: Implement Client Characteristic Configuration
Date: Wed, 13 Oct 2010 13:34:10 -0300
Message-Id: <1286987650-25914-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1286459639-25194-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1286459639-25194-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 3e62518..7939d9d 100644
--- a/TODO
+++ b/TODO
@@ -89,3 +89,12 @@ ATT/GATT
 
   Priority: Low
   Complexity: C2
+
+- Implement Client Characteristic Configuration support in the attribute
+  server to manage indications and notications. This is a per client attribute
+  to control how the client wants to receive reports of changes in a given
+  characteristic value.
+  See Volume 3, Part G, section 3.3.3.3 for more information
+
+  Priority: Low
+  Complexity: C2
-- 
1.7.3.1

