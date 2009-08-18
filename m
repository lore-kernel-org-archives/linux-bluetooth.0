Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH] Fix audio.conf parsing bug - sink and source were transposed.
Date: Tue, 18 Aug 2009 15:32:49 -0700
Message-Id: <1250634769-12220-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/a2dp.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 45be5d4..41b8f88 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1098,9 +1098,9 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		if (strstr(str, "Sink"))
-			source = TRUE;
-		if (strstr(str, "Source"))
 			sink = TRUE;
+		if (strstr(str, "Source"))
+			source = TRUE;
 		g_free(str);
 	}
 
@@ -1111,9 +1111,9 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		if (strstr(str, "Sink"))
-			source = FALSE;
-		if (strstr(str, "Source"))
 			sink = FALSE;
+		if (strstr(str, "Source"))
+			source = FALSE;
 		g_free(str);
 	}
 
-- 
1.6.3.1

