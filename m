Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reuse of H4 and BCSP code
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20021127095652.07b78738@mail1.qualcomm.com>
References: <5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
	<5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
	<5.1.0.14.2.20021127095652.07b78738@mail1.qualcomm.com>
Message-Id: <1038466070.772.42.camel@pegasus.local>
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
Date: 28 Nov 2002 07:47:44 +0100
Content-Type: text/plain

Hi Max,

> >this will be possible for the btuart_cs and bt950_cs driver, but it will
> >not be a good idea for the bluecard_cs and bt3c_cs. These two drivers
> >should not look like a TTY and they only share the H4 protocol. 
> So it's impossible to switch them to BCSP ? 
> If that's the case then it's ok to keep them stand alone.

for the bluecard_cs this is right, because it is an Ericsson chip and I
think it is also true for the bt3c_cs because they use another kind
firmware. But the point is not implementing H4, because this is easy and
the code is very small. So we can keep (and I actually will) keep these
drivers standalone. But if I can reuse the existing H4 code like in #2 I
am also happy.

And in the case of BCSP it makes really sense to maintain the code at
one central point :)

> >And I don't want to make them work like the bluetooth.o driver from Greg.
> USB is different. bluetty _emulates_ serial interface, where is in this
> case all those cards have real UARTs and drivers would _reuse_ existing
> serial interface (i.e. TTY) provided by the kernel.

This is exactly what I wanted to say. If they don't have real UART, like
16650A or an OX950 or something else it is not good to emulate a TTY.

> >And it should be possible to put some quirks into the serial_cs to let it work 
> >with all cards supported by the bt950_cs and btuart_cs driver, but from my point
> >this is the wrong way, because the serial_cs is a very messy beast.
> bt950 doesn't have to talk to serial_cs. It be nice if it can reuse 16650A code
> but if it can't it should be standalone TTY.
> What cards are supported by btuart_cs that are not supported by serial_cs ?

The serial.o have a register_serial function and I want to start playing
with it. And yes we have one card that works with btuart_cs, but not
with serial_cs. I was told that the "magic initialization" of serial_cs
(or serial.o) causes the hciattach to fail, but the minimal things in
btuart_cs keep it happy and the device will work.

> #2 is already there. All you have do in your driver is provide following 
> interfaces:
>         - struct hci_uart
>                 H4 and BCSP don't use tty field, so may by NULL
>         - hci_uart_register_proto() / hci_uart_register_proto()
> 
>         - Call h4_init() and bcsp_init() during initialization.
> 
> That's it. Once you have that you can just link hci_h4.o and hci_bcsp.o
> into your driver.
> btw We should probably just drop this register/unregister interface. It's 
> not dynamic anyway.

I will start playing with it. Have anyone done this before and can share
some experiences?

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
