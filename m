Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: fix power_on vs close race
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1463128729-2959-1-git-send-email-jslaby@suse.cz>
Date: Fri, 13 May 2016 07:51:17 -0700
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <0F397746-FC6F-47B9-A35B-3EA6CFB4A0C9@holtmann.org>
References: <1463128729-2959-1-git-send-email-jslaby@suse.cz>
To: Jiri Slaby <jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

> With all the latest fixes applied, I am still able to reproduce this
> (and other) warning(s):
> WARNING: CPU: 1 PID: 19684 at ../kernel/workqueue.c:4092 destroy_workqueue+0x70a/0x770()
> ...
> Call Trace:
> [<ffffffff819fee81>] ? dump_stack+0xb3/0x112
> [<ffffffff8117377e>] ? warn_slowpath_common+0xde/0x140
> [<ffffffff811ce68a>] ? destroy_workqueue+0x70a/0x770
> [<ffffffff811739ae>] ? warn_slowpath_null+0x2e/0x40
> [<ffffffff811ce68a>] ? destroy_workqueue+0x70a/0x770
> [<ffffffffa0c944c9>] ? hci_unregister_dev+0x2a9/0x720 [bluetooth]
> [<ffffffffa0b301db>] ? vhci_release+0x7b/0xf0 [hci_vhci]
> [<ffffffffa0b30160>] ? vhci_flush+0x50/0x50 [hci_vhci]
> [<ffffffff8117cd73>] ? do_exit+0x863/0x2b90
> 
> This is due to race present in the hci_unregister_dev path.
> hdev->power_on work races with hci_dev_do_close. One tries to open,
> the other tries to close, leading to warning like the above. (Another
> example is a warning in kobject_get or kobject_put depending on who
> wins the race.)
> 
> Fix this by switching those two racers to ensure hdev->power_on never
> triggers while hci_dev_do_close is in progress.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> ---
> net/bluetooth/hci_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
