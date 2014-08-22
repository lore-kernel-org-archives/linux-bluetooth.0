Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update GAP PTS test results
Date: Fri, 22 Aug 2014 10:21:09 +0200
Message-ID: <2956675.sA7ZkmbgK2@uw000953>
In-Reply-To: <1408616595-25940-1-git-send-email-marcin.kraglak@tieto.com>
References: <1408616595-25940-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 21 of August 2014 12:23:15 Marcin Kraglak wrote:
> ---
>  android/pts-gap.txt | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index 3076310..05a2ddb 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -172,10 +172,17 @@ TC_BOND_NBON_BV_02_C	PASS	haltest: gattc register_client
>  				bluetooth create_bond <address>
>  				bluetooth remove_bond <address>
>  TC_BOND_NBON_BV_03_C	PASS	haltest: gattc listen
> -TC_BOND_BON_BV_01_C	INC	gattc register_client
> -				gattc listen 1
> -				bluetooth create_bond <pts_bdaddr>
> -				JIRA #BA-68
> +TC_BOND_BON_BV_01_C	PASS	#12503 however it is possible to pass it without
> +				entering securid (Bonding - No MITM):
> +				btmgmt power on
> +				btmgmt le on
> +				btmgmt ssp on
> +				btmgmt connectable on
> +				btmgmt discov on
> +				btmgmt advertising on
> +				btmgmt pairable on
> +				To bond with PTS execute
> +				btmgmt pair -t 0x01 -c 0x03 <PTS addr>
>  TC_BOND_BON_BV_02_C	PASS
>  TC_BOND_BON_BV_03_C	PASS	gattc register_client
>  				gattc listen 1
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
