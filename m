Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 11:18:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 3/6] Support for adding UUID128 to extended inquiry
 response
Message-ID: <20100803081846.GB5831@jh-x301>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
 <1280576713-1398-4-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280576713-1398-4-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Sat, Jul 31, 2010, Inga Stotland wrote:
> ---
>  src/sdpd-service.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 62 insertions(+), 0 deletions(-)

A couple of coding style comments here:

> +		/* Check for duplicates, EIR data is Little Endian */
> +		for (i = 0; i < index; i++) {
> +			for (k = 0; k < SIZEOF_UUID128; k++) {
> +				if (uuid128[i*SIZEOF_UUID128 + k] !=

Space before and after *

> +					rec->svclass.value.uuid128.data[SIZEOF_UUID128 - k])

Looks like you're going beyond 80-characters. Maybe you could create an
extra variable and assign rec->svclass.value.uuid.data to it.

> +		for (k = 0; k < SIZEOF_UUID128; k++)
> +			uuid128[index*SIZEOF_UUID128 + k] =

Space before and after *

> +				rec->svclass.value.uuid128.data[SIZEOF_UUID128 - 1 - k];

Again over 80-characters, but if you use the extra variable that I
previously suggested for rec->svclass.value.uuid128.data it should help.

> +		ptr[1] = (truncated) ? EIR_UUID128_SOME : EIR_UUID128_ALL;

Since truncated is just a gboolean and not a more complex statement I'd
just leave out the parenthesis around it, but quite a minor thing in the
end.

Johan
