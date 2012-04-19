Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Apr 2012 10:45:33 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Yu A Wang <arron.wang@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] rfkill: Set device powered even adapter is not
 created
Message-ID: <20120419074533.GA20567@x220.ger.corp.intel.com>
References: <1326704570-22854-1-git-send-email-arron.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326704570-22854-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jan 16, 2012, Yu A Wang wrote:
> ---
>  src/rfkill.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/src/rfkill.c b/src/rfkill.c
> index b40c6e7..5d32fac 100644
> --- a/src/rfkill.c
> +++ b/src/rfkill.c
> @@ -128,11 +128,18 @@ static gboolean rfkill_event(GIOChannel *chan,
>  	if (id < 0)
>  		return TRUE;
>  
> +	DBG("RFKILL unblock for hci%d", id);
> +
>  	adapter = manager_find_adapter_by_id(id);
> -	if (!adapter)
> +	if (!adapter) {
> +		/*
> +		 * If device is rfkilled, the initialize operation
> +		 * may failed and adapter is not created, then we
> +		 * need to set the device powered directly.
> +		 */
> +		adapter_ops_set_powered(id, TRUE);
>  		return TRUE;
> -
> -	DBG("RFKILL unblock for hci%d", id);
> +	}
>  
>  	btd_adapter_restore_powered(adapter);

This looks more like a workaround to another issue: if the kernel is
aware of the adapter but user space isn't it means that something has
gone wrong during the initialization process and *that* should be fixed
instead of blindly attempting to power on the adapter id anyway.

Johan
