Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFA3A4F23
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516446; cv=pass; b=JJtnU9B8Ut5VEbTehGprFujNrf8kVXIHDiYze+PzfeRUJZotSZ6OehyzQWoWtKmyQ9m2uJKdiqWp0TYxPO81s5RRPOvarmPbznacZn6X70A7YzTzZ18cLDwpQUn/0xKWVphzAyCZw336O4C1P1sTLTvW7BpRoCMfkWqb9LuOK4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516446; c=relaxed/simple;
	bh=8cfoQ1XUTCbCEEj0v/7n9j0jlqBLpdx6TPoVbxBo76I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyAm2Gw8/2zipWovU5txRCMXec1huAe3bBPjh/UeDv7GuKbdfB2D9PDz6VUdd9X5OLPtvxZyCqPJhGziqi6Lc0ABKz9RYvO0ZHVrW+NPVu4/dqxr2rzegGKofwWwfpQoQZKlHbkmu1RAJ9jxc3WwqPdzIm0kiI4lmR19WXNSUl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHliItjI; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHliItjI"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so4721984d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 09:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778516443; cv=none;
        d=google.com; s=arc-20240605;
        b=lHXC8TDE2PbrogbeSWyIe/lD5NIVbWADEPGFrYno9I0cUr0gsyMMUPFJvq+U/0pfRa
         MHio2ZwOQI7rBNORF1JXsKWnv5jC3ZvnXgyOluK+NJ5s13Abksm/SKPWFIScG/vQgr9S
         Jxt+k9gUmQG8QeL4g6CPalEpa0GWRPKJqOPZS8ICXjY12lF/uwuUccW0HWPxLoZ1J7mC
         GARgOM+9ikTKoK7BM7G3R3FuAf/rxWk49PQHZ99NOdq9OdhE3ye/58hPfwkmitmuyqbC
         sUOngP3GCQ9FH+B2DqRjUakHD/9WiH7+sZNU5VFgr5QaP6uoXQPjClOZnq8BzDJWiXGf
         9EkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uiyzSWA1z6dY/jyOJ9j8hol+ZwbGjrt+xURO0wfhjlk=;
        fh=tVljXsHqTI1nM+H51NnjB7qH54j4T9t8Td7Hb5a5prw=;
        b=UogHqXFkJrp2sIGnP1BleXexRWwC6lisNAxEZhul7My1/9IwbHGd12M4fLUtdAMEZM
         VMnBxcPN/q5b15QqazPoJWNA0jqLI0+hoiWOhWpf47mV/ToDEZXSq1f3Ci+6IOd2RxVG
         qN75fZJFGQrTtlA2JCd0mEq5KYBcAzbjaUK6LocMZ5lzFH1NhnsdZ4uv87ooDu9HTQzb
         lNUTdTjiBGbeqQAMif1MA+ow+fMZrLPdvyqFWitLyIE+qO+o4Og1DJS8EXA4cnLjNPi3
         KvndaZld5l4NS4VQUqQuWLS2QFUjMo1v8ogEjSqMuezigJls9P8JLZtr4kiibjefa8Fe
         Tu9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516443; x=1779121243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiyzSWA1z6dY/jyOJ9j8hol+ZwbGjrt+xURO0wfhjlk=;
        b=hHliItjI4NQHxNtc1zhbRzTRC55psFvg00/uL+Z41M55rlgocbC75UKDD5NXaWd+rn
         Gwpo23sA8WH8hzt1IMzVqT6EYVaqnHo+1ymWSVkhUWnsMftYItJNCn/D6Qy1wPSqIpOu
         Ucy4/W9AC6HlkDDOwodc4Mwftyvr57vAGJO1cB6sG3755Wuk4EXTdhFj8GiNVoIEnkWu
         JUtwNAgMJ5HlJz1aptkzkLF+XcJbjOPFrZ+58tnjuwbIgjdk+xK3mHGAqHf0BWNZIfPz
         7X/psTVVBlJ2c5nHGDvoPnQt/c9V530VYk/i/cp1v8mDk2hwy3K09g8zQcIZfztzN1RH
         0zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516443; x=1779121243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uiyzSWA1z6dY/jyOJ9j8hol+ZwbGjrt+xURO0wfhjlk=;
        b=eAlhGPRWVBbakbL/mr8mX8Xwcz9bigs+upv7UHWSUGntyYnpcu352rrxdJZejEkjXi
         SHZCUZdEBZmTumD8exsYj5cMWNn+8PDJ4jbpQBqvZAfIEHkjaxbsipgx0y7y/kl5dd8H
         mLuOEo1cW4BcKGupMD5nv4wUlkbRR6Ot1+Xlpw5CGX4BfQKRso8sVZk5gNoK12+7xhje
         c88xdBaIMiws4epaoFZ9Pa0BETMGv4zFSuPTZppVyLruioTjvhVgS3dxDmzsa0yk7TVg
         X5uhpc9g0DcEVu1jiC4Avlnip7kGVxok9vLZYmkbFiH2C/3zAMSeFb5Og48hSF6GbMnE
         FN2A==
X-Forwarded-Encrypted: i=1; AFNElJ94DELD4K4LUe1E8GWGMFGPpKQKNctNY3qifLoYHGqaval2CHQIxqds9qOJnc+9PMlGiAEl6f1AQjYWT2kmVSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9I7BXvyhHKQABNdVQyCAHgFFsj4VCJ79OB+pHESxu7duMGAhE
	enoh8zNSYzbKO6vnNGB/vqMASFAhVzu2FFNSj8UVjn6VgVLY8lABaY4iUokY9v4yvDsNdo3yWyo
	iOkh3E3rBde744k96M5LIblM0I98X3I4=
X-Gm-Gg: Acq92OHlJ4HI1PcPJd6WpfhfiuonjqEzG7DvUsitUQJCEimxLdAzTxEATT2sfZCWj0L
	u5U281OuhiO8bXaV9RdbndyjurK0gxU9IWhssz2P09kLRoO3roCGL7nfOuJtub42KIeJkoL14Uh
	6PtXBSuOF0r/NCqgv6gn0B3Hr+sfwRmv9Bb8KW99/G0xqIM+WXkrWqFgCDXuWPWDfmLVURXPD9H
	s6tFghfPRxs+V7yfHl3yxhiTUdY9Tbs8xDXuOhzfQj0qpOq+6iGllWS47x0GWtJA8aDMP1emEzh
	/PwHw+nvrNu2MB79bGB+HHIP1aONkjEXDjGyJFinLq5V8QCtd56qj+fl+2fyZRisCcbtUQ3Cwr4
	SL6tc
X-Received: by 2002:a53:d511:0:b0:650:3bbf:6a60 with SMTP id
 956f58d0204a3-65c7999b125mr19166369d50.37.1778516442993; Mon, 11 May 2026
 09:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509173745.413473-1-rollkingzzc@gmail.com> <20260510040424.2054614-1-rollkingzzc@gmail.com>
In-Reply-To: <20260510040424.2054614-1-rollkingzzc@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 May 2026 12:20:32 -0400
X-Gm-Features: AVHnY4KfCAFuILGDe7lS2YDNerVZdwdDJ00RDoilHPdU9Rpl9F5RQLA4olE_pOc
Message-ID: <CABBYNZLWzkDcZW+32-a1AdrvVzEfqs0BqGoH_jH9NBForCSHWA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: 6lowpan: Fix peer and channel lifetime
 during teardown
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>, zerocling0077@gmail.com, 
	hanguidong02@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 10, 2026 at 12:04=E2=80=AFAM Zhang Cen <rollkingzzc@gmail.com> =
wrote:
>
> 6LoWPAN peers keep a protocol-owned L2CAP channel reference in
> peer->chan. chan_close_cb() removes the peer from the RCU list when the
> channel is closed, but the old code also dropped that channel reference
> before the peer object stopped being observable by in-flight RCU readers.
>
> That can leave peer readers with a live lowpan_peer that still points at
> an l2cap_chan whose last reference has already been released. Some
> lookup helpers also returned raw peer pointers after dropping RCU
> protection, so keeping only the channel alive until the RCU callback
> still leaves the peer lifetime rules implicit.
>
> Make the peer lifetime explicit. Give each lowpan_peer a refcount, have
> RCU lookups take a peer reference before returning a peer outside the
> read-side critical section, and make peer_del() only unlink the peer and
> schedule an RCU callback to drop the list owner reference after the grace
> period. Release the peer-owned L2CAP channel reference and module
> reference from the final peer put.
>
> Keep temporary channel references in transmit and disconnect paths that
> cache or send through peer->chan after lookup.
>
> The buggy scenario involves two paths, with each column showing the order=
 within that path:
>
> L2CAP peer teardown:                   Concurrent peer reader:
>   1. A close path holds a                1. A reader such as
>      temporary reference to the             lookup_peer(),
>      channel                                peer_lookup_dst(),
>                                             send_mcast_pkt(), or
>                                             bt_6lowpan_disconnect()
>                                             observes the peer
>   2. l2cap_chan_del() drops the          2. The reader keeps using the
>      connection-owned channel               raw peer or peer->chan after
>      reference                              RCU lookup protection ends
>   3. chan_close_cb() removes the         3. The reader reads channel
>      lowpan_peer from the peer              fields, locks the channel, or
>      list                                   sends through the channel
>                                             pointer
>   4. The old chan_close_cb()
>      dropped the peer-owned
>      channel reference before the
>      peer RCU grace period ended
>   5. The close caller releases its
>      temporary channel reference
>
> If the reader reaches its channel use after teardown releases the peer-
> owned channel reference and the close caller releases its temporary
> reference, it can use a freed channel; raw peer returns can also outlive
> the peer RCU callback.
>
> lowpan_peer objects remain RCU-observable after peer_del() unlinks them.
>
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
>
> ---
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 2f03b780b40d..7334a78f5bfb 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -9,6 +9,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/module.h>
>  #include <linux/debugfs.h>
> +#include <linux/refcount.h>
>
>  #include <net/ipv6.h>
>  #include <net/ip6_route.h>
> @@ -61,6 +62,7 @@ enum {
>  struct lowpan_peer {
>         struct list_head list;
>         struct rcu_head rcu;
> +       refcount_t refcnt;
>         struct l2cap_chan *chan;
>
>         /* peer addresses in various formats */
> @@ -95,13 +97,33 @@ static inline void peer_add(struct lowpan_btle_dev *d=
ev,
>         atomic_inc(&dev->peer_count);
>  }
>
> +static inline bool lowpan_peer_get_unless_zero(struct lowpan_peer *peer)
> +{
> +       return refcount_inc_not_zero(&peer->refcnt);
> +}
> +
> +static void lowpan_peer_put(struct lowpan_peer *peer)
> +{
> +       if (!refcount_dec_and_test(&peer->refcnt))
> +               return;
> +
> +       l2cap_chan_put(peer->chan);
> +       kfree(peer);
> +       module_put(THIS_MODULE);
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
> @@ -179,7 +201,8 @@ static inline struct lowpan_peer *peer_lookup_dst(str=
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
> @@ -189,7 +212,8 @@ static inline struct lowpan_peer *peer_lookup_dst(str=
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
> @@ -212,8 +236,9 @@ static struct lowpan_peer *lookup_peer(struct l2cap_c=
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
> @@ -361,8 +386,10 @@ static int chan_recv_cb(struct l2cap_chan *chan, str=
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
> @@ -370,6 +397,8 @@ static int chan_recv_cb(struct l2cap_chan *chan, stru=
ct sk_buff *skb)
>                 err =3D -EAGAIN;
>         }
>
> +       lowpan_peer_put(peer);
> +
>         return err;
>  }
>
> @@ -380,6 +409,8 @@ static int setup_header(struct sk_buff *skb, struct n=
et_device *netdev,
>         struct ipv6hdr *hdr;
>         struct lowpan_btle_dev *dev;
>         struct lowpan_peer *peer;
> +       struct l2cap_chan *chan;
> +       u8 peer_lladdr[ETH_ALEN];
>         u8 *daddr;
>         int err, status =3D 0;
>
> @@ -388,9 +419,9 @@ static int setup_header(struct sk_buff *skb, struct n=
et_device *netdev,
>         dev =3D lowpan_btle_dev(netdev);
>
>         memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));
> +       lowpan_cb(skb)->chan =3D NULL;
>
>         if (ipv6_addr_is_multicast(&ipv6_daddr)) {
> -               lowpan_cb(skb)->chan =3D NULL;
>                 daddr =3D NULL;
>         } else {
>                 BT_DBG("dest IP %pI6c", &ipv6_daddr);
> @@ -406,10 +437,15 @@ static int setup_header(struct sk_buff *skb, struct=
 net_device *netdev,
>                         return -ENOENT;
>                 }
>
> -               daddr =3D peer->lladdr;
> -               *peer_addr =3D peer->chan->dst;
> -               *peer_addr_type =3D peer->chan->dst_type;
> -               lowpan_cb(skb)->chan =3D peer->chan;
> +               chan =3D peer->chan;
> +               l2cap_chan_hold(chan);
> +               memcpy(peer_lladdr, peer->lladdr, ETH_ALEN);
> +               *peer_addr =3D chan->dst;
> +               *peer_addr_type =3D chan->dst_type;
> +               lowpan_cb(skb)->chan =3D chan;
> +               lowpan_peer_put(peer);
> +
> +               daddr =3D peer_lladdr;
>
>                 status =3D 1;
>         }
> @@ -417,8 +453,13 @@ static int setup_header(struct sk_buff *skb, struct =
net_device *netdev,
>         lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_addr)=
;
>
>         err =3D dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0);
> -       if (err < 0)
> +       if (err < 0) {
> +               if (lowpan_cb(skb)->chan) {
> +                       l2cap_chan_put(lowpan_cb(skb)->chan);
> +                       lowpan_cb(skb)->chan =3D NULL;
> +               }
>                 return err;
> +       }
>
>         return status;
>  }
> @@ -483,15 +524,23 @@ static int send_mcast_pkt(struct sk_buff *skb, stru=
ct net_device *netdev)
>                 dev =3D lowpan_btle_dev(entry->netdev);
>
>                 list_for_each_entry_rcu(pentry, &dev->peers, list) {
> +                       struct l2cap_chan *chan =3D pentry->chan;
>                         int ret;
>
>                         local_skb =3D skb_clone(skb, GFP_ATOMIC);
> +                       if (!local_skb) {
> +                               err =3D -ENOMEM;
> +                               continue;
> +                       }
> +
> +                       l2cap_chan_hold(chan);
>
>                         BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p"=
,
>                                netdev->name,
> -                              &pentry->chan->dst, pentry->chan->dst_type=
,
> -                              &pentry->peer_addr, pentry->chan);
> -                       ret =3D send_pkt(pentry->chan, local_skb, netdev)=
;
> +                              &chan->dst, chan->dst_type,
> +                              &pentry->peer_addr, chan);
> +                       ret =3D send_pkt(chan, local_skb, netdev);
> +                       l2cap_chan_put(chan);
>                         if (ret < 0)
>                                 err =3D ret;
>
> @@ -530,10 +579,14 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, str=
uct net_device *netdev)
>
>         if (err) {
>                 if (lowpan_cb(skb)->chan) {
> +                       struct l2cap_chan *chan =3D lowpan_cb(skb)->chan;
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
> +                       l2cap_chan_put(chan);
> +                       lowpan_cb(skb)->chan =3D NULL;
>                 } else {
>                         err =3D -ENOENT;
>                 }
> @@ -649,6 +702,7 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_=
chan *chan,
>         if (!peer)
>                 return NULL;
>
> +       refcount_set(&peer->refcnt, 1);
>         peer->chan =3D chan;
>
>         baswap((void *)peer->lladdr, &chan->dst);
> @@ -802,8 +856,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
>                                last ? "last " : "1 ", peer);
>                         BT_DBG("chan %p orig refcnt %u", chan,
>                                kref_read(&chan->kref));
> -
> -                       l2cap_chan_put(chan);
>                         break;
>                 }
>         }
> @@ -918,6 +970,7 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_=
type)
>  static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
>  {
>         struct lowpan_peer *peer;
> +       struct l2cap_chan *chan;
>
>         BT_DBG("conn %p dst type %u", conn, dst_type);
>
> @@ -925,11 +978,16 @@ static int bt_6lowpan_disconnect(struct l2cap_conn =
*conn, u8 dst_type)
>         if (!peer)
>                 return -ENOENT;
>
> -       BT_DBG("peer %p chan %p", peer, peer->chan);
> +       chan =3D peer->chan;
> +       l2cap_chan_hold(chan);
> +
> +       BT_DBG("peer %p chan %p", peer, chan);
> +       lowpan_peer_put(peer);
>
> -       l2cap_chan_lock(peer->chan);
> -       l2cap_chan_close(peer->chan, ENOENT);
> -       l2cap_chan_unlock(peer->chan);
> +       l2cap_chan_lock(chan);
> +       l2cap_chan_close(chan, ENOENT);
> +       l2cap_chan_unlock(chan);
> +       l2cap_chan_put(chan);
>
>         return 0;
>  }
> @@ -1169,6 +1227,7 @@ static ssize_t lowpan_control_write(struct file *fp=
,
>                         peer =3D lookup_peer(conn);
>                         if (peer) {
>                                 BT_DBG("6LoWPAN connection already exists=
");
> +                               lowpan_peer_put(peer);
>                                 return -EALREADY;
>                         }

AI got quite a few issues with this change:

https://sashiko.dev/#/patchset/20260509173745.413473-1-rollkingzzc%40gmail.=
com

--=20
Luiz Augusto von Dentz
