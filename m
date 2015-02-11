Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/3] Bluetooth: Do not allow LE connection if LE is not enabled
Date: Wed, 11 Feb 2015 12:31:40 +0100
Message-Id: <1423654302-32348-1-git-send-email-lukasz.rymanowski@tieto.com>
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
 net/bluetooth/hci_conn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c9b8fa5..409c05e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -733,6 +733,14 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	struct hci_request req;
 	int err;
 
+	/* Let's make sure that le is enabled.*/
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+		if (lmp_le_capable(hdev))
+			return ERR_PTR(-ECONNREFUSED);
+
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	/* Some devices send ATT messages as soon as the physical link is
 	 * established. To be able to handle these ATT messages, the user-
 	 * space first establishes the connection and then starts the pairing
-- 
1.8.4

