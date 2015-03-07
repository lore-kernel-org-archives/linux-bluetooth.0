Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH bluetooth-next] Bluetooth: fix sco_exit compile warning
Date: Sat,  7 Mar 2015 20:52:28 +0100
Message-Id: <1425757948-10550-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While compiling the following warning occurs:

WARNING: net/built-in.o(.init.text+0x602c): Section mismatch in
reference from the function bt_init() to the function
.exit.text:sco_exit()
The function __init bt_init() references
a function __exit sco_exit().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
sco_exit() so it may be used outside an exit section.

Since commit 6d785aa345f525e1fdf098b7c590168f0b00f3f1 ("Bluetooth:
Convert mgmt to use HCI chan registration API") the function "sco_exit"
is used inside of function "bt_init". The suggested solution by remove
the __exit annotation solved this issue.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>
---
I don't have any working bluetooth setup here, just compile tested.

 net/bluetooth/sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 54279ac..4322c83 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1231,7 +1231,7 @@ error:
 	return err;
 }
 
-void __exit sco_exit(void)
+void sco_exit(void)
 {
 	bt_procfs_cleanup(&init_net, "sco");
 
-- 
2.3.0

