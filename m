Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310624928-17720-1-git-send-email-luiz.dentz@gmail.com>
References: <1310624928-17720-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 14 Jul 2011 20:45:27 +0300
Message-ID: <CAHMBquUuOLAYCSBbAG41AQqvC4hutfCxbkFTbd4bPYr9Bs3mHg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] Fix possible invalid read/free on manager.c
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jul 14, 2011 at 9:28 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
>  Invalid read of size 4
>    at 0x178A20: adapter_get_address (string3.h:52)
>    by 0x174C28: adapter_cmp (manager.c:324)
>    by 0x4EA95B0: g_slist_find_custom (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x174ED9: manager_find_adapter (manager.c:333)
>    by 0x16ABFA: sdp_record_remove (sdpd-database.c:270)
>    by 0x16A4D6: remove_record_from_server (sdpd-service.c:286)
>    by 0x12A947: avrcp_unregister (control.c:972)
>    by 0x1208CC: avrcp_server_remove (manager.c:1066)
>    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x178985: adapter_remove (adapter.c:2326)
>    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
>  Address 0x603ccd0 is 16 bytes inside a block of size 448 free'd
>    at 0x4A055FE: free (vg_replace_malloc.c:366)
>    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x11EB59: remove_interface (object.c:563)
>    by 0x11F380: g_dbus_unregister_interface (object.c:715)
>    by 0x1787EC: btd_adapter_unref (adapter.c:2496)
>    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x174E96: manager_cleanup (manager.c:301)
>    by 0x11CCE8: main (main.c:305)
>
>  Invalid read of size 2
>    at 0x178A25: adapter_get_address (string3.h:52)
>    by 0x174C28: adapter_cmp (manager.c:324)
>    by 0x4EA95B0: g_slist_find_custom (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x174ED9: manager_find_adapter (manager.c:333)
>    by 0x16ABFA: sdp_record_remove (sdpd-database.c:270)
>    by 0x16A4D6: remove_record_from_server (sdpd-service.c:286)
>    by 0x12A947: avrcp_unregister (control.c:972)
>    by 0x1208CC: avrcp_server_remove (manager.c:1066)
>    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x178985: adapter_remove (adapter.c:2326)
>    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
>  Address 0x603ccd4 is 20 bytes inside a block of size 448 free'd
>    at 0x4A055FE: free (vg_replace_malloc.c:366)
>    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x11EB59: remove_interface (object.c:563)
>    by 0x11F380: g_dbus_unregister_interface (object.c:715)
>    by 0x1787EC: btd_adapter_unref (adapter.c:2496)
>    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
>    by 0x174E96: manager_cleanup (manager.c:301)
>    by 0x11CCE8: main (main.c:305)
> ---
>  src/adapter.c |    2 --
>  src/manager.c |   16 +++++++++++++---
>  2 files changed, 13 insertions(+), 5 deletions(-)

Wouldn't it be better to shorten commit messages like this one? It is
not very convenient to have full screen message that doesn't bring
much addition explanation to its title.

Thanks,
Dmitriy
