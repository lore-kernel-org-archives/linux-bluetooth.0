Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/6] Fix possible null pointer deference
Date: Tue, 22 Nov 2011 15:49:46 +0100
Message-Id: <1321973388-16300-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1321973388-16300-4-git-send-email-sancane@gmail.com>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
 <1321973388-16300-2-git-send-email-sancane@gmail.com>
 <1321973388-16300-3-git-send-email-sancane@gmail.com>
 <1321973388-16300-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 9ad7e59..4faf900 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -599,6 +599,9 @@ static DBusMessage *write_attr_interval(struct thermometer *t, DBusMessage *msg,
 	struct characteristic *ch;
 	guint8 atval[2];
 
+	if (t->attrib == NULL)
+		return btd_error_not_connected(msg);
+
 	ch = get_characteristic(t, MEASUREMENT_INTERVAL_UUID);
 	if (ch == NULL)
 		return btd_error_not_available(msg);
@@ -672,6 +675,9 @@ static void enable_final_measurement(struct thermometer *t)
 	uint8_t atval[2];
 	gchar *msg;
 
+	if (t->attrib == NULL)
+		return;
+
 	ch = get_characteristic(t, TEMPERATURE_MEASUREMENT_UUID);
 	if (ch == NULL) {
 		DBG("Temperature measurement characteristic not found");
@@ -699,6 +705,9 @@ static void enable_intermediate_measurement(struct thermometer *t)
 	uint8_t atval[2];
 	gchar *msg;
 
+	if (t->attrib == NULL)
+		return;
+
 	ch = get_characteristic(t, INTERMEDIATE_TEMPERATURE_UUID);
 	if (ch == NULL) {
 		DBG("Intermediate measurement characteristic not found");
@@ -726,6 +735,9 @@ static void disable_final_measurement(struct thermometer *t)
 	uint8_t atval[2];
 	gchar *msg;
 
+	if (t->attrib == NULL)
+		return;
+
 	ch = get_characteristic(t, TEMPERATURE_MEASUREMENT_UUID);
 	if (ch == NULL) {
 		DBG("Temperature measurement characteristic not found");
@@ -753,6 +765,9 @@ static void disable_intermediate_measurement(struct thermometer *t)
 	uint8_t atval[2];
 	gchar *msg;
 
+	if (t->attrib == NULL)
+		return;
+
 	ch = get_characteristic(t, INTERMEDIATE_TEMPERATURE_UUID);
 	if (ch == NULL) {
 		DBG("Intermediate measurement characteristic not found");
-- 
1.7.7.4

