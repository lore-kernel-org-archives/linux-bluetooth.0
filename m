Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150417220040.A379A220209@puck.mtv.corp.google.com>
References: <20150417220040.A379A220209@puck.mtv.corp.google.com>
Date: Mon, 20 Apr 2015 17:50:52 +0300
Message-ID: <CABBYNZKHUbsLjzZrxNqUKe8Qp8L+F=COftCZfed1C+2JwydDOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hog: re-enable HoG report notifications on HoG device reconnect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Sat, Apr 18, 2015 at 1:00 AM, Petri Gynther <pgynther@google.com> wrote:
> On HoG device reconnect, re-enable HoG report notifications every
> time by writing the client characteristic configuration attribute
> of each HoG report.
>
> Doing this on every reconnect:
> 1. ensures that HoG report notifications are always enabled
>    (e.g. lost report notification state in battery swap).
> 2. signals to HoG device that it can start sending HoG reports
>    (e.g. buffered keypresses while the reconnect is still pending).

Is that happening for a specific device? For 1 I suppose it would
loose the paring keys as well which means we would not be able to
connect at all as HoG mandates pairing, or does it loose only the CCC
configuration? Reason 2 is not necessary the behavior every device
would have, for example I don't expect a mouse to buffer anything and
even a keyboard may buffer only the last key pressed since it might
have very little memory to spend in buffering, anyway I suppose reason
1 is what you should really concentrate to tell us what is going on.

> ---
>  profiles/input/hog.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index c55443c..690fd43 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -842,10 +842,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>         for (l = hogdev->reports; l; l = l->next) {
>                 struct report *r = l->data;
>
> -               r->notifyid = g_attrib_register(hogdev->attrib,
> -                                       ATT_OP_HANDLE_NOTIFY,
> -                                       r->decl->value_handle,
> -                                       report_value_cb, r, NULL);
> +               enable_report_notification(r);
>         }
>  }
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
