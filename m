Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 11:36:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 6/6] Support for generating dictionary value of service
 UUIDs.
Message-ID: <20100803083641.GD5831@jh-x301>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
 <1280576713-1398-7-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280576713-1398-7-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Sat, Jul 31, 2010, Inga Stotland wrote:
> Add service UUIDs from EIR to device properties in "Device Found" signal.
> ---
>  src/adapter.c  |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  src/adapter.h  |    4 +-
>  src/dbus-hci.c |    6 ++--
>  3 files changed, 97 insertions(+), 8 deletions(-)

A few more coding style issues:

> +	while (len < EIR_DATA_LENGTH) {
> +		uint8_t type = eir_data[1];
> +		uint8_t field_len = eir_data[0];

Add an empty line here (it's almost always a good thing to have after
variable declarations).

> +		if (type == EIR_UUID16_SOME || type == EIR_UUID16_ALL)
> +			count += field_len/2;

Space before and after /

> +		else if (type == EIR_UUID32_SOME || type == EIR_UUID32_ALL)
> +			count += field_len/4;

Same here.

> +		else if (type == EIR_UUID128_SOME || type == EIR_UUID128_ALL)
> +			count += field_len/16;

And here

> +			count = field_len/size;

And here

> +			count = field_len/size;

And here


> +					val32 = (val32<<8) + data[k];

Space before and after <<

> +			count = field_len/size;

Space before and after /

> +					service.value.uuid128.data[k] = data[size-k-1];

Space before and after -

> +	/* Extract UUIDs from extended inquiry response if any*/
> +	if (eir_data != NULL)
> +		uuid_count = get_uuid_count_eir(eir_data);
> +
> +	if (uuid_count > 0) {
> +		uuids = g_new0(char *, uuid_count + 1);
> +		get_uuids_eir(uuids, eir_data);
> +	}
> +

I don't think these two get_uuids_eir and get_uuid_count_eir functions
are really needed. Could you change it to just one function:

char **get_eir_uuids(const uint8_t *eir_data, size_t *count)

Johan
