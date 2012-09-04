Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 09/15] Bluetooth: AMP: Add hs_hchan and hs_hcon to l2cap_chan
Date: Tue,  4 Sep 2012 16:44:28 +0300
Message-Id: <1346766274-21612-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After logical link is established initialize high speed hci_conn and
hci_chan vars which will be used for sending data over AMP channel.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/hci_event.c     |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 064be7f..227307b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -433,6 +433,8 @@ struct l2cap_chan {
 	struct sock *sk;
 
 	struct l2cap_conn	*conn;
+	struct hci_conn		*hs_hcon;
+	struct hci_chan		*hs_hchan;
 	struct kref	kref;
 
 	__u8		state;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a4b2f1d..07209e5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3519,6 +3519,8 @@ static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (mgr) {
 		struct l2cap_chan *bredr_chan = mgr->bredr_chan;
 
+		bredr_chan->hs_hcon = hcon;
+		bredr_chan->hs_hchan = hchan;
 		l2cap_finish_efs_config(bredr_chan);
 	}
 }
-- 
1.7.9.5

