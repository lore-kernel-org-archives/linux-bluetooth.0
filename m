Return-Path: <cyrus@holtmann.org>
From: <ramm@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ram Malovany <ramm@ti.com>
Subject: [PATCH 3/3] Bluetooth: Set name_state to unknown when entry name is empty
Date: Wed, 18 Jul 2012 15:06:06 +0300
Message-ID: <1342613166-23651-3-git-send-email-ramm@ti.com>
In-Reply-To: <1342613166-23651-1-git-send-email-ramm@ti.com>
References: <1342613166-23651-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ram Malovany <ramm@ti.com>

When the name of the given entry is empty , the state needs to be
updated accordingly.

Signed-off-by: Ram Malovany <ramm@ti.com>
---
 net/bluetooth/hci_event.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3224dcc..f799b46 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1408,6 +1408,8 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 		e->name_state = NAME_KNOWN;
 		mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00,
 				 e->data.rssi, name, name_len);
+	} else {
+		e->name_state = NAME_NOT_KNOWN;
 	}
 
 	if (hci_resolve_next_name(hdev))
-- 
1.7.4.1

