Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use GFP_KERNEL in hci_chan_create()
Date: Mon, 30 Jan 2012 09:22:10 -0300
Message-Id: <1327926130-26149-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1327926130-26149-1-git-send-email-andre.guedes@openbossa.org>
References: <1327926130-26149-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is called in process context only, so it should use
GFP_KERNEL to allocate memory.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9ec7b8e..7b38a0b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -945,7 +945,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 
 	BT_DBG("%s conn %p", hdev->name, conn);
 
-	chan = kzalloc(sizeof(struct hci_chan), GFP_ATOMIC);
+	chan = kzalloc(sizeof(struct hci_chan), GFP_KERNEL);
 	if (!chan)
 		return NULL;
 
-- 
1.7.8.4

