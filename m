Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334786904-26282-4-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-4-git-send-email-jprvita@openbossa.org>
Date: Fri, 20 Apr 2012 13:52:34 -0400
Message-ID: <CAJdJm_OkfN1NjZ7=ufFqcfhH=C=YZ7T-V8pTy-TN0SLe02K1XQ@mail.gmail.com>
Subject: Re: [RFC v2 03/16] HoG: load primary service handle
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

2012/4/18 João Paulo Rechi Vita <jprvita@openbossa.org>:
>  int hog_device_register(struct btd_device *device, const char *path)
>  {
>        struct hog_device *hogdev;
> +       struct gatt_primary *prim;
>
>        hogdev = find_device_by_path(devices, path);
>        if (hogdev)
>                return -EALREADY;
>
> +       prim = load_hog_primary(device);
> +       if (!prim)
> +               return -EINVAL;
> +
>        hogdev = hog_device_new(device, path);
> -       if (!hogdev)
> +       if (!hogdev) {
> +               g_free(prim);

This g_free() call does not look correct. load_hog_primary() returns a
pointer to GSList data (more specifically from the primary service
list), which is freed in another part of BlueZ.

So I think you can safely just return here.

>                return -ENOMEM;
> +       }
> +
> +       hogdev->hog_primary = g_memdup(prim, sizeof(*prim));
>
>        hogdev->attioid = btd_device_add_attio_callback(device,
>                                                        attio_connected_cb,
> @@ -122,6 +154,7 @@ static void hog_device_free(struct hog_device *hogdev)
>  {
>        btd_device_unref(hogdev->device);
>        g_free(hogdev->path);
> +       g_free(hogdev->hog_primary);
>        g_free(hogdev);
>  }

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
