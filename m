Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Re-run OPP with ETS-12160
Date: Wed, 30 Apr 2014 11:23:07 +0200
Message-ID: <2911569.JJvJOSa0vN@uw000953>
In-Reply-To: <1398771067-6531-1-git-send-email-sebastian.chlad@tieto.com>
References: <1398771067-6531-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 29 of April 2014 13:31:07 Sebastian Chlad wrote:
> There is new ETS for OPP: 12160 which solves the problem of the
> client test: OPH_BV_01_I
> ---
>  android/pts-opp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pts-opp.txt b/android/pts-opp.txt
> index 86b9589..0a070ca 100644
> --- a/android/pts-opp.txt
> +++ b/android/pts-opp.txt
> @@ -30,8 +30,8 @@ TC_CLIENT_BCP_BV_05_I   N/A
>  TC_CLIENT_CON_BV_01_C	N/A
>  TC_CLIENT_OPH_BI_01_C	PASS	PTS issue: ID: 12081 (bluetooth.org)
>  				ETS-12081 required
> -TC_CLIENT_OPH_BV_01_I	NONE	OBEX_DISCONNECT_REQ sent on closed channel
> -				PTS issue reported: ID: 12081
> +TC_CLIENT_OPH_BV_01_I	PASS	PTS issue: ID: 12081.
> +				ETS-12160 required
>  TC_CLIENT_OPH_BV_02_I	N/A
>  TC_CLIENT_OPH_BV_03_I	PASS	ETS-12081 required (bluetooth.org)
>  TC_CLIENT_OPH_BV_04_I	N/A
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
