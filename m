Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384093460.4593.8.camel@nuvo>
References: <1384093460.4593.8.camel@nuvo>
Date: Tue, 12 Nov 2013 10:58:50 +0200
Message-ID: <CABBYNZL3Hw0bQbV_yDm9H_tRnp_XXYUmu0Qi7Dk=efrBghkZmg@mail.gmail.com>
Subject: Re: [PATCH] obex: Use user's cache dir as a default root
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sun, Nov 10, 2013 at 4:24 PM, Bastien Nocera <hadess@hadess.net> wrote:
>
> It's per-user, so we won't try to overwrite somebody else's
> files in /tmp when that happens. It's also (unless we have a
> particularly bizarre setup) on the same partition as the destination
> folder which means we can atomically move the file to the destination
> with a unique filename.
> ---
>  obexd/src/main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/obexd/src/main.c b/obexd/src/main.c
> index 61a06b2..2f7d723 100644
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
> @@ -285,8 +283,10 @@ int main(int argc, char *argv[])
>                 exit(EXIT_FAILURE);
>         }
>
> -       if (option_root == NULL)
> -               option_root = g_strdup(DEFAULT_ROOT_PATH);
> +       if (option_root == NULL) {
> +               option_root = g_build_filename(g_get_user_cache_dir(), "obexd", NULL);
> +               g_mkdir_with_parents(option_root, 0700);
> +       }
>
>         if (option_root[0] != '/') {
>                 char *old_root = option_root, *home = getenv("HOME");
> --
> 1.8.4.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
