Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] client: Fix memory leak due to the option to
 register an agent
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <e75606ee-1e0f-5225-21d7-d6129202d9ac@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <22ba2dcc-325a-ea3a-85c9-48c47c4a4292@jp.fujitsu.com>
Date: Tue, 4 Jul 2017 16:21:10 +0900
MIME-Version: 1.0
In-Reply-To: <e75606ee-1e0f-5225-21d7-d6129202d9ac@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Would you apply my patch to git master branch if there are not any problems?
I confirmed that it was applied to the latest master branch with no problem.

Regards,
Eramoto

On 2017年06月21日 19:07, ERAMOTO Masaya wrote:
> When bluetoothctl runs with the command line option "-a <capability>", it
> does not free the variable auto_register_agent registering the initial
> agent and allocates new memory for it.
> 
> This frees the allocated memory before allocating new memory.
> (The related commit id is 6db3470c2ea161b4b808ad1fc80dfd7e014fd359.)
> 
> ---
>  client/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/client/main.c b/client/main.c
> index 2f269af..9b01dfb 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2358,6 +2358,7 @@ static gboolean parse_agent(const char *key, const char *value,
>  	if (!value)
>  		return FALSE;
>  
> +	g_free(auto_register_agent);
>  	auto_register_agent = g_strdup(value);
>  
>  	return TRUE;
> 
