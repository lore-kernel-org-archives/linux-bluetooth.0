Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1094482974.14552.38891.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Subject: [Bluez-devel] BNEP corruption.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 06 Sep 2004 16:02:55 +0100

Using a PCMCIA bluetooth card I see this frequently... 

bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Out-of-order packet arrived, got 2 expected 1
bcsp_recv: Out-of-order packet arrived, got 3 expected 1
bcsp_recv: Out-of-order packet arrived, got 4 expected 1
bcsp_recv: Short BCSP packet
bcsp_recv: Out-of-order packet arrived, got 7 expected 6
bcsp_recv: Out-of-order packet arrived, got 0 expected 6
bcsp_recv: Out-of-order packet arrived, got 1 expected 6
bcsp_recv: Error in BCSP hdr checksum

At some point I'll investigate -- I thought we were supposed to be using
flow control so that really shouldn't happen. But more concerning is the
fact that this leads to silent corruption in network traffic -- we seem
to be bypassing checksums on packets received by BNEP. Let's not do
that:

--- net/bluetooth/bnep/core.c~	2004-08-14 06:37:26.000000000 +0100
+++ net/bluetooth/bnep/core.c	2004-09-06 15:28:05.749950320 +0100
@@ -384,7 +384,7 @@
 	
 	s->stats.rx_packets++;
 	nskb->dev       = dev;
-	nskb->ip_summed = CHECKSUM_UNNECESSARY;
+	nskb->ip_summed = CHECKSUM_NONE;
 	nskb->protocol  = eth_type_trans(nskb, dev);
 	netif_rx_ni(nskb);
 	return 0;


-- 
dwmw2



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
