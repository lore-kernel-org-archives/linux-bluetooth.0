Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Adding Broadcom Support for BCM 20702AO of Fuijitsu Lifebook E751 with .driver_info = BTUSB_BCM_PATCHRAM },
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <547C2F76.80000@gmx.de>
Date: Mon, 1 Dec 2014 11:37:59 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CA52376B-12C5-4A2E-9922-616A722D1D54@holtmann.org>
References: <547C2F76.80000@gmx.de>
To: harv@gmx.de
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harvey,

> may I kindly ask to incorporate the bluetooth device of my Laptop
> Fuijitsu Lifebook E751 to the list of devices supported through
> loading firmware via
> .driver_info = BTUSB_BCM_PATCHRAM ?
> 
> Output of usb-devices:
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e031 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0

you need to send a patch adding the changes to the USB device table. The commit message should include the content of /sys/kernel/debug/usb/devices in the commit message and also instructions on how to get the firmware file needed for this hardware.

Regards

Marcel

