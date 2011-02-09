Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 13:58:23 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix small typo
Message-ID: <20110209215823.GB11911@jh-x301>
References: <1297193877-26625-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1297193877-26625-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Tue, Feb 08, 2011, Elvis Pfützenreuter wrote:
> ---
>  doc/health-api.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/doc/health-api.txt b/doc/health-api.txt
> index a0a1685..3d0a717 100644
> --- a/doc/health-api.txt
> +++ b/doc/health-api.txt
> @@ -18,7 +18,7 @@ Methods:
>  
>  		Returns the path of the new registered application.
>  
> -		Dict is defined as bellow:
> +		Dict is defined as below:
>  		{
>  			"DataType": uint16, (mandatory)
>  			"Role" : ("Source" or "Sink"), (mandatory)

Pushed upstream. Thanks.

Johan
