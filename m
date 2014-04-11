Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/client: Fix parameter completion for gatt
Date: Fri, 11 Apr 2014 14:40:26 +0200
Message-Id: <1397220026-27177-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397220026-27177-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397220026-27177-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes missing service handle in parameters completion for gatt
server add_descriptor method.
---
 android/client/if-gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index da2f299..250472a 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1736,7 +1736,8 @@ static struct method server_methods[] = {
 			"<server_if> <service_handle> <included_handle>"),
 	GATTS_METHODCH(add_characteristic,
 		"<server_if> <service_handle> <uuid> <properites> <permissions>"),
-	GATTS_METHODCH(add_descriptor, "<server_if> <uuid> <permissions>"),
+	GATTS_METHODCH(add_descriptor,
+			"<server_if> <service_handle> <uuid> <permissions>"),
 	GATTS_METHODCH(start_service,
 				"<server_if> <service_handle> <transport>"),
 	GATTS_METHODCH(stop_service, "<server_if> <service_handle>"),
-- 
1.9.1

