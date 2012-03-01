Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:46:00 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/6] core: remove set_limited_discoverable from
 adapter_ops driver
Message-ID: <20120301014600.GE26492@x220>
References: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
 <1330428206-8185-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330428206-8185-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 28, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Core should not longer need to take care of details of discoverable bits
> ---
>  src/adapter.c |    8 --------
>  src/adapter.h |    1 -
>  2 files changed, 0 insertions(+), 9 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 208f4c8..c5f4d0d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -206,14 +206,6 @@ static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
>  		return MODE_UNKNOWN;
>  }
>  
> -static void adapter_set_limited_discoverable(struct btd_adapter *adapter,
> -							gboolean limited)
> -{
> -	DBG("%s", limited ? "TRUE" : "FALSE");
> -
> -	adapter_ops->set_limited_discoverable(adapter->dev_id, limited);
> -}
> -
>  static struct session_req *session_ref(struct session_req *req)
>  {
>  	req->refcount++;
> diff --git a/src/adapter.h b/src/adapter.h
> index 611e86f..345e308 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -186,7 +186,6 @@ struct btd_adapter_ops {
>  	int (*set_discoverable) (int index, gboolean discoverable,
>  							uint16_t timeout);
>  	int (*set_pairable) (int index, gboolean pairable);
> -	int (*set_limited_discoverable) (int index, gboolean limited);
>  	int (*start_discovery) (int index);
>  	int (*stop_discovery) (int index);

This would also seem to introduce compilation breakage. Just remove the
mgmtops and hciops functions in the same go.

Johan
