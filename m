Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reuse of H4 and BCSP code
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
References: <5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
Message-Id: <1038409787.771.53.camel@pegasus.local>
Mime-Version: 1.0
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
Date: 27 Nov 2002 16:09:40 +0100
Content-Type: text/plain

Hi Max,

> >the current hci_uart.o driver supports H4 and BCSP HCI protocols and the
> >code from it should be reusable by the other drivers two. For example
> >most PCMCIA cards are a kind of serial cards with an UART on it. The
> >only difference is how the UART would be used to talk to the Bluetooth
> >chips and many times you need some extra code. If this Bluetooth chip is
> >one from CSR their are two protocols available two use and you can
> >switch between them if you like (and autodetection would be great). So
> >it should be possible to reuse the H4 and the BCSP code, which will make
> >some PCCARD drivers a little bit smaller.
> >
> >The current driver which can reuse the code are:
> >
> >bluecard_cs:    H4
> >bt3c_cs:        H4
> >btuart_cs:      H4 and BCSP
> >bt950_cs:       H4 and BCSP
> >hci_uart:       H4 and BCSP
> >
> >At the moment I see two ways of doing this, but maybe there are more of
> >them.
> >
> >1. Let the hci_uart driver export some function to let the drivers
> >register. Maybe something like:
> >
> >        hci_register_uart       (which later calls hci_register_dev)
> >        hci_unregister_uart     (which later calls hci_unregister_dev)
> >
> >2. Make the code in hci_h4.c and hci_bcsp.c linkable against the driver.
> >
> >Both versions have advantages and disadvantages. The first one keeps the
> >size of the driver module small, but you always need another module to
> >interface with the HCI core. The second one need no other modules, but
> >the code for the UART protocols are in every driver.
> 
> 3. Move H4 and BCSP to a separate module hci_uart_proto (or whatever) and
> export 
>         hci_uart_get_proto(XXX) 
>         hci_uart_put_proto(XXX)
>         etc

sounds for me similar to the number 1. But you pull the code outside the
hci_uart driver. My problem with this is (like with number 1) you need
another module to let the driver interface with the HCI core.

> 4. Make all H4/BCSP _cs look like normal TTY (with minimal TTY functionality) 
> and use hciattach + hci_uart.o

this will be possible for the btuart_cs and bt950_cs driver, but it will
not be a good idea for the bluecard_cs and bt3c_cs. These two drivers
should not look like a TTY and they only share the H4 protocol. And I
don't want to make them work like the bluetooth.o driver from Greg. This
is the wrong way I think. For the btuart_cs you can use the serial_cs
driver and than use hciattach and the hci_uart driver. And it should be
possible to put some quirks into the serial_cs to let it work with all
cards supported by the bt950_cs and btuart_cs driver, but from my point
this is the wrong way, because the serial_cs is a very messy beast.

> Believe it or not but I actually prefer #4 :). I know I know, I was the one who
> said that we should try to avoid TTY layers if possible. But it's becoming 
> more and more troublesome. I don't like the idea of moving BCSP initialization
> and H4/BCSP auto-detection into the kernel. In order to keep it in the user space 
> we need some interface for hciattach. And TTY provides perfect interface 
> for what hciattach needs to do.
> So far I haven't seen any Bluetooth HCI performance issues related to the 
> TTY layer. We set tty->low_latency flag and get data right of the ring buffer.
> And we don't have to support complete TTY functionally, just stuff that we need
> i.e. set baudrate, read/write, etc.
> btw In 2.5.x TTY layer has been cleaned up and doesn't look as bad as in 2.4.
> 
> #1 Is essentially reinventing TTY interface. i.e. HW drivers register to a
> generic layer i.e. TTY (or HCI in our case).
> #2 Is unnecessary bloating. I'd rather do #3.
> 
> But the biggest disadvantage of 1,2 and 3 is lack of interface for the user space.
> If you remember BCSP discussions, there was an issue of properly resetting HCI device
> (i.e. HCI and all the way up) if HW problems were detected. With hciattach it's easy,
> hci_uart sends SIGHUP -> hciattach closes TTY -> HCI device unregistered -> hciattach 
> reopens TTY. It's not that simple without hciattach.

I will take the weekend to do some test with the serial_cs driver and
try to get the bt950_cs register a TTY and start playing with it. Maybe
we should do something like #2 and #4. So the code can be linked into
another driver like for bluecard_cs and bt3c_cs and maybe if some people
need a special driver for some embedded devices. On the embedded side
the bloat of #2 wouldn't count because you will only have one hardware
driver. With using number #2 for it we can maintain the H4 and BCSP
source code at one point and it can be reused. So we only use them in
the hci_uart, bluecard_cs and bt3c_cs driver, but it can be used by
special drivers in the future, if needed.

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
