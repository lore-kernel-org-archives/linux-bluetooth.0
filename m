Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v6 13/18] gitignore: Add test/gatt-service
Date: Tue,  4 Feb 2014 14:53:44 -0300
Message-Id: <1391536429-8345-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
 <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index b86deae..3f3c7d4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@ test/sap_client.pyc
 test/bluezutils.pyc
 unit/test-ringbuf
 unit/test-queue
+test/gatt-service
 unit/test-eir
 unit/test-uuid
 unit/test-crc
-- 
1.8.3.1

