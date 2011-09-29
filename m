Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 7/9] Read temperature type characteristic
Date: Thu, 29 Sep 2011 15:46:26 +0200
Message-Id: <1317303988-26310-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1317303988-26310-7-git-send-email-sancane@gmail.com>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
 <1317303988-26310-4-git-send-email-sancane@gmail.com>
 <1317303988-26310-5-git-send-email-sancane@gmail.com>
 <1317303988-26310-6-git-send-email-sancane@gmail.com>
 <1317303988-26310-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index f0b977e..b10d09e 100644
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
@@ -113,7 +120,29 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	/* TODO */
+	struct characteristic *ch = user_data;
+	struct thermometer *t = ch->t;
+	uint8_t value[ATT_MAX_MTU];
+	int vlen;
+
+	if (status != 0) {
+		DBG("Temperature Type value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, len, value, &vlen)) {
+		DBG("Protocol error.");
+		return;
+	}
+
+	if (vlen != 1) {
+		DBG("Invalid length for Temperature type");
+		return;
+	}
+
+	t->has_interval = TRUE;
+	t->type = (uint8_t) value[0];
 }
 
 static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
-- 
1.7.6.1

