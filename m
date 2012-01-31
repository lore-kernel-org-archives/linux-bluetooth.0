Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328025545-14320-1-git-send-email-sancane@gmail.com>
References: <1328025545-14320-1-git-send-email-sancane@gmail.com>
Date: Tue, 31 Jan 2012 12:23:04 -0400
Message-ID: <CAJdJm_NADwgGb-ZitDQNipgWoDQuRa1M+aQOMdzWmU81JpuNew@mail.gmail.com>
Subject: Re: [PATCH] device: Fix segmentation fault removing devices
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Jan 31, 2012 at 11:59 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> There is an unbalanced control regarding to the GATT channel and its
> attachid, we have to to update the attach id value by setting it to
> zero whenever we detach a GATT channel.

Can you detail how to reproduce the segfault? I want to test on my own setup.

Thanks

> ---
>  src/device.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index c19acd4..9f749b7 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1734,6 +1734,7 @@ static void attrib_disconnected(gpointer user_data)
>        attrib_channel_detach(device->attrib, device->attachid);
>        g_attrib_unref(device->attrib);
>        device->attrib = NULL;
> +       device->attachid = 0;
>
>        if (device->auto_connect == FALSE)
>                return;
> @@ -1781,6 +1782,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
>
>        if (device->attios == NULL && device->attios_offline == NULL) {
>                attrib_channel_detach(device->attrib, device->attachid);
> +               device->attachid = 0;
>                g_attrib_unref(device->attrib);
>                device->attrib = NULL;
>        } else
> @@ -2854,7 +2856,7 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
>        if (device->attios != NULL || device->attios_offline != NULL)
>                return TRUE;
>
> -       if (device->attachid) {
> +       if (device->attachid > 0) {
>                attrib_channel_detach(device->attrib, device->attachid);
>                device->attachid = 0;
>        }
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
