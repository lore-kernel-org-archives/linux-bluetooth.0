Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Once again: Socket CF card and Kernel 2.6
Message-ID: <20050305192539.GA26285@adamis.de>
References: <20050226031901.GL11723@adamis.de> <1109578431.17256.9.camel@pegasus> <20050228220209.GA8151@adamis.de> <1109665776.17256.122.camel@pegasus> <42294598.6010004@adamis.de> <1110021859.8058.111.camel@pegasus> <20050305141858.GA21208@adamis.de> <1110046671.18555.3.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
In-Reply-To: <1110046671.18555.3.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 5 Mar 2005 20:25:39 +0100


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

On 05.03.05 19:17:50, Marcel Holtmann wrote:
> I only have the old Socket cards (dtl1_cs driver) at hand and so I can't
> test it, but my Xircom card is still not working.

Is that Xircom card similar to the newer Socket cards? i.e. does it have
a 16C95x UART? If yes you could try this patch which I used while
investigating the problem, it includes some debug messages which might
help.

> For the Socket card the baud rate is 230400 and yes, this is to slow for
> the full bandwith of a piconet. However I never did any bandwith test
> with this card, but actually there are cards out there where the UART
> limits the total possible bandwidth.

Huh - but at least it's still a lot faster than a GPRS connection so it's
okay for me...

Regards,
Mathias


-- 
The first time you'll get a Microsoft product that doesn't suck,
will be the day they start producing vacuum cleaners.

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=debug-patch

--- 8250.c_2.6.11-org	2005-03-02 08:37:47.000000000 +0100
+++ 8250.c	2005-03-05 02:32:50.000000000 +0100
@@ -56,11 +56,11 @@
 /*
  * Debugging.
  */
-#if 0
+//#if 0
 #define DEBUG_AUTOCONF(fmt...)	printk(fmt)
-#else
-#define DEBUG_AUTOCONF(fmt...)	do { } while (0)
-#endif
+//#else
+//#define DEBUG_AUTOCONF(fmt...)	do { } while (0)
+//#endif
 
 #if 0
 #define DEBUG_INTR(fmt...)	printk(fmt)
@@ -346,7 +346,7 @@
 static inline void serial8250_clear_fifos(struct uart_8250_port *p)
 {
 	if (p->capabilities & UART_CAP_FIFO) {
-		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO);
+//alskdfj		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO);
 		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO |
 			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 		serial_outp(p, UART_FCR, 0);
@@ -1636,9 +1636,25 @@
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk /* /16 */); 
 	quot = serial8250_get_divisor(port, baud);
+	printk(KERN_INFO "***** Serial: baud=%d quot=%d\n", baud, quot);
 
+	if (up->port.type == PORT_16C950) {
+		unsigned int baud_base = port->uartclk/16;
+		if (baud <= baud_base)
+			serial_icr_write(up, UART_TCR, 0);
+		else if (baud <= 2*baud_base) {
+			serial_icr_write(up, UART_TCR, 0x8);
+			baud_base = baud_base * 2;
+		} else if (baud <= 4*baud_base) {
+			serial_icr_write(up, UART_TCR, 0x4);
+			baud_base = baud_base * 4;
+		} else
+			serial_icr_write(up, UART_TCR, 0);
+		printk(KERN_INFO "***** Serial: baud_base=%d\n", baud_base);
+	}
+	
 	/*
 	 * Work around a bug in the Oxford Semiconductor 952 rev B
 	 * chip which causes it to seriously miscalculate baud rates

--a8Wt8u1KmwUX3Y2C--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
