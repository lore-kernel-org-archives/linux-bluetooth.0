Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Aug 2011 16:49:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3] Fix possible invalid read/free on media.c
Message-ID: <20110808134918.GA22839@dell>
References: <1312809732-18235-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312809732-18235-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Aug 08, 2011, Luiz Augusto von Dentz wrote:
> This also fix the circular dependency of media.c and a2dp.c
> 
>  Invalid read of size 8
>     at 0x4EA8CC2: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x13AF33: path_free (media.c:417)
>     by 0x11EB39: remove_interface (object.c:563)
>     by 0x11F360: g_dbus_unregister_interface (object.c:715)
>     by 0x120C49: media_server_remove (manager.c:1098)
>     by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x178915: adapter_remove (adapter.c:2326)
>     by 0x17535F: btd_manager_unregister_adapter (manager.c:293)
>     by 0x154081: device_event (hciops.c:2643)
>     by 0x1543C1: io_stack_event (hciops.c:2763)
>     by 0x4E8C88C: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x4E8D087: ??? (in /lib64/libglib-2.0.so.0.2908.0)
>   Address 0x63f6638 is 8 bytes inside a block of size 16 free'd
>     at 0x4A055FE: free (vg_replace_malloc.c:366)
>     by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x13AE53: media_endpoint_remove (media.c:118)
>     by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x13AF33: path_free (media.c:417)
>     by 0x11EB39: remove_interface (object.c:563)
>     by 0x11F360: g_dbus_unregister_interface (object.c:715)
>     by 0x120C49: media_server_remove (manager.c:1098)
>     by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
> ---
>  audio/a2dp.c      |   92 ++++---
>  audio/a2dp.h      |   31 +++-
>  audio/media.c     |  698 +++++++++++++++++++++++++++++++----------------------
>  audio/media.h     |   17 --
>  audio/transport.c |    3 +-
>  5 files changed, 493 insertions(+), 348 deletions(-)

Applied. Thanks.

Johan
