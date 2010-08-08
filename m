Return-Path: <cyrus@holtmann.org>
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] net: bluetooth: Fix build error from rfcomm/tty.c
Date: Sun,  8 Aug 2010 14:37:58 +0530
Message-Id: <1281258478-17335-1-git-send-email-santosh.shilimkar@ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The build error is as follows:
`rfcomm_cleanup_ttys' referenced in section `.init.text' of net/built-in.o:
defined in discarded section `.exit.text' of net/built-in.o
make: *** [.tmp_vmlinux1] Error 1

This patch fixes by removing __exit from fucntion 'rfcomm_cleanup_ttys'
to avoid section mismatch

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/rfcomm/tty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 026205c..befc3a5 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1183,7 +1183,7 @@ int __init rfcomm_init_ttys(void)
 	return 0;
 }
 
-void __exit rfcomm_cleanup_ttys(void)
+void rfcomm_cleanup_ttys(void)
 {
 	tty_unregister_driver(rfcomm_tty_driver);
 	put_tty_driver(rfcomm_tty_driver);
-- 
1.6.0.4
