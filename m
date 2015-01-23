Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] Bluetooth: Do not allow LE connection if LE is not enabled
Date: Fri, 23 Jan 2015 12:53:31 +0100
Message-Id: <1422014012-6840-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Kernel gives possibility to enable/disable LE host support.
There is flag HCI_LE_ENABLED which is set when this support is enabled
and some parts of the code checks this flag e.g. SMP
However it is still possible to make LE connection if LE Host support is
disabled, what might be confused for remote device.
This patch makes sure that kernel will not send HCI LE Create Connection
if LE HOST support is not enabled.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/hci_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c9b8fa5..3a89d8f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -733,6 +733,10 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	struct hci_request req;
 	int err;
 
+	/* Let's make sure that le is enabled */
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/* Some devices send ATT messages as soon as the physical link is
 	 * established. To be able to handle these ATT messages, the user-
 	 * space first establishes the connection and then starts the pairing
-- 
1.8.4

