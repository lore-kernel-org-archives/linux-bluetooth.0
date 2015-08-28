Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH] Bluetooth: bring device down when closing HCI_CHANNEL_USER socket
Date: Fri, 28 Aug 2015 12:54:30 +0200
Message-Id: <1440759270-23099-2-git-send-email-simon.fels@canonical.com>
In-Reply-To: <1440759270-23099-1-git-send-email-simon.fels@canonical.com>
References: <1440759270-23099-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a HCI_CHANNEL_USER socket is open and should be closed we first try to close the
device which will fail as hci_dev_close checks for HCI_CHANNEL_USER being set and if it is
it just fails to close the device. Clearing the HCI_CHANNEL_USER flag first before trying
to close the device fixes this.

Signed-off-by: Simon Fels <simon.fels@canonical.com>
---
 backports/net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backports/net/bluetooth/hci_sock.c b/backports/net/bluetooth/hci_sock.c
index 9a2732f..c84c13e 100644
--- a/backports/net/bluetooth/hci_sock.c
+++ b/backports/net/bluetooth/hci_sock.c
@@ -503,8 +503,8 @@ static int hci_sock_release(struct socket *sock)
 
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
-			hci_dev_close(hdev->id);
 			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
+			hci_dev_close(hdev->id);
 			mgmt_index_added(hdev);
 		}
 
-- 
2.1.4

