Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Aleksander Drewnicki <ext.aleksander.drewnicki@tieto.com>
Subject: [PATCH 10/10] android/client: Add completion for mce method
Date: Thu,  9 Oct 2014 14:45:14 +0200
Message-Id: <1412858714-2845-11-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aleksander Drewnicki <ext.aleksander.drewnicki@tieto.com>

This patch adds completion functions to mce method.
---
 android/client/if-mce.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/client/if-mce.c b/android/client/if-mce.c
index 76c9f73..5f101e0 100644
--- a/android/client/if-mce.c
+++ b/android/client/if-mce.c
@@ -54,6 +54,15 @@ static void init_p(int argc, const char **argv)
 	EXEC(if_mce->init, &mce_cbacks);
 }
 
+static void get_remote_mas_instances_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = NULL;
+		*enum_func = enum_devices;
+	}
+}
+
 /* search for MAS instances on remote device */
 
 static void get_remote_mas_instances_p(int argc, const char **argv)
@@ -68,7 +77,7 @@ static void get_remote_mas_instances_p(int argc, const char **argv)
 
 static struct method methods[] = {
 	STD_METHOD(init),
-	STD_METHODH(get_remote_mas_instances, "<addr>"),
+	STD_METHODCH(get_remote_mas_instances, "<addr>"),
 	END_METHOD
 };
 
-- 
1.9.3

