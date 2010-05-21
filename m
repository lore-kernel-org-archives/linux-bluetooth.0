Return-Path: <cyrus@holtmann.org>
Subject: use of hci_recv_fragment in HCI UART transport driver
From: suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <Luis.Rodriguez@Atheros.com>,
	<Jothikumar.Mothilal@Atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 May 2010 10:07:46 +0530
Message-ID: <1274416666.28388.29.camel@atheros013-desktop>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The function "hci_recv_fragment()" was designed to avoid messy Bluetooth Rx packet reassembly on the HCI transport driver.
It does work well for HCI USB transport driver but it becomes a bit redundant when used on HCI UART transport driver.

This is basically due to the fact that the function require the caller to provide the HCI Packet type as input parameter.

This is pretty straight forward for a BT USB transport driver as both ACL data and HCI events are received through different callbacks.
Which means you will have 2 calls of hci_recv_fragment(). One with HCI_EVENT_PKT as packet type and other with HCI_ACLDATA_PKT, with packet type hard coded.

As far as HCI UART transport driver is concerned, it does not have this luxury. Both event and data are received through the same callback.
So, if the driver has to provide the packet type as input to  hci_recv_fragment(), it will have to parse the HCI Rx data to get it in the first place.
 
This means driver will have to do everything hci_recv_fragment() does minus the memcpy, implementing the same messy code.

I know that we should be able to work around it by checking whether which reassembly buffer is not null and so on. But this is just a hack not a solution.


The second reason is, hci_recv_fragment() implements a certain policy on the driver i.e 

" Whenever HCI Rx data is reassembled it directly has to be sent to host, without the driver interfering".

This robs the driver a chance have a look at the HCI event and do some housekeeping (it is entirely up to the driver what he wants to do then).

This is the one reason why someone would write a custom HCI transport driver protocol. 
Other ways he could have used the standard H4 implementation if he just wanted to transfer packets to and from Host.


Please provide your comments.

Regards
Suraj
