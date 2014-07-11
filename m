Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Delcare the hci_sec_filter as const
Date: Fri, 11 Jul 2014 05:36:40 +0200
Message-Id: <1405049800-40462-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_sec_filter socket filter details do not change. They are fixed
and with that they can also be delcared as const.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 7805fd1b4a78..0753fa4970c0 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -49,7 +49,7 @@ struct hci_sec_filter {
 	__u32 ocf_mask[HCI_SFLT_MAX_OGF + 1][4];
 };
 
-static struct hci_sec_filter hci_sec_filter = {
+static const struct hci_sec_filter hci_sec_filter = {
 	/* Packet types */
 	0x10,
 	/* Events */
-- 
1.9.3

