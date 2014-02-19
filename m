Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140218213509.EB15A1005F0@puck.mtv.corp.google.com>
References: <20140218213509.EB15A1005F0@puck.mtv.corp.google.com>
Date: Tue, 18 Feb 2014 17:02:56 -0800
Message-ID: <CAGXr9JFtWLxcipUktj-PPkdfVNpY_HsjOc+USRT9QiWOB-FikQ@mail.gmail.com>
Subject: Re: [PATCH] sdptool: Fix sdptool output
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Please discard this patch. Anderson has already submitted identical
patch in "[PATCH BlueZ 3/3] lib/sdp: Fix printing of multiple record
fields".

On Tue, Feb 18, 2014 at 1:35 PM, Petri Gynther <pgynther@google.com> wrote:
> Add missing newlines to sdp_record_print().
> ---
>  lib/sdp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/sdp.c b/lib/sdp.c
> index 3b26ec3..f957c46 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -1604,13 +1604,13 @@ void sdp_record_print(const sdp_record_t *rec)
>  {
>         sdp_data_t *d = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
>         if (d && SDP_IS_TEXT_STR(d->dtd))
> -               printf("Service Name: %.*s", d->unitSize, d->val.str);
> +               printf("Service Name: %.*s\n", d->unitSize, d->val.str);
>         d = sdp_data_get(rec, SDP_ATTR_SVCDESC_PRIMARY);
>         if (d && SDP_IS_TEXT_STR(d->dtd))
> -               printf("Service Description: %.*s", d->unitSize, d->val.str);
> +               printf("Service Description: %.*s\n", d->unitSize, d->val.str);
>         d = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
>         if (d && SDP_IS_TEXT_STR(d->dtd))
> -               printf("Service Provider: %.*s", d->unitSize, d->val.str);
> +               printf("Service Provider: %.*s\n", d->unitSize, d->val.str);
>  }
>
>  #ifdef SDP_DEBUG
> --
> 1.9.0.rc1.175.g0b1dcb5
>
