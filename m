Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/11] android/bluetoothd-wrapper: Fix indentation
Date: Mon, 15 Sep 2014 16:49:14 +0200
Message-Id: <1410792555-24765-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetoothd-wrapper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
index 5e15dd8..7f668da 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -72,12 +72,12 @@ int main(int argc, char *argv[])
 
 	if (get_config("debug", value, NULL) > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
-			debug = 1;
+		debug = 1;
 
 	if (get_config("mgmtdbg", value, NULL) > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0)) {
-			debug = 1;
-			mgmt_dbg = 1;
+		debug = 1;
+		mgmt_dbg = 1;
 	}
 
 	if (get_config("valgrind", value, NULL) > 0 &&
-- 
1.9.3

