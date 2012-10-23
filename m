Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: mgmt: Use __constant when dealing with constants
Date: Tue, 23 Oct 2012 19:02:19 +0530
Message-id: <1350999140-7481-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

__constant_cpu_to_le*() is the right go here.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/mgmt.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b127b88..e3bb2a7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -222,7 +222,7 @@ static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 
-	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
+	hdr->opcode = __constant_cpu_to_le16(MGMT_EV_CMD_STATUS);
 	hdr->index = cpu_to_le16(index);
 	hdr->len = cpu_to_le16(sizeof(*ev));
 
@@ -253,7 +253,7 @@ static int cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 
-	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->opcode = __constant_cpu_to_le16(MGMT_EV_CMD_COMPLETE);
 	hdr->index = cpu_to_le16(index);
 	hdr->len = cpu_to_le16(sizeof(*ev) + rp_len);
 
@@ -832,7 +832,7 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 data_len,
 	if (hdev)
 		hdr->index = cpu_to_le16(hdev->id);
 	else
-		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
+		hdr->index = __constant_cpu_to_le16(MGMT_INDEX_NONE);
 	hdr->len = cpu_to_le16(data_len);
 
 	if (data)
@@ -3570,9 +3570,11 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 	ev->rssi = rssi;
 	if (cfm_name)
-		ev->flags |= cpu_to_le32(MGMT_DEV_FOUND_CONFIRM_NAME);
+		ev->flags |=
+			__constant_cpu_to_le32(MGMT_DEV_FOUND_CONFIRM_NAME);
 	if (!ssp)
-		ev->flags |= cpu_to_le32(MGMT_DEV_FOUND_LEGACY_PAIRING);
+		ev->flags |=
+			__constant_cpu_to_le32(MGMT_DEV_FOUND_LEGACY_PAIRING);
 
 	if (eir_len > 0)
 		memcpy(ev->eir, eir, eir_len);
-- 
1.7.9.5

