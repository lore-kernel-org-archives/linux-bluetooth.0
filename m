Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add missing index added event on user channel failure
Date: Mon, 17 Feb 2014 09:21:18 -0800
Message-Id: <1392657679-32983-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the setup of user channel fails, the index added event is not sent
and will cause issues with user interaction. This problem can be easily
triggered with a LE only controller without a public address. In that
case hci_dev_open() fails and that error case is not sending an event
saying that the controller is available for normal use again.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 7552f9e3089c..68e51a84e72d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -716,6 +716,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		err = hci_dev_open(hdev->id);
 		if (err) {
 			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
+			mgmt_index_added(hdev);
 			hci_dev_put(hdev);
 			goto done;
 		}
-- 
1.8.5.3

