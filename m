Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Apr 2013 12:26:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH BlueZ v4 2/3] service: Add callbacks to track state
 changes
Message-ID: <20130426092600.GA15067@x220.ger.corp.intel.com>
References: <1366965552-14146-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1366965552-14146-3-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366965552-14146-3-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Apr 26, 2013, Mikel Astiz wrote:
> +static GSList *state_callbacks;

I know it's not strictly speaking necessary but the convention in the
source tree is to explicitly initialize this kind of variables to NULL.

> +gboolean btd_service_remove_state_cb(guint id)

Please use bool instead of gboolean (since we're trying to avoid GLib
types whenever possible).

> +	for (l = state_callbacks; l != NULL; l = g_slist_next(l)) {
> +		struct service_state_callback *cb = l->data;
> +
> +		if (cb && cb->id == id) {
> +			state_callbacks = g_slist_remove_link(state_callbacks,
> +									l);

This leaks l. It should be delete_link() instead of remove_link(),
however I don't see why you shouldn't just use g_slist_remove(list, cb);
since that'll even fit on a single line in this case.

Johan
