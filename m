Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 02/34] Bluetooth: trivial: clean up of l2cap_chan_connect
Date: Thu, 19 Jan 2012 11:19:51 +0200
Message-Id: <1326964823-26747-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 48b5c0d..5ace149 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1128,10 +1128,9 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
 	__u8 auth_type;
-	int err;
+	int err = 0;
 
-	BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst),
-							chan->psm);
+	BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst), chan->psm);
 
 	hdev = hci_get_route(dst, src);
 	if (!hdev)
@@ -1232,8 +1231,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 			l2cap_do_start(chan);
 	}
 
-	err = 0;
-
 done:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
-- 
1.7.4.1

