Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96E229B38
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779855423; cv=none; b=C9ZTkUkaLubObHYVyoc5Zv8dRfS8gq8b9ru8WUy/tDOSl/4GInaStpg7lbjIbWl1njXdRkQOeXQTtdVLLLPZcgqf29y7G6jb/BICOaExyge/zPWN/fK0CYAi7AhBH7NFQ/F7gKNI5FBEqmDbn096tG19vojXrSOMZMZrOVQdEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779855423; c=relaxed/simple;
	bh=CmT7gsxdszAiCc8c5OPVCCWr/Pz8YJnJUDsXbbBah3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QdVbdjRKlsqLfQf15ptK+d9TLn/yC7w3T8GduyScYZ9plOd3otQ5gAYc1phLFk3pThmTUunG8ui8odCWLyFC4XJZ5uRDq1en9sWeCDYsjYhgO6tqHWJTa855xQMGyn6y8WAZK1oLBdnF8Ys2Q/QrEyeD4wUsw0WlJeeIqadZ/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=bB8gYnNq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hi+T8KqT; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="bB8gYnNq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hi+T8KqT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D06EAEC021B;
	Wed, 27 May 2026 00:16:59 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 27 May 2026 00:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779855419;
	 x=1779941819; bh=yyHzww5crvbw+FNJh+Ue4fedMuaTOBPH6lRiNMNiKEw=; b=
	bB8gYnNqZ/bBiTg8yOEu69wtzuuR0AN+NKqjoulOvB6jv+r9n0zKWZCZK9kusjCJ
	WkbgU1dtOl37ADFP7BVukLmMDei5491MmyYExpXpJLiCw5egBqRv5XNz4k1WSEFq
	X94b3r9fPHUkYiyhzGB8lyitS+QiSEXmZ4gLgcQmIW9WesHOebEEy7GEC7nfxbt7
	9a/BZ1pHKgKdXvXPi6TnH6dfIKj2ug/ig2Jzig0p/f+5W3ZgPd8iuGCZxzg9CFXL
	4iWwqCPP5vNzuO9HCXxMdX0ib5UtkEyigHqNj1oJsiCRV4/xr4SRb3xTikLKI8Pa
	QdzlfS3ocK6DFqZuMdwZ9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779855419; x=
	1779941819; bh=yyHzww5crvbw+FNJh+Ue4fedMuaTOBPH6lRiNMNiKEw=; b=h
	i+T8KqT/rBDJQOX+M/Gsj2OjbiyywP3HfmjjxkeCwLUyyJN9ZbpfMKgmoT2oZg1l
	KUQJ0u6wRdCjKGbjfZ+TLwEJ58G9n2rkA51vaptc+Z9Dne+3G5rlnp69vdM6fajC
	j8WYSKnJfd1FUz2PMGQDm6o72oFMAolSYOX6b0Dq61jLYgroZAVShAhXRykBXg8D
	dnR8+IlAG+LXRHo4aunwBIEagx8OiuQs1WQx6VrzLGFFIV04v36O3qqx1xYuEiIJ
	GhjRzTfdxoiMWtcFNJ8FHBGMVxW+sedKBPo2IThCq7kFa3JH5Vug3LHdLeWj4IWc
	+gLL0mPLqp25aiYVl/nqw==
X-ME-Sender: <xms:O3AWati6JvuILEc-q9veAGK549ivMuU9T-qHRbUp6qB8GnDmOph56A>
    <xme:O3AWas1xCiYKZu3JmO_ux7rfTFai0qnm6RnRQ3-AarR6GO2Q_W_u4LjbKbuq07CfV
    xOx_zA3fPJFNMsXI1_hHbYgoTVlAvjmZpEE-H9nyDKy9O_Z7gyfkgU>
X-ME-Proxy-Cause: dmFkZTEV6RJMcg1OaySd0hjnpQ2TU/a5kXaCs350KxoxqbpYIW9Ws9No2BKXg6NyGS3+BJ
    fdI9kcNzywqeyJpxikkKA//lfv3weIEFHgq9+ZL57bhgIFPV6FBm33ia4q7uh7VDkEFg2F
    ZexfnqhN7QD7rHaSZjgzhnFuRH//NSyCQ9preGM/zB9O9HosDsZOUtPWGpm5ZEieabKQ9G
    1lGfl3Mb7D20omRwKa3Lp1tNnajTO9XVr+NE/7jQLBhQFE0+9O3OTBKntVv6TD7/imzdCw
    8Fe3jHMM08fRchbx4rYVnOdlG6cvPt19BhKEUTawauomflXdH4xcp0qe4mnJwK9vEW/nYu
    fwI5FHWN0bwaQ8gDfFlvDo1SFBoM7R0/vGEpszUg0LVAvkL+alZYG/WeSoInLbAMvHtoto
    67Z/U7xZ5UU56qPZvtaFBQeA3o8oU0ZIcOECkVO02K3zCbU3P8zvi347Ieuwww10yKBkP1
    efIT6ivZFCtQFey3QPY071QILnsuUdHhAJup9+bdihTbqmlZCE+SUz3nQltC1FuhONBX5D
    knRN57zwc8K/kpY65ht7+PZzchU9jVmI8BCo59EP5hE7bkri7Rp25w38t7PDruAGjzU6CX
    11FlMjh5zUdccB//t4k9J2Gs7xfF1h+4df05vZHRHobew2PI+DrsvFJELpbg
X-ME-Proxy: <xmx:O3AWam9HXPdBfeM2UzEpSTFlcDwUArHO8AL5moCTs9tC98z1b-g2iw>
    <xmx:O3AWauenlj-oWW6tVb-j8K6QyP1kelCDc4QQ5_bn81tBi2a8CJefcg>
    <xmx:O3AWavGCVPOSoRoEJQKYAYQbRLJd_AG_hsqc4VcG7WAQeemheJbZJw>
    <xmx:O3AWasfHXUejWJdcQc_LgUgHBvyXT1YIqTEmIOxdAvPbAvQ4kgfLLQ>
    <xmx:O3AWapyC0nh9Jm9b62ZcKaXeanksL24yuYrW6jNwfL3yih36UxfFAYOO>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 940DE216008A; Wed, 27 May 2026 00:16:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvY6Iv3jnud7
Date: Wed, 27 May 2026 00:16:39 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Message-Id: <c45459c5-e7d9-4ea2-bd61-903a33f8778f@app.fastmail.com>
In-Reply-To: 
 <CABBYNZL_ymHCE+uf6kJ2Mi=R4pEwy-wcSL3HKDP0krd7D73Kqw@mail.gmail.com>
References: <20260520162030.2842543-1-oss@fourdim.xyz>
 <20260520162030.2842543-2-oss@fourdim.xyz>
 <CABBYNZL_ymHCE+uf6kJ2Mi=R4pEwy-wcSL3HKDP0krd7D73Kqw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Tue, May 26, 2026, at 4:46 PM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, May 20, 2026 at 12:20=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
>>
>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
>> release_sock(parent). Once the parent lock is released, the child
>> socket sk can be freed by another task.
>>
>> Allocate the channel outside the func to prevent this.
>>
>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2ca=
p_core.c")
>> Cc: stable@kernel.org
>> Assisted-by: Claude:claude-opus-4-6
>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> ---
>>  include/net/bluetooth/l2cap.h |  8 +++--
>>  net/bluetooth/6lowpan.c       | 14 ++++-----
>>  net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++-----=
--
>>  net/bluetooth/l2cap_sock.c    | 48 +++++++++++++++++------------
>>  net/bluetooth/smp.c           | 13 +++-----
>>  5 files changed, 91 insertions(+), 50 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2=
cap.h
>> index 5172afee5494..f7a11e6431f0 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -619,7 +619,8 @@ struct l2cap_chan {
>>  struct l2cap_ops {
>>         char                    *name;
>>
>> -       struct l2cap_chan       *(*new_connection) (struct l2cap_chan=
 *chan);
>> +       int                     (*new_connection)(struct l2cap_chan *=
chan,
>> +                                                 struct l2cap_chan *=
new_chan);
>>         int                     (*recv) (struct l2cap_chan * chan,
>>                                          struct sk_buff *skb);
>>         void                    (*teardown) (struct l2cap_chan *chan,=
 int err);
>> @@ -883,9 +884,10 @@ static inline __u16 __next_seq(struct l2cap_chan=
 *chan, __u16 seq)
>>         return (seq + 1) % (chan->tx_win_max + 1);
>>  }
>>
>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct=
 l2cap_chan *chan)
>> +static inline int l2cap_chan_no_new_connection(struct l2cap_chan *ch=
an,
>> +                                              struct l2cap_chan *new=
_chan)
>>  {
>> -       return NULL;
>> +       return -EOPNOTSUPP;
>>  }
>>
>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct=
 sk_buff *skb)
>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> index 23a229ab6a33..286c0b45055b 100644
>> --- a/net/bluetooth/6lowpan.c
>> +++ b/net/bluetooth/6lowpan.c
>> @@ -743,19 +743,19 @@ static inline void chan_ready_cb(struct l2cap_c=
han *chan)
>>         ifup(dev->netdev);
>>  }
>>
>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan =
*pchan)
>> +static inline int chan_new_conn_cb(struct l2cap_chan *pchan,
>> +                                  struct l2cap_chan *chan)
>>  {
>> -       struct l2cap_chan *chan;
>> -
>> -       chan =3D chan_create();
>> -       if (!chan)
>> -               return NULL;
>> +       l2cap_chan_set_defaults(chan);
>>
>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> +       chan->imtu =3D 1280;
>
> The 3 lines above make no sense.
>

chan_create code in 6lowpan.c

static struct l2cap_chan *chan_create(void)
{
	struct l2cap_chan *chan;

	chan =3D l2cap_chan_create();
	if (!chan)
		return NULL;

	l2cap_chan_set_defaults(chan);

	chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
	chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
	chan->imtu =3D 1280;

	return chan;
}

Since we allocate chan outside and replace the chan_create here,
I do think these are needed and they are specific to 6lowpan only.

I can refactor it in this patch or in a follow-up patch. I would prefer =
it
to be in a follow-up patch.

>>         chan->ops =3D pchan->ops;
>>
>>         BT_DBG("chan %p pchan %p", chan, pchan);
>>
>> -       return chan;
>> +       return 0;
>>  }
>>
>>  static void unregister_dev(struct lowpan_btle_dev *dev)
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index fdccd62ccca8..505f32034971 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -4051,10 +4051,16 @@ static void l2cap_connect(struct l2cap_conn *=
conn, struct l2cap_cmd_hdr *cmd,
>>                 goto response;
>>         }
>>
>> -       chan =3D pchan->ops->new_connection(pchan);
>> +       chan =3D l2cap_chan_create();
>>         if (!chan)
>>                 goto response;
>>
>> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
>> +               l2cap_chan_put(chan);
>> +               chan =3D NULL;
>> +               goto response;
>> +       }
>> +
>>         /* For certain devices (ex: HID mouse), support for authentic=
ation,
>>          * pairing and bonding is optional. For such devices, inorder=
 to avoid
>>          * the ACL alive for too long after L2CAP disconnection, rese=
t the ACL
>> @@ -4132,6 +4138,10 @@ static void l2cap_connect(struct l2cap_conn *c=
onn, struct l2cap_cmd_hdr *cmd,
>>                 chan->num_conf_req++;
>>         }
>>
>> +       /* Drop our local ref; __l2cap_chan_add() pinned chan via the=
 conn list. */
>> +       if (chan)
>> +               l2cap_chan_put(chan);
>> +
>>         l2cap_chan_unlock(pchan);
>>         l2cap_chan_put(pchan);
>>  }
>> @@ -4881,6 +4891,7 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
>>         struct l2cap_le_conn_rsp rsp;
>>         struct l2cap_chan *chan, *pchan;
>>         u16 dcid, scid, credits, mtu, mps;
>> +       u16 rsp_mtu, rsp_mps;
>>         __le16 psm;
>>         u8 result;
>>
>> @@ -4893,6 +4904,8 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
>>         psm  =3D req->psm;
>>         dcid =3D 0;
>>         credits =3D 0;
>> +       rsp_mtu =3D 0;
>> +       rsp_mps =3D 0;
>>
>>         if (mtu < 23 || mps < 23)
>>                 return -EPROTO;
>> @@ -4953,12 +4966,19 @@ static int l2cap_le_connect_req(struct l2cap_=
conn *conn,
>>                 goto response_unlock;
>>         }
>>
>> -       chan =3D pchan->ops->new_connection(pchan);
>> +       chan =3D l2cap_chan_create();
>>         if (!chan) {
>>                 result =3D L2CAP_CR_LE_NO_MEM;
>>                 goto response_unlock;
>>         }
>>
>> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
>> +               l2cap_chan_put(chan);
>> +               chan =3D NULL;
>> +               result =3D L2CAP_CR_LE_NO_MEM;
>> +               goto response_unlock;
>> +       }
>> +
>>         bacpy(&chan->src, &conn->hcon->src);
>>         bacpy(&chan->dst, &conn->hcon->dst);
>>         chan->src_type =3D bdaddr_src_type(conn->hcon);
>> @@ -4974,6 +4994,8 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
>>
>>         dcid =3D chan->scid;
>>         credits =3D chan->rx_credits;
>> +       rsp_mtu =3D chan->imtu;
>> +       rsp_mps =3D chan->mps;
>>
>>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>>
>> @@ -4993,6 +5015,9 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
>>                 result =3D L2CAP_CR_LE_SUCCESS;
>>         }
>>
>> +       /* Drop our local ref; __l2cap_chan_add() pinned chan via the=
 conn list. */
>> +       l2cap_chan_put(chan);
>> +
>>  response_unlock:
>>         l2cap_chan_unlock(pchan);
>>         l2cap_chan_put(pchan);
>> @@ -5001,13 +5026,8 @@ static int l2cap_le_connect_req(struct l2cap_c=
onn *conn,
>>                 return 0;
>>
>>  response:
>> -       if (chan) {
>> -               rsp.mtu =3D cpu_to_le16(chan->imtu);
>> -               rsp.mps =3D cpu_to_le16(chan->mps);
>> -       } else {
>> -               rsp.mtu =3D 0;
>> -               rsp.mps =3D 0;
>> -       }
>> +       rsp.mtu =3D cpu_to_le16(rsp_mtu);
>> +       rsp.mps =3D cpu_to_le16(rsp_mps);
>>
>>         rsp.dcid    =3D cpu_to_le16(dcid);
>>         rsp.credits =3D cpu_to_le16(credits);
>> @@ -5177,12 +5197,18 @@ static inline int l2cap_ecred_conn_req(struct=
 l2cap_conn *conn,
>>                         continue;
>>                 }
>>
>> -               chan =3D pchan->ops->new_connection(pchan);
>> +               chan =3D l2cap_chan_create();
>>                 if (!chan) {
>>                         result =3D L2CAP_CR_LE_NO_MEM;
>>                         continue;
>>                 }
>>
>> +               if (pchan->ops->new_connection(pchan, chan) < 0) {
>> +                       l2cap_chan_put(chan);
>> +                       result =3D L2CAP_CR_LE_NO_MEM;
>> +                       continue;
>> +               }
>> +
>>                 bacpy(&chan->src, &conn->hcon->src);
>>                 bacpy(&chan->dst, &conn->hcon->dst);
>>                 chan->src_type =3D bdaddr_src_type(conn->hcon);
>> @@ -5217,6 +5243,9 @@ static inline int l2cap_ecred_conn_req(struct l=
2cap_conn *conn,
>>                 } else {
>>                         l2cap_chan_ready(chan);
>>                 }
>> +
>> +               /* Drop our local ref; __l2cap_chan_add() pinned chan=
 via the conn list. */
>> +               l2cap_chan_put(chan);
>>         }
>>
>>  unlock:
>> @@ -7399,7 +7428,11 @@ static void l2cap_connect_cfm(struct hci_conn =
*hcon, u8 status)
>>                         goto next;
>>
>>                 l2cap_chan_lock(pchan);
>> -               chan =3D pchan->ops->new_connection(pchan);
>> +               chan =3D l2cap_chan_create();
>> +               if (chan && pchan->ops->new_connection(pchan, chan) <=
 0) {
>> +                       l2cap_chan_put(chan);
>> +                       chan =3D NULL;
>> +               }
>>                 if (chan) {
>>                         bacpy(&chan->src, &hcon->src);
>>                         bacpy(&chan->dst, &hcon->dst);
>> @@ -7407,6 +7440,9 @@ static void l2cap_connect_cfm(struct hci_conn *=
hcon, u8 status)
>>                         chan->dst_type =3D dst_type;
>>
>>                         __l2cap_chan_add(conn, chan);
>> +
>> +                       /* Drop our local ref; __l2cap_chan_add() pin=
ned chan via the conn list. */
>> +                       l2cap_chan_put(chan);
>>                 }
>>
>>                 l2cap_chan_unlock(pchan);
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index dede550d6031..598f24c8f704 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list =3D {
>>  static const struct proto_ops l2cap_sock_ops;
>>  static void l2cap_sock_init(struct sock *sk, struct sock *parent);
>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket =
*sock,
>> -                                    int proto, gfp_t prio, int kern);
>> +                                    int proto, gfp_t prio, int kern,
>> +                                    struct l2cap_chan *chan);
>>  static void l2cap_sock_cleanup_listen(struct sock *parent);
>>
>>  bool l2cap_is_socket(struct socket *sock)
>> @@ -1507,12 +1508,13 @@ static void l2cap_sock_cleanup_listen(struct =
sock *parent)
>>         }
>>  }
>>
>> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_=
chan *chan)
>> +static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
>> +                                       struct l2cap_chan *new_chan)
>>  {
>>         struct sock *sk, *parent =3D chan->data;
>>
>>         if (!parent)
>> -               return NULL;
>> +               return -EINVAL;
>>
>>         lock_sock(parent);
>>
>> @@ -1520,15 +1522,15 @@ static struct l2cap_chan *l2cap_sock_new_conn=
ection_cb(struct l2cap_chan *chan)
>>         if (sk_acceptq_is_full(parent)) {
>>                 BT_DBG("backlog full %d", parent->sk_ack_backlog);
>>                 release_sock(parent);
>> -               return NULL;
>> +               return -ENOBUFS;
>>         }
>>
>>         sk =3D l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
>> -                             GFP_ATOMIC, 0);
>> +                             GFP_ATOMIC, 0, new_chan);
>>         if (!sk) {
>>                 release_sock(parent);
>> -               return NULL;
>> -        }
>> +               return -ENOMEM;
>> +       }
>>
>>         bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
>>
>> @@ -1538,7 +1540,7 @@ static struct l2cap_chan *l2cap_sock_new_connec=
tion_cb(struct l2cap_chan *chan)
>>
>>         release_sock(parent);
>>
>> -       return l2cap_pi(sk)->chan;
>> +       return 0;
>>  }
>>
>>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buf=
f *skb)
>> @@ -1939,10 +1941,10 @@ static struct proto l2cap_proto =3D {
>>  };
>>
>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket =
*sock,
>> -                                    int proto, gfp_t prio, int kern)
>> +                                    int proto, gfp_t prio, int kern,
>> +                                    struct l2cap_chan *chan)
>>  {
>>         struct sock *sk;
>> -       struct l2cap_chan *chan;
>>
>>         sk =3D bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, ke=
rn);
>>         if (!sk)
>> @@ -1953,14 +1955,11 @@ static struct sock *l2cap_sock_alloc(struct n=
et *net, struct socket *sock,
>>
>>         INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
>>
>> -       chan =3D l2cap_chan_create();
>> -       if (!chan) {
>> -               sk_free(sk);
>> -               if (sock)
>> -                       sock->sk =3D NULL;
>> -               return NULL;
>> -       }
>> -
>> +       /* The sock owns two refs on chan, matching the puts in
>> +        * l2cap_sock_kill() and l2cap_sock_destruct(). The caller ke=
eps
>> +        * its own ref independent of these.
>> +        */
>> +       l2cap_chan_hold(chan);
>>         l2cap_chan_hold(chan);
>>
>>         l2cap_pi(sk)->chan =3D chan;
>> @@ -1972,6 +1971,7 @@ static int l2cap_sock_create(struct net *net, s=
truct socket *sock, int protocol,
>>                              int kern)
>>  {
>>         struct sock *sk;
>> +       struct l2cap_chan *chan;
>>
>>         BT_DBG("sock %p", sock);
>>
>> @@ -1986,10 +1986,18 @@ static int l2cap_sock_create(struct net *net,=
 struct socket *sock, int protocol,
>>
>>         sock->ops =3D &l2cap_sock_ops;
>>
>> -       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern=
);
>> -       if (!sk)
>> +       chan =3D l2cap_chan_create();
>> +       if (!chan)
>>                 return -ENOMEM;
>>
>> +       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern=
, chan);
>> +       if (!sk) {
>> +               l2cap_chan_put(chan);
>> +               return -ENOMEM;
>> +       }
>> +       /* Sock has taken its own refs on chan; drop the chan_create(=
) ref. */
>> +       l2cap_chan_put(chan);
>> +
>>         l2cap_sock_init(sk, NULL);
>>         bt_sock_link(&l2cap_sk_list, sk);
>>         return 0;
>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>> index 1739c1989dbd..25cb5dc580bf 100644
>> --- a/net/bluetooth/smp.c
>> +++ b/net/bluetooth/smp.c
>> @@ -3204,16 +3204,11 @@ static const struct l2cap_ops smp_chan_ops =3D=
 {
>>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
>>  };
>>
>> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *=
pchan)
>> +static inline int smp_new_conn_cb(struct l2cap_chan *pchan,
>> +                                 struct l2cap_chan *chan)
>>  {
>> -       struct l2cap_chan *chan;
>> -
>>         BT_DBG("pchan %p", pchan);
>>
>> -       chan =3D l2cap_chan_create();
>> -       if (!chan)
>> -               return NULL;
>> -
>>         chan->chan_type =3D pchan->chan_type;
>>         chan->ops       =3D &smp_chan_ops;
>>         chan->scid      =3D pchan->scid;
>> @@ -3229,9 +3224,9 @@ static inline struct l2cap_chan *smp_new_conn_c=
b(struct l2cap_chan *pchan)
>>          */
>>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
>>
>> -       BT_DBG("created chan %p", chan);
>> +       BT_DBG("initialised chan %p", chan);
>>
>> -       return chan;
>> +       return 0;
>>  }
>>
>>  static const struct l2cap_ops smp_root_chan_ops =3D {
>> --
>> 2.54.0
>>
>
>
> --=20
> Luiz Augusto von Dentz

Best,
Siwei
