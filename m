Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/9] android/health: Fix wrong callback return type
Date: Thu, 26 Jun 2014 16:35:42 +0200
Message-ID: <7934410.hG5i33YCjT@uw000953>
In-Reply-To: <1403784265-1455-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1403784265-1455-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 26 of June 2014 15:04:19 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.c | 8 ++++++--
>  android/health.h | 8 ++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index dd2e5af..3cb2016 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1098,7 +1098,7 @@ static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
>  	DBG("Not Implemeneted");
>  }
>  
> -static void mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
> +static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
>  				uint16_t mdlid, uint8_t *conf, void *data)
>  {
>  	GError *gerr = NULL;
> @@ -1133,11 +1133,15 @@ static void mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
>  
>  		return MCAP_SUCCESS;
>  	}
> +
> +	return MCAP_SUCCESS;
>  }
>  
> -static void mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
> +static uint8_t mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
>  {
>  	DBG("Not Implemeneted");
> +
> +	return MCAP_SUCCESS;
>  }
>  
>  static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
> diff --git a/android/health.h b/android/health.h
> index 0b32fd3..ab7d478 100644
> --- a/android/health.h
> +++ b/android/health.h
> @@ -21,5 +21,13 @@
>   *
>   */
>  
> +#define HDP_MDEP_ECHO		0x00
> +#define HDP_MDEP_INITIAL	0x01
> +#define HDP_MDEP_FINAL		0x7F
> +
> +#define HDP_NO_PREFERENCE_DC	0x00
> +#define HDP_RELIABLE_DC		0x01
> +#define HDP_STREAMING_DC	0x02
> +
>  bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
>  void bt_health_unregister(void);
> 

This should go before Patch 2, to avoid build errors.

-- 
Best regards, 
Szymon Janc
