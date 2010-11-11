Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 23:07:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v2 1/7] Fix invalid memory access when EIR field length
 is zero
Message-ID: <20101111210705.GB24514@jh-x301>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 11, 2010, Vinicius Costa Gomes wrote:
> diff --git a/src/adapter.c b/src/adapter.c
> index b1aabbd..8b742b7 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2977,14 +2977,13 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
>  	unsigned int i;
>  
>  	while (len < EIR_DATA_LENGTH - 1) {
> -		uint8_t type = eir_data[1];
>  		uint8_t field_len = eir_data[0];
>  
>  		/* Check for the end of EIR */
>  		if (field_len == 0)
>  			break;
>  
> -		switch (type) {
> +		switch (eir_data[1]) {
>  		case EIR_UUID16_SOME:
>  		case EIR_UUID16_ALL:
>  			uuid16_count = field_len / 2;

Pushed upstream. Thanks.

Johan
