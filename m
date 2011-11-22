Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/6] Process measurements interval indication
Date: Tue, 22 Nov 2011 15:49:45 +0100
Message-Id: <1321973388-16300-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1321973388-16300-3-git-send-email-sancane@gmail.com>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
 <1321973388-16300-2-git-send-email-sancane@gmail.com>
 <1321973388-16300-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 1746e60..9ad7e59 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -1084,7 +1084,16 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
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
1.7.7.4

