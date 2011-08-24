Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 11:30:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] AVRCP: Metadata item #7 should return TrackDuration
Message-ID: <20110824083023.GA19274@dell>
References: <201108232225.08328.dstockwell@frequency-one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201108232225.08328.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, Aug 23, 2011, David Stockwell wrote:
> @@ -194,7 +194,8 @@ enum media_info_id {
>  	MEDIA_INFO_TRACK =		4,
>  	MEDIA_INFO_N_TRACKS =		5,
>  	MEDIA_INFO_GENRE =		6,
> -	MEDIA_INFO_CURRENT_POSITION =	7,
> +	MEDIA_INFO_PLAYING_TIME =	7,
> +	MEDIA_INFO_LAST = MEDIA_INFO_PLAYING_TIME,
>  };

Actually that's not quite what I meant. The idea was this:

	MEDIA_INFO_PLAYING_TIME = 7,
	MEDIA_INFO_LAST,

That way you can just keep adding new entries above MEDIA_INFO_LAST and
its value will always be the last "real" value + 1 (which also means
that the comparison in the for-loop changes from <= to <).

Johan
