Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set HCI_MGMT flag only in read_controller_info
Date: Mon, 24 Oct 2011 22:36:26 +0200
Message-Id: <1319488586-2779-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HCI_MGMT flag should only be set when user space requests the full
controller information. This way we avoid potential issues with setting
change events ariving before the actual read_controller_info command
finishes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9ffd7c3..b086c69 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -151,8 +151,6 @@ static int read_index_list(struct sock *sk)
 
 		hci_del_off_timer(d);
 
-		set_bit(HCI_MGMT, &d->flags);
-
 		if (test_bit(HCI_SETUP, &d->flags))
 			continue;
 
-- 
1.7.7

