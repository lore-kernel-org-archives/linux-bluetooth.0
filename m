Return-Path: <akpm@osdl.org>
Date: Sat, 23 Dec 2006 17:18:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
        maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in
 2.6.20-rc1)
Message-Id: <20061223171804.e2c22a67.akpm@osdl.org>
In-Reply-To: <20061223235501.GA1740@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz>
	<20061223235501.GA1740@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 24 Dec 2006 00:55:01 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> PM: Removing info for No Bus:usbdev3.15_ep81
> PM: Removing info for No Bus:usbdev3.15_ep82
> PM: Removing info for No Bus:usbdev3.15_ep02
> slab error in verify_redzone_free(): cache `size-512': memory outside object was overwritten
>  [<c016a1b8>] cache_free_debugcheck+0x128/0x1d0
>  [<c04b58e3>] hci_usb_close+0xf3/0x160
>  [<c016b530>] kfree+0x50/0xa0
>  [<c04b58e3>] hci_usb_close+0xf3/0x160
>  [<c04b59be>] hci_usb_disconnect+0x2e/0x90
>  [<c0454f23>] usb_disable_interface+0x53/0x70
>  [<c04576f8>] usb_unbind_interface+0x38/0x80
>  [<c032f908>] __device_release_driver+0x68/0xb0
>  [<c032fc3e>] device_release_driver+0x1e/0x40
>  [<c032f1db>] bus_remove_device+0x8b/0xa0
>  [<c032dbc9>] device_del+0x159/0x1c0
>  [<c04559ad>] usb_disable_device+0x4d/0x100
>  [<c044fe8a>] usb_disconnect+0x9a/0x110
>  [<c0452405>] hub_thread+0x355/0xbd0
>  [<c061426e>] schedule+0x2de/0x8f0
>  [<c013c640>] autoremove_wake_function+0x0/0x50
>  [<c04520b0>] hub_thread+0x0/0xbd0
>  [<c013c58c>] kthread+0xec/0xf0
>  [<c013c4a0>] kthread+0x0/0xf0
>  [<c0103be7>] kernel_thread_helper+0x7/0x10
>  =======================

yes, this one looks like memory scribblage in bluetooth.  The
buffer.c assertion failure should now be fixed, please verify.
