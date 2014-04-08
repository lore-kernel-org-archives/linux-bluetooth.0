Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1396877011-30322-1-git-send-email-b.sudha@samsung.com>
References: <1396877011-30322-1-git-send-email-b.sudha@samsung.com>
Date: Tue, 8 Apr 2014 11:55:11 +0300
Message-ID: <CABBYNZJ4u0z3ZMp3ruqoDK1BGXXzn1HPHYr_eA_aADkAAacHBQ@mail.gmail.com>
Subject: Re: [PATCH] [Bluetooth 4.1][32bit-UUID Support] Added support for 32
 bit uuid for the Attribute type in ATT and GATT for GATT Client devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sudha Bheemanna <b.sudha@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 7, 2014 at 4:23 PM, Sudha Bheemanna <b.sudha@samsung.com> wrote:
> 1> As per 4.0 spec support for only 16 and 128 bit support was provided for attribute type in GATT.
> 2> As a part of core 4.1 spec, 32 bit uuid support is also added. The code changes for the same
>    in ATT and GATT is added as a part of this patch for GATT client role.
> ---
>  attrib/att.c  |   12 ++++++++++++
>  attrib/gatt.c |   11 +++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/attrib/att.c b/attrib/att.c
> index 8e9c06d..2225255 100644
> --- a/attrib/att.c
> +++ b/attrib/att.c
> @@ -42,6 +42,8 @@ static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
>  {
>         if (src->type == BT_UUID16)
>                 put_le16(src->value.u16, dst);
> +       else if (src->type == BT_UUID32)
> +               put_le32(src->value.u32, dst);
>         else
>                 /* Convert from 128-bit BE to LE */
>                 bswap_128(&src->value.u128, dst);
> @@ -134,6 +136,8 @@ static void get_uuid(uint8_t type, const void *val, bt_uuid_t *uuid)
>  {
>         if (type == BT_UUID16)
>                 bt_uuid16_create(uuid, get_le16(val));
> +       else if (type == BT_UUID32)
> +               bt_uuid32_create(uuid, get_le32(val));
>         else {
>                 uint128_t u128;
>
> @@ -153,6 +157,8 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
>
>         if (uuid->type == BT_UUID16)
>                 uuid_len = 2;
> +       else if (uuid->type == BT_UUID32)
> +               uuid_len = 4;
>         else if (uuid->type == BT_UUID128)
>                 uuid_len = 16;
>         else
> @@ -187,6 +193,8 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
>
>         if (len == (min_len + 2))
>                 type = BT_UUID16;
> +       else if (len == (min_len + 4))
> +               type = BT_UUID32;
>         else if (len == (min_len + 16))
>                 type = BT_UUID128;
>         else
> @@ -398,6 +406,8 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
>
>         if (uuid->type == BT_UUID16)
>                 uuid_len = 2;
> +       else if (uuid->type == BT_UUID32)
> +               uuid_len = 4;
>         else if (uuid->type == BT_UUID128)
>                 uuid_len = 16;
>         else
> @@ -429,6 +439,8 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
>
>         if (len == (min_len + 2))
>                 type = BT_UUID16;
> +       if (len == (min_len + 4))
> +               type = BT_UUID32;
>         else if (len == (min_len + 16))
>                 type = BT_UUID128;
>         else
> diff --git a/attrib/gatt.c b/attrib/gatt.c
> index 49cd1a3..bb2330a 100644
> --- a/attrib/gatt.c
> +++ b/attrib/gatt.c
> @@ -143,6 +143,8 @@ static void put_uuid_le(const bt_uuid_t *uuid, void *dst)
>  {
>         if (uuid->type == BT_UUID16)
>                 put_le16(uuid->value.u16, dst);
> +       else if (uuid->type == BT_UUID32)
> +               put_le32(uuid->value.u32, dst);
>         else
>                 /* Convert from 128-bit BE to LE */
>                 bswap_128(&uuid->value.u128, dst);
> @@ -155,6 +157,11 @@ static void get_uuid128(uint8_t type, const void *val, bt_uuid_t *uuid)
>
>                 bt_uuid16_create(&uuid16, get_le16(val));
>                 bt_uuid_to_uuid128(&uuid16, uuid);
> +       } else if (type == BT_UUID32) {
> +               bt_uuid_t uuid32;
> +
> +               bt_uuid32_create(&uuid32, get_le32(val));
> +               bt_uuid_to_uuid128(&uuid32, uuid);
>         } else {
>                 uint128_t u128;
>
> @@ -256,6 +263,8 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
>
>         if (list->len == 6)
>                 type = BT_UUID16;
> +       else if (list->len == 8)
> +               type = BT_UUID32;
>         else if (list->len == 20)
>                 type = BT_UUID128;
>         else {
> @@ -519,6 +528,8 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
>
>         if (list->len == 7)
>                 type = BT_UUID16;
> +       else if (list->len == 9)
> +               type = BT_UUID32;
>         else
>                 type = BT_UUID128;
>
> --
> 1.7.9.5

Overall your patch look good, but the commit message is way too big
can you format so it looks nice on git shortlog and other git
commands.



-- 
Luiz Augusto von Dentz
