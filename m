Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Sep 2011 20:23:34 -0300
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	johan.hedberg@gmail.com
Subject: Re: [PATCH] AVRCP: Metadata item #7 should return TrackDuration
Message-ID: <20110908232334.GA11329@vigoh>
References: <201108241914.07574.dstockwell@frequency-one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201108241914.07574.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Stockwell <dstockwell@frequency-one.com> [2011-08-24 19:14:07 -0500]:

> AVRCP: Metadata item #7 should return TrackDuration
> 
> Should be total playing time of the track (TrackDuration)
> in msec, not current position within track.
> ---
>  audio/control.c |   21 ++++++++-------------
>  1 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/audio/control.c b/audio/control.c
> index be95c19..4aad67d 100644
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

Your email client is wrapping at 80 cols, so your patches cannot be
properly applied.

Consider using git-sent-email for sending patches, or fix your email
client. As far as I could see you are using Kmail. It can be fixed by
following Documentation/email-clients.txt in the kernel repository.

I rebased your patches on top of upstream, and sent to the mailing list
since I needed these changes applied to make some others. I kept
you as the author of the patches.


regards,
Lucas De Marchi
