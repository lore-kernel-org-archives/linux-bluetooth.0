Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
Subject: [PATCHv2 5/5] Implement ATT handle indication
Date: Tue, 22 Feb 2011 18:01:31 -0300
Message-Id: <1298408491-11154-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Elvis Pfützenreuter <epx@signove.com>

---
 src/attrib-server.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 8fcfa89..dc4d864 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -61,6 +61,8 @@ struct gatt_channel {
 	guint mtu;
 	guint id;
 	gboolean encrypted;
+	guint outstanding_indications;
+	time_t oldest_indication;
 };
 
 struct group_elem {
@@ -888,6 +890,10 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		length = find_by_type(start, end, &uuid, value, vlen,
 							opdu, channel->mtu);
 		break;
+	case ATT_OP_HANDLE_CNF:
+		if (channel->outstanding_indications)
+			channel->outstanding_indications -= 1;
+		return;
 	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_EXEC_WRITE_REQ:
@@ -967,8 +973,11 @@ static void confirm_event(GIOChannel *io, void *user_data)
 static void attrib_notify_clients(struct attribute *attr)
 {
 	guint handle = attr->handle;
+	time_t now;
 	GSList *l;
 
+	time(&now);
+
 	for (l = clients; l; l = l->next) {
 		struct gatt_channel *channel = l->data;
 
@@ -985,6 +994,37 @@ static void attrib_notify_clients(struct attribute *attr)
 			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
 							NULL, NULL, NULL);
 		}
+
+		/* The outstanding_indications variable counts how many
+		 * unconfirmed indications have been sent. The oldest_indication
+		 * variable gives a small time frame to accomodate
+		 * almost-concomitant indications, sending both without forcing
+		 * a serialization.
+		 *
+		 * Indications are withheld once oldest_indication is older than
+		 * at least 1 second and there are pending confirmations. */
+
+		if (channel->outstanding_indications &&
+				(now - channel->oldest_indication) > 1)
+			continue;
+
+		/* Indication */
+		if (g_slist_find_custom(channel->indicate,
+				GUINT_TO_POINTER(handle), handle_cmp) != NULL) {
+			uint8_t pdu[ATT_MAX_MTU];
+			uint16_t len;
+
+			len = enc_indication(attr, pdu, channel->mtu);
+			if (len == 0)
+				continue;
+
+			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
+							NULL, NULL, NULL);
+
+			channel->outstanding_indications += 1;
+			if (channel->outstanding_indications == 1)
+				channel->oldest_indication = now;
+		}
 	}
 }
 
-- 
1.7.0.4

