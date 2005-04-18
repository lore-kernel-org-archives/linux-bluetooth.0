Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <426305F5.8010506@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Socket rev. F with 2.6 kernel
References: <200504172343.51763.pavouk@pavouk.org> <1113776422.16233.83.camel@pegasus>
In-Reply-To: <1113776422.16233.83.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------010701090804060606080409"
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
Date: Sun, 17 Apr 2005 18:57:25 -0600

This is a multi-part message in MIME format.
--------------010701090804060606080409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pavel,

I had the same card and it would not work with 2.6 until I applied this 
patch. (posted to the mailing list about a month ago)

Even then I couldn't get the rev f to do audio stuff though.

Brad

Marcel Holtmann wrote:
> Hi Pavel,
> 
> 
>>I used SOCKET BT CF card with Zaurus SL-C860 with kernel 2.4.18.
>>It works with dtl1_cs kernel driver. Now I have new distribution
>>with kernel 2.6.11. This driver is not listed in menuconfig now.
>>
>>What kernel driver (2.6.11) to use for this card?
>>I found, that file dtl1_cs.c is present in kernel tree.
> 
> 
> it is still the same driver.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------010701090804060606080409
Content-Type: text/plain;
 name="patch-serial-16c950"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-serial-16c950"

--- 8250.c_2.6.11-org	2005-03-02 08:37:47.000000000 +0100
+++ 8250.c	2005-03-05 15:01:34.000000000 +0100
@@ -1604,7 +1604,7 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, max_baud;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -1636,9 +1636,29 @@
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	max_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
+	baud = uart_get_baud_rate(port, termios, old, 0, max_baud); 
 	quot = serial8250_get_divisor(port, baud);
 
+	/* 
+	 * 16C950 supports additional prescaler ratios between 1:16 and 1:4
+	 * thus increasing max baud rate to uartclk/4. The following was taken
+	 * from kernel 2.4 by Mathias Adam <a2@adamis.de> to make the Socket
+	 * Bluetooth CF Card work under 2.6.11.
+	 * (Patch might have other side effects so be careful!)
+	 */
+	if (up->port.type == PORT_16C950) {
+		unsigned int baud_base = port->uartclk/16;
+		if (baud <= port->uartclk/16)
+			serial_icr_write(up, UART_TCR, 0);
+		else if (baud <= port->uartclk/8) {
+			serial_icr_write(up, UART_TCR, 0x8);
+		} else if (baud <= port->uartclk/4) {
+			serial_icr_write(up, UART_TCR, 0x4);
+		} else
+			serial_icr_write(up, UART_TCR, 0);
+	}
+	
 	/*
 	 * Work around a bug in the Oxford Semiconductor 952 rev B
 	 * chip which causes it to seriously miscalculate baud rates

--------------010701090804060606080409--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
