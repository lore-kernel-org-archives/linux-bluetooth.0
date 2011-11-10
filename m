Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/6] Notify intermediate measurements
Date: Thu, 10 Nov 2011 12:37:02 +0100
Message-Id: <1320925022-21891-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1320925022-21891-6-git-send-email-sancane@gmail.com>
References: <1320925022-21891-1-git-send-email-sancane@gmail.com>
 <1320925022-21891-2-git-send-email-sancane@gmail.com>
 <1320925022-21891-3-git-send-email-sancane@gmail.com>
 <1320925022-21891-4-git-send-email-sancane@gmail.com>
 <1320925022-21891-5-git-send-email-sancane@gmail.com>
 <1320925022-21891-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   47 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 0663b3c..fb03b8d 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -61,6 +61,7 @@ struct thermometer {
 	struct att_range	*svc_range;	/* Thermometer range */
 	guint			attioid;	/* Att watcher id */
 	guint			attindid;	/* Att incications id */
+	guint			attnotid;	/* Att notifications id */
 	GSList			*chars;		/* Characteristics */
 	GSList			*fwatchers;     /* Final measurements */
 	GSList			*iwatchers;     /* Intermediate measurements */
@@ -152,6 +153,9 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->attindid > 0)
 		g_attrib_unregister(t->attrib, t->attindid);
 
+	if (t->attnotid > 0)
+		g_attrib_unregister(t->attrib, t->attnotid);
+
 	if (t->attrib != NULL)
 		g_attrib_unref(t->attrib);
 
@@ -893,12 +897,14 @@ static void update_watcher(gpointer data, gpointer user_data)
 
 static void recv_measurement(struct thermometer *t, struct measurement *msmt)
 {
-	if (g_strcmp0(msmt->msmnt, "Intermediate") == 0) {
-		DBG("Notification of intermediate measurement not implemented");
-		return;
-	}
+	GSList *wlist;
 
-	g_slist_foreach(t->fwatchers, update_watcher, msmt);
+	if (g_strcmp0(msmt->msmnt, "Intermediate") == 0)
+		wlist = t->iwatchers;
+	else
+		wlist = t->fwatchers;
+
+	g_slist_foreach(wlist, update_watcher, msmt);
 }
 
 static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
@@ -1015,6 +1021,30 @@ static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 									NULL);
 }
 
+static void notif_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	struct thermometer *t = user_data;
+	const struct characteristic *ch;
+	uint16_t handle;
+	GSList *l;
+
+	if (len < 3) {
+		DBG("Bad pdu received");
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+	l = g_slist_find_custom(t->chars, &handle, cmp_char_val_handle);
+	if (l == NULL) {
+		DBG("Unexpected handle: 0x%04x", handle);
+		return;
+	}
+
+	ch = l->data;
+	if (g_strcmp0(ch->attr.uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0)
+		proc_measurement(t, pdu, len, FALSE);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -1023,6 +1053,8 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	t->attindid = g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
 							ind_handler, t, NULL);
+	t->attnotid = g_attrib_register(t->attrib, ATT_OP_HANDLE_NOTIFY,
+							notif_handler, t, NULL);
 	gatt_discover_char(t->attrib, t->svc_range->start, t->svc_range->end,
 					NULL, configure_thermometer_cb, t);
 }
@@ -1038,6 +1070,11 @@ static void attio_disconnected_cb(gpointer user_data)
 		t->attindid = 0;
 	}
 
+	if (t->attnotid > 0) {
+		g_attrib_unregister(t->attrib, t->attnotid);
+		t->attnotid = 0;
+	}
+
 	g_attrib_unref(t->attrib);
 	t->attrib = NULL;
 }
-- 
1.7.7.3

