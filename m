Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/6] thermometer.c: Process measurement interval indications
Date: Fri,  9 Dec 2011 19:19:01 +0100
Message-Id: <1323454744-14589-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1323454744-14589-3-git-send-email-sancane@gmail.com>
References: <1323454744-14589-1-git-send-email-sancane@gmail.com>
 <1323454744-14589-2-git-send-email-sancane@gmail.com>
 <1323454744-14589-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch emits PropertyChange signal whenever a new value is
set in the measurement interval characteristic.
---
 thermometer/thermometer.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index d175800..da793a6 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -1083,7 +1083,16 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 static void proc_measurement_interval(struct thermometer *t, const uint8_t *pdu,
 								uint16_t len)
 {
-	DBG("TODO: Process measurements interval indication");
+	guint16 interval;
+
+	if (len < 5) {
+		DBG("Measurement interval value is not provided");
+		return;
+	}
+
+	interval = att_get_u16(&pdu[3]);
+
+	change_property(t, "Interval", &interval);
 }
 
 static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
-- 
1.7.8

