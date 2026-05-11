Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09813DBD55
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519512; cv=pass; b=UfJWXw1r+BtCHGVsRaavXRenNGwCZlfkANQZF0RyM14imzbVIHO3qmVmwCfqemda9EPn7les+TaZCFTX5I9JhPIM9JmSstUEzxkMCiJkrcniszh0geRAtfhgtkU6CR8/UPB8B8/pSmb0FrIQ+y/9UB/WtO3GAOl15IW38CEQrFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519512; c=relaxed/simple;
	bh=IP3lmlL2U2F5Xrk7TrM6/nwwVs7jaFZ+ptqlb5tvOao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlLJR0ahqGs7NY1IOry5882Bjxc6pyslbta9CnsQ853LozjCpdse1OpYN34mE9gqZrHeQ9LtPwwikQXZzN5w0iNfpy9L7Yw62nBbcLI1dLy1D0LHAWlJ0UbjsI4fWM6qljeFqPm5jv3Cmzc/qr7oRqUg1mEDfhrV902TrJaGNGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLgLFv9Z; arc=pass smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLgLFv9Z"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-38be5e86918so57994511fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778519509; cv=none;
        d=google.com; s=arc-20240605;
        b=HWT2B3iYVfRKG2G71IWykQBzCAca6O+yr8wFQhv6l67RJlAZFxDqphVEFfbTl9e5Tz
         nWGGmkd2uIZQyUPinI4kvzHE3k2zzTo9+P/fmc2YZj1abJ7XZBXqIL5uxfZwXSADfYb+
         oJ38LRvq4eWqVx0et/fAq+qVYKntNK27y6vzUdAtf4n4lsR8lX+uw/LVKfrOT0vVTLQ3
         vamXuVbNRh8zVxJ0+2b5QS9V92SfBjbQcza8nBc1jpXqORg8pq0xZi/vgEZJFFzvnttx
         QKWWL4E1w9KDIEICMsb0LY5K1BTPEBiL1FcYen7hHoSn9SlxrxuC3Cv1XMR/JgrH3rUV
         cdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8popQ+I08bTlMScJN9PKvoPYs8vCY/EIL/tMaGI6ME=;
        fh=nU4YRTg28dEnnFgFbCpC/d7pZW00n/+EXCT115v9X3Y=;
        b=jGdsXCl0QQuo7TcmM9OPymKzcMAka1+NotVWwAryhexo6hpCjTquZRk54DNzUXTc1P
         8jL9UbyAhQo6YIqrFM/WQ9Pb3rF3UvCxR+hzbRTBglx0MjmK0lwo/FzgzBNR9z8f6rzb
         vVAuxE3utv1beu80WCuMjHa4gre3/4/gUAz9/0N5Mft+UrI8lTlgShXas5auv8iprXfo
         a53ppzSz7NGR1m6f2PzP0d7mrOOFv5oByVv9TOuu+myuvmca0OFikgCfcQHdOHWZkZwi
         fLSO2n4lEd1B6r8pDdE6IS7iqBdRMl0s0ZhrMJbI16bG6WY3gdE0BVKqtmpEy7JXN8ZJ
         x2nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519509; x=1779124309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8popQ+I08bTlMScJN9PKvoPYs8vCY/EIL/tMaGI6ME=;
        b=JLgLFv9ZwWaBeGIi6g+VXXZAFKM35OD0zUuwGHftaVeQCimA4yHNHHW5krMk9I/n8Q
         yqxJqnwGsNbdYMpxUHmOLcSTpszSoCckjr/RLD7MYCw31bD0ddD/MtY0Ox36xbkR6WeC
         4VQ/TnQUinLiIzchUlyOqztSLREGOvbFv0lYWKL2XsqVRc6c9uTd9C3b9cJxWbhgjC1m
         1nuHsizcO2GqCFhifWQgVu4Xs/Z6yNGefKCrcA0O4VJ01/6zYXAGDo2AHg6LGP/vl9tz
         kR+Qu12jmTugWtY/yRcQgYVSf3eW2Mxih10d1B5a9YjG+rm4XI8tqeijqsYgtEmt6x/0
         P4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519509; x=1779124309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8popQ+I08bTlMScJN9PKvoPYs8vCY/EIL/tMaGI6ME=;
        b=E1NNf4pR+P1YcNdYBQfUPM1e8HpEvC5g1yVjfu0m26drI5Hhn0mKDwaCemVg0Bnc50
         JbF/EgzRlucSXn5vTfIcjXitocVvvmOmBYPJAHx0Uh+K6FmEUiPktAWvAQRKiAF+cjgI
         jYhktZM5+q5Q38ZB+gnXLRFBfiPdlEW1FAbCDy+jnKU9lowwlTsJDm6DeCKkpmE3BsmS
         3W/RHXTDvs1yTBwfU5F9VVEEkt3+7IGobacpE8pQ03avdjWHBnFnh2wYOt37TZRAzwIj
         gHiqiETo12SbggdjMI2rP07mbO2NGuykN+qOpHnFGdjJdBxXY9QshNrb5swK2vHJ+KvR
         Gslw==
X-Forwarded-Encrypted: i=1; AFNElJ/0lupKgQwrgE9sqLQ8TEkha3Cb5L+7yUt6mZPuRQKvYLPeMV13gin9XgrCZlqY3vTEf2pHD4EiNzhfcFtizc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjhcM9Drk4NEEYBtIE/fWUWecoJ1wkeQTRhGwOvBx52i9QiWq
	0lAT8lH39Q8za7peI/4tPiEC3wkuvYIY+ehGqnt5WyelckG4yFlJ8/4J03Mw1t4BlB1Q2NbonPz
	X1Ys1odBoUM/GM0FrLEB53eDFMOPoBwSO47EPCkEj+++r
X-Gm-Gg: Acq92OHqXnaqrJPLeBRl+uZshh/Wo1lmJV80SgUVIc3D7TT4V7G65CrjJOHfIkCE/2U
	Y80WKH/+QewprcgJ8BLYSfh/ZrfdiMQinPwv/Qo91kNzHMhiEskNCnugB42n/J5p/034cnHblMd
	QSJr1AZNRJzrB3rPmwI8Gc93qYgCnroVif+UpUWqLrU7ZgEZpeGVdvBZZ7BMqWIqtBjYXbloKUb
	7vaAtmhVk9ZzjmbUQuXEzFQbUl0KKLEmhLx5bjB6TEAZyPfzCjJ1/bztqz7jh6T3gICZaWJLHkF
	gh5VlWds0k4DAge1O1w=
X-Received: by 2002:a05:651c:150e:b0:394:635:70b1 with SMTP id
 38308e7fff4ca-39406357258mr36690811fa.3.1778519508313; Mon, 11 May 2026
 10:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509173745.413473-1-rollkingzzc@gmail.com>
 <20260510040424.2054614-1-rollkingzzc@gmail.com> <CABBYNZLWzkDcZW+32-a1AdrvVzEfqs0BqGoH_jH9NBForCSHWA@mail.gmail.com>
In-Reply-To: <CABBYNZLWzkDcZW+32-a1AdrvVzEfqs0BqGoH_jH9NBForCSHWA@mail.gmail.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Tue, 12 May 2026 01:11:36 +0800
X-Gm-Features: AVHnY4KfmkcRz73Zaor35AWLNDjjzR1puU-xgzcZxCQKlab29Q2h-5IujL2mlXY
Message-ID: <CAB7XQsEJz7gYMhdM23BsGfxZQtgRpf9uQ5EfN+aMY2z-TJvBXg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: 6lowpan: Fix peer and channel lifetime
 during teardown
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>, zerocling0077@gmail.com, 
	hanguidong02@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks for pointing this out.

I'll take another look at the lifetime and context issues raised there
and rework the patch accordingly. I'll send a v3 after addressing them.

Thanks,
Zhang Cen

Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=
=8812=E6=97=A5=E5=91=A8=E4=BA=8C 00:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Sun, May 10, 2026 at 12:04=E2=80=AFAM Zhang Cen <rollkingzzc@gmail.com=
> wrote:
> >
> > 6LoWPAN peers keep a protocol-owned L2CAP channel reference in
> > peer->chan. chan_close_cb() removes the peer from the RCU list when the
> > channel is closed, but the old code also dropped that channel reference
> > before the peer object stopped being observable by in-flight RCU reader=
s.
> >
> > That can leave peer readers with a live lowpan_peer that still points a=
t
> > an l2cap_chan whose last reference has already been released. Some
> > lookup helpers also returned raw peer pointers after dropping RCU
> > protection, so keeping only the channel alive until the RCU callback
> > still leaves the peer lifetime rules implicit.
> >
> > Make the peer lifetime explicit. Give each lowpan_peer a refcount, have
> > RCU lookups take a peer reference before returning a peer outside the
> > read-side critical section, and make peer_del() only unlink the peer an=
d
> > schedule an RCU callback to drop the list owner reference after the gra=
ce
> > period. Release the peer-owned L2CAP channel reference and module
> > reference from the final peer put.
> >
> > Keep temporary channel references in transmit and disconnect paths that
> > cache or send through peer->chan after lookup.
> >
> > The buggy scenario involves two paths, with each column showing the ord=
er within that path:
> >
> > L2CAP peer teardown:                   Concurrent peer reader:
> >   1. A close path holds a                1. A reader such as
> >      temporary reference to the             lookup_peer(),
> >      channel                                peer_lookup_dst(),
> >                                             send_mcast_pkt(), or
> >                                             bt_6lowpan_disconnect()
> >                                             observes the peer
> >   2. l2cap_chan_del() drops the          2. The reader keeps using the
> >      connection-owned channel               raw peer or peer->chan afte=
r
> >      reference                              RCU lookup protection ends
> >   3. chan_close_cb() removes the         3. The reader reads channel
> >      lowpan_peer from the peer              fields, locks the channel, =
or
> >      list                                   sends through the channel
> >                                             pointer
> >   4. The old chan_close_cb()
> >      dropped the peer-owned
> >      channel reference before the
> >      peer RCU grace period ended
> >   5. The close caller releases its
> >      temporary channel reference
> >
> > If the reader reaches its channel use after teardown releases the peer-
> > owned channel reference and the close caller releases its temporary
> > reference, it can use a freed channel; raw peer returns can also outliv=
e
> > the peer RCU callback.
> >
> > lowpan_peer objects remain RCU-observable after peer_del() unlinks them=
.
> >
> > Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> >
> > ---
> > diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> > index 2f03b780b40d..7334a78f5bfb 100644
> > --- a/net/bluetooth/6lowpan.c
> > +++ b/net/bluetooth/6lowpan.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/etherdevice.h>
> >  #include <linux/module.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/refcount.h>
> >
> >  #include <net/ipv6.h>
> >  #include <net/ip6_route.h>
> > @@ -61,6 +62,7 @@ enum {
> >  struct lowpan_peer {
> >         struct list_head list;
> >         struct rcu_head rcu;
> > +       refcount_t refcnt;
> >         struct l2cap_chan *chan;
> >
> >         /* peer addresses in various formats */
> > @@ -95,13 +97,33 @@ static inline void peer_add(struct lowpan_btle_dev =
*dev,
> >         atomic_inc(&dev->peer_count);
> >  }
> >
> > +static inline bool lowpan_peer_get_unless_zero(struct lowpan_peer *pee=
r)
> > +{
> > +       return refcount_inc_not_zero(&peer->refcnt);
> > +}
> > +
> > +static void lowpan_peer_put(struct lowpan_peer *peer)
> > +{
> > +       if (!refcount_dec_and_test(&peer->refcnt))
> > +               return;
> > +
> > +       l2cap_chan_put(peer->chan);
> > +       kfree(peer);
> > +       module_put(THIS_MODULE);
> > +}
> > +
> > +static void lowpan_peer_put_rcu(struct rcu_head *rcu)
> > +{
> > +       struct lowpan_peer *peer =3D container_of(rcu, struct lowpan_pe=
er, rcu);
> > +
> > +       lowpan_peer_put(peer);
> > +}
> > +
> >  static inline bool peer_del(struct lowpan_btle_dev *dev,
> >                             struct lowpan_peer *peer)
> >  {
> >         list_del_rcu(&peer->list);
> > -       kfree_rcu(peer, rcu);
> > -
> > -       module_put(THIS_MODULE);
> > +       call_rcu(&peer->rcu, lowpan_peer_put_rcu);
> >
> >         if (atomic_dec_and_test(&dev->peer_count)) {
> >                 BT_DBG("last peer");
> > @@ -179,7 +201,8 @@ static inline struct lowpan_peer *peer_lookup_dst(s=
truct lowpan_btle_dev *dev,
> >                        &peer->chan->dst, peer->chan->dst_type,
> >                        &peer->peer_addr);
> >
> > -               if (!ipv6_addr_cmp(&peer->peer_addr, nexthop)) {
> > +               if (!ipv6_addr_cmp(&peer->peer_addr, nexthop) &&
> > +                   lowpan_peer_get_unless_zero(peer)) {
> >                         rcu_read_unlock();
> >                         return peer;
> >                 }
> > @@ -189,7 +212,8 @@ static inline struct lowpan_peer *peer_lookup_dst(s=
truct lowpan_btle_dev *dev,
> >         neigh =3D __ipv6_neigh_lookup(dev->netdev, nexthop);
> >         if (neigh) {
> >                 list_for_each_entry_rcu(peer, &dev->peers, list) {
> > -                       if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN))=
 {
> > +                       if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN) =
&&
> > +                           lowpan_peer_get_unless_zero(peer)) {
> >                                 neigh_release(neigh);
> >                                 rcu_read_unlock();
> >                                 return peer;
> > @@ -212,8 +236,9 @@ static struct lowpan_peer *lookup_peer(struct l2cap=
_conn *conn)
> >
> >         list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
> >                 peer =3D __peer_lookup_conn(entry, conn);
> > -               if (peer)
> > +               if (peer && lowpan_peer_get_unless_zero(peer))
> >                         break;
> > +               peer =3D NULL;
> >         }
> >
> >         rcu_read_unlock();
> > @@ -361,8 +386,10 @@ static int chan_recv_cb(struct l2cap_chan *chan, s=
truct sk_buff *skb)
> >                 return -ENOENT;
> >
> >         dev =3D lookup_dev(chan->conn);
> > -       if (!dev || !dev->netdev)
> > +       if (!dev || !dev->netdev) {
> > +               lowpan_peer_put(peer);
> >                 return -ENOENT;
> > +       }
> >
> >         err =3D recv_pkt(skb, dev->netdev, peer);
> >         if (err) {
> > @@ -370,6 +397,8 @@ static int chan_recv_cb(struct l2cap_chan *chan, st=
ruct sk_buff *skb)
> >                 err =3D -EAGAIN;
> >         }
> >
> > +       lowpan_peer_put(peer);
> > +
> >         return err;
> >  }
> >
> > @@ -380,6 +409,8 @@ static int setup_header(struct sk_buff *skb, struct=
 net_device *netdev,
> >         struct ipv6hdr *hdr;
> >         struct lowpan_btle_dev *dev;
> >         struct lowpan_peer *peer;
> > +       struct l2cap_chan *chan;
> > +       u8 peer_lladdr[ETH_ALEN];
> >         u8 *daddr;
> >         int err, status =3D 0;
> >
> > @@ -388,9 +419,9 @@ static int setup_header(struct sk_buff *skb, struct=
 net_device *netdev,
> >         dev =3D lowpan_btle_dev(netdev);
> >
> >         memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));
> > +       lowpan_cb(skb)->chan =3D NULL;
> >
> >         if (ipv6_addr_is_multicast(&ipv6_daddr)) {
> > -               lowpan_cb(skb)->chan =3D NULL;
> >                 daddr =3D NULL;
> >         } else {
> >                 BT_DBG("dest IP %pI6c", &ipv6_daddr);
> > @@ -406,10 +437,15 @@ static int setup_header(struct sk_buff *skb, stru=
ct net_device *netdev,
> >                         return -ENOENT;
> >                 }
> >
> > -               daddr =3D peer->lladdr;
> > -               *peer_addr =3D peer->chan->dst;
> > -               *peer_addr_type =3D peer->chan->dst_type;
> > -               lowpan_cb(skb)->chan =3D peer->chan;
> > +               chan =3D peer->chan;
> > +               l2cap_chan_hold(chan);
> > +               memcpy(peer_lladdr, peer->lladdr, ETH_ALEN);
> > +               *peer_addr =3D chan->dst;
> > +               *peer_addr_type =3D chan->dst_type;
> > +               lowpan_cb(skb)->chan =3D chan;
> > +               lowpan_peer_put(peer);
> > +
> > +               daddr =3D peer_lladdr;
> >
> >                 status =3D 1;
> >         }
> > @@ -417,8 +453,13 @@ static int setup_header(struct sk_buff *skb, struc=
t net_device *netdev,
> >         lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_add=
r);
> >
> >         err =3D dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0)=
;
> > -       if (err < 0)
> > +       if (err < 0) {
> > +               if (lowpan_cb(skb)->chan) {
> > +                       l2cap_chan_put(lowpan_cb(skb)->chan);
> > +                       lowpan_cb(skb)->chan =3D NULL;
> > +               }
> >                 return err;
> > +       }
> >
> >         return status;
> >  }
> > @@ -483,15 +524,23 @@ static int send_mcast_pkt(struct sk_buff *skb, st=
ruct net_device *netdev)
> >                 dev =3D lowpan_btle_dev(entry->netdev);
> >
> >                 list_for_each_entry_rcu(pentry, &dev->peers, list) {
> > +                       struct l2cap_chan *chan =3D pentry->chan;
> >                         int ret;
> >
> >                         local_skb =3D skb_clone(skb, GFP_ATOMIC);
> > +                       if (!local_skb) {
> > +                               err =3D -ENOMEM;
> > +                               continue;
> > +                       }
> > +
> > +                       l2cap_chan_hold(chan);
> >
> >                         BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %=
p",
> >                                netdev->name,
> > -                              &pentry->chan->dst, pentry->chan->dst_ty=
pe,
> > -                              &pentry->peer_addr, pentry->chan);
> > -                       ret =3D send_pkt(pentry->chan, local_skb, netde=
v);
> > +                              &chan->dst, chan->dst_type,
> > +                              &pentry->peer_addr, chan);
> > +                       ret =3D send_pkt(chan, local_skb, netdev);
> > +                       l2cap_chan_put(chan);
> >                         if (ret < 0)
> >                                 err =3D ret;
> >
> > @@ -530,10 +579,14 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, s=
truct net_device *netdev)
> >
> >         if (err) {
> >                 if (lowpan_cb(skb)->chan) {
> > +                       struct l2cap_chan *chan =3D lowpan_cb(skb)->cha=
n;
> > +
> >                         BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %=
p",
> >                                netdev->name, &addr, addr_type,
> > -                              &lowpan_cb(skb)->addr, lowpan_cb(skb)->c=
han);
> > -                       err =3D send_pkt(lowpan_cb(skb)->chan, skb, net=
dev);
> > +                              &lowpan_cb(skb)->addr, chan);
> > +                       err =3D send_pkt(chan, skb, netdev);
> > +                       l2cap_chan_put(chan);
> > +                       lowpan_cb(skb)->chan =3D NULL;
> >                 } else {
> >                         err =3D -ENOENT;
> >                 }
> > @@ -649,6 +702,7 @@ static struct l2cap_chan *add_peer_chan(struct l2ca=
p_chan *chan,
> >         if (!peer)
> >                 return NULL;
> >
> > +       refcount_set(&peer->refcnt, 1);
> >         peer->chan =3D chan;
> >
> >         baswap((void *)peer->lladdr, &chan->dst);
> > @@ -802,8 +856,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
> >                                last ? "last " : "1 ", peer);
> >                         BT_DBG("chan %p orig refcnt %u", chan,
> >                                kref_read(&chan->kref));
> > -
> > -                       l2cap_chan_put(chan);
> >                         break;
> >                 }
> >         }
> > @@ -918,6 +970,7 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 ds=
t_type)
> >  static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
> >  {
> >         struct lowpan_peer *peer;
> > +       struct l2cap_chan *chan;
> >
> >         BT_DBG("conn %p dst type %u", conn, dst_type);
> >
> > @@ -925,11 +978,16 @@ static int bt_6lowpan_disconnect(struct l2cap_con=
n *conn, u8 dst_type)
> >         if (!peer)
> >                 return -ENOENT;
> >
> > -       BT_DBG("peer %p chan %p", peer, peer->chan);
> > +       chan =3D peer->chan;
> > +       l2cap_chan_hold(chan);
> > +
> > +       BT_DBG("peer %p chan %p", peer, chan);
> > +       lowpan_peer_put(peer);
> >
> > -       l2cap_chan_lock(peer->chan);
> > -       l2cap_chan_close(peer->chan, ENOENT);
> > -       l2cap_chan_unlock(peer->chan);
> > +       l2cap_chan_lock(chan);
> > +       l2cap_chan_close(chan, ENOENT);
> > +       l2cap_chan_unlock(chan);
> > +       l2cap_chan_put(chan);
> >
> >         return 0;
> >  }
> > @@ -1169,6 +1227,7 @@ static ssize_t lowpan_control_write(struct file *=
fp,
> >                         peer =3D lookup_peer(conn);
> >                         if (peer) {
> >                                 BT_DBG("6LoWPAN connection already exis=
ts");
> > +                               lowpan_peer_put(peer);
> >                                 return -EALREADY;
> >                         }
>
> AI got quite a few issues with this change:
>
> https://sashiko.dev/#/patchset/20260509173745.413473-1-rollkingzzc%40gmai=
l.com
>
> --
> Luiz Augusto von Dentz
