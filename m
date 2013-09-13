Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/8] core: Minor whitespace fix
Date: Fri, 13 Sep 2013 13:30:46 +0200
Message-ID: <1379071852-10094-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379071852-10094-1-git-send-email-szymon.janc@tieto.com>
References: <1379071852-10094-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/main.c b/src/main.c
index dc0478e..eafe2ed 100644
--- a/src/main.c
+++ b/src/main.c
@@ -282,10 +282,10 @@ static void init_defaults(void)
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
 
-        main_opts.did_source = 0x0002;		/* USB */
-        main_opts.did_vendor = 0x1d6b;		/* Linux Foundation */
-        main_opts.did_product = 0x0246;		/* BlueZ */
-        main_opts.did_version = (major << 8 | minor);
+	main_opts.did_source = 0x0002;		/* USB */
+	main_opts.did_vendor = 0x1d6b;		/* Linux Foundation */
+	main_opts.did_product = 0x0246;		/* BlueZ */
+	main_opts.did_version = (major << 8 | minor);
 }
 
 static GMainLoop *event_loop;
-- 
1.8.4

