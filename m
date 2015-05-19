Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/2] lib/bnep: Update bnep header with BNEPGETSUPPFEAT and setup response
Date: Tue, 19 May 2015 16:34:39 +0200
Message-ID: <3048713.ta9afG7rS0@leonov>
In-Reply-To: <1431589630-30252-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1431589630-30252-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 14 of May 2015 09:47:09 Grzegorz Kolodziejczyk wrote:
> This patch updates bnep header with get bnep supported features ioctl
> and bnep setup response flag.
> ---
>  lib/bnep.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/bnep.h b/lib/bnep.h
> index aa46852..e7c2c87 100644
> --- a/lib/bnep.h
> +++ b/lib/bnep.h
> @@ -126,6 +126,9 @@ struct bnep_ext_hdr {
>  #define BNEPCONNDEL	_IOW('B', 201, int)
>  #define BNEPGETCONNLIST	_IOR('B', 210, int)
>  #define BNEPGETCONNINFO	_IOR('B', 211, int)
> +#define BNEPGETSUPPFEAT	_IOR('B', 212, int)
> +
> +#define BNEP_SETUP_RESPONSE	0
> 
>  struct bnep_connadd_req {
>  	int      sock;		/* Connected socket */

Both patches applied. Thanks.

-- 
BR
Szymon Janc
