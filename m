Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644176A01C
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489036; cv=none; b=FLHUh1YpVFYSl4ZrJwzZzgx7UqnDMHuXNoyb/f9quctlTEWHX9sgeBafCWujERzfy+UrLjRF9985tGs8RVQ+c0l6PKbcb5fh7FpPCe1axQq2tBl0QWaVeYA0t5d4SHTa3mClBzyvvyswgTUbJElX1qQKV83zlFO27GY1/zt3tGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489036; c=relaxed/simple;
	bh=uQDcIiwheWIAnJIFWRQ6W/qtIP0gO3C4vubL33UE+HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSvRsgJzuov5zyDVYex0KMpOjCZ++ki8Hk7yV+0e4un4UOPqZmjthN2vkD1Z26f7zCBw7xl9LmGvWb2CS0gVt4kOjXBZth1cX2BzV0JNWkJcxVja/LgDVhuvNup7RbdfaD9gSOfCl7HwTEziNGtdMc8Tih1w2qGDZjsWEB31o5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwW4gZ/F; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwW4gZ/F"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51174101765so1126767e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 06:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707489032; x=1708093832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDxRLywQDwCuWgGIMCby11ETmud5kq862uOiIDu1fUI=;
        b=QwW4gZ/FksYGfjEzDWn03/iTdjea2lDQCtYrdvnSJegTb7YSrXacCmg8igz6rEZWRM
         znrIq8dpjLWOyzEUBbc9/H2+FgrURjSj79iFplEBjebtHtqAWs2n/LDhqPz5s54WC2Ck
         6vVeVvYuGEg74sGdEy3RZY9ECct64u51+B+CKZXFPa2LQuv3/ZPEXvyNnBAuQFWLcR5j
         VnnQmXSRjDcf2cKdR5eU2AubwnfTNUYp0KNV4lF+I27zz1mjRODPa9D+owdSd3dPHF/E
         ueEagpscb58xuPFynLn7/efeH95FtJeUbzPMUAkH6ImvwK1bCDiiLu0i4Sil7KJtXq6M
         /3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707489032; x=1708093832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDxRLywQDwCuWgGIMCby11ETmud5kq862uOiIDu1fUI=;
        b=PqNbXyQP73dnE+6yOWKlwXuRzW3mLsn/QXjP/CS6LvNULBin6yH+XiGA2HjBJfAo21
         jmxC83GkAyunv5E1EPTwSBwdv2af1YdS5kn13IyRC/1WHJhgPgTqW9CHetMyChbrLn1D
         r9owsJMc2myAxZra8ax/KUSfsTaya4fcXMN8ewaUcrDJO8/ddDmpaJLclemXtJB4B/LG
         lkBBPCoOZwbgx6GZKBV5T5vuMqk9WDL9AdgL610P62P6OmvCqLfCwgeW/poA32lYErrW
         YsODr6X1uIKsPh+aEH4pUNYDhcd57EJa+R67UexzRvprb+3Es0ew871CS45KMNNdqVG/
         YQSw==
X-Gm-Message-State: AOJu0YzywNKTJtlLIUEVkxEMOqKIWjf56YeHtwMc+7ULel7TJyMN3Z6l
	+tKT/PInjxTFjwNVh6R7sp3Bh6tGlIiu+N83yCWI+V7D26RLHdRh2Q62cGDQqEyt3Zmq5NmvFMl
	Jdv1TQ2KPr/DhwaLw52cRJu7PmcvMA3sBkA0=
X-Google-Smtp-Source: AGHT+IGIQI0X2e+LW4Q4PPWXYcBCZjD6bUtYHz7JXLS1EU/pAWvgX0EmIKw1RQEqTw/jpEJR1RpVNzkTsRWKtbJrsUk=
X-Received: by 2002:a2e:8788:0:b0:2d0:9bd4:c6c5 with SMTP id
 n8-20020a2e8788000000b002d09bd4c6c5mr1329374lji.42.1707489031836; Fri, 09 Feb
 2024 06:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ebaa4168cb73733ae8fca3c8f47fb88b757ebdfe.1707343746.git.pav@iki.fi>
In-Reply-To: <ebaa4168cb73733ae8fca3c8f47fb88b757ebdfe.1707343746.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Feb 2024 09:30:19 -0500
Message-ID: <CABBYNZ+9m--Yw_WLD9K26Gkr0DtJZf7pFor4zOaAbrqxjC-y2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] Bluetooth: ISO: add stream synchronization mechanism
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Feb 7, 2024 at 5:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ISO streams in the same group should be synchronized, this is required
> e.g. by stereo audio playback in TWS headsets.  Currently the only
> synchronization mechanism we use is that the user has to supply data for
> each stream at the right time and in right order, and then we send them
> to the controller ASAP without explicitly trying to keep streams in sync
> and hope for the best.
>
> However, it is observed e.g. with Intel AX210 that rather often a packet
> for one of the streams does not get sent but is left in the queue and
> postponed, even if submitted to controller queue at the same time (as
> far as able). After this, that ISO stream latency is persistently one
> packet larger relative to the other streams in the group, and e.g. TWS
> stereo audio is ruined.  User sending packets to the ISO sockets cannot
> know this occurred, nor can it easily correct for it.
>
> The issue can e.g. be triggered by bad transmission (e.g. cover one of
> the TWS earbuds with hand, or move the device further away), which
> appears to make a random change to the latency of its stream.
>
> Fix the problem by adding an explicit stream synchronization mechanism
> to ISO sockets, and handling stream synchronization in packet
> scheduling.
>
> The user may tag each packet sent to ISO socket via CMSG with a
> monotonically increasing sequence number.  The kernel shall ensure that
> SDU timings within ISO group are such that packets with same CMSG
> sequence number are aligned.
>
> The implementation here does this by delaying sending some packets until
> the streams are aligned.  It will also wait for controller queue to
> flush sufficiently, if it appears that streams are out of sync on the
> controller side.  See the code for explanation.
>
> This patch fixes the observed TWS desynchronization issue (currently not
> completely, see below), if the sound server is modified to add the
> packet seq,
> https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-seqnum
>
> I tried various other things to try to fix this (FIFO scheduling,
> different number of packets submitted at the same time, etc.), without
> much success, and this is the first one to give results.  Requiring
> conn->sent alignment before sending more stuff to the controller seemed
> the important step here.
>
> There are a few things to think about, hence RFC:
>
> - Any better ideas?
>
>   The spec seems vague here (if we can't set SDU timestamps), so some
>   approach that's not based on guessing what the controller internally
>   does could be better.
>
> - The conn->sent alignment check probably should be somehow refined.  It
>   seems to be enough with low transport latency, but with larger
>   transport latencies one can still get streams out of sync,
>   characterized by the controller not reporting Number of Completed
>   packets for all streams in one go, but sending completed packet events
>   for some of the streams only a bit later.
>
> - This sort of scheduling thing that depends on controller queue or
>   clock IMO needs to be done in kernel, user should just tell the kernel
>   how stuff is supposed to be scheduled.
>
> - However, not clear if packet sequence number is the best way to for
>   this sort of thing, or if user should specify some sort of timestamps
>   or other information instead.
>
>   E.g. we might change this to use SDU timestamps (if they can be used),
>   but user would communicate the scheduling info still the same way.
>
> - Ideally we probably should use SDU timestamps to explicitly tell the
>   controller which packets go to same interval, but at least when last
>   tried AX210 didn't support HCI_LE_Read_ISO_TX_Sync, and it appears
>   clock synchronization is required which cannot(?) be obtained without
>   it.
>
> - This patch can make latency to grow on transmission glitch, if it
>   needs to wait for controller queue to drain so that streams can be
>   aligned again. For proper flow control especially in audio use cases,
>   but also more generally, would be better to have for user a way to
>   know the number of packets in queue, in socket buf, and in controller,
>   and the max.  TIOCOUTQ is similar, but does not give packet counts nor
>   controller queue so is insufficient.

I'd be cautions on doing such a change to packet scheduling, I'd like
to keep it as simple as possible and not introduce early optimizations
until the controller's scheduler matures for ISO, in the meantime
perhaps we should focus in reporting the latencies, either with use of
HCI_LE_Read_ISO_TX_Sync or using NOCP events like btmon does, that way
the application can make the necessary adjustments.

Btw, I do intend to create a issue against the Bluetooth Core spec
regarding how the packet flow control works for ISO, it doesn't seem
doing credit based flow control is the correct approach for something
that requires strict timings like ISO does, so we might as well
schedule packets every interval and ignore the number of buffers
completely since they are restored asynchronously it gets really
complicated to synchronize connections like we are observing in the
issues.

> Link: https://github.com/bluez/bluez/issues/515
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/bluetooth.h |   6 +
>  include/net/bluetooth/iso.h       |   3 +
>  net/bluetooth/hci_core.c          | 262 ++++++++++++++++++++++++++++--
>  net/bluetooth/iso.c               |  46 ++++++
>  4 files changed, 305 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 7ffa8c192c3f..f93149740207 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -458,6 +458,11 @@ struct mgmt_ctrl {
>         u16 opcode;
>  };
>
> +struct iso_ctrl {
> +       u16 seq;
> +       u8 have_seq:1;
> +};
> +
>  struct bt_skb_cb {
>         u8 pkt_type;
>         u8 force_active;
> @@ -469,6 +474,7 @@ struct bt_skb_cb {
>                 struct hci_ctrl hci;
>                 struct mgmt_ctrl mgmt;
>                 struct scm_creds creds;
> +               struct iso_ctrl iso;
>         };
>  };
>  #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
> diff --git a/include/net/bluetooth/iso.h b/include/net/bluetooth/iso.h
> index 3f4fe8b78e1b..a68ddd99232f 100644
> --- a/include/net/bluetooth/iso.h
> +++ b/include/net/bluetooth/iso.h
> @@ -29,4 +29,7 @@ struct sockaddr_iso {
>         struct sockaddr_iso_bc iso_bc[];
>  };
>
> +/* ISO socket CMSG */
> +#define ISO_CMSG_SEQ                   0x01    /* u16 data */
> +
>  #endif /* __ISO_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 34c8dca2069f..706784aa8bb4 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3330,6 +3330,7 @@ static void hci_queue_iso(struct hci_conn *conn, st=
ruct sk_buff_head *queue,
>  {
>         struct hci_dev *hdev =3D conn->hdev;
>         struct sk_buff *list;
> +       ktime_t now =3D ktime_get();
>         __u16 flags;
>
>         skb->len =3D skb_headlen(skb);
> @@ -3346,6 +3347,7 @@ static void hci_queue_iso(struct hci_conn *conn, st=
ruct sk_buff_head *queue,
>                 /* Non fragmented */
>                 BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->=
len);
>
> +               skb_set_delivery_time(skb, now, true);
>                 skb_queue_tail(queue, skb);
>         } else {
>                 /* Fragmented */
> @@ -3353,6 +3355,7 @@ static void hci_queue_iso(struct hci_conn *conn, st=
ruct sk_buff_head *queue,
>
>                 skb_shinfo(skb)->frag_list =3D NULL;
>
> +               skb_set_delivery_time(skb, now, true);
>                 __skb_queue_tail(queue, skb);
>
>                 do {
> @@ -3365,6 +3368,7 @@ static void hci_queue_iso(struct hci_conn *conn, st=
ruct sk_buff_head *queue,
>
>                         BT_DBG("%s frag %p len %d", hdev->name, skb, skb-=
>len);
>
> +                       skb_set_delivery_time(skb, now, true);
>                         __skb_queue_tail(queue, skb);
>                 } while (list);
>         }
> @@ -3461,6 +3465,237 @@ static struct hci_conn *hci_low_sent(struct hci_d=
ev *hdev, __u8 type,
>         return conn;
>  }
>
> +static unsigned int iso_group_id(struct hci_conn *conn)
> +{
> +       if (!conn)
> +               return 0xff;
> +
> +       if (bacmp(&conn->dst, BDADDR_ANY))
> +               return (u8)conn->iso_qos.ucast.cig;
> +       else
> +               return (u8)conn->iso_qos.bcast.big + 0x100;
> +}
> +
> +static int iso_seq_cmp(u16 a, u16 b)
> +{
> +       u16 diff =3D a - b;
> +
> +       return (diff =3D=3D 0) ? 0 : (diff < U16_MAX / 2) ? 1 : -1;
> +}
> +
> +static struct hci_conn *hci_low_iso_group(struct hci_dev *hdev, u16 grou=
p_id,
> +                                         int pkt, int max_pkt,
> +                                         ktime_t *res_time)
> +{
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       struct hci_conn *c;
> +       bool ready =3D true;
> +       bool same_sent =3D true;
> +       struct hci_conn *early_c =3D NULL;
> +       ktime_t early_time =3D KTIME_MAX;
> +       struct hci_conn *seq_c =3D NULL;
> +       u16 seq =3D 0;
> +       unsigned int sent =3D ~0;
> +       int group_size =3D 0;
> +
> +       /* The controller may use packet arrival times to assign timestam=
ps
> +        * (Core v5.4 Vol 6 Part G Sec 3.3). We should try to send packet=
s that
> +        * correspond to same interval in ISO group at the same time, so =
that
> +        * streams in the group stay in sync with each other.
> +        *
> +        * User may attach a sequence number (seq) to each skb via cmsg. =
 We try
> +        * to send, within a group, the skb that have the same seq at the=
 same
> +        * time.
> +        *
> +        * skb seq and ktime (when we received it from user) are used for
> +        * scheduling. The seq of a stream is the one of its first skb.
> +        *
> +        * First:
> +        *
> +        * - For each stream in a group, clear seq that are earlier than =
other
> +        *   seq in the group.
> +        *
> +        * - If all streams in a group have same seq, those streams are
> +        *   "ready".
> +        *
> +        * - If a stream in a group has no seq, that stream is "ready".
> +        *
> +        * Then:
> +        *
> +        * Select the "ready" stream that has earliest ktime, of those in=
 all
> +        * groups.
> +        *
> +        * If the stream has seq (=3D its group as a whole is "ready"):
> +        *
> +        * - If controller does not have enough free packet slots to rece=
ive
> +        *   the whole group at once, but in principle can have enough sl=
ots,
> +        *   don't send anything and wait for queue to clear.
> +        *
> +        * - If conn->sent in the group are not equal, don't send anythin=
g
> +        *   and wait for queue to clear.
> +        *
> +        * The conn->sent one is important, and is what recovers synchron=
ization
> +        * when the controller loses it. It appears that e.g. with Intel =
AX210
> +        * sometimes one of packets of a group, even when submitted immed=
iately
> +        * after each other to all streams in a group, fails to be sent b=
ut is
> +        * left in the queue instead of being discarded. It gets postpone=
d for
> +        * later, but this destroys synchronization between streams, and =
we have
> +        * to compensate for this if we see it.
> +        *
> +        * Core v5.4 Vol 6 Part G does not give much tools to do things p=
roperly
> +        * when HCI_LE_Read_ISO_TX_Sync does not work and we can't set
> +        * timestamps, hence the contortions here.
> +        */
> +
> +       /* called with rcu lock held */
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               struct sk_buff *skb;
> +
> +               if (c->type !=3D ISO_LINK || c->state !=3D BT_CONNECTED)
> +                       continue;
> +               if (iso_group_id(c) !=3D group_id)
> +                       continue;
> +
> +               ++group_size;
> +
> +               if (sent =3D=3D ~0)
> +                       sent =3D c->sent;
> +               if (c->sent !=3D sent)
> +                       same_sent =3D false;
> +
> +               if (skb_queue_empty(&c->data_q)) {
> +                       ready =3D false;
> +                       continue;
> +               }
> +
> +               skb =3D skb_peek(&c->data_q);
> +
> +               /* Earliest skb */
> +               if (!early_c || skb_get_ktime(skb) < early_time) {
> +                       early_c =3D c;
> +                       early_time =3D skb_get_ktime(skb);
> +               }
> +
> +               if (bt_cb(skb)->iso.have_seq) {
> +                       u16 cseq =3D bt_cb(skb)->iso.seq;
> +                       int diff =3D iso_seq_cmp(cseq, seq);
> +
> +                       if (seq_c && diff !=3D 0)
> +                               ready =3D false;
> +
> +                       /* Largest seq */
> +                       if (!seq_c || diff > 0) {
> +                               seq =3D cseq;
> +                               seq_c =3D c;
> +                       }
> +               } else {
> +                       ready =3D false;
> +               }
> +       }
> +
> +       if (!early_c) {
> +               *res_time =3D KTIME_MAX;
> +               return NULL;
> +       }
> +
> +       /* Group has seq and is ready? */
> +       if (ready) {
> +               *res_time =3D early_time;
> +
> +               /* Need to wait for queue to clear? */
> +               if (!same_sent && pkt < max_pkt) {
> +                       BT_DBG("group %u !same_sent", group_id);
> +                       return NULL;
> +               }
> +               if (group_size <=3D max_pkt && group_size > pkt) {
> +                       BT_DBG("group %u wait queue", group_id);
> +                       return NULL;
> +               }
> +
> +               BT_DBG("group %u ready %u", group_id, seq);
> +       } else {
> +               early_c =3D NULL;
> +               early_time =3D KTIME_MAX;
> +
> +               if (seq_c)
> +                       BT_DBG("group %u seq %u", group_id, seq);
> +       }
> +
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               struct sk_buff *skb;
> +
> +               if (c->type !=3D ISO_LINK || c->state !=3D BT_CONNECTED)
> +                       continue;
> +               if (iso_group_id(c) !=3D group_id || skb_queue_empty(&c->=
data_q))
> +                       continue;
> +
> +               skb =3D skb_peek(&c->data_q);
> +
> +               /* Clear seq */
> +               if (ready) {
> +                       bt_cb(skb)->iso.have_seq =3D false;
> +                       skb_set_delivery_time(skb, early_time, true);
> +               } else if (bt_cb(skb)->iso.have_seq && seq_c) {
> +                       u16 cseq =3D bt_cb(skb)->iso.seq;
> +
> +                       if (cseq !=3D seq)
> +                               bt_cb(skb)->iso.have_seq =3D false;
> +               }
> +
> +               /* Conn with earliest non-seq skb */
> +               if (!bt_cb(skb)->iso.have_seq) {
> +                       if (!early_c || skb_get_ktime(skb) < early_time) =
{
> +                               early_c =3D c;
> +                               early_time =3D skb_get_ktime(skb);
> +                       }
> +               }
> +       }
> +
> +       *res_time =3D early_time;
> +       return early_c;
> +}
> +
> +static struct hci_conn *hci_low_iso(struct hci_dev *hdev, int pkt, int m=
ax_pkt)
> +{
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       struct hci_conn *c;
> +       unsigned long group_done[BITS_TO_LONGS(0x200)];
> +       ktime_t min =3D KTIME_MAX;
> +       struct hci_conn *conn =3D NULL;
> +
> +       /* See hci_low_iso_group() for explanation */
> +
> +       bitmap_zero(group_done, 0x200);
> +
> +       rcu_read_lock();
> +
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               struct hci_conn *c2;
> +               ktime_t t;
> +
> +               if (c->type !=3D ISO_LINK || c->state !=3D BT_CONNECTED)
> +                       continue;
> +               if (test_bit(iso_group_id(c), group_done))
> +                       continue;
> +
> +               c2 =3D hci_low_iso_group(hdev, iso_group_id(c), pkt, max_=
pkt, &t);
> +               if (t < min) {
> +                       conn =3D c2;
> +                       min =3D t;
> +               }
> +
> +               BT_DBG("group %u conn %p", iso_group_id(c), c2);
> +
> +               set_bit(iso_group_id(c), group_done);
> +       }
> +
> +       rcu_read_unlock();
> +
> +       BT_DBG("conn %p", conn);
> +
> +       return conn;
> +}
> +
>  static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
>  {
>         struct hci_conn_hash *h =3D &hdev->conn_hash;
> @@ -3846,12 +4081,11 @@ static void hci_sched_le(struct hci_dev *hdev)
>                 hci_prio_recalculate(hdev, LE_LINK);
>  }
>
> -/* Schedule CIS */
> +/* Schedule CIS/BIS */
>  static void hci_sched_iso(struct hci_dev *hdev)
>  {
>         struct hci_conn *conn;
> -       struct sk_buff *skb;
> -       int quote, *cnt;
> +       unsigned int max, *cnt;
>
>         BT_DBG("%s", hdev->name);
>
> @@ -3860,16 +4094,20 @@ static void hci_sched_iso(struct hci_dev *hdev)
>
>         cnt =3D hdev->iso_pkts ? &hdev->iso_cnt :
>                 hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
> -       while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote))) {
> -               while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
> -                       BT_DBG("skb %p len %d", skb, skb->len);
> -                       hci_send_frame(hdev, skb);
> +       max =3D (cnt =3D=3D &hdev->iso_cnt) ? hdev->iso_pkts : 0;
>
> -                       conn->sent++;
> -                       if (conn->sent =3D=3D ~0)
> -                               conn->sent =3D 0;
> -                       (*cnt)--;
> -               }
> +       while (*cnt && (conn =3D hci_low_iso(hdev, *cnt, max))) {
> +               struct sk_buff *skb;
> +
> +               skb =3D skb_dequeue(&conn->data_q);
> +
> +               BT_DBG("skb %p len %d", skb, skb->len);
> +               hci_send_frame(hdev, skb);
> +
> +               conn->sent++;
> +               if (conn->sent =3D=3D ~0)
> +                       conn->sent =3D 0;
> +               (*cnt)--;
>         }
>  }
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 04f6572d35f1..58d9ec8ce298 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1240,12 +1240,48 @@ static int iso_sock_getname(struct socket *sock, =
struct sockaddr *addr,
>         return sizeof(struct sockaddr_iso);
>  }
>
> +static int iso_cmsg_parse_one(struct cmsghdr *cmsg, struct iso_ctrl *ctr=
l)
> +{
> +       switch (cmsg->cmsg_type) {
> +       case ISO_CMSG_SEQ:
> +               if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(ctrl->seq)))
> +                       return -EINVAL;
> +
> +               memcpy(&ctrl->seq, CMSG_DATA(cmsg), sizeof(ctrl->seq));
> +               ctrl->have_seq =3D true;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int iso_cmsg_parse(struct sock *sk, struct msghdr *msg, struct is=
o_ctrl *ctrl)
> +{
> +       struct cmsghdr *cmsg;
> +       int err;
> +
> +       for_each_cmsghdr(cmsg, msg) {
> +               if (!CMSG_OK(msg, cmsg))
> +                       return -EINVAL;
> +
> +               if (cmsg->cmsg_level !=3D SOL_BLUETOOTH)
> +                       continue;
> +
> +               err =3D iso_cmsg_parse_one(cmsg, ctrl);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
>  static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>                             size_t len)
>  {
>         struct sock *sk =3D sock->sk;
>         struct sk_buff *skb, **frag;
>         size_t mtu;
> +       struct iso_ctrl ctrl =3D {};
>         int err;
>
>         BT_DBG("sock %p, sk %p", sock, sk);
> @@ -1257,6 +1293,12 @@ static int iso_sock_sendmsg(struct socket *sock, s=
truct msghdr *msg,
>         if (msg->msg_flags & MSG_OOB)
>                 return -EOPNOTSUPP;
>
> +       if (msg->msg_controllen) {
> +               err =3D iso_cmsg_parse(sk, msg, &ctrl);
> +               if (err < 0)
> +                       return err;
> +       }
> +
>         lock_sock(sk);
>
>         if (sk->sk_state !=3D BT_CONNECTED) {
> @@ -1274,6 +1316,8 @@ static int iso_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>
>         len -=3D skb->len;
>
> +       bt_cb(skb)->iso =3D ctrl;
> +
>         BT_DBG("skb %p len %d", sk, skb->len);
>
>         /* Continuation fragments */
> @@ -1294,6 +1338,8 @@ static int iso_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>                 skb->len +=3D tmp->len;
>                 skb->data_len +=3D tmp->len;
>
> +               bt_cb(tmp)->iso.have_seq =3D false;
> +
>                 BT_DBG("frag %p len %d", *frag, tmp->len);
>
>                 frag =3D &(*frag)->next;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
