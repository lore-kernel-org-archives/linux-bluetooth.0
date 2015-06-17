Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 0/5] Improving bluetooth 6lowpan cleanup & module unloading
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
Date: Wed, 17 Jun 2015 19:20:36 +0200
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	lukasz.duda@nordicsemi.no, linux-bluetooth@vger.kernel.org
Message-Id: <22676960-0AEF-4DF5-9DDD-BCB036F32BDC@holtmann.org>
References: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
To: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Glenn,

> First a big thank you for all the great effort on the 6lowpan bluetooth
> module! As a company providing 6lowpan enabled bluetooth devices this module
> has been extremly important to us in order to show the technology.
> 
> As a user of the module some issues have been seen when the USB hci
> device has been restarted (crash or dongle removed) while in a 6lowpan
> connection. A set of patches has been created in order to improve the
> creation/removal of the netdev, created in the bluetooth 6lowpan module.
> A more predictable netdev is quite useful for scripts and daemons depending
> on a specific device name.
> 
> 
> The set of patches:
> 
> - Patch #1 enables scheduling of delete_netdev when the last 6lowpan 
>   peer has been removed.
> 
> - Patch #2 renames the variable used in patch #1 in order to trigger 
>   the schedule of the delete_netdev.
> 
> - Patch #3 moves the sysfs device from the the device of the first
>   connected 6lowpan device to the hci device. This enables sysfs to 
>   locate and remove all the netdev sysfs entries associated with the 
>   netdev. This also fixes the known issue reported: 
>   http://www.spinics.net/lists/linux-bluetooth/msg48455.html
> 
> - Patch #4 removes a double kfree of the netdev priv.
> 
> - Patch #5 removes an additional module_put() which causes the module 
>   refcount to underflow. Any attempt on unloading the module after this
>   causes a seg.fault.

all 5 patches have been applied bluetooth-next tree.

> Testing 
> =======
> 
> The patches has been tested on Ubuntu and Raspian (Raspberry Pi) using the 
> bluetooth-next branch. A quick way of testing the cleanup proceedures is 
> to remove the bluetooth USB dongle while in a connection. 
> 
> 
> Description of patch #1
> =======================
> 
> This patch fixes an issue with the netdev not being unregistered when 
> the last peer is deleted. Removing the logical negation operator on the 
> boolean solves this issue. If the last peer is removed the condition 
> will be true, and the delete_netdev() is scheduled.
> 
> Problem: 
> 
> The "removed" flag is set to true by default, but the variable has to be 
> set to false in order to schedule the delete_netdev work. The condition 
> is always false because chan->conn is NULL on the l2cap channel 
> disconnections.
> 
> Also, if the link goes down ungracefully for example by unplugging the 
> dongle (usb reset), the bt0 is never removed, and the next 6lowpan 
> connection will make a new netdev bt1. If normal disconnects are performed
> the initial netdev is never removed.
> 
> SystemTap log before applying the patch:
>     0 kworker/u17:0(61):  -> l2cap_chan_no_teardown
>     5 kworker/u17:0(61):  <- l2cap_chan_no_teardown
>     0 kworker/u17:0(61):  -> chan_close_cb
>    10 kworker/u17:0(61):    -> ifdown
>    13 kworker/u17:0(61):    <- ifdown
>    14 kworker/u17:0(61):  <- chan_close_cb
> 
> SystemTap log after applying the patch:
>     0 kworker/u17:0(61):  -> l2cap_chan_no_teardown
>     8 kworker/u17:0(61):  <- l2cap_chan_no_teardown
>     0 kworker/u17:0(61):  -> chan_close_cb
>    31 kworker/u17:0(61):    -> ifdown
>    39 kworker/u17:0(61):    <- ifdown
>    45 kworker/u17:0(61):  <- chan_close_cb
>     0 kworker/0:1(19579):  -> delete_netdev
>    14 kworker/0:1(19579):    -> unregister_netdev
>    20 kworker/0:1(19579):      -> unregister_netdevice_queue
>   785 kworker/0:1(19579):        -> unregister_netdevice_many
>   795 kworker/0:1(19579):        <- unregister_netdevice_many
>   906 kworker/0:1(19579):        -> device_event
>  1121 kworker/0:1(19579):        <- device_event
>  3368 kworker/0:1(19579):      <- unregister_netdevice_queue
> 45875 kworker/0:1(19579):      -> device_event
> 45881 kworker/0:1(19579):      <- device_event
> 46280 kworker/0:1(19579):    <- unregister_netdev
> 46283 kworker/0:1(19579):  <- delete_netdev

On a separate note, do not feel shy to include such detailed information in the commit message of each patch. There is really no limit on the commit message. I actually welcome long and descriptive commit messages.

Regards

Marcel

