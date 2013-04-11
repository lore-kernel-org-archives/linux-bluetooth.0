Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 1/6] core: Convert the pincode callback to an interable list.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365628753-16774-2-git-send-email-deymo@chromium.org>
Date: Wed, 10 Apr 2013 22:05:01 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DFCDACC7-ECDB-45E1-BDD0-68794E29D51D@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org> <1365628753-16774-2-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> The current pincode callback list on the adapter keeps track of all the
> pincode callbacks registered by a plugin for that adapter and calls each
> one until one provides a pincode for the current bonding. This mechanism
> forgets about what happened with previous bonding attempts and pushes the
> status track to the plugin side.
> 
> This patch creates an iterator struct (struct pincb_iter) that keeps track
> of the last function called and the number of times called. This will
> allow to provide more information about the bonding status to the pincode
> callback.
> ---
> src/adapter.c | 51 +++++++++++++++++++++++++++++++++++++++++++--------
> src/adapter.h |  4 ++++
> src/device.c  | 13 +++++++++++++
> src/device.h  |  1 +
> 4 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 6255da6..957f829 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -121,6 +121,12 @@ struct service_auth {
> 	struct agent *agent;		/* NULL for queued auths */
> };
> 
> +struct pincb_iter {
> +	GSList *it;			/* current callback function */
> +	int count;			/* numer of times it() was called */
> +	/* When the iterator reaches the end, it is NULL and count is -1 */
> +};
> +

explain to me why this iter struct is needed. I am a little bit lost on the nested GSList in it.

I get the basic idea what this patch tries to achieve, but it looks a bit too complicated to me.

Regards

Marcel

