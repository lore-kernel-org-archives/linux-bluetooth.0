Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 03/10] thermometer: Use GAttrib buffer
Date: Wed, 20 Jun 2012 14:27:45 -0300
Message-Id: <1340213272-2853-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the static local buffer by the GAttrib internal
buffer to temporarily store the output ATT PDU.
---
 thermometer/thermometer.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 4a44177..c2256b6 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -1135,9 +1135,10 @@ static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
 	struct thermometer *t = user_data;
 	const struct characteristic *ch;
-	uint8_t opdu[ATT_MAX_MTU];
+	uint8_t *opdu;
 	uint16_t handle, olen;
 	GSList *l;
+	int plen;
 
 	if (len < 3) {
 		DBG("Bad pdu received");
@@ -1158,7 +1159,8 @@ static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
 		proc_measurement_interval(t, pdu, len);
 
-	olen = enc_confirmation(opdu, sizeof(opdu));
+	opdu = g_attrib_get_buffer(t->attrib, &plen);
+	olen = enc_confirmation(opdu, plen);
 
 	if (olen > 0)
 		g_attrib_send(t->attrib, 0, opdu[0], opdu, olen, NULL, NULL,
-- 
1.7.8.6

