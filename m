Return-Path: <cyrus@holtmann.org>
Message-ID: <1338176868.15105.113.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: Really fix registering hci with duplicate
 name
From: Marcel Holtmann <marcel@holtmann.org>
To: Sasha Levin <levinsasha928@gmail.com>
Cc: gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Mon, 28 May 2012 05:47:48 +0200
In-Reply-To: <1338151016-13494-1-git-send-email-levinsasha928@gmail.com>
References: <1338151016-13494-1-git-send-email-levinsasha928@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sasha,

> Commit fc50744 ("Bluetooth: Fix registering hci with duplicate name") didn't
> fully fix the duplicate naming issue with devices, and duplicate device names
> could still be created:
> 
> [  142.484097] device: 'hci1': device_add
> [...]
> [  150.545263] device: 'hci1': device_add
> [  150.550128] kobject: 'hci1' (ffff880014cc4e58): kobject_add_internal: parent: 'bluetooth', set: 'devices'
> [  150.558979] ------------[ cut here ]------------
> [  150.561438] WARNING: at fs/sysfs/dir.c:529 sysfs_add_one+0xb0/0xd0()
> [  150.572974] Hardware name: Bochs
> [  150.580502] sysfs: cannot create duplicate filename '/devices/virtual/bluetooth/hci1'
> [  150.584444] Pid: 7563, comm: trinity-child1 Tainted: G        W    3.4.0-next-20120524-sasha #296
> [...]
> 
> Instead of the weird logic and the attempt at keeping the device list sorted,
> just use an IDA.
> 
> Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
> ---
> 
> Changes from v1:
> 
>  - Address comments by Marcel.
>  - Remove errornous mutex lock.
> 
>  net/bluetooth/hci_core.c |   41 ++++++++++++++++++++++++-----------------
>  1 files changed, 24 insertions(+), 17 deletions(-)

thanks for addressing this. Patch has been applied to bluetooth-next
tree.

Regards

Marcel


