Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1467295600-31828-1-git-send-email-biman.paul@samsung.com>
References: <1467295600-31828-1-git-send-email-biman.paul@samsung.com>
From: Biman Paul <biman.innovative@gmail.com>
Date: Thu, 1 Sep 2016 23:07:19 +0530
Message-ID: <CAEaeM0K7T_GZpBrh00TgAWoZ7OKkPHrscr9Kv_Wjj61cd78zmg@mail.gmail.com>
Subject: Re: [PATCH 1/1] obexd/pbap: clear cache if name header is present
To: linux-bluetooth@vger.kernel.org
Cc: Biman Paul <biman.paul@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 30, 2016 at 7:36 PM, Biman Paul <biman.paul@samsung.com> wrote:
> Remote device is not able to fetch call logs from different folder.
> It always returns the call logs requested in first request.
>
> Considering a situation to fetch from och and then from cch,
> there are two ways to request x-bt/vcard-listing:
> Case I:
> 1. SetPhoneBook to /telecom/och (absolute path)
> 2. PullvCardListing with name header '' (empty)
> Remote devices using this method always calls SetPhoneBook with absolute path
> to set the path and we clear the cache when new path is set.
> Case II:
> 1. SetPhoneBook to /telecom (relative path)
> 2. PullvCardListing with name header 'och'
> Remote devices using this method calls SetPhoneBook with '/telecom' only once
> and cache is not cleared when second PullvCardListing is made with name header.
> This results in cached incorrect list sent to remote device.
>
> Clear cache if name header is present would prevent sending of
> cache list as it is not present. Instead it would request to
> create new cache based on new name header.
> ---
>  obexd/plugins/pbap.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
> index bab691c..ad93208 100644
> --- a/obexd/plugins/pbap.c
> +++ b/obexd/plugins/pbap.c
> @@ -543,13 +543,18 @@ static int pbap_get(struct obex_session *os, void *user_data)
>
>         } else if (g_ascii_strcasecmp(type, VCARDLISTING_TYPE) == 0) {
>                 /* Always relative */
> -               if (!name || strlen(name) == 0)
> +               if (!name || strlen(name) == 0) {
>                         /* Current folder */
>                         path = g_strdup(pbap->folder);
> -               else
> +               } else {
>                         /* Current folder + relative path */
>                         path = g_build_filename(pbap->folder, name, NULL);
>
> +                       /* clear cache */
> +                       pbap->cache.valid = FALSE;
> +                       pbap->cache.index = 0;
> +                       cache_clear(&pbap->cache);
> +               }
>         } else if (g_ascii_strcasecmp(type, VCARDENTRY_TYPE) == 0) {
>                 /* File name only */
>                 path = g_strdup(name);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ping
