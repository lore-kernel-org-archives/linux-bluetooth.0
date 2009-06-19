Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Jun 2009 23:07:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix small typo
Message-ID: <20090619200706.GA30225@jh-x301>
References: <1245438529-16211-1-git-send-email-jprvita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1245438529-16211-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jun 19, 2009, João Paulo Rechi Vita wrote:
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -136,7 +136,7 @@ gboolean server_is_enabled(bdaddr_t *src, uint16_t svc)
>  	case HEADSET_SVCLASS_ID:
>  		return enabled.headset;
>  	case HEADSET_AGW_SVCLASS_ID:
> -		return  FALSE;
> +		return FALSE;
>  	case HANDSFREE_SVCLASS_ID:
>  		return enabled.headset && enabled.hfp;
>  	case HANDSFREE_AGW_SVCLASS_ID:

Pushed upstream. Thanks.

Johan
