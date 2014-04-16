Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397642813-18424-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1397642813-18424-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Wed, 16 Apr 2014 12:30:54 +0200
Message-ID: <CAF3PWx3POCgEh4pSMS=+x4DARj6fjti2LSMcSipDiW7Rzm_Ong@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/gatt: Extend android2uuid uuid type support
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On 16 April 2014 12:06, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> Now conversion function android2uuid can recognize type of uuid and set
> it value by copying significant bytes.
> ---
>  android/gatt.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 243e02f..9163f6d 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -54,6 +54,14 @@
>  #define GATT_SUCCESS   0x00000000
>  #define GATT_FAILURE   0x00000101
>
> +#define BASE_UUID16_OFFSET     12
> +#define BASE_UUID32_OFFSET     10
> +
> +static uint8_t BLUETOOTH_UUID[] = {
> +       0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +       0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +};
> +
>  struct gatt_client {
>         int32_t id;
>         uint8_t uuid[16];
> @@ -132,14 +140,48 @@ static struct queue *disc_dev_list = NULL;        /* Disconnected devices */
>
>  static void bt_le_discovery_stop_cb(void);
>
> +static int get_type_from_android_uuid(const uint8_t *uuid)
> +{
> +       int i;
> +
> +       for (i = 0; i < 16; i++) {
> +               /* minimal uuid (16) value */
> +               if (i == 12 || i == 13)
> +                       continue;
> +
> +               if (uuid[i] != BLUETOOTH_UUID[i])
> +                       break;
> +       }
> +
> +       if (i < 12)
> +               return BT_UUID128;
> +       if (i < 14)
> +               return BT_UUID32;
> +       return BT_UUID16;
> +}

Since this is used for GATT operations you only need to handle either
16-bit or 128-bit UUIDs since 32-bit UUIDs should be converted to
128-bit for ATT PDU anyway.

BR,
Andrzej
