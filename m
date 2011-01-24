Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Andr=C3=A9=20Dieb=20Martins?= <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Dieb=20Martins?= <andre.dieb@signove.com>
Subject: [PATCH 2/2] Implement dumping for evnet LE Connection Update Complete.
Date: Mon, 24 Jan 2011 16:32:39 -0300
Message-Id: <1295897559-5540-2-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1295897559-5540-1-git-send-email-andre.dieb@signove.com>
References: <1295897559-5540-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 41a19b4..64c3b0c 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -3532,6 +3532,19 @@ static inline void evt_le_advertising_report_dump(int level, struct frame *frm)
 	}
 }
 
+static inline void evt_le_conn_update_complete_dump(int level, struct frame *frm)
+{
+	evt_le_connection_update_complete *uevt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x handle %d\n", uevt->status, btohs(uevt->handle));
+
+	p_indent(level, frm);
+	printf("interval %.2fms, latency %.2fms, superv. timeout %.2fms\n",
+			btohs(uevt->interval) * 1.25, btohs(uevt->latency) * 1.25,
+			btohs(uevt->supervision_timeout) * 10.0);
+}
+
 static inline void le_meta_ev_dump(int level, struct frame *frm)
 {
 	evt_le_meta_event *mevt = frm->ptr;
@@ -3552,6 +3565,9 @@ static inline void le_meta_ev_dump(int level, struct frame *frm)
 	case EVT_LE_ADVERTISING_REPORT:
 		evt_le_advertising_report_dump(level + 1, frm);
 		break;
+	case EVT_LE_CONN_UPDATE_COMPLETE:
+		evt_le_conn_update_complete_dump(level + 1, frm);
+		break;
 	default:
 		raw_dump(level, frm);
 		break;
-- 
1.7.1

