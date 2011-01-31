Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 1/2] Implement dump for event LE Read Remote Used Features Complete.
Date: Mon, 31 Jan 2011 16:09:31 -0300
Message-Id: <1296500972-14105-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: André Dieb Martins <andre.dieb@signove.com>

---
 parser/hci.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 6f9e2a3..8b45376 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -3546,6 +3546,26 @@ static inline void evt_le_conn_update_complete_dump(int level,
 			btohs(uevt->supervision_timeout) * 10.0);
 }
 
+static inline void evt_le_read_remote_used_features_complete_dump(int level, struct frame *frm)
+{
+	int i;
+	evt_le_read_remote_used_features_complete *revt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x handle %d\n", revt->status, btohs(revt->handle));
+
+	if (revt->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(revt->status));
+	} else {
+		p_indent(level, frm);
+		printf("Features:");
+		for (i = 0; i < 8; i++)
+			printf(" 0x%2.2x", revt->features[i]);
+		printf("\n");
+	}
+}
+
 static inline void le_meta_ev_dump(int level, struct frame *frm)
 {
 	evt_le_meta_event *mevt = frm->ptr;
@@ -3569,6 +3589,9 @@ static inline void le_meta_ev_dump(int level, struct frame *frm)
 	case EVT_LE_CONN_UPDATE_COMPLETE:
 		evt_le_conn_update_complete_dump(level + 1, frm);
 		break;
+	case EVT_LE_READ_REMOTE_USED_FEATURES_COMPLETE:
+		evt_le_read_remote_used_features_complete_dump(level + 1, frm);
+		break;
 	default:
 		raw_dump(level, frm);
 		break;
-- 
1.7.1

