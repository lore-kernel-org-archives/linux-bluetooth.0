Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 7/7] Bluetooth: Remove RSSI monitor on disconnection
Date: Tue,  9 Aug 2011 16:29:42 -0400
Message-Id: <4e4198d3.0750640a.58f6.0ec9@mx.google.com>
In-Reply-To: <1312921782-27523-1-git-send-email-y>
References: <y>
 <1312921782-27523-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

Remove RSSI monitor from list when remote has been disconnected.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/mgmt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9c90090..0174637 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2376,6 +2376,8 @@ int mgmt_disconnected(u16 index, bdaddr_t *bdaddr)
 	if (sk)
 		sock_put(sk);
 
+	err = rssi_monitor_remove(index, bdaddr);
+
 	return err;
 }
 
-- 
1.7.4.1

