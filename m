Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 20 Oct 2014 15:37:55 +0300
Message-ID: <CABBYNZJf2PdRCyiwMrXWx1TDXrvneA7LKN64f0u5CFBW_nBouw@mail.gmail.com>
Subject: Re: [PATCH 1/6] bnep: Avoid double error print for bnep_connadd()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Oct 17, 2014 at 3:54 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> This avoids double printing the same error with bnep connection add
> ioctl.
> ---
>  profiles/network/bnep.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 136709d..035beb1 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -316,10 +316,8 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
>         setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
>
>         sk = g_io_channel_unix_get_fd(session->io);
> -       if (bnep_connadd(sk, session->src, session->iface)) {
> -               error("bnep conn could not be added");
> +       if (bnep_connadd(sk, session->src, session->iface) < 0)
>                 goto failed;
> -       }
>
>         if (bnep_if_up(session->iface)) {
>                 error("could not up %s", session->iface);
> @@ -556,14 +554,14 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
>  int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
>                                                 const bdaddr_t *addr)
>  {
> +       int err;
> +
>         if (!bridge || !iface || !addr)
>                 return -EINVAL;
>
> -       if (bnep_connadd(sk, dst, iface) < 0) {
> -               error("Can't add connection to the bridge %s: %s(%d)",
> -                                               bridge, strerror(errno), errno);
> -               return -errno;
> -       }
> +       err = bnep_connadd(sk, dst, iface);
> +       if (err < 0)
> +               return err;
>
>         if (bnep_add_to_bridge(iface, bridge) < 0) {
>                 error("Can't add %s to the bridge %s: %s(%d)",
> --
> 1.9.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
