Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 16:20:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] media: Fix possible crash when endpoint exit
Message-ID: <20120921132044.GB15946@x220>
References: <1348233143-27796-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348233143-27796-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 21, 2012, Luiz Augusto von Dentz wrote:
> a2dp_sep_unlock may free the endpoint if it is not registered anymore
> which leads to destroying all related transport causing the following:
> 
> Invalid read of size 1
>    at 0x4A09F09: memcpy@GLIBC_2.2.5 (mc_replace_strmem.c:836)
>    by 0x4F7C02D: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x4F7AAE5: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x4F7B10B: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x4F68DA0: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x4F66788: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x4F66B41: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x4F6D64E: dbus_message_new_signal (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x180FC2: emit_property_changed (dbus-common.c:130)
>    by 0x13FD15: transport_set_state (transport.c:206)
>    by 0x140519: suspend_a2dp (transport.c:460)
>    by 0x122436: service_filter (watch.c:476)
>  Address 0x6546110 is 48 bytes inside a block of size 49 free'd
>    at 0x4A079AE: free (vg_replace_malloc.c:427)
>    by 0x4C8037E: g_free (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x1409F9: media_transport_free (transport.c:1160)
>    by 0x12282F: remove_interface (object.c:553)
>    by 0x123699: g_dbus_unregister_interface (object.c:1231)
>    by 0x141547: media_transport_destroy (transport.c:228)
>    by 0x4C95ACC: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C95AEA: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x13E53D: media_endpoint_remove (media.c:162)
>    by 0x133F62: a2dp_unregister_sep (a2dp.c:1247)
>    by 0x1369D7: a2dp_sep_unlock (a2dp.c:1814)
>    by 0x1404D3: suspend_a2dp (transport.c:455)
> ---
>  audio/transport.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Applied. Thanks.

Johan
