Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] TODO: Bump priority of signed writes
Date: Tue, 10 Feb 2015 17:06:57 +0200
Message-Id: <1423580817-16986-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423580817-16986-1-git-send-email-luiz.dentz@gmail.com>
References: <1423580817-16986-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This has to be completed in order to finalize unit tests as well as use
it in BfA.
---
 TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/TODO b/TODO
index 62b33a0..e489221 100644
--- a/TODO
+++ b/TODO
@@ -102,7 +102,7 @@ ATT/GATT (new shared stack)
 - shared/att currently doesn't handle signed writes. It should be extended to
   support signing outgoing and verify incoming ATT PDUs.
 
-  Priority: Medium
+  Priority: High
   Complexity: C1
 
 - Add complete GATT test coverage in unit/test-gatt following the GATT test
-- 
2.1.0

