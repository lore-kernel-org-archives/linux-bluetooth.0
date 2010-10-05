Return-Path: <cyrus@holtmann.org>
Subject: Re: New Broadcom chip in W510
From: Marcel Holtmann <marcel@holtmann.org>
To: Lu Ran <hephooey@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <201010050754.18704.hephooey@gmail.com>
References: <201009190926.51131.hephooey@gmail.com>
	 <1286271048.17473.66.camel@aeonflux>
	 <201010050754.18704.hephooey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 14:13:59 +0200
Message-ID: <1286280839.17473.90.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lu,

> > can you show me the content of /proc/bus/usb/devices (or usbdevices.sh)
> > for that device.
> 
> I put the output ot "cat /proc/bus/usb/devices" in the attachment, I am pretty 
> sure the setup of my software is OK, because now I can use my bluetooth 
> headset with an dongle, but it does not work for the internal chip.

maybe that hardware has some limitations that are unclear to me. Can you
run hcidump -X -V and give us the output when trying to establish a SCO
connection.

Regards

Marcel


