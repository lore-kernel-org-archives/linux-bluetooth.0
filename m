Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 12:02:09 -0300
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH 2/3] AVRCP: Metadata item #7 should return TrackDuration
Message-ID: <20110824150209.GA11862@vigoh>
References: <201108240805.59288.dstockwell@frequency-one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201108240805.59288.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Stockwell <dstockwell@frequency-one.com> [2011-08-24 08:05:59 -0500]:

> [PATCH 2/3] AVRCP: Metadata item #7 should return TrackDuration
> 
> Should be total playing time of the track (TrackDuration)
> in msec, not current position within track.
> ---
>  audio/control.c |   21 ++++++++-------------
>  1 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/audio/control.c b/audio/control.c
> index be95c19..eb86029 100644
> --- a/audio/control.c
> +++ b/audio/control.c
> @@ -194,7 +194,8 @@ enum media_info_id {
>  	MEDIA_INFO_TRACK =		4,
>  	MEDIA_INFO_N_TRACKS =		5,
>  	MEDIA_INFO_GENRE =		6,
> -	MEDIA_INFO_CURRENT_POSITION =	7,
> +	MEDIA_INFO_PLAYING_TIME =	7,
> +	MEDIA_INFO_LAST,
>  };
>  
>  static DBusConnection *connection = NULL;
> @@ -928,19 +929,13 @@ static int mp_get_media_attribute(struct media_player 
> *mp,
>  		len = strlen(valstr);
>  		memcpy(elem->val, valstr, len);
>  		break;
> -	case MEDIA_INFO_CURRENT_POSITION:
> -		if (mi->elapsed != 0xFFFFFFFF) {
> -			uint32_t elapsed;
> -
> -			mp_get_playback_status(mp, NULL, &elapsed, NULL);
> -
> -			snprintf(valstr, 20, "%u", elapsed);
> -			len = strlen(valstr);
> -			memcpy(elem->val, valstr, len);
> -		} else {
> +	case MEDIA_INFO_PLAYING_TIME:
> +		if (!mi->track_len)

track_len is initialized with 0xFFFFFFFF, because as per spec when it
has this value it means it's not available (see media_info_init())


Otherwise seems good.

regards, 
Lucas De Marchi
