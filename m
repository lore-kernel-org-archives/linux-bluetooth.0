Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Aug 2010 13:25:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
 "Device Found" signal.
Message-ID: <20100805102513.GA7221@jh-x301>
References: <1280962831-18147-1-git-send-email-ingas@codeaurora.org>
 <1280962831-18147-8-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280962831-18147-8-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Wed, Aug 04, 2010, Inga Stotland wrote:
> ---
>  src/adapter.c  |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  src/adapter.h  |    4 +-
>  src/dbus-hci.c |    6 ++--
>  3 files changed, 102 insertions(+), 8 deletions(-)

I've pushed the six other patches upstream, but I'm still a bit
concerned with this one. First there's a minor coding style issue:

> +static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
> +{
> +	uint8_t len = 0;
> +	char **uuids = NULL;
> +	size_t total = 0;

Neither the uuids nor the total variable need to be initialized upon
declaration if you look at the function's code flow. In general
initialization upon declaration of variables is something that should be
avoided whenever not strictly needed since it can hide real issues that
the compiler would otherwise be able to catch.

Then, a more general concern about this function. It will receive data
as input that any nearby device that's discoverable has declared in
their EIR data. I.e. we need to be super strict about checking the
validity of the data and not make any assumptions about the correctness
of encoded field lengths etc. in order not to do buffer overflows. Have
you taken this into account when designing the function? Looking at it
it seems it might be possible to give it data that will cause some
buffer overflows (by e.g. placing a uuid list at the very end of the EIR
data with an invalid field length value).

Johan
