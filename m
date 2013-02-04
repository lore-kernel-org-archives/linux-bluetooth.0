Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Feb 2013 10:30:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] AVRCP: Handler player features as a byte array
Message-ID: <20130204083030.GA1147@x220>
References: <1359924910-27167-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359924910-27167-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Feb 03, 2013, Luiz Augusto von Dentz wrote:
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -67,7 +67,7 @@ struct media_player {
>  	char			*name;		/* Player name */
>  	char			*type;		/* Player type */
>  	char			*subtype;	/* Player subtype */
> -	uint64_t		features[2];	/* Player features */
> +	uint8_t			*features;	/* Player features */

Why not just have this as features[16] here as well so you don't need to
do g_memdup and g_free?

Johan
