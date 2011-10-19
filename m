Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319012398-13859-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1319012398-13859-1-git-send-email-dmitriy.paliy@nokia.com>
Date: Wed, 19 Oct 2011 12:24:27 +0300
Message-ID: <CABBYNZLpHP9m=-5KfMzpvWeuLJqOeND6h_ZLcbe1zJq_35og5g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix release all sessions on powering adapter off
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Oct 19, 2011 at 11:19 AM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> When adapter is powered off, all sessions should be released without
> changing mode, which is contrary to what session_remove does. This
> prevents from such situation when powering off leads to new mode
> derived from mode_sessions.
>
> Currently, if there are multiple mode sessions requested by different
> clients, powering adapter off results in powering immediately it on.
> ---
>  src/adapter.c |   14 ++------------
>  1 files changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index d1ef17c..6d982a0 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2313,19 +2313,9 @@ static void set_mode_complete(struct btd_adapter *adapter)
>
>        DBG("");
>
> -       /*
> -        * g_slist_free is not called after g_slist_foreach because the list is
> -        * updated using g_slist_remove in session_remove.
> -        */
>        if (adapter->mode == MODE_OFF) {
> -               GSList *l;
> -
> -               for (l = adapter->mode_sessions; l;) {
> -                       struct session_req *req = l->data;
> -                       l = g_slist_next(l);
> -                       session_remove(req);
> -                       session_free(req);
> -               }
> +               g_slist_free_full(adapter->mode_sessions, session_free);
> +               adapter->mode_sessions = NULL;
>        }
>
>        if (adapter->pending_mode == NULL)
> --
> 1.7.4.1
>
>

Nice and clean, ack.

-- 
Luiz Augusto von Dentz
