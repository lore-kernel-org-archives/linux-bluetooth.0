Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Updated GAP test result
Date: Tue, 19 Aug 2014 19:33:11 +0200
Message-ID: <9158771.nusftVSrUU@leonov>
In-Reply-To: <1408435944-22125-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1408435944-22125-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 19 of August 2014 10:12:24 Lukasz Rymanowski wrote:
> Updated test result and instruction for TC_BOND_BON_BV_04_C
> ---
> Since kernel version has been updated we should schedule regression run.
> 
>  android/pts-gap.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index af75dff..0158707 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -3,7 +3,7 @@ PTS test results for GAP
>  PTS version: 5.2
>  Tested: 01-August-2014
>  Android version: 4.4.4
> -Kernel version: 3.17
> +Kernel version: 3.18
> 
>  Results:
>  PASS	test passed
> @@ -180,11 +180,11 @@ TC_BOND_BON_BV_01_C	INC	gattc register_client
>  TC_BOND_BON_BV_02_C	PASS
>  TC_BOND_BON_BV_03_C	PASS	gattc register_client
>  				gattc listen 1
> -TC_BOND_BON_BV_04_C	FAIL	haltest: gattc_register_client
> +TC_BOND_BON_BV_04_C	PASS	haltest: gattc_register_client
>  				gattc connect <client_id> <address>
> -				bluetooth remove_bond <address>
> +				gattc disconnect
>  				gattc connect <client_id> <address>
> -				JIRA #BA-70
> +				gattc test_command 226 <addr> 0 2
>  TC_SEC_AUT_BV_11_C	PASS	haltest: gattc register_client
>  				gatts register_server
>  				gatts add_service 2 <uuid> 3

Applied, thanks.

-- 
BR
Szymon Janc
