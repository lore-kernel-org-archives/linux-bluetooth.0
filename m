Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Dec 2009 17:58:49 +0200
From: Dan Carpenter <error27@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: [patch] clean up.  signed => unsigned
Message-ID: <20091208155849.GA28661@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

This is just a clean up to please static checkers.  It does not 
change how the kernel runs.

0xc0 is 192 and pkt_delim is a signed char so the max it can be is 
127.  I have made it unsigned.

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/drivers/bluetooth/hci_bcsp.c	2009-12-08 16:37:28.000000000 +0200
+++ devel/drivers/bluetooth/hci_bcsp.c	2009-12-08 16:37:39.000000000 +0200
@@ -125,7 +125,7 @@ static void bcsp_crc_update(u16 *crc, u8
 
 static void bcsp_slip_msgdelim(struct sk_buff *skb)
 {
-	const char pkt_delim = 0xc0;
+	const unsigned char pkt_delim = 0xc0;
 
 	memcpy(skb_put(skb, 1), &pkt_delim, 1);
 }
