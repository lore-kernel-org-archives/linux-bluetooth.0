Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Apr 2013 14:24:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v3 1/8] core: Convert the pincode callback to an
 interable list.
Message-ID: <20130424112444.GA15231@x220.ger.corp.intel.com>
References: <1366740247-368-1-git-send-email-deymo@chromium.org>
 <1366740247-368-2-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366740247-368-2-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, Apr 23, 2013, Alex Deymo wrote:
> +struct pincb_iter {
> +	GSList *it;			/* current callback function */
> +	uint32_t attempt;		/* numer of times it() was called */

Why specifically uint32_t? We usually reserve fixed size integer types
for stuff that directly maps to a protocol that really requires it,
whereas for simple iterators "int" should be enough.

> +	iter = device_bonding_iter(device);
> +
> +	if (iter == NULL)

Remove the empty line above. When doing an assignment to a variable and
then testing the variable's value we don't have any empty lines in
between.

Johan
