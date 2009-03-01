Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth radio =?ISO-8859-1?Q?doesn=B4t?= reply to inquiry
 request
From: Marcel Holtmann <marcel@holtmann.org>
To: Carles Cufi <carles.cufi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <D97BBDAF-F830-4495-B1CC-B56C5C235E72@gmail.com>
References: <aa4f458e0903010445j49d07c26j144210cb099540de@mail.gmail.com>
	 <1235931668.6074.47.camel@localhost.localdomain>
	 <D97BBDAF-F830-4495-B1CC-B56C5C235E72@gmail.com>
Content-Type: text/plain
Date: Mon, 02 Mar 2009 00:55:58 +0100
Message-Id: <1235951758.6074.49.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carles,

> > why don't you use periodic inquiry instead and let the controller  
> > handle
> > the timing.
> >
> 
> Because the specific bit I am working on is a C++ library capable of  
> doing (among other things) asynchronous discovery while avoiding any  
> intermediate caches (that's why I don't use the D-Bus interface or the  
> ioctl call) and I do not have control over the periodicity of the  
> inquiry nor know when it is going to be cancelled or started again.  
> The API requirements were to provide an fast, not cached inquiry that  
> can be started and cancelled at will by the application.
> Having examined the logs the amount of inquiry requests I am sending  
> is fairly low (every 30 seconds or so) and so I thought it wouldn't be  
> a problem for the HCI or USB layers to handle in terms of data volume.

do me favor and read the Bluetooth specification, because periodic
inquiry is a low-level HCI command.

> > Also should try the bluetooth-testing.git tree since it contains an
> > updated btusb.ko driver.
> 
> I will try it and let you know about the results.
> Does this imply that it looks like a problem in the btusb driver? The  
> only other explanations that occurred me until now were:

With btusb we were trying to send as less URBs as possible, but it could
be that not having bulk URB running the chips behave funny. At least
that is what we have seen with some hardware. So that could be an issue
here. Nobody knows for sure.

Regards

Marcel


