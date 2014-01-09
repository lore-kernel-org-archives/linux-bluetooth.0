Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@gmail.com,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 13/18] gitignore: Add test/gatt-service
Date: Thu,  9 Jan 2014 13:38:18 -0300
Message-Id: <1389285503-19348-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
 <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 3e0641d..f79378d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -70,6 +70,7 @@ tools/3dsp
 tools/obexctl
 test/sap_client.pyc
 test/bluezutils.pyc
+test/gatt-service
 unit/test-eir
 unit/test-uuid
 unit/test-crc
-- 
1.8.3.1

