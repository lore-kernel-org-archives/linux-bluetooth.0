Return-Path: <cyrus@holtmann.org>
Subject: Re: use of hci_recv_fragment in HCI UART transport driver
From: Marcel Holtmann <marcel@holtmann.org>
To: suraj <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Luis.Rodriguez@Atheros.com,
	Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1274416666.28388.29.camel@atheros013-desktop>
References: <1274416666.28388.29.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 May 2010 09:33:02 +0200
Message-ID: <1274427182.27220.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> The function "hci_recv_fragment()" was designed to avoid messy Bluetooth Rx packet reassembly on the HCI transport driver.
> It does work well for HCI USB transport driver but it becomes a bit redundant when used on HCI UART transport driver.
> 
> This is basically due to the fact that the function require the caller to provide the HCI Packet type as input parameter.
> 
> This is pretty straight forward for a BT USB transport driver as both ACL data and HCI events are received through different callbacks.
> Which means you will have 2 calls of hci_recv_fragment(). One with HCI_EVENT_PKT as packet type and other with HCI_ACLDATA_PKT, with packet type hard coded.
> 
> As far as HCI UART transport driver is concerned, it does not have this luxury. Both event and data are received through the same callback.
> So, if the driver has to provide the packet type as input to  hci_recv_fragment(), it will have to parse the HCI Rx data to get it in the first place.
>  
> This means driver will have to do everything hci_recv_fragment() does minus the memcpy, implementing the same messy code.
> 
> I know that we should be able to work around it by checking whether which reassembly buffer is not null and so on. But this is just a hack not a solution.

I remember why I added the packet type to the function. The reason is
that events and ACL packets arrive on different USB endpoints and in
theory they can arrive at exactly the same time or intermix with each
other. So that needs to be protected.

So I think we need something like hci_recv_packet_fragment and
hci_recv_stream_fragment.

This would result at least in that we can consolidate all this code
duplication in the Bluetooth core.

> The second reason is, hci_recv_fragment() implements a certain policy on the driver i.e 
> 
> " Whenever HCI Rx data is reassembled it directly has to be sent to host, without the driver interfering".
> 
> This robs the driver a chance have a look at the HCI event and do some housekeeping (it is entirely up to the driver what he wants to do then).
> 
> This is the one reason why someone would write a custom HCI transport driver protocol. 
> Other ways he could have used the standard H4 implementation if he just wanted to transfer packets to and from Host.

This is actually fully on purpose. A driver should not interfere with
HCI event or commands for that matter at all. It should be just a pure
transport.

If we need to hook something into vendor command/event handling then we
should find a different way in doing this. The major job of a HCI driver
is to be a pure, simple and stupid transport driver.

Regards

Marcel


