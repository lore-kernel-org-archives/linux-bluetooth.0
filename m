Return-Path: <cyrus@holtmann.org>
Message-ID: <1384091198.4593.6.camel@nuvo>
Subject: Re: [PATCH 3/3] obex: Use XDG_RUNTIME_DIR as a default root
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 10 Nov 2013 14:46:38 +0100
In-Reply-To: <1384016598.3880.38.camel@nuvo>
References: <1384016598.3880.38.camel@nuvo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2013-11-09 at 18:03 +0100, Bastien Nocera wrote:
> It's per-user, so we won't try to overwrite somebody else's
> files in /tmp when that happens.

There might be another useful directory instead. We could use
g_get_user_cache_dir() instead of the run-time dir. This would save
cross-partition moves by default, making the move to the Downloads dir
atomic (a single rename, which can fail, iterate until we find a "free"
filename).

Is that better for you?

> ---
>  obexd/src/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/obexd/src/main.c b/obexd/src/main.c
> index 61a06b2..15777f5 100644
> --- a/obexd/src/main.c
> +++ b/obexd/src/main.c
> @@ -50,8 +50,6 @@
>  #include "obexd.h"
>  #include "server.h"
>  
> -#define DEFAULT_ROOT_PATH "/tmp"
> -
>  #define DEFAULT_CAP_FILE CONFIGDIR "/capability.xml"
>  
>  static GMainLoop *main_loop = NULL;
> @@ -286,7 +284,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  	if (option_root == NULL)
> -		option_root = g_strdup(DEFAULT_ROOT_PATH);
> +		option_root = g_build_filename (g_get_user_runtime_dir (), "obexd", NULL);
>  
>  	if (option_root[0] != '/') {
>  		char *old_root = option_root, *home = getenv("HOME");


