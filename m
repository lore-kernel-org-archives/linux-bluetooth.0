Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Apr 2013 14:42:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v3 1/8] core: Convert the pincode callback to an
 interable list.
Message-ID: <20130424114234.GE15231@x220.ger.corp.intel.com>
References: <1366740247-368-1-git-send-email-deymo@chromium.org>
 <1366740247-368-2-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366740247-368-2-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, Apr 23, 2013, Alex Deymo wrote:
> +gboolean pincb_iter_end(struct pincb_iter *iter)
> +{
> +	return iter->it == NULL && iter->attempt == 0;
> +}

Related to the avoidance of GLib dependencies we're also in the progress
of converting "gboolean" to "bool" in any code that doesn't directly
deal with GLib APIs. This also means that we try to use bool instead of
gboolean in all new code.

Johan
