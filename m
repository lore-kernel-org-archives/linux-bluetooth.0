Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 09:24:41 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, patrick.ohly@intel.com
Subject: Re: [PATCH BlueZ 8/8] doc/obex-api: Update documentation
Message-ID: <20140217072439.GA27868@aemeltch-MOBL1>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
 <1392393184-15266-8-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392393184-15266-8-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 14, 2014 at 05:53:04PM +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds Suspend and Resume methods and 'suspended' value as status in
> the Transfer interface documentation.
> ---
>  doc/obex-api.txt | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index 1f22fea..0f57ce1 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -90,12 +90,26 @@ Methods		void Cancel()
>  					 org.bluez.obex.Error.InProgress
>  					 org.bluez.obex.Error.Failed
>  
> +		void Suspend()
> +
> +			Suspend transference.

would transfer sound better then transference ?

Best regards 
Andrei Emeltchenko 

> +
> +			Possible errors: org.bluez.obex.Error.NotAuthorized
> +					 org.bluez.obex.Error.NotInProgress
> +
> +		void Resume()
> +
> +			Resume transference.
> +
> +			Possible errors: org.bluez.obex.Error.NotAuthorized
> +					 org.bluez.obex.Error.NotInProgress
> +
>  Properties	string Status [readonly]
>  
>  			Inform the current status of the transfer.
>  
> -			Possible values: "queued", "active", "complete" or
> -					"error"
> +			Possible values: "queued", "active", "suspended",
> +					"complete" or "error"
>  
>  		object Session [readonly]
>  
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
