Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Fix permission of enable_le param
Date: Tue, 11 Oct 2011 15:58:53 -0300
Message-Id: <1318359533-7640-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

With 0444 it is impossible to change the param, changing it to 0644.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d7d96b6..0e57634 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3104,5 +3104,5 @@ void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 	kfree_skb(skb);
 }
 
-module_param(enable_le, bool, 0444);
+module_param(enable_le, bool, 0644);
 MODULE_PARM_DESC(enable_le, "Enable LE support");
-- 
1.7.6.4

