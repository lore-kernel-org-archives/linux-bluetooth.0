Return-Path: <eauth@softsys.co.at>
Subject: Re: [Bluez-users] lockup problem with larger packets
From: Erwin Authried <eauth@softsys.co.at>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098964060.6636.15.camel@pegasus>
References: <1098480115.3258.61.camel@justakiss>
	 <1098539750.26310.17.camel@pegasus>  <1098928778.23859.32.camel@kabel>
	 <1098964060.6636.15.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-9KGnijx2xArCjte4SwV+"
Message-Id: <1098973897.11799.97.camel@justakiss>
Mime-Version: 1.0
Date: Thu, 28 Oct 2004 16:31:37 +0200
List-ID: <bluez-users.lists.sourceforge.net>


--=-9KGnijx2xArCjte4SwV+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
here's a patch that reduces the execution time for "unslipping" the
received data considerably. The patch does NOT support packets with CRC!
This would require a little bit of additional work, I think that it
would be better to rewrite the crc routine to calculate the whole packet
checksum at once for better performance. I have not done that because
the CBT100C doesn't use crc's.
Please ignore the __fastram attribute, it's for uClinux on my specific
board only. Functions with this attribute are placed into the cpu's
internal 32-bit ram for faster execution.

Regards,
Erwin

Am Don, den 28.10.2004 schrieb Marcel Holtmann um 13:47:
> Hi Erwin,
> 
> > > > I have cross-compiled bluez for uClinux-2.4.20 for ARM7, with the bluez
> > > > kernel patch applied, and bluez-utils 2.10. I'm using the Conceptronic
> > > > CBT100C PCMCIA card on the system. The card is initialized with
> > > > "hciattach ttyS2 bcsp". Basically, the system works fine, but I see
> > > > occasional overrun errors on the UART, maybe because the ARM7 is running
> > > > with 40MHz only. When I transmit larger packets (l2ping -s 300 ...), the
> > > > number of overrun errors increases, and sometimes the system locks up.
> > > > I'm getting an endless sequence of: 
> > > > 
> > > > bcsp_pkt_cull: Peer acked invalid packet
> > > > bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
> > > > bcsp_pkt_cull: Peer acked invalid packet
> > > > bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
> > > > bcsp_pkt_cull: Peer acked invalid packet
> > > > ...
> > > 
> > > I am not a BCSP or uClinux expert so I think that I can't help you here,
> > > but from my testing with the BCSP part of the hci_uart driver I never
> > > saw any problems like this.
> > > 
> > After a lot of debugging, I found out that the serial irq routine calls
> > tty_flip_buffer_push with the serial interrupt disabled. The processing
> > of the input buffer in bcsp_recv (hci_bcsp.c) was too slow so that the
> > characters that were buffered in the FIFO during that time caused an
> > overrun (There is no RTS/CTS flowcontrol). I have done modifiations to
> > hci_bcsp.c so that the processing is done much faster, and the problem
> > seems to have gone. 
> 
> please provide us a patch with your modifications.
> 
> Regards
> 
> Marcel


--=-9KGnijx2xArCjte4SwV+
Content-Disposition: attachment; filename=unslip.patch
Content-Type: text/x-patch; name=unslip.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -u hci_bcsp.h.orig hci_bcsp.h
--- hci_bcsp.h.orig	Wed Oct 27 23:08:04 2004
+++ hci_bcsp.h	Thu Oct 28 16:12:00 2004
@@ -42,6 +42,7 @@
 	struct sk_buff_head unrel;	/* Unreliable packets queue */
 
 	unsigned long rx_count;
+	unsigned char *rx_ptr;	
 	struct  sk_buff *rx_skb;
 	u8      rxseq_txack;		/* rxseq == txack. */
 	u8      rxack;			/* Last packet sent by us that the peer ack'ed */
diff -u hci_bcsp.c.orig hci_bcsp.c
--- hci_bcsp.c.orig	Mon Oct 25 23:22:58 2004
+++ hci_bcsp.c	Thu Oct 28 16:13:54 2004
@@ -53,6 +53,9 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+
+#include <linux/fastram.h>
+
 #include "hci_uart.h"
 #include "hci_bcsp.h"
 
@@ -401,53 +404,46 @@
 	}
 }
 
-static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char byte)
+static int __fastram bcsp_unslip(struct bcsp_struct *bcsp, unsigned char **p_pdata, int *p_count)
 {
-	const u8 c0 = 0xc0, db = 0xdb;
-
-	switch (bcsp->rx_esc_state) {
-	case BCSP_ESCSTATE_NOESC:
-		switch (byte) {
-		case 0xdb:
-			bcsp->rx_esc_state = BCSP_ESCSTATE_ESC;
-			break;
-		default:
-			memcpy(skb_put(bcsp->rx_skb, 1), &byte, 1);
-			if ((bcsp->rx_skb-> data[0] & 0x40) != 0 && 
-					bcsp->rx_state != BCSP_W4_CRC)
-				bcsp_crc_update(&bcsp->message_crc, byte);
-			bcsp->rx_count--;
-		}
-		break;
-
-	case BCSP_ESCSTATE_ESC:
-		switch (byte) {
-		case 0xdc:
-			memcpy(skb_put(bcsp->rx_skb, 1), &c0, 1);
-			if ((bcsp->rx_skb-> data[0] & 0x40) != 0 && 
-					bcsp->rx_state != BCSP_W4_CRC)
-				bcsp_crc_update(&bcsp-> message_crc, 0xc0);
-			bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
-			bcsp->rx_count--;
-			break;
-
-		case 0xdd:
-			memcpy(skb_put(bcsp->rx_skb, 1), &db, 1);
-			if ((bcsp->rx_skb-> data[0] & 0x40) != 0 && 
-					bcsp->rx_state != BCSP_W4_CRC) 
-				bcsp_crc_update(&bcsp-> message_crc, 0xdb);
-			bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
-			bcsp->rx_count--;
-			break;
-
-		default:
-			BT_ERR ("Invalid byte %02x after esc byte", byte);
-			kfree_skb(bcsp->rx_skb);
-			bcsp->rx_skb = NULL;
-			bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
-			bcsp->rx_count = 0;
-		}
-	}
+    unsigned char *pdata=*p_pdata;
+    int count=*p_count;
+    unsigned char c;
+    int ret=0;
+
+    while(bcsp->rx_count && count){
+        c=*pdata++; count--;
+        if (c==0xc0) {ret=-2; goto unslip_ret;}	//unexpected end of slip pkt.
+
+        switch(bcsp->rx_esc_state){
+        case BCSP_ESCSTATE_NOESC:
+            if (c==0xdb){
+                bcsp->rx_esc_state = BCSP_ESCSTATE_ESC;
+            }
+            else{
+                *bcsp->rx_ptr++ = c; bcsp->rx_count--;
+            }
+            break;
+        case BCSP_ESCSTATE_ESC:
+            switch(c){
+            case 0xdd:
+                *bcsp->rx_ptr++ = 0xdb;
+                break;
+            case 0xdc:
+                *bcsp->rx_ptr++ = 0xc0;
+                break;
+            default:
+		ret=-1; goto unslip_ret;	// Illegal char after ESC
+            }
+            bcsp->rx_count--;
+            bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
+            break;
+        }
+    } // while
+unslip_ret:
+    *p_pdata = pdata;
+    *p_count = count;
+    return ret;
 }
 
 static inline void bcsp_complete_rx_pkt(struct hci_uart *hu)
@@ -507,27 +503,32 @@
 }
 
 /* Recv data */
-static int bcsp_recv(struct hci_uart *hu, void *data, int count)
+static int __fastram bcsp_recv(struct hci_uart *hu, void *data, int count)
 {
 	struct bcsp_struct *bcsp = hu->priv;
-	register unsigned char *ptr;
-
+	unsigned char *ptr;
 	BT_DBG("hu %p count %d rx_state %ld rx_count %ld", 
 		hu, count, bcsp->rx_state, bcsp->rx_count);
-
 	ptr = data;
 	while (count) {
-		if (bcsp->rx_count) {
-			if (*ptr == 0xc0) {
-				BT_ERR("Short BCSP packet");
-				kfree_skb(bcsp->rx_skb);
-				bcsp->rx_state = BCSP_W4_PKT_START;
-				bcsp->rx_count = 0;
-			} else
-				bcsp_unslip_one_byte(bcsp, *ptr);
-
-			ptr++; count--;
-			continue;
+		// dest buf: bcsp->rx_ptr, rx_count
+		if (bcsp->rx_count){
+		    switch (bcsp_unslip(bcsp,&ptr,&count)){
+		    case -2:
+			BT_ERR("Short BCSP packet");
+			kfree_skb(bcsp->rx_skb);
+			bcsp->rx_state = BCSP_W4_PKT_START;
+			bcsp->rx_count = 0;
+			break;
+		    case -1:
+			BT_ERR("Illegal SLIP char");
+			kfree_skb(bcsp->rx_skb);
+			bcsp->rx_skb=NULL;
+			bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
+			bcsp->rx_count = 0;
+			break;
+		    }
+		    continue;
 		}
 
 		switch (bcsp->rx_state) {
@@ -553,12 +554,14 @@
 			bcsp->rx_state = BCSP_W4_DATA;
 			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) + 
 					(bcsp->rx_skb->data[2] << 4);	/* May be 0 */
+			bcsp->rx_ptr=skb_put(bcsp->rx_skb,bcsp->rx_count);
 			continue;
 
 		case BCSP_W4_DATA:
 			if (bcsp->rx_skb->data[0] & 0x40) {	/* pkt with crc */
 				bcsp->rx_state = BCSP_W4_CRC;
 				bcsp->rx_count = 2;
+				bcsp->rx_ptr=skb_put(bcsp->rx_skb,2);
 			} else
 				bcsp_complete_rx_pkt(hu);
 			continue;
@@ -609,7 +612,6 @@
 				/* Do not increment ptr or decrement count
 				 * Allocate packet. Max len of a BCSP pkt= 
 				 * 0xFFF (payload) +4 (header) +2 (crc) */
-
 				bcsp->rx_skb = bluez_skb_alloc(0x1005, GFP_ATOMIC);
 				if (!bcsp->rx_skb) {
 					BT_ERR("Can't allocate mem for new packet");
@@ -617,6 +619,8 @@
 					bcsp->rx_count = 0;
 					return 0;
 				}
+				bcsp->rx_ptr=skb_put(bcsp->rx_skb,bcsp->rx_count);
+
 				bcsp->rx_skb->dev = (void *) &hu->hdev;
 				break;
 			}

--=-9KGnijx2xArCjte4SwV+--
