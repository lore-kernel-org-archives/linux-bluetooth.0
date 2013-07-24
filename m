Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Jul 2013 21:57:56 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib/gatt_service_add: support 128-bit uuids for
 characteristics
Message-ID: <20130724045756.GC14367@x220.p-661hnu-f1>
References: <1374587243-30452-1-git-send-email-djcb.bulk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374587243-30452-1-git-send-email-djcb.bulk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dirk-Jan,

On Tue, Jul 23, 2013, Dirk-Jan C. Binnema wrote:
> +		case GATT_OPT_CHR_BT_UUID_T:
> +			memcpy(&info->uuid, va_arg(args, bt_uuid_t *), sizeof(bt_uuid_t));

The above looks like a too long line to me. Please stick to under 80
characters.

>  static gboolean add_characteristic(struct btd_adapter *adapter,
> -				uint16_t *handle, struct gatt_info *info)
> +				   uint16_t *handle, struct gatt_info *info)

The above coding style change seems unrelated to this patch.

> -	if (!info->uuid.value.u16 || !info->props) {
> +	if ((!info->uuid.value.u16 && info->uuid.type != BT_UUID128) || !info->props) {

Looks like a too long line as well.

info->uuid.value is a union so I don't think it's safe to check any
particular member before you've checked uuid.type. However, isn't what
you want above to check that you have a BT_UUID16 or BT_UUID128? I.e.
there should be no need to check for info->uuid.value.u16 directly.

>  	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
> -						atval, sizeof(atval)) == NULL)
> +			  atval, 3 + info->uuid.type/8) == NULL)

It looks like the above change introduces a mix of spaces and tabs for
indentation. The user space style is to use only tabs (indent as much as
you can as long as you don't go over 80 characters).

> -	g_assert(h - start_handle == (uint16_t) size);
> +	g_assert((uint16_t)(h - start_handle) == (uint16_t) size);

Be consistent with the coding style here: type casts should have a space
between the cast and the variable.

>  typedef enum {
>  	GATT_OPT_INVALID = 0,
>  	GATT_OPT_CHR_UUID,
> +	GATT_OPT_CHR_BT_UUID_T,
>  	GATT_OPT_CHR_PROPS,
>  	GATT_OPT_CHR_VALUE_CB,
>  	GATT_OPT_CHR_AUTHENTICATION,

To be honest, I'm not 100% sure this is the best name for the new
option, but I can't really think of anything much better either.
Renaming the existing one to UUID_STR and the new one to UUID (like the
old one was) would be one option, but it's one more patch and more code
changes.

Johan
