Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAND and RFCOMM simultaneously
From: Marcel Holtmann <marcel@holtmann.org>
To: Harald Meier <meh1@rts.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <003201c4161f$d37a2050$4000fe0a@rtsviec64>
References: <003201c4161f$d37a2050$4000fe0a@rtsviec64>
Content-Type: text/plain
Message-Id: <1080630888.4094.5.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 30 Mar 2004 09:14:48 +0200

Hi Harald,

> All PCs in the PAN are equipped with G+W Instruments PICO Bluetooth PCI
> Adapter (class 1).
> The Serial Devices are equipped with G+W Instruments Blue Serial Bluetooth
> Adapter.
> (www.gw-instruments.de)
> 
> The init script does the following:
> 
>         insmod bt-pci.o            # the driver for the BT-PCI card
>         insmod bluez.o
>         insmod hci_usb.o
>         insmod l2cap.o
>         insmod bnep.o
>        insmod rfcomm.o
> 
>         hcid
> 
>         sdpd
> 
>         pand --listen --role NAP                                         #
> on the NAP
>         pand --connect <BT-address-of-NAP> --persist    # in the PANU
> 
> The hcid.conf is attached (same for NAP and PANU).
> 
> When this is running, I get a "Function not implemented" if I try to connect
> to
> a different NAP (using pand) or if I try to establish a RFCOMM connection.

maybe your Bluetooth device don't support multiple connections. Show us
the output of "hciconfig -a".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
