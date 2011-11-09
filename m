Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/6] Notify intermediate measurements
Date: Wed,  9 Nov 2011 11:52:03 +0100
Message-Id: <1320835923-10989-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1320835923-10989-6-git-send-email-sancane@gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
 <1320835923-10989-2-git-send-email-sancane@gmail.com>
 <1320835923-10989-3-git-send-email-sancane@gmail.com>
 <1320835923-10989-4-git-send-email-sancane@gmail.com>
 <1320835923-10989-5-git-send-email-sancane@gmail.com>
 <1320835923-10989-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   50 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 849b040..384f883 100644
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
 
@@ -894,14 +898,14 @@ static void update_watcher(struct watcher *w, struct measurement *m)
 
 static void recv_measurement(struct thermometer *t, struct measurement *msmt)
 {
-	GSList *l;
+	GSList *l, *ll;
 
-	if (g_strcmp0(msmt->msmnt, "Intermediate") == 0) {
-		DBG("Notification of intermediate measurement not implemented");
-		return;
-	}
+	if (g_strcmp0(msmt->msmnt, "Intermediate") == 0)
+		ll = t->iwatchers;
+	else
+		ll = t->fwatchers;
 
-	for (l = t->fwatchers; l; l = l->next)
+	for (l = ll; l; l = l->next)
 		update_watcher(l->data, msmt);
 }
 
@@ -1022,6 +1026,33 @@ done:
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
+	if (pdu[0] != ATT_OP_HANDLE_NOTIFY) {
+		DBG("Not notification received");
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+	l = g_slist_find_custom(t->chars, &handle, cmp_char_val_handle);
+	if (l == NULL)
+		return;
+
+	ch = l->data;
+	if (g_strcmp0(ch->attr.uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0)
+		proc_measurement(t, pdu, len, FALSE);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -1030,6 +1061,8 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	t->attindid = g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
 							ind_handler, t, NULL);
+	t->attnotid = g_attrib_register(t->attrib, ATT_OP_HANDLE_NOTIFY,
+							notif_handler, t, NULL);
 	gatt_discover_char(t->attrib, t->svc_range->start, t->svc_range->end,
 					NULL, configure_thermometer_cb, t);
 }
@@ -1045,6 +1078,11 @@ static void attio_disconnected_cb(gpointer user_data)
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
1.7.7.2

