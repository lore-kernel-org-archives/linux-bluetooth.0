Return-Path: <pavouk@pavouk.org>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Pretec and Ambicom BT2000E driver
Date: Sun, 11 Apr 2004 00:36:47 +0200
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200404100030.49916.pavouk@pavouk.org> <1081593241.3028.7.camel@pegasus>
In-Reply-To: <1081593241.3028.7.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404110036.47661.pavouk@pavouk.org>
List-ID: <bluez-users.lists.sourceforge.net>

Hello,

> I know that driver and I really thought of including it, but the best
> way is to make it working through serial_cs and hci_uart/hciattach. Once
> this is solved every card with a 16C950 UART will work and not only the
> two with an Ericsson chip on it.

Today I make some experiments with it.
I have Zaurus SL-C860 with CackoRom kernel 2.4.18...

I edit configuration. After inserting BT2000E CF card is loaded serial_cs
kernel module.
DMESG: ttyS03 at port 0xf60002f8 (irq = 39) is a 16C950/954

# hciattach 10 ttyS3 ericsson 115200
# hciconfig hci0 up
Can't init device hci0. Connection timed out(110)

I've tried several combination with hciattach command with speed from 9600 to 
460800, flow enabled/disabled but without success.

Do you have some idea?

Do you know right parameters for hciattach?

There are some more useful informations:
# cat /proc/tty/driver/serial
serinfo:1.0 driver:5.05c revision:2001-07-08
0: uart:16C950/954 port:F60002F8 irq:39 baud:115200 tx:139 rx:21 fe:6 brk:11 
RTS|CTS|DTR|DSR|CD|RI
1: uart:unknown port:0 irq:0
2: uart:unknown port:0 irq:0
3: uart:unknown port:0 irq:0

# cat /proc/tty/drivers
serial_cpu           /dev/cua        5   64-66 serial:callout
serial_cpu           /dev/ttyS       4   64-66 serial
serial               /dev/cua        5   67-70 serial:callout
serial               /dev/ttyS       4   67-70 serial

# ls -l /dev/ttyS3
crw-------    1 zaurus   root       4,  67 Apr 10 21:58 /dev/ttyS3

I have few more questions.
In dmesg I see: ttyS03... Why not ttyS3?

When I make"rmmod serial_cs"
I see in dmesg this: tty03 unloaded.
Why tty03 and not ttyS3?

I'am a little confused ;-)

This cards works now with bt2000e_cs.o but sometimes my Zaurus freezes when 
removing card...
 
> Regards
> Marcel

Best regards,

Pavel Ruzicka
