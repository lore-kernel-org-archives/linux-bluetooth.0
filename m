Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Aug 2010 10:55:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
 "Device Found" signal.
Message-ID: <20100806075552.GA22150@jh-x301>
References: <20100805102513.GA7221@jh-x301>
 <1281047801-4044-1-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281047801-4044-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Thu, Aug 05, 2010, Inga Stotland wrote:
> +	while (len < EIR_DATA_LENGTH - 1) {
> +		uint8_t type = eir_data[1];
> +		uint8_t field_len = eir_data[0];
> +
> +		/* Check for the end of EIR */
> +		if (field_len == 0)
> +			break;

Shouldn't there also be another check here:

		/* Bail out if field_len claims to reach beyond the EIR
		 * data end */
		if (len + field_len + 1 >= EIR_DATA_LENGTH)
			break;

Johan
