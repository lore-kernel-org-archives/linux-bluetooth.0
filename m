Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Oct 2010 14:26:44 -0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Provide extra query for vCard single call
Message-ID: <20101025162644.GA13585@jh-x301>
References: <1287997498-2576-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287997498-2576-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Oct 25, 2010, Rafal Michalski wrote:
> This patch makes that additional circumstance is recognized - after
> making a call with number that is out of phonebook it can be downloaded
> as a single vCard containing number with OTHER type.
> ---
>  plugins/phonebook-tracker.c |   20 ++++++++++++++++++--
>  1 files changed, 18 insertions(+), 2 deletions(-)

Pushed upstream, but I had to fix your coding style first:

> -	query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id, id,
> -						id, id, id, id, id, id, id,
> +	if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0) {
> +		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
> +						id, id, id, id, id, id, id, id,
>  						id, id, id, id, id);
> +	} else {
> +		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
> +								id, id, id);
> +	}
>  
>  	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);

Single line branches shouldn't use curly braces.

Johan
