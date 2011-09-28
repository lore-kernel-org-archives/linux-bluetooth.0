Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 7/9] Read temperature type characteristic
Date: Wed, 28 Sep 2011 19:48:44 +0200
Message-Id: <1317232126-12640-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1317232126-12640-7-git-send-email-sancane@gmail.com>
References: <1317232126-12640-1-git-send-email-sancane@gmail.com>
 <1317232126-12640-2-git-send-email-sancane@gmail.com>
 <1317232126-12640-3-git-send-email-sancane@gmail.com>
 <1317232126-12640-4-git-send-email-sancane@gmail.com>
 <1317232126-12640-5-git-send-email-sancane@gmail.com>
 <1317232126-12640-6-git-send-email-sancane@gmail.com>
 <1317232126-12640-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   47 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index f0b977e..de5f155 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -47,6 +47,13 @@ struct thermometer {
 	gint                    attioid;	/* Att watcher id */
 	gint			attindid;	/* Att incications id */
 	GSList			*chars;		/* Characteristics */
+	gboolean		intermediate;
+	guint8			type;
+	guint16			interval;
+	guint16			max;
+	guint16			min;
+	gboolean		has_type;
+	gboolean		has_interval;
 };
 
 struct characteristic {
@@ -63,6 +70,24 @@ struct descriptor {
 
 static GSList *thermometers = NULL;
 
+static gchar* temptype2str(uint8_t value)
+{
+	switch (value) {
+	case 1: return "Armpit";
+	case 2: return "Body";
+	case 3: return "Ear";
+	case 4: return "Finger";
+	case 5: return "Intestines";
+	case 6: return "Mouth";
+	case 7: return "Rectum";
+	case 8: return "Toe";
+	case 9: return "Tympanum";
+	default:
+		error("Temperature type %d reserved for future use", value);
+		return NULL;
+	};
+}
+
 static void destroy_char(gpointer user_data)
 {
 	struct characteristic *c = user_data;
@@ -113,7 +138,27 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	/* TODO */
+	struct characteristic *ch = user_data;
+	struct thermometer *t = ch->t;
+	uint8_t value;
+	int vlen;
+
+	if (status != 0) {
+		DBG("Temperature Type value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, len, &value, &vlen)) {
+		DBG("Protocol error");
+		return;
+	}
+
+	DBG("TEMPERATURE TYPE: %s", temptype2str(value));
+	if (!t->has_interval)
+		t->has_interval = TRUE;
+
+	t->type = value;
 }
 
 static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
-- 
1.7.6.1

