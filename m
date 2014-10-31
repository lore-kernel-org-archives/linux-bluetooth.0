Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414745523-31699-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414745523-31699-1-git-send-email-marcin.kraglak@tieto.com>
Date: Fri, 31 Oct 2014 16:48:32 +0200
Message-ID: <CABBYNZJhx12-b_25x-uX_8NA8rZHHLowtZ0CM_SOQHUXnGEHeA@mail.gmail.com>
Subject: Re: [PATCHv3 1/7] shared/io: Remove disconnect handler in io_destroy
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Fri, Oct 31, 2014 at 10:51 AM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> Diconnect callback may be called after destroying IO in next
> mainloop iteration (it leada to reading freed data). Removing
> disconnect handler prevents that situation.
> ---
>  src/shared/io-glib.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> index a2ada66..5ebde3d 100644
> --- a/src/shared/io-glib.c
> +++ b/src/shared/io-glib.c
> @@ -115,6 +115,11 @@ void io_destroy(struct io *io)
>                 io->write_watch = 0;
>         }
>
> +       if (io->disconnect_watch > 0) {
> +               g_source_remove(io->disconnect_watch);
> +               io->disconnect_watch = 0;
> +       }
> +
>         g_io_channel_unref(io->channel);
>         io->channel = NULL;
>
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
