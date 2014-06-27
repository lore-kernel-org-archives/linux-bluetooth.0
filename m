Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 02/12] android/health: Fix wrong callback return type
Date: Fri, 27 Jun 2014 16:11:11 +0200
Message-ID: <2488115.NJdaFG3YRd@uw000953>
In-Reply-To: <1403868303-8129-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1403868303-8129-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 27 of June 2014 14:24:53 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index de67475..140afee 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1098,15 +1098,19 @@ static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
>  	DBG("Not Implemeneted");
>  }
>  
> -static void mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
> +static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
>  				uint16_t mdlid, uint8_t *conf, void *data)
>  {
>  	DBG("Not Implemeneted");
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

This patch is now applied. Thanks. 

-- 
Best regards, 
Szymon Janc
