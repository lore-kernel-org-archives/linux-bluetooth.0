Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 7/7] Bluetooth: Remove RSSI monitor on disconnection
Date: Tue,  2 Aug 2011 14:35:09 -0400
Message-Id: <1312310109-27082-8-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
References: <y>
 <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove RSSI monitor from list when remote has been disconnected.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/mgmt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b034290..e2379d15 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2374,6 +2374,8 @@ int mgmt_disconnected(u16 index, bdaddr_t *bdaddr)
 	if (sk)
 		sock_put(sk);
 
+	err = rssi_monitor_remove(index, bdaddr);
+
 	return err;
 }
 
-- 
1.7.4.1

