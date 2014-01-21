Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v2 13/18] gitignore: Add test/gatt-service
Date: Tue, 21 Jan 2014 10:26:49 -0300
Message-Id: <1390310814-19880-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 67e9850..48fcf57 100644
--- a/.gitignore
+++ b/.gitignore
@@ -73,6 +73,7 @@ tools/3dsp
 tools/obexctl
 test/sap_client.pyc
 test/bluezutils.pyc
+test/gatt-service
 unit/test-eir
 unit/test-uuid
 unit/test-crc
-- 
1.8.3.1

