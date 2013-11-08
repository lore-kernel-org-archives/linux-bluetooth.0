Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Fix error handling in adapter_ready
Date: Fri, 8 Nov 2013 15:00:59 +0100
Message-ID: <1383919259-11782-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On error negative value is passed to adapter_ready callback. This fix
passing negative error code to strerror.
---
 android/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/main.c b/android/main.c
index 93870d0..36cc8aa 100644
--- a/android/main.c
+++ b/android/main.c
@@ -465,8 +465,8 @@ static GOptionEntry options[] = {
 
 static void adapter_ready(int err)
 {
-	if (err) {
-		error("Adapter initialization failed: %s", strerror(err));
+	if (err < 0) {
+		error("Adapter initialization failed: %s", strerror(-err));
 		exit(EXIT_FAILURE);
 	}
 
-- 
1.8.4.2

