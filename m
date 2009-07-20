Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth honeypot - hci socket that reads package problem -
From: Marcel Holtmann <marcel@holtmann.org>
To: Vincenzo Ampolo <vincenzo.ampolo@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Stefano Zanero <zanero@elet.polimi.it>
In-Reply-To: <200907200938.35808.vincenzo.ampolo@gmail.com>
References: <200907200938.35808.vincenzo.ampolo@gmail.com>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 09:45:28 +0200
Message-Id: <1248075928.4549.91.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincenzo,

> For my thesis, i'm trying to write a bluez based honeypot.
> The basic concept is to listen at the hci level and perform actions. (switch 
> on sockets in rfcomm or l2cap channels or addresses to audit the data)
> 
> I started studying the hcidump code and the hci socket. The main problem i'm 
> having is that the hci socket which is created in this way
> 
> 	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> 
> does not "pop" the package from the bluez stack, it just reads but the package 
> will continue to be processed by the stack. So if there is an attempt for a 
> connection it will find a closed socket. Is there a way to "pop" the package 
> from the stack, so i can read the destination channel or address of the 
> package and turn on a socket on that specified channel or address and then 
> "push" again the package into the stack?
> 
> If it's not possible, the only way to set my bluetooth honeypot up is to open 
> a socket for each rfcomm and l2cap channel and address and wait for data to 
> audit.

what you are planning is to write a whole Bluetooth stack in userspace,
but wanna have the kernel do the hardware abstraction :)

You need to set the device into RAW mode. Otherwise the kernel will keep
processing the HCI packets.

Regards

Marcel


