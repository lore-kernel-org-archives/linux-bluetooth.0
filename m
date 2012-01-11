Return-Path: <cyrus@holtmann.org>
Message-ID: <1326278147.6454.225.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0489:e031]
From: Marcel Holtmann <marcel@holtmann.org>
To: harv@gmx.de
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Jan 2012 11:35:47 +0100
In-Reply-To: <4F0D450F.3000600@gmx.de>
References: <4F0ACADF.1060906@cestona.ro>
	   <1326137984.6454.152.camel@aeonflux> <4F0BE4CB.30907@gmx.de>
	  <1326183061.6454.194.camel@aeonflux> <4F0C355E.5050609@gmx.de>
	 <1326214276.6454.212.camel@aeonflux> <4F0D450F.3000600@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harvey,

> > virtualbox and then running either usbmon or Wireshark on your Linux
> > system should work just fine.
> 
> O.K., here's what I found: running windows in virtualbox first then 
> shutting it down again: the adapter works in linux too until the next 
> reboot (still have to load the module and echo the ID to new_ID because 
> of the adapter not reconigzed by the actual bt module)
> Doing a capture with wireshark on usb port 2 gives me the capture file 
> attached.

so there is clearly some binary download in the capture file. It will
most likely match the files that a referenced in the .inf file. However
I am not reverse engineering this stuff for anybody. Someone else has to
do that job.

Regards

Marcel


