Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Sep 2012 13:07:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jeff Hansen <x@jeffhansen.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] input: Implement idle timeout for fakehid.
Message-ID: <20120905100718.GC766@x220>
References: <1346077185-18377-1-git-send-email-x@jeffhansen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346077185-18377-1-git-send-email-x@jeffhansen.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

On Mon, Aug 27, 2012, Jeff Hansen wrote:
> +		fake->timeout = iconn->timeout * 1000;

Why not use the original iconn->timeout value and then use
g_timeout_add_seconds instead of g_timeout_add?

> +	guint		idle_timeout;
> +	uint32_t	timeout;

Why uint32_t instead of just int that iconn->timeout is?

> +static gboolean ps3remote_idle(gpointer data)
> +{
> +	struct fake_input *fake = data;
> +	input_device_request_disconnect(fake->idev);
> +	return FALSE;
> +}

Could you add an empty line before and after
input_device_request_disconnect for slightly better readability.

> +	if (fake->idle_timeout) {

For consistency with the rest of the code base please use > 0 for
checking for valid GSource IDs. I'd also just call it idle_id to avoid
confusion with "timeout" which is not a GSource ID.

> +		g_source_remove(fake->idle_timeout);
> +		fake->idle_timeout = 0;
> +	}
> +	if (fake->timeout)
> +		fake->idle_timeout = g_timeout_add(fake->timeout, ps3remote_idle, fake);

Please add an empty line before this second if statement and also do > 0
here.

> +	if (fake->idle_timeout) {

And > 0 again here.

Johan
