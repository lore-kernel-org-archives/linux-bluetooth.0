Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] thermometer: Fix handling of missing Temperature Type
Date: Tue, 14 Feb 2012 13:52:24 -0400
Message-Id: <1329241945-32414-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to HTS 1.0, it is not mandatory to have Temperature Type
information (the Characteristic and the indication field are both
unconditionally optional).

Given there is no default value specified on the spec, we assume the
thermometer is for general use, and set the type to "Body".
---
 thermometer/thermometer.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 9bf9881..7906d84 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -1086,13 +1086,8 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 		type = temptype2str(pdu[index]);
 	} else if (t->has_type)
 		type = temptype2str(t->type);
-	else {
-		DBG("Can't get temperature type");
-		return;
-	}
-
-	if (type == NULL)
-		return;
+	else
+		type = "Body";
 
 	m.type = g_strdup(type);
 	m.value = final ? "Final" : "Intermediate";
-- 
1.7.5.4

