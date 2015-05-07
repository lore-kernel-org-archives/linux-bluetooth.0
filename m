Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430925036-20245-1-git-send-email-chanyeol.park@samsung.com>
References: <1430925036-20245-1-git-send-email-chanyeol.park@samsung.com>
Date: Thu, 7 May 2015 11:20:50 +0300
Message-ID: <CABBYNZ+tM==j0Af=X93jCCQAqenspFbtbLRs6KqFrMuA8-niOg@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/3] audio/a2dp: connect A2DP vendor codec if possible
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Wed, May 6, 2015 at 6:10 PM,  <chanyeol.park@samsung.com> wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
>
> This patch gives the priority on vendor codec during A2DP codec
> negotiation.

There is already a prioritization based on the sender and in the order
the endpoints are registered, so by doing this you would be breaking
the prioritization instead register the codecs in order of preference
that should have the same results.

> ---
>  profiles/audio/a2dp.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 31c5086..d9a2f72 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1751,6 +1751,8 @@ static gboolean check_vendor_codec(struct a2dp_sep *sep, uint8_t *cap,
>  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
>                                         const char *sender)
>  {
> +       struct a2dp_sep *selected_sep = NULL;
> +
>         for (; list; list = list->next) {
>                 struct a2dp_sep *sep = list->data;
>                 struct avdtp_remote_sep *rsep;
> @@ -1776,15 +1778,20 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
>                 service = avdtp_get_codec(rsep);
>                 cap = (struct avdtp_media_codec_capability *) service->data;
>
> -               if (cap->media_codec_type != A2DP_CODEC_VENDOR)
> -                       return sep;
> +               if (cap->media_codec_type != A2DP_CODEC_VENDOR) {
> +                       selected_sep = sep;
> +                       continue;
> +               }
>
>                 if (check_vendor_codec(sep, cap->data,
>                                         service->length - sizeof(*cap)))
>                         return sep;
>         }
>
> -       return NULL;
> +       if (selected_sep)
> +               return selected_sep;
> +       else
> +               return NULL;
>  }
>
>  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
