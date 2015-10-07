Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5613B4A7.7030901@ubnt.com>
References: <5613B4A7.7030901@ubnt.com>
Date: Wed, 7 Oct 2015 16:09:38 +0300
Message-ID: <CABBYNZL1yyLJ_77AO_=Bhvpf-13Enj1pkq6nuex_vQ2G0ZvUgQ@mail.gmail.com>
Subject: Re: [PATCH] core/advertising: Fix string match in le adv search
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Tue, Oct 6, 2015 at 2:46 PM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
> Instead of searching for matched entry in the list, the function match_advertisement
> was searching for the first non-matched entry. As a result, it wasn't possible to
> unregister existing advertisement from LE Adv manager.
>
> Signed-off-by: Andrejs Hanins <andrejs.hanins@ubnt.com>

Please remember no signed-off-by in userspace and keep the description
under 72 columns, this time I fixed it for you.

> ---
>  src/advertising.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index d56b7a2..a148625 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -77,10 +77,10 @@ static bool match_advertisement(const void *a, const void *b)
>         const struct advertisement *ad = a;
>         const struct dbus_obj_match *match = b;
>
> -       if (match->owner && !g_strcmp0(ad->owner, match->owner))
> +       if (match->owner && g_strcmp0(ad->owner, match->owner))
>                 return false;
>
> -       if (match->path && !g_strcmp0(ad->path, match->path))
> +       if (match->path && g_strcmp0(ad->path, match->path))
>                 return false;
>
>         return true;
> --
> 1.9.1

Nice catch, applied.


-- 
Luiz Augusto von Dentz
