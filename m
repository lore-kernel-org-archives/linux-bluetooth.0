Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jan 2013 14:12:15 +0100
From: Ludek Finstrle <luf@pzkagis.cz>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] audio: Replace g_hash_table_contains() with
 g_hash_table_lookup()
Message-ID: <20130107131215.GC914@pzkagis.cz>
References: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Mon, Jan 07, 2013 at 06:03:52PM +0530, Jaganath Kanakkassery napsal(a):
> g_hash_table_contains() is supported only from GLib 2.32. If BlueZ has to
> build against GLib 2.28 this patch replaces g_hash_table_contains() to
> g_hash_table_lookup()
> ---
>  profiles/audio/player.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index 8748893..4198bdb 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -172,8 +172,13 @@ static gboolean get_status(const GDBusPropertyTable *property,
>  static gboolean setting_exists(const GDBusPropertyTable *property, void *data)
>  {
>  	struct media_player *mp = data;
> +	const char *value;
> +
> +	value = g_hash_table_lookup(mp->settings, property->name);
> +	if (value == NULL)
> +		return FALSE;
>  
> -	return g_hash_table_contains(mp->settings, property->name);
> +	return TRUE;
>  }

Doesn't

return g_hash_table_lookup(mp->settings, property->name) != NULL;

do the same? Maybe it's againist some code style but looks better
than several lines.

Luf
