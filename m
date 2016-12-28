Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr>
References: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Dec 2016 11:14:22 +0200
Message-ID: <CABBYNZKr=3ssvbypvP71kH5UzDfyLKzcgrW=P7sZXTSsgNPPHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/btgatt-client: Fix set-security interactive command
To: Maxime Chevallier <maxime.chevallier@smile.fr>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Maxime,

On Thu, Dec 22, 2016 at 12:36 PM, Maxime Chevallier
<maxime.chevallier@smile.fr> wrote:
> Fix the interactive "set-security" command in btgatt-client, that would
> always fail due to bad initialization of argv buffer :
>
> [GATT client]# set-security 2
> Usage: set_security <level>
> level: 1-3
> e.g.:
>         set-sec-level 2
> ---
>  tools/btgatt-client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 40a03b1..afe00aa 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -1198,8 +1198,7 @@ static void set_security_usage(void)
>
>  static void cmd_set_security(struct client *cli, char *cmd_str)
>  {
> -       char *argvbuf[1];
> -       char **argv = argvbuf;
> +       char *argv[2];
>         int argc = 0;
>         char *endptr = NULL;
>         int level;
> --
> 2.1.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
