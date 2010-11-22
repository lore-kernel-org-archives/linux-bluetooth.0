Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 23:07:08 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix typo in adapter documentation
Message-ID: <20101122220708.GA15647@jh-x301>
References: <1290452756-7967-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290452756-7967-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Mon, Nov 22, 2010, Jose Antonio Santos Cadenas wrote:
> ---
>  doc/adapter-api.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 65e2887..f287f29 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -148,7 +148,7 @@ Methods		dict GetProperties()
>  
>  			This registers the adapter wide agent.
>  
> -			The object path defines the path the of the agent
> +			The object path defines the path of the agent
>  			that will be called when user input is needed.
>  
>  			If an application disconnects from the bus all

Pushed upstream. Thanks.

Johan
