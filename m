Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1295617586-3398-5-git-send-email-sheldon.demario@openbossa.org>
References: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
	<1295617586-3398-5-git-send-email-sheldon.demario@openbossa.org>
Date: Fri, 21 Jan 2011 13:50:56 -0400
Message-ID: <AANLkTi=efT4PZ4T_Ns0xQWcEZgdzkD-ZBO4AhnyF6QnH@mail.gmail.com>
Subject: Re: [PATCH 5/7] Add transport option to interactive gatttool
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 21, 2011 at 9:46 AM, Sheldon Demario
<sheldon.demario@openbossa.org> wrote:
> ---
>  attrib/igatttool.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/attrib/igatttool.c b/attrib/igatttool.c
> index 29290ed..e0d8b44 100644
> --- a/attrib/igatttool.c
> +++ b/attrib/igatttool.c
> @@ -137,6 +137,23 @@ static void cmd_exit(char **cmd)
>        g_main_loop_quit(main_loop);
>  }
>
> +static void cmd_transport(char **cmd)

You can call this parameter "opt" for consistency with other commands.

> +{
> +       if (cmd[1] == NULL)
> +               return;
> +
> +       if (conn_state != STATE_DISCONNECTED)
> +               return;
> +
> +       if (strcasecmp(cmd[1], "le") == 0)
> +               opt_le = TRUE;
> +       else if (strcasecmp(cmd[1], "br") == 0)
> +               opt_le = FALSE;

I've noticed every command callback has the two lines below. Would be
possible to move them to after the callback is called ?

> +
> +       rl_set_prompt(get_prompt());
> +       rl_redisplay();
> +}
> +

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
