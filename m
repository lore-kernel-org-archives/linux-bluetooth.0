Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328798781-27566-1-git-send-email-luiz.dentz@gmail.com>
References: <1328798781-27566-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 9 Feb 2012 17:36:00 +0200
Message-ID: <CABBYNZLDZuaCU9TcRLvJr=vHkSWFLp9w7t8uvn9-7AzeeCPArQ@mail.gmail.com>
Subject: Re: [PATCH obexd] btio: Adjust socket buffers to be at least as big
 as MTU
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 9, 2012 at 4:46 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  btio/btio.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index 9781ec4..be81faf 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -119,6 +119,34 @@ static gboolean check_nval(GIOChannel *io)
>        return FALSE;
>  }
>
> +static void adjust_buffers(GIOChannel *io)
> +{
> +       int sk = g_io_channel_unix_get_fd(io);
> +       int omtu = 0, imtu = 0, sndbuf = 0, rcvbuf = 0;
> +       socklen_t len = sizeof(int);
> +
> +       if (!bt_io_get(io, BT_IO_L2CAP, NULL, BT_IO_OPT_OMTU, &omtu,
> +                                               BT_IO_OPT_IMTU, &imtu,
> +                                               BT_IO_OPT_INVALID))
> +               return;
> +
> +       if (getsockopt(sk, SOL_SOCKET, SO_SNDBUF, &sndbuf, &len) < 0)
> +               return;
> +
> +       if (sndbuf < omtu) {
> +               sndbuf = omtu;
> +               setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &sndbuf, len);
> +       }
> +
> +       if (getsockopt(sk, SOL_SOCKET, SO_RCVBUF, &rcvbuf, &len) < 0)
> +               return;
> +
> +       if (rcvbuf < imtu) {
> +               rcvbuf = imtu;
> +               setsockopt(sk, SOL_SOCKET, SO_RCVBUF, &rcvbuf, len);
> +       }
> +}
> +
>  static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
>                                                        gpointer user_data)
>  {
> @@ -129,10 +157,15 @@ static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
>        if ((cond & G_IO_NVAL) || check_nval(io))
>                return FALSE;
>
> -       if (cond & (G_IO_HUP | G_IO_ERR))
> +       if (cond & (G_IO_HUP | G_IO_ERR)) {
>                g_set_error(&err, BT_IO_ERROR, BT_IO_ERROR_DISCONNECTED,
>                                "HUP or ERR on socket");
> +               goto done;
> +       }
>
> +       adjust_buffers(io);
> +
> +done:
>        accept->connect(io, err, accept->user_data);
>
>        g_clear_error(&err);
> @@ -159,14 +192,21 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
>                else
>                        err = -sk_err;
>
> -               if (err < 0)
> +               if (err < 0) {
>                        g_set_error(&gerr, BT_IO_ERROR,
>                                        BT_IO_ERROR_CONNECT_FAILED, "%s (%d)",
>                                        strerror(-err), -err);
> -       } else if (cond & (G_IO_HUP | G_IO_ERR))
> +                       goto done;
> +               }
> +       } else if (cond & (G_IO_HUP | G_IO_ERR)) {
>                g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
>                                "HUP or ERR on socket");
> +               goto done;
> +       }
> +
> +       adjust_buffers(io);
>
> +done:
>        conn->connect(io, gerr, conn->user_data);
>
>        if (gerr)
> @@ -199,8 +239,10 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
>
>        if (server->confirm)
>                server->confirm(cli_io, server->user_data);
> -       else
> +       else {
> +               adjust_buffers(cli_io);
>                server->connect(cli_io, NULL, server->user_data);
> +       }
>
>        g_io_channel_unref(cli_io);
>
> --
> 1.7.7.6

Maybe I should have sent this as an RFC since this could be done in
kernel automatically as it could be considered broken in case of
SOCK_SEQPACKET if socket buffer cannot hold a write/read of MTU size.
This is not actually a new problem as there exist a workaround in
avdtp.c to adjust the socket buffer too, but it became more evident
with introduction of gobex which can use SOCK_SEQPACKET with a
considerable big MTU (up to 64k) which will fail if there is not
enough space to stuff full packets.


-- 
Luiz Augusto von Dentz
