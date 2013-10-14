Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 21/22] gitignore: Add curcular buffer unit tests
Date: Mon, 14 Oct 2013 10:34:37 +0200
Message-Id: <1381739678-16260-22-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index e492c3f..f9bf975 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@ unit/test-gdbus-client
 unit/test-sdp
 unit/test-lib
 unit/test-mgmt
+unit/test-cbuffer
 tools/mgmt-tester
 tools/gap-tester
 tools/btattach
-- 
1.7.9.5

