Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 12 Nov 2015 16:38:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] client: Fix crash when exiting
Message-ID: <20151112143815.GB15722@t440s.P-661HNU-F1>
References: <1447337613-2214-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447337613-2214-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 12, 2015, Luiz Augusto von Dentz wrote:
> When exiting the available proxies are destroy in the same order they are
> added causing the following crash when there are attributes whose service
> has already been removed:
> 
> Invalid read of size 8
>    at 0x414AAD: g_dbus_proxy_get_path (client.c:525)
>    by 0x40B948: characteristic_is_child (gatt.c:136)
>    by 0x40C420: gatt_remove_characteristic (gatt.c:157)
>    by 0x4067A7: proxy_removed (main.c:446)
>    by 0x414A2E: proxy_free (client.c:439)
>    by 0x4E7AF6C: g_list_foreach (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x4E7AF8A: g_list_free_full (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x415D54: g_dbus_client_unref (client.c:1310)
>    by 0x40511B: main (main.c:2067)
>  Address 0x5eb5450 is 16 bytes inside a block of size 80 free'd
>    at 0x4C29D6A: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>    by 0x4E8479E: g_free (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x4149D6: g_dbus_proxy_unref (client.c:517)
>    by 0x414A8D: proxy_free (client.c:451)
>    by 0x4E7AF6C: g_list_foreach (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x4E7AF8A: g_list_free_full (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x415D54: g_dbus_client_unref (client.c:1310)
>    by 0x40511B: main (main.c:2067)
> ---
>  client/gatt.c | 22 +++++++++++++++++-----
>  client/main.c |  8 +++-----
>  2 files changed, 20 insertions(+), 10 deletions(-)

Applied. Thanks.

Johan
