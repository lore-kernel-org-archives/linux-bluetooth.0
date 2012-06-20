Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 04/10] gatttool: Use GAttrib buffer
Date: Wed, 20 Jun 2012 14:27:46 -0300
Message-Id: <1340213272-2853-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the static local buffer by the GAttrib internal
buffer to store temporarly the output ATT PDU.
---
 attrib/gatttool.c    |    6 ++++--
 attrib/interactive.c |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index c70b1d6..1f23522 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -75,8 +75,9 @@ struct characteristic_data {
 static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
 	GAttrib *attrib = user_data;
-	uint8_t opdu[ATT_MAX_MTU];
+	uint8_t *opdu;
 	uint16_t handle, i, olen = 0;
+	int plen;
 
 	handle = att_get_u16(&pdu[1]);
 
@@ -100,7 +101,8 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	if (pdu[0] == ATT_OP_HANDLE_NOTIFY)
 		return;
 
-	olen = enc_confirmation(opdu, sizeof(opdu));
+	opdu = g_attrib_get_buffer(attrib, &plen);
+	olen = enc_confirmation(opdu, plen);
 
 	if (olen > 0)
 		g_attrib_send(attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 1cdbfef..3657798 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -101,8 +101,9 @@ static void set_state(enum state st)
 
 static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
-	uint8_t opdu[ATT_MAX_MTU];
+	uint8_t *opdu;
 	uint16_t handle, i, olen;
+	int plen;
 
 	handle = att_get_u16(&pdu[1]);
 
@@ -128,7 +129,8 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	if (pdu[0] == ATT_OP_HANDLE_NOTIFY)
 		return;
 
-	olen = enc_confirmation(opdu, sizeof(opdu));
+	opdu = g_attrib_get_buffer(attrib, &plen);
+	olen = enc_confirmation(opdu, plen);
 
 	if (olen > 0)
 		g_attrib_send(attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
-- 
1.7.8.6

