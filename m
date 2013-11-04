Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android/daemon: Implement get adapter name
Date: Mon,  4 Nov 2013 12:49:39 +0200
Message-Id: <1383562180-21646-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/adapter.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index af461b8..fdac82e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1017,13 +1017,14 @@ static void send_adapter_address(void)
 	g_free(ev);
 }
 
-static bool get_name(void)
+static bool send_adapter_name(void)
 {
-	DBG("Not implemented");
+	if (!adapter->name)
+		return false;
 
-	/* TODO: Add implementation */
+	adapter_name_changed((uint8_t *) adapter->name);
 
-	return false;
+	return true;
 }
 
 static bool get_uuids(void)
@@ -1098,7 +1099,7 @@ static bool get_property(void *buf, uint16_t len)
 		send_adapter_address();
 		return true;
 	case HAL_PROP_ADAPTER_NAME:
-		return get_name();
+		return send_adapter_name();
 	case HAL_PROP_ADAPTER_UUIDS:
 		return get_uuids();
 	case HAL_PROP_ADAPTER_CLASS:
-- 
1.7.10.4

