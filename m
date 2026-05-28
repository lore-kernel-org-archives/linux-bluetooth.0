Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74DF3EFFD5
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974025; cv=pass; b=btHXzG+GoiUPXvdoo4zpWyeRinZLhcfBw4+06bgDV/N3C29Ue+/ePhrKrY+9lyOeu7nSC9HHMi67K1ANJb/v402kggNsIbgneDGbowU3CNTNr7nIii/7Zkd1gu1uegOAlP8V0WfZyi8uRo1DpkHGUgFEvxqMpnXq8iRuJLCkO30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974025; c=relaxed/simple;
	bh=Pq9/ahU2aH2zROtEX4CujwVZf5fqtyTynwsroJhow+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC09B0S6YpP91+oLJW5d6Mw8BYeKZV23caoAJYeyjfQesxuQaMkBAReTI6/OCf+uI8eNklBOstKj6OrPTV+yMYU6Gxp7bJ5Gx3XAhpuxK5SzCSRadmwC37djuTj5jookHqCXAgzTHj1rxgOM8BLTjbcNcv3s9Bk3BX05y6i5rmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaAxU/dt; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaAxU/dt"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6563f83ae9fso12365730d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 06:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779974023; cv=none;
        d=google.com; s=arc-20240605;
        b=TfunsjIZfd/nOY9XUmQUzhZ40jV+f0PDWpW7IV1Wuusqn80W+oIQ+gdg7+9Bkz9Bgt
         u0az40cinBQX6pIjmudglTRzgz6ayujDXvbCc1liX6tHUtBtmPz95/BaGouonUDfeGIB
         mps2gDyaBAjEInfxJjuGadkJY7ssvlt0MJsfIPlIIYDRTGD/15UcuvpfRaIJKm4i5w9+
         CEXiz8BEUdSKXCb4+fosPyZGKgxgR9ImDVvbOnoCi1oiW3gAT8qiI7vCyTCEeo1ObZ0X
         YLDoSIaQoMevKYP1S53NESesXfJfZ9RK1SGs5D3ZV/2XxVw9ofvibGXHy+6uO3ekvUqF
         RC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FC46tl/3Y2y1w2wMHFy3XfDmrZD6eZXx1A+RmWVtw8E=;
        fh=ACFSm2lPTQindzXmfQcTMj0yPCCA0wBEI3LoTudSPp8=;
        b=CJ2vwHW+xoisXvmrohklAdWDthaf/h9tkFdDDkcSX+FGks8AXNMcI7PhJLtqTkqVQS
         oZnXhR9zZQDOAEV6N17BXS9bujN9tU8do2IAmPa940QC3GN5vj52fj9NFzGxCPlkw3tW
         ZhjYyPzT2Rjr6NWMxQFZQJKqHToiGeoKn3hLwMis6PEwCU2oy8562SHKfHy6Ui2IxyuJ
         ns85Luzgt1mVcC3y14himtlkvaXTNy65BgwjpgZzarwDuMgd1pCwgd6nIH8+MBt3qgYm
         kiFDJQmJe0fWh4XTkD2rdWiJOINIBPOrr7/Op29hQEMlWBSD7JHvSXd2sbmSt5hMi7pK
         IUoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779974023; x=1780578823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC46tl/3Y2y1w2wMHFy3XfDmrZD6eZXx1A+RmWVtw8E=;
        b=WaAxU/dtyDG/PTHjCiTXol4GzTrPlcdTRClzmZ1oWAAH9zSW2djR35pwTK74D7gJLh
         DtqNZAoVOqSPADbWbQQzKQxm80VSatCpfzQjJxXPIfZR6a05zlrF+7G19lNwIQbU8zXk
         fTXCgQfEB89TORTTSBL8bNsFFT5EL67tM/39eYBE6eBIwBlxouD3yIfCtesA2KB0hKpY
         e07mtj/0i5coxBA6HXi6cYObIFEovvJAmXe4GPHXxZb3TKjUv2/oKiQdssqRMbrn4gZa
         GxliGbf2Z49hoRg8R5cFWmtaRtbCjXVChXL6njEr6+8zNwPG9wN57y+33o463tVJKPcP
         MTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974023; x=1780578823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FC46tl/3Y2y1w2wMHFy3XfDmrZD6eZXx1A+RmWVtw8E=;
        b=Q1TWP3BefxQ5MsTzBOPQRMSb5jvx+BqIbqYOVzsKfOxmeEXE21iXYu1gofj4Q6t+XH
         i+tobR5i/FU4HO4MJ+n3M/j2kBNzEgvgobXQh7bD09K1rb5A1Aw1OiUWANVSUktI1wrg
         WoH7zxB/QyA4nsRWburn0nPV3pVs10NDTRDR8MCgWeCUelR/xEkwKo47zoFj1OHKLuNA
         otYanbF9vKSSkoaU8ITtYkyrgXEWM2IjKscSla8nBh5moIcqP7oXg86/26gcYlnZ4lUP
         q4wr52n5BjmdTMtwTsVgw2CAVCo95aOAnVUZAIaG0IG1s95MeQnBC7Exm8Sbhp6BPUBt
         o6CQ==
X-Forwarded-Encrypted: i=1; AFNElJ9C9Xlgz9stYUwbnpG6aUifSo8MeBqXmumDsolHD3Fp9MbhbChmRK9ypLahTytomiItkwNfstf8gDA+5WYt4bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/woABo227spZDu0YJyCjzGMXDHDUIJrHfDqTfYOzAFrNpKV4
	KrYGghpLtkY4qw9JQ/H2Fu4pkd4UzIqWWiqtyKnxUPigZ3HNdzV48c818PQ7hHjJrHPy7xx2JLl
	QRsfak4/gc6J9Ne9pnSF+CsJh+pDCRsU=
X-Gm-Gg: Acq92OGWzlfQpK94GSeXT5yQo1tIhQG82bHpCspkyGrItkEtbW8jpHqxxrP/CrFKGg/
	2RtenMdckMg7QLLWRUw0aLfXP2C2WvCN2zaC9EXl9y47tO2jRieQSj68YqWQDFStKPS1uueR5+K
	OtIoVyBDZJedc26i3Nywt6XbX6SAGq05t+eBGD3VRM2My1yyqn6Zj4U22W4chAf+UP7nXpA7Q2D
	KUwnnGniRugyygStKTQmQPATqeztprRO3or0cha33B+l11ilbQEEqD1QiU4oiZW4IupmmQ8iyTb
	mItiMD8hO6vmetODDffK9X9KjFlyLMFt6E9ZbKcaIXSL52eg+r/UZ60fZRdsx/RJP+imk0U0WSa
	1EJcN
X-Received: by 2002:a53:acc5:0:10b0:65e:5daf:fe6a with SMTP id
 956f58d0204a3-65ec98eee57mr20379419d50.36.1779974022824; Thu, 28 May 2026
 06:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511172310.3723421-1-rollkingzzc@gmail.com>
In-Reply-To: <20260511172310.3723421-1-rollkingzzc@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 May 2026 09:13:31 -0400
X-Gm-Features: AVHnY4L25Amg6vUI_5zlWUcH2bdgiWWNy8Ima2a5t3Tn1pUeUGIVSwfn-H2mEzs
Message-ID: <CABBYNZLVGZ+noQEHBP52mhNK=Vfmh3OfeHon+CgPz2YcpPrOSA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: 6lowpan: Fix peer and channel lifetime
 during teardown
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>, zerocling0077@gmail.com, 
	2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2026 at 1:23=E2=80=AFPM Zhang Cen <rollkingzzc@gmail.com> w=
rote:
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

How did you test this?

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

Unrelated

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

Don't think this makes any difference, perhaps the idea is to set
peer->chan to NULL?

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

Unrelated.

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

Unrelated.

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

This sounds a lot more complicated then it should be, and it is adding
a bunch of unrelated changes on top.

>  module_init(bt_6lowpan_init);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
