Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
Date: Tue, 26 Nov 2002 10:02:33 -0800
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Reuse of H4 and BCSP code
In-Reply-To: <1038260639.772.57.camel@pegasus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

>the current hci_uart.o driver supports H4 and BCSP HCI protocols and the
>code from it should be reusable by the other drivers two. For example
>most PCMCIA cards are a kind of serial cards with an UART on it. The
>only difference is how the UART would be used to talk to the Bluetooth
>chips and many times you need some extra code. If this Bluetooth chip is
>one from CSR their are two protocols available two use and you can
>switch between them if you like (and autodetection would be great). So
>it should be possible to reuse the H4 and the BCSP code, which will make
>some PCCARD drivers a little bit smaller.
>
>The current driver which can reuse the code are:
>
>bluecard_cs:    H4
>bt3c_cs:        H4
>btuart_cs:      H4 and BCSP
>bt950_cs:       H4 and BCSP
>hci_uart:       H4 and BCSP
>
>At the moment I see two ways of doing this, but maybe there are more of
>them.
>
>1. Let the hci_uart driver export some function to let the drivers
>register. Maybe something like:
>
>        hci_register_uart       (which later calls hci_register_dev)
>        hci_unregister_uart     (which later calls hci_unregister_dev)
>
>2. Make the code in hci_h4.c and hci_bcsp.c linkable against the driver.
>
>Both versions have advantages and disadvantages. The first one keeps the
>size of the driver module small, but you always need another module to
>interface with the HCI core. The second one need no other modules, but
>the code for the UART protocols are in every driver.

3. Move H4 and BCSP to a separate module hci_uart_proto (or whatever) and
export 
        hci_uart_get_proto(XXX) 
        hci_uart_put_proto(XXX)
        etc

4. Make all H4/BCSP _cs look like normal TTY (with minimal TTY functionality) 
and use hciattach + hci_uart.o

>>>From me personal view of it I don't like to have too much modules and I
>would go with the second possibility. But anyway for both methods some
>parts of the BCSP init code have to be moved to the kernel space.

Believe it or not but I actually prefer #4 :). I know I know, I was the one who
said that we should try to avoid TTY layers if possible. But it's becoming 
more and more troublesome. I don't like the idea of moving BCSP initialization
and H4/BCSP auto-detection into the kernel. In order to keep it in the user space 
we need some interface for hciattach. And TTY provides perfect interface 
for what hciattach needs to do.
So far I haven't seen any Bluetooth HCI performance issues related to the 
TTY layer. We set tty->low_latency flag and get data right of the ring buffer.
And we don't have to support complete TTY functionally, just stuff that we need
i.e. set baudrate, read/write, etc.
btw In 2.5.x TTY layer has been cleaned up and doesn't look as bad as in 2.4.

#1 Is essentially reinventing TTY interface. i.e. HW drivers register to a
generic layer i.e. TTY (or HCI in our case).
#2 Is unnecessary bloating. I'd rather do #3.

But the biggest disadvantage of 1,2 and 3 is lack of interface for the user space.
If you remember BCSP discussions, there was an issue of properly resetting HCI device
(i.e. HCI and all the way up) if HW problems were detected. With hciattach it's easy,
hci_uart sends SIGHUP -> hciattach closes TTY -> HCI device unregistered -> hciattach 
reopens TTY. It's not that simple without hciattach.

Max
