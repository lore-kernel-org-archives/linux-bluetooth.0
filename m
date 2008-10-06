Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez/git + 2.6.27-rc8 + Belkin F8T017 -> Can't read class of
	adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Stuart Pook <kernel6org@pook.es>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48EA7770.30307@pook.es>
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>
	 <48E3B3BF.6070205@pook.es>
	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>
	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>
	 <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>
	 <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>
	 <48EA7770.30307@pook.es>
Content-Type: text/plain
Date: Mon, 06 Oct 2008 22:45:44 +0200
Message-Id: <1223325944.11272.227.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

> > Why your application gives up prematurely is still unclear to me.
> 
> I must admit this what interests me most.
> 
> I wondered if it was by old USBBT100 Bluetooth dongle that is causing
> my problems. I thus bought a Belkin F8T017 (Bluetooth v2.1 Class I).
> It works even less than my old Linksys USBBT100.
> 
> bluetoothd (from git) says:
> 
> bluetoothd[3517]: HCI dev 0 up
> bluetoothd[3517]: Can't read class of adapter on /org/bluez/hci0: Input/output error (5)

loas btusb or hci_usb with reset=1 and show me the content
of /proc/bus/usb/devices to add a permanent quirk.

Regards

Marcel


