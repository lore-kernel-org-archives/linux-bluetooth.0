Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 6/7] Add ATT dump for read req/resp
Date: Wed,  9 Feb 2011 11:01:49 -0300
Message-Id: <1297260110-10515-6-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1297260110-10515-1-git-send-email-andre.dieb@signove.com>
References: <1297260110-10515-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index b172f95..2a9da30 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -331,6 +331,14 @@ static void att_find_info_resp_dump(int level, struct frame *frm)
 	}
 }
 
+static void att_read_req_dump(int level, struct frame *frm)
+{
+	uint16_t handle = btohs(htons(get_u16(frm)));
+
+	p_indent(level, frm);
+	printf("handle 0x%2.2x\n", handle);
+}
+
 static void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -371,6 +379,12 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_FIND_INFO_RESP:
 			att_find_info_resp_dump(level + 1, frm);
 			break;
+		case ATT_OP_READ_REQ:
+			att_read_req_dump(level + 1, frm);
+			break;
+		case ATT_OP_READ_RESP:
+			raw_dump(level + 1, frm);
+			break;
 		case ATT_OP_HANDLE_NOTIFY:
 			att_handle_notify_dump(level + 1, frm);
 			break;
-- 
1.7.1

