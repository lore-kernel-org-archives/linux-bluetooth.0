Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 0/4] Fix hci_dev ref-counts
Date: Fri, 28 Oct 2011 15:00:00 +0200
Message-Id: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

We currently have two reference counters for each hci_dev. This patchset tries
to reduce this to one ref-count and fix several bugs with them. The two
available ref-counts currently are:

1) hci_dev->dev internal
This ref-count is increased by hci_alloc_dev() and decreased inside
hci_free_dev(). No other code currently uses this refcount. It can be set with
get_device() and put_device().
When this ref-count drops zero, then the hci_dev structure is deallocated (see
bt_link_release inside hci_sysfs.c), hence, this ref-count is the most important
one. However, we currently do not use it correctly.

2) hci_dev->refcnt
This ref-count is used inside hci_dev_hold/put() and practically used as if it
would protect the hci_dev structure. However, if this ref-count drops zero, then
the ->destruct callback is called which is used by all drivers *exclusively* to
deallocate driver structures and *not* to deallocate or destroy the hci_dev.


Every driver calls hci_unregister_dev() and I see no reason why the drivers
shouldn't deallocate their structures after calling this function. Patch 0001
does exactly this by removing the "destruct" callback and make all drivers to
the cleanup after calling hci_unregister_dev()/hci_free_dev(). Some drivers
(erroneously) already do it this way.

Patch 0002 fixes a bug in hci_sysfs.c. We pass a callback with every
"struct device" that we create. However, a device is not bound to a module so
the device may continue living even though we already unloaded bluetooth.ko.
Hence, we take a reference to the bluetooth module on device-init and release it
on device-free.

Patch 0003 now completely removes the "owner" field of an hci_dev structure as
it is no longer bound to a module. Patch 0001 removed the "destruct" callback so
we have no reason to bind hci_dev's to modules anymore.

Patch 0004 finally removes the hci_dev->refcnt counter. This counter is totally
useless and we should use the hci_dev->dev internal counter instead.


Almost all other subsystems use the ref-counters this way so it would be quite
nice to have hci_dev also work this way. The diffstat also looks quite nice.
Funny thing is, that patch 0002 breaks the ref-count on my machine. If I load
btusb and unload it again, then the refcnt of bluetooth.ko is still 1 (it should
be 0). I couldn't find a bug in my patches so this seems to be an identification
that with our current implementation the hci_dev->refcnt never drops zero and
hence driver allocated structures are never freed. (rmmod -f ... still helps)
This can be easily traced down, I think, but I haven't done it, yet.

This is why I marked it as RFC. If someone could review the patches, I'd be
very happy.


Regards
David


David Herrmann (4):
  Bluetooth: Remove obsolete hci-destruct callback
  Bluetooth: Fix hci-sysfs ref-counts
  Bluetooth: Remove hci owner field
  Bluetooth: Correctly take device refcounts

 drivers/bluetooth/bfusb.c        |   13 +------------
 drivers/bluetooth/bluecard_cs.c  |    8 --------
 drivers/bluetooth/bpa10x.c       |   17 +++--------------
 drivers/bluetooth/bt3c_cs.c      |    8 --------
 drivers/bluetooth/btmrvl_main.c  |    6 ------
 drivers/bluetooth/btsdio.c       |   13 +------------
 drivers/bluetooth/btuart_cs.c    |    8 --------
 drivers/bluetooth/btusb.c        |   13 +------------
 drivers/bluetooth/btwilink.c     |   10 ----------
 drivers/bluetooth/dtl1_cs.c      |    8 --------
 drivers/bluetooth/hci_ldisc.c    |   13 +------------
 drivers/bluetooth/hci_vhci.c     |    9 +--------
 include/net/bluetooth/hci_core.h |   16 ++++------------
 net/bluetooth/hci_core.c         |   13 ++++++++-----
 net/bluetooth/hci_sysfs.c        |    8 +++++++-
 15 files changed, 27 insertions(+), 136 deletions(-)

-- 
1.7.7.1
