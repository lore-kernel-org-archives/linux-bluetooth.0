Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Apr 2013 14:37:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v3 7/8] core: Expose the last bonding attempt timeout on
 retry
Message-ID: <20130424113718.GD15231@x220.ger.corp.intel.com>
References: <1366740247-368-1-git-send-email-deymo@chromium.org>
 <1366740247-368-8-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366740247-368-8-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, Apr 23, 2013, Alex Deymo wrote:
> +	gint64 attempt_start_time_us;
> +	gint64 last_attempt_duration_us;
>  };
>  
>  typedef enum {
> @@ -1420,12 +1422,52 @@ static struct bonding_req *bonding_request_new(DBusMessage *msg,
>  
>  	bonding->capability = io_cap;
>  
> +	/* Marks the bonding start time for the first attempt on request
> +	 * construction. The following attempts will be updated on
> +	 * device_bonding_retry. */
> +	bonding->attempt_start_time_us = g_get_monotonic_time();

Since we're in the long run aiming to remove the GLib dependency, I'm
not so sure it's the best idea to add yet another dependency to a GLib
feature. Would it be that much more complicated to just use libc
directly for this? OTOH, if Marcel doesn't mind this new GLib API
dependency I'm not gonna object to this patch.

Johan
