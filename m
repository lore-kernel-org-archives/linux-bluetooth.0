Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/6] attrib: Remove all the usages of ATT_MAX_MTU
Date: Wed, 10 Oct 2012 20:34:59 -0300
Message-Id: <1349912103-663-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This "define" was bogus for two reasons: 1. There's no concept
of maximum MTU in the ATT level; 2. It was used as a maximum attribute
value length.
---
 attrib/gatttool.c       |  2 +-
 attrib/interactive.c    |  2 +-
 profiles/alert/server.c | 11 ++++++-----
 src/attrib-server.c     |  3 ++-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 16cce0c..252064d 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -227,7 +227,7 @@ static gboolean characteristics(gpointer user_data)
 static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	uint8_t value[ATT_MAX_MTU];
+	uint8_t value[plen];
 	ssize_t vlen;
 	int i;
 
diff --git a/attrib/interactive.c b/attrib/interactive.c
index b41a7bb..716e675 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -309,7 +309,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	uint8_t value[ATT_MAX_MTU];
+	uint8_t value[plen];
 	ssize_t vlen;
 	int i;
 
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 77de704..761a24b 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -353,24 +353,25 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	struct notify_data *nd = cb->notify_data;
 	enum notify_type type = nd->type;
 	struct alert_adapter *al_adapter = nd->al_adapter;
-	uint8_t pdu[ATT_MAX_MTU];
-	size_t len = 0;
+	size_t len;
+	uint8_t *pdu = g_attrib_get_buffer(attrib, &len);
+
 
 	switch (type) {
 	case NOTIFY_RINGER_SETTING:
 		len = enc_notification(al_adapter->hnd_value[type],
 				&ringer_setting, sizeof(ringer_setting),
-				pdu, sizeof(pdu));
+				pdu, len);
 		break;
 	case NOTIFY_ALERT_STATUS:
 		len = enc_notification(al_adapter->hnd_value[type],
 				&alert_status, sizeof(alert_status),
-				pdu, sizeof(pdu));
+				pdu, len);
 		break;
 	case NOTIFY_NEW_ALERT:
 	case NOTIFY_UNREAD_ALERT:
 		len = enc_notification(al_adapter->hnd_value[type],
-					nd->value, nd->len, pdu, sizeof(pdu));
+					nd->value, nd->len, pdu, len);
 		break;
 	default:
 		DBG("Unknown type, could not send notification");
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 76a32af..ec4ecc3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -907,11 +907,12 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 							gpointer user_data)
 {
 	struct gatt_channel *channel = user_data;
-	uint8_t opdu[channel->mtu], value[ATT_MAX_MTU];
+	uint8_t opdu[channel->mtu];
 	uint16_t length, start, end, mtu, offset;
 	bt_uuid_t uuid;
 	uint8_t status = 0;
 	size_t vlen;
+	uint8_t *value = g_attrib_get_buffer(channel->attrib, &vlen);
 
 	DBG("op 0x%02x", ipdu[0]);
 
-- 
1.7.12.3

