Return-Path: <jjjessen@control.auc.dk>
Date: Tue, 16 Sep 2003 16:02:43 +0200 (MEST)
From: "Jan J. Jessen" <jjjessen@control.auc.dk>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Digianswer USB driver
In-Reply-To: <1062202301.11258.19.camel@pegasus>
Message-ID: <Pine.GSO.4.40.0309161558370.18622-100000@prosit.control.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,
I've now tried the patch and compiled a new kernel with hci_usb as a
module.
When I load it into the kernel I get the following:

# insmod /lib/modules/2.4.22/kernel/drivers/bluetooth/hci_usb.o
/lib/modules/2.4.22/kernel/drivers/bluetooth/hci_usb.o: unresolved symbol
hci_register_dev_Rsmp_17de4405
/lib/modules/2.4.22/kernel/drivers/bluetooth/hci_usb.o: unresolved symbol
hci_unregister_dev_Rsmp_380d73d1
/lib/modules/2.4.22/kernel/drivers/bluetooth/hci_usb.o: unresolved symbol
hci_recv_frame_Rsmp_75250b00

I've used a "fresh" 2.4.22 kernel

regards
Jan Jakob


On 30 Aug 2003, Marcel Holtmann wrote:

> Hi Jan,
>
> attached is a patch which modifies the hci_usb.o driver to deal with
> normal H:2 and the Digianswer devices. Please test it and send me a
> report with "hciconfig -a" and "cat /proc/bus/usb/devices".
>
> Regards
>
> Marcel
