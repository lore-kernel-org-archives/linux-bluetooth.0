Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339620563-25161-6-git-send-email-szymon@janc.net.pl>
References: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
	<1339620563-25161-6-git-send-email-szymon@janc.net.pl>
Date: Thu, 14 Jun 2012 10:58:58 +0300
Message-ID: <CABBYNZKh8t8Oq7NfKYjXCO7CEtRjF3d=rB5Uv5dP8OEn_zz3tw@mail.gmail.com>
Subject: Re: [PATCH obexd 6/7] filesystem: Use proper pointer type instead of
 void* in string_read
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jun 13, 2012 at 11:49 PM, Szymon Janc <szymon@janc.net.pl> wrote:
> ---
>  plugins/filesystem.c |    3 +--
>  plugins/filesystem.h |    2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/plugins/filesystem.c b/plugins/filesystem.c
> index e664fc5..d1a3df4 100644
> --- a/plugins/filesystem.c
> +++ b/plugins/filesystem.c
> @@ -594,9 +594,8 @@ static int string_free(void *object)
>        return 0;
>  }
>
> -ssize_t string_read(void *object, void *buf, size_t count)
> +ssize_t string_read(GString *string, void *buf, size_t count)
>  {
> -       GString *string = object;
>        ssize_t len;
>
>        if (string->len == 0)
> diff --git a/plugins/filesystem.h b/plugins/filesystem.h
> index f95773b..694a350 100644
> --- a/plugins/filesystem.h
> +++ b/plugins/filesystem.h
> @@ -21,6 +21,6 @@
>  *
>  */
>
> -ssize_t string_read(void *object, void *buf, size_t count);
> +ssize_t string_read(GString *string, void *buf, size_t count);
>  gboolean is_filename(const char *name);
>  int verify_path(const char *path);
> --
> 1.7.10.4

Nak, the idea is to match the parameters of mimetype driver read
callback, so you don't have to cast.


-- 
Luiz Augusto von Dentz
