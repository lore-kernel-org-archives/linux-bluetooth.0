Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1466408993-3808-5-git-send-email-patrik.flykt@linux.intel.com>
References: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com> <1466408993-3808-5-git-send-email-patrik.flykt@linux.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jun 2016 15:56:31 +0300
Message-ID: <CABBYNZJrNLhx22TFTZyr6SeeAqQ7+EoYz3BZUSdT1V0ZgQMYxg@mail.gmail.com>
Subject: Re: [RFC 4/4] bluetooth: Do not set IFF_POINTOPOINT
To: Patrik Flykt <patrik.flykt@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	aar@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrik,

On Mon, Jun 20, 2016 at 10:49 AM, Patrik Flykt
<patrik.flykt@linux.intel.com> wrote:
> The IPv6 stack needs to send and receive Neighbor Discovery
> messages. Remove the IFF_POINTOPOINT flag.

I guess we can quote the https://tools.ietf.org/html/rfc7668#section-2.2:


   ' In Bluetooth LE, direct wireless communication only takes place
   between a central and a peripheral.  This means that inherently the
   Bluetooth LE star represents a hub-and-spokes link model.
   Nevertheless, two peripherals may communicate through the central by
   using IP routing functionality per this specification.'

I guess this means the router should act as a hub, there is actually a
dedicated session for Neighbor Discovery:
https://tools.ietf.org/html/rfc7668#section-3.2.3

*We might have to check if we are conforming to things like not
publishing link-local addresses.


> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
>  net/bluetooth/6lowpan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 2dddb2b..1a70312 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -650,8 +650,7 @@ static void netdev_setup(struct net_device *dev)
>  {
>         dev->hard_header_len    = 0;
>         dev->needed_tailroom    = 0;
> -       dev->flags              = IFF_RUNNING | IFF_POINTOPOINT |
> -                                 IFF_MULTICAST;
> +       dev->flags              = IFF_RUNNING | IFF_MULTICAST;
>         dev->watchdog_timeo     = 0;
>
>         dev->netdev_ops         = &netdev_ops;
> --
> 2.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
