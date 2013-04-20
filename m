Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_get_cmd_complete() can be static
Date: Sat, 20 Apr 2013 16:24:31 +0300
Message-Id: <1366464271-3067-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Fengguang Wu <fengguang.wu@intel.com>

There are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next master
head:   a0b644b0385fa58ca578f6dce4473e8a8e6f6c38
commit: 75e84b7c522c6e07964cd1f5bf28535768a1e9fa Bluetooth: Add __hci_cmd_sync() helper function
date:   13 days ago

>> net/bluetooth/hci_core.c:82:16: sparse: symbol 'hci_get_cmd_complete' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 49550ff..cdd730d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -79,7 +79,8 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 	}
 }
 
-struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 event)
+static struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
+					    u8 event)
 {
 	struct hci_ev_cmd_complete *ev;
 	struct hci_event_hdr *hdr;
-- 
1.7.10.4

