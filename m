Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RE: Question about role switch
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY1-DAV1776C899FF3D88A4F64F79AAAD0@phx.gbl>
References: <BAY1-DAV1776C899FF3D88A4F64F79AAAD0@phx.gbl>
Content-Type: text/plain
Message-Id: <1103187081.8717.30.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 16 Dec 2004 09:51:21 +0100

Hi Krishna,

this is not your thread.

>  > > Is there any way to do bi-directional Inquiry so that both the
> inquiring and
>  > >inquired (inquiry scanning) device/s get each others address and
> clock.
>  
> >  what do you want? You can"t get the address from the device that is
> > inquiring you. You have to inquiry by yourself.
>  
> Here is the situation: 
>  
> The host has two Bluetooth radios, 
> Radio1: listening to inquiring devices  
> Radio2: Connect or page devices (Inquiry is disabled on this one).
> Lots of Mobile Devices: Looking for connection with the host
>  
> Radio1 would listen to inquiries and somehow!!! after getting
> addresses of inquiring devices, would pass them onto Radio2, which
> would eventually page the devices to connect.  What I would like to
> have is the mobile devices looking for connection would initiate the
> inquiry but page would be initiated by Radio2 on the host. This would
> require Radio1 to know the address without doing inquiry (but only
> listening to inquiries)...  Is there any way possible to achieve this?
> Role switch attempt !? 

I think that I know what you are trying to do. This is not possible and
you should really read the specification and understand how Bluetooth
works.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
