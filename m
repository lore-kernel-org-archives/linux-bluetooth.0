Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH v3] Implement ATT handle indications
Date: Thu, 10 Mar 2011 09:41:13 -0300
Message-Id: <1299760873-15742-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index b980b28..ec221d1 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -875,6 +875,8 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		length = find_by_type(start, end, &uuid, value, vlen,
 							opdu, channel->mtu);
 		break;
+	case ATT_OP_HANDLE_CNF:
+		return;
 	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_EXEC_WRITE_REQ:
@@ -972,6 +974,26 @@ static void attrib_notify_clients(struct attribute *attr)
 			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
 							NULL, NULL, NULL);
 		}
+
+		/* Indication */
+		if (g_slist_find_custom(channel->indicate,
+					GUINT_TO_POINTER(handle), handle_cmp)) {
+			uint8_t pdu[ATT_MAX_MTU];
+			uint16_t len;
+
+			len = enc_indication(attr, pdu, channel->mtu);
+			if (len == 0)
+				return;
+
+			/*
+			g_attrib_send() implicitly guarantees that this
+			indication is sent only when the previous one has
+			been confirmed, so we don't need to keep a queue
+			*/
+
+			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
+							NULL, NULL, NULL);
+		}
 	}
 }
 
-- 
1.7.1

