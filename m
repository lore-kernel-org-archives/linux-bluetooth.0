Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Dohyun Pyun <dh79.pyun@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, steve.jun@samsung.com
Subject: Re: [PATCH BLUEZ] android/pan: Fix not NULL terminating parsed string
Date: Wed, 29 Jul 2015 09:29:33 +0200
Message-ID: <3434204.zRI1YPC0Rc@leonov>
In-Reply-To: <1438151088-26152-1-git-send-email-dh79.pyun@samsung.com>
References: <1438151088-26152-1-git-send-email-dh79.pyun@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dohyun Pyun,

On Wednesday 29 of July 2015 15:24:48 Dohyun Pyun wrote:
> From: DoHyun Pyun <dh79.pyun@samsung.com>
> 
> This patch prevents the possible not NULL terminating problem.
> ifr_name's array size is IFNAMSIZ. So If BNEP_BRIDGE has IFNAMSIZ size,
> the name string will be not NULL terminating.
> ---
>  android/pan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/pan.c b/android/pan.c
> index 0bb576e..c40a6d3 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -88,7 +88,7 @@ static int set_forward_delay(int sk)
>  	struct ifreq ifr;
> 
>  	memset(&ifr, 0, sizeof(ifr));
> -	strncpy(ifr.ifr_name, BNEP_BRIDGE, IFNAMSIZ);
> +	strncpy(ifr.ifr_name, BNEP_BRIDGE, IFNAMSIZ - 1);
>  	ifr.ifr_data = (char *) args;
> 
>  	if (ioctl(sk, SIOCDEVPRIVATE, &ifr) < 0) {

Patch applied, thanks.

-- 
BR
Szymon Janc
