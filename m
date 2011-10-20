Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/8] Disable final measurements indication when last watcher is removed
Date: Thu, 20 Oct 2011 11:46:49 +0200
Message-Id: <1319104011-27747-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1319104011-27747-6-git-send-email-sancane@gmail.com>
References: <1319104011-27747-1-git-send-email-sancane@gmail.com>
 <1319104011-27747-2-git-send-email-sancane@gmail.com>
 <1319104011-27747-3-git-send-email-sancane@gmail.com>
 <1319104011-27747-4-git-send-email-sancane@gmail.com>
 <1319104011-27747-5-git-send-email-sancane@gmail.com>
 <1319104011-27747-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 4a03fc6..9b14e6f 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -532,7 +532,30 @@ static void enable_final_measurement(struct thermometer *t)
 
 static void disable_final_measurement(struct thermometer *t)
 {
-	/* TODO: disable final measurements */
+	struct characteristic *ch;
+	struct descriptor *desc;
+	bt_uuid_t btuuid;
+	uint8_t atval[2];
+	gchar *msg;
+
+	ch = get_characteristic(t, TEMPERATURE_MEASUREMENT_UUID);
+	if (ch == NULL) {
+		DBG("Temperature measurement characteristic not found");
+		return;
+	}
+
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	desc = get_descriptor(ch, &btuuid);
+	if (desc == NULL) {
+		DBG("Client characteristic configuration descriptor not found");
+		return;
+	}
+
+	atval[0] = 0x00;
+	atval[1] = 0x00;
+	msg = g_strdup("Disable final measurement");
+	gatt_write_char(t->attrib, desc->handle, atval, 2,
+						final_measurement_cb, msg);
 }
 
 static void watcher_exit(DBusConnection *conn, void *user_data)
-- 
1.7.6.1

