Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304984994-14114-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1304984994-14114-1-git-send-email-vinicius.gomes@openbossa.org>
Date: Tue, 10 May 2011 13:21:08 +0300
Message-ID: <BANLkTinX+8SXu+6jg5v4vHjde1fOWP2_cw@mail.gmail.com>
Subject: Re: [PATCH] Fix starting security procedures when not needed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, May 10, 2011 at 2:49 AM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> The default value of sec_level when setting *any* option
> using bt_io_set() was BT_SECURITY_MEDIUM. This was causing
> the security procedure being started in some situations that
> it should not.
> ---
>  btio/btio.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index a3cf38a..df028a6 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -659,7 +659,6 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
>        /* Set defaults */
>        opts->defer = DEFAULT_DEFER_TIMEOUT;
>        opts->master = -1;
> -       opts->sec_level = BT_IO_SEC_MEDIUM;
>        opts->mode = L2CAP_MODE_BASIC;
>        opts->flushable = -1;

I believe this was on purpose so that if you want another security
level you need to force it when using BtIO, this could be set in the
kernel by default but since it already uses LOW that could break some
applications.


-- 
Luiz Augusto von Dentz
Computer Engineer
