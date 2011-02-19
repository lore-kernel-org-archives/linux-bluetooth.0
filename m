Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-15-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<1298068173-16518-15-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 18 Feb 2011 22:24:51 -0300
Message-ID: <AANLkTim4ieVO2mwXo=hOgVwi1wFs9KTznfxSMsaZ2K1v@mail.gmail.com>
Subject: Re: [RFC v2 14/14] Change Attribute example to create UUID128 on host order
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Feb 18, 2011 at 7:29 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> ---
>  attrib/example.c |   23 ++++++++++++++---------
>  1 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/attrib/example.c b/attrib/example.c
> index f5fcf1b..6e39a68 100644
> --- a/attrib/example.c
> +++ b/attrib/example.c
> @@ -60,6 +60,14 @@
>  #define FMT_KILOGRAM_UUID              0xA010
>  #define FMT_HANGING_UUID               0xA011
>
> +#define CHAR_WEIGHT_UUID (&(uint128_t) {{ \
> +                       0x80, 0x88, 0xF2, 0x18, 0x90, 0x2C, 0x45, 0x0B, \
> +                       0xB6, 0xC4, 0x62, 0x89, 0x1E, 0x8C, 0x25, 0xE9 }})
> +
> +#define PRIM_WEIGHT_UUID (&(uint128_t) {{ \
> +                       0x4F, 0x0A, 0xC0, 0x96, 0x35, 0xD4, 0x49, 0x11, \
> +                       0x96, 0x31, 0xDE, 0xA8, 0xDC, 0x74, 0xEE, 0xFE }})
> +
>  static int register_attributes(void)
>  {
>        const char *desc_out_temp = "Outside Temperature";
> @@ -69,14 +77,9 @@ static int register_attributes(void)
>        const char *manufacturer_name2 = "ACME Weighing Scales";
>        const char *serial1 = "237495-3282-A";
>        const char *serial2 = "11267-2327A00239";
> -       const unsigned char char_weight_uuid[] = { 0x80, 0x88, 0xF2, 0x18, 0x90,
> -               0x2C, 0x45, 0x0B, 0xB6, 0xC4, 0x62, 0x89, 0x1E, 0x8C, 0x25,
> -               0xE9 };
> -       const unsigned char prim_weight_uuid[] = { 0x4F, 0x0A, 0xC0, 0x96, 0x35,
> -               0xD4, 0x49, 0x11, 0x96, 0x31, 0xDE, 0xA8, 0xDC, 0x74, 0xEE,
> -               0xFE };
>        uint8_t atval[256];
>        uuid_t uuid;
> +       uint128_t h128;
>        int len;
>
>        /* Battery state service: primary service definition */
> @@ -260,7 +263,8 @@ static int register_attributes(void)
>
>        /* Weight service: primary service definition */
>        sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> -       memcpy(atval, prim_weight_uuid, 16);
> +       ntoh128(PRIM_WEIGHT_UUID, &h128);
> +       att_put_u128(h128, atval);
>        attrib_db_add(0x0680, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 16);
>
>        /* Weight: include */
> @@ -274,11 +278,12 @@ static int register_attributes(void)
>        sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
>        atval[0] = ATT_CHAR_PROPER_READ;
>        att_put_u16(0x0683, &atval[1]);
> -       memcpy(&atval[3], char_weight_uuid, 16);

You missed a "ntoh128(CHAR_WEIGHT_UUID, &h128);" right here.

> +       att_put_u128(h128, &atval[3]);
>        attrib_db_add(0x0682, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 19);
>
>        /* Weight: characteristic value */
> -       sdp_uuid128_create(&uuid, char_weight_uuid);
> +       ntoh128(CHAR_WEIGHT_UUID, &h128);
> +       sdp_uuid128_create(&uuid, &h128);
>        atval[0] = 0x82;
>        atval[1] = 0x55;
>        atval[2] = 0x00;
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
