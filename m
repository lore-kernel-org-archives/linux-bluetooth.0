Return-Path: <cyrus@holtmann.org>
Message-ID: <62255.200.163.20.213.1248372772.squirrel@www.inbd.com.br>
Date: Thu, 23 Jul 2009 13:12:52 -0500 (CDT)
Subject: linux-bluetooth
From: andre.souza@inbd.com.br
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi, i'am try make working the bluez in a ARM platform but i've some
problems to recognize the usb adapter.

The message when i connect the device is:

[bash]# usb 1-1: new full speed USB device using s3c2410-ohci and address 2
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full speed USB device using s3c2410-ohci and address 3
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full speed USB device using s3c2410-ohci and address 4
usb 1-1: device not accepting address 4, error -110
usb 1-1: new full speed USB device using s3c2410-ohci and address 5
usb 1-1: device not accepting address 5, error -110


and when i execute the comand hcitool scan, i get that the device is
unavailable. I suspect that
the driver usb is not run correctly.
But when i connect other device like a pen-drive, the usb reconize normaly!


The ARM used is SBC2440II, the kernel version is 2.6.13 and the arm gcc is
3.4.1.


Any idea to how recognize the device?

Thanks in advance.

Andre Souza


