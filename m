Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412941053-11835-1-git-send-email-fons@spotify.com>
References: <1412941053-11835-1-git-send-email-fons@spotify.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Fri, 10 Oct 2014 17:27:31 +0200
Message-ID: <CAHF=Y4pK0XC63ThZchFd1qu3+MVh9B=+35v5U4oKcMNAe9e9Og@mail.gmail.com>
Subject: Re: [PATCH] core: Add Manufacturer Specific Data EIR field
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Please ignore this first patch. I sent a new bundle "[PATCH v2 0/2] core:
Add plugin-support for Manufacturer Specific Data EIR" with more
context and an extra patch for subscribing to MSD from plugins.

On Fri, Oct 10, 2014 at 1:37 PM, Alfonso Acosta <fons@spotify.com> wrote:
> Athough the Manufacturer Specific Data field is not used internally,
> it's useful for external plugins, e.g. iBeacon.
> ---
>  src/eir.c | 8 ++++++++
>  src/eir.h | 4 ++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/src/eir.c b/src/eir.c
> index d22ad91..f130855 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -240,6 +240,14 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
>                         eir->did_product = data[4] | (data[5] << 8);
>                         eir->did_version = data[6] | (data[7] << 8);
>                         break;
> +
> +               case EIR_MANUFACTURER_DATA:
> +                       if (data_len < 2)
> +                               break;
> +                       eir->msd_company = get_le16(data);
> +                       eir->msd_data_len = data_len - 2;
> +                       memcpy(&eir->msd_data, data+2, eir->msd_data_len);
> +                       break;
>                 }
>
>                 eir_data += field_len + 1;
> diff --git a/src/eir.h b/src/eir.h
> index e486fa2..88a5bf0 100644
> --- a/src/eir.h
> +++ b/src/eir.h
> @@ -37,6 +37,7 @@
>  #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
>  #define EIR_DEVICE_ID               0x10  /* device ID */
>  #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
> +#define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
>
>  /* Flags Descriptions */
>  #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
> @@ -62,6 +63,9 @@ struct eir_data {
>         uint16_t did_product;
>         uint16_t did_version;
>         uint16_t did_source;
> +       uint16_t msd_company;
> +       uint8_t msd_data[HCI_MAX_EIR_LENGTH];
> +       uint8_t msd_data_len;
>  };
>
>  void eir_data_free(struct eir_data *eir);
> --
> 1.9.1
>



-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
