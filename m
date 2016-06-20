Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [RFC 3/4] bluetooth: Set 6 byte device addresses
To: Patrik Flykt <patrik.flykt@linux.intel.com>,
	linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
References: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
 <1466408993-3808-4-git-send-email-patrik.flykt@linux.intel.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <0c24af16-de97-fee7-fe3e-507774665d52@pengutronix.de>
Date: Mon, 20 Jun 2016 13:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <1466408993-3808-4-git-send-email-patrik.flykt@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

On 06/20/2016 09:49 AM, Patrik Flykt wrote:
> Set BTLE MAC addresses that are 6 bytes long and not 8 bytes
> that are used in other places with 6lowpan.
> 
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> This patch needs to be cleaned up but worksforme.
> ---
>  net/bluetooth/6lowpan.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index d020299..2dddb2b 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -80,6 +80,8 @@ struct lowpan_btle_dev {
>  	struct delayed_work notify_peers;
>  };
>  
> +static void set_addr(u8 *eui, u8 *addr, u8 addr_type);
> +
>  static inline struct lowpan_btle_dev *
>  lowpan_btle_dev(const struct net_device *netdev)
>  {
> @@ -272,9 +274,10 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
>  static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
>  			   struct l2cap_chan *chan)
>  {
> -	const u8 *saddr, *daddr;
> +	const u8 *saddr;
>  	struct lowpan_btle_dev *dev;
>  	struct lowpan_peer *peer;
> +	unsigned char eui64_daddr[EUI64_ADDR_LEN];

I know it's currently saved still as 8 byte address in L2 btle 6LoWPAN
handling, but this isn't really necessary or? Correct would be to change
all the code to really save the 6 byte bluetooth device address only.
Not the FFFE u/l stuff anymore. All l2 addresses which should be stored
somehow should be 6 byte.

>  
>  	dev = lowpan_btle_dev(netdev);
>  
> @@ -285,9 +288,9 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
>  		return -EINVAL;
>  
>  	saddr = peer->eui64_addr;
> -	daddr = dev->netdev->dev_addr;
> +	set_addr(&eui64_daddr[0], chan->src.b, chan->src_type);
>  

I have still issues with that:

Okay, the current setup which I also had done is the following:

 A <-----> B

I suppose bdaddr A is:

 peer->eui64_addr

B is:

 chan->src.b

This is true point to point communcation.
But isn't the following setup not also possible? Questions for bluetooth
experts:

 A <-----> B
 A <-----> C
 A <-----> ...

Which is still point-to-point, but the "chan->src.b" is some variable
where it depends if it's B or C... or even more.

If the last setup with "two chan->src.b" is possible, then don't use
your own saved bluetooth device address which you saved while creating
some 6lowpan connection (I suppose this is how it's currently saved in
chan->src.b").

You need to use the destination address which comes from the neighbour
discovery cache.

You cannot decide at this point to which L3 address the L2 address comes
from, only the ndisc cache knows it. The same also if:

 A <-----> B

you don't use ndisc daddr, you use your own stored one. And of course remove
the reconstruction of L2 address from L3 address which doesn't work in some
cases, use the L2 from ndisc. [0]

> -	return lowpan_header_decompress(skb, netdev, daddr, saddr);
> +	return lowpan_header_decompress(skb, netdev, &eui64_daddr, saddr);

In this case saddr and daddr should now the 6-bytes address of bluetooth
device address, right? But then I don't get why eui64_daddr is still
EUI64_ADDR_LEN.

Then you need to update the IPHC SAM/DAM = 11 handling, e.g. [1]. Note,
there exists more compression/uncompression for L2 addresses.

>  }
>  
>  static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> @@ -681,13 +684,6 @@ static void set_addr(u8 *eui, u8 *addr, u8 addr_type)
>  	BT_DBG("type %d addr %*phC", addr_type, 8, eui);
>  }
>  
> -static void set_dev_addr(struct net_device *netdev, bdaddr_t *addr,
> -		         u8 addr_type)
> -{
> -	netdev->addr_assign_type = NET_ADDR_PERM;
> -	set_addr(netdev->dev_addr, addr->b, addr_type);
> -}
> -
>  static void ifup(struct net_device *netdev)
>  {
>  	int err;
> @@ -795,7 +791,7 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
>  static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
>  {
>  	struct net_device *netdev;
> -	int err = 0;
> +	int i, err = 0;
>  
>  	netdev = alloc_netdev(LOWPAN_PRIV_SIZE(sizeof(struct lowpan_btle_dev)),
>  			      IFACE_NAME_TEMPLATE, NET_NAME_UNKNOWN,
> @@ -803,7 +799,9 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
>  	if (!netdev)
>  		return -ENOMEM;
>  
> -	set_dev_addr(netdev, &chan->src, chan->src_type);
> +	netdev->addr_assign_type = NET_ADDR_PERM;
> +	for (i = 0; i < sizeof(chan->src); i++)
> +		netdev->dev_addr[i] = chan->src.b[sizeof(chan->src) - 1 - i];
>  
>  	netdev->netdev_ops = &netdev_ops;
>  	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
> 

- Alex

[0] http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L452
[1] http://lxr.free-electrons.com/source/net/6lowpan/iphc.c#L327
