Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Once again: Socket CF card and Kernel 2.6
Message-ID: <20050305141858.GA21208@adamis.de>
References: <20050226031901.GL11723@adamis.de> <1109578431.17256.9.camel@pegasus> <20050228220209.GA8151@adamis.de> <1109665776.17256.122.camel@pegasus> <42294598.6010004@adamis.de> <1110021859.8058.111.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
In-Reply-To: <1110021859.8058.111.camel@pegasus>
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
Date: Sat, 5 Mar 2005 15:18:58 +0100


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by minne.gra.de id j25EPXod023841

Hi Marcel,

On 05.03.05 12:24:19, Marcel Holtmann wrote:
> > I just got it working by doing a little change in the serial driver=20
> > (8250.c). I tested it with 2.6.11 but I think it could work for any 2=
.6=20
> > kernel.
>=20
> please provide a patch for your change.

So - after some cleaning - here it is. A short description:

The BlueZ driver requests a baud rate
of 230400 which is uartclk/8 (serial_cs sets uartclk=3D1843200). However
serial8250_set_termios() refuses to program a baud rate larger than
uartclk/16 which should be ok for most UARTs. I looked into the 2.4
driver and found some code that changes the internal prescaler to values
between 1:16 and 1:4 to support baud rates up to uartclk/4 respectively
(this is done for 16C950 UARTs only). The datasheet of oxford's oxcf950
chip confirms this feature.

Apply the patch to the file drivers/serial/8250.c

Please let me know if there are problems or if it does work.

> > One thing I discovered while debugging this: the hci_uart driver=20
> > seems to initialize the actual UART with only 230400 baud. Is this=20
> > really the case or are those UARTs clocked at nonstandard (higher)=20
> > frequencies so that this setting does result in a higher real baud ra=
te?
>=20
> The hci_uart is only a line discipline. Every initialization and baud
> rate settings are done with hciattach.

ok so it's hciattach that sets the baudrate - but that wasn't the point
(or I misunderstood your answer?): I wonder if the bluetooth module is
really accessed at only 230400 baud (that's the rate which is given to
the 8250 driver) which seems a little bit slow thinking of bluetooths
>700kbaud maximum rate...


Regards

Mathias


--=20
Der Jammer der Menschen ist, da=DF die Narren so sicher sind und die
Klugen so voller Zweifel. (Bertrand Russel)

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-serial-16c950

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

--ZPt4rx8FFjLCG7dd--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
