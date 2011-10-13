Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 10:44:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/12] Make title always available in metadata
Message-ID: <20111013074452.GC8289@fusion.localdomain>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1318432282-25002-4-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318432282-25002-4-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 12, 2011, Lucas De Marchi wrote:
> ---
>  audio/media.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/media.c b/audio/media.c
> index c9fe0f0..56913d5 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1438,6 +1438,11 @@ static gboolean parse_player_metadata(struct media_player *mp,
>  	if (g_hash_table_size(track) == 0) {
>  		g_hash_table_unref(track);
>  		track = NULL;
> +	} else if (title == FALSE) {
> +		struct metadata_value *value = g_new(struct metadata_value, 1);
> +
> +		value->type = DBUS_TYPE_STRING;
> +		value->value.str = g_strdup("");
>  	}
>  
>  	if (mp->track != NULL)

This doesn't make any sense. You're allocating a new variable which is
only available inside the "else if" scope, and then doing nothing with
it. Additionally this memory is leaked once you exit the scope.

Johan
