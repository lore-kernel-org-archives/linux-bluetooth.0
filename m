Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Jan 2014 09:55:26 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/4] audio/AVRCP: Fix coding style
Message-ID: <20140131075447.GB18867@aemeltch-MOBL1>
References: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
 <1391123008-26767-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391123008-26767-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jan 30, 2014 at 03:03:28PM -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  profiles/audio/avrcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index ac861d2..4521bc4 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -2161,7 +2161,7 @@ static struct media_item *parse_media_folder(struct avrcp *session,
>  		name[namelen] = '\0';
>  	}
>  
> -	item =  media_player_create_folder(mp, name, type, uid);
> +	item = media_player_create_folder(mp, name, type, uid);

what is the point creating this patch instead of merging with previous one
which introduced this style issue?

Best regards 
Andrei Emeltchenko 

>  	if (!item)
>  		return NULL;
>  
> -- 
> 1.8.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
