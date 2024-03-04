Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BA7CF1F
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595533; cv=pass; b=dA8BmsbfNu5KsokiwvGEd1QsYqCrlPjPH28d6aozW3L9TEaus0CIodEuQfPsFyJkKuDkIsfbXQHhnv/5jsF57meBAjRTP48oNxljmANYFEPONBJjCf+n5cG1I0tir5GQ1T/s6JZHdEgJoypgsAS0mcp1ylW6bfEmDVD1d7I95IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595533; c=relaxed/simple;
	bh=ZdbuWgjHCOOBDl4Dpy6VZtg6Ee5RobDF2N4RiMIV6G0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=areHCacUW9SDgNtheDfG0AuA2bpBclpW1Wx9Jt0hR7j/jyCBnwbtIrAzSACd/Ufki5IXHephPLHikj2egpequgWddXf58gbbNVC16luwHHxHc7OruLJt/9mnLxAY0VxFLjEFymX2bZ6ie/slvmC6H8oNaDemojqsrt+61IFBJvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=etzV17Xj; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="etzV17Xj"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TpZrw63N4z49Q3m;
	Tue,  5 Mar 2024 01:38:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1709595521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KIU1qheet3KRAMcnQ9/tueDI/7XJFBbMCb9IjzWYwjw=;
	b=etzV17XjOkaiu6MOH4ZmDsV0DK+ESpty2UKGUpnodOJyOyjqgRMKiy8+ebU6d4kpC26BWm
	e4cIobOiHXl07pJL2G8HykDM2hLHDwwQU+ykvYVSiNRkwsxB3e2jWdwlHv0k/xzhizh/U2
	drMtXZf7fc4kRca/phx8o7BECSre9QVoLFK0VeAFarbvyWr9K8VzYJ8CmCpm5hTLlcelIe
	RMP6sm8liRDOxaDG4CW7RJm9aoBUzYEKMpXRLUKzw8/42QlQJ++1nwladn9BdFLzdpkhPM
	usPHQCKkpqWpwwgLIVWIPZM4k3d0TvOdsYLPeHzGD+ZyimzUiVMFJXRroMPb2w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1709595521; a=rsa-sha256;
	cv=none;
	b=G1eXK5flYzkvOC29hYrloYF5zYV4xJnBm1VYvwV2XKuGpyDtjwiRxVmpmuL0vy4m3+/17u
	1T/bSDdzSra7BM+DGi8NvMDZVX2D/mYWaV2XJycZDuvJ+g2ryu67kFr9YjblFy3ECWBF5j
	xRgvrr/YcEWVAfOmdVDLxCG/ety4j9R+ptxo8iwyyqmx5KH5RApp14l8MWxa71yRfqmLBD
	mT986O6t94E2WB5+zn1zGKwH6kGYcHhjIe3OHLtYqNjq+Sdk7HoTRWxlmiMpjKW6dOQKfJ
	jMgL9Wk/EwM1IfUWICUq8tCXMIUa02K1g5hp9CNn93FK7Q04H0vyPhWXECxpSw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1709595521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KIU1qheet3KRAMcnQ9/tueDI/7XJFBbMCb9IjzWYwjw=;
	b=KpQ+2QrBxSyLeq3ZRAHVFwM42jmc7KQ2NFlMqkAUlr6v0Ya3cwNzmdWr2riodT7KT1THri
	a/kZW8PLdJLr/MOlUgVMLIfrT8korG0x8tRCm24ttt4mebOBILj0ycZU9xpC2aDuhL55Kq
	eYdfmuycyPMKGncJ3JRqBi5k4VnLiN8aAZI1vqnd4Qy7nKatjTPMMvoKS+GR5avl/9KFth
	JJ3F7NANv6hFk4sUAIcPOfAmKLana4HZpF+jktVXMvL0ZRAk6YxxsGAaiX+lRAuG1HyclV
	Xkr/zZH60kuu31SjtTqOIxom23Jx32rRoc6tXTYQiO52Ryxcq7kxGEMmuyIJeQ==
Message-ID: <ae98f147da92f4b35dc683e47558e97434c5f36a.camel@iki.fi>
Subject: Re: [PATCH 1/3] Bluetooth: add support for skb TX timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 05 Mar 2024 01:38:37 +0200
In-Reply-To: <CABBYNZJXpL1ALKmqq2uwGHM1mm6LvPPUAOYEoJiJuz4U_nfMbQ@mail.gmail.com>
References: <cover.1709409547.git.pav@iki.fi>
	 <d19187ab9842df2565d1d82beb171a8967d2ea94.1709409547.git.pav@iki.fi>
	 <CABBYNZJXpL1ALKmqq2uwGHM1mm6LvPPUAOYEoJiJuz4U_nfMbQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2024-03-04 kello 09:36 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sat, Mar 2, 2024 at 3:08=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > Support enabling TX timestamping for some skbs, and track them until
> > packet completion.  Generate SCM_TSTAMP_SCHED when sending to driver,
> > and SCM_TSTAMP_SND at packet completion.
> >=20
> > Make the default situation with no TX timestamping more efficient by
> > only counting packets in the queue when there is nothing to track.  Whe=
n
> > there is something to track, we need to make clones, since the driver
> > may modify sent skbs.
>=20
> Great work, really nice to see how this is shaping up.
>=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  include/net/bluetooth/hci_core.h | 12 +++++
> >  net/bluetooth/hci_conn.c         | 78 ++++++++++++++++++++++++++++++++
> >  net/bluetooth/hci_core.c         |  5 ++
> >  net/bluetooth/hci_event.c        |  4 ++
> >  4 files changed, 99 insertions(+)
> >=20
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 56fb42df44a3..51b556612a6b 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -267,6 +267,12 @@ struct adv_info {
> >         struct delayed_work     rpa_expired_cb;
> >  };
> >=20
> > +struct tx_comp_queue {
> > +       struct sk_buff_head queue;
> > +       unsigned int extra;
> > +       unsigned int tracked;
> > +};
> > +
> >  #define HCI_MAX_ADV_INSTANCES          5
> >  #define HCI_DEFAULT_ADV_DURATION       2
> >=20
> > @@ -763,6 +769,8 @@ struct hci_conn {
> >         struct sk_buff_head data_q;
> >         struct list_head chan_list;
> >=20
> > +       struct tx_comp_queue tx_comp_queue;
>=20
> I'd go with tx_q just to be short.

Ack.

>=20
> > +
> >         struct delayed_work disc_work;
> >         struct delayed_work auto_accept_work;
> >         struct delayed_work idle_work;
> > @@ -1546,6 +1554,10 @@ void hci_conn_enter_active_mode(struct hci_conn =
*conn, __u8 force_active);
> >  void hci_conn_failed(struct hci_conn *conn, u8 status);
> >  u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
> >=20
> > +void hci_conn_tx_comp_queue(struct hci_conn *conn, struct sk_buff *skb=
);
> > +void hci_conn_tx_comp_dequeue(struct hci_conn *conn);
>=20
> I'd drop the comp term here, so just hci_conn_tx_queue and
> hci_conn_tx_dequeue since we want to do it no matter if the skb was
> marked to be tracked or not.

Ack.

>=20
> > +void hci_tx_timestamp(struct sk_buff *skb, const struct sockcm_cookie =
*sockc);
> > +
> >  /*
> >   * hci_conn_get() and hci_conn_put() are used to control the life-time=
 of an
> >   * "hci_conn" object. They do not guarantee that the hci_conn object i=
s running,
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 3ad74f76983b..f44d4b8fa0c6 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -27,6 +27,7 @@
> >=20
> >  #include <linux/export.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/errqueue.h>
> >=20
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <net/bluetooth/hci_core.h>
> > @@ -973,6 +974,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev,=
 int type, bdaddr_t *dst,
> >         }
> >=20
> >         skb_queue_head_init(&conn->data_q);
> > +       skb_queue_head_init(&conn->tx_comp_queue.queue);
> >=20
> >         INIT_LIST_HEAD(&conn->chan_list);
> >         INIT_LIST_HEAD(&conn->link_list);
> > @@ -1117,6 +1119,7 @@ void hci_conn_del(struct hci_conn *conn)
> >         }
> >=20
> >         skb_queue_purge(&conn->data_q);
> > +       skb_queue_purge(&conn->tx_comp_queue.queue);
> >=20
> >         /* Remove the connection from the list and cleanup its remainin=
g
> >          * state. This is a separate function since for some cases like
> > @@ -2928,3 +2931,78 @@ int hci_abort_conn(struct hci_conn *conn, u8 rea=
son)
> >=20
> >         return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NUL=
L);
> >  }
> > +
> > +void hci_tx_timestamp(struct sk_buff *skb, const struct sockcm_cookie =
*sockc)
> > +{
> > +       /* This shall be called on a single skb of those generated by u=
ser
> > +        * sendmsg(), and only when the sendmsg() does not return error=
 to
> > +        * user. This is required for keeping the tskey that increments=
 here in
> > +        * sync with possible sendmsg() counting by user.
> > +        */
> > +
> > +       if (!skb || !sockc)
> > +               return;
> > +
> > +       skb_setup_tx_timestamp(skb, sockc->tsflags);
> > +}
> > +
> > +void hci_conn_tx_comp_queue(struct hci_conn *conn, struct sk_buff *skb=
)
> > +{
> > +       struct tx_comp_queue *comp =3D &conn->tx_comp_queue;
> > +       bool track =3D false;
> > +
> > +       if (skb->sk) {
> > +               if (skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP)
> > +                       __skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> > +                                       SCM_TSTAMP_SCHED);
> > +
> > +               if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > +                       track =3D true;
> > +       }
> > +
> > +       /* If nothing is tracked, just count extra skbs at the queue he=
ad */
> > +       if (!track && !comp->tracked) {
> > +               comp->extra++;
> > +               return;
> > +       }
> > +
> > +       if (track) {
> > +               skb =3D skb_clone_sk(skb);
> > +               if (!skb)
> > +                       return;
> > +
> > +               comp->tracked++;
> > +       } else {
> > +               skb =3D skb_clone(skb, GFP_KERNEL);
> > +               if (!skb)
> > +                       return;
> > +       }
>=20
> Do we really need clones here? Can we just have references or that
> doesn't work because the skb could be put in another queue by the
> driver which would screw our own queuing?

Some drivers like in btmtkuart_send_frame are putting sent skbs to
queues and modifying the contents, so at least different queue
structure from skb_queue_* would be needed.

I'm guessing the assumption in drivers generally is they now own the
skb and can do what they want with them, so clones sound safer here if
there are no rules we can assume.

>=20
> > +       skb_queue_tail(&comp->queue, skb);
> > +}
> > +
> > +void hci_conn_tx_comp_dequeue(struct hci_conn *conn)
> > +{
> > +       struct tx_comp_queue *comp =3D &conn->tx_comp_queue;
> > +       struct sk_buff *skb;
> > +
> > +       /* If there are tracked skbs, the counted extra go before deque=
uing real
> > +        * skbs, to keep ordering. When nothing is tracked, the orderin=
g doesn't
> > +        * matter so dequeue real skbs first to get rid of them ASAP.
> > +        */
> > +       if (comp->extra && (comp->tracked || skb_queue_empty(&comp->que=
ue))) {
> > +               comp->extra--;
> > +               return;
> > +       }
> > +
> > +       skb =3D skb_dequeue(&comp->queue);
> > +       if (!skb)
> > +               return;
> > +
> > +       if (skb->sk) {
> > +               comp->tracked--;
> > +               skb_tstamp_tx(skb, NULL);
> > +       }
> > +
> > +       kfree_skb(skb);
> > +}
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index df3aa41e376d..f4af6e99d798 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3715,6 +3715,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hde=
v)
> >                         hci_conn_enter_active_mode(chan->conn,
> >                                                    bt_cb(skb)->force_ac=
tive);
> >=20
> > +                       hci_conn_tx_comp_queue(chan->conn, skb);
> > +
> >                         hci_send_frame(hdev, skb);
> >                         hdev->acl_last_tx =3D jiffies;
> >=20
> > @@ -3876,6 +3878,9 @@ static void hci_sched_iso(struct hci_dev *hdev)
> >         while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote)))=
 {
> >                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q)))=
 {
> >                         BT_DBG("skb %p len %d", skb, skb->len);
> > +
> > +                       hci_conn_tx_comp_queue(conn, skb);
> > +
> >                         hci_send_frame(hdev, skb);
> >=20
> >                         conn->sent++;
>=20
> I'd assume we should be doing the same for SCO_LINK, or that was
> intentionally left out? Perhaps it would be better to have something
> like hci_conn_send_frame as a helper function that does take care of
> updating whatever needs to be updated before calling hci_send_frame.

It looks like kernel is not currently enabling Synchronous Flow Control
(cf.=C2=A0Core 5.4 Vol 4, Part E page 1817), so there are no NoCP events fo=
r
SCO packets appearing, so the tx queue can't work.

Indeed, there's no flow control in hci_core.c:hci_sched_sco/esco,
sco_cnt is not decremented.

We could still send SCHED timestamps, but they probably wouldn't be
very useful for user if no queue can form in the socket.

Trying to enable TX timestamping if hdev doesn't support required flow
control mode maybe should fail with EOPNOTSUPP or something similar, so
user then knows no SND timestamps are going to be issued.

> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index bffd2c7ff608..f56211d8ff7a 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4438,6 +4438,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev =
*hdev, void *data,
> >                 struct hci_comp_pkts_info *info =3D &ev->handles[i];
> >                 struct hci_conn *conn;
> >                 __u16  handle, count;
> > +               unsigned int i;
> >=20
> >                 handle =3D __le16_to_cpu(info->handle);
> >                 count  =3D __le16_to_cpu(info->count);
> > @@ -4448,6 +4449,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev =
*hdev, void *data,
> >=20
> >                 conn->sent -=3D count;
> >=20
> > +               for (i =3D 0; i < count; ++i)
> > +                       hci_conn_tx_comp_dequeue(conn);
> > +
> >                 switch (conn->type) {
> >                 case ACL_LINK:
> >                         hdev->acl_cnt +=3D count;
> > --
> > 2.44.0
>=20
> Btw, one thing that might be great to have is the timestamp
> information also forward to the monitor with use of SCM, btmon already
> does track the NOCP event and print the amount of time it took but
> that is probably no as precise as doing this in kernel, besides it
> doesn't

It's not clear to me how the SND tstamp should be signaled in the
monitor socket. For errqueue, similarly the other net TX tstamping, it
is sending one packet for each timestamp if there are multiple, along
with original data unless TSONLY was set, but not sure that's fine for
the monitor.

--=20
Pauli Virtanen
