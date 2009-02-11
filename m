Return-Path: <cyrus@holtmann.org>
Message-Id: <200902112128.n1BLSBnP000351@imap1.linux-foundation.org>
Subject: [patch 1/2] bluetooth/bt3c: eliminate a sparse warning
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org, andre@bitwigglers.org,
        hidave.darkstar@gmail.com
From: akpm@linux-foundation.org
Date: Wed, 11 Feb 2009 13:28:11 -0800
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Haupt <andre@bitwigglers.org>

This eliminates a sparse warning that symbol 'stat' shadows an earlier one.

Signed-off-by: Andre Haupt <andre@bitwigglers.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Dave Young <hidave.darkstar@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/bluetooth/bt3c_cs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/bluetooth/bt3c_cs.c~bluetooth-bt3c-eliminate-a-sparse-warning drivers/bluetooth/bt3c_cs.c
--- a/drivers/bluetooth/bt3c_cs.c~bluetooth-bt3c-eliminate-a-sparse-warning
+++ a/drivers/bluetooth/bt3c_cs.c
@@ -359,9 +359,9 @@ static irqreturn_t bt3c_interrupt(int ir
 			BT_ERR("Very strange (stat=0x%04x)", stat);
 		} else if ((stat & 0xff) != 0xff) {
 			if (stat & 0x0020) {
-				int stat = bt3c_read(iobase, 0x7002) & 0x10;
+				int status = bt3c_read(iobase, 0x7002) & 0x10;
 				BT_INFO("%s: Antenna %s", info->hdev->name,
-							stat ? "out" : "in");
+							status ? "out" : "in");
 			}
 			if (stat & 0x0001)
 				bt3c_receive(info);
_
