Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 04/10] android/client: Add init/cleanup for GATT
Date: Thu, 31 Oct 2013 11:45:09 +0100
Message-ID: <1383216315-30627-5-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds gatt functions code.
---
 android/client/if-gatt.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index db5494c..90cc805 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -496,12 +496,20 @@ static const btgatt_callbacks_t gatt_cbacks = {
 
 static void init_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_gatt);
+
+	EXEC(if_gatt->init, &gatt_cbacks);
 }
 
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_gatt);
+
+	EXECV(if_gatt->cleanup);
+
+	if_gatt = NULL;
 }
 
 static struct method methods[] = {
-- 
1.7.9.5

