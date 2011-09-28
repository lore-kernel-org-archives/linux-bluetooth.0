Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/9] Add handler function to manage GATT indications
Date: Wed, 28 Sep 2011 19:48:42 +0200
Message-Id: <1317232126-12640-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1317232126-12640-5-git-send-email-sancane@gmail.com>
References: <1317232126-12640-1-git-send-email-sancane@gmail.com>
 <1317232126-12640-2-git-send-email-sancane@gmail.com>
 <1317232126-12640-3-git-send-email-sancane@gmail.com>
 <1317232126-12640-4-git-send-email-sancane@gmail.com>
 <1317232126-12640-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index e06c6da..f8c17c6 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -40,6 +40,7 @@ struct thermometer {
 	GAttrib			*attrib;	/* GATT connection */
 	struct att_range	*svc_range;	/* Thermometer range */
 	gint                    attioid;	/* Att watcher id */
+	gint			attindid;	/* Att incications id */
 };
 
 static GSList *thermometers = NULL;
@@ -51,6 +52,9 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->attioid)
 		btd_device_remove_attio_callback(t->dev, t->attioid);
 
+	if (t->attindid)
+		g_attrib_unregister(t->attrib, t->attindid);
+
 	if (t->attrib)
 		g_attrib_unref(t->attrib);
 
@@ -135,11 +139,19 @@ static GDBusSignalTable thermometer_signals[] = {
 	{ }
 };
 
+static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	/* TODO: Process indication */
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct thermometer *t = user_data;
 
 	t->attrib = g_attrib_ref(attrib);
+
+	t->attindid = g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
+							ind_handler, t, NULL);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -148,6 +160,11 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	DBG("GATT Disconnected");
 
+	if (t->attindid) {
+		g_attrib_unregister(t->attrib, t->attindid);
+		t->attindid = 0;
+	}
+
 	g_attrib_unref(t->attrib);
 	t->attrib = NULL;
 }
-- 
1.7.6.1

