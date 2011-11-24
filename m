Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Nov 2011 15:24:57 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC obexd 05/10] client-doc: replace parameter dict with
 conventional ones
Message-ID: <20111124182457.GB20733@samus>
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
 <1322143742-31182-6-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322143742-31182-6-git-send-email-mikel.astiz@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On 15:08 Thu 24 Nov, Mikel Astiz wrote:
> The usage of a dictionary as a parameter passing mechanism seems not to
> be necessary any more.
> ---
>  doc/client-api.txt |   22 ++++++++++------------
>  1 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/doc/client-api.txt b/doc/client-api.txt
> index a6f30af..67355c6 100644
> --- a/doc/client-api.txt
> +++ b/doc/client-api.txt
> @@ -12,27 +12,25 @@ Service		org.openobex.client
>  Interface	org.openobex.Client
>  Object path	/
>  
> -Methods		object CreateSession(dict device)
> +Methods		object CreateSession(string source, string destination,
> +					string target)
>  
> -			Create a new OBEX session. The device is configured
> -			via properties like in SendFiles.
> +			Create a new OBEX session for the given source (local)
> +			address, destination (remote) address and target. The
> +			supported target values are:
> +				- "OPP"
> +				- "FTP"
> +				- "SYNC"
> +				- "PBAP"
>  
>  		void RemoveSession(object session)
>  
>  			Unregister session and abort pending transfers.
>  
> -		string GetCapabilities(dict device)
> +		string GetCapabilities(string source, string destination)
>  
>  			Get remote device capabilities.
>  
> -Properties	string Target
> -
> -		string Source
> -
> -		string Destination
> -
> -		byte Channel

I just wanted to say that for most of the cases doing the SDP seach 
always is the right thing to do, but sometimes you want to avoid it.

I agree that for now we can leave it, but it would be nice if there
was a way to add it later if we ever need it.

> -
>  Session hierarchy
>  =================
>  
> -- 
> 1.7.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
