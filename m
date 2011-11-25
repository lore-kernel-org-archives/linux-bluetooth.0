Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Fix bad epoch time stamp generation
Date: Fri, 25 Nov 2011 16:37:28 +0100
Message-Id: <1322235448-9638-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The number of months is in the range 0 to 11, we have to decrease
month number by 1 before getting the epoch.
---
 thermometer/thermometer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index db33cdb..e3872c9 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -954,7 +954,7 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 		}
 
 		ts.tm_year = att_get_u16(&pdu[8]) - 1900;
-		ts.tm_mon = pdu[10];
+		ts.tm_mon = pdu[10] - 1;
 		ts.tm_mday = pdu[11];
 		ts.tm_hour = pdu[12];
 		ts.tm_min = pdu[13];
-- 
1.7.7.4

