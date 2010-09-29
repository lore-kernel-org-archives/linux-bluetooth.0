Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 1/2] Add master/slave parsing for le_conn_complete event
Date: Wed, 29 Sep 2010 16:56:20 +0300
Message-Id: <1285768581-19654-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 250ba58..7f23605 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -3239,7 +3239,8 @@ static inline void evt_le_conn_complete_dump(int level, struct frame *frm)
 	evt_le_connection_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle %d\n", evt->status, btohs(evt->handle));
+	printf("status 0x%2.2x handle %d, role %s\n",
+		evt->status, btohs(evt->handle), evt->role?"slave":"master");
 }
 
 static inline void le_meta_ev_dump(int level, struct frame *frm)
-- 
1.7.1

