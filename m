Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF671708
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 11:29:57 -0800 (PST)
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A619A61E5FE04;
	Thu,  7 Dec 2023 20:29:50 +0100 (CET)
Message-ID: <8ff48948-af4d-4bba-be38-891e89e25a92@molgen.mpg.de>
Date: Thu, 7 Dec 2023 20:29:49 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1] client/player: Fix not prompting all parameter
 on endpoint.register
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20231207184723.3862261-1-luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231207184723.3862261-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Am 07.12.23 um 19:47 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When Auto Accept is not enable not all parameters are requested.

enable*d*

> ---
>   client/player.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/client/player.c b/client/player.c
> index 4673d2efece8..4d49602c70d7 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -2813,17 +2813,13 @@ static void endpoint_auto_accept(const char *input, void *user_data)
>   		return;
>   	} else if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
>   		ep->auto_accept = false;
> +		bt_shell_prompt_input(ep->path, "Max Transports (auto/value):",
> +						endpoint_max_transports, ep);
> +		return;
>   	} else {
>   		bt_shell_printf("Invalid input for Auto Accept\n");
>   		return bt_shell_noninteractive_quit(EXIT_FAILURE);
>   	}
> -
> -	if (ep->broadcast)
> -		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
> -					endpoint_iso_group, ep);
> -	else
> -		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
> -					endpoint_iso_group, ep);
>   }

Excuse my ignorance, but it’s not clear to me why *Max Transports* is 
now used instead of *BIG* or *CIG*, and what the code path is, that 
could not have led to one of the two prompts.

>   static void endpoint_set_metadata(const char *input, void *user_data)


Kind regards,

Paul
