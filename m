Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/4] tools/btpclient: Fix setting/reseting connectable flag
Date: Mon, 15 Jan 2018 14:50:32 +0100
Message-ID: <5141790.R4lJDEd9iq@ix>
In-Reply-To: <20180112141012.28113-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180112141012.28113-1-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday, 12 January 2018 15:10:09 CET Grzegorz Kolodziejczyk wrote:
> Defined setting flag is presented as mask.
> ---
>  tools/btpclient.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 806403f6a..a8a65fd51 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -368,9 +368,9 @@ static void btp_gap_set_connectable(uint8_t index, const
> void *param, new_settings = adapter->current_settings;
> 
>  	if (cp->connectable)
> -		new_settings |= 1 << BTP_GAP_SETTING_CONNECTABLE;
> +		new_settings |= BTP_GAP_SETTING_CONNECTABLE;
>  	else
> -		new_settings &= ~(1 << BTP_GAP_SETTING_CONNECTABLE);
> +		new_settings &= ~BTP_GAP_SETTING_CONNECTABLE;
> 
>  	update_current_settings(adapter, new_settings);

This patch is now applied, thanks.

-- 
pozdrawiam
Szymon Janc


