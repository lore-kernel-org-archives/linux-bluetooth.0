Return-Path: <cyrus@holtmann.org>
From: Rami Rosen <ramirose@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	Rami Rosen <ramirose@gmail.com>
Subject: [PATCH BlueZ] bluetooth: remove unused member of hci_dev.
Date: Mon,  1 Oct 2012 15:15:15 +0200
Message-Id: <1349097315-19653-1-git-send-email-ramirose@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes core_data member from hci_dev struct as it is unused.
Signed-off-by: Rami Rosen <ramirose@gmail.com>
---
 include/net/bluetooth/hci_core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ea1f934..90ae4f0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -262,8 +262,6 @@ struct hci_dev {
 
 	struct sk_buff_head	driver_init;
 
-	void			*core_data;
-
 	atomic_t		promisc;
 
 	struct dentry		*debugfs;
-- 
1.7.11.4
