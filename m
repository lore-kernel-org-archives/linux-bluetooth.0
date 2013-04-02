Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ v2 12/13] gatttool: Show info message when no primary service is found
Date: Tue,  2 Apr 2013 19:31:29 -0400
Message-Id: <1364945490-17059-13-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 attrib/interactive.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 9b16ddf..1d31889 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -190,6 +190,11 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 		return;
 	}
 
+	if (services == NULL) {
+		rl_printf("No primary service found\n");
+		return;
+	}
+
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
 		rl_printf("attr handle: 0x%04x, end grp handle: 0x%04x uuid: %s\n",
@@ -208,6 +213,11 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 		return;
 	}
 
+	if (ranges == NULL) {
+		rl_printf("No service UUID found\n");
+		return;
+	}
+
 	for (l = ranges; l; l = l->next) {
 		struct att_range *range = l->data;
 		rl_printf("Starting handle: 0x%04x Ending handle: 0x%04x\n",
-- 
1.7.9.5

