Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Mar 2013 13:20:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 03/10 v3] player: Add defines for item types and
 folder types
Message-ID: <20130301112042.GA23500@x220.P-661HNU-F1>
References: <1362062830-24549-1-git-send-email-luiz.dentz@gmail.com>
 <1362062830-24549-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362062830-24549-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Feb 28, 2013, Luiz Augusto von Dentz wrote:
> +static const char *type_to_string(uint8_t type)
> +{
> +	switch (type) {
> +	case PLAYER_ITEM_TYPE_AUDIO:
> +		return "audio";
> +	case PLAYER_ITEM_TYPE_VIDEO:
> +		return "video";
> +	case PLAYER_ITEM_TYPE_FOLDER:
> +		return "folder";
> +	}
> +
> +	return NULL;
> +}
> +
>  
> +static const char *folder_type_to_string(uint8_t type)
> +{
> +	switch (type) {
> +	case PLAYER_FOLDER_TYPE_MIXED:
> +		return "mixed";
> +	case PLAYER_FOLDER_TYPE_TITLES:
> +		return "titles";
> +	case PLAYER_FOLDER_TYPE_ALBUMS:
> +		return "albums";
> +	case PLAYER_FOLDER_TYPE_ARTISTS:
> +		return "artists";
> +	case PLAYER_FOLDER_TYPE_GENRES:
> +		return "genres";
> +	case PLAYER_FOLDER_TYPE_PLAYLISTS:
> +		return "playlists";
> +	case PLAYER_FOLDER_TYPE_YEARS:
> +		return "years";
> +	}
> +
> +	return NULL;
> +}
> diff --git a/profiles/audio/player.h b/profiles/audio/player.h
> index 28689c5..9888f56 100644
> --- a/profiles/audio/player.h
> +++ b/profiles/audio/player.h
> @@ -23,6 +23,20 @@
>   *
>   */
>  
> +#define PLAYER_ITEM_TYPE_AUDIO		0x00
> +#define PLAYER_ITEM_TYPE_VIDEO		0x01
> +#define PLAYER_ITEM_TYPE_FOLDER		0x02
> +#define PLAYER_ITEM_TYPE_INVALID	0xff
> +
> +#define PLAYER_FOLDER_TYPE_MIXED	0x00
> +#define PLAYER_FOLDER_TYPE_TITLES	0x01
> +#define PLAYER_FOLDER_TYPE_ALBUMS	0x02
> +#define PLAYER_FOLDER_TYPE_ARTISTS	0x03
> +#define PLAYER_FOLDER_TYPE_GENRES	0x04
> +#define PLAYER_FOLDER_TYPE_PLAYLISTS	0x05
> +#define PLAYER_FOLDER_TYPE_YEARS	0x06
> +#define PLAYER_FOLDER_TYPE_INVALID	0xff

Why not enums? That'd let the compiler verify that all values are
covered in switch statements and since this is an internal API and not a
protocol detail there really isn't a need to use a fixed size integer
(uint8_t).

Johan
