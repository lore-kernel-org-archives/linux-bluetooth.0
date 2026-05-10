Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0F81732
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2026 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778377457; cv=none; b=DovNAFfCIu9ijZVKNd9owVgBvoHjrbDNd08NTaMdfA1rW1OuZ8oszTkRZgMTBlyqF7iPi9E7UrAZxSvO5+IHqt3R4m0uPzJ7Xhd0VsYEit7FDKKoXw6Wg+9UIxa4ta+IebGTQtRrTnBcIS4hqKLepEWyqj3Nnd15CbPQo3uPZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778377457; c=relaxed/simple;
	bh=eJdPO7hSWxQQxN4nqsoX8jtFgqUUt4vQXuLHYdY10mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8pARkwGMoyOc14jMOPCfazDl/1xTse8vSnGOgnLUPnc61tbDEwfE747eOdGCqH7xgQyRQOqjszIpRbu1fVtjfMCHybfnfPSNFB4Xi1IjEK/yJiBiMTCySMMEsu7PtokYrzoXPMVuwARyopCZM3XB2j/Xa6p2SpZtTgqlO1HCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=OIe7Zlqv; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="OIe7Zlqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1778377450;
	bh=ivAjlDjThhDb8MJ8lA3QsxEVl8yNT4Po/P1b+iV8q08=;
	h=From:Subject:Date:Message-ID;
	b=OIe7ZlqvekpK/C+RdCjloITTTtCqHQGShzU4KO1nusTPLjhAT5XuAHt2UwdBenTBj
	 +w6tGaAPlMysXAH5oAVqEAcjzTLnNyKKH1skEo3psyyaOPZB31ML//ZiSSLrNahRmv
	 WIwLKlL1wogmeyCZ1YKM90uD9iKndSmppqCKPnwI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.32) with ESMTP
	id 69FFE2DE00003853; Sun, 10 May 2026 09:44:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2950034457033
X-SMAIL-UIID: 560741E10A204BBC9313BD5247439691-20260510-094400-1
From: Hillf Danton <hdanton@sina.com>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com
Subject: Re: [PATCH] Bluetooth: 6lowpan: Defer peer channel release until RCU cleanup
Date: Sun, 10 May 2026 09:43:56 +0800
Message-ID: <20260510014359.472-1-hdanton@sina.com>
In-Reply-To: <20260509173745.413473-1-rollkingzzc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 10 May 2026 01:37:45 +0800 Zhang Cen wrote:
> A 6LoWPAN peer stores the protocol-owned L2CAP channel reference in
> peer->chan. chan_close_cb() removes the peer from the RCU list, but it
> also drops that reference immediately. The peer object can still be seen
> by in-flight RCU readers, and some paths keep using peer->chan after the
> lookup has finished.
> 
> That lets transmit and disconnect paths dereference, lock, or send
> through a channel whose last reference was released by the close path.
> 
Sounds like the race between close and lookup paths

	chan_close_cb()		setup_header()
	---			---
	peer_del()
	  list_del_rcu(&peer->list);
	  kfree_rcu(peer, rcu);
	l2cap_chan_put(c); // free chan

				peer_lookup_dst(dev, &ipv6_daddr, skb);
				  rcu_read_lock();
				  peer = find peer;
				  rcu_read_unlock();
				if (peer)
					addr = peer->chan->dst; //uaf

and on the lookup side, a) peer is unsafe outside rcu lock and
b) chan is used after put.

To fix the race, in addition to move l2cap_chan_put() to the rcu
callback as this patch does, refcount should be added to peer to
make the lookup path safe.

	chan_close_cb()		setup_header()
	---			---
	peer_del()
	  list_del_rcu(&peer->list);
	  call_rcu(&peer->rcu, peer_free_rcu);
	    if (peer->refcount-- == 0) {
	        //alternatively schedule workqueue if task context needed
	    	l2cap_chan_put(c);
		kfree(peer);
		module_put(THIS_MODULE);
	    }
				peer_lookup_dst(dev, &ipv6_daddr, skb);
				  rcu_read_lock();
				  peer = find peer;
				  if (peer)
				  	peer->refcount++;
				  rcu_read_unlock();
				if (peer) {
					addr = peer->chan->dst;
					if (peer->refcount-- == 0)
						schedule workqueue to free peer;
				}

> Defer the peer-owned l2cap_chan_put() until the peer RCU callback so a
> peer that remains observable through RCU still carries a live channel
> reference. Then take temporary channel references in the unicast,
> multicast, and explicit disconnect paths before they keep using the
> channel after the lookup window closes.
> 
> If the reader reaches step 3 after teardown reaches step 4, it can hit a
> freed l2cap_chan.
> 
> The buggy scenario involves two paths, with each column showing the order within that path:
> 
>   L2CAP peer teardown:                   Concurrent peer reader:
>   1. l2cap_conn_del() or another         1. A reader such as
>      close path takes a temporary           __peer_lookup_conn(),
>      hold on the channel                    setup_header(),
>                                             send_mcast_pkt(), or
>                                             bt_6lowpan_disconnect()
>                                             traverses the peer list and
>                                             reads peer->chan
>   2. l2cap_chan_del() drops the          2. The reader keeps using the
>      connection-owned channel               raw channel pointer after the
>      reference before 6LoWPAN               lookup or after only RCU
>      close handling finishes                protection remains
>   3. chan_close_cb() removes the         3. It dereferences channel
>      matching lowpan_peer from the          fields or calls send or close
>      peer list                              operations through that
>                                             pointer
>   4. The original chan_close_cb()
>      also dropped the peer-owned
>      l2cap_chan reference, and the
>      close caller later released
>      its temporary hold
> 
> A peer reader can still observe the lowpan_peer while chan_close_cb()
> has already consumed the peer-owned channel reference and the close
> caller is releasing the last temporary hold, leaving peer->chan stale
> before the peer's RCU grace period ends.
> 
> lowpan_peer objects stay RCU-visible after peer_del() removes them from
> the list.
> 
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> 
> ---
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 2f03b780b40d..ea3ee6929101 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -95,13 +95,20 @@ static inline void peer_add(struct lowpan_btle_dev *dev,
>  	atomic_inc(&dev->peer_count);
>  }
>  
> +static void peer_free_rcu(struct rcu_head *rcu)
> +{
> +	struct lowpan_peer *peer = container_of(rcu, struct lowpan_peer, rcu);
> +
> +	l2cap_chan_put(peer->chan);
> +	kfree(peer);
> +	module_put(THIS_MODULE);
> +}
> +
>  static inline bool peer_del(struct lowpan_btle_dev *dev,
>  			    struct lowpan_peer *peer)
>  {
>  	list_del_rcu(&peer->list);
> -	kfree_rcu(peer, rcu);
> -
> -	module_put(THIS_MODULE);
> +	call_rcu(&peer->rcu, peer_free_rcu);
>  
>  	if (atomic_dec_and_test(&dev->peer_count)) {
>  		BT_DBG("last peer");
> @@ -137,9 +144,32 @@ __peer_lookup_conn(struct lowpan_btle_dev *dev, struct l2cap_conn *conn)
>  	return NULL;
>  }
>  
> -static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
> -						  struct in6_addr *daddr,
> -						  struct sk_buff *skb)
> +static struct l2cap_chan *lookup_peer_chan(struct l2cap_conn *conn)
> +{
> +	struct lowpan_btle_dev *entry;
> +	struct lowpan_peer *peer;
> +	struct l2cap_chan *chan = NULL;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
> +		peer = __peer_lookup_conn(entry, conn);
> +		if (peer) {
> +			chan = peer->chan;
> +			l2cap_chan_hold(chan);
> +			break;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return chan;
> +}
> +
> +static int peer_lookup_dst(struct lowpan_btle_dev *dev, struct in6_addr *daddr,
> +			   struct sk_buff *skb, u8 *lladdr,
> +			   bdaddr_t *peer_addr, u8 *peer_addr_type,
> +			   struct l2cap_chan **chan)
>  {
>  	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
>  	int count = atomic_read(&dev->peer_count);
> @@ -175,13 +205,20 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
>  	rcu_read_lock();
>  
>  	list_for_each_entry_rcu(peer, &dev->peers, list) {
> +		struct l2cap_chan *pchan = peer->chan;
> +
>  		BT_DBG("dst addr %pMR dst type %u ip %pI6c",
> -		       &peer->chan->dst, peer->chan->dst_type,
> +		       &pchan->dst, pchan->dst_type,
>  		       &peer->peer_addr);
>  
>  		if (!ipv6_addr_cmp(&peer->peer_addr, nexthop)) {
> +			memcpy(lladdr, peer->lladdr, ETH_ALEN);
> +			*peer_addr = pchan->dst;
> +			*peer_addr_type = pchan->dst_type;
> +			l2cap_chan_hold(pchan);
> +			*chan = pchan;
>  			rcu_read_unlock();
> -			return peer;
> +			return 0;
>  		}
>  	}
>  
> @@ -190,9 +227,16 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
>  	if (neigh) {
>  		list_for_each_entry_rcu(peer, &dev->peers, list) {
>  			if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN)) {
> +				struct l2cap_chan *pchan = peer->chan;
> +
> +				memcpy(lladdr, peer->lladdr, ETH_ALEN);
> +				*peer_addr = pchan->dst;
> +				*peer_addr_type = pchan->dst_type;
> +				l2cap_chan_hold(pchan);
> +				*chan = pchan;
>  				neigh_release(neigh);
>  				rcu_read_unlock();
> -				return peer;
> +				return 0;
>  			}
>  		}
>  		neigh_release(neigh);
> @@ -200,7 +244,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
>  
>  	rcu_read_unlock();
>  
> -	return NULL;
> +	return -ENOENT;
>  }
>  
>  static struct lowpan_peer *lookup_peer(struct l2cap_conn *conn)
> @@ -379,7 +423,7 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
>  	struct in6_addr ipv6_daddr;
>  	struct ipv6hdr *hdr;
>  	struct lowpan_btle_dev *dev;
> -	struct lowpan_peer *peer;
> +	u8 peer_lladdr[ETH_ALEN];
>  	u8 *daddr;
>  	int err, status = 0;
>  
> @@ -388,9 +432,9 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
>  	dev = lowpan_btle_dev(netdev);
>  
>  	memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));
> +	lowpan_cb(skb)->chan = NULL;
>  
>  	if (ipv6_addr_is_multicast(&ipv6_daddr)) {
> -		lowpan_cb(skb)->chan = NULL;
>  		daddr = NULL;
>  	} else {
>  		BT_DBG("dest IP %pI6c", &ipv6_daddr);
> @@ -400,16 +444,15 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
>  		 * or user set route) so get peer according to
>  		 * the destination address.
>  		 */
> -		peer = peer_lookup_dst(dev, &ipv6_daddr, skb);
> -		if (!peer) {
> +		err = peer_lookup_dst(dev, &ipv6_daddr, skb, peer_lladdr,
> +				      peer_addr, peer_addr_type,
> +				      &lowpan_cb(skb)->chan);
> +		if (err) {
>  			BT_DBG("no such peer");
> -			return -ENOENT;
> +			return err;
>  		}
>  
> -		daddr = peer->lladdr;
> -		*peer_addr = peer->chan->dst;
> -		*peer_addr_type = peer->chan->dst_type;
> -		lowpan_cb(skb)->chan = peer->chan;
> +		daddr = peer_lladdr;
>  
>  		status = 1;
>  	}
> @@ -417,8 +460,13 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
>  	lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_addr);
>  
>  	err = dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0);
> -	if (err < 0)
> +	if (err < 0) {
> +		if (lowpan_cb(skb)->chan) {
> +			l2cap_chan_put(lowpan_cb(skb)->chan);
> +			lowpan_cb(skb)->chan = NULL;
> +		}
>  		return err;
> +	}
>  
>  	return status;
>  }
> @@ -483,15 +531,23 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
>  		dev = lowpan_btle_dev(entry->netdev);
>  
>  		list_for_each_entry_rcu(pentry, &dev->peers, list) {
> +			struct l2cap_chan *chan = pentry->chan;
>  			int ret;
>  
>  			local_skb = skb_clone(skb, GFP_ATOMIC);
> +			if (!local_skb) {
> +				err = -ENOMEM;
> +				continue;
> +			}
> +
> +			l2cap_chan_hold(chan);
>  
>  			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
>  			       netdev->name,
> -			       &pentry->chan->dst, pentry->chan->dst_type,
> -			       &pentry->peer_addr, pentry->chan);
> -			ret = send_pkt(pentry->chan, local_skb, netdev);
> +			       &chan->dst, chan->dst_type,
> +			       &pentry->peer_addr, chan);
> +			ret = send_pkt(chan, local_skb, netdev);
> +			l2cap_chan_put(chan);
>  			if (ret < 0)
>  				err = ret;
>  
> @@ -530,10 +586,14 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
>  
>  	if (err) {
>  		if (lowpan_cb(skb)->chan) {
> +			struct l2cap_chan *chan = lowpan_cb(skb)->chan;
> +
>  			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
>  			       netdev->name, &addr, addr_type,
> -			       &lowpan_cb(skb)->addr, lowpan_cb(skb)->chan);
> -			err = send_pkt(lowpan_cb(skb)->chan, skb, netdev);
> +			       &lowpan_cb(skb)->addr, chan);
> +			err = send_pkt(chan, skb, netdev);
> +			l2cap_chan_put(chan);
> +			lowpan_cb(skb)->chan = NULL;
>  		} else {
>  			err = -ENOENT;
>  		}
> @@ -802,8 +862,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
>  			       last ? "last " : "1 ", peer);
>  			BT_DBG("chan %p orig refcnt %u", chan,
>  			       kref_read(&chan->kref));
> -
> -			l2cap_chan_put(chan);
>  			break;
>  		}
>  	}
> @@ -917,19 +975,20 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
>  
>  static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
>  {
> -	struct lowpan_peer *peer;
> +	struct l2cap_chan *chan;
>  
>  	BT_DBG("conn %p dst type %u", conn, dst_type);
>  
> -	peer = lookup_peer(conn);
> -	if (!peer)
> +	chan = lookup_peer_chan(conn);
> +	if (!chan)
>  		return -ENOENT;
>  
> -	BT_DBG("peer %p chan %p", peer, peer->chan);
> +	BT_DBG("chan %p", chan);
>  
> -	l2cap_chan_lock(peer->chan);
> -	l2cap_chan_close(peer->chan, ENOENT);
> -	l2cap_chan_unlock(peer->chan);
> +	l2cap_chan_lock(chan);
> +	l2cap_chan_close(chan, ENOENT);
> +	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  
>  	return 0;
>  }
> 
