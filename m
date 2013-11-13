Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Adapter name reset on suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1384350278.5071.6.camel@nuvo>
Date: Thu, 14 Nov 2013 08:28:29 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <130CE89B-A508-4FB9-B7EA-35D500742EC1@holtmann.org>
References: <1384350278.5071.6.camel@nuvo>
To: Bastien Nocera <hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> After suspending and resuming my laptop, hci0's name is reset to what
> looks like the factory name:
> $ hciconfig -a | grep Name
> 	Name: 'BCM20702A'
> 
> This is the device in question:
> Bus 001 Device 004: ID 0a5c:21e6 Broadcom Corp. BCM20702 Bluetooth 4.0 [ThinkPad]
> 
> And my laptop is a Lenovo X1 Carbon.
> 
> Neither udevadm nor btmon show the device going away on suspend and
> coming back on resume.

can you start btmon, call hciconfig hci0 name, then suspend, then resume, call hciconfig hci0 name again.

I am wondering if for some reason the suspend/resume actually does a HCI Reset without telling us. The name normally only gets reset to BCM20702A when doing a full reset.

Another possibility is that we actually forgot to set it in the first place. I am pretty sure I have intensively tested and that should not happen, but you might just found a corner case.

Regards

Marcel

