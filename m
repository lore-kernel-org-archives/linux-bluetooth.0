Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 3/4] tools: Fix coding style when testing pointer
Date: Fri, 21 Mar 2014 16:20:32 -0300
Message-Id: <1395429633-656-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes tools/gatt-service.c coding style, using !ptr instead
of ptr == NULL.
---
 tools/gatt-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 255f3bb..71f7a50 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -272,7 +272,7 @@ static void register_external_service(gpointer a, gpointer b)
 
 	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
 					GATT_MGR_IFACE, "RegisterService");
-	if (msg == NULL) {
+	if (!msg) {
 		printf("Couldn't allocate D-Bus message\n");
 		return;
 	}
-- 
1.8.3.1

