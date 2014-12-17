Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418782038-10999-6-git-send-email-armansito@chromium.org>
References: <1418782038-10999-1-git-send-email-armansito@chromium.org>
	<1418782038-10999-6-git-send-email-armansito@chromium.org>
Date: Wed, 17 Dec 2014 15:08:13 +0200
Message-ID: <CABBYNZJB4NZuKwQ-r64Te03QwSHi50quQ=Ka4UBhFLcORuufgw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 05/10] core: device: Don't disconnect if attios
 not set
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Dec 17, 2014 at 4:07 AM, Arman Uguray <armansito@chromium.org> wrote:
> Currently there is no way for external applications to claim ownership
> on a GATT connection and as profiles move away from attio.h it doesn't
> make much sense to immediately disconnect if no attio callbacks have
> been set after probing the profiles (as this will always immediately
> disconnect the device). This patch removes this logic from btd_device.

I was thinking that if no driver accepts the connection we should
disconnect but it doesn't look like you had done anything in this
direction, for external client using the D-Bus API maybe we need some
method for registering client making only the services with clients
visible.

> ---
>  src/device.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index e8bdc18..64591d0 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3642,9 +3642,6 @@ static void register_gatt_services(struct browse_req *req)
>
>         device_probe_profiles(device, req->profiles_added);
>
> -       if (device->attios == NULL && device->attios_offline == NULL)
> -               attio_cleanup(device);
> -
>         device_svc_resolved(device, device->bdaddr_type, 0);
>
>         store_services(device);
> @@ -5069,11 +5066,6 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
>
>         g_free(attio);
>
> -       if (device->attios != NULL || device->attios_offline != NULL)
> -               return TRUE;
> -
> -       attio_cleanup(device);
> -
>         return TRUE;
>  }
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
