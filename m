Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_cmd_task: hci0 command tx timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.33.0502151510240.1694-100000@horus.imag.fr>
References: <Pine.GSO.4.33.0502151510240.1694-100000@horus.imag.fr>
Content-Type: text/plain
Message-Id: <1109028409.7626.48.camel@pegasus>
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
Date: Tue, 22 Feb 2005 00:26:49 +0100

Hi Catalin,

> While using a COM One Bluetooth USB dongle, after a random
> amount of time, the device becomes unresponsive (no HCI
> commands are accepted). The only solution is to physically
> remove the dongle and re-insert it.
> 
> The system is Fedora Core 3, kernel version 2.6.10-1.741_FC3.
> 
> These are the relevant messages from /var/log/messages:
> 
> Feb 15 14:20:22 corse kernel: usb 2-2: new full speed USB device using
> uhci_hcd and address 7
> Feb 15 14:22:02 corse kernel: hci_cmd_task: hci0 command tx timeout
> 
> Also, here is the output of hcidump -i hci0 -x before the crash occurs:
> 
> > HCI Event: Connect Complete (0x03) plen 11
>   00 28 00 3E 17 39 EE 02 00 01 00
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 4097 scid 0x0041
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 4097 scid 0x0040
> < HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>   28 00 13
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
>   00
> 
> As you can see the last three commands get no answers.
> 
> Here's (the relevant parts of) the output of lsmod:
> 
> Module                  Size  Used by
> dtl1_cs                11845  3
> l2cap                  26053  3
> pcmcia                 20805  5 dtl1_cs
> dm_mod                 55509  0
> ac                      4805  0
> joydev                  9217  0
> hci_usb                15041  3
> bluetooth              48069  7 dtl1_cs,l2cap,hci_usb
> yenta_socket           19137  1
> pcmcia_core            50817  3 dtl1_cs,pcmcia,yenta_socket
> uhci_hcd               31321  0
> hw_random               5717  0
> 
> I have read that this behavior might be caused by the loss of
> syncronization between the host and the device. Is there any way to fix this?

show us the content of /proc/bus/usb/devices and you should try to load
the hci_usb driver with isoc=0 to disable the ISOC transfers. What does
lspci say about your USB host controller?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
