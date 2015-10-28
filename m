Return-Path: <cyrus@holtmann.org>
Message-ID: <1446022626.2902.17.camel@linux.intel.com>
Subject: Re: [RFC bluetooth-next 2/2] bluetooth: 6lowpan: rework receive
 handling
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de
Date: Wed, 28 Oct 2015 10:57:06 +0200
In-Reply-To: <1445698256-10407-3-git-send-email-alex.aring@gmail.com>
References: <1445698256-10407-1-git-send-email-alex.aring@gmail.com>
	 <1445698256-10407-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

Thanks for the patch, this fixes the UDP compression crash that I am
seeing in my tests. Some comments to the TODOs below.


On la, 2015-10-24 at 16:50 +0200, Alexander Aring wrote:
> This patch reworks the receive handling of bluetooth 6lowpan. I
> introduce the same mechanism like we do in 802.15.4 6LoWPAN. Small
> change is that I changed RX_QUEUED to RX_QUEUE, because it's not queued,
> returning RX_QUEUE means the skb will be queued.
> 
> About the TODOs:
> 
> I added several TODOs which I am not sure how to handle it right now.
> E.g. "skb->dev = dev", if this is really necessary, the current
> implementation does it in IPHC and not in IPv6 dispatch value.
> 
> About memory management here:
> 
> This is currently wrong somehow, you can see that at the first call of
> "skb_share_check", if this fails then the skb will be freed by
> kfree_skb. But the previous error checks doesn't kfree_skb the skb. This
> is a different handling for the same thing.
> 
> Jukka, please look how the ".recv" callback of "l2cap_ops" is working.
> Who will free the skb? The ".recv" callback of "l2cap_ops" if returning
> errno, or the callback itself need to do that. If it's when returning
> errno, then you can't use skb_share_check/skb_unshare here.

For the .recv callback in patch 1, I think we do not need to do anything
as it really looks like the actual error value is not used anywhere,
only thing important in l2cap_core.c is that there was an error, the
value is ignored.

> 
> I assume the callback itself need to do that.
> 
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/bluetooth/6lowpan.c | 157 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 95 insertions(+), 62 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index d936e7d..72ccbbf 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -29,6 +29,11 @@
>  
>  #define VERSION "0.1"
>  
> +typedef unsigned __bitwise__ lowpan_rx_result;
> +#define RX_CONTINUE		((__force lowpan_rx_result) 0u)
> +#define RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
> +#define RX_QUEUE		((__force lowpan_rx_result) 3u)
> +
>  static struct dentry *lowpan_enable_debugfs;
>  static struct dentry *lowpan_control_debugfs;
>  
> @@ -257,13 +262,38 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
>  
>  static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
>  {
> -	struct sk_buff *skb_cp;
> +	skb->protocol = htons(ETH_P_IPV6);
> +	skb->pkt_type = PACKET_HOST;
> +
> +	dev->stats.rx_bytes += skb->len;
> +	dev->stats.rx_packets++;
> +
> +	return netif_rx(skb);
> +}
>  
> -	skb_cp = skb_copy(skb, GFP_ATOMIC);
> -	if (!skb_cp)
> +static int lowpan_rx_handlers_result(struct sk_buff *skb,
> +				     struct net_device *dev,
> +				     lowpan_rx_result res)
> +{
> +	switch (res) {
> +	case RX_CONTINUE:
> +		/* nobody cared about this packet */
> +		net_warn_ratelimited("%s: received unknown dispatch\n",
> +				     __func__);
> +
> +		/* fall-through */
> +	case RX_DROP_UNUSABLE:
> +		kfree_skb(skb);
>  		return NET_RX_DROP;
> +	case RX_QUEUE:
> +		return give_skb_to_upper(skb, dev);
> +	default:
> +		/* should never occur */
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
>  
> -	return netif_rx(skb_cp);
> +	return NET_RX_DROP;
>  }
>  
>  static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
> @@ -287,82 +317,85 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
>  	return lowpan_header_decompress(skb, netdev, daddr, saddr);
>  }
>  
> -static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> -		    struct l2cap_chan *chan)
> +static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb,
> +					 struct net_device *dev,
> +					 struct l2cap_chan *chan)
>  {
> -	struct sk_buff *local_skb;
>  	int ret;
>  
> -	if (!netif_running(dev))
> -		goto drop;
> -
> -	if (dev->type != ARPHRD_6LOWPAN || !skb->len)
> -		goto drop;
> -
> -	skb_reset_network_header(skb);
> +	if (!lowpan_is_iphc(*skb_network_header(skb)))
> +		return RX_CONTINUE;
>  
> -	skb = skb_share_check(skb, GFP_ATOMIC);
> -	if (!skb)
> -		goto drop;
> -
> -	/* check that it's our buffer */
> -	if (lowpan_is_ipv6(*skb_network_header(skb))) {
> -		/* Copy the packet so that the IPv6 header is
> -		 * properly aligned.
> -		 */
> -		local_skb = skb_copy_expand(skb, NET_SKB_PAD - 1,
> -					    skb_tailroom(skb), GFP_ATOMIC);
> -		if (!local_skb)
> -			goto drop;
> +	ret = iphc_decompress(skb, dev, chan);
> +	if (ret < 0)
> +		return RX_DROP_UNUSABLE;
>  
> -		local_skb->protocol = htons(ETH_P_IPV6);
> -		local_skb->pkt_type = PACKET_HOST;
> +	return RX_QUEUE;
> +}
>  
> -		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
> +static lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb,
> +					 struct net_device *dev,
> +					 struct l2cap_chan *chan)
> +{
> +	if (!lowpan_is_ipv6(*skb_network_header(skb)))
> +		return RX_CONTINUE;
>  
> -		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
> -			kfree_skb(local_skb);
> -			goto drop;
> -		}
> +	/* Pull off the 1-byte of 6lowpan header. */
> +	skb_pull(skb, 1);
> +	return RX_QUEUE;
> +}
>  
> -		dev->stats.rx_bytes += skb->len;
> -		dev->stats.rx_packets++;
> +static int lowpan_invoke_rx_handlers(struct sk_buff *skb,
> +				     struct net_device *dev,
> +				     struct l2cap_chan *chan)
> +{
> +	lowpan_rx_result res;
>  
> -		consume_skb(local_skb);
> -		consume_skb(skb);
> -	} else if (lowpan_is_iphc(*skb_network_header(skb))) {
> -		local_skb = skb_clone(skb, GFP_ATOMIC);
> -		if (!local_skb)
> -			goto drop;
> +#define CALL_RXH(rxh)			\
> +	do {				\
> +		res = rxh(skb, dev, chan); \
> +		if (res != RX_CONTINUE)	\
> +			goto rxh_next;	\
> +	} while (0)
>  
> -		ret = iphc_decompress(local_skb, dev, chan);
> -		if (ret < 0) {
> -			kfree_skb(local_skb);
> -			goto drop;
> -		}
> +	/* likely at first */
> +	CALL_RXH(lowpan_rx_h_iphc);
> +	CALL_RXH(lowpan_rx_h_ipv6);
>  
> -		local_skb->protocol = htons(ETH_P_IPV6);
> -		local_skb->pkt_type = PACKET_HOST;
> -		local_skb->dev = dev;
> +rxh_next:
> +	return lowpan_rx_handlers_result(skb, dev, res);
> +}
>  
> -		if (give_skb_to_upper(local_skb, dev)
> -				!= NET_RX_SUCCESS) {
> -			kfree_skb(local_skb);
> -			goto drop;
> -		}
> +static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> +		    struct l2cap_chan *chan)
> +{
> +	/* TODO check for reserved, nalp dispatch here? */

Yes, NALP (Not A LoWPAN frame) should be checked.


> +	if (!netif_running(dev) ||
> +	    dev->type != ARPHRD_6LOWPAN || !skb->len)
> +		goto drop;
>  
> -		dev->stats.rx_bytes += skb->len;
> -		dev->stats.rx_packets++;
> +	/* we will manipulate the skb struct */
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb)
> +		goto out;
>  
> -		consume_skb(local_skb);
> -		consume_skb(skb);
> -	} else {
> -		goto drop;
> +	/* TODO is this done by bluetooth callback, before? */
> +	skb_reset_network_header(skb);

Tried this and commmented the reset away. Unfortunately no packets could
be received any more after that.


> +	/* TODO really necessary? Previous did that in one branch only */
> +	skb->dev = dev;

Commenting skb->dev away causes null pointer access and oops later in
the stack.

[  183.607760] BUG: unable to handle kernel NULL pointer dereference at
0000000000000048
[  183.608007] IP: [<ffffffff81664fc2>] enqueue_to_backlog+0x52/0x220
[  183.608007] PGD bf8e067 PUD 983d067 PMD 0 
[  183.608007] Oops: 0000 [#1] SMP 
[  183.608007] Modules linked in: cmac rfcomm btusb btrtl btbcm btintel
nhc_udp nhc_dest nhc_hop nhc_routing nhc_mobility nhc_ipv6 nhc_fragment
bluetooth_6lowpan 6lowpan nls_utf8 isofs fuse tun ip6t_rpfilter
ip6t_REJECT nf_reject_ipv6 xt_conntrack bnep bluetooth rfkill
ebtable_nat ebtable_broute bridge ebtable_filter ebtables ip6table_nat
nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle
ip6table_security ip6table_raw xt_connmark ip6table_filter ip6_tables
iptable_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
iptable_raw nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iosf_mbi
ppdev joydev pcspkr snd_intel8x0 snd_ac97_codec ac97_bus snd_seq
snd_seq_device snd_pcm snd_timer snd video parport_pc parport i2c_piix4
soundcore ata_generic 8021q garp stp llc mrp serio_raw fjes pata_acpi
e1000
[  183.608007] CPU: 0 PID: 2096 Comm: kworker/u3:2 Not tainted 4.3.0-rc6
+ #5
[  183.608007] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[  183.608007] Workqueue: hci0 hci_rx_work [bluetooth]
[  183.608007] task: ffff88002e87bb00 ti: ffff88000bca4000 task.ti:
ffff88000bca4000
[  183.608007] RIP: 0010:[<ffffffff81664fc2>]  [<ffffffff81664fc2>]
enqueue_to_backlog+0x52/0x220
[  183.608007] RSP: 0000:ffff88000bca7bc8  EFLAGS: 00010046
[  183.608007] RAX: 0000000000000000 RBX: ffff88003fc17e00 RCX:
0000000000000018
[  183.608007] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff88003fc17ecc
[  183.608007] RBP: ffff88000bca7c00 R08: 00000081bb495e01 R09:
0000000000000000
[  183.608007] R10: ffff880028bda760 R11: ffff88002500cfd8 R12:
0000000000017e00
[  183.608007] R13: ffff88000bca7c18 R14: ffff88003db73440 R15:
0000000000000286
[  183.608007] FS:  0000000000000000(0000) GS:ffff88003fc00000(0000)
knlGS:0000000000000000
[  183.608007] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  183.608007] CR2: 0000000000000048 CR3: 000000000bfa8000 CR4:
00000000000006f0
[  183.608007] Stack:
[  183.608007]  ffff8800251fbc68 ffff88000bca7c00 ffff88001e8b0000
ffff88003db73440
[  183.608007]  ffff88003db73440 ffff88003db73440 ffff880003acadf0
ffff88000bca7c38
[  183.608007]  ffffffff816651d4 0000000000000000 000002ff00000000
000000003dfb3176
[  183.608007] Call Trace:
[  183.608007]  [<ffffffff816651d4>] netif_rx_internal+0x44/0xf0
[  183.608007]  [<ffffffff81665330>] netif_rx_ni+0x20/0x70
[  183.608007]  [<ffffffffa0317f3f>] chan_recv_cb+0x2af/0x2f0
[bluetooth_6lowpan]
[  183.608007]  [<ffffffffa024c5d6>] l2cap_recv_frame+0x2916/0x2a30
[bluetooth]
[  183.608007]  [<ffffffff81651db7>] ? skb_release_data+0xa7/0xd0
[  183.608007]  [<ffffffff81651159>] ? kfree_skbmem+0x59/0x60
[  183.608007]  [<ffffffffa024cf7f>] ? l2cap_recv_acldata+0x4f/0x330
[bluetooth]
[  183.608007]  [<ffffffffa024d14f>] l2cap_recv_acldata+0x21f/0x330
[bluetooth]
[  183.608007]  [<ffffffffa02189a6>] hci_rx_work+0x196/0x3d0 [bluetooth]
[  183.608007]  [<ffffffff810b719e>] process_one_work+0x19e/0x3f0
[  183.608007]  [<ffffffff810b743e>] worker_thread+0x4e/0x450
[  183.608007]  [<ffffffff8177834c>] ? __schedule+0x36c/0x980
[  183.608007]  [<ffffffff810b73f0>] ? process_one_work+0x3f0/0x3f0
[  183.608007]  [<ffffffff810b73f0>] ? process_one_work+0x3f0/0x3f0
[  183.608007]  [<ffffffff810bcda8>] kthread+0xd8/0xf0
[  183.608007]  [<ffffffff810bccd0>] ? kthread_worker_fn+0x160/0x160
[  183.608007]  [<ffffffff8177cd9f>] ret_from_fork+0x3f/0x70
[  183.608007]  [<ffffffff810bccd0>] ? kthread_worker_fn+0x160/0x160
[  183.608007] Code: 89 d5 48 03 1c f5 60 d9 d2 81 9c 58 0f 1f 44 00 00
49 89 c7 fa 66 0f 1f 44 00 00 48 8d bb cc 00 00 00 e8 f2 76 11 00 49 8b
46 20 <48> 8b 40 48 a8 01 74 10 8b 93 c8 00 00 00 8b 05 5e 0e 6d 00 39 
[  183.608007] RIP  [<ffffffff81664fc2>] enqueue_to_backlog+0x52/0x220
[  183.608007]  RSP <ffff88000bca7bc8>
[  183.608007] CR2: 0000000000000048
[  183.608007] ---[ end trace ead20527bbe7e9a0 ]---
[  193.482702] send_mcast_pkt: xmit bt0 to 00:02:72:c6:42:12 type 1 IP
fe80::202:72ff:fec6:4212 chan ffff880025185fb0
[  193.487332] clocksource: timekeeping watchdog: Marking clocksource
'tsc' as unstable because the skew is too large:
[  193.492235] clocksource:                       'acpi_pm' wd_now:
31e1a6 wd_last: 153cbc mask: ffffff
[  193.496173] clocksource:                       'tsc' cs_now:
8863621b45 cs_last: 81b84b089a mask: ffffffffffffffff
[  194.221265] send_mcast_pkt: xmit bt0 to 00:02:72:c6:42:12 type 1 IP
fe80::202:72ff:fec6:4212 chan ffff880025185fb0
[  195.049693] send_mcast_pkt: xmit bt0 to 00:02:72:c6:42:12 type 1 IP
fe80::202:72ff:fec6:4212 chan ffff880025185fb0


> +
> +	/* iphc will manipulate the skb buffer, unshare it */
> +	if (lowpan_is_iphc(*skb_network_header(skb))) {
> +		skb = skb_unshare(skb, GFP_ATOMIC);
> +		if (!skb)
> +			goto out;
>  	}
>  
> -	return NET_RX_SUCCESS;
> +	return lowpan_invoke_rx_handlers(skb, dev, chan);
>  
>  drop:
> +	kfree_skb(skb);
> +out:
>  	dev->stats.rx_dropped++;
>  	return NET_RX_DROP;
>  }


Cheers,
Jukka


