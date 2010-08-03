Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 11:23:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 4/6] Fix in logic to write EIR when SDP records are
 changed.
Message-ID: <20100803082323.GC5831@jh-x301>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
 <1280576713-1398-5-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280576713-1398-5-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Sat, Jul 31, 2010, Inga Stotland wrote:
> Whenver SDP service record is added/deleted/modified check for whether 
> class of device needs to be updated as well. If the update is 
> needed, proceed as before and new EIR will be written subsequently. 
> If the class of device is already present, just update EIR and return.
> ---
>  src/adapter.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)

A few minor coding style issues

> -	/* If we already have the CoD we want or the cache is enabled or an
> -	 * existing CoD write is in progress just bail out */
> -	if (adapter->current_cod == adapter->wanted_cod ||
> -			adapter->cache_enable || adapter->pending_cod)
> +	/* If the cache is enabled or an existing CoD write is in progress
> +	 * just bail out */
> +	if(adapter->cache_enable || adapter->pending_cod)

Missing space beteween if and (

>  		return 0;

Add an empty line here.

> +	/* If we already have the CoD we want, update EIR and return */
> +	if (adapter->current_cod == adapter->wanted_cod) {
> +		update_ext_inquiry_response(adapter);
> +		return 0;
> +	}

Johan
