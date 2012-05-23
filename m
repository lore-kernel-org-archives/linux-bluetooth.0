Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 May 2012 15:02:52 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 10/12] adapter: Remove unwanted if check and code
Message-ID: <20120523180252.GB32263@samus>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
 <1337788652-23697-11-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337788652-23697-11-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On 21:27 Wed 23 May, Syam Sidhardhan wrote:
> Here the variable agent never be NULL, so no need to check it
> against NULL.
> ---
>  src/adapter.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 18dd5b6..16d379c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1618,9 +1618,6 @@ static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
>  
>  	agent = agent_create(adapter, name, path, cap,
>  				(agent_remove_cb) agent_removed, adapter);
> -	if (!agent)
> -		return btd_error_failed(msg, "Failed to create a new agent");
> -

While you are at it, you could remove the "agent" variable.

Apart from this, the series looks good.

>  	adapter->agent = agent;
>  
>  	DBG("Agent registered for hci%d at %s:%s", adapter->dev_id, name,
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
