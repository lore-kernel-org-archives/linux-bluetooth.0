Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1466408993-3808-2-git-send-email-patrik.flykt@linux.intel.com>
References: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com> <1466408993-3808-2-git-send-email-patrik.flykt@linux.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Nov 2016 14:26:16 +0200
Message-ID: <CABBYNZKFnwzgR7mp5qOqibvqZjF3tfTcDB-+LsNkPwcYVPvrKw@mail.gmail.com>
Subject: Re: [RFC 1/4] addrconf: Create EUI48 IPv6 addresses for BTLE 6LoWPAN
To: Patrik Flykt <patrik.flykt@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alexander Aring <aar@pengutronix.de>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 20, 2016 at 10:49 AM, Patrik Flykt
<patrik.flykt@linux.intel.com> wrote:
> Create EUI48 IPv6 addresses for 6LoWPAN over Bluetooth Low Energy.
> Both IEEE802.15.4 and Bluetooth Low Energy use a netdevice type of
> ARPHRD_6LOWPAN, therefore generate the IPv6 address based on the
> MAC address length.
>
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
>  net/ipv6/addrconf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 6c8fc3f..6697fe6 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2055,6 +2055,10 @@ static int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
>         case ARPHRD_IPGRE:
>                 return addrconf_ifid_gre(eui, dev);
>         case ARPHRD_6LOWPAN:
> +               /* 6LoWPAN over BTLE */
> +               if (dev->addr_len == ETH_ALEN)
> +                       return addrconf_ifid_eui48(eui, dev);
> +
>                 return addrconf_ifid_eui64(eui, dev);
>         case ARPHRD_IEEE1394:
>                 return addrconf_ifid_ieee1394(eui, dev);
> --
> 2.8.1

This still seems to be broken.

-- 
Luiz Augusto von Dentz
