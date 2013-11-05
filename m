Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android: Stop mainloop if reading version failed
Date: Tue, 5 Nov 2013 15:18:47 +0100
Message-ID: <1383661128-25029-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
References: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If reading mgmt version failed or kernel supported version is to old
mainloop should be stopped.
---
 android/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/android/main.c b/android/main.c
index d68abe1..4bb5101 100644
--- a/android/main.c
+++ b/android/main.c
@@ -592,12 +592,12 @@ static void read_version_complete(uint8_t status, uint16_t length,
 	if (status) {
 		error("Failed to read version information: %s (0x%02x)",
 						mgmt_errstr(status), status);
-		return;
+		goto error;
 	}
 
 	if (length < sizeof(*rp)) {
 		error("Wrong size response");
-		return;
+		goto error;
 	}
 
 	mgmt_version = rp->version;
@@ -608,7 +608,7 @@ static void read_version_complete(uint8_t status, uint16_t length,
 
 	if (MGMT_VERSION(mgmt_version, mgmt_revision) < MGMT_VERSION(1, 3)) {
 		error("Version 1.3 or later of management interface required");
-		return;
+		goto error;
 	}
 
 	mgmt_send(mgmt_if, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE, 0, NULL,
@@ -624,6 +624,9 @@ static void read_version_complete(uint8_t status, uint16_t length,
 		return;
 
 	error("Failed to read controller index list");
+
+error:
+	g_main_loop_quit(event_loop);
 }
 
 static bool init_mgmt_interface(void)
-- 
1.8.4.2

