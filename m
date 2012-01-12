Return-Path: <cyrus@holtmann.org>
Message-ID: <1326407273.6454.250.camel@aeonflux>
Subject: Re: [PATCH] Fix EIR name parsing
From: Marcel Holtmann <marcel@holtmann.org>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 12 Jan 2012 23:27:53 +0100
In-Reply-To: <1326393217-13111-1-git-send-email-bruna.moreira@openbossa.org>
References: <1326393217-13111-1-git-send-email-bruna.moreira@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

> Some vendors put a NUL byte terminator on EIR name field. If that is the
> case, use -1 as string length so g_utf8_validade() can parse it
> properly.
> ---
>  src/eir.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/src/eir.c b/src/eir.c
> index e4554e8..3826f55 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -119,6 +119,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
>  
>  	while (len < eir_len - 1) {
>  		uint8_t field_len = eir_data[0];
> +		ssize_t name_len;
>  
>  		/* Check for the end of EIR */
>  		if (field_len == 0)
> @@ -154,8 +155,16 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
>  
>  		case EIR_NAME_SHORT:
>  		case EIR_NAME_COMPLETE:
> +			/* Some vendors put a NUL byte terminator. If that is
> +			 * the case, use -1 as string length so
> +			 * g_utf8_validade() can parse it properly. */
> +			if (eir_data[field_len] == '\0')
> +				name_len = -1;
> +			else
> +				name_len = field_len - 1;
> +

why do we have to do -1 here? We could just reduce the field_len by 1.
What is the point in g_utf8_validate having to figure out the length of
the data. We do already know it.

Regards

Marcel


