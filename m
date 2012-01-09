Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jan 2012 13:44:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org
Subject: Re: [PATCH 00/18] Cleanup HCI reference counts
Message-ID: <20120109114417.GA31957@x220>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sat, Jan 07, 2012, David Herrmann wrote:
> David Herrmann (18):
>   Bluetooth: Make hci-destruct callback optional
>   Bluetooth: bluecard-cs: Remove empty destruct cb
>   Bluetooth: bt3c-cs: Remove empty destruct cb
>   Bluetooth: btmrvl: Remove empty destruct cb
>   Bluetooth: btuart-cs: Remove empty destruct cb
>   Bluetooth: btwilink: Remove empty destruct cb
>   Bluetooth: dtl1-cs: Remove empty destruct cb
>   Bluetooth: vhci: Free driver_data on file release
>   Bluetooth: bfusb: Free driver_data on USB shutdown
>   Bluetooth: btusb: Free driver data on USB shutdown
>   Bluetooth: bpa10x: Free private driver data on usb shutdown
>   Bluetooth: btsdio: Free driver data on SDIO shutdown
>   Bluetooth: uart-ldisc: Fix memory leak and remove destruct cb
>   Bluetooth: Remove unused hci-destruct cb
>   Bluetooth: Correctly acquire module ref
>   Bluetooth: Remove HCI-owner field
>   Bluetooth: Correctly take hci_dev->dev refcount
>   Bluetooth: Remove __hci_dev_put/hold
> 
>  drivers/bluetooth/bfusb.c        |   13 +------------
>  drivers/bluetooth/bluecard_cs.c  |    8 --------
>  drivers/bluetooth/bpa10x.c       |   17 +++--------------
>  drivers/bluetooth/bt3c_cs.c      |    8 --------
>  drivers/bluetooth/btmrvl_main.c  |    6 ------
>  drivers/bluetooth/btsdio.c       |   13 +------------
>  drivers/bluetooth/btuart_cs.c    |    8 --------
>  drivers/bluetooth/btusb.c        |   17 +++--------------
>  drivers/bluetooth/btwilink.c     |   10 ----------
>  drivers/bluetooth/dtl1_cs.c      |    8 --------
>  drivers/bluetooth/hci_ldisc.c    |   14 ++------------
>  drivers/bluetooth/hci_vhci.c     |    9 +--------
>  include/net/bluetooth/hci_core.h |   28 ++++------------------------
>  net/bluetooth/hci_core.c         |    9 ++++-----
>  net/bluetooth/hci_sysfs.c        |    2 ++
>  15 files changed, 21 insertions(+), 149 deletions(-)

All of these patches have been applied to my bluetooth-next tree. In the
future please adjust your editor settings so that your commit message
lines aren't longer than 72 characters. The message should be fully
visible with git log (which indents the messages) on a 80-wide terminal
I ended up fixing the messages manually this time.

Johan
