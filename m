Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Set security level to MEDIUM for mcap instances created from HDP plugin
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <1300882066-7273-1-git-send-email-sancane@gmail.com>
Date: Wed, 23 Mar 2011 09:36:30 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0B998901-FCE1-49E5-AF1C-4C6E663292AB@signove.com>
References: <1300882066-7273-1-git-send-email-sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 23 Mar 2011, at 09:07 , Santiago Carot-Nemesio wrote:

> Some health devices without IO capabilities can't connect to mcap
> instances when security level is set to HIGH. This patch enables
> above devices to connect to Health instances avoiding the MITM
> problem.
> ---
> health/hdp.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/health/hdp.c b/health/hdp.c
> index d4a2a30..3c2dce1 100644
> --- a/health/hdp.c
> +++ b/health/hdp.c
> @@ -1329,7 +1329,7 @@ static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
> 		goto update;
> 
> 	adapter_get_address(hdp_adapter->btd_adapter, &addr);
> -	hdp_adapter->mi = mcap_create_instance(&addr, BT_IO_SEC_HIGH, 0, 0,
> +	hdp_adapter->mi = mcap_create_instance(&addr, BT_IO_SEC_MEDIUM, 0, 0,
> 					mcl_connected, mcl_reconnected,
> 					mcl_disconnected, mcl_uncached,
> 					NULL, /* CSP is not used by now */
> -- 
> 1.7.4.1

Tested here com Nonin 9650 oximeter, works perfectly.