Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 2/2] Bluetooth: Reorder HCI user channel socket release
Date: Thu, 21 May 2015 16:46:41 +0200
Message-Id: <1432219601-3663-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1432219601-3663-1-git-send-email-loic.poulain@intel.com>
References: <1432219601-3663-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The hci close method needs to know if we are in user channel context.
Only add the index to mgmt once close is performed.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 net/bluetooth/hci_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 56f9edb..e1beb4e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -503,9 +503,9 @@ static int hci_sock_release(struct socket *sock)
 
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
-			mgmt_index_added(hdev);
-			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
 			hci_dev_close(hdev->id);
+			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
+			mgmt_index_added(hdev);
 		}
 
 		atomic_dec(&hdev->promisc);
-- 
1.9.1
