Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
References: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
Date: Sun, 30 Dec 2012 10:37:28 -0400
Message-ID: <CAJdJm_PpJOVALj5xJvCRA4mC6WAMyP5RsqHVruz6xaRBDhXg5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Giovanni Gherdovich <g.gherdovich@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Giovanni,

A few coding style comments below.

On Sun, Dec 30, 2012 at 6:17 AM, Giovanni Gherdovich
<g.gherdovich@gmail.com> wrote:
> The function g_queue_free_full is available only from GLib 2.32.
> If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
> this patch replaces the calls to g_queue_free_full with its body,
> taken from the sources of GLib 2.32.
>
> Signed-off-by: Giovanni Gherdovich <g.gherdovich@gmail.com>

BlueZ does not use Signed-off-by tag, so you must remove it.

> ---
>  profiles/audio/avctp.c |    3 ++-
>  src/adapter.c          |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 013c587..745ced8 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -395,7 +395,8 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
>                 g_source_remove(chan->process_id);
>
>         g_free(chan->buffer);
> -       g_queue_free_full(chan->queue, pending_destroy);
> +       g_queue_foreach(chan->queue, (GFunc)pending_destroy, NULL);
> +       g_queue_free(chan->queue);

Where possible, try to avoid using casts for functions. In this case,
try removing "(GFunc)" and see if code still compiles cleanly with
"./bootstrap-configure && make".

>         g_slist_free_full(chan->processed, pending_destroy);
>         g_slist_free_full(chan->handlers, g_free);
>         g_free(chan);
> diff --git a/src/adapter.c b/src/adapter.c
> index e71cea8..a244ae2 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1697,7 +1697,8 @@ static void adapter_free(gpointer user_data)
>         if (adapter->auth_idle_id)
>                 g_source_remove(adapter->auth_idle_id);
>
> -       g_queue_free_full(adapter->auths, g_free);
> +       g_queue_foreach (adapter->auths, (GFunc)g_free, NULL);
> +       g_queue_free (adapter->auths);

Same comment as above regarding "(GFunc)". Also remove the whitespace
before "(" for the two statements.

We usually split the patches if they touch "core" files (in src/*) and
profile code in profiles/*. For simple patches it is no big deal, but
it also does not hurt if you do this always.

And finally, the commit summary should be in present tense (Replaced
-> Replace), e.g.:

core: Replace calls to g_queue_free_full function
AVCTP: Replace calls to g_queue_free_full function

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
