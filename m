Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424678384-25495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424678384-25495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 23 Feb 2015 15:08:30 +0200
Message-ID: <CABBYNZLqLNVn5o05yRM-Bezb33sH95aHjASJhOaPCfXHK2MDkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] audio/a2dp: Fix queue initialization
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 23, 2015 at 9:59 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> After changing GSList to queue initialization was missing.
> ---
>  profiles/audio/a2dp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index b024742..ad21df3 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1249,6 +1249,7 @@ static void avdtp_server_destroy(struct avdtp_server *server)
>         g_io_channel_shutdown(server->io, TRUE, NULL);
>         g_io_channel_unref(server->io);
>         btd_adapter_unref(server->adapter);
> +       queue_destroy(server->seps, NULL);
>         g_free(server);
>  }
>
> @@ -1373,6 +1374,7 @@ static struct avdtp_server *avdtp_server_init(struct btd_adapter *adapter)
>         }
>
>         server->adapter = btd_adapter_ref(adapter);
> +       server->seps = queue_new();
>
>         avdtp_servers = g_slist_append(avdtp_servers, server);
>
> --
> 2.1.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
