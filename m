Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 18 May 2014 09:17:00 +0530
Message-ID: <CALSp4eNGPZ+S=yi=SCJ-X3Yu0YWqDxwscmgm_Y1Cz1v4x6QRcA@mail.gmail.com>
Subject: BT over TTY lines
From: bhasker neti <bnetiqipl@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are working on x86 ubuntu based project where our BT chipset is
connected to PC.

We are using TTY interface for all tx/rx operations.


Bluetooth flow :

It downloads the initial firmware via /dev/ttyXYZ from user space, and
then attaches hci_ldisc with tty_ldisc in the kernel, then does all
the Tx/Rx operations.

We are facing one issue:

When we connect the chip via UART interface, it is coming as
/dev/ttyS0, the code base is working fine, from user space as well as
from kernel space,

But when we connect the chip using UART/USB converter, it is coming up
as /dev/ttyUSB0, we were able to download from user space via tty
interface, but from kernel space we are not able to communicate with
the device,

I am not able to trace the tty code, but I can see that in failure
case no command is going out on serial lines from PC.

Can you please share some inputs here, is there anything specially we
need to handle USB serial interfaces? How it is different from UART
tty interface ?

Here is our code base :

http://lxr.free-electrons.com/source/drivers/bluetooth/hci_ldisc.c#L139


Setup details:

Ubuntu 12.04
Kernel : 3-10.
BLUEZ : 4.98/4.101
