Return-Path: <bhumirks@gmail.com>
From: Bhumika Goyal <bhumirks@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] drivers:bluetooth:ath3k:fixed a blank line after declaration issue
Date: Tue, 12 Jan 2016 22:10:15 +0530
Message-Id: <1452616815-8283-1-git-send-email-bhumirks@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed a coding style issue.Added a blank link after declaration.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/bluetooth/ath3k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index fa893c3..ebd641b 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -497,6 +497,7 @@ static int ath3k_probe(struct usb_interface *intf,
 	/* match device ID in ath3k blacklist table */
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
+
 		match = usb_match_id(intf, ath3k_blist_tbl);
 		if (match)
 			id = match;
-- 
1.9.1
