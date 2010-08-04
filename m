Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Aug 2010 22:11:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
 "Device Found" signal.
Message-ID: <20100804191134.GA18869@jh-x301>
References: <1280941655-14313-1-git-send-email-ingas@codeaurora.org>
 <1280941655-14313-8-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280941655-14313-8-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Wed, Aug 04, 2010, Inga Stotland wrote:
> ---
>  src/adapter.c  |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  src/adapter.h  |    4 +-
>  src/dbus-hci.c |    6 ++--
>  3 files changed, 108 insertions(+), 8 deletions(-)

A few more things here:

> +static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
> +{
> +	uint8_t len = 0;
> +	char **uuid_buf = NULL;
> +	char **uuids;
<snip>
> +	uuid_buf = g_new0(char *, total + 1);
> +
> +	if (!uuid_buf)
> +		return NULL;
> +
> +	uuids = uuid_buf;

First of all, g_new0 is guaranteed to return non-NULL. If something goes
wrong with the memory allocation abort() will be called and the process
will exit. So the NULL check is redundant. Secondly, I don't think you
need both of these variables (see further below).

> +	for (i = 0; i < uuid16_count; i++) {
> +		uint16_t val16 = uuid16[1];
> +
> +		val16 = (val16<<8) + uuid16[0];

Space missing before and after <<

> +		service.value.uuid16 = val16;
> +		*uuids++ = bt_uuid2string(&service);

Instead of incrementing the pointer you could just do

	uuids[i] = bt_uuid2string(&service);

That way the original pointer stays unchanged and you don't need the
second one.

Johan
