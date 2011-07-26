Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 12:55:02 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2 v2] Fix possible invalid read/free on manager.c
Message-ID: <20110726095502.GC28891@dell>
References: <1310733208-12838-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310733208-12838-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jul 15, 2011, Luiz Augusto von Dentz wrote:
>  Invalid read of size 4
>     at 0x178A20: adapter_get_address (string3.h:52)
>     by 0x174C28: adapter_cmp (manager.c:324)
>     by 0x4EA95B0: g_slist_find_custom (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x174ED9: manager_find_adapter (manager.c:333)
>     by 0x16ABFA: sdp_record_remove (sdpd-database.c:270)
>     by 0x16A4D6: remove_record_from_server (sdpd-service.c:286)
>     by 0x12A947: avrcp_unregister (control.c:972)
>     by 0x1208CC: avrcp_server_remove (manager.c:1066)
>     by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x178985: adapter_remove (adapter.c:2326)
>     by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
>   Address 0x603ccd0 is 16 bytes inside a block of size 448 free'd
>     at 0x4A055FE: free (vg_replace_malloc.c:366)
>     by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x11EB59: remove_interface (object.c:563)
>     by 0x11F380: g_dbus_unregister_interface (object.c:715)
>     by 0x1787EC: btd_adapter_unref (adapter.c:2496)
>     by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
>     by 0x174E96: manager_cleanup (manager.c:301)
>     by 0x11CCE8: main (main.c:305)
> ---
>  src/adapter.c |    2 --
>  src/manager.c |   10 ++++++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)

The first patch has been applied. For the second one I'm awaiting for
the fixes that we discussed (offline).

Johan
