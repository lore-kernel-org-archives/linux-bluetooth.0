Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2492698A2
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462403; cv=none; b=LXpVsf3LqvYOIm9U1YuMZe0UQJXGaxlPr5S+OAGAshXxTeLv2dLB2iAmkNT33jUQ1LcSyq7BJBBi0obl6Rz42U0rcO11gQTreRRLa+2mansc+P7zUpcSlOka9xfuMg7ZsDuMCYiRl8spDJ6TL0CIZl3f2Ot055dcQAhXE55Q36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462403; c=relaxed/simple;
	bh=Yqru8YddfyEOZjegMmPNhimBb8i5LsR901px2Vk5jYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhZvWFXVHJu9qc4zsoX2d5a++stvVg1W/XxdPeqG0y4saeEm6cv6CkY3mUWBb0Gx+7QInU9oK3ffe+TnaTM2IlwaGJNB3SpgaWw/PMxWX9tnRnjF/5/OhW9VHDXWMm942mky55U5iyJgVEiwE4iMUutq/zKWgJW96tCYjovIe5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPetm2Kd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPetm2Kd"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-310447fe59aso48914791fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746462399; x=1747067199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekkgKipdpJy20GjF0kOmtapFKzVSxLL1U7GFNzjyH5k=;
        b=iPetm2KdRZuAsqUsxlrgEhi0H5pRQbz4nT6TpzVBCcZ/ky6L1MBQ6VhzG4olK2DS63
         2AVU2oxSLn0c8Wyk8S/v9OwlYyXPFbgZ70J6djee7fshnb+eMtTAFX9fqQSCeIa0jDJy
         ZdENGKUnDDIEWRG2wCEPRF7lY2g4OzNDVxxVZZoy714bUBYKX+ivWaZ0fWJzftvyagN/
         HnbwDCAmLVIzk1DNxKYc9Xc3vdeTGLxGFJCdetbzZ+d8PAKgjLIXNqtj9HBJz8/6eQqs
         aI5UGYk0iN2sl3pwDUVAolBYbISH/mHvHjvbh4kY8VvYo3Mqcih6ByCbE1ez8i/me29o
         nDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462399; x=1747067199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekkgKipdpJy20GjF0kOmtapFKzVSxLL1U7GFNzjyH5k=;
        b=Mn//gClTMT+klO3wAvfxBMT2IJyFtLaIUaB3sk5siQ5FtxTcK+4qANidqnjnWEl9CU
         JsYR+PL2mx4Uvxq4BJkjcGffE9fnzALe4uvXjg0gbZWU3H/iIlmbuufpRFATGcRvbCzI
         0L/TnGC0g86Kk4JTqmJn5LvqGU9dQhfDONvXEp0J2o6Ghjm8BlXk8FYy6b1gxl+r56Kn
         71tK5QHUgxPN/KQUAiON+ziGkTNsUyASf7Swkhc/bB8PQdndI7muB/k2xF5VZcVQpxJY
         H08v44yeHhm1sxUbiQxGa20qs3kURsJ2dl4bfM2tg5uLffD9KvTBw6N7Vj2rol3olVLF
         hVWw==
X-Gm-Message-State: AOJu0YzlofM+UMdTxBMbWbRAKdFOItmqf5RHAF9nn6wXt3mVvAeu7sHy
	vZ9Xb7icoox3yj89qbmYFDouHu1AlqMtD6iWIPpribFy4uHRRcuDjw/UGw8g2YXJ/Mhg0ikbTIX
	8sPUF5uZ4g29DLZDwGSZSJ9Ddplc=
X-Gm-Gg: ASbGncty4/s728PtVvMvLsJhdGhJBwxr6ICoFmARCD5n2h0gU1pOu567/2QCJJzTHma
	eXvUw7QUKG/wR0hnoy+D83Ofhg5k36Ewcsyia9yakszVaIdRaPopDHd9UQWenqiFPX3fd57L4r+
	/H+fxOWqfbIypfp9W7EoxKco1qfrAXX58=
X-Google-Smtp-Source: AGHT+IET1PLPMcLwXoxxvFMdf4t0dd15F7wFMT3hHS7Gu9IKrQzdTYn6S7I0V4wVIwbhxceJ7V3J03fRWgZuwBYmxNY=
X-Received: by 2002:a05:651c:221d:b0:30b:bce7:80da with SMTP id
 38308e7fff4ca-32348b4d939mr24999151fa.9.1746462398420; Mon, 05 May 2025
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e26c5c8ef755e9dbe2e1a5204a86ecd907fd6508.1746280854.git.pav@iki.fi>
In-Reply-To: <e26c5c8ef755e9dbe2e1a5204a86ecd907fd6508.1746280854.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 May 2025 12:26:24 -0400
X-Gm-Features: ATxdqUF6A0z23nlH3FFUyk3Ca1NM_Kbe-tTDTrJhwlT1F14Hs38MjEeFjav72J8
Message-ID: <CABBYNZ++P4F9pJv0Kn0h4dwieeaiDaL4REDNaemQxgxsgeH=1g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: separate ISO_LINK_UCAST and BCAST link types
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, May 3, 2025 at 10:08=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Use separate link type id for unicast and broadcast ISO connections.
> These connection types are handled with separate HCI commands, socket
> API is different, and hci_conn has union fields that are different in
> the two cases, so they shall not be mixed up.
>
> Currently in most places it is attempted to distinguish ucast by
> bacmp(&c->dst, BDADDR_ANY) but it is wrong as dst is set for bcast sink
> hci_conn in iso_conn_ready(). Additionally checking sync_handle might be
> OK, but depends on details of bcast conn configuration flow.
>
> To avoid complicating it, use separate link types.

While I agree this makes things easier, I'd go with CIS_LINK and
BIS_LINK as names, anyway I can probably rename it myself so no need
to resend.

> Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     Although in theory this should be OK, bcast functionality is untested
>     with this patch, aside from passing iso-tester.
>
>  include/net/bluetooth/hci.h      |  3 +-
>  include/net/bluetooth/hci_core.h | 48 ++++++++++++++------------------
>  net/bluetooth/hci_conn.c         | 44 +++++++++++++++++------------
>  net/bluetooth/hci_core.c         | 21 ++++++++------
>  net/bluetooth/hci_event.c        | 24 ++++++++--------
>  net/bluetooth/hci_sync.c         | 16 +++++++----
>  net/bluetooth/iso.c              |  4 +--
>  net/bluetooth/mgmt.c             |  3 +-
>  8 files changed, 89 insertions(+), 74 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 2502febf4da7..4d19fde81770 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -558,7 +558,8 @@ enum {
>  #define ESCO_LINK      0x02
>  /* Low Energy links do not have defined link type. Use invented one */
>  #define LE_LINK                0x80
> -#define ISO_LINK       0x82
> +#define ISO_LINK_UCAST 0x82
> +#define ISO_LINK_BCAST 0x83
>  #define INVALID_LINK   0xff
>
>  /* LMP features */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 965ca1ca841c..7f89a19ca1d9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -999,7 +999,8 @@ static inline void hci_conn_hash_add(struct hci_dev *=
hdev, struct hci_conn *c)
>         case ESCO_LINK:
>                 h->sco_num++;
>                 break;
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>                 h->iso_num++;
>                 break;
>         }
> @@ -1025,7 +1026,8 @@ static inline void hci_conn_hash_del(struct hci_dev=
 *hdev, struct hci_conn *c)
>         case ESCO_LINK:
>                 h->sco_num--;
>                 break;
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>                 h->iso_num--;
>                 break;
>         }
> @@ -1042,7 +1044,8 @@ static inline unsigned int hci_conn_num(struct hci_=
dev *hdev, __u8 type)
>         case SCO_LINK:
>         case ESCO_LINK:
>                 return h->sco_num;
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>                 return h->iso_num;
>         default:
>                 return 0;
> @@ -1103,7 +1106,7 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_bis(struct hci_dev *hdev,
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (bacmp(&c->dst, ba) || c->type !=3D ISO_LINK)
> +               if (bacmp(&c->dst, ba) || c->type !=3D ISO_LINK_BCAST)
>                         continue;
>
>                 if (c->iso_qos.bcast.bis =3D=3D bis) {
> @@ -1125,7 +1128,7 @@ hci_conn_hash_lookup_create_pa_sync(struct hci_dev =
*hdev)
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D ISO_LINK)
> +               if (c->type !=3D ISO_LINK_BCAST)
>                         continue;
>
>                 if (!test_bit(HCI_CONN_CREATE_PA_SYNC, &c->flags))
> @@ -1151,8 +1154,8 @@ hci_conn_hash_lookup_per_adv_bis(struct hci_dev *hd=
ev,
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (bacmp(&c->dst, ba) || c->type !=3D ISO_LINK ||
> -                       !test_bit(HCI_CONN_PER_ADV, &c->flags))
> +               if (bacmp(&c->dst, ba) || c->type !=3D ISO_LINK_BCAST ||
> +                   !test_bit(HCI_CONN_PER_ADV, &c->flags))
>                         continue;
>
>                 if (c->iso_qos.bcast.big =3D=3D big &&
> @@ -1241,7 +1244,7 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_cis(struct hci_dev *hdev,
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D ISO_LINK || !bacmp(&c->dst, BDADDR_ANY))
> +               if (c->type !=3D ISO_LINK_UCAST)
>                         continue;
>
>                 /* Match CIG ID if set */
> @@ -1273,7 +1276,7 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_cig(struct hci_dev *hdev,
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D ISO_LINK || !bacmp(&c->dst, BDADDR_ANY))
> +               if (c->type !=3D ISO_LINK_UCAST)
>                         continue;
>
>                 if (handle =3D=3D c->iso_qos.ucast.cig) {
> @@ -1296,17 +1299,7 @@ static inline struct hci_conn *hci_conn_hash_looku=
p_big(struct hci_dev *hdev,
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D ISO_LINK)
> -                       continue;
> -
> -               /* An ISO_LINK hcon with BDADDR_ANY as destination
> -                * address is a Broadcast connection. A Broadcast
> -                * slave connection is associated with a PA train,
> -                * so the sync_handle can be used to differentiate
> -                * from unicast.
> -                */
> -               if (bacmp(&c->dst, BDADDR_ANY) &&
> -                   c->sync_handle =3D=3D HCI_SYNC_HANDLE_INVALID)
> +               if (c->type !=3D ISO_LINK_BCAST)
>                         continue;
>
>                 if (handle =3D=3D c->iso_qos.bcast.big) {
> @@ -1330,7 +1323,7 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *=
hdev,
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D ISO_LINK)
> +               if (c->type !=3D ISO_LINK_BCAST)
>                         continue;
>
>                 if (handle =3D=3D c->iso_qos.bcast.big && num_bis =3D=3D =
c->num_bis) {
> @@ -1353,8 +1346,8 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev=
, __u8 handle,  __u16 state)
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (bacmp(&c->dst, BDADDR_ANY) || c->type !=3D ISO_LINK |=
|
> -                       c->state !=3D state)
> +               if (c->type !=3D ISO_LINK_BCAST || bacmp(&c->dst, BDADDR_=
ANY) ||
> +                   c->state !=3D state)
>                         continue;
>
>                 if (handle =3D=3D c->iso_qos.bcast.big) {
> @@ -1377,8 +1370,8 @@ hci_conn_hash_lookup_pa_sync_big_handle(struct hci_=
dev *hdev, __u8 big)
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D ISO_LINK ||
> -                       !test_bit(HCI_CONN_PA_SYNC, &c->flags))
> +               if (c->type !=3D ISO_LINK_BCAST ||
> +                   !test_bit(HCI_CONN_PA_SYNC, &c->flags))
>                         continue;
>
>                 if (c->iso_qos.bcast.big =3D=3D big) {
> @@ -1400,7 +1393,7 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev =
*hdev, __u16 sync_handle)
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D ISO_LINK)
> +               if (c->type !=3D ISO_LINK_BCAST)
>                         continue;
>
>                 /* Ignore the listen hcon, we are looking
> @@ -2014,7 +2007,8 @@ static inline int hci_proto_connect_ind(struct hci_=
dev *hdev, bdaddr_t *bdaddr,
>         case ESCO_LINK:
>                 return sco_connect_ind(hdev, bdaddr, flags);
>
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>                 return iso_connect_ind(hdev, bdaddr, flags);
>
>         default:
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d8f6aaf14703..ba56d5212cec 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -785,7 +785,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev,=
 u8 big, struct hci_conn *c
>         d->sync_handle =3D conn->sync_handle;
>
>         if (test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags)) {
> -               hci_conn_hash_list_flag(hdev, find_bis, ISO_LINK,
> +               hci_conn_hash_list_flag(hdev, find_bis, ISO_LINK_BCAST,
>                                         HCI_CONN_PA_SYNC, d);
>
>                 if (!d->count)
> @@ -795,7 +795,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev,=
 u8 big, struct hci_conn *c
>         }
>
>         if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
> -               hci_conn_hash_list_flag(hdev, find_bis, ISO_LINK,
> +               hci_conn_hash_list_flag(hdev, find_bis, ISO_LINK_BCAST,
>                                         HCI_CONN_BIG_SYNC, d);
>
>                 if (!d->count)
> @@ -885,9 +885,11 @@ static void cis_cleanup(struct hci_conn *conn)
>         /* Check if ISO connection is a CIS and remove CIG if there are
>          * no other connections using it.
>          */
> -       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_BOUND, &d);
> -       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_CONNECT, &d=
);
> -       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_CONNECTED, =
&d);
> +       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK_UCAST, BT_BOUND=
, &d);
> +       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK_UCAST, BT_CONNE=
CT,
> +                                &d);
> +       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK_UCAST, BT_CONNE=
CTED,
> +                                &d);
>         if (d.count)
>                 return;
>
> @@ -910,7 +912,8 @@ static struct hci_conn *__hci_conn_add(struct hci_dev=
 *hdev, int type, bdaddr_t
>                 if (!hdev->acl_mtu)
>                         return ERR_PTR(-ECONNREFUSED);
>                 break;
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>                 if (hdev->iso_mtu)
>                         /* Dedicated ISO Buffer exists */
>                         break;
> @@ -974,7 +977,8 @@ static struct hci_conn *__hci_conn_add(struct hci_dev=
 *hdev, int type, bdaddr_t
>                 hci_copy_identity_address(hdev, &conn->src, &conn->src_ty=
pe);
>                 conn->mtu =3D hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu=
;
>                 break;
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>                 /* conn->src should reflect the local identity address */
>                 hci_copy_identity_address(hdev, &conn->src, &conn->src_ty=
pe);
>
> @@ -1071,7 +1075,8 @@ static void hci_conn_cleanup_child(struct hci_conn =
*conn, u8 reason)
>                 if (HCI_CONN_HANDLE_UNSET(conn->handle))
>                         hci_conn_failed(conn, reason);
>                 break;
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>                 if ((conn->state !=3D BT_CONNECTED &&
>                     !test_bit(HCI_CONN_CREATE_CIS, &conn->flags)) ||
>                     test_bit(HCI_CONN_BIG_CREATED, &conn->flags))
> @@ -1146,7 +1151,8 @@ void hci_conn_del(struct hci_conn *conn)
>                         hdev->acl_cnt +=3D conn->sent;
>         } else {
>                 /* Unacked ISO frames */
> -               if (conn->type =3D=3D ISO_LINK) {
> +               if (conn->type =3D=3D ISO_LINK_UCAST ||
> +                   conn->type =3D=3D ISO_LINK_BCAST) {
>                         if (hdev->iso_pkts)
>                                 hdev->iso_cnt +=3D conn->sent;
>                         else if (hdev->le_pkts)
> @@ -1532,7 +1538,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev =
*hdev, bdaddr_t *dst,
>                      memcmp(conn->le_per_adv_data, base, base_len)))
>                 return ERR_PTR(-EADDRINUSE);
>
> -       conn =3D hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_MASTER)=
;
> +       conn =3D hci_conn_add_unset(hdev, ISO_LINK_BCAST, dst, HCI_ROLE_M=
ASTER);
>         if (IS_ERR(conn))
>                 return conn;
>
> @@ -1740,7 +1746,7 @@ static int hci_le_create_big(struct hci_conn *conn,=
 struct bt_iso_qos *qos)
>         data.count =3D 0;
>
>         /* Create a BIS for each bound connection */
> -       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK,
> +       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK_BCAST,
>                                  BT_BOUND, &data);
>
>         cp.handle =3D qos->bcast.big;
> @@ -1829,12 +1835,12 @@ static bool hci_le_set_cig_params(struct hci_conn=
 *conn, struct bt_iso_qos *qos)
>                 for (data.cig =3D 0x00; data.cig < 0xf0; data.cig++) {
>                         data.count =3D 0;
>
> -                       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK=
,
> +                       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK=
_UCAST,
>                                                  BT_CONNECT, &data);
>                         if (data.count)
>                                 continue;
>
> -                       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK=
,
> +                       hci_conn_hash_list_state(hdev, find_cis, ISO_LINK=
_UCAST,
>                                                  BT_CONNECTED, &data);
>                         if (!data.count)
>                                 break;
> @@ -1884,7 +1890,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev,=
 bdaddr_t *dst,
>         cis =3D hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.=
cig,
>                                        qos->ucast.cis);
>         if (!cis) {
> -               cis =3D hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_=
MASTER);
> +               cis =3D hci_conn_add_unset(hdev, ISO_LINK_UCAST, dst,
> +                                        HCI_ROLE_MASTER);
>                 if (IS_ERR(cis))
>                         return cis;
>                 cis->cleanup =3D cis_cleanup;
> @@ -1976,7 +1983,7 @@ bool hci_iso_setup_path(struct hci_conn *conn)
>
>  int hci_conn_check_create_cis(struct hci_conn *conn)
>  {
> -       if (conn->type !=3D ISO_LINK || !bacmp(&conn->dst, BDADDR_ANY))
> +       if (conn->type !=3D ISO_LINK_UCAST)
>                 return -EINVAL;
>
>         if (!conn->parent || conn->parent->state !=3D BT_CONNECTED ||
> @@ -2072,7 +2079,7 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev =
*hdev, bdaddr_t *dst,
>
>         bt_dev_dbg(hdev, "dst %pMR type %d sid %d", dst, dst_type, sid);
>
> -       conn =3D hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_SLAVE);
> +       conn =3D hci_conn_add_unset(hdev, ISO_LINK_BCAST, dst, HCI_ROLE_S=
LAVE);
>         if (IS_ERR(conn))
>                 return conn;
>
> @@ -2221,7 +2228,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hd=
ev, bdaddr_t *dst,
>          * the start periodic advertising and create BIG commands have
>          * been queued
>          */
> -       hci_conn_hash_list_state(hdev, bis_mark_per_adv, ISO_LINK,
> +       hci_conn_hash_list_state(hdev, bis_mark_per_adv, ISO_LINK_BCAST,
>                                  BT_BOUND, &data);
>
>         /* Queue start periodic advertising and create BIG */
> @@ -2953,7 +2960,8 @@ void hci_conn_tx_queue(struct hci_conn *conn, struc=
t sk_buff *skb)
>          * TODO: SCO support without flowctl (needs to be done in drivers=
)
>          */
>         switch (conn->type) {
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>         case ACL_LINK:
>         case LE_LINK:
>                 break;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a58fd3bf8851..0c4b07115563 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2898,12 +2898,13 @@ int hci_recv_frame(struct hci_dev *hdev, struct s=
k_buff *skb)
>                 break;
>         case HCI_ACLDATA_PKT:
>                 /* Detect if ISO packet has been sent as ACL */
> -               if (hci_conn_num(hdev, ISO_LINK)) {
> +               if (hci_conn_num(hdev, ISO_LINK_UCAST) ||
> +                   hci_conn_num(hdev, ISO_LINK_BCAST)) {
>                         __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->=
handle);
>                         __u8 type;
>
>                         type =3D hci_conn_lookup_type(hdev, hci_handle(ha=
ndle));
> -                       if (type =3D=3D ISO_LINK)
> +                       if (type =3D=3D ISO_LINK_UCAST || type =3D=3D ISO=
_LINK_BCAST)
>                                 hci_skb_pkt_type(skb) =3D HCI_ISODATA_PKT=
;
>                 }
>                 break;
> @@ -3356,7 +3357,8 @@ static inline void hci_quote_sent(struct hci_conn *=
conn, int num, int *quote)
>         case LE_LINK:
>                 cnt =3D hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
>                 break;
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>                 cnt =3D hdev->iso_mtu ? hdev->iso_cnt :
>                         hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
>                 break;
> @@ -3370,7 +3372,7 @@ static inline void hci_quote_sent(struct hci_conn *=
conn, int num, int *quote)
>  }
>
>  static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
> -                                    int *quote)
> +                                    __u8 type2, int *quote)
>  {
>         struct hci_conn_hash *h =3D &hdev->conn_hash;
>         struct hci_conn *conn =3D NULL, *c;
> @@ -3382,7 +3384,8 @@ static struct hci_conn *hci_low_sent(struct hci_dev=
 *hdev, __u8 type,
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D type || skb_queue_empty(&c->data_q))
> +               if ((c->type !=3D type && c->type !=3D type2) ||
> +                   skb_queue_empty(&c->data_q))
>                         continue;
>
>                 if (c->state !=3D BT_CONNECTED && c->state !=3D BT_CONFIG=
)
> @@ -3590,7 +3593,7 @@ static void hci_sched_sco(struct hci_dev *hdev, __u=
8 type)
>         else
>                 cnt =3D &hdev->sco_cnt;
>
> -       while (*cnt && (conn =3D hci_low_sent(hdev, type, &quote))) {
> +       while (*cnt && (conn =3D hci_low_sent(hdev, type, type, &quote)))=
 {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
>                         hci_send_conn_frame(hdev, conn, skb);
> @@ -3718,12 +3721,14 @@ static void hci_sched_iso(struct hci_dev *hdev)
>
>         BT_DBG("%s", hdev->name);
>
> -       if (!hci_conn_num(hdev, ISO_LINK))
> +       if (!hci_conn_num(hdev, ISO_LINK_UCAST) &&
> +           !hci_conn_num(hdev, ISO_LINK_BCAST))
>                 return;
>
>         cnt =3D hdev->iso_pkts ? &hdev->iso_cnt :
>                 hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
> -       while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote))) {
> +       while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK_UCAST,
> +                                           ISO_LINK_BCAST, &quote))) {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
>                         hci_send_conn_frame(hdev, conn, skb);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 105d1446c9dc..6ecf36afaae0 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3793,7 +3793,7 @@ static void hci_unbound_cis_failed(struct hci_dev *=
hdev, u8 cig, u8 status)
>         lockdep_assert_held(&hdev->lock);
>
>         list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) =
{
> -               if (conn->type !=3D ISO_LINK || !bacmp(&conn->dst, BDADDR=
_ANY) ||
> +               if (conn->type !=3D ISO_LINK_UCAST ||
>                     conn->state =3D=3D BT_OPEN || conn->iso_qos.ucast.cig=
 !=3D cig)
>                         continue;
>
> @@ -4456,7 +4456,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *h=
dev, void *data,
>
>                         break;
>
> -               case ISO_LINK:
> +               case ISO_LINK_UCAST:
> +               case ISO_LINK_BCAST:
>                         if (hdev->iso_pkts) {
>                                 hdev->iso_cnt +=3D count;
>                                 if (hdev->iso_cnt > hdev->iso_pkts)
> @@ -6402,7 +6403,8 @@ static void hci_le_pa_sync_estabilished_evt(struct =
hci_dev *hdev, void *data,
>         conn->sync_handle =3D le16_to_cpu(ev->handle);
>         conn->sid =3D HCI_SID_INVALID;
>
> -       mask |=3D hci_proto_connect_ind(hdev, &ev->bdaddr, ISO_LINK, &fla=
gs);
> +       mask |=3D hci_proto_connect_ind(hdev, &ev->bdaddr, ISO_LINK_BCAST=
,
> +                                     &flags);
>         if (!(mask & HCI_LM_ACCEPT)) {
>                 hci_le_pa_term_sync(hdev, ev->handle);
>                 goto unlock;
> @@ -6412,7 +6414,7 @@ static void hci_le_pa_sync_estabilished_evt(struct =
hci_dev *hdev, void *data,
>                 goto unlock;
>
>         /* Add connection to indicate PA sync event */
> -       pa_sync =3D hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
> +       pa_sync =3D hci_conn_add_unset(hdev, ISO_LINK_BCAST, BDADDR_ANY,
>                                      HCI_ROLE_SLAVE);
>
>         if (IS_ERR(pa_sync))
> @@ -6443,7 +6445,7 @@ static void hci_le_per_adv_report_evt(struct hci_de=
v *hdev, void *data,
>
>         hci_dev_lock(hdev);
>
> -       mask |=3D hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flag=
s);
> +       mask |=3D hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK_BCAST,=
 &flags);
>         if (!(mask & HCI_LM_ACCEPT))
>                 goto unlock;
>
> @@ -6727,7 +6729,7 @@ static void hci_le_cis_estabilished_evt(struct hci_=
dev *hdev, void *data,
>                 goto unlock;
>         }
>
> -       if (conn->type !=3D ISO_LINK) {
> +       if (conn->type !=3D ISO_LINK_UCAST) {
>                 bt_dev_err(hdev,
>                            "Invalid connection link type handle 0x%4.4x",
>                            handle);
> @@ -6845,7 +6847,7 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev=
, void *data,
>         if (!acl)
>                 goto unlock;
>
> -       mask =3D hci_proto_connect_ind(hdev, &acl->dst, ISO_LINK, &flags)=
;
> +       mask =3D hci_proto_connect_ind(hdev, &acl->dst, ISO_LINK_UCAST, &=
flags);
>         if (!(mask & HCI_LM_ACCEPT)) {
>                 hci_le_reject_cis(hdev, ev->cis_handle);
>                 goto unlock;
> @@ -6853,8 +6855,8 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev=
, void *data,
>
>         cis =3D hci_conn_hash_lookup_handle(hdev, cis_handle);
>         if (!cis) {
> -               cis =3D hci_conn_add(hdev, ISO_LINK, &acl->dst, HCI_ROLE_=
SLAVE,
> -                                  cis_handle);
> +               cis =3D hci_conn_add(hdev, ISO_LINK_UCAST, &acl->dst,
> +                                  HCI_ROLE_SLAVE, cis_handle);
>                 if (IS_ERR(cis)) {
>                         hci_le_reject_cis(hdev, ev->cis_handle);
>                         goto unlock;
> @@ -6969,7 +6971,7 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>                                 bt_dev_dbg(hdev, "ignore too large handle=
 %u", handle);
>                                 continue;
>                         }
> -                       bis =3D hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
> +                       bis =3D hci_conn_add(hdev, ISO_LINK_BCAST, BDADDR=
_ANY,
>                                            HCI_ROLE_SLAVE, handle);
>                         if (IS_ERR(bis))
>                                 continue;
> @@ -7025,7 +7027,7 @@ static void hci_le_big_info_adv_report_evt(struct h=
ci_dev *hdev, void *data,
>
>         hci_dev_lock(hdev);
>
> -       mask |=3D hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flag=
s);
> +       mask |=3D hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK_BCAST,=
 &flags);
>         if (!(mask & HCI_LM_ACCEPT))
>                 goto unlock;
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d00ff18f3be0..5f37335140a9 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2860,7 +2860,7 @@ static int hci_le_set_ext_scan_param_sync(struct hc=
i_dev *hdev, u8 type,
>                 if (sent) {
>                         struct hci_conn *conn;
>
> -                       conn =3D hci_conn_hash_lookup_ba(hdev, ISO_LINK,
> +                       conn =3D hci_conn_hash_lookup_ba(hdev, ISO_LINK_B=
CAST,
>                                                        &sent->bdaddr);
>                         if (conn) {
>                                 struct bt_iso_qos *qos =3D &conn->iso_qos=
;
> @@ -5477,7 +5477,7 @@ static int hci_connect_cancel_sync(struct hci_dev *=
hdev, struct hci_conn *conn,
>         if (conn->type =3D=3D LE_LINK)
>                 return hci_le_connect_cancel_sync(hdev, conn, reason);
>
> -       if (conn->type =3D=3D ISO_LINK) {
> +       if (conn->type =3D=3D ISO_LINK_UCAST) {
>                 /* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part=
 E
>                  * page 1857:
>                  *
> @@ -5490,9 +5490,10 @@ static int hci_connect_cancel_sync(struct hci_dev =
*hdev, struct hci_conn *conn,
>                         return hci_disconnect_sync(hdev, conn, reason);
>
>                 /* CIS with no Create CIS sent have nothing to cancel */
> -               if (bacmp(&conn->dst, BDADDR_ANY))
> -                       return HCI_ERROR_LOCAL_HOST_TERM;
> +               return HCI_ERROR_LOCAL_HOST_TERM;
> +       }
>
> +       if (conn->type =3D=3D ISO_LINK_BCAST) {
>                 /* There is no way to cancel a BIS without terminating th=
e BIG
>                  * which is done later on connection cleanup.
>                  */
> @@ -5554,9 +5555,12 @@ static int hci_reject_conn_sync(struct hci_dev *hd=
ev, struct hci_conn *conn,
>  {
>         struct hci_cp_reject_conn_req cp;
>
> -       if (conn->type =3D=3D ISO_LINK)
> +       if (conn->type =3D=3D ISO_LINK_UCAST)
>                 return hci_le_reject_cis_sync(hdev, conn, reason);
>
> +       if (conn->type =3D=3D ISO_LINK_BCAST)
> +               return -EINVAL;
> +
>         if (conn->type =3D=3D SCO_LINK || conn->type =3D=3D ESCO_LINK)
>                 return hci_reject_sco_sync(hdev, conn, reason);
>
> @@ -6917,7 +6921,7 @@ static void create_pa_complete(struct hci_dev *hdev=
, void *data, int err)
>                 goto unlock;
>
>         /* Add connection to indicate PA sync error */
> -       pa_sync =3D hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
> +       pa_sync =3D hci_conn_add_unset(hdev, ISO_LINK_BCAST, BDADDR_ANY,
>                                      HCI_ROLE_SLAVE);
>
>         if (IS_ERR(pa_sync))
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 2f348f48e99d..608c8bf72128 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2219,7 +2219,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>
>  static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
>  {
> -       if (hcon->type !=3D ISO_LINK) {
> +       if (hcon->type !=3D ISO_LINK_UCAST && hcon->type !=3D ISO_LINK_BC=
AST) {
>                 if (hcon->type !=3D LE_LINK)
>                         return;
>
> @@ -2260,7 +2260,7 @@ static void iso_connect_cfm(struct hci_conn *hcon, =
__u8 status)
>
>  static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>  {
> -       if (hcon->type !=3D ISO_LINK)
> +       if (hcon->type !=3D ISO_LINK_UCAST && hcon->type !=3D ISO_LINK_BC=
AST)
>                 return;
>
>         BT_DBG("hcon %p reason %d", hcon, reason);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 46b22708dfbd..26700394349c 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3221,7 +3221,8 @@ static int disconnect(struct sock *sk, struct hci_d=
ev *hdev, void *data,
>  static u8 link_to_bdaddr(u8 link_type, u8 addr_type)
>  {
>         switch (link_type) {
> -       case ISO_LINK:
> +       case ISO_LINK_UCAST:
> +       case ISO_LINK_BCAST:
>         case LE_LINK:
>                 switch (addr_type) {
>                 case ADDR_LE_DEV_PUBLIC:
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
