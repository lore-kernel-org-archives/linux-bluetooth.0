Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: mgmt: Initialize HCI_MGMT flag for any command
Date: Thu,  1 Mar 2012 12:33:29 -0800
Message-Id: <1330634012-4502-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The read_controller_info is typically the first command that user space
sends when taking a controller into use. This is also the reason why
this command has been used as the trigger to set the HCI_MGMT flag.
However, when not running the user-space daemon and using command line
tools it is possible that read_controller_info is not the first
controller specific command. This patch moves the HCI_MGMT
initialization to a generic place where it will be set for whatever
happens to be the first mgmt command targetting a specific controller.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cc9fb64..cf8c840 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -610,8 +610,11 @@ static void service_cache_off(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
-static void mgmt_init_hdev(struct hci_dev *hdev)
+static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
+	if (!test_and_clear_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags))
+		return;
+
 	if (!test_and_set_bit(HCI_MGMT, &hdev->dev_flags)) {
 		INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 
@@ -632,9 +635,6 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev)
 
 	hci_dev_lock(hdev);
 
-	if (test_and_clear_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags))
-		mgmt_init_hdev(hdev);
-
 	memset(&rp, 0, sizeof(rp));
 
 	bacpy(&rp.bdaddr, &hdev->bdaddr);
@@ -2764,6 +2764,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 						MGMT_STATUS_INVALID_PARAMS);
 			goto done;
 		}
+
+		mgmt_init_hdev(sk, hdev);
 	}
 
 	cp = buf + sizeof(*hdr);
-- 
1.7.9.1

