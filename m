Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 3/5] Bluetooth: hci_core: Remove header declared but not define
Date: Thu, 12 Apr 2012 20:33:19 +0530
Message-id: <1334243001-17016-29-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 include/net/bluetooth/hci_core.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ed9eaba..3d10671 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -697,8 +697,6 @@ struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_adv_entry(struct hci_dev *hdev,
 					struct hci_ev_le_advertising_info *ev);
 
-void hci_del_off_timer(struct hci_dev *hdev);
-
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct sk_buff *skb);
-- 
1.7.4.1

