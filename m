Return-Path: <cyrus@holtmann.org>
Message-ID: <1357615354.1806.19.camel@aeonflux>
Subject: Re: [PATCH 1/2] audio: Replace g_hash_table_contains() with
 g_hash_table_lookup()
From: Marcel Holtmann <marcel@holtmann.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 07 Jan 2013 19:22:34 -0800
In-Reply-To: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
References: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

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

	return value ? TRUE : FALSE;

Regards

Marcel


