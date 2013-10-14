Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 22/22] gitignore: Add blueatchat unit tests
Date: Mon, 14 Oct 2013 10:34:38 +0200
Message-Id: <1381739678-16260-23-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index f9bf975..c72c911 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@ unit/test-sdp
 unit/test-lib
 unit/test-mgmt
 unit/test-cbuffer
+unit/test-blueatchat
 tools/mgmt-tester
 tools/gap-tester
 tools/btattach
-- 
1.7.9.5

