Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Implement ATT handle indications
Date: Fri, 25 Feb 2011 09:37:37 -0300
Message-Id: <1298637457-19588-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Treatment of near-concomitant indications, the first possibly blocking
the second, will be implemented in another patch.
---
 src/attrib-server.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5f645bb..2114700 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -58,6 +58,7 @@ struct gatt_channel {
 	guint mtu;
 	guint id;
 	gboolean encrypted;
+	guint outstanding_indications;
 };
 
 struct group_elem {
@@ -872,6 +873,10 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
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
@@ -969,6 +974,25 @@ static void attrib_notify_clients(struct attribute *attr)
 			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
 							NULL, NULL, NULL);
 		}
+
+		if (channel->outstanding_indications)
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
+				return;
+
+			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
+							NULL, NULL, NULL);
+
+			channel->outstanding_indications += 1;
+		}
 	}
 }
 
-- 
1.7.1

