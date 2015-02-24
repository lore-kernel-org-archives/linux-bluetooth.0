Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/gatt: Fix incorrect error check
Date: Tue, 24 Feb 2015 17:49:32 +0100
Message-ID: <6225434.BfCaSeET8H@uw000953>
In-Reply-To: <1424438578-10645-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424438578-10645-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 20 of February 2015 15:22:58 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  tools/btgatt-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index e59d5db..25ace4a 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -1021,7 +1021,7 @@ static void cmd_set_sec_level(struct client *cli, char *cmd_str)
>  		return;
>  	}
>  
> -	if (bt_gatt_client_set_sec_level(cli->gatt, level) < 0)
> +	if (!bt_gatt_client_set_sec_level(cli->gatt, level))
>  		printf("Could not set sec level\n");
>  	else
>  		printf("Setting security level %d success\n", level);
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
