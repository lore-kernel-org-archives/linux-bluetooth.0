Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/11] Bluetooth: Add flag to track managment controlled adapters
Date: Tue,  4 Jan 2011 12:08:48 +0200
Message-Id: <1294135732-26765-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a HCI_MGMT flag to track adapters which are under the
control of the management interface. This is needed to make sure that
new kernels will work with old user space versions. I.e. behaviour which
could break old user space versions (but is needed by the management
interface) should not be exhibited when the HCI_MGMT flag is not set.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/mgmt.c        |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6469d67..a34f638 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -79,6 +79,7 @@ enum {
 
 	HCI_SETUP,
 	HCI_AUTO_OFF,
+	HCI_MGMT,
 };
 
 /* HCI ioctl defines */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 36a3e1c..9d82da9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -140,6 +140,8 @@ static int read_index_list(struct sock *sk)
 
 		hci_del_off_timer(d);
 
+		set_bit(HCI_MGMT, &d->flags);
+
 		if (test_bit(HCI_SETUP, &d->flags))
 			continue;
 
@@ -198,6 +200,8 @@ static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 
 	hci_dev_lock_bh(hdev);
 
+	set_bit(HCI_MGMT, &hdev->flags);
+
 	put_unaligned_le16(hdev->id, &rp->index);
 	rp->type = hdev->dev_type;
 
-- 
1.7.2.3

