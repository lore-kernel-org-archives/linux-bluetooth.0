Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 09/14] thermometer: Add constant definition for watcher interface name
Date: Tue, 25 Sep 2012 16:52:38 +0200
Message-ID: <1348584763-22824-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/thermometer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index f0c1d67..6f3314a 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -44,6 +44,7 @@
 
 #define THERMOMETER_INTERFACE		"org.bluez.Thermometer"
 #define THERMOMETER_MANAGER_INTERFACE	"org.bluez.ThermometerManager"
+#define THERMOMETER_WATCHER_INTERFACE	"org.bluez.ThermometerWatcher"
 
 /* Temperature measurement flag fields */
 #define TEMP_UNITS		0x01
@@ -1034,7 +1035,7 @@ static void update_watcher(gpointer data, gpointer user_data)
 	DBusMessage *msg;
 
 	msg = dbus_message_new_method_call(w->srv, w->path,
-				"org.bluez.ThermometerWatcher",
+				THERMOMETER_WATCHER_INTERFACE,
 				"MeasurementReceived");
 	if (msg == NULL)
 		return;
-- 
1.7.11.3

