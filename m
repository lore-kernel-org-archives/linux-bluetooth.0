Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1038260639.772.57.camel@pegasus.local>
Mime-Version: 1.0
Subject: [Bluez-devel] Reuse of H4 and BCSP code
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 25 Nov 2002 22:43:53 +0100

Hi,

the current hci_uart.o driver supports H4 and BCSP HCI protocols and the
code from it should be reusable by the other drivers two. For example
most PCMCIA cards are a kind of serial cards with an UART on it. The
only difference is how the UART would be used to talk to the Bluetooth
chips and many times you need some extra code. If this Bluetooth chip is
one from CSR their are two protocols available two use and you can
switch between them if you like (and autodetection would be great). So
it should be possible to reuse the H4 and the BCSP code, which will make
some PCCARD drivers a little bit smaller.

The current driver which can reuse the code are:

bluecard_cs:	H4
bt3c_cs:	H4
btuart_cs:	H4 and BCSP
bt950_cs:	H4 and BCSP
hci_uart:	H4 and BCSP

At the moment I see two ways of doing this, but maybe there are more of
them.

1. Let the hci_uart driver export some function to let the drivers
register. Maybe something like:

	hci_register_uart	(which later calls hci_register_dev)
	hci_unregister_uart	(which later calls hci_unregister_dev)

2. Make the code in hci_h4.c and hci_bcsp.c linkable against the driver.

Both versions have advantages and disadvantages. The first one keeps the
size of the driver module small, but you always need another module to
interface with the HCI core. The second one need no other modules, but
the code for the UART protocols are in every driver.

>From me personal view of it I don't like to have too much modules and I
would go with the second possibility. But anyway for both methods some
parts of the BCSP init code have to be moved to the kernel space.

Please comment on this. Anyone who will start with this?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
