Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android: Require at least 1.3 version of mgmt interface
Date: Tue, 5 Nov 2013 15:18:45 +0100
Message-ID: <1383661128-25029-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
References: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android daemon is not providing old kernels compatibility features.
---
 android/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/main.c b/android/main.c
index 7d36976..7ee47fc 100644
--- a/android/main.c
+++ b/android/main.c
@@ -608,8 +608,8 @@ static void read_version_complete(uint8_t status, uint16_t length,
 	info("Bluetooth management interface %u.%u initialized",
 						mgmt_version, mgmt_revision);
 
-	if (mgmt_version < 1) {
-		error("Version 1.0 or later of management interface required");
+	if (MGMT_VERSION(mgmt_version, mgmt_revision) < MGMT_VERSION(1, 3)) {
+		error("Version 1.3 or later of management interface required");
 		return;
 	}
 
-- 
1.8.4.2

