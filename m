Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1374651156-19959-1-git-send-email-djcb.bulk@gmail.com>
References: <20130724045756.GC14367@x220.p-661hnu-f1>
	<1374651156-19959-1-git-send-email-djcb.bulk@gmail.com>
Date: Wed, 24 Jul 2013 06:55:40 -0400
Message-ID: <CAJdJm_P-Zgg+r1Nc2OevfyQ1QkbpgbSYdVV9B-33WEZm=V553w@mail.gmail.com>
Subject: Re: [PATCH] attrib/gatt_service_add: support 128-bit uuids for characteristics
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dirk-Jan,

On Wed, Jul 24, 2013 at 3:32 AM, Dirk-Jan C. Binnema
<djcb.bulk@gmail.com> wrote:
> @@ -183,10 +189,11 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
>         uint16_t h = *handle;
>         struct attribute *a;
>         bt_uuid_t bt_uuid;
> -       uint8_t atval[5];
> +       uint8_t atval[131];

Where "131" comes from? A UUID has 128 bits (i.e. 16 bytes). Anyway, I
suggest using atval[ATT_MAX_VALUE_LEN] and not worry about the size
here, as long as you pass the exact site to atttrib_db_add(), as you
do below.

> @@ -222,9 +229,9 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
>         bt_uuid16_create(&bt_uuid, GATT_CHARAC_UUID);
>         atval[0] = info->props;
>         att_put_u16(h + 1, &atval[1]);
> -       att_put_u16(info->uuid.value.u16, &atval[3]);
> +       att_put_uuid(info->uuid, &atval[3]);
>         if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
> -                                               atval, sizeof(atval)) == NULL)
> +                               atval, 3 + info->uuid.type/8) == NULL)

Add spaces around "/" here, i.e: 3 + info->uuid.type / 8

>                 return FALSE;
>
>         /* characteristic value */
> @@ -341,7 +348,7 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
>         }
>
>         g_assert(size < USHRT_MAX);
> -       g_assert(h - start_handle == (uint16_t) size);
> +       g_assert((uint16_t) (h - start_handle) == (uint16_t) size);

This actually seems unrelated to the patch. Can you put it into a
separate patch with the compilation error you got?

>         g_slist_free_full(chrs, free_gatt_info);
>
>         return TRUE;
> [...]
> diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
> index b810e2e..5c3e15d 100644
> --- a/attrib/gatt-service.h
> +++ b/attrib/gatt-service.h
> @@ -25,6 +25,7 @@
>  typedef enum {
>         GATT_OPT_INVALID = 0,
>         GATT_OPT_CHR_UUID,
> +       GATT_OPT_CHR_BT_UUID_T,

My suggestion would be to rename the old one to GATT_OPT_CHR_UUID16
and this could be GATT_OPT_CHR_UUID. But as Johan said, this could be
in a separate patch.

>         GATT_OPT_CHR_PROPS,
>         GATT_OPT_CHR_VALUE_CB,
>         GATT_OPT_CHR_AUTHENTICATION,

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
