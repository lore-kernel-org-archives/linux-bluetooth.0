Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/6] thermometer.c: Fix bad read operation when time stamp is not provided.
Date: Fri,  9 Dec 2011 19:19:03 +0100
Message-Id: <1323454744-14589-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1323454744-14589-5-git-send-email-sancane@gmail.com>
References: <1323454744-14589-1-git-send-email-sancane@gmail.com>
 <1323454744-14589-2-git-send-email-sancane@gmail.com>
 <1323454744-14589-3-git-send-email-sancane@gmail.com>
 <1323454744-14589-4-git-send-email-sancane@gmail.com>
 <1323454744-14589-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Time stamp value is an optional field provided in the measure, so next
value in the array will start in a different index depending if the
time stamp was provided or not. This patch check this case and update
the index to a proper value in the byte array before reading the
temperature type value.
---
 thermometer/thermometer.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index ad1569b..b112f04 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -1072,12 +1072,18 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
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
1.7.8

