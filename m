Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: Fix using an absolute timeout on hci_conn_put()
Date: Wed,  4 Jan 2012 11:57:17 -0300
Message-Id: <1325689037-19540-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

queue_delayed_work() expects a relative time for when that work
should be scheduled.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ea9231f..92b8fea 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -561,7 +561,7 @@ static inline void hci_conn_put(struct hci_conn *conn)
 		}
 		cancel_delayed_work_sync(&conn->disc_work);
 		queue_delayed_work(conn->hdev->workqueue,
-					&conn->disc_work, jiffies + timeo);
+					&conn->disc_work, timeo);
 	}
 }
 
-- 
1.7.8.1

