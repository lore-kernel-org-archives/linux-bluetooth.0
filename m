Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH hcidump] LE Connection Complete Event dump
Date: Tue, 30 Aug 2011 14:47:48 -0300
Message-Id: <1314726468-11779-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Print Peer Address and Peer Address Type parameters from LE
Connection Complete Event.
---
 parser/hci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index f41eec2..3c24cde 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -3520,11 +3520,16 @@ static inline void remote_host_features_notify_dump(int level, struct frame *frm
 static inline void evt_le_conn_complete_dump(int level, struct frame *frm)
 {
 	evt_le_connection_complete *evt = frm->ptr;
+	char addr[18];
 
 	p_indent(level, frm);
 	printf("status 0x%2.2x handle %d, role %s\n",
 					evt->status, btohs(evt->handle),
 					evt->role ? "slave" : "master");
+
+	p_indent(level, frm);
+	p_ba2str(&evt->peer_bdaddr, addr);
+	printf("bdaddr %s (%s)\n", addr, bdaddrtype2str(evt->peer_bdaddr_type));
 }
 
 static inline void evt_le_advertising_report_dump(int level, struct frame *frm)
-- 
1.7.5.2

