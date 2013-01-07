Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jan 2013 10:27:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/4] input: Validate SDP HIDDescriptorList
 subattributes
Message-ID: <20130107082734.GA8075@x220.ger.corp.intel.com>
References: <1357501558-3457-1-git-send-email-anderson.lizardo@openbossa.org>
 <1357501558-3457-4-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357501558-3457-4-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sun, Jan 06, 2013, Anderson Lizardo wrote:
> It should not be assumed that remote SDP attributes are in a compliant
> format. This fixes a couple of invalid pointer access on invalid data.
> ---
>  profiles/input/device.c |   60 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 14 deletions(-)

I've applied the first three patches, but this one needs a bit of fixing
up:

> +	if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
> +		goto invalid_desc;

Please always be explicit on what values you're checking for instead of
assuming that the reader of the code knows what's contained within some
range. In this case there's already a convenient SDP_IS_SEQ() macro you
could use.

> +	if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
> +		goto invalid_desc;

Same here.

> +	if (!d || d->dtd < SDP_TEXT_STR8 || d->dtd > SDP_TEXT_STR32)
> +		goto invalid_desc;

I suppose the best way to handle this one is to add a SDP_IS_STR() macro
(in a separate patch) to lib/sdp.h and then use it in this patch.

Johan
