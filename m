Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427463981-19365-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427463981-19365-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Thu, 2 Apr 2015 12:56:11 +0200
Message-ID: <CAMv5Gbc-=6xFNo8=MUmY2ZKx_NnLYGGw02+s_jGO6ZxxAoakZA@mail.gmail.com>
Subject: Re: [PATCH] profiles/network: Add remove connection if iface couldn't
 bring up
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping.

On 27 March 2015 at 14:46, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> Connection should be deleted if bnep interface couldn't bring up.
> ---
>  profiles/network/bnep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index e325b72..ab72021 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -631,8 +631,10 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>         }
>
>         err = bnep_if_up(iface);
> -       if (err < 0)
> +       if (err < 0) {
> +               bnep_conndel(addr);
>                 rsp = BNEP_CONN_NOT_ALLOWED;
> +       }
>
>  reply:
>         if (bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp) < 0) {
> --
> 2.1.0
>
