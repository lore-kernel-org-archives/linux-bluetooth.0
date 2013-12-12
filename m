Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386757887-29018-6-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
	<1386757887-29018-6-git-send-email-szymon.janc@tieto.com>
Date: Wed, 11 Dec 2013 22:04:32 -0200
Message-ID: <CAJdJm_N2aABBteKtWyRXh_-a8Oy722BMbZSrH_koNYbY8F5hpA@mail.gmail.com>
Subject: Re: [PATCH 6/9] android/bluetooth: Add support for remote device RSSI
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 11, 2013 at 7:31 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
\> @@ -2306,11 +2309,13 @@ static uint8_t
get_device_friendly_name(struct device *dev)
>
>  static uint8_t get_device_rssi(struct device *dev)
>  {
> -       DBG("Not implemented");
> +       if (!dev->rssi)
> +               return HAL_STATUS_FAILED;

0 dBm is a valid RSSI value, so I suppose this code needs some other
way to identify an uninitialized value (e.g. a second boolean field.)

>
> -       /* TODO */
> +       send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_RSSI,
> +                                               sizeof(dev->rssi), &dev->rssi);
>
> -       return HAL_STATUS_FAILED;
> +       return HAL_STATUS_SUCCESS;
>  }

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
