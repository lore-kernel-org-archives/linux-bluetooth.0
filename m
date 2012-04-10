Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Apr 2012 13:33:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] mgmtops: Handle Start Discovery Complete in case of
 failure
Message-ID: <20120410103306.GA9418@x220>
References: <1334052807-14320-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334052807-14320-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Tue, Apr 10, 2012, Hemant Gupta wrote:
> This patch adds handling of start discovery complete event in cases
> when discovery fails to get started.
> ---
>  plugins/mgmtops.c |   33 ++++++++++++++++++++++++++++++++-
>  1 files changed, 32 insertions(+), 1 deletions(-)

The patch is now applied but I still had to fix it up manually myself:

> +static void start_discovery_complete(int sk, uint16_t index, uint8_t status,
> +				     void *buf, size_t len)

Incorrect indentation above: you should indent with tabs as much as
possible while remaining under the 80 character boundary.

> +	if (len != sizeof(*type)) {
> +		error("start_discovery_complete event size mismatch "
> +			"(%zu != %zu)", len, sizeof(*type));

This should also be indented more.

> +	DBG("type %u status %u", *type, status);

Where did the hci%u go? I meant move the entire DBG statement here and
not just part of it (it's perfectly fine to print the index value even
though it's > max_index).

> +	if (index > max_index) {
> +		error("Unexpected index %u in start_discovery_complete",
> +			index);

Incorrect indentation again (should be indented more)

> +	DBG("hci%u", index);

And the above should go away assuming that you move the entire statement
to the new location.

I think we'll need to reexamine the user space coding style now that the
kernel doesn't use a strict tabs-only approach anymore. But for now
we're still following the style we've always used in user space.

Johan
