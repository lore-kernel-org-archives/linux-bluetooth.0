Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 23:55:03 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Feng Hong <hongfeng@marvell.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Avoid duplicate conn dev register
Message-ID: <20130418025503.GB17064@joana>
References: <1365489826-30652-1-git-send-email-hongfeng@marvell.com>
 <E62404B31D39064FBDD0B843ADF05A7D2DEBE7E9EB@SC-VEXCH4.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E62404B31D39064FBDD0B843ADF05A7D2DEBE7E9EB@SC-VEXCH4.marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Feng,

* Feng Hong <hongfeng@marvell.com> [2013-04-11 19:43:48 -0700]:

> Hello, Marcel Holtmann, Gustavo Padovan, Johan Hedberg,
> 
> What's your idea why below warning will happen ?
> [  651.865509] WARNING: at lib/kobject.c:198 kobject_add_internal+0x1f4/0x264()
> [  651.872894] kobject_add_internal failed for hci0:1 with -EEXIST, don't try to register things with the same name in the same directory.
> [  651.910125] [<c011991c>] (unwind_backtrace+0x0/0x11c) from [<c0134d3c>] (warn_slowpath_common+0x4c/0x64)
> [  651.920013] [<c0134d3c>] (warn_slowpath_common+0x4c/0x64) from [<c0134dd4>] (warn_slowpath_fmt+0x2c/0x3c)
> [  651.930053] [<c0134dd4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02d91e0>] (kobject_add_internal+0x1f4/0x264)
> [  651.940246] [<c02d91e0>] (kobject_add_internal+0x1f4/0x264) from [<c02d95f0>] (kobject_add+0x68/0x8c)
> [  651.949890] [<c02d95f0>] (kobject_add+0x68/0x8c) from [<c03323c8>] (device_add+0x104/0x5b8)
> [  651.958831] [<c03323c8>] (device_add+0x104/0x5b8) from [<c0547484>] (hci_conn_add_sysfs+0x4c/0x80)
> [  651.968109] [<c0547484>] (hci_conn_add_sysfs+0x4c/0x80) from [<c053996c>] (hci_event_packet+0x530/0x6428)
> [  651.978149] [<c053996c>] (hci_event_packet+0x530/0x6428) from [<c05342a8>] (hci_rx_work+0xd0/0x390)
> [  651.987640] [<c05342a8>] (hci_rx_work+0xd0/0x390) from [<c014ce24>] (process_one_work+0x280/0x488)
> [  651.996978] [<c014ce24>] (process_one_work+0x280/0x488) from [<c014d240>] (worker_thread+0x214/0x3b4)
> [  652.006652] [<c014d240>] (worker_thread+0x214/0x3b4) from [<c01511b4>] (kthread+0x80/0x8c)
> [  652.015228] [<c01511b4>] (kthread+0x80/0x8c) from [<c0113ed8>] (kernel_thread_exit+0x0/0x8)
> [  652.023925] ---[ end trace 7d6ac73956376f0a ]---
> [  652.035034] Bluetooth: Failed to register connection device
> 
> And if above really happen, the patch below can avoid system from panic, what's your comments on this protection ? 

I think that fc225c3f5 and other commits we recently added to bluetooth-next
may help you with this. Could give bluetooth-next a try please and see if this
is gone?

	Gustavo
