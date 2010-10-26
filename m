Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288082028-10014-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1288082028-10014-1-git-send-email-dmitriy.paliy@nokia.com>
Date: Tue, 26 Oct 2010 08:01:15 -0700
Message-ID: <AANLkTink-xzPS-ZBB1_YCGRdUjfPRJ_sHcC9+tebe9zO@mail.gmail.com>
Subject: Re: [PATCH] Fix cache is invalid on empty listing response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 26, 2010 at 1:33 AM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> Fix cache marked as invalid when no data available in response to get phone
> book listing. This fixes obexd crash in 3-way calling scenario. Cache is
> created when there is second incoming call. If the call is rejected and
> retried again, valid empty cache is sent over obex stream that causes obexd
> crash. With this fix, the stream is aborted in such scenario. A new attempt
> to create cache is carried out on each new subsequent incoming call.
> ---
>  plugins/pbap.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/pbap.c b/plugins/pbap.c
> index 11cb678..f7f3897 100644
> --- a/plugins/pbap.c
> +++ b/plugins/pbap.c
> @@ -407,7 +407,11 @@ static void cache_ready_notify(void *user_data)
>                        (const char *) pbap->params->searchval);
>
>        if (sorted == NULL) {
> -               pbap->cache.valid = TRUE;
> +               /* When no data available from tracker, cache marked as
> +                * invalid (new one will be tried to be created next time),
> +                * no such file or directory error is set, and obex stream
> +                * is aborted */
> +               pbap->cache.valid = FALSE;
>                obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
>                return;
>        }

We discussed about this offline and apparently when cache.valid is set
to FALSE it will create a new cache for the next requests so we need
to free the current cache otherwise it will leak.

-- 
Luiz Augusto von Dentz
Computer Engineer
