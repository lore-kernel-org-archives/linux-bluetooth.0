Return-Path: <cyrus@holtmann.org>
Subject: Re: Support for 0489:e031 Foxconn / Hon Hai
From: Marcel Holtmann <marcel@holtmann.org>
To: thilo@cestona.ro
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 02 Jun 2011 03:03:25 +0200
In-Reply-To: <ab01e70.1c463c971db970bc2f7804c43e6bf946@1oca1host.de>
References: <ab01e70.1c463c971db970bc2f7804c43e6bf946@1oca1host.de>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1306976606.7131.0.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thilo,

> I got a new laptop and as usual new hardware has devices which aren't supported.
> In this case, it is the bluetooth adapter of the Fujitsu Lifebook E751. 
> 
> I have attached the lsusb -v output corresponding the adapter.
> 
> Can someone please tell me, which information are also needed so support can be implemented?
> 
> Should I contact Foxconn (or Broadcom) if they have a public spec?
> 
> As it is a internal usb bluetooth adapter might it be enough to add the ID to btusb.c? (didn't work so far ;) )

what about the usb-devices.sh script output or /proc/bus/usb/devices
content for this adatper.

Regards

Marcel


