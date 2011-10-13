Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 7/9] Read temperature type characteristic
Date: Thu, 13 Oct 2011 17:29:20 +0200
Message-Id: <1318519762-17475-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1318519762-17475-7-git-send-email-sancane@gmail.com>
References: <1318519762-17475-1-git-send-email-sancane@gmail.com>
 <1318519762-17475-2-git-send-email-sancane@gmail.com>
 <1318519762-17475-3-git-send-email-sancane@gmail.com>
 <1318519762-17475-4-git-send-email-sancane@gmail.com>
 <1318519762-17475-5-git-send-email-sancane@gmail.com>
 <1318519762-17475-6-git-send-email-sancane@gmail.com>
 <1318519762-17475-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 41b9d72..163a804 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -48,6 +48,13 @@ struct thermometer {
 	guint			attioid;	/* Att watcher id */
 	guint			attindid;	/* Att incications id */
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
@@ -114,7 +121,29 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
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
+	t->has_type = TRUE;
+	t->type = value[0];
 }
 
 static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
-- 
1.7.6.1

