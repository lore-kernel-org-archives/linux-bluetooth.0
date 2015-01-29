Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1422497463-32539-5-git-send-email-armansito@chromium.org>
References: <1422497463-32539-1-git-send-email-armansito@chromium.org>
	<1422497463-32539-5-git-send-email-armansito@chromium.org>
Date: Thu, 29 Jan 2015 15:52:22 +0200
Message-ID: <CABBYNZ+6OCd2tLfSVJt-dUYUc348jTik003jkwc+vFs-uKaS9w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] core: device: Add device_is_bonded_for_gatt
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Jan 29, 2015 at 4:11 AM, Arman Uguray <armansito@chromium.org> wrote:
> Added the device_is_bonded_for_gatt function, which returns true if
> the bonding state is true for the bearer over which the GATT db was
> populated. For now, this only returns the LE state but added for
> better layering, so that future changes to the internal logic can be
> simply performed here to avoid regressions.
>
> Change-Id: I6ebd16a1111aa38645a0a072536f4171d246b931
> ---
>  src/device.c | 14 +++++++++++++-
>  src/device.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 9cb5acb..2ef2b6a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -506,8 +506,10 @@ static void gatt_client_cleanup(struct btd_device *device)
>         bt_gatt_client_unref(device->client);
>         device->client = NULL;
>
> -       if (!device->le_state.bonded)
> +       if (!device_is_bonded_for_gatt(device)) {
> +               DBG("Device is not bonded, clearing client attribute cache");
>                 gatt_db_clear(device->db);
> +       }
>  }
>
>  static void attio_cleanup(struct btd_device *device)
> @@ -638,6 +640,16 @@ bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type)
>         return state->bonded;
>  }
>
> +bool device_is_bonded_for_gatt(struct btd_device *device)
> +{
> +       /*
> +        * TODO: Once we properly support GATT over BR/EDR, we should remember
> +        * whether the GATT client  database was populated over LE or BR/EDR and
> +        * check the correct bonding state.
> +        */
> +       return device->le_state.bonded;
> +}
> +
>  gboolean device_is_trusted(struct btd_device *device)
>  {
>         return device->trusted;
> diff --git a/src/device.h b/src/device.h
> index a7fefee..b4aead1 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -82,6 +82,7 @@ const char *device_get_path(const struct btd_device *device);
>  gboolean device_is_temporary(struct btd_device *device);
>  bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
>  bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
> +bool device_is_bonded_for_gatt(struct btd_device *device);

Isn't this equivalent to device_is_bonded or perhaps we don't the
type? I guess it is possible to retrieve in what transport we are
connected and then check if we it is bonded.

>  gboolean device_is_trusted(struct btd_device *device);
>  void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
>  void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
> --
> 2.2.0.rc0.207.ga3a616c
>



-- 
Luiz Augusto von Dentz
