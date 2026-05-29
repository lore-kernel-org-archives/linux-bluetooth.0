Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192672472AF
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072406; cv=none; b=mIwh5VowAk0dvYbmEuhnlj/TNUZBmC27azGdaKa/JryXIH1GAv4s9dpTFhU3gqkbxZNC0Br+V+5toTiY6zxbtRQlfZKDjodz3PDUPP8/iGn09zo+VadDoYMIlkn5ZlEojjd8V1vcd8caO35cJC0WiIytbJwKK+IY/nO5BbmNvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072406; c=relaxed/simple;
	bh=HybzvyJFMJL0iONLuNuEVpoBX7ahDqm37A0Mj/gZvTY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CmtMD9GpkWdqFhLido89og5QbTX3dTTMreirzP7xf5AvzfAmMXTDCvuoz2VzWxqNeyCjTNOqbbzxs8kz/+YfKLquQedbKfPpuJbhlwCrgeUkIG1Ejwyd1vkusnZX8qH00eJH5zy+cIUQK7HI2QyQq8JfwVN9ZsAlYxBVTWaSVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=bXbHG1dI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j5eLCZ6g; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="bXbHG1dI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j5eLCZ6g"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D6EC1D0008D;
	Fri, 29 May 2026 12:33:23 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-03.internal (MEProxy); Fri, 29 May 2026 12:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780072402;
	 x=1780158802; bh=VntnbI0OlWaztt0jQsNrW3M0bGWyQrszKlmYk1tMf28=; b=
	bXbHG1dINuPqazY6K83RSUS38OgAVs7uRhkl9rwD/X3sBtaQRPOgaGrB7VCcEtN6
	7S+huUWpQlZbIW9KBrnEtGCgejRKgFN/O0CKo7HxFv8/XKS55qUtqD6V/ckC3POp
	gVpQGg62oh8I/LJrGcqCBQfo4F9H+8TLc7H9EFl/u2WbR9Yn0ucExbu8g0JkTogR
	OoXn2qD+nobRBaHsvqKEpgKpNIYt3DsxA9V0ljRay+OyGng1Febh4QFL057BHt8f
	Drh1GGQXelCigEwIbFIfPNRdwqBUCEF2AwCUebn4k5gEnTdCi4C9inDSUoYbAAtq
	+5g4LkNQ4pBQz6dSCfW8WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780072402; x=
	1780158802; bh=VntnbI0OlWaztt0jQsNrW3M0bGWyQrszKlmYk1tMf28=; b=j
	5eLCZ6gCSrEGC4iP5yTLEzrfI7EnEdy2KQjJYRB9hIkLx+Cz15K23AnNw/qTKJ1r
	kkw08LHpIl60vyyzlJghjZ56dUyriVhFkWY0IbvhMmJWFB3lKYUaTMQD/Z12GefV
	MmTTac8+h9aqwu1vNR8MjIz0JMRurWyqpR+eAEOvj8TeylwNgN8o6Xt8vRF5c8ad
	uVNmSo1YDL//g0ECpGW2TARX/DnRtW5rM/m7kxdu6JKxbvssXmQQNAANdbML6oeD
	RYyydAI5CSqgy/Xyky0vVZ+ThW7F11hbGB6KX0fNrZVYrYHj6kY1Iv4VRBB3eOug
	ou31KpC8grHhnb+CqQbLg==
X-ME-Sender: <xms:0r8ZamyADLlAnFI_Wg2WqSL0PE7P6BlB_sjPqPakzjHCrxZ--bXLdw>
    <xme:0r8ZatGJ0uzSHmQjt8gY00DsDsbdrsn1vMq7BKleIpqpoMge-DSB40xnaXeSLDWkJ
    ThWBE3vxtL3s0tnqLiFW_PS1r4hd7mPL6_VIL_cfISThsMDCxpDLAc>
X-ME-Proxy-Cause: dmFkZTG39NBdQ9KSz921Ltxk5rRyNEZ14Eq0dwRUuOauaAIck/ZZ9p/btdOiTgvbIszCZt
    cfeUuvP2K37T4/x+1jvnS0WpFRvx0vDzqjYJ9f/kwaK7SFvKjAuyeB6opL0BrjUFcbrPp8
    YlTdYTCtfvCEVuoxgV/PPO/okXCvdpy6MDsBGJ8fRKnkdAuOHO1hxmgaNjgMrvuXsIyPZw
    akoj55m89VAFJ1ltxvuWM0F5H2mw4eWTrpPmCxC30Qw99k4i6ncPP+9hJRbbpItRH1I4DK
    WQuUOYCkKj/6g0gqZuuIC2zaVaOkNxICkmiKGD/5sCPJapbASvpg6wC0mZf7J2TnfyxMFF
    XV9rcaEwOJaO4RZFMTOcv6xyW7aYp50WN+L8qeJUALRaTLpnFkXHYYcxcaVMFGJo2qs1l7
    9HcIDpOYVcrv/EH3UdnLM1rdz5fX9azl3Vm7nvwtYM6n2KTAQzflxdxvb1TEVYpXsYnPqw
    nKLhG4gjCbrQHJe5BZ36p36EJRqk+FK1ne76h3yYYRNl/yo17rzSDgmww9NVfjioR3mkkd
    YNwPrRlob8goqGxU1IzSBOyWD/j7YqRKRU061CT9xWkRdy4cBjvDzsJ86ivHlQQz2GVAy1
    pOHYyzGWX+m3VvaU6S8Vw24+QoyenDCf3lJwZpiv/42RaWPTKicWr31Ox5TA
X-ME-Proxy: <xmx:0r8ZamMlIRDE7KynvQe6-odwadyvg8dsufziaTZH6UNNSiBBvXO7Cw>
    <xmx:0r8Zastgwt_ZTN_KC8fw1MxgNfUVYtp1iPROeOVdUd6l1YulhlDurg>
    <xmx:0r8ZagUUP5gqBJ2RJZQ4K3fe75LuHV5fLM07GQB00dL1tuRybo7GsA>
    <xmx:0r8ZakuFBVT9V0N9ROvggi8a9MdVTTx66vz-rawfQJNY4fKMsl8zjw>
    <xmx:0r8ZahA_ARF2QXbP_ud_Bbip-whBfe3P-4LNiKOL5PvIHbeZk60ius6F>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8EA2D3020073; Fri, 29 May 2026 12:33:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvY6Iv3jnud7
Date: Fri, 29 May 2026 12:33:04 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Message-Id: <460b3909-2210-4cf3-be9e-4f8af3175160@app.fastmail.com>
In-Reply-To: <c45459c5-e7d9-4ea2-bd61-903a33f8778f@app.fastmail.com>
References: <20260520162030.2842543-1-oss@fourdim.xyz>
 <20260520162030.2842543-2-oss@fourdim.xyz>
 <CABBYNZL_ymHCE+uf6kJ2Mi=R4pEwy-wcSL3HKDP0krd7D73Kqw@mail.gmail.com>
 <c45459c5-e7d9-4ea2-bd61-903a33f8778f@app.fastmail.com>
Subject: Re: [PATCH v5 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, May 27, 2026, at 12:16 AM, Siwei Zhang wrote:
> Hi Luiz,
>
> On Tue, May 26, 2026, at 4:46 PM, Luiz Augusto von Dentz wrote:
>> Hi Siwei,
>>
>> On Wed, May 20, 2026 at 12:20=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz=
> wrote:
>>>
>>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
>>> release_sock(parent). Once the parent lock is released, the child
>>> socket sk can be freed by another task.
>>>
>>> Allocate the channel outside the func to prevent this.
>>>
>>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2c=
ap_core.c")
>>> Cc: stable@kernel.org
>>> Assisted-by: Claude:claude-opus-4-6
>>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>>> ---
>>>  include/net/bluetooth/l2cap.h |  8 +++--
>>>  net/bluetooth/6lowpan.c       | 14 ++++-----
>>>  net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++----=
---
>>>  net/bluetooth/l2cap_sock.c    | 48 +++++++++++++++++------------
>>>  net/bluetooth/smp.c           | 13 +++-----
>>>  5 files changed, 91 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l=
2cap.h
>>> index 5172afee5494..f7a11e6431f0 100644
>>> --- a/include/net/bluetooth/l2cap.h
>>> +++ b/include/net/bluetooth/l2cap.h
>>> @@ -619,7 +619,8 @@ struct l2cap_chan {
>>>  struct l2cap_ops {
>>>         char                    *name;
>>>
>>> -       struct l2cap_chan       *(*new_connection) (struct l2cap_cha=
n *chan);
>>> +       int                     (*new_connection)(struct l2cap_chan =
*chan,
>>> +                                                 struct l2cap_chan =
*new_chan);
>>>         int                     (*recv) (struct l2cap_chan * chan,
>>>                                          struct sk_buff *skb);
>>>         void                    (*teardown) (struct l2cap_chan *chan=
, int err);
>>> @@ -883,9 +884,10 @@ static inline __u16 __next_seq(struct l2cap_cha=
n *chan, __u16 seq)
>>>         return (seq + 1) % (chan->tx_win_max + 1);
>>>  }
>>>
>>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struc=
t l2cap_chan *chan)
>>> +static inline int l2cap_chan_no_new_connection(struct l2cap_chan *c=
han,
>>> +                                              struct l2cap_chan *ne=
w_chan)
>>>  {
>>> -       return NULL;
>>> +       return -EOPNOTSUPP;
>>>  }
>>>
>>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struc=
t sk_buff *skb)
>>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>>> index 23a229ab6a33..286c0b45055b 100644
>>> --- a/net/bluetooth/6lowpan.c
>>> +++ b/net/bluetooth/6lowpan.c
>>> @@ -743,19 +743,19 @@ static inline void chan_ready_cb(struct l2cap_=
chan *chan)
>>>         ifup(dev->netdev);
>>>  }
>>>
>>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan=
 *pchan)
>>> +static inline int chan_new_conn_cb(struct l2cap_chan *pchan,
>>> +                                  struct l2cap_chan *chan)
>>>  {
>>> -       struct l2cap_chan *chan;
>>> -
>>> -       chan =3D chan_create();
>>> -       if (!chan)
>>> -               return NULL;
>>> +       l2cap_chan_set_defaults(chan);
>>>
>>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>>> +       chan->imtu =3D 1280;
>>
>> The 3 lines above make no sense.
>>
>
> chan_create code in 6lowpan.c
>
> static struct l2cap_chan *chan_create(void)
> {
> 	struct l2cap_chan *chan;
>
> 	chan =3D l2cap_chan_create();
> 	if (!chan)
> 		return NULL;
>
> 	l2cap_chan_set_defaults(chan);
>
> 	chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> 	chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> 	chan->imtu =3D 1280;
>
> 	return chan;
> }
>
> Since we allocate chan outside and replace the chan_create here,
> I do think these are needed and they are specific to 6lowpan only.
>
> I can refactor it in this patch or in a follow-up patch. I would prefe=
r it
> to be in a follow-up patch.
>

What do you think. Please let me know if you want me to change anything.

>>>         chan->ops =3D pchan->ops;
>>>
>>>         BT_DBG("chan %p pchan %p", chan, pchan);
>>>
>>> -       return chan;
>>> +       return 0;
>>>  }
>>>
>>>  static void unregister_dev(struct lowpan_btle_dev *dev)
>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>> index fdccd62ccca8..505f32034971 100644
>>> --- a/net/bluetooth/l2cap_core.c
>>> +++ b/net/bluetooth/l2cap_core.c
>>> @@ -4051,10 +4051,16 @@ static void l2cap_connect(struct l2cap_conn =
*conn, struct l2cap_cmd_hdr *cmd,
>>>                 goto response;
>>>         }
>>>
>>> -       chan =3D pchan->ops->new_connection(pchan);
>>> +       chan =3D l2cap_chan_create();
>>>         if (!chan)
>>>                 goto response;
>>>
>>> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
>>> +               l2cap_chan_put(chan);
>>> +               chan =3D NULL;
>>> +               goto response;
>>> +       }
>>> +
>>>         /* For certain devices (ex: HID mouse), support for authenti=
cation,
>>>          * pairing and bonding is optional. For such devices, inorde=
r to avoid
>>>          * the ACL alive for too long after L2CAP disconnection, res=
et the ACL
>>> @@ -4132,6 +4138,10 @@ static void l2cap_connect(struct l2cap_conn *=
conn, struct l2cap_cmd_hdr *cmd,
>>>                 chan->num_conf_req++;
>>>         }
>>>
>>> +       /* Drop our local ref; __l2cap_chan_add() pinned chan via th=
e conn list. */
>>> +       if (chan)
>>> +               l2cap_chan_put(chan);
>>> +
>>>         l2cap_chan_unlock(pchan);
>>>         l2cap_chan_put(pchan);
>>>  }
>>> @@ -4881,6 +4891,7 @@ static int l2cap_le_connect_req(struct l2cap_c=
onn *conn,
>>>         struct l2cap_le_conn_rsp rsp;
>>>         struct l2cap_chan *chan, *pchan;
>>>         u16 dcid, scid, credits, mtu, mps;
>>> +       u16 rsp_mtu, rsp_mps;
>>>         __le16 psm;
>>>         u8 result;
>>>
>>> @@ -4893,6 +4904,8 @@ static int l2cap_le_connect_req(struct l2cap_c=
onn *conn,
>>>         psm  =3D req->psm;
>>>         dcid =3D 0;
>>>         credits =3D 0;
>>> +       rsp_mtu =3D 0;
>>> +       rsp_mps =3D 0;
>>>
>>>         if (mtu < 23 || mps < 23)
>>>                 return -EPROTO;
>>> @@ -4953,12 +4966,19 @@ static int l2cap_le_connect_req(struct l2cap=
_conn *conn,
>>>                 goto response_unlock;
>>>         }
>>>
>>> -       chan =3D pchan->ops->new_connection(pchan);
>>> +       chan =3D l2cap_chan_create();
>>>         if (!chan) {
>>>                 result =3D L2CAP_CR_LE_NO_MEM;
>>>                 goto response_unlock;
>>>         }
>>>
>>> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
>>> +               l2cap_chan_put(chan);
>>> +               chan =3D NULL;
>>> +               result =3D L2CAP_CR_LE_NO_MEM;
>>> +               goto response_unlock;
>>> +       }
>>> +
>>>         bacpy(&chan->src, &conn->hcon->src);
>>>         bacpy(&chan->dst, &conn->hcon->dst);
>>>         chan->src_type =3D bdaddr_src_type(conn->hcon);
>>> @@ -4974,6 +4994,8 @@ static int l2cap_le_connect_req(struct l2cap_c=
onn *conn,
>>>
>>>         dcid =3D chan->scid;
>>>         credits =3D chan->rx_credits;
>>> +       rsp_mtu =3D chan->imtu;
>>> +       rsp_mps =3D chan->mps;
>>>
>>>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>>>
>>> @@ -4993,6 +5015,9 @@ static int l2cap_le_connect_req(struct l2cap_c=
onn *conn,
>>>                 result =3D L2CAP_CR_LE_SUCCESS;
>>>         }
>>>
>>> +       /* Drop our local ref; __l2cap_chan_add() pinned chan via th=
e conn list. */
>>> +       l2cap_chan_put(chan);
>>> +
>>>  response_unlock:
>>>         l2cap_chan_unlock(pchan);
>>>         l2cap_chan_put(pchan);
>>> @@ -5001,13 +5026,8 @@ static int l2cap_le_connect_req(struct l2cap_=
conn *conn,
>>>                 return 0;
>>>
>>>  response:
>>> -       if (chan) {
>>> -               rsp.mtu =3D cpu_to_le16(chan->imtu);
>>> -               rsp.mps =3D cpu_to_le16(chan->mps);
>>> -       } else {
>>> -               rsp.mtu =3D 0;
>>> -               rsp.mps =3D 0;
>>> -       }
>>> +       rsp.mtu =3D cpu_to_le16(rsp_mtu);
>>> +       rsp.mps =3D cpu_to_le16(rsp_mps);
>>>
>>>         rsp.dcid    =3D cpu_to_le16(dcid);
>>>         rsp.credits =3D cpu_to_le16(credits);
>>> @@ -5177,12 +5197,18 @@ static inline int l2cap_ecred_conn_req(struc=
t l2cap_conn *conn,
>>>                         continue;
>>>                 }
>>>
>>> -               chan =3D pchan->ops->new_connection(pchan);
>>> +               chan =3D l2cap_chan_create();
>>>                 if (!chan) {
>>>                         result =3D L2CAP_CR_LE_NO_MEM;
>>>                         continue;
>>>                 }
>>>
>>> +               if (pchan->ops->new_connection(pchan, chan) < 0) {
>>> +                       l2cap_chan_put(chan);
>>> +                       result =3D L2CAP_CR_LE_NO_MEM;
>>> +                       continue;
>>> +               }
>>> +
>>>                 bacpy(&chan->src, &conn->hcon->src);
>>>                 bacpy(&chan->dst, &conn->hcon->dst);
>>>                 chan->src_type =3D bdaddr_src_type(conn->hcon);
>>> @@ -5217,6 +5243,9 @@ static inline int l2cap_ecred_conn_req(struct =
l2cap_conn *conn,
>>>                 } else {
>>>                         l2cap_chan_ready(chan);
>>>                 }
>>> +
>>> +               /* Drop our local ref; __l2cap_chan_add() pinned cha=
n via the conn list. */
>>> +               l2cap_chan_put(chan);
>>>         }
>>>
>>>  unlock:
>>> @@ -7399,7 +7428,11 @@ static void l2cap_connect_cfm(struct hci_conn=
 *hcon, u8 status)
>>>                         goto next;
>>>
>>>                 l2cap_chan_lock(pchan);
>>> -               chan =3D pchan->ops->new_connection(pchan);
>>> +               chan =3D l2cap_chan_create();
>>> +               if (chan && pchan->ops->new_connection(pchan, chan) =
< 0) {
>>> +                       l2cap_chan_put(chan);
>>> +                       chan =3D NULL;
>>> +               }
>>>                 if (chan) {
>>>                         bacpy(&chan->src, &hcon->src);
>>>                         bacpy(&chan->dst, &hcon->dst);
>>> @@ -7407,6 +7440,9 @@ static void l2cap_connect_cfm(struct hci_conn =
*hcon, u8 status)
>>>                         chan->dst_type =3D dst_type;
>>>
>>>                         __l2cap_chan_add(conn, chan);
>>> +
>>> +                       /* Drop our local ref; __l2cap_chan_add() pi=
nned chan via the conn list. */
>>> +                       l2cap_chan_put(chan);
>>>                 }
>>>
>>>                 l2cap_chan_unlock(pchan);
>>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>>> index dede550d6031..598f24c8f704 100644
>>> --- a/net/bluetooth/l2cap_sock.c
>>> +++ b/net/bluetooth/l2cap_sock.c
>>> @@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list =3D {
>>>  static const struct proto_ops l2cap_sock_ops;
>>>  static void l2cap_sock_init(struct sock *sk, struct sock *parent);
>>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket=
 *sock,
>>> -                                    int proto, gfp_t prio, int kern=
);
>>> +                                    int proto, gfp_t prio, int kern,
>>> +                                    struct l2cap_chan *chan);
>>>  static void l2cap_sock_cleanup_listen(struct sock *parent);
>>>
>>>  bool l2cap_is_socket(struct socket *sock)
>>> @@ -1507,12 +1508,13 @@ static void l2cap_sock_cleanup_listen(struct=
 sock *parent)
>>>         }
>>>  }
>>>
>>> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap=
_chan *chan)
>>> +static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
>>> +                                       struct l2cap_chan *new_chan)
>>>  {
>>>         struct sock *sk, *parent =3D chan->data;
>>>
>>>         if (!parent)
>>> -               return NULL;
>>> +               return -EINVAL;
>>>
>>>         lock_sock(parent);
>>>
>>> @@ -1520,15 +1522,15 @@ static struct l2cap_chan *l2cap_sock_new_con=
nection_cb(struct l2cap_chan *chan)
>>>         if (sk_acceptq_is_full(parent)) {
>>>                 BT_DBG("backlog full %d", parent->sk_ack_backlog);
>>>                 release_sock(parent);
>>> -               return NULL;
>>> +               return -ENOBUFS;
>>>         }
>>>
>>>         sk =3D l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CA=
P,
>>> -                             GFP_ATOMIC, 0);
>>> +                             GFP_ATOMIC, 0, new_chan);
>>>         if (!sk) {
>>>                 release_sock(parent);
>>> -               return NULL;
>>> -        }
>>> +               return -ENOMEM;
>>> +       }
>>>
>>>         bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
>>>
>>> @@ -1538,7 +1540,7 @@ static struct l2cap_chan *l2cap_sock_new_conne=
ction_cb(struct l2cap_chan *chan)
>>>
>>>         release_sock(parent);
>>>
>>> -       return l2cap_pi(sk)->chan;
>>> +       return 0;
>>>  }
>>>
>>>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_bu=
ff *skb)
>>> @@ -1939,10 +1941,10 @@ static struct proto l2cap_proto =3D {
>>>  };
>>>
>>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket=
 *sock,
>>> -                                    int proto, gfp_t prio, int kern)
>>> +                                    int proto, gfp_t prio, int kern,
>>> +                                    struct l2cap_chan *chan)
>>>  {
>>>         struct sock *sk;
>>> -       struct l2cap_chan *chan;
>>>
>>>         sk =3D bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, k=
ern);
>>>         if (!sk)
>>> @@ -1953,14 +1955,11 @@ static struct sock *l2cap_sock_alloc(struct =
net *net, struct socket *sock,
>>>
>>>         INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
>>>
>>> -       chan =3D l2cap_chan_create();
>>> -       if (!chan) {
>>> -               sk_free(sk);
>>> -               if (sock)
>>> -                       sock->sk =3D NULL;
>>> -               return NULL;
>>> -       }
>>> -
>>> +       /* The sock owns two refs on chan, matching the puts in
>>> +        * l2cap_sock_kill() and l2cap_sock_destruct(). The caller k=
eeps
>>> +        * its own ref independent of these.
>>> +        */
>>> +       l2cap_chan_hold(chan);
>>>         l2cap_chan_hold(chan);
>>>
>>>         l2cap_pi(sk)->chan =3D chan;
>>> @@ -1972,6 +1971,7 @@ static int l2cap_sock_create(struct net *net, =
struct socket *sock, int protocol,
>>>                              int kern)
>>>  {
>>>         struct sock *sk;
>>> +       struct l2cap_chan *chan;
>>>
>>>         BT_DBG("sock %p", sock);
>>>
>>> @@ -1986,10 +1986,18 @@ static int l2cap_sock_create(struct net *net=
, struct socket *sock, int protocol,
>>>
>>>         sock->ops =3D &l2cap_sock_ops;
>>>
>>> -       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, ker=
n);
>>> -       if (!sk)
>>> +       chan =3D l2cap_chan_create();
>>> +       if (!chan)
>>>                 return -ENOMEM;
>>>
>>> +       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, ker=
n, chan);
>>> +       if (!sk) {
>>> +               l2cap_chan_put(chan);
>>> +               return -ENOMEM;
>>> +       }
>>> +       /* Sock has taken its own refs on chan; drop the chan_create=
() ref. */
>>> +       l2cap_chan_put(chan);
>>> +
>>>         l2cap_sock_init(sk, NULL);
>>>         bt_sock_link(&l2cap_sk_list, sk);
>>>         return 0;
>>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>>> index 1739c1989dbd..25cb5dc580bf 100644
>>> --- a/net/bluetooth/smp.c
>>> +++ b/net/bluetooth/smp.c
>>> @@ -3204,16 +3204,11 @@ static const struct l2cap_ops smp_chan_ops =3D=
 {
>>>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
>>>  };
>>>
>>> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan =
*pchan)
>>> +static inline int smp_new_conn_cb(struct l2cap_chan *pchan,
>>> +                                 struct l2cap_chan *chan)
>>>  {
>>> -       struct l2cap_chan *chan;
>>> -
>>>         BT_DBG("pchan %p", pchan);
>>>
>>> -       chan =3D l2cap_chan_create();
>>> -       if (!chan)
>>> -               return NULL;
>>> -
>>>         chan->chan_type =3D pchan->chan_type;
>>>         chan->ops       =3D &smp_chan_ops;
>>>         chan->scid      =3D pchan->scid;
>>> @@ -3229,9 +3224,9 @@ static inline struct l2cap_chan *smp_new_conn_=
cb(struct l2cap_chan *pchan)
>>>          */
>>>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
>>>
>>> -       BT_DBG("created chan %p", chan);
>>> +       BT_DBG("initialised chan %p", chan);
>>>
>>> -       return chan;
>>> +       return 0;
>>>  }
>>>
>>>  static const struct l2cap_ops smp_root_chan_ops =3D {
>>> --
>>> 2.54.0
>>>
>>
>>
>> --=20
>> Luiz Augusto von Dentz
>
> Best,
> Siwei

Best,
Siwei
