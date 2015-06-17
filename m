Return-Path: <cyrus@holtmann.org>
From: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
To: <marcel@holtmann.org>
CC: <jukka.rissanen@linux.intel.com>, <lukasz.duda@nordicsemi.no>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH 0/5] Improving bluetooth 6lowpan cleanup & module unloading
Date: Wed, 17 Jun 2015 07:32:22 -0700
Message-ID: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

First a big thank you for all the great effort on the 6lowpan bluetooth
module! As a company providing 6lowpan enabled bluetooth devices this module
has been extremly important to us in order to show the technology.

As a user of the module some issues have been seen when the USB hci
device has been restarted (crash or dongle removed) while in a 6lowpan
connection. A set of patches has been created in order to improve the
creation/removal of the netdev, created in the bluetooth 6lowpan module.
A more predictable netdev is quite useful for scripts and daemons depending
on a specific device name.


The set of patches:

 - Patch #1 enables scheduling of delete_netdev when the last 6lowpan 
   peer has been removed.

 - Patch #2 renames the variable used in patch #1 in order to trigger 
   the schedule of the delete_netdev.

 - Patch #3 moves the sysfs device from the the device of the first
   connected 6lowpan device to the hci device. This enables sysfs to 
   locate and remove all the netdev sysfs entries associated with the 
   netdev. This also fixes the known issue reported: 
   http://www.spinics.net/lists/linux-bluetooth/msg48455.html

 - Patch #4 removes a double kfree of the netdev priv.

 - Patch #5 removes an additional module_put() which causes the module 
   refcount to underflow. Any attempt on unloading the module after this
   causes a seg.fault.

Testing 
=======

The patches has been tested on Ubuntu and Raspian (Raspberry Pi) using the 
bluetooth-next branch. A quick way of testing the cleanup proceedures is 
to remove the bluetooth USB dongle while in a connection. 


Description of patch #1
=======================

This patch fixes an issue with the netdev not being unregistered when 
the last peer is deleted. Removing the logical negation operator on the 
boolean solves this issue. If the last peer is removed the condition 
will be true, and the delete_netdev() is scheduled.

Problem: 

The "removed" flag is set to true by default, but the variable has to be 
set to false in order to schedule the delete_netdev work. The condition 
is always false because chan->conn is NULL on the l2cap channel 
disconnections.

Also, if the link goes down ungracefully for example by unplugging the 
dongle (usb reset), the bt0 is never removed, and the next 6lowpan 
connection will make a new netdev bt1. If normal disconnects are performed
the initial netdev is never removed.

SystemTap log before applying the patch:
     0 kworker/u17:0(61):  -> l2cap_chan_no_teardown
     5 kworker/u17:0(61):  <- l2cap_chan_no_teardown
     0 kworker/u17:0(61):  -> chan_close_cb
    10 kworker/u17:0(61):    -> ifdown
    13 kworker/u17:0(61):    <- ifdown
    14 kworker/u17:0(61):  <- chan_close_cb

SystemTap log after applying the patch:
     0 kworker/u17:0(61):  -> l2cap_chan_no_teardown
     8 kworker/u17:0(61):  <- l2cap_chan_no_teardown
     0 kworker/u17:0(61):  -> chan_close_cb
    31 kworker/u17:0(61):    -> ifdown
    39 kworker/u17:0(61):    <- ifdown
    45 kworker/u17:0(61):  <- chan_close_cb
     0 kworker/0:1(19579):  -> delete_netdev
    14 kworker/0:1(19579):    -> unregister_netdev
    20 kworker/0:1(19579):      -> unregister_netdevice_queue
   785 kworker/0:1(19579):        -> unregister_netdevice_many
   795 kworker/0:1(19579):        <- unregister_netdevice_many
   906 kworker/0:1(19579):        -> device_event
  1121 kworker/0:1(19579):        <- device_event
  3368 kworker/0:1(19579):      <- unregister_netdevice_queue
 45875 kworker/0:1(19579):      -> device_event
 45881 kworker/0:1(19579):      <- device_event
 46280 kworker/0:1(19579):    <- unregister_netdev
 46283 kworker/0:1(19579):  <- delete_netdev


Description of patch #2
=======================
After the change of logic in patch #1, renaming the variable used to
trigger the scheduling of the delete_netdev felt right.


Description of patch #3
=======================

This patch moves the sysfs device used by the netdev from the device of 
the first connected peer to the hci sysfs device. Using the sysfs device
of hci instead of the first connected device fixes this issue such that 
the sysfs group of tx-0 and bt0 kobject are still present after the last
peer has been deleted and all sysfs entries can be removed.

Problem: 

When the first 6lowpan connection is created, the netdev will be set up 
using the sysfs device of this peer. When the last peer is disconnected 
and unregister_netdev() is called, it will not be able to locate the sysfs
entries of tx-0 and bt0 as the symlink from /sys/class/net/bt0 has been 
broken. Because of this broken reference the sysfs group for bt0 and tx-0
cannot be properly removed.

The test described below depends on unregister_netdev to be triggered 
which means patch #1 should have been included.

Test:

 1. Create 2 6lowpan connections:
    - The first connected device got handle #64
    - The second connected device got handle #65

    /sys/class/net/bt0 is now pointing to the sysfs device of the first
    connected peer:
    lrwxrwxrwx  1 root root 0 juni  15 16:56 bt0 -> ../../devices/pci0000:00/0000:00:1d.0/usb6/6-2/6-2:1.0/bluetooth/hci0/hci0:64/net/bt0

 2. Disconnect the first peer.
    /sys/class/net/bt0 is still pointing to the /hci0:64/net/bt0 with a 
    broken link as the device has been removed.

 3. When disconnecting the last peer sysfs is not able to locate the sysfs 
    group for bt0 and tx-0 which can be seen in the syslog:

[  467.005987] ------------[ cut here ]------------
[  467.005991] WARNING: CPU: 1 PID: 32 at fs/sysfs/group.c:224 sysfs_remove_group+0x8e/0x90()
[  467.005993] sysfs group c1a81208 not found for kobject 'tx-0'
...
[  467.006028] CPU: 1 PID: 32 Comm: kworker/1:1 Tainted: G    B      OE   4.1.0-rc4+ #2
[  467.006030] Hardware name: ...
[  467.006032] Workqueue: events delete_netdev [bluetooth_6lowpan]
[  467.006033]  00000000 00000000 f4533dcc c16f4868 f4533e10 f4533e00 c10643cb c1917860
[  467.006037]  f4533e2c 00000020 c1925634 000000e0 c1216bae 000000e0 c1216bae 00000000
[  467.006041]  c1a81208 f2f9881c f4533e18 c1064433 00000009 f4533e10 c1917860 f4533e2c
[  467.006045] Call Trace:
[  467.006047]  [<c16f4868>] dump_stack+0x41/0x52
[  467.006050]  [<c10643cb>] warn_slowpath_common+0x8b/0xc0
[  467.006052]  [<c1216bae>] ? sysfs_remove_group+0x8e/0x90
[  467.006054]  [<c1216bae>] ? sysfs_remove_group+0x8e/0x90
[  467.006056]  [<c1064433>] warn_slowpath_fmt+0x33/0x40
[  467.006058]  [<c1216bae>] sysfs_remove_group+0x8e/0x90
[  467.006061]  [<c161ca73>] netdev_queue_update_kobjects+0xd3/0x140
[  467.006063]  [<c161c950>] ? net_rx_queue_update_kobjects+0xd0/0x120
[  467.006065]  [<c162f8ee>] ? nlmsg_notify+0xde/0xf0
[  467.006067]  [<c161cb1e>] netdev_unregister_kobject+0x3e/0x60
[  467.006069]  [<c15fff73>] rollback_registered_many+0x1a3/0x2d0
[  467.006071]  [<c16000c4>] rollback_registered+0x24/0x40
[  467.006073]  [<c16007bf>] unregister_netdevice_queue+0x4f/0xc0
[  467.006075]  [<c16f80c0>] ? mutex_lock+0x10/0x30
[  467.006077]  [<c1600849>] unregister_netdev+0x19/0x30
[  467.006079]  [<f87264f0>] delete_netdev+0x10/0x20 [bluetooth_6lowpan]
[  467.006082]  [<c107a822>] process_one_work+0x122/0x3c0
[  467.006084]  [<c107b1f9>] worker_thread+0x39/0x4e0
[  467.006086]  [<c107b1c0>] ? rescuer_thread+0x320/0x320
[  467.006087]  [<c107f71b>] kthread+0x9b/0xb0
[  467.006089]  [<c16fa881>] ret_from_kernel_thread+0x21/0x30
[  467.006091]  [<c107f680>] ? kthread_create_on_node+0x110/0x110
[  467.006093] ---[ end trace 677f3b617d14804a ]---
[  467.006195] ------------[ cut here ]------------
[  467.006197] WARNING: CPU: 1 PID: 32 at fs/sysfs/group.c:224 sysfs_remove_group+0x8e/0x90()
[  467.006199] sysfs group c1a64008 not found for kobject 'bt0'
...
[  467.006232] CPU: 1 PID: 32 Comm: kworker/1:1 Tainted: G    B   W  OE   4.1.0-rc4+ #2
[  467.006234] Hardware name: ...
[  467.006236] Workqueue: events delete_netdev [bluetooth_6lowpan]
[  467.006237]  00000000 00000000 f4533dbc c16f4868 f4533e00 f4533df0 c10643cb c1917860
[  467.006241]  f4533e1c 00000020 c1925634 000000e0 c1216bae 000000e0 c1216bae 00000000
[  467.006245]  c1a64008 f105f3d0 f4533e08 c1064433 00000009 f4533e00 c1917860 f4533e1c
[  467.006249] Call Trace:
[  467.006251]  [<c16f4868>] dump_stack+0x41/0x52
[  467.006253]  [<c10643cb>] warn_slowpath_common+0x8b/0xc0
[  467.006255]  [<c1216bae>] ? sysfs_remove_group+0x8e/0x90
[  467.006257]  [<c1216bae>] ? sysfs_remove_group+0x8e/0x90
[  467.006259]  [<c1064433>] warn_slowpath_fmt+0x33/0x40
[  467.006261]  [<c1216bae>] sysfs_remove_group+0x8e/0x90
[  467.006264]  [<c1478fb6>] dpm_sysfs_remove+0x46/0x50
[  467.006267]  [<c146e1af>] device_del+0x3f/0x210
[  467.006269]  [<c146de1d>] ? device_for_each_child+0x4d/0x70
[  467.006271]  [<c147ab42>] ? pm_runtime_set_memalloc_noio+0xa2/0xe0
[  467.006273]  [<c161cb39>] netdev_unregister_kobject+0x59/0x60
[  467.006275]  [<c15fff73>] rollback_registered_many+0x1a3/0x2d0
[  467.006277]  [<c16000c4>] rollback_registered+0x24/0x40
[  467.006279]  [<c16007bf>] unregister_netdevice_queue+0x4f/0xc0
[  467.006281]  [<c16f80c0>] ? mutex_lock+0x10/0x30
[  467.006283]  [<c1600849>] unregister_netdev+0x19/0x30
[  467.006285]  [<f87264f0>] delete_netdev+0x10/0x20 [bluetooth_6lowpan]
[  467.006288]  [<c107a822>] process_one_work+0x122/0x3c0
[  467.006290]  [<c107b1f9>] worker_thread+0x39/0x4e0
[  467.006292]  [<c107b1c0>] ? rescuer_thread+0x320/0x320
[  467.006294]  [<c107f71b>] kthread+0x9b/0xb0
[  467.006296]  [<c16fa881>] ret_from_kernel_thread+0x21/0x30
[  467.006297]  [<c107f680>] ? kthread_create_on_node+0x110/0x110
[  467.006299] ---[ end trace 677f3b617d14804b ]---
[  467.006303] ------------[ cut here ]------------
[  467.006306] WARNING: CPU: 1 PID: 32 at fs/sysfs/group.c:224 sysfs_remove_group+0x8e/0x90()
[  467.006307] sysfs group c1a812f0 not found for kobject 'bt0'
...
[  467.006340] CPU: 1 PID: 32 Comm: kworker/1:1 Tainted: G    B   W  OE   4.1.0-rc4+ #2
[  467.006342] Hardware name: ...
[  467.006344] Workqueue: events delete_netdev [bluetooth_6lowpan]
[  467.006345]  00000000 00000000 f4533da4 c16f4868 f4533de8 f4533dd8 c10643cb c1917860
[  467.006349]  f4533e04 00000020 c1925634 000000e0 c1216bae 000000e0 c1216bae 00000000
[  467.006353]  c1a812f0 f105f3d0 f4533df0 c1064433 00000009 f4533de8 c1917860 f4533e04
[  467.006357] Call Trace:
[  467.006359]  [<c16f4868>] dump_stack+0x41/0x52
[  467.006361]  [<c10643cb>] warn_slowpath_common+0x8b/0xc0
[  467.006363]  [<c1216bae>] ? sysfs_remove_group+0x8e/0x90
[  467.006365]  [<c1216bae>] ? sysfs_remove_group+0x8e/0x90
[  467.006367]  [<c1064433>] warn_slowpath_fmt+0x33/0x40
[  467.006369]  [<c1216bae>] sysfs_remove_group+0x8e/0x90
[  467.006371]  [<c1216c5a>] sysfs_remove_groups+0x2a/0x40
[  467.006373]  [<c146d9a3>] device_remove_attrs+0x43/0x70
[  467.006375]  [<c146e265>] device_del+0xf5/0x210
[  467.006377]  [<c146de1d>] ? device_for_each_child+0x4d/0x70
[  467.006379]  [<c147ab42>] ? pm_runtime_set_memalloc_noio+0xa2/0xe0
[  467.006381]  [<c161cb39>] netdev_unregister_kobject+0x59/0x60
[  467.006383]  [<c15fff73>] rollback_registered_many+0x1a3/0x2d0
[  467.006385]  [<c16000c4>] rollback_registered+0x24/0x40
[  467.006387]  [<c16007bf>] unregister_netdevice_queue+0x4f/0xc0
[  467.006389]  [<c16f80c0>] ? mutex_lock+0x10/0x30
[  467.006391]  [<c1600849>] unregister_netdev+0x19/0x30
[  467.006393]  [<f87264f0>] delete_netdev+0x10/0x20 [bluetooth_6lowpan]
[  467.006395]  [<c107a822>] process_one_work+0x122/0x3c0
[  467.006397]  [<c107b1f9>] worker_thread+0x39/0x4e0
[  467.006399]  [<c107b1c0>] ? rescuer_thread+0x320/0x320
[  467.006401]  [<c107f71b>] kthread+0x9b/0xb0
[  467.006403]  [<c16fa881>] ret_from_kernel_thread+0x21/0x30
[  467.006405]  [<c107f680>] ? kthread_create_on_node+0x110/0x110
[  467.006406] ---[ end trace 677f3b617d14804c ]---

After applying the patch the errors are gone and the sysfs reference is 
pointing to the hci device instead of the device of the first connected 
peer:
lrwxrwxrwx  1 root root 0 juni  15 17:24 bt0 -> ../../devices/pci0000:00/0000:00:1d.0/usb6/6-2/6-2:1.0/bluetooth/hci0/net/bt0


Description of patch #4
=======================

This patch removes the kfree of the netdev priv in device_event() upon
NETDEV_UNREGISTER event. The freeing of netdev priv memory is taken care 
of by the netdev destructor.

Problem: 

When device_event() is called the first time (NETDEV_UNREGISTER) the priv 
of the netdev will be kfree'd. It is also scheduled to be deleted through
the netdev destructor. The destructor function will attempt to free the 
same memory a second time. As kfree of the netdev priv is handled by the 
netdev destructor the kfree in device_event should not be done.

Test:

 1. Create one connection.
 2. Disconnect the connection (implies that patch #1 is included in order
    to trigger unregister_netdev).

    The syslog shows the second (netdev destructor) kfree is being issued:

[ 1885.469676] [4487] bluetooth_6lowpan:device_event:1419: Unregistered netdev bt0 f1054580
[ 1885.469680] =============================================================================
[ 1885.469684] BUG kmalloc-2048 (Tainted: G  R B   W  OE  ): Invalid object pointer 0xf1054a80
[ 1885.469686] -----------------------------------------------------------------------------
[ 1885.469689] INFO: Slab 0xf7102c80 objects=14 used=6 fp=0xf1050000 flags=0x2804081
[ 1885.469693] CPU: 0 PID: 4487 Comm: kworker/0:1 Tainted: G  R B   W  OE   4.1.0-rc4+ #2
[ 1885.469695] Hardware name: ...
[ 1885.469701] Workqueue: events delete_netdev [bluetooth_6lowpan]
[ 1885.469704]  00000000 00000000 f10adca4 c16f4868 f7102c80 f10add38 c11912e2 c1911688
[ 1885.469710]  f7102c80 0000000e 00000006 f1050000 02804081 61766e49 2064696c 656a626f
[ 1885.469716]  70207463 746e696f 30207265 30316678 38613435 00000030 f7b3a7e8 00000001
[ 1885.469722] Call Trace:
[ 1885.469729]  [<c16f4868>] dump_stack+0x41/0x52
[ 1885.469733]  [<c11912e2>] slab_err+0x82/0xa0
[ 1885.469737]  [<c112febd>] ? irq_work_queue+0x6d/0x80
[ 1885.469740]  [<c11914a7>] ? check_slab+0x67/0x100
[ 1885.469744]  [<c10b32bd>] ? log_store+0x1cd/0x210
[ 1885.469747]  [<c1191f98>] free_debug_processing+0xf8/0x260
[ 1885.469749]  [<c10b5a66>] ? vprintk_emit+0x316/0x580
[ 1885.469752]  [<c1192eab>] __slab_free+0x22b/0x320
[ 1885.469756]  [<f87142ab>] ? device_event+0x7b/0xc0 [bluetooth_6lowpan]
[ 1885.469758]  [<c10b5e47>] ? vprintk_default+0x37/0x40
[ 1885.469761]  [<c16f3aa1>] ? printk+0x17/0x19
[ 1885.469765]  [<c13608ee>] ? __dynamic_pr_debug+0x4e/0x70
[ 1885.469768]  [<c1193305>] kfree+0x145/0x150
[ 1885.469771]  [<f87142ab>] ? device_event+0x7b/0xc0 [bluetooth_6lowpan]
[ 1885.469774]  [<f87142ab>] ? device_event+0x7b/0xc0 [bluetooth_6lowpan]
[ 1885.469778]  [<f87142ab>] device_event+0x7b/0xc0 [bluetooth_6lowpan]
[ 1885.469782]  [<c10804ee>] notifier_call_chain+0x4e/0x70
[ 1885.469785]  [<c10805df>] raw_notifier_call_chain+0x1f/0x30
[ 1885.469789]  [<c15fe24d>] call_netdevice_notifiers_info+0x2d/0x60
[ 1885.469792]  [<c1624088>] ? dev_shutdown+0x58/0x90
[ 1885.469795]  [<c15fffa1>] rollback_registered_many+0x1d1/0x2d0
[ 1885.469798]  [<c16000c4>] rollback_registered+0x24/0x40
[ 1885.469801]  [<c16007bf>] unregister_netdevice_queue+0x4f/0xc0
[ 1885.469804]  [<c16f80c0>] ? mutex_lock+0x10/0x30
[ 1885.469807]  [<c1600849>] unregister_netdev+0x19/0x30
[ 1885.469811]  [<f87144f0>] delete_netdev+0x10/0x20 [bluetooth_6lowpan]
[ 1885.469814]  [<c107a822>] process_one_work+0x122/0x3c0
[ 1885.469817]  [<c107b1f9>] worker_thread+0x39/0x4e0
[ 1885.469820]  [<c107b1c0>] ? rescuer_thread+0x320/0x320
[ 1885.469823]  [<c107f71b>] kthread+0x9b/0xb0
[ 1885.469826]  [<c16fa881>] ret_from_kernel_thread+0x21/0x30
[ 1885.469829]  [<c107f680>] ? kthread_create_on_node+0x110/0x110
[ 1885.469832] FIX kmalloc-2048: Object at 0xf1054a80 not freed
[ 1885.484051] [50] bluetooth:hci_conn_del:510: hci0 hcon f336d910 handle 65


Description of patch #5
=======================

This patch removes the additional module_put() in disconnect_all_peers()
making a correct module refcount so that the module can be removed after 
disabling 6lowpan through debugfs.

Problem:

When disabling 6lowpan using debugfs "6lowpan_enable" the module refcount 
is set to -1 because of an additional module_put() in disconnect_all_peers().
Attemps to remove the bluetooth_6lowpan module results in a 
Segmentation Fault.

Test:

 1. Create one 6lowpan connection and the refcount increases:
    root@dellovo:~# lsmod | grep bluetooth_6lowpan
    bluetooth_6lowpan      24576  1

    root@dellovo:~# cat /sys/kernel/debug/bluetooth/6lowpan_control
    00:b8:ac:69:4b:11 (type 1)

 2. Disable 6lowpan through the debugfs while in a 6lowpan connection:
    root@dellovo:~# echo 0 > /sys/kernel/debug/bluetooth/6lowpan_enable

    The module refcount is now -1:
    root@dellovo:~# lsmod | grep bluetooth_6lowpan
    bluetooth_6lowpan      24576  -1

 3. Removing the bluetooth_6lowpan module results in a seg.fault.
    root@dellovo:~# modprobe -r bluetooth_6lowpan
    Segmentation Fault!

Cheers,
Glenn

Glenn Ruben Bakke (5):
  Bluetooth: 6lowpan: Enable delete_netdev to be scheduled when last
    peer is deleted
  Bluetooth: 6lowpan: Rename ambiguous variable
  Bluetooth: 6lowpan: Move netdev sysfs device reference
  Bluetooth: 6lowpan: Fix double kfree of netdev priv
  Bluetooth: 6lowpan: Fix module refcount

 net/bluetooth/6lowpan.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.1.4
