Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Mar 2013 17:00:55 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	marcel@holtmann.org
Subject: Re: [PATCH 3/6] "agent" command capability argument and
 autocompletion
Message-ID: <20130314200055.GE2649@samus>
References: <1363285326-20089-1-git-send-email-deymo@chromium.org>
 <1363285326-20089-4-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363285326-20089-4-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

Sorry for the double post.

On 11:22 Thu 14 Mar, Alex Deymo wrote:
> This patch enables argument autocompletion for the agent command with the
> list of capabilities an agent can have, adding also "on" (for the default "")
> and "off". The command passes the argument (parsing and verifying it) to the
> dbus method call.
> ---
>  client/main.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/client/main.c b/client/main.c
> index 704cf46..12b08b5 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -59,6 +59,27 @@ static GDBusProxy *default_ctrl;
>  static GList *ctrl_list;
>  static GList *dev_list;
>  
> +static const char* agent_arguments[] = {
> +	"on",
> +	"off",
> +	"DisplayOnly",
> +	"DisplayYesNo",
> +	"KeyboardDisplay",
> +	"KeyboardOnly",
> +	"NoInputNoOutput",
> +	NULL
> +};
> +
> +static const char* agent_capability_options[] = {

Neither I (nor my compiler) could find any usages of this ;-)

> +	"", /* default */
> +	"DisplayOnly",
> +	"DisplayYesNo",
> +	"KeyboardDisplay",
> +	"KeyboardOnly",
> +	"NoInputNoOutput",
> +	NULL
> +};
> +

[snip]


Cheers,
-- 
Vinicius
