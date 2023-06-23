Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F358EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 19:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFWTjj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWTji (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 15:39:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26D1FC6
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 12:39:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b477e9d396so16670121fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687549175; x=1690141175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL0iMsUuHbOkRMCHKeutDpYE72FzogH0Q4lnz4SZoNc=;
        b=swIz82gjx7izxD0QNCWJO7tdwQDkuFauiKsIF9kRmWrm2IP3ObLuAalRmSq709lndh
         2cp+q/WQeFXfWuOeO9BP8E9ep0exqySUm3sd8uTW9HOP0MGTNb5qVS6s+t3WilFqoNJp
         tQMgjyUevVG+t7pWn+VmfJ5kBfi9+TOoe+3OYl8lAkUn6/ZODUYVUiKQBkB3E8MLH89/
         +eXHsu6/z5U8nGCxgj5zeN+tzQIHtFm1S/MlGNvc54GrMLo3SAuNzFXUX5ReKCms8qWL
         MzzxXnGzUIM4sfwGYW/WM1ybuvRVld0CIQjpc2yLdqNLFELffeKZWvit+9lfL7xuGzHg
         fblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687549175; x=1690141175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL0iMsUuHbOkRMCHKeutDpYE72FzogH0Q4lnz4SZoNc=;
        b=hSg9vnUthahhG3vOS+AXDOlZSWyTY4uqIprf/AT+wYdq9HDPCj3h2KTY2yQf9Huxn/
         zp2ArjUfhQg2G8kaUYNGBu1dzrowUyxOgQaOd6BPk+trL7ftkeDiz3fe353rjoXcrNp6
         s4S2BqKrmdioBRac5PJE+t+CWCJhDvb1Cs+RP62eKEQhSOX3x4acv/kas+vM5PImCMCJ
         AWkLZO0sDYvkP+LYT94SiMpC5ASkGIHyCRiR+Uft+1x6OIyjDZKn1xLQIA5v7EMyhNYc
         R1gHih68AznDjfjVL0G2b+uS37bpoUVipGfjbH0FbAwGvJlwQklwN9enqGDaEaxpcAdg
         CvFQ==
X-Gm-Message-State: AC+VfDxQYwMBtqN05Ag0w+Zh9FJGH+KcQdhJ/QqUZLbkoVVp5ujQMA/M
        pqx6IGG381RL2wi1NtDR8QdxPl1JIDh5avXu9FWNU/l0XMU=
X-Google-Smtp-Source: ACHHUZ4SyN7HTG/v+j5w24L0mpG692V5FsWy7H/c1yv+jDPQJLZ97ezri14hGvFe0tFAbUwAt1LMpQHJkbrqJEclaq8=
X-Received: by 2002:a2e:9846:0:b0:2b4:737c:e316 with SMTP id
 e6-20020a2e9846000000b002b4737ce316mr13943309ljj.14.1687549174689; Fri, 23
 Jun 2023 12:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687525956.git.pav@iki.fi> <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
In-Reply-To: <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Jun 2023 12:39:22 -0700
Message-ID: <CABBYNZK_3aOVYgf6LiFXvkdGbju2UgU4WuEKRSrpuTdwv=BbFg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] Bluetooth: hci_conn: add hci_conn_is_alive
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Jun 23, 2023 at 10:37=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> A delayed operation such as hci_sync on a given hci_conn needs to take
> hci_conn_get, so that the hci_conn doesn't get freed in the meantime.
> This does not guarantee the conn is still alive in a valid state, as it
> may be cleaned up in the meantime, so one needs to check if it is still
> in conn_hash to know if it's still alive.
>
> Simplify this alive check, using HCI_CONN_DELETED flag. This is also
> meaningful with RCU lock only, but with slightly different semantics.
>
> If hci_conn_is_alive(conn) returns true inside rcu_read_lock, conn was
> in conn_hash from the point of view of the current task when the flag
> was read. Then its deletion cannot complete before rcu_read_unlock.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     This probably can be done with RCU primitives setting list.prev, but
>     that's maybe more magical...
>
>  include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
>  net/bluetooth/hci_conn.c         | 10 +---------
>  2 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 05a9b3ab3f56..cab39bdd0592 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -978,6 +978,7 @@ enum {
>         HCI_CONN_PER_ADV,
>         HCI_CONN_BIG_CREATED,
>         HCI_CONN_CREATE_CIS,
> +       HCI_CONN_DELETED,
>  };
>
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> @@ -997,6 +998,7 @@ static inline bool hci_conn_sc_enabled(struct hci_con=
n *conn)
>  static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_co=
nn *c)
>  {
>         struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       WARN_ON(test_bit(HCI_CONN_DELETED, &c->flags));
>         list_add_tail_rcu(&c->list, &h->list);
>         switch (c->type) {
>         case ACL_LINK:
> @@ -1023,6 +1025,10 @@ static inline void hci_conn_hash_add(struct hci_de=
v *hdev, struct hci_conn *c)
>  static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_co=
nn *c)
>  {
>         struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       bool deleted;
> +
> +       deleted =3D test_and_set_bit(HCI_CONN_DELETED, &c->flags);
> +       WARN_ON(deleted);
>
>         list_del_rcu(&c->list);
>         synchronize_rcu();
> @@ -1049,6 +1055,18 @@ static inline void hci_conn_hash_del(struct hci_de=
v *hdev, struct hci_conn *c)
>         }
>  }
>
> +/* With hdev->lock: whether hci_conn is in conn_hash.
> + * With RCU: if true, the hci_conn is valid conn_hash iteration cursor a=
nd
> + * hci_conn_hash_del has not completed. (Note that if hci_conn was obtai=
ned in
> + * this critical section it is always valid, but this may return false!)
> + */
> +static inline bool hci_conn_is_alive(struct hci_dev *hdev, struct hci_co=
nn *c)
> +{
> +       RCU_LOCKDEP_WARN(lockdep_is_held(&hdev->lock) || rcu_read_lock_he=
ld(),
> +                        "suspicious locking");
> +       return !test_bit(HCI_CONN_DELETED, &c->flags);
> +}

I think we are better off doing something like
hci_conn_hold_unless_zero like we do in l2cap_chan_hold_unless_zero,
that said we need to check if the hci_conn_drop can still set the ref
below zero, anyway that is probably a bug in itself and we should
probably WARN_ON if that happens.

>  static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
>  {
>         struct hci_conn_hash *h =3D &hdev->conn_hash;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 62a7ccfdfe63..d489a4829be7 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -183,21 +183,13 @@ static void le_scan_cleanup(struct work_struct *wor=
k)
>         struct hci_conn *conn =3D container_of(work, struct hci_conn,
>                                              le_scan_cleanup);
>         struct hci_dev *hdev =3D conn->hdev;
> -       struct hci_conn *c =3D NULL;
>
>         BT_DBG("%s hcon %p", hdev->name, conn);
>
>         hci_dev_lock(hdev);
>
>         /* Check that the hci_conn is still around */
> -       rcu_read_lock();
> -       list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> -               if (c =3D=3D conn)
> -                       break;
> -       }
> -       rcu_read_unlock();
> -
> -       if (c =3D=3D conn) {
> +       if (hci_conn_is_alive(hdev, conn)) {

Hmm, I don't think this is safe, except if we are doing hci_conn_get
we can't really access the conn pointer since it may be freed already,
anyway this is sort of broken already given that we do access
conn->hdev already.

>                 hci_connect_le_scan_cleanup(conn, 0x00);
>                 hci_conn_cleanup(conn);
>         }
> --
> 2.41.0
>


--=20
Luiz Augusto von Dentz
