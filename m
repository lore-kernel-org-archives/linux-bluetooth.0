Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 May 2015 15:23:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gatt: Fix memory leak in profile_add
Message-ID: <20150522122304.GA5680@t440s.lan>
References: <1432021797-24630-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432021797-24630-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, May 19, 2015, Andrei Emeltchenko wrote:
> Cleanup memory correctly.
> ---
>  src/gatt-database.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index dd80aa0..ca514db 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2299,8 +2299,11 @@ static int profile_add(struct external_profile *profile, const char *uuid)
>  		return -ENOMEM;
>  
>  	p->remote_uuid = (const void *) g_strdup(uuid);
> -	if (!p->remote_uuid)
> +	if (!p->remote_uuid) {
> +		g_free((void *) p->name);
> +		free((void *) p);
>  		return -ENOMEM;
> +	}
>  
>  	p->auto_connect = true;

Applied, but we need to do something about the 'const char *' members of
btd_profile. If we're using them to store non-const values they
shouldn't be declared const to begin with. If someone wants to
contribute this change the btd_profile the definition should also have a
comment that the management of these values is left to the higher-level
implementation (i.e. nothing needed for the stack based ones, and
g_free/free needed for ext_profile and the GATT stuff).

Johan
