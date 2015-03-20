Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426833308-23046-1-git-send-email-bharat.panda@samsung.com>
References: <1426833308-23046-1-git-send-email-bharat.panda@samsung.com>
Date: Fri, 20 Mar 2015 15:38:56 +0200
Message-ID: <CABBYNZ+5L+QKdTrLpaw92gW=LYbCaPuZbUHj2HOzk2SHaGzJhA@mail.gmail.com>
Subject: Re: [PATCH ] obexd/pbap: Fix NULL check to avoid potential crash
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Mar 20, 2015 at 8:35 AM, Bharat Panda <bharat.panda@samsung.com> wrote:
> NULL pointer check for name is done before using the same.
> ---
>  obexd/plugins/pbap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
> index cec5acd..f2f9166 100644
> --- a/obexd/plugins/pbap.c
> +++ b/obexd/plugins/pbap.c
> @@ -728,6 +728,11 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
>         int ret;
>         void *request;
>
> +       if (name == NULL) {
> +               ret = -EBADR;
> +               goto fail;
> +       }
> +
>         DBG("name %s context %p valid %d", name, context, pbap->cache.valid);
>
>         if (oflag != O_RDONLY) {
> @@ -735,11 +740,6 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
>                 goto fail;
>         }
>
> -       if (name == NULL) {
> -               ret = -EBADR;
> -               goto fail;
> -       }
> -
>         /* PullvCardListing always get the contacts from the cache */
>
>         if (pbap->cache.valid) {
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
