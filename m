Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Oct 2014 10:09:40 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkv+bu23Fm_thq7A5AOrCEXaaWmcKNaX-193GqFh=W0S8xA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1410161007340.1316-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 16 Oct 2014, Naveen Kumar Parna wrote:

> > Indeed. However, it is possible to use an additional in between your
> > devices and the internal hub.
> >
> >         Regards
> >                 Oliver
> >
> >
> 
> 
> Tested with this configuration(external hubs Dev 3, Dev 4, Dev 17, Dev
> 10) and got the same result.
> 
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
> 
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
> 
>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
> 
>         |__ Port 5: Dev 3, If 0, Class=hub, Driver=hub/7p, 12M
> 
>             |__ Port 1: Dev 4, If 0, Class=hub, Driver=hub/7p, 12M

This is not what Oliver meant.  You have to use a USB-2 hub.  And 
having one of them is enough; you don't need two.

Alan Stern

