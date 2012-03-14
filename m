Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331214279-27521-1-git-send-email-arik@wizery.com>
References: <1331214279-27521-1-git-send-email-arik@wizery.com>
Date: Wed, 14 Mar 2012 08:03:19 -0400
Message-ID: <CAJdJm_Ph1Ax_BJUVz3UsLvzLQnA1uH5n8p=ihNc-KHuxoCVoHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] device: don't auto-connect on disc-cb attio callback registration
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Mar 8, 2012 at 9:44 AM, Arik Nemtsov <arik@wizery.com> wrote:
> If a device is already connected, don't auto-connect if we register
> a disconnect-only attio callback. This will obviously fail.
> ---
>  src/device.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)

I can't see why this patch is necessary. attio_connected() seems to
properly check that device->cfunc is set before calling it.

Can you explain why you need it?

>
> diff --git a/src/device.c b/src/device.c
> index dfc8e59..b339ac1 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2942,10 +2942,15 @@ guint btd_device_add_attio_callback(struct btd_device *device,
>        attio->dcfunc = dcfunc;
>        attio->user_data = user_data;
>
> -       if (device->attrib && cfunc) {
> -               device->attios_offline = g_slist_append(device->attios_offline,
> -                                                                       attio);
> -               g_idle_add(notify_attios, device);
> +       if (device->attrib) {
> +               if (cfunc) {
> +                       device->attios_offline =
> +                               g_slist_append(device->attios_offline, attio);
> +
> +                       g_idle_add(notify_attios, device);
> +               } else {
> +                       device->attios = g_slist_append(device->attios, attio);
> +               }
>        } else {
>                device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
>                                                att_connect, device,
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
