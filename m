Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/bluetooth: Fix Supported feature bitmask for MPMD scenarios
Date: Tue, 21 Oct 2014 11:03:50 +0200
Message-ID: <5359012.3MzvoDGJvz@uw000953>
In-Reply-To: <1413812032-26631-1-git-send-email-marcin.kraglak@tieto.com>
References: <1413812032-26631-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Monday 20 of October 2014 15:33:51 Marcin Kraglak wrote:
> Set A2DP-SRC_AVRCP-TG instead of A2DP-SNK_AVRCP-CT_DUN-DT bit.
> It was affecting TC_SDP_CTH_SD_BV_01_I PTS test case.
> ---
>  android/bluetooth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 827e205..03eb1a1 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -70,7 +70,7 @@
>   */
>  #define MPS_DEFAULT_MPMD ((1ULL << 1) | (1ULL << 3) | (1ULL << 5) | \
>  				(1ULL << 6) | (1ULL << 8) | (1ULL << 10) | \
> -				(1ULL << 12) | (1ULL << 15) | (1ULL << 18))
> +				(1ULL << 12) | (1ULL << 15) | (1ULL << 17))
>  
>  /*
>   * bits in bitmask as defined in table 6.5 of Multi Profile Specification
> 

Both patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
