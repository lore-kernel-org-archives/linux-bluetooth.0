Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4081EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 18:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjF2S62 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjF2S61 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 14:58:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA651B1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 11:58:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69ff54321so16563241fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688065103; x=1690657103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayD11+dsKr71I70NW0Cdklptxcu4U+hGfifGk1UNOuM=;
        b=BWStNn43MyacWvHA2s9etHhSv5lnxJ7Dn/2aUwK1jGZSoJlBU8obcnL7Kb3Uiz7ra+
         0Ydm9lXHHW3A7tSIrrP9c4UzFhpdnhdqDGUwG4wpWLOmunBZCiJSh0lPSpJHGwv6KFKM
         rhE+EMYe2vo7rJ8ObAVZoE1mOuxjzGOXhsDKHv1CutVkpZ+fMPLmrLcClSiJDHM9sLL9
         gAp7rU/Stbw1lW5OTCYafOljh3NRSiPHZKe1yum/fMG5Qu8fKozf2rp0eWXIPbQvKOm2
         y6S9lv6OYZ4bCdsBQ3svEdty5p1vKYXlo+dnunXjPQAa3CbGAj1pCJBof8reQrVCNn8Z
         B1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065103; x=1690657103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayD11+dsKr71I70NW0Cdklptxcu4U+hGfifGk1UNOuM=;
        b=Y9+sPjYHxgMRutsYebauLBe7SZixeJcZIvJfA6hsB+hEdlN+nH9aLUwVasOXvJsPTB
         rziPHinNsAB20xz/gZ8lKZA/WrK6XhBhYETT5EDvd5Bj8OWmQBRmPqB+9zXCEbHfwE2u
         OJ5vdSipn3zc+l+PNsnSzJFdkjDSY3eoGIdtNM0lGccbCvRmsfbg3aVIIXKrD41JAd1M
         VU0b8Iv6YFUs8W4waL6Q70d1kpoDBuG9aGcCoZ/+6pE6NKXnR1SDIuMP7pf809aXajMx
         G9UgQFVB3kPmAyTHe3/lE8Fr+Hloyg/3wHialkUbWB/0XjXEf5paPKXNQr5K1YR5Zx8M
         O1MQ==
X-Gm-Message-State: ABy/qLYf58z3L0fNaP0COKKenGEbt/XDLc4uY4Jov4M3/qgKUKn1ifRe
        48krQFRdh5lOm4xJNDN4l7INNt1tmMeT7tOa1wU1n/LVX5Q=
X-Google-Smtp-Source: APBJJlGMAz0dWQbSariWUKSIgB45S1ppg/znEeX6ZZ07W/UpSJyOdUSMnJR9Rf4s76sxup6n3CuRYZNbFuOy04VnayM=
X-Received: by 2002:a2e:2e05:0:b0:2b6:9b44:8d06 with SMTP id
 u5-20020a2e2e05000000b002b69b448d06mr471837lju.43.1688065103187; Thu, 29 Jun
 2023 11:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230628150232.239778-1-iulia.tanasescu@nxp.com> <20230628150232.239778-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230628150232.239778-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Jun 2023 11:58:11 -0700
Message-ID: <CABBYNZJY2Ht9b41dzGm1J0L+2XH=Jzf0a7hg50HsbTxrN4nDHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: ISO: Notify user space about failed bis connections
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Wed, Jun 28, 2023 at 8:06=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Some use cases require the user to be informed if BIG synchronization
> fails. This commit makes it so that even if the BIG sync established
> event arrives with error status, a new hconn is added for each BIS,
> and the iso layer is notified about the failed connections.
>
> Unsuccesful bis connections will be marked using the
> HCI_CONN_BIG_SYNC_FAILED flag. From the iso layer, the POLLERR event
> is triggered on the newly allocated bis sockets, before adding them
> to the accept list of the parent socket.
>
> From user space, a new fd for each failed bis connection will be
> obtained by calling accept. The user should check for the POLLERR
> event on the new socket, to determine if the connection was successful
> or not.
>
> The HCI_CONN_BIG_SYNC flag has been added to mark whether the BIG sync
> has been successfully established. This flag is checked at bis cleanup,
> so the HCI LE BIG Terminate Sync command is only issued if needed.
>
> The BT_SK_BIG_SYNC flag indicates if BIG create sync has been called
> for a listening socket, to avoid issuing the command everytime a BIGInfo
> advertising report is received.
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/hci_core.h | 25 ++++++++++++++++
>  net/bluetooth/hci_conn.c         | 50 +++++++++++++++++---------------
>  net/bluetooth/hci_event.c        | 21 +++++++++++---
>  net/bluetooth/iso.c              | 37 ++++++++++++++++-------
>  4 files changed, 95 insertions(+), 38 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 05a9b3ab3f56..f068a578ff59 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -978,6 +978,8 @@ enum {
>         HCI_CONN_PER_ADV,
>         HCI_CONN_BIG_CREATED,
>         HCI_CONN_CREATE_CIS,
> +       HCI_CONN_BIG_SYNC,
> +       HCI_CONN_BIG_SYNC_FAILED,
>  };
>
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> @@ -1288,6 +1290,29 @@ static inline struct hci_conn *hci_conn_hash_looku=
p_big(struct hci_dev *hdev,
>         return NULL;
>  }
>
> +static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct h=
ci_dev *hdev,
> +                                                       __u8 handle)
> +{
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       struct hci_conn  *c;
> +
> +       rcu_read_lock();
> +
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               if (c->type !=3D ISO_LINK)
> +                       continue;
> +
> +               if (handle =3D=3D c->iso_qos.bcast.big) {
> +                       rcu_read_unlock();
> +                       return c;
> +               }
> +       }
> +
> +       rcu_read_unlock();
> +
> +       return NULL;
> +}
> +
>  static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev=
 *hdev,
>                                                         __u8 type, __u16 =
state)
>  {
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 47e7aa4d63a9..491ca8e876f0 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -686,6 +686,19 @@ static void hci_conn_timeout(struct work_struct *wor=
k)
>                 return;
>         }
>
> +       /* Cleanup bises that failed to be established */
> +       if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags)) {
> +               conn->state =3D BT_CLOSED;
> +               hci_disconn_cfm(conn, hci_proto_disconn_ind(conn));
> +               hci_conn_hash_del(conn->hdev, conn);
> +
> +               if (conn->cleanup)
> +                       conn->cleanup(conn);
> +
> +               hci_conn_put(conn);
> +               return;
> +       }

I will be pushing some changes to how hci_abort_conn works, the code
above shall probably be done inside the likes of hci_conn_failed
though but first we need to add support for BIS into
hci_abort_conn_sync.

>         hci_abort_conn(conn, hci_proto_disconn_ind(conn));
>  }
>
> @@ -793,6 +806,7 @@ struct iso_list_data {
>         int count;
>         struct iso_cig_params pdu;
>         bool big_term;
> +       bool big_sync_term;
>  };
>
>  static void bis_list(struct hci_conn *conn, void *data)
> @@ -810,17 +824,6 @@ static void bis_list(struct hci_conn *conn, void *da=
ta)
>         d->count++;
>  }
>
> -static void find_bis(struct hci_conn *conn, void *data)
> -{
> -       struct iso_list_data *d =3D data;
> -
> -       /* Ignore unicast */
> -       if (bacmp(&conn->dst, BDADDR_ANY))
> -               return;
> -
> -       d->count++;
> -}
> -
>  static int terminate_big_sync(struct hci_dev *hdev, void *data)
>  {
>         struct iso_list_data *d =3D data;
> @@ -873,31 +876,26 @@ static int big_terminate_sync(struct hci_dev *hdev,=
 void *data)
>         bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", d->big,
>                    d->sync_handle);
>
> -       /* Check if ISO connection is a BIS and terminate BIG if there ar=
e
> -        * no other connections using it.
> -        */
> -       hci_conn_hash_list_state(hdev, find_bis, ISO_LINK, BT_CONNECTED, =
d);
> -       if (d->count)
> -               return 0;
> -
> -       hci_le_big_terminate_sync(hdev, d->big);
> +       if (d->big_sync_term)
> +               hci_le_big_terminate_sync(hdev, d->big);
>
>         return hci_le_pa_terminate_sync(hdev, d->sync_handle);
>  }
>
> -static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16 sync_h=
andle)
> +static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci=
_conn *conn)
>  {
>         struct iso_list_data *d;
>         int ret;
>
> -       bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, sync_han=
dle);
> +       bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, conn->sy=
nc_handle);
>
>         d =3D kzalloc(sizeof(*d), GFP_KERNEL);
>         if (!d)
>                 return -ENOMEM;
>
>         d->big =3D big;
> -       d->sync_handle =3D sync_handle;
> +       d->sync_handle =3D conn->sync_handle;
> +       d->big_sync_term =3D test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn-=
>flags);
>
>         ret =3D hci_cmd_sync_queue(hdev, big_terminate_sync, d,
>                                  terminate_big_destroy);
> @@ -933,8 +931,14 @@ static void bis_cleanup(struct hci_conn *conn)
>
>                 hci_le_terminate_big(hdev, conn);
>         } else {
> +               bis =3D hci_conn_hash_lookup_big_any_dst(hdev,
> +                                                      conn->iso_qos.bcas=
t.big);
> +
> +               if (bis)
> +                       return;
> +
>                 hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
> -                                    conn->sync_handle);
> +                                    conn);
>         }
>  }
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 77cbf13037b3..30d0a6631e17 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7039,9 +7039,6 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>                                 flex_array_size(ev, bis, ev->num_bis)))
>                 return;
>
> -       if (ev->status)
> -               return;
> -
>         hci_dev_lock(hdev);
>
>         for (i =3D 0; i < ev->num_bis; i++) {
> @@ -7065,9 +7062,25 @@ static void hci_le_big_sync_established_evt(struct=
 hci_dev *hdev, void *data,
>                 bis->iso_qos.bcast.in.latency =3D le16_to_cpu(ev->interva=
l) * 125 / 100;
>                 bis->iso_qos.bcast.in.sdu =3D le16_to_cpu(ev->max_pdu);
>
> -               hci_iso_setup_path(bis);
> +               if (!ev->status) {
> +                       set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> +                       hci_iso_setup_path(bis);
> +               }
>         }
>
> +       /* In case BIG sync failed, notify each failed connection to
> +        * the user after all hci connections have been added
> +        */
> +       if (ev->status)
> +               for (i =3D 0; i < ev->num_bis; i++) {
> +                       u16 handle =3D le16_to_cpu(ev->bis[i]);
> +
> +                       bis =3D hci_conn_hash_lookup_handle(hdev, handle)=
;
> +
> +                       set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags);
> +                       hci_connect_cfm(bis, ev->status);
> +               }
> +
>         hci_dev_unlock(hdev);
>  }
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 84d238d0639a..e0386b12ea4e 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -48,6 +48,11 @@ static void iso_sock_kill(struct sock *sk);
>  #define EIR_SERVICE_DATA_LENGTH 4
>  #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH=
)
>
> +/* iso_pinfo flags values */
> +enum {
> +       BT_SK_BIG_SYNC,
> +};
> +
>  struct iso_pinfo {
>         struct bt_sock          bt;
>         bdaddr_t                src;
> @@ -58,7 +63,7 @@ struct iso_pinfo {
>         __u8                    bc_num_bis;
>         __u8                    bc_bis[ISO_MAX_NUM_BIS];
>         __u16                   sync_handle;
> -       __u32                   flags;
> +       unsigned long           flags;
>         struct bt_iso_qos       qos;
>         bool                    qos_user_set;
>         __u8                    base_len;
> @@ -1569,6 +1574,12 @@ static void iso_conn_ready(struct iso_conn *conn)
>                 hci_conn_hold(hcon);
>                 iso_chan_add(conn, sk, parent);
>
> +               if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)=
->status) {
> +                       /* Trigger error signal on child socket */
> +                       sk->sk_err =3D ECONNREFUSED;
> +                       sk->sk_error_report(sk);
> +               }
> +
>                 if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
>                         sk->sk_state =3D BT_CONNECT2;
>                 else
> @@ -1637,15 +1648,19 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_=
t *bdaddr, __u8 *flags)
>                         if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
>                                 iso_pi(sk)->bc_num_bis =3D ev2->num_bis;
>
> -                       err =3D hci_le_big_create_sync(hdev,
> -                                                    &iso_pi(sk)->qos,
> -                                                    iso_pi(sk)->sync_han=
dle,
> -                                                    iso_pi(sk)->bc_num_b=
is,
> -                                                    iso_pi(sk)->bc_bis);
> -                       if (err) {
> -                               bt_dev_err(hdev, "hci_le_big_create_sync:=
 %d",
> -                                          err);
> -                               sk =3D NULL;
> +                       if (!test_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)=
) {
> +                               set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flag=
s);

You can probably use test_and_set_bit instead above.

> +
> +                               err =3D hci_le_big_create_sync(hdev,
> +                                                            &iso_pi(sk)-=
>qos,
> +                                                            iso_pi(sk)->=
sync_handle,
> +                                                            iso_pi(sk)->=
bc_num_bis,
> +                                                            iso_pi(sk)->=
bc_bis);
> +                               if (err) {
> +                                       bt_dev_err(hdev, "hci_le_big_crea=
te_sync: %d",
> +                                                  err);
> +                                       sk =3D NULL;
> +                               }
>                         }
>                 }
>         } else {
> @@ -1688,7 +1703,7 @@ static void iso_connect_cfm(struct hci_conn *hcon, =
__u8 status)
>
>         BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status)=
;
>
> -       if (!status) {
> +       if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) =
{

Shouldn't it be !test_bit above?

>                 struct iso_conn *conn;
>
>                 conn =3D iso_conn_add(hcon);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
