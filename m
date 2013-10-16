Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove enable_hs declaration
Date: Wed, 16 Oct 2013 02:09:01 -0700
Message-Id: <1381914541-48086-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This seems to be a left-over. The module parameter enable_hs has
been removed, but its extern declaration is still present. It is
not needed anymore, so just remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c8bc7bf..77a971a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1787,6 +1787,4 @@ struct hci_inquiry_req {
 };
 #define IREQ_CACHE_FLUSH 0x0001
 
-extern bool enable_hs;
-
 #endif /* __HCI_H */
-- 
1.8.3.1

