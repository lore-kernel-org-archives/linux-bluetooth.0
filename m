Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH BlueZ 1/3] audio/media: Fix notifying settings changed incorrectly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1371402085-30762-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 16 Jun 2013 23:15:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1BC9236A-FF61-4858-AB41-6A2A05C086BE@holtmann.org>
References: <1371402085-30762-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> We should notify only the setting that has changed not all of them.
> ---
> profiles/audio/media.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index eb5ea81..69139a7 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1480,7 +1480,7 @@ static gboolean set_property(struct media_player *mp, const char *key,
> 
> 	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
> 
> -	settings = list_settings(mp);
> +	settings = g_list_prepend(NULL, (char *) key);

this is dangerous. Can you guarantee that the memory it points to is not used outside of this function. Seriously, making a comment here if this is safe is a good idea. If it is not safe, then it needs to be fixed.

We are using const function arguments for pointers to clearly indicate that the lifetime of that pointer is really only guaranteed inside the function.

Regards

Marcel

