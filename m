Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20021127095652.07b78738@mail1.qualcomm.com>
Date: Wed, 27 Nov 2002 10:34:22 -0800
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Reuse of H4 and BCSP code
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1038409787.771.53.camel@pegasus.local>
References: <5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
	<5.1.0.14.2.20021126092054.0798bff0@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

>> 3. Move H4 and BCSP to a separate module hci_uart_proto (or whatever) and
>> export 
>>         hci_uart_get_proto(XXX) 
>>         hci_uart_put_proto(XXX)
>>         etc
>
>sounds for me similar to the number 1. But you pull the code outside the
>hci_uart driver. My problem with this is (like with number 1) you need
>another module to let the driver interface with the HCI core.
But you already have it. I mean you keep most of the bluecard_cs (or whatever)
and simply off load H4/BCSP processing.

>> 4. Make all H4/BCSP _cs look like normal TTY (with minimal TTY functionality) 
>> and use hciattach + hci_uart.o
>
>this will be possible for the btuart_cs and bt950_cs driver, but it will
>not be a good idea for the bluecard_cs and bt3c_cs. These two drivers
>should not look like a TTY and they only share the H4 protocol. 
So it's impossible to switch them to BCSP ? 
If that's the case then it's ok to keep them stand alone.

>And I don't want to make them work like the bluetooth.o driver from Greg.
USB is different. bluetty _emulates_ serial interface, where is in this
case all those cards have real UARTs and drivers would _reuse_ existing
serial interface (i.e. TTY) provided by the kernel.

>This is the wrong way I think. For the btuart_cs you can use the serial_cs
>driver and than use hciattach and the hci_uart driver. 
Yep.

>And it should be possible to put some quirks into the serial_cs to let it work 
>with all cards supported by the bt950_cs and btuart_cs driver, but from my point
>this is the wrong way, because the serial_cs is a very messy beast.
bt950 doesn't have to talk to serial_cs. It be nice if it can reuse 16650A code
but if it can't it should be standalone TTY.
What cards are supported by btuart_cs that are not supported by serial_cs ?

>> Believe it or not but I actually prefer #4 :). I know I know, I was the one who
>> said that we should try to avoid TTY layers if possible. But it's becoming 
>> more and more troublesome. I don't like the idea of moving BCSP initialization
>> and H4/BCSP auto-detection into the kernel. In order to keep it in the user space 
>> we need some interface for hciattach. And TTY provides perfect interface 
>> for what hciattach needs to do.
>> So far I haven't seen any Bluetooth HCI performance issues related to the 
>> TTY layer. We set tty->low_latency flag and get data right of the ring buffer.
>> And we don't have to support complete TTY functionally, just stuff that we need
>> i.e. set baudrate, read/write, etc.
>> btw In 2.5.x TTY layer has been cleaned up and doesn't look as bad as in 2.4.
>> 
>> #1 Is essentially reinventing TTY interface. i.e. HW drivers register to a
>> generic layer i.e. TTY (or HCI in our case).
>> #2 Is unnecessary bloating. I'd rather do #3.
>> 
>> But the biggest disadvantage of 1,2 and 3 is lack of interface for the user space.
>> If you remember BCSP discussions, there was an issue of properly resetting HCI device
>> (i.e. HCI and all the way up) if HW problems were detected. With hciattach it's easy,
>> hci_uart sends SIGHUP -> hciattach closes TTY -> HCI device unregistered -> hciattach 
>> reopens TTY. It's not that simple without hciattach.
>
>I will take the weekend to do some test with the serial_cs driver and
>try to get the bt950_cs register a TTY and start playing with it. Maybe
>we should do something like #2 and #4. So the code can be linked into
>another driver like for bluecard_cs and bt3c_cs and maybe if some people
>need a special driver for some embedded devices. On the embedded side
>the bloat of #2 wouldn't count because you will only have one hardware
>driver. With using number #2 for it we can maintain the H4 and BCSP
>source code at one point and it can be reused. So we only use them in
>the hci_uart, bluecard_cs and bt3c_cs driver, but it can be used by
>special drivers in the future, if needed.

#2 is already there. All you have do in your driver is provide following 
interfaces:
        - struct hci_uart
                H4 and BCSP don't use tty field, so may by NULL
        - hci_uart_register_proto() / hci_uart_register_proto()

        - Call h4_init() and bcsp_init() during initialization.

That's it. Once you have that you can just link hci_h4.o and hci_bcsp.o
into your driver.
btw We should probably just drop this register/unregister interface. It's 
not dynamic anyway.

Max
