Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] emulator/btdev: Fix not disabling le advertising on connection
Date: Mon, 25 Aug 2014 13:08:52 +0200
Message-Id: <1408964932-9690-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Le Advertising should be disabled after the le connection is
established (Core Spec. 4.1 - Part E, Sec. 7.8.9). Not doing so
results in errors while switching advertisement multiple times during
different connection states.
---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index b09f8cb..86fd3d9 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1023,6 +1023,7 @@ static void le_conn_complete(struct btdev *btdev,
 
 		btdev->conn = remote;
 		remote->conn = btdev;
+		remote->le_adv_enable = 0;
 
 		cc->status = status;
 		cc->peer_addr_type = btdev->le_scan_own_addr_type;
-- 
1.9.1

