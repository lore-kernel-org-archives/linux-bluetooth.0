Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 May 2014 17:53:35 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix L2CAP LE debugfs entries permissions
Message-ID: <20140514155335.GR4157@zurbaran>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


0466 was probably meant to be 0644, there's no reason why everyone
except root could write there.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a1e5bb7..dc4d301 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7519,9 +7519,9 @@ int __init l2cap_init(void)
 	l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
 					    NULL, &l2cap_debugfs_fops);
 
-	debugfs_create_u16("l2cap_le_max_credits", 0466, bt_debugfs,
+	debugfs_create_u16("l2cap_le_max_credits", 0644, bt_debugfs,
 			   &le_max_credits);
-	debugfs_create_u16("l2cap_le_default_mps", 0466, bt_debugfs,
+	debugfs_create_u16("l2cap_le_default_mps", 0644, bt_debugfs,
 			   &le_default_mps);
 
 	bt_6lowpan_init();
-- 
2.0.0.rc0

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
