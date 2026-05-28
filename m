Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEC324718
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953833; cv=pass; b=FuQRIp0jEl51wER7d4tC2gbmOBu1NaL7zoG5TpJA7I9yEhc9AR4bZ6tVb3Zsp5UzkyrBgT3Z/q8n2Q3yJgVORK2Qs06g4IwY8yg4WJaC87bc2z8kZr3DSUhNCACxRWCIO0434qIFDEkN38LS4cfk54TxLwE5ftv7BSCtsexL5KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953833; c=relaxed/simple;
	bh=NjRKH/2Mg1QKmnbSO4uhd5jnNPqv1FpPmsNApPJldFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF6GGb6wPS+xb2/B1m0h3UJtHMFVay7PHAt+wHZxlORXJKHKifLkfE9nhV9r7eyhfF+RvnVirPhjylym0N+y/8rPqnijEQ3D3DJLGI3xwtGtomwYt8ZCZUN3i13GyrADD1UY7yAlJVnOnjOO08sl5k1XA5S+81ARRfOCjj7DdbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=as480+LF; arc=pass smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as480+LF"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-38e7d983f91so109639471fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 00:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779953830; cv=none;
        d=google.com; s=arc-20240605;
        b=JdIKgT7COZZVn3lrBYmlZ7yg7gIzW5EjIvVuzz5i9eqXiCVb6dw+TtALqJ0Vya3w4d
         OUZp4oSJJp9oytNafiRql1X1tG1VEbDd/gu3Jq2RB+9ZDFm2b+kUtqZc+DlxUOU7I9tI
         vcPwr8AydMhIQCoysfwZKWNIjcfhKUwbJ/3DxSrQJcgpqsnaNdHI/yHcZWuSP9qg6Vs8
         hvLbcYPEAcas3ZbA2EOi7QnzBx5lDTYBKmTUBwq/acssvj/cvulFNwP5l5TQ3kdzF7Uk
         zYoAUlqX+GjmUYwckP11fOLH9ACimVl+NuEoU7kYLL0KTkhdoQFPKUlFoSdOQu+sBGHc
         9p1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9hKkAaHLQjn/+K3bm33ixfOAQG0PzX3RECheX+9OzY=;
        fh=Z2BuGqv/ExsADAxBxwhk9jrlnufn6BfUcO9lu1LsAdY=;
        b=DZUeCTPFlUnfhvSA6ONhyzjzAUhfm+VNWilFOpysJIojyhJbzu6eMsIJuiAslFppdt
         a47MN4b4tS20HKgZf7iIv8VgLySj1LGjrKiJE1WfxBCF7+J/g4ZR3x1LVfbIBn6cVx/v
         LisksOvm046U7MJbpTviETbAI3Mj1STdX2MdnHnCHFLq6/N2uhUa5Kty/hJveatNrKbK
         xKXkkgEddmd5V2dIfpmXxGI1fdRI9AwKGEXovnj2gdkjAaqNCsaHbLZXu3WXGGP2dW15
         6THwbthp5P/FeYvdCHI3I6dL9KyBxc8T/4Pf4S9KOz3J7xD+f4FvXziS3DfL52a+gtKs
         +fNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779953830; x=1780558630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9hKkAaHLQjn/+K3bm33ixfOAQG0PzX3RECheX+9OzY=;
        b=as480+LFqvhF1dwFhAQu/iVkUYUrJa61xLISsRC4Q/W63AxfPi1ItUZUcH48kLV5FX
         HVD2P34ywmXQj1KNkI7TK5LTkTKTZ0EOD/pXiYaZyemYsYLw1IW5f29ijLZ3u93+xFxX
         VIS8NgeMmY3dL3Nu4YxGgIxCfBvCKR20CUpFdf1H5BcBYbd9JmbfeonlI1XH/wYZJOao
         QqaTK87pQxKZOMhs8qIDaSNpphj6ycaj4PM60uITBFHsv5Uk7RTexvXC5w3KHut0iRE4
         Kzbti/NzMuJstO4068HRi2NIbqZUzPAT68518qVMXnUkKCQZUKAAZjX47gRNTrVesC4G
         Sl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779953830; x=1780558630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9hKkAaHLQjn/+K3bm33ixfOAQG0PzX3RECheX+9OzY=;
        b=ZHGSJ06F74KKSoJFoN3Hcq32mkykOEjVagNqnxN2noR+WRVyrMxsPuGxn2Z3wJK3+8
         UxS+zr2zRy7CvOOPHpOM556lrpadgOVOLUgDd/F5uXxbrEGbKn6n/e68KPpahxOi7kB/
         DOLHGZ4VWdAhxhI2dXJ63zE3HKjdqVjED2NSQcrLkyvwJsmftwIz83wic55o/c3KFe/T
         lwGj0ps9IBX1QUuj1Ot4+cQ6f5lYmzVC3q7VVqnjLApLOB9GVqD6B9dx194VgxYbXjs5
         RjlbOjAtyNNHFanHl4uDpI0L9Dbs9dsLxFPRwqBYq06LW9s7SPN0vwD7kbITl6vpXkNW
         Eefg==
X-Gm-Message-State: AOJu0YwyLj5Isv/JqIDJvcVKavUTuL54J7j5aut5Coy2TsOfVQnEUqK7
	ly7SH2SIeVRcpAT83HYnwXIPWG6N1iq5Z96P6cyRGJQNJPC8aJBWjP5drF/bn3hA+iqPHzxgEAj
	Cop8wTHktMgj/3XOjFcLrINlXE/0GuAU=
X-Gm-Gg: Acq92OF2WCzs5o21rHtIXwbelZJTgZjNbWoMNJptfxFWhQlCk3CEfSuqUWjqsWteJs7
	vcRjeJGfsot0MigamckHuiCxS/ZoSeUVbF9fg8bcHr/B3HapU+vHifrC/8cBp8tI66Bz9L2lqjI
	MxS9+H4MfBFtQ+ZOJatWKrWjSrwRCTwVwZjZP/RYCdNgz8up8e7DVwq+KLeVEXC9NwUtniUa7YC
	cm9kfY85QQPI9WMk+CFEBh8M/7zbolQLQ4hjMPZmqqcOWsKq3+ppTr2k/ZxRkYCT4CRkkTob9wF
	WIM1g0ntEAuvXrV3crfIMHnt607XdlU=
X-Received: by 2002:a2e:be0d:0:b0:38f:e999:6a5a with SMTP id
 38308e7fff4ca-395d8c20ec6mr86479301fa.11.1779953829652; Thu, 28 May 2026
 00:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511172310.3723421-1-rollkingzzc@gmail.com>
In-Reply-To: <20260511172310.3723421-1-rollkingzzc@gmail.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Thu, 28 May 2026 15:36:54 +0800
X-Gm-Features: AVHnY4JaEEA3qZVGATuqQhZX0krzkXJEgexVC4bYMM2c3cLonB_PB2xNkLvhUkY
Message-ID: <CAB7XQsG+9BRdEwLXvZCV7Xr83nOUpVQGJprA3UFcxRgPM=GJfw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: 6lowpan: Fix peer and channel lifetime
 during teardown
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hillf Danton <hdanton@sina.com>, zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel, Luiz,

Gentle ping on this v3.  This version makes the peer lifetime explicit
with a peer refcount, keeps lookup-returned peers pinned after the RCU
lookup, and defers the peer-owned L2CAP channel release out of the RCU
callback.

The bluetooth test bot reported no failures.  Please let me know if you
would prefer this to be simplified or split differently.

Thanks,
Zhang Cen

Zhang Cen <rollkingzzc@gmail.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C 01:23=E5=86=99=E9=81=93=EF=BC=9A
>
> A 6LoWPAN peer keeps a protocol-owned L2CAP channel reference in
> peer->chan. chan_close_cb() removes the peer from the RCU list when the
> channel is closed, but the old code also dropped that channel reference
> before the peer object stopped being observable by in-flight RCU readers.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
>   close path:                            lookup/transmit path:
>   l2cap_conn_del() or another            setup_header(), send_mcast_pkt()=
,
>   close path holds a temporary           bt_6lowpan_disconnect(), or
>   channel reference                      chan_recv_cb() observes a peer
>
>   l2cap_chan_del() drops the             the reader leaves the RCU read
>   connection-owned channel reference     side critical section, or keeps
>                                          using peer->chan inside it
>
>   chan_close_cb() removes the peer       the reader reads channel fields,
>   from the peer list                     locks the channel, or sends
>                                          through peer->chan
>
>   the old chan_close_cb() dropped
>   the peer-owned channel reference
>
>   the close caller releases its
>   temporary channel reference
>
> If the close path consumes the peer-owned channel reference before a
> reader finishes with peer->chan, the reader can use a freed l2cap_chan.
> The lookup helpers that returned raw peer pointers after rcu_read_unlock(=
)
> also let callers outlive the peer object's kfree_rcu() lifetime.
>
> Give lowpan_peer its own refcount and make RCU lookups acquire a peer
> reference before returning a peer to code that runs outside the read-side
> critical section. Keep the peer-owned L2CAP channel reference attached to
> the peer until the last peer reference is dropped.
>
> The last peer put can happen from an RCU callback or from the network
> transmit path, so do not drop the final L2CAP channel reference directly
> from lowpan_peer_put(). Queue final peer destruction to a dedicated
> workqueue and release the channel and module references there. Store the
> peer, rather than a temporary channel reference, in the skb control block
> for unicast transmit, and put the peer after the send path is done.
> Multicast continues to use peer->chan only while it is inside the RCU
> read-side critical section.
>
> Wait for queued RCU callbacks and peer-destroy work during module exit so
> asynchronous peer destruction cannot outlive the module text.
>
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> ---
>  net/bluetooth/6lowpan.c | 128 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 104 insertions(+), 24 deletions(-)
>
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 23a229ab6..7a1b0d7b0 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -9,6 +9,8 @@
>  #include <linux/etherdevice.h>
>  #include <linux/module.h>
>  #include <linux/debugfs.h>
> +#include <linux/refcount.h>
> +#include <linux/workqueue.h>
>
>  #include <net/ipv6.h>
>  #include <net/ip6_route.h>
> @@ -29,10 +31,12 @@ static struct dentry *lowpan_control_debugfs;
>
>  #define IFACE_NAME_TEMPLATE "bt%d"
>
> +struct lowpan_peer;
> +
>  struct skb_cb {
>         struct in6_addr addr;
>         struct in6_addr gw;
> -       struct l2cap_chan *chan;
> +       struct lowpan_peer *peer;
>  };
>  #define lowpan_cb(skb) ((struct skb_cb *)((skb)->cb))
>
> @@ -52,6 +56,7 @@ static bool enable_6lowpan;
>   */
>  static struct l2cap_chan *listen_chan;
>  static DEFINE_MUTEX(set_lock);
> +static struct workqueue_struct *lowpan_peer_wq;
>
>  enum {
>         LOWPAN_PEER_CLOSING,
> @@ -61,6 +66,8 @@ enum {
>  struct lowpan_peer {
>         struct list_head list;
>         struct rcu_head rcu;
> +       struct work_struct destroy_work;
> +       refcount_t refcnt;
>         struct l2cap_chan *chan;
>
>         /* peer addresses in various formats */
> @@ -95,13 +102,39 @@ static inline void peer_add(struct lowpan_btle_dev *=
dev,
>         atomic_inc(&dev->peer_count);
>  }
>
> +static inline bool lowpan_peer_get_unless_zero(struct lowpan_peer *peer)
> +{
> +       return refcount_inc_not_zero(&peer->refcnt);
> +}
> +
> +static void lowpan_peer_destroy(struct work_struct *work)
> +{
> +       struct lowpan_peer *peer =3D container_of(work, struct lowpan_pee=
r,
> +                                               destroy_work);
> +
> +       l2cap_chan_put(peer->chan);
> +       kfree(peer);
> +       module_put(THIS_MODULE);
> +}
> +
> +static void lowpan_peer_put(struct lowpan_peer *peer)
> +{
> +       if (refcount_dec_and_test(&peer->refcnt))
> +               queue_work(lowpan_peer_wq, &peer->destroy_work);
> +}
> +
> +static void lowpan_peer_put_rcu(struct rcu_head *rcu)
> +{
> +       struct lowpan_peer *peer =3D container_of(rcu, struct lowpan_peer=
, rcu);
> +
> +       lowpan_peer_put(peer);
> +}
> +
>  static inline bool peer_del(struct lowpan_btle_dev *dev,
>                             struct lowpan_peer *peer)
>  {
>         list_del_rcu(&peer->list);
> -       kfree_rcu(peer, rcu);
> -
> -       module_put(THIS_MODULE);
> +       call_rcu(&peer->rcu, lowpan_peer_put_rcu);
>
>         if (atomic_dec_and_test(&dev->peer_count)) {
>                 BT_DBG("last peer");
> @@ -179,7 +212,8 @@ static inline struct lowpan_peer *peer_lookup_dst(str=
uct lowpan_btle_dev *dev,
>                        &peer->chan->dst, peer->chan->dst_type,
>                        &peer->peer_addr);
>
> -               if (!ipv6_addr_cmp(&peer->peer_addr, nexthop)) {
> +               if (!ipv6_addr_cmp(&peer->peer_addr, nexthop) &&
> +                   lowpan_peer_get_unless_zero(peer)) {
>                         rcu_read_unlock();
>                         return peer;
>                 }
> @@ -189,7 +223,8 @@ static inline struct lowpan_peer *peer_lookup_dst(str=
uct lowpan_btle_dev *dev,
>         neigh =3D __ipv6_neigh_lookup(dev->netdev, nexthop);
>         if (neigh) {
>                 list_for_each_entry_rcu(peer, &dev->peers, list) {
> -                       if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN)) {
> +                       if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN) &&
> +                           lowpan_peer_get_unless_zero(peer)) {
>                                 neigh_release(neigh);
>                                 rcu_read_unlock();
>                                 return peer;
> @@ -212,8 +247,9 @@ static struct lowpan_peer *lookup_peer(struct l2cap_c=
onn *conn)
>
>         list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
>                 peer =3D __peer_lookup_conn(entry, conn);
> -               if (peer)
> +               if (peer && lowpan_peer_get_unless_zero(peer))
>                         break;
> +               peer =3D NULL;
>         }
>
>         rcu_read_unlock();
> @@ -361,8 +397,10 @@ static int chan_recv_cb(struct l2cap_chan *chan, str=
uct sk_buff *skb)
>                 return -ENOENT;
>
>         dev =3D lookup_dev(chan->conn);
> -       if (!dev || !dev->netdev)
> +       if (!dev || !dev->netdev) {
> +               lowpan_peer_put(peer);
>                 return -ENOENT;
> +       }
>
>         err =3D recv_pkt(skb, dev->netdev, peer);
>         if (err) {
> @@ -370,6 +408,8 @@ static int chan_recv_cb(struct l2cap_chan *chan, stru=
ct sk_buff *skb)
>                 err =3D -EAGAIN;
>         }
>
> +       lowpan_peer_put(peer);
> +
>         return err;
>  }
>
> @@ -380,6 +420,8 @@ static int setup_header(struct sk_buff *skb, struct n=
et_device *netdev,
>         struct ipv6hdr *hdr;
>         struct lowpan_btle_dev *dev;
>         struct lowpan_peer *peer;
> +       struct l2cap_chan *chan;
> +       u8 peer_lladdr[ETH_ALEN];
>         u8 *daddr;
>         int err, status =3D 0;
>
> @@ -388,9 +430,9 @@ static int setup_header(struct sk_buff *skb, struct n=
et_device *netdev,
>         dev =3D lowpan_btle_dev(netdev);
>
>         memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));
> +       lowpan_cb(skb)->peer =3D NULL;
>
>         if (ipv6_addr_is_multicast(&ipv6_daddr)) {
> -               lowpan_cb(skb)->chan =3D NULL;
>                 daddr =3D NULL;
>         } else {
>                 BT_DBG("dest IP %pI6c", &ipv6_daddr);
> @@ -406,10 +448,13 @@ static int setup_header(struct sk_buff *skb, struct=
 net_device *netdev,
>                         return -ENOENT;
>                 }
>
> -               daddr =3D peer->lladdr;
> -               *peer_addr =3D peer->chan->dst;
> -               *peer_addr_type =3D peer->chan->dst_type;
> -               lowpan_cb(skb)->chan =3D peer->chan;
> +               chan =3D peer->chan;
> +               memcpy(peer_lladdr, peer->lladdr, ETH_ALEN);
> +               *peer_addr =3D chan->dst;
> +               *peer_addr_type =3D chan->dst_type;
> +               lowpan_cb(skb)->peer =3D peer;
> +
> +               daddr =3D peer_lladdr;
>
>                 status =3D 1;
>         }
> @@ -417,8 +462,13 @@ static int setup_header(struct sk_buff *skb, struct =
net_device *netdev,
>         lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_addr)=
;
>
>         err =3D dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0);
> -       if (err < 0)
> +       if (err < 0) {
> +               if (lowpan_cb(skb)->peer) {
> +                       lowpan_peer_put(lowpan_cb(skb)->peer);
> +                       lowpan_cb(skb)->peer =3D NULL;
> +               }
>                 return err;
> +       }
>
>         return status;
>  }
> @@ -486,6 +536,10 @@ static int send_mcast_pkt(struct sk_buff *skb, struc=
t net_device *netdev)
>                         int ret;
>
>                         local_skb =3D skb_clone(skb, GFP_ATOMIC);
> +                       if (!local_skb) {
> +                               err =3D -ENOMEM;
> +                               continue;
> +                       }
>
>                         BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p"=
,
>                                netdev->name,
> @@ -529,11 +583,17 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, str=
uct net_device *netdev)
>         }
>
>         if (err) {
> -               if (lowpan_cb(skb)->chan) {
> +               struct lowpan_peer *peer =3D lowpan_cb(skb)->peer;
> +
> +               if (peer) {
> +                       struct l2cap_chan *chan =3D peer->chan;
> +
>                         BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p"=
,
>                                netdev->name, &addr, addr_type,
> -                              &lowpan_cb(skb)->addr, lowpan_cb(skb)->cha=
n);
> -                       err =3D send_pkt(lowpan_cb(skb)->chan, skb, netde=
v);
> +                              &lowpan_cb(skb)->addr, chan);
> +                       err =3D send_pkt(chan, skb, netdev);
> +                       lowpan_peer_put(peer);
> +                       lowpan_cb(skb)->peer =3D NULL;
>                 } else {
>                         err =3D -ENOENT;
>                 }
> @@ -649,6 +709,8 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_=
chan *chan,
>         if (!peer)
>                 return NULL;
>
> +       INIT_WORK(&peer->destroy_work, lowpan_peer_destroy);
> +       refcount_set(&peer->refcnt, 1);
>         peer->chan =3D chan;
>
>         baswap((void *)peer->lladdr, &chan->dst);
> @@ -822,8 +884,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
>                                last ? "last " : "1 ", peer);
>                         BT_DBG("chan %p orig refcnt %u", chan,
>                                kref_read(&chan->kref));
> -
> -                       l2cap_chan_put(chan);
>                         break;
>                 }
>         }
> @@ -938,6 +998,7 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_=
type)
>  static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
>  {
>         struct lowpan_peer *peer;
> +       struct l2cap_chan *chan;
>
>         BT_DBG("conn %p dst type %u", conn, dst_type);
>
> @@ -945,11 +1006,14 @@ static int bt_6lowpan_disconnect(struct l2cap_conn=
 *conn, u8 dst_type)
>         if (!peer)
>                 return -ENOENT;
>
> -       BT_DBG("peer %p chan %p", peer, peer->chan);
> +       chan =3D peer->chan;
> +
> +       BT_DBG("peer %p chan %p", peer, chan);
>
> -       l2cap_chan_lock(peer->chan);
> -       l2cap_chan_close(peer->chan, ENOENT);
> -       l2cap_chan_unlock(peer->chan);
> +       l2cap_chan_lock(chan);
> +       l2cap_chan_close(chan, ENOENT);
> +       l2cap_chan_unlock(chan);
> +       lowpan_peer_put(peer);
>
>         return 0;
>  }
> @@ -1189,6 +1253,7 @@ static ssize_t lowpan_control_write(struct file *fp=
,
>                         peer =3D lookup_peer(conn);
>                         if (peer) {
>                                 BT_DBG("6LoWPAN connection already exists=
");
> +                               lowpan_peer_put(peer);
>                                 return -EALREADY;
>                         }
>
> @@ -1320,6 +1385,12 @@ static struct notifier_block bt_6lowpan_dev_notifi=
er =3D {
>
>  static int __init bt_6lowpan_init(void)
>  {
> +       int err;
> +
> +       lowpan_peer_wq =3D alloc_ordered_workqueue("bt_6lowpan_peer", 0);
> +       if (!lowpan_peer_wq)
> +               return -ENOMEM;
> +
>         lowpan_enable_debugfs =3D debugfs_create_file_unsafe("6lowpan_ena=
ble",
>                                                            0644, bt_debug=
fs,
>                                                            NULL,
> @@ -1328,7 +1399,14 @@ static int __init bt_6lowpan_init(void)
>                                                      bt_debugfs, NULL,
>                                                      &lowpan_control_fops=
);
>
> -       return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
> +       err =3D register_netdevice_notifier(&bt_6lowpan_dev_notifier);
> +       if (err) {
> +               debugfs_remove(lowpan_enable_debugfs);
> +               debugfs_remove(lowpan_control_debugfs);
> +               destroy_workqueue(lowpan_peer_wq);
> +       }
> +
> +       return err;
>  }
>
>  static void __exit bt_6lowpan_exit(void)
> @@ -1346,6 +1424,8 @@ static void __exit bt_6lowpan_exit(void)
>         disconnect_devices();
>
>         unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
> +       rcu_barrier();
> +       destroy_workqueue(lowpan_peer_wq);
>  }
>
>  module_init(bt_6lowpan_init);
> --
> 2.43.0
>
