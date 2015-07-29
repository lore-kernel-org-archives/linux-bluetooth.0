Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Dohyun Pyun <dh79.pyun@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, grzegorz.kolodziejczyk@tieto.com,
	steve.jun@samsung.com
Subject: Re: [PATCH BLUEZ] tools/bneptest: Fix not NULL terminating parsed string
Date: Wed, 29 Jul 2015 09:29:50 +0200
Message-ID: <1549921.uu7jjHlb6V@leonov>
In-Reply-To: <1438150734-25746-1-git-send-email-dh79.pyun@samsung.com>
References: <1438150734-25746-1-git-send-email-dh79.pyun@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dohyun Pyun,

On Wednesday 29 of July 2015 15:18:54 Dohyun Pyun wrote:
> From: DoHyun Pyun <dh79.pyun@samsung.com>
> 
> This patch prevents the possible not NULL terminating problem.
> ifr_name's array size is IFNAMSIZ. So If bridge has IFNAMSIZ size,
> the name string will be not NULL terminating.
> ---
>  tools/bneptest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bneptest.c b/tools/bneptest.c
> index a7d5815..1404252 100644
> --- a/tools/bneptest.c
> +++ b/tools/bneptest.c
> @@ -89,7 +89,7 @@ static int set_forward_delay(int sk)
>  	struct ifreq ifr;
> 
>  	memset(&ifr, 0, sizeof(ifr));
> -	strncpy(ifr.ifr_name, bridge, IFNAMSIZ);
> +	strncpy(ifr.ifr_name, bridge, IFNAMSIZ - 1);
>  	ifr.ifr_data = (char *) args;
> 
>  	if (ioctl(sk, SIOCDEVPRIVATE, &ifr) < 0) {

Applied, thanks.

-- 
BR
Szymon Janc
