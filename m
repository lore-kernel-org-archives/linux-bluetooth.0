Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 5/5] Extended support for generating dictionary value
 of service UUIDs
From: Marcel Holtmann <marcel@holtmann.org>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	johan.hedberg@gmail.com
In-Reply-To: <1279662974-16454-6-git-send-email-ingas@codeaurora.org>
References: <1279662974-16454-1-git-send-email-ingas@codeaurora.org>
	 <1279662974-16454-6-git-send-email-ingas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Jul 2010 01:46:24 -0700
Message-ID: <1279701984.3035.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

>  src/adapter.c  |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  src/adapter.h  |    4 +-
>  src/dbus-hci.c |    6 ++--
>  3 files changed, 97 insertions(+), 8 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index b22b086..612c3a9 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2763,8 +2763,84 @@ static void emit_device_found(const char *path, const char *address,
>  	g_dbus_send_message(connection, signal);
>  }
>  
> +static int get_uuid_count_eir (uint8_t *eir_data)
> +{

please get the coding style right. It is count_eir(uint8 ...)

> +	uint8_t len = 0;
> +	int count = 0;
> +
> +	while (len < EIR_DATA_LENGTH) {
> +		uint8_t type = eir_data[1];
> +		uint8_t field_len = eir_data[0];
> +		if ((type == EIR_UUID16_SOME) || (type == EIR_UUID16_ALL))
> +			count += field_len/2;

The double ( ) is not needed. So if (type == ... || type == ...). That
is enough actually.

Regards

Marcel


