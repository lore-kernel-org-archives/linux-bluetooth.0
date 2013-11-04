Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/daemon: Implement get adapter name
Date: Mon,  4 Nov 2013 11:39:12 +0200
Message-Id: <1383557952-9302-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383556934-5481-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383556934-5481-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/adapter.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index cb92f2f..55c495c 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -71,6 +71,8 @@ static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 {
 	const struct mgmt_cp_set_local_name *rp = param;
 
+	DBG("");
+
 	if (length < sizeof(*rp)) {
 		error("Wrong size of local name changed parameters");
 		return;
@@ -1016,13 +1018,14 @@ static void send_adapter_address(void)
 	g_free(ev);
 }
 
-static bool get_name(void)
+static bool send_adapter_name(void)
 {
-	DBG("Not implemented");
+	if (!adapter->name)
+		return false;
 
-	/* TODO: Add implementation */
+	adapter_name_changed(adapter->name);
 
-	return false;
+	return true;
 }
 
 static bool get_uuids(void)
@@ -1097,7 +1100,7 @@ static bool get_property(void *buf, uint16_t len)
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

