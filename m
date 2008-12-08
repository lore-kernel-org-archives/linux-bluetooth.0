Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add parent dev in rfcomm tty sysfs registration
From: Marcel Holtmann <marcel@holtmann.org>
To: Alban Browaeys <prahal@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <493D6E2F.7000406@yahoo.com>
References: <493D6E2F.7000406@yahoo.com>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 20:07:51 +0100
Message-Id: <1228763271.28839.91.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alban,

> This is an attempt at getting the parent device to be bound to the sysfs 
> entry of rfcomm tty.
> This let hal detect it properly when connecting. No more.
> 
> Thus one have to :
> $ rfcomm connect 0
> after adding his configuration for the device to connect to in 
> /etc/bluetooth/rfcomm.conf
> One need a patch to hal (for to add the address and channel data to the 
> hald/linux/device.c serial handler) and an fdi for  to add the  
> capabilities  to get  the serial line to be recognized as a modem by 
> NetworkManager.
> 
> Maybe it could be achieved at bind. Though this would either requires a 
> change to rfcomm to get the sysfs data available at bind and not connect 
> or to have hal poll bluez (I don't know yet if udev send event at rfcomm 
> bind /dev/rfcommX creation so if polling could be avoided).
> 
> 
> Also this does not address the lack of presence of rfcomm tty in 
> /sys/devices. This I am too lost in the different device_move to know if 
> it is registered in /sys/devices then moved to /sys/class/bluetooth or 
> if something is missing for to get the entries in /sys/devices . Tty 
> available documentation implying it should be automatic lead me to think 
> device_move is the key of this issue.
> 
> So it is not a panacea but with this at least it becomes "possible" to 
> get something out of hal and with a single script that rfcomm connect to 
> get the bluetooth serial device in NetworkManager.

so how do you handle the case where we have BDADDR_ANY as source and
multiple adapters attached. At time of binding the RFCOMM TTY we don't
know which adapter it will use when actually opening it.

Regards

Marcel


