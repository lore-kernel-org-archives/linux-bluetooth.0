Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/4] android/hal: Update property used for start/stop services
Date: Tue, 14 Jan 2014 16:28:01 +0100
Message-Id: <1389713283-13038-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
References: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 4 ++--
 android/hal-ipc.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index be45836..76560da 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -822,12 +822,12 @@ static int config_hci_snoop_log(uint8_t enable)
 {
 	DBG("enable %u", enable);
 
-	if (enable && property_set("ctl.start", SNOOP_SERVICE_NAME) < 0) {
+	if (enable && property_set("bluetooth.start", SNOOP_SERVICE_NAME) < 0) {
 		error("Failed to start service %s", SNOOP_SERVICE_NAME);
 		return BT_STATUS_FAIL;
 	}
 
-	if (!enable && property_set("ctl.stop", SNOOP_SERVICE_NAME) < 0) {
+	if (!enable && property_set("bluetooth.stop", SNOOP_SERVICE_NAME) < 0) {
 		error("Failed to stop service %s", SNOOP_SERVICE_NAME);
 		return BT_STATUS_FAIL;
 	}
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 97f1bcd..56165df 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -259,7 +259,7 @@ bool hal_ipc_init(void)
 	}
 
 	/* Start Android Bluetooth daemon service */
-	if (property_set("ctl.start", SERVICE_NAME) < 0) {
+	if (property_set("bluetooth.start", SERVICE_NAME) < 0) {
 		error("Failed to start service %s", SERVICE_NAME);
 		close(sk);
 		return false;
-- 
1.8.3.2

