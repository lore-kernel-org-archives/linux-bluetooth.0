Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v5 13/18] gitignore: Add test/gatt-service
Date: Mon, 27 Jan 2014 17:35:19 -0300
Message-Id: <1390854924-31904-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index e2b23fc..5e5880f 100644
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

