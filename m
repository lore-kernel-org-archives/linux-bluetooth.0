Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/3] Bluetooth: Move scope of kernel parameter enable_hs
Date: Mon, 14 Nov 2011 12:42:49 +0200
Message-Id: <1321267370-15727-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1321267370-15727-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321267370-15727-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h   |    2 ++
 include/net/bluetooth/l2cap.h |    1 -
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 275099f..cdcaac3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1357,4 +1357,6 @@ struct hci_inquiry_req {
 };
 #define IREQ_CACHE_FLUSH 0x0001
 
+extern int enable_hs;
+
 #endif /* __HCI_H */
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index aeb8676..71df8cb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -793,7 +793,6 @@ static inline __u8 __ctrl_size(struct l2cap_chan *chan)
 }
 
 extern int disable_ertm;
-extern int enable_hs;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
-- 
1.7.4.1

