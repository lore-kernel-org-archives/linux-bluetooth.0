Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 13:36:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] AVRCP: Corrected metadata: Playing Time
Message-ID: <20110822103632.GC9949@dell>
References: <201108201753.32608.dstockwell@frequency-one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201108201753.32608.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sat, Aug 20, 2011, David Stockwell wrote:
> Metadata item #7 should return total playing time of the track (TrackDuration) 
> in msec, not current position within the track.
> 
> Signed-off-by: David Stockwell <dstockwell@frequency-one.com>

Please remove the signed-off-by (same in the other patches)

> ---
>  audio/control.c |   22 ++++++++--------------
>  1 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/audio/control.c b/audio/control.c
> index 4e10cac..047e6ac 100644
> --- a/audio/control.c
> +++ b/audio/control.c
> @@ -196,7 +196,7 @@ enum media_info_id {
>  	MEDIA_INFO_TRACK =		4,
>  	MEDIA_INFO_N_TRACKS =		5,
>  	MEDIA_INFO_GENRE =		6,
> -	MEDIA_INFO_CURRENT_POSITION =	7,
> +	MEDIA_INFO_PLAYING_TIME =	7,
>  };

Would it make sense to add a MEDIA_INFO_LAST to the end of the above
list and then instead of the following:

> -		for (i = 1; i <= MEDIA_INFO_CURRENT_POSITION; i++) {
> +		for (i = 1; i <= MEDIA_INFO_PLAYING_TIME; i++) {
>  			size = mp_get_media_attribute(control->mp, i,
>  							&pdu->params[pos]);

You'd have:

	for (i = 1; i < MEDIA_INFO_LAST; i++) {

Seems more readable to me at least and it'd make it easier to add new
MEDIA_INFO types in the future (you only need to change the enum
definition and protect yourself against forgetting to update both
places).

Btw, it looked like this avrcp_handle_get_element_attributes function
might not be properly checking the amount of actually received data in
all necessary places before accessing the buffer (i.e. having the risk
of remotely triggered buffer overflows). Could you please verify this
and fix it if the issue really exists.

Johan
