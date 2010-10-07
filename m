Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] TODO: Implement Client Characteristic Configuration
Date: Thu,  7 Oct 2010 10:53:59 -0300
Message-Id: <1286459639-25194-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1286459639-25194-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1286459639-25194-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index a9f1339..75a929c 100644
--- a/TODO
+++ b/TODO
@@ -18,6 +18,14 @@ Background
 ATT/GATT
 ========
 
+- Implement Client Characteristic Configuration support in the attribute
+  server to manage indications and notications. This is a per client attribute
+  to control how the client wants to receive reports of changes in a given
+  characteristic value.
+
+  Priority: Low
+  Complexity: C2
+
 - gatttool should have the ability to wait for req responses before
   quitting (some servers require a small sleep even with cmd's). Maybe a
   --delay-exit or --timeout command line switch.
-- 
1.7.3.1

