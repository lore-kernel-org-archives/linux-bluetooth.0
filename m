Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Jan 2013 16:39:08 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2 v2] thermometer: Fix crash while unregistering
 adapter
Message-ID: <20130128223908.GA6043@x220>
References: <1359409441-21066-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359409441-21066-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jan 28, 2013, Luiz Augusto von Dentz wrote:
> Invalid read of size 8
>    at 0x448200: g_attrib_unregister (gattrib.c:722)
>    by 0x440476: destroy_thermometer (thermometer.c:167)
>    by 0x40D849: remove_interface (object.c:656)
>    by 0x40DAA9: g_dbus_unregister_interface (object.c:1413)
>    by 0x3DF7A63C9C: g_slist_foreach (gslist.c:894)
>    by 0x469656: device_remove (device.c:2200)
>    by 0x45CDC1: adapter_remove (adapter.c:3884)
>    by 0x45F146: index_removed (adapter.c:5442)
>    by 0x46BC17: received_data (mgmt.c:252)
>    by 0x3DF7A47A74: g_main_context_dispatch (gmain.c:2715)
>    by 0x3DF7A47DA7: g_main_context_iterate.isra.24 (gmain.c:3290)
>    by 0x3DF7A481A1: g_main_loop_run (gmain.c:3484)
>  Address 0x40 is not stack'd, malloc'd or (recently) free'd
> ---
> v2: Print a warning if invalid id is passed to g_attrib_unregister
> 
>  profiles/thermometer/thermometer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Both patches have been applied. Thanks.

Johan
