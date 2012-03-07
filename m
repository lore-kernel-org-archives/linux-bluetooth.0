Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix using uninitialized variable
Date: Wed,  7 Mar 2012 20:20:14 +0200
Message-Id: <1331144414-28513-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

+ src/net/bluetooth/rfcomm/tty.c: warning: 'p' is used uninitialized in this
       function:  => 218
+ src/net/bluetooth/rfcomm/tty.c: warning: 'p' may be used uninitialized in
       this function:  => 218

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/tty.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index a2d4f51..c179734 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -196,7 +196,7 @@ static DEVICE_ATTR(channel, S_IRUGO, show_channel, NULL);
 static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 {
 	struct rfcomm_dev *dev, *entry;
-	struct list_head *head = &rfcomm_dev_list, *p;
+	struct list_head *head = &rfcomm_dev_list;
 	int err = 0;
 
 	BT_DBG("id %d channel %d", req->dev_id, req->channel);
@@ -215,7 +215,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 				break;
 
 			dev->id++;
-			head = p;
+			head = &entry->list;
 		}
 	} else {
 		dev->id = req->dev_id;
@@ -229,7 +229,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 			if (entry->id > dev->id - 1)
 				break;
 
-			head = p;
+			head = &entry->list;
 		}
 	}
 
-- 
1.7.7.6

