Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: mgmt: Add local name information to read_info reply
Date: Tue, 15 Mar 2011 20:54:52 +0200
Message-Id: <1300215293-30294-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1300215293-30294-1-git-send-email-johan.hedberg@gmail.com>
References: <1300215293-30294-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds the name of the adapter to the reply of the read_info
management command.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/mgmt.h |    1 +
 net/bluetooth/mgmt.c         |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5fabfa8..4deeea1 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -55,6 +55,7 @@ struct mgmt_rp_read_info {
 	__u16 manufacturer;
 	__u8 hci_ver;
 	__u16 hci_rev;
+	__u8 name[249];
 } __packed;
 
 struct mgmt_mode {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4476d8e..67529c8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -183,6 +183,8 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	set_bit(HCI_MGMT, &hdev->flags);
 
+	memset(&rp, 0, sizeof(rp));
+
 	rp.type = hdev->dev_type;
 
 	rp.powered = test_bit(HCI_UP, &hdev->flags);
@@ -204,6 +206,8 @@ static int read_controller_info(struct sock *sk, u16 index)
 	rp.hci_ver = hdev->hci_ver;
 	put_unaligned_le16(hdev->hci_rev, &rp.hci_rev);
 
+	memcpy(rp.name, hdev->dev_name, sizeof(hdev->dev_name));
+
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
-- 
1.7.4.1

