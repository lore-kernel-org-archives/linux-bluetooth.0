Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B217BAED
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502416; cv=none; b=MDr3fZgtsv+FQCaXO5AwB8AX5F/UGnIANkdnq/yzWQtKOyXncASNakatgjT2aOFbxCvlmLhy4PIV9uKLrD1jNwEGXLm/GPfsBJ3WS+57gUmTCFElUgRkLGltd858wLEy00TjjbrO8JCrQjDuJ8gfGMrgvEAoI71L8dRRgh955E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502416; c=relaxed/simple;
	bh=D9WafjZKCIR0SejNTDXcAHYI/AgodnQv+v0yx6qJQrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cm8ehizdRjtxZUdfLexognxquEGVoUKUEFDV8fb4Z4ExmG4qoJ1rVcMDvwD1Nv9gPHZkDg98ho7zyN1kfrZKR3lq/UfAiNw4pQdzfEuAi0CHE1feARiOn5F1oirDszv8SCVVy9Rxp1EuhFJ3n+TxbjOAwCa326TuJdWI314784o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=185.67.36.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6EF4B240103
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 19:12:06 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TWhl90cQpz9rxG;
	Fri,  9 Feb 2024 19:12:04 +0100 (CET)
Message-ID: <c8635777d2df511174c43ad47d81e1cbc660a405.camel@iki.fi>
Subject: Re: [RFC PATCH] Bluetooth: ISO: add stream synchronization mechanism
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 09 Feb 2024 18:12:03 +0000
In-Reply-To: <CABBYNZ+9m--Yw_WLD9K26Gkr0DtJZf7pFor4zOaAbrqxjC-y2Q@mail.gmail.com>
References: 
	<ebaa4168cb73733ae8fca3c8f47fb88b757ebdfe.1707343746.git.pav@iki.fi>
	 <CABBYNZ+9m--Yw_WLD9K26Gkr0DtJZf7pFor4zOaAbrqxjC-y2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pe, 2024-02-09 kello 09:30 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, Feb 7, 2024 at 5:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > ISO streams in the same group should be synchronized, this is required
> > e.g. by stereo audio playback in TWS headsets.  Currently the only
> > synchronization mechanism we use is that the user has to supply data fo=
r
> > each stream at the right time and in right order, and then we send them
> > to the controller ASAP without explicitly trying to keep streams in syn=
c
> > and hope for the best.
> >=20
> > However, it is observed e.g. with Intel AX210 that rather often a packe=
t
> > for one of the streams does not get sent but is left in the queue and
> > postponed, even if submitted to controller queue at the same time (as
> > far as able). After this, that ISO stream latency is persistently one
> > packet larger relative to the other streams in the group, and e.g. TWS
> > stereo audio is ruined.  User sending packets to the ISO sockets cannot
> > know this occurred, nor can it easily correct for it.
> >=20
> > The issue can e.g. be triggered by bad transmission (e.g. cover one of
> > the TWS earbuds with hand, or move the device further away), which
> > appears to make a random change to the latency of its stream.
> >=20
> > Fix the problem by adding an explicit stream synchronization mechanism
> > to ISO sockets, and handling stream synchronization in packet
> > scheduling.
> >=20
> > The user may tag each packet sent to ISO socket via CMSG with a
> > monotonically increasing sequence number.  The kernel shall ensure that
> > SDU timings within ISO group are such that packets with same CMSG
> > sequence number are aligned.
> >=20
> > The implementation here does this by delaying sending some packets unti=
l
> > the streams are aligned.  It will also wait for controller queue to
> > flush sufficiently, if it appears that streams are out of sync on the
> > controller side.  See the code for explanation.
> >=20
> > This patch fixes the observed TWS desynchronization issue (currently no=
t
> > completely, see below), if the sound server is modified to add the
> > packet seq,
> > https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-seqnum
> >=20
> > I tried various other things to try to fix this (FIFO scheduling,
> > different number of packets submitted at the same time, etc.), without
> > much success, and this is the first one to give results.  Requiring
> > conn->sent alignment before sending more stuff to the controller seemed
> > the important step here.
> >=20
> > There are a few things to think about, hence RFC:
> >=20
> > - Any better ideas?
> >=20
> >   The spec seems vague here (if we can't set SDU timestamps), so some
> >   approach that's not based on guessing what the controller internally
> >   does could be better.
> >=20
> > - The conn->sent alignment check probably should be somehow refined.  I=
t
> >   seems to be enough with low transport latency, but with larger
> >   transport latencies one can still get streams out of sync,
> >   characterized by the controller not reporting Number of Completed
> >   packets for all streams in one go, but sending completed packet event=
s
> >   for some of the streams only a bit later.
> >=20
> > - This sort of scheduling thing that depends on controller queue or
> >   clock IMO needs to be done in kernel, user should just tell the kerne=
l
> >   how stuff is supposed to be scheduled.
> >=20
> > - However, not clear if packet sequence number is the best way to for
> >   this sort of thing, or if user should specify some sort of timestamps
> >   or other information instead.
> >=20
> >   E.g. we might change this to use SDU timestamps (if they can be used)=
,
> >   but user would communicate the scheduling info still the same way.
> >=20
> > - Ideally we probably should use SDU timestamps to explicitly tell the
> >   controller which packets go to same interval, but at least when last
> >   tried AX210 didn't support HCI_LE_Read_ISO_TX_Sync, and it appears
> >   clock synchronization is required which cannot(?) be obtained without
> >   it.
> >=20
> > - This patch can make latency to grow on transmission glitch, if it
> >   needs to wait for controller queue to drain so that streams can be
> >   aligned again. For proper flow control especially in audio use cases,
> >   but also more generally, would be better to have for user a way to
> >   know the number of packets in queue, in socket buf, and in controller=
,
> >   and the max.  TIOCOUTQ is similar, but does not give packet counts no=
r
> >   controller queue so is insufficient.
>=20
> I'd be cautions on doing such a change to packet scheduling, I'd like
> to keep it as simple as possible and not introduce early optimizations
> until the controller's scheduler matures for ISO, in the meantime
> perhaps we should focus in reporting the latencies, either with use of
> HCI_LE_Read_ISO_TX_Sync or using NOCP events like btmon does, that way
> the application can make the necessary adjustments.

Fair enough, persistent stream desynchronization even if SDU to both
streams are submitted at the same time at ISO interval may be
controller side issue we should not try to workaround.

Of course if the controller doesn't properly implement the mandatory
HCI LE Read ISO TX Sync, it's not compliant in any case.

For the present though, it probably would make more sense to change the
kernel to send ISO packets in global FIFO order, rather than trying to
balance=C2=A0conn->sent queues without knowing which packets belong
together.

I can send a patch for that, and try to dig up old latency reporting
patches... The idea I think would be to add ioctl for this so it's
accessible if you have the fd.

> Btw, I do intend to create a issue against the Bluetooth Core spec
> regarding how the packet flow control works for ISO, it doesn't seem
> doing credit based flow control is the correct approach for something
> that requires strict timings like ISO does, so we might as well
> schedule packets every interval and ignore the number of buffers
> completely since they are restored asynchronously it gets really
> complicated to synchronize connections like we are observing in the
> issues.

Clarification on how stream synchronization is supposed to work over
HCI would be useful.

Is it the job of the controller to realign TX synchronization based on
timestamps when SDU were received (and drop data / change latency as
needed), or is it the job of the host to monitor the TX sync and do
this if it sees TX sync is off for some streams?

Here it looks as if the controller expects the host to do it. Vol 6
Part G Sec 3.3 gives the opposite impression, but it's not really
clear.

> > Link: https://github.com/bluez/bluez/issues/515
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  include/net/bluetooth/bluetooth.h |   6 +
> >  include/net/bluetooth/iso.h       |   3 +
> >  net/bluetooth/hci_core.c          | 262 ++++++++++++++++++++++++++++--
> >  net/bluetooth/iso.c               |  46 ++++++
> >  4 files changed, 305 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 7ffa8c192c3f..f93149740207 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -458,6 +458,11 @@ struct mgmt_ctrl {
> >         u16 opcode;
> >  };
> >=20
> > +struct iso_ctrl {
> > +       u16 seq;
> > +       u8 have_seq:1;
> > +};
> > +
> >  struct bt_skb_cb {
> >         u8 pkt_type;
> >         u8 force_active;
> > @@ -469,6 +474,7 @@ struct bt_skb_cb {
> >                 struct hci_ctrl hci;
> >                 struct mgmt_ctrl mgmt;
> >                 struct scm_creds creds;
> > +               struct iso_ctrl iso;
> >         };
> >  };
> >  #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
> > diff --git a/include/net/bluetooth/iso.h b/include/net/bluetooth/iso.h
> > index 3f4fe8b78e1b..a68ddd99232f 100644
> > --- a/include/net/bluetooth/iso.h
> > +++ b/include/net/bluetooth/iso.h
> > @@ -29,4 +29,7 @@ struct sockaddr_iso {
> >         struct sockaddr_iso_bc iso_bc[];
> >  };
> >=20
> > +/* ISO socket CMSG */
> > +#define ISO_CMSG_SEQ                   0x01    /* u16 data */
> > +
> >  #endif /* __ISO_H */
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 34c8dca2069f..706784aa8bb4 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3330,6 +3330,7 @@ static void hci_queue_iso(struct hci_conn *conn, =
struct sk_buff_head *queue,
> >  {
> >         struct hci_dev *hdev =3D conn->hdev;
> >         struct sk_buff *list;
> > +       ktime_t now =3D ktime_get();
> >         __u16 flags;
> >=20
> >         skb->len =3D skb_headlen(skb);
> > @@ -3346,6 +3347,7 @@ static void hci_queue_iso(struct hci_conn *conn, =
struct sk_buff_head *queue,
> >                 /* Non fragmented */
> >                 BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb=
->len);
> >=20
> > +               skb_set_delivery_time(skb, now, true);
> >                 skb_queue_tail(queue, skb);
> >         } else {
> >                 /* Fragmented */
> > @@ -3353,6 +3355,7 @@ static void hci_queue_iso(struct hci_conn *conn, =
struct sk_buff_head *queue,
> >=20
> >                 skb_shinfo(skb)->frag_list =3D NULL;
> >=20
> > +               skb_set_delivery_time(skb, now, true);
> >                 __skb_queue_tail(queue, skb);
> >=20
> >                 do {
> > @@ -3365,6 +3368,7 @@ static void hci_queue_iso(struct hci_conn *conn, =
struct sk_buff_head *queue,
> >=20
> >                         BT_DBG("%s frag %p len %d", hdev->name, skb, sk=
b->len);
> >=20
> > +                       skb_set_delivery_time(skb, now, true);
> >                         __skb_queue_tail(queue, skb);
> >                 } while (list);
> >         }
> > @@ -3461,6 +3465,237 @@ static struct hci_conn *hci_low_sent(struct hci=
_dev *hdev, __u8 type,
> >         return conn;
> >  }
> >=20
> > +static unsigned int iso_group_id(struct hci_conn *conn)
> > +{
> > +       if (!conn)
> > +               return 0xff;
> > +
> > +       if (bacmp(&conn->dst, BDADDR_ANY))
> > +               return (u8)conn->iso_qos.ucast.cig;
> > +       else
> > +               return (u8)conn->iso_qos.bcast.big + 0x100;
> > +}
> > +
> > +static int iso_seq_cmp(u16 a, u16 b)
> > +{
> > +       u16 diff =3D a - b;
> > +
> > +       return (diff =3D=3D 0) ? 0 : (diff < U16_MAX / 2) ? 1 : -1;
> > +}
> > +
> > +static struct hci_conn *hci_low_iso_group(struct hci_dev *hdev, u16 gr=
oup_id,
> > +                                         int pkt, int max_pkt,
> > +                                         ktime_t *res_time)
> > +{
> > +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> > +       struct hci_conn *c;
> > +       bool ready =3D true;
> > +       bool same_sent =3D true;
> > +       struct hci_conn *early_c =3D NULL;
> > +       ktime_t early_time =3D KTIME_MAX;
> > +       struct hci_conn *seq_c =3D NULL;
> > +       u16 seq =3D 0;
> > +       unsigned int sent =3D ~0;
> > +       int group_size =3D 0;
> > +
> > +       /* The controller may use packet arrival times to assign timest=
amps
> > +        * (Core v5.4 Vol 6 Part G Sec 3.3). We should try to send pack=
ets that
> > +        * correspond to same interval in ISO group at the same time, s=
o that
> > +        * streams in the group stay in sync with each other.
> > +        *
> > +        * User may attach a sequence number (seq) to each skb via cmsg=
.  We try
> > +        * to send, within a group, the skb that have the same seq at t=
he same
> > +        * time.
> > +        *
> > +        * skb seq and ktime (when we received it from user) are used f=
or
> > +        * scheduling. The seq of a stream is the one of its first skb.
> > +        *
> > +        * First:
> > +        *
> > +        * - For each stream in a group, clear seq that are earlier tha=
n other
> > +        *   seq in the group.
> > +        *
> > +        * - If all streams in a group have same seq, those streams are
> > +        *   "ready".
> > +        *
> > +        * - If a stream in a group has no seq, that stream is "ready".
> > +        *
> > +        * Then:
> > +        *
> > +        * Select the "ready" stream that has earliest ktime, of those =
in all
> > +        * groups.
> > +        *
> > +        * If the stream has seq (=3D its group as a whole is "ready"):
> > +        *
> > +        * - If controller does not have enough free packet slots to re=
ceive
> > +        *   the whole group at once, but in principle can have enough =
slots,
> > +        *   don't send anything and wait for queue to clear.
> > +        *
> > +        * - If conn->sent in the group are not equal, don't send anyth=
ing
> > +        *   and wait for queue to clear.
> > +        *
> > +        * The conn->sent one is important, and is what recovers synchr=
onization
> > +        * when the controller loses it. It appears that e.g. with Inte=
l AX210
> > +        * sometimes one of packets of a group, even when submitted imm=
ediately
> > +        * after each other to all streams in a group, fails to be sent=
 but is
> > +        * left in the queue instead of being discarded. It gets postpo=
ned for
> > +        * later, but this destroys synchronization between streams, an=
d we have
> > +        * to compensate for this if we see it.
> > +        *
> > +        * Core v5.4 Vol 6 Part G does not give much tools to do things=
 properly
> > +        * when HCI_LE_Read_ISO_TX_Sync does not work and we can't set
> > +        * timestamps, hence the contortions here.
> > +        */
> > +
> > +       /* called with rcu lock held */
> > +       list_for_each_entry_rcu(c, &h->list, list) {
> > +               struct sk_buff *skb;
> > +
> > +               if (c->type !=3D ISO_LINK || c->state !=3D BT_CONNECTED=
)
> > +                       continue;
> > +               if (iso_group_id(c) !=3D group_id)
> > +                       continue;
> > +
> > +               ++group_size;
> > +
> > +               if (sent =3D=3D ~0)
> > +                       sent =3D c->sent;
> > +               if (c->sent !=3D sent)
> > +                       same_sent =3D false;
> > +
> > +               if (skb_queue_empty(&c->data_q)) {
> > +                       ready =3D false;
> > +                       continue;
> > +               }
> > +
> > +               skb =3D skb_peek(&c->data_q);
> > +
> > +               /* Earliest skb */
> > +               if (!early_c || skb_get_ktime(skb) < early_time) {
> > +                       early_c =3D c;
> > +                       early_time =3D skb_get_ktime(skb);
> > +               }
> > +
> > +               if (bt_cb(skb)->iso.have_seq) {
> > +                       u16 cseq =3D bt_cb(skb)->iso.seq;
> > +                       int diff =3D iso_seq_cmp(cseq, seq);
> > +
> > +                       if (seq_c && diff !=3D 0)
> > +                               ready =3D false;
> > +
> > +                       /* Largest seq */
> > +                       if (!seq_c || diff > 0) {
> > +                               seq =3D cseq;
> > +                               seq_c =3D c;
> > +                       }
> > +               } else {
> > +                       ready =3D false;
> > +               }
> > +       }
> > +
> > +       if (!early_c) {
> > +               *res_time =3D KTIME_MAX;
> > +               return NULL;
> > +       }
> > +
> > +       /* Group has seq and is ready? */
> > +       if (ready) {
> > +               *res_time =3D early_time;
> > +
> > +               /* Need to wait for queue to clear? */
> > +               if (!same_sent && pkt < max_pkt) {
> > +                       BT_DBG("group %u !same_sent", group_id);
> > +                       return NULL;
> > +               }
> > +               if (group_size <=3D max_pkt && group_size > pkt) {
> > +                       BT_DBG("group %u wait queue", group_id);
> > +                       return NULL;
> > +               }
> > +
> > +               BT_DBG("group %u ready %u", group_id, seq);
> > +       } else {
> > +               early_c =3D NULL;
> > +               early_time =3D KTIME_MAX;
> > +
> > +               if (seq_c)
> > +                       BT_DBG("group %u seq %u", group_id, seq);
> > +       }
> > +
> > +       list_for_each_entry_rcu(c, &h->list, list) {
> > +               struct sk_buff *skb;
> > +
> > +               if (c->type !=3D ISO_LINK || c->state !=3D BT_CONNECTED=
)
> > +                       continue;
> > +               if (iso_group_id(c) !=3D group_id || skb_queue_empty(&c=
->data_q))
> > +                       continue;
> > +
> > +               skb =3D skb_peek(&c->data_q);
> > +
> > +               /* Clear seq */
> > +               if (ready) {
> > +                       bt_cb(skb)->iso.have_seq =3D false;
> > +                       skb_set_delivery_time(skb, early_time, true);
> > +               } else if (bt_cb(skb)->iso.have_seq && seq_c) {
> > +                       u16 cseq =3D bt_cb(skb)->iso.seq;
> > +
> > +                       if (cseq !=3D seq)
> > +                               bt_cb(skb)->iso.have_seq =3D false;
> > +               }
> > +
> > +               /* Conn with earliest non-seq skb */
> > +               if (!bt_cb(skb)->iso.have_seq) {
> > +                       if (!early_c || skb_get_ktime(skb) < early_time=
) {
> > +                               early_c =3D c;
> > +                               early_time =3D skb_get_ktime(skb);
> > +                       }
> > +               }
> > +       }
> > +
> > +       *res_time =3D early_time;
> > +       return early_c;
> > +}
> > +
> > +static struct hci_conn *hci_low_iso(struct hci_dev *hdev, int pkt, int=
 max_pkt)
> > +{
> > +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> > +       struct hci_conn *c;
> > +       unsigned long group_done[BITS_TO_LONGS(0x200)];
> > +       ktime_t min =3D KTIME_MAX;
> > +       struct hci_conn *conn =3D NULL;
> > +
> > +       /* See hci_low_iso_group() for explanation */
> > +
> > +       bitmap_zero(group_done, 0x200);
> > +
> > +       rcu_read_lock();
> > +
> > +       list_for_each_entry_rcu(c, &h->list, list) {
> > +               struct hci_conn *c2;
> > +               ktime_t t;
> > +
> > +               if (c->type !=3D ISO_LINK || c->state !=3D BT_CONNECTED=
)
> > +                       continue;
> > +               if (test_bit(iso_group_id(c), group_done))
> > +                       continue;
> > +
> > +               c2 =3D hci_low_iso_group(hdev, iso_group_id(c), pkt, ma=
x_pkt, &t);
> > +               if (t < min) {
> > +                       conn =3D c2;
> > +                       min =3D t;
> > +               }
> > +
> > +               BT_DBG("group %u conn %p", iso_group_id(c), c2);
> > +
> > +               set_bit(iso_group_id(c), group_done);
> > +       }
> > +
> > +       rcu_read_unlock();
> > +
> > +       BT_DBG("conn %p", conn);
> > +
> > +       return conn;
> > +}
> > +
> >  static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
> >  {
> >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > @@ -3846,12 +4081,11 @@ static void hci_sched_le(struct hci_dev *hdev)
> >                 hci_prio_recalculate(hdev, LE_LINK);
> >  }
> >=20
> > -/* Schedule CIS */
> > +/* Schedule CIS/BIS */
> >  static void hci_sched_iso(struct hci_dev *hdev)
> >  {
> >         struct hci_conn *conn;
> > -       struct sk_buff *skb;
> > -       int quote, *cnt;
> > +       unsigned int max, *cnt;
> >=20
> >         BT_DBG("%s", hdev->name);
> >=20
> > @@ -3860,16 +4094,20 @@ static void hci_sched_iso(struct hci_dev *hdev)
> >=20
> >         cnt =3D hdev->iso_pkts ? &hdev->iso_cnt :
> >                 hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
> > -       while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote)))=
 {
> > -               while (quote-- && (skb =3D skb_dequeue(&conn->data_q)))=
 {
> > -                       BT_DBG("skb %p len %d", skb, skb->len);
> > -                       hci_send_frame(hdev, skb);
> > +       max =3D (cnt =3D=3D &hdev->iso_cnt) ? hdev->iso_pkts : 0;
> >=20
> > -                       conn->sent++;
> > -                       if (conn->sent =3D=3D ~0)
> > -                               conn->sent =3D 0;
> > -                       (*cnt)--;
> > -               }
> > +       while (*cnt && (conn =3D hci_low_iso(hdev, *cnt, max))) {
> > +               struct sk_buff *skb;
> > +
> > +               skb =3D skb_dequeue(&conn->data_q);
> > +
> > +               BT_DBG("skb %p len %d", skb, skb->len);
> > +               hci_send_frame(hdev, skb);
> > +
> > +               conn->sent++;
> > +               if (conn->sent =3D=3D ~0)
> > +                       conn->sent =3D 0;
> > +               (*cnt)--;
> >         }
> >  }
> >=20
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 04f6572d35f1..58d9ec8ce298 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1240,12 +1240,48 @@ static int iso_sock_getname(struct socket *sock=
, struct sockaddr *addr,
> >         return sizeof(struct sockaddr_iso);
> >  }
> >=20
> > +static int iso_cmsg_parse_one(struct cmsghdr *cmsg, struct iso_ctrl *c=
trl)
> > +{
> > +       switch (cmsg->cmsg_type) {
> > +       case ISO_CMSG_SEQ:
> > +               if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(ctrl->seq)))
> > +                       return -EINVAL;
> > +
> > +               memcpy(&ctrl->seq, CMSG_DATA(cmsg), sizeof(ctrl->seq));
> > +               ctrl->have_seq =3D true;
> > +               return 0;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static int iso_cmsg_parse(struct sock *sk, struct msghdr *msg, struct =
iso_ctrl *ctrl)
> > +{
> > +       struct cmsghdr *cmsg;
> > +       int err;
> > +
> > +       for_each_cmsghdr(cmsg, msg) {
> > +               if (!CMSG_OK(msg, cmsg))
> > +                       return -EINVAL;
> > +
> > +               if (cmsg->cmsg_level !=3D SOL_BLUETOOTH)
> > +                       continue;
> > +
> > +               err =3D iso_cmsg_parse_one(cmsg, ctrl);
> > +               if (err < 0)
> > +                       return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
> >                             size_t len)
> >  {
> >         struct sock *sk =3D sock->sk;
> >         struct sk_buff *skb, **frag;
> >         size_t mtu;
> > +       struct iso_ctrl ctrl =3D {};
> >         int err;
> >=20
> >         BT_DBG("sock %p, sk %p", sock, sk);
> > @@ -1257,6 +1293,12 @@ static int iso_sock_sendmsg(struct socket *sock,=
 struct msghdr *msg,
> >         if (msg->msg_flags & MSG_OOB)
> >                 return -EOPNOTSUPP;
> >=20
> > +       if (msg->msg_controllen) {
> > +               err =3D iso_cmsg_parse(sk, msg, &ctrl);
> > +               if (err < 0)
> > +                       return err;
> > +       }
> > +
> >         lock_sock(sk);
> >=20
> >         if (sk->sk_state !=3D BT_CONNECTED) {
> > @@ -1274,6 +1316,8 @@ static int iso_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
> >=20
> >         len -=3D skb->len;
> >=20
> > +       bt_cb(skb)->iso =3D ctrl;
> > +
> >         BT_DBG("skb %p len %d", sk, skb->len);
> >=20
> >         /* Continuation fragments */
> > @@ -1294,6 +1338,8 @@ static int iso_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
> >                 skb->len +=3D tmp->len;
> >                 skb->data_len +=3D tmp->len;
> >=20
> > +               bt_cb(tmp)->iso.have_seq =3D false;
> > +
> >                 BT_DBG("frag %p len %d", *frag, tmp->len);
> >=20
> >                 frag =3D &(*frag)->next;
> > --
> > 2.43.0
> >=20
> >=20
>=20
>=20

