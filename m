Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 00/18] Cleanup HCI reference counts
Date: Sat,  7 Jan 2012 15:47:06 +0100
Message-Id: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

This is the same as my previous patchset but split into sequential patches. The
first patch makes the destruct-cb optional so the patches 2-7 can remove the
empty callbacks.
Patches 8-14 make the remaining drivers drop the destruct-callback and directly
free the driver data.
Patches 15-18 then remove the (now unused!) destruct callback and then properly
fixes the reference counts (same patches as already posted).

I hope the first 14 patches make clear that half of our drivers already work
without the destruct callback and the other half can be safely converted into
not using it. In fact, the drivers that use it introduce some memleaks which are
fixed by simply dropping the callback and freeing everything right away.

I've added detailed commit messages to each driver. If a single step is unclear,
please point me to it.


By the way, this fixes several bugs we currently have, including some mem-leaks
as described in the commits and the fact that hci_free_dev() currently
*directly* destroys the hci object regardless of any previous calls to
hci_hold_dev/hci_put_dev(). This is because the hci->refcnt counter is in no way
linked to the lifetime of the hci object. See hci_sysfs the release_host
callback which actually frees the hci object. It is in no way triggered by
hci->refcnt.
This patchset fixes all this and introduces proper reference counting.

Cheers
David

David Herrmann (18):
  Bluetooth: Make hci-destruct callback optional
  Bluetooth: bluecard-cs: Remove empty destruct cb
  Bluetooth: bt3c-cs: Remove empty destruct cb
  Bluetooth: btmrvl: Remove empty destruct cb
  Bluetooth: btuart-cs: Remove empty destruct cb
  Bluetooth: btwilink: Remove empty destruct cb
  Bluetooth: dtl1-cs: Remove empty destruct cb
  Bluetooth: vhci: Free driver_data on file release
  Bluetooth: bfusb: Free driver_data on USB shutdown
  Bluetooth: btusb: Free driver data on USB shutdown
  Bluetooth: bpa10x: Free private driver data on usb shutdown
  Bluetooth: btsdio: Free driver data on SDIO shutdown
  Bluetooth: uart-ldisc: Fix memory leak and remove destruct cb
  Bluetooth: Remove unused hci-destruct cb
  Bluetooth: Correctly acquire module ref
  Bluetooth: Remove HCI-owner field
  Bluetooth: Correctly take hci_dev->dev refcount
  Bluetooth: Remove __hci_dev_put/hold

 drivers/bluetooth/bfusb.c        |   13 +------------
 drivers/bluetooth/bluecard_cs.c  |    8 --------
 drivers/bluetooth/bpa10x.c       |   17 +++--------------
 drivers/bluetooth/bt3c_cs.c      |    8 --------
 drivers/bluetooth/btmrvl_main.c  |    6 ------
 drivers/bluetooth/btsdio.c       |   13 +------------
 drivers/bluetooth/btuart_cs.c    |    8 --------
 drivers/bluetooth/btusb.c        |   17 +++--------------
 drivers/bluetooth/btwilink.c     |   10 ----------
 drivers/bluetooth/dtl1_cs.c      |    8 --------
 drivers/bluetooth/hci_ldisc.c    |   14 ++------------
 drivers/bluetooth/hci_vhci.c     |    9 +--------
 include/net/bluetooth/hci_core.h |   28 ++++------------------------
 net/bluetooth/hci_core.c         |    9 ++++-----
 net/bluetooth/hci_sysfs.c        |    2 ++
 15 files changed, 21 insertions(+), 149 deletions(-)

-- 
1.7.8.1
