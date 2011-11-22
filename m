Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/6] Fix access to an invalid memory sector if time stamp is not supported
Date: Tue, 22 Nov 2011 15:49:47 +0100
Message-Id: <1321973388-16300-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1321973388-16300-5-git-send-email-sancane@gmail.com>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
 <1321973388-16300-2-git-send-email-sancane@gmail.com>
 <1321973388-16300-3-git-send-email-sancane@gmail.com>
 <1321973388-16300-4-git-send-email-sancane@gmail.com>
 <1321973388-16300-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 4faf900..e37254c 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -1073,12 +1073,18 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 		m.suptime = FALSE;
 
 	if (flags & TEMP_TYPE) {
-		if (len < 16) {
+		uint8_t index;
+
+		if (m.suptime && len >= 16)
+			index = 15;
+		else if (!m.suptime && len >= 9)
+			index = 9;
+		else {
 			DBG("Can't get temperature type");
 			return;
 		}
 
-		type = temptype2str(pdu[15]);
+		type = temptype2str(pdu[index]);
 	} else if (t->has_type)
 		type = temptype2str(t->type);
 	else {
-- 
1.7.7.4

