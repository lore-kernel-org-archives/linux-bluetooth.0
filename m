Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Oct 2011 10:36:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix MediaPlayer documentation
Message-ID: <20111020073647.GA11517@fusion.localdomain>
References: <CAMOw1v6OwkwFfqeZmNSOGCXp+W1_yEpsM-+8XyeF9NW1CR_f-w@mail.gmail.com>
 <1319025900-1437-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319025900-1437-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 19, 2011, Lucas De Marchi wrote:
> ---
>  doc/media-api.txt |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index b8dcdbd..c748e50 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -180,12 +180,6 @@ Signals		PropertyChanged(string setting, variant value)
>  
>  					Track duration in milliseconds
>  
> -		StatusChanged(string status, uint32 position)
> -
> -			Possible status: "playing", "stopped", "paused",
> -					"forward-seek", "reverse-seek" or
> -					"error"
> -
>  Properties	string Equalizer [readwrite]
>  
>  			Possible values: "off" or "on"

Applied. Thanks.

Johan
