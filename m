Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/8] Bluetooth LE 6LoWPAN using CoC
Date: Fri, 23 May 2014 12:27:20 +0300
Message-Id: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this v2 patchset moves the 6lowpan functionality from bluetooth.ko
module to a separate bluetooth_6lowpan.ko module. Patches #2, #3,
#7 and #8 are there to support this change.

Patch #1 refactors the l2cap socket handling so that we can deal with
normal memory buffers instead of struct msghdr buffers.

The address type and its relation to U/L bit in MAC address was
incorrect and it is fixed by patch #6.

Additional channel default values are set by patch #4 so that channel
API user does not need to set all of them separately.


Known issues:

If you have a 6lowpan connection so that there is bt0 device and
you have managed to transfer IPv6 packets between devices, then
if you disconnect bluetooth connection and unload the module, the
kernel will print this information

[ 6652.781151] sysfs group c1bbfdf0 not found for kobject 'tx-0'
[ 6652.800927] Modules linked in: bluetooth_6lowpan(-) 6lowpan_iphc rfcomm bnep nfc ecb btusb bluetooth rfkill parport_pc parport snd_intel8x0 snd_ac97_codec ac97_bus
...
[ 6652.958454] Call Trace:
[ 6652.959097]  [<c180e9a8>] dump_stack+0x4b/0x75
[ 6652.959931]  [<c104557e>] warn_slowpath_common+0x7e/0xa0
[ 6652.961600]  [<c11ae727>] ? sysfs_remove_group+0x87/0x90
[ 6652.962556]  [<c11ae727>] ? sysfs_remove_group+0x87/0x90
[ 6652.963507]  [<c10455d3>] warn_slowpath_fmt+0x33/0x40
[ 6652.964436]  [<c11ae727>] sysfs_remove_group+0x87/0x90
[ 6652.965368]  [<c171c3ab>] netdev_queue_update_kobjects+0xcb/0x140
[ 6652.966410]  [<c171c290>] ? net_rx_queue_update_kobjects+0xd0/0x120
[ 6652.967474]  [<c170ca5b>] ? dev_mc_flush+0x2b/0x30
[ 6652.968370]  [<c171c45e>] netdev_unregister_kobject+0x3e/0x60
[ 6652.969382]  [<c17044fe>] rollback_registered_many+0x18e/0x260
[ 6652.970842]  [<c108e1eb>] ? trace_hardirqs_on+0xb/0x10
[ 6652.971682]  [<c17045f8>] rollback_registered+0x28/0x40
[ 6652.972605]  [<c1705877>] unregister_netdevice_queue+0x47/0x80
[ 6652.973633]  [<c17058c9>] unregister_netdev+0x19/0x30
[ 6652.974569]  [<d0d96e96>] bt_6lowpan_cleanup+0xd0/0xf1 [bluetooth_6lowpan]
[ 6652.975715]  [<c181413d>] ? mutex_unlock+0xd/0x10
[ 6652.976553]  [<c10b8052>] SyS_delete_module+0x132/0x1c0
[ 6653.207496]  [<c181a6e0>] ? __do_page_fault+0x570/0x570
[ 6653.208447]  [<c1061a97>] ? task_work_run+0x97/0xb0
[ 6653.209344]  [<c1817418>] syscall_call+0x7/0xb
[ 6653.239854] ---[ end trace 220b56e4c36be0fe ]---
[ 6653.260995] ------------[ cut here ]------------...
...
[ 6653.101471] sysfs group c1ba7988 not found for kobject 'bt0'
...
[ 6653.396054] Call Trace:
[ 6653.400714]  [<c180e9a8>] dump_stack+0x4b/0x75
[ 6653.401621]  [<c104557e>] warn_slowpath_common+0x7e/0xa0
[ 6653.402588]  [<c11ae727>] ? sysfs_remove_group+0x87/0x90
[ 6653.403552]  [<c11ae727>] ? sysfs_remove_group+0x87/0x90
[ 6653.404515]  [<c10455d3>] warn_slowpath_fmt+0x33/0x40
[ 6653.405765]  [<c11ae727>] sysfs_remove_group+0x87/0x90
[ 6653.406588]  [<c11ae75a>] sysfs_remove_groups+0x2a/0x40
[ 6653.407536]  [<c14fae43>] device_remove_attrs+0x43/0x70
[ 6653.429816]  [<c14fb95d>] device_del+0xed/0x180
[ 6653.431629]  [<c171c470>] netdev_unregister_kobject+0x50/0x60
[ 6653.432703]  [<c17044fe>] rollback_registered_many+0x18e/0x260
[ 6653.433655]  [<c108e1eb>] ? trace_hardirqs_on+0xb/0x10
[ 6653.434592]  [<c17045f8>] rollback_registered+0x28/0x40
[ 6653.435535]  [<c1705877>] unregister_netdevice_queue+0x47/0x80
[ 6653.436552]  [<c17058c9>] unregister_netdev+0x19/0x30
[ 6653.437478]  [<d0d96e96>] bt_6lowpan_cleanup+0xd0/0xf1 [bluetooth_6lowpan]
[ 6653.438618]  [<c181413d>] ? mutex_unlock+0xd/0x10
[ 6653.439503]  [<c10b8052>] SyS_delete_module+0x132/0x1c0
[ 6653.446650]  [<c181a6e0>] ? __do_page_fault+0x570/0x570
[ 6653.450627]  [<c1061a97>] ? task_work_run+0x97/0xb0
[ 6653.451649]  [<c1817418>] syscall_call+0x7/0xb
[ 6653.463235] ---[ end trace 220b56e4c36be0ff ]---


The problem looks similar what is described in this bug report
https://bugzilla.kernel.org/show_bug.cgi?id=65281

I am investigating this issue.


Cheers,
Jukka


Jukka Rissanen (8):
  Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
  Bluetooth: Create callbacks for hci device creation and deletion
  Bluetooth: Create callbacks for hcon connect and disconnect
  Bluetooth: l2cap: Set more channel defaults
  Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed
    one
  Bluetooth: 6lowpan: Fix MAC address universal/local bit handling
  Bluetooth: 6LoWPAN: Create a kernel module
  Bluetooth: 6lowpan: Remove all 6lowpan network devices when module is
    unloaded

 include/net/bluetooth/hci.h      |   1 -
 include/net/bluetooth/hci_core.h |  53 +++
 include/net/bluetooth/l2cap.h    |   5 +-
 net/bluetooth/6lowpan.c          | 883 +++++++++++++++++++++++++++++----------
 net/bluetooth/6lowpan.h          |  47 ---
 net/bluetooth/Kconfig            |   6 +-
 net/bluetooth/Makefile           |   4 +-
 net/bluetooth/a2mp.c             |  12 +-
 net/bluetooth/hci_core.c         |  63 +--
 net/bluetooth/hci_event.c        |   6 +-
 net/bluetooth/l2cap_core.c       | 101 +++--
 net/bluetooth/l2cap_sock.c       |  14 +-
 12 files changed, 814 insertions(+), 381 deletions(-)
 delete mode 100644 net/bluetooth/6lowpan.h

-- 
1.8.3.1

