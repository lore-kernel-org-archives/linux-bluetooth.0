Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <473204D5.6060809@tiscali.nl>
Date: Wed, 07 Nov 2007 19:32:53 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: bluez-devel@lists.sf.net
Subject: [Bluez-devel] [PATCH] fix freeing of skbs in btsdio_rx_packet();
	drivers/bluetooth/btsdio.c
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Free skbs with kfree_skb rather than kfree

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index b786f61..df79882 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -152,7 +152,7 @@ static int btsdio_rx_packet(struct btsdio_data *data)
 
 	err = sdio_readsb(data->func, skb->data, REG_RDAT, len - 4);
 	if (err < 0) {
-		kfree(skb);
+		kfree_skb(skb);
 		return err;
 	}
 
@@ -163,7 +163,7 @@ static int btsdio_rx_packet(struct btsdio_data *data)
 
 	err = hci_recv_frame(skb);
 	if (err < 0) {
-		kfree(skb);
+		kfree_skb(skb);
 		return err;
 	}
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
