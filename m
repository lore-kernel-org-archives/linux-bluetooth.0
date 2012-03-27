Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 18:11:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/4] eir: Read GAP appearance from advertising data
Message-ID: <20120327151102.GA444@x220.P-661HNU-F1>
References: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
 <1332854978-26072-5-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332854978-26072-5-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Tue, Mar 27, 2012, Bruna Moreira wrote:
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -108,6 +108,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
>  	while (len < eir_len - 1) {
>  		uint8_t field_len = eir_data[0];
>  		uint8_t data_len, *data = &eir_data[2];
> +		uint16_t *u16;
>  
>  		/* Check for the end of EIR */
>  		if (field_len == 0)
> @@ -164,6 +165,14 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
>  			if (data_len < 3)
>  				break;
>  			memcpy(eir->dev_class, data, 3);
> +			break;
> +
> +		case EIR_GAP_APPEARANCE:
> +			if (data_len < 2)
> +				break;
> +			u16 = (uint16_t *) data;
> +			eir->appearance = btohs(bt_get_unaligned(u16));
> +			break;
>  		}

I don't think you need the u16 variable at all. Just do:

	eir->appearance = bt_get_le16(data);

Johan
