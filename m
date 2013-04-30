Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:16:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v4 1/8] core: Convert the pincode callback to an
 interable list.
Message-ID: <20130430081629.GA777@x220.ger.corp.intel.com>
References: <1367006741-28907-1-git-send-email-deymo@chromium.org>
 <1367006741-28907-2-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367006741-28907-2-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Fri, Apr 26, 2013, Alex Deymo wrote:
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
>  src/adapter.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  src/adapter.h |  4 ++++
>  src/device.c  | 14 ++++++++++++++
>  src/device.h  |  1 +
>  4 files changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 6255da6..f343178 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -121,6 +121,12 @@ struct service_auth {
>  	struct agent *agent;		/* NULL for queued auths */
>  };
>  
> +struct pincb_iter {

What concerns me a bit about this is that you're now introducing the
first symbols exported by adapter.{c.h} that are not name spaced with
btd_adapter* or adapter*. Would it make sense to keep this name spacing
even for the iterator?

> +	unsigned int attempt;		/* numer of times it() was called */

Just use int and not unsigned int. It's what we typically use for
iterator variables.

Johan
