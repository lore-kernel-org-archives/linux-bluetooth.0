Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/6] thermometer.c: Fix possible null pointer deference
Date: Fri,  9 Dec 2011 19:19:02 +0100
Message-Id: <1323454744-14589-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1323454744-14589-4-git-send-email-sancane@gmail.com>
References: <1323454744-14589-1-git-send-email-sancane@gmail.com>
 <1323454744-14589-2-git-send-email-sancane@gmail.com>
 <1323454744-14589-3-git-send-email-sancane@gmail.com>
 <1323454744-14589-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch check the GATT server is connected before doing any
GATT transaction. If it isn't, we abort the operation to avoid the
NULL pointer deference problem.
---
 thermometer/thermometer.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index da793a6..ad1569b 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -598,6 +598,9 @@ static DBusMessage *write_attr_interval(struct thermometer *t, DBusMessage *msg,
 	struct characteristic *ch;
 	guint8 atval[2];
 
+	if (t->attrib == NULL)
+		return btd_error_not_connected(msg);
+
 	ch = get_characteristic(t, MEASUREMENT_INTERVAL_UUID);
 	if (ch == NULL)
 		return btd_error_not_available(msg);
@@ -671,6 +674,9 @@ static void enable_final_measurement(struct thermometer *t)
 	uint8_t atval[2];
 	gchar *msg;
 
+	if (t->attrib == NULL)
+		return;
+
 	ch = get_characteristic(t, TEMPERATURE_MEASUREMENT_UUID);
 	if (ch == NULL) {
 		DBG("Temperature measurement characteristic not found");
@@ -698,6 +704,9 @@ static void enable_intermediate_measurement(struct thermometer *t)
 	uint8_t atval[2];
 	gchar *msg;
 
+	if (t->attrib == NULL)
+		return;
+
 	ch = get_characteristic(t, INTERMEDIATE_TEMPERATURE_UUID);
 	if (ch == NULL) {
 		DBG("Intermediate measurement characteristic not found");
@@ -725,6 +734,9 @@ static void disable_final_measurement(struct thermometer *t)
 	uint8_t atval[2];
 	gchar *msg;
 
+	if (t->attrib == NULL)
+		return;
+
 	ch = get_characteristic(t, TEMPERATURE_MEASUREMENT_UUID);
 	if (ch == NULL) {
 		DBG("Temperature measurement characteristic not found");
@@ -752,6 +764,9 @@ static void disable_intermediate_measurement(struct thermometer *t)
 	uint8_t atval[2];
 	gchar *msg;
 
+	if (t->attrib == NULL)
+		return;
+
 	ch = get_characteristic(t, INTERMEDIATE_TEMPERATURE_UUID);
 	if (ch == NULL) {
 		DBG("Intermediate measurement characteristic not found");
-- 
1.7.8

