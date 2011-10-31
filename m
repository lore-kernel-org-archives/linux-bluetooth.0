Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Remove unnecessary casting in thermometer plugin
Date: Mon, 31 Oct 2011 14:16:05 +0100
Message-Id: <1320066965-27742-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 0d85102..8f0a5ea 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -200,7 +200,7 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 {
 	struct characteristic *ch = user_data;
 	uint8_t value[ATT_MAX_MTU];
-	uint16_t *p, interval;
+	uint16_t interval;
 	int vlen;
 
 	if (status != 0) {
@@ -219,9 +219,7 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	p = (uint16_t *) value;
-	interval = btohs(bt_get_unaligned(p));
-
+	interval = att_get_u16(&value[0]);
 	change_property(ch->t, "Interval", &interval);
 }
 
-- 
1.7.7.1

