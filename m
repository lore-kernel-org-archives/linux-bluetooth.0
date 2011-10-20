Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Oct 2011 14:19:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Simplify eir_parse function
Message-ID: <20111020111956.GA5742@fusion.localdomain>
References: <1319100817-8477-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1319100817-8477-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Oct 20, 2011, Frédéric Danis wrote:
> -int eir_parse(struct eir_data *eir, uint8_t *eir_data)
> +static void eir_parse_uuid16(struct eir_data *eir, uint8_t *data, uint8_t len)

If you change data to void * it'd make the following changes easier:

> +	uint8_t *uuid_ptr = data;

How about uint16_t *u16 = data;

It would then make the iteration and conversion easier:

> +	service.type = SDP_UUID16;
> +	for (i = 0; i < len / 2; i++) {
> +		val16 = uuid_ptr[1];
> +		val16 = (val16 << 8) + uuid_ptr[0];
> +		service.value.uuid16 = val16;

This could be simply:

	service.value.uuid16 = btohs(bt_get_unaligned(u16));

> +		uuid_str = bt_uuid2string(&service);
> +		eir->services = g_slist_append(eir->services, uuid_str);
> +		uuid_ptr += 2;

And this u16++, actually just put it after i++ directly in the loop
definintion.

> +static void eir_parse_uuid32(struct eir_data *eir, uint8_t *data, uint8_t len)
> +{
> +	uint8_t *uuid_ptr = data;

uint32_t *u32 = data; (assuming you make data void * like above)

> +	service.type = SDP_UUID32;
> +	for (i = 0; i < len / 4; i++) {
> +		val32 = uuid_ptr[3];
> +		for (k = 2; k >= 0; k--)
> +			val32 = (val32 << 8) + uuid_ptr[k];
> +		service.value.uuid32 = val32;

Just change this all to:

		service.value.uuid32 = bt_get_unaligned(btohl(u32));

> +		uuid_ptr += 4;

And move this to the for-loop definition after i++ as u32++

>  		case EIR_NAME_SHORT:
>  		case EIR_NAME_COMPLETE:
> -			name = (const char *) &eir_data[2];
> -			name_len = field_len - 1;
> +			if (g_utf8_validate((char *) &eir_data[2],
> +							field_len - 1, NULL))
> +				eir->name = g_strndup((char *) &eir_data[2],
> +								field_len - 1);
> +			else
> +				eir->name = g_strdup("");
>  			eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
>  			break;

If there are multiple name tags in the EIR data you would leak here all
of them except the last one (devices shouldn't have this but you can't
control all sorts of crazy things people do). To keep the behavior as
the existing code, free eir->name when encountering multiple tags and
just keep the last one.

Also, If the name isn't valid UTF-8 I suppose you can just keep
eir->name as NULL instead of pointing to an empty string?

Johan
