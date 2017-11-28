Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] shared/shell: Print usage when no argument
 generator is set
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20171127161704.14073-1-luiz.dentz@gmail.com>
 <20171127161704.14073-4-luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <bd0b4257-fe3f-1a63-20fa-c5e28c11900b@jp.fujitsu.com>
Date: Tue, 28 Nov 2017 10:47:05 +0900
MIME-Version: 1.0
In-Reply-To: <20171127161704.14073-4-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thank you for dealing with my request.

On 11/28/2017 01:17 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This prints the command and arguments if the command don't provide
> a generator so one don't have to always resort to help for checking it.
> ---
>  src/shared/shell.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 73aedaf79..bd5cf18fc 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -527,8 +527,12 @@ static char **menu_completion(const struct bt_shell_menu_entry *entry,
>  		if (strcmp(entry->cmd, input_cmd))
>  			continue;
>  
> -		if (!entry->gen)
> -			continue;
> +		if (!entry->gen) {
> +			if (text[0] == '\0')
> +				bt_shell_printf("Usage: %s %s\n", entry->cmd,
> +								entry->arg);

If entry->arg is NULL, it prints out "(null)" on my box.


Regards,
Eramoto

