Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Max Krasnyansky <maxk@qualcomm.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F30D726.5030907@superbug.demon.co.uk>
References: 
	<5.1.0.14.2.20030805101803.0c38f768@unixmail.qualcomm.com>	<1060121840.935.2
	 5.camel@pegasus>  <3F3037A3.3000003@superbug.demon.co.uk>
	<1060159313.962.58.camel@pegasus>  <3F30D726.5030907@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1060168048.935.69.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 06 Aug 2003 13:07:21 +0200

Hi James,

> >>To this end, I think it would be helpful to separate INT and BULK 
> >>traffic from SCO traffic.
> >>SCO is realtime, INT and BULK are not, so they require different buffer 
> >>handling.
> >>To this end, INT and BULK work well with queues, and SCO are better 
> >>suited to ring buffers.
> > 
> > 
> > This is not quite correct. The hci_usb driver and the HCI core have to
> > handle SCO traffic, but they don't have to know much about it. It is a
> > packet type which have to be send and received. Nothing more, nothing
> > less. The hci_usb driver uses ISOC endpoints to transfer SCO packets and
> > BULK endpoints to transfer ACL packets. All other buffering which is
> > needing have to be done in the sco module.
> > 
> > May I have to repeat myself - let us first finish the hci_usb driver
> > with full SCO support. Max has agreed on my core change and I will push
> > it for 2.4 and 2.5/2.6, so the hci_usb driver can be fixed very easy.
> 
> I think you will find out later that SCO traffic needs a bit more than 
> just packet send/receive. But I guess that I can add those features once 
> you have fixed your stuff in hci_usb on kernel 2.6.

I already know that SCO traffic needs a bit more than that, but not in
the HCI host drivers. Maybe we have to modify the HCI core for better
SCO support, but there is no need to push SCO buffering or anything else
into the driver. The driver is not meant for any other logic than
transporting HCI packets from the hardware to the HCI core and vice
versa. All drivers uses some kind of queuing, but this should not be a
problem, because it is only for serializing the HCI packets, before they
are send to the hardware.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
