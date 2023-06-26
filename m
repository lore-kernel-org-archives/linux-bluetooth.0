Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503DAEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFZTuz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZTuy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 15:50:54 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74122DC
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 12:50:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso26111901fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687809050; x=1690401050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLNU8vglhxSW0Yp8DajldsDaNQcJhRVHcG3K5ySBXmo=;
        b=dksK8EGWHygIOx2AYdqKWjzvMzNuhKnN23KpLbd2RENTJppCtWo1rrJ2JSdqVwcCSU
         +1llckfeynBgzD1fTbIR0MW5CdZ2Xp2+FJAetyRe09szcSqOD/29Kpccm6e2BN+69xnE
         6I0QQS1ZOo7Ehupq432MQ427UgdhrsiunbQ2rZ1NQrPTiKXGhioZH0Loi4R6Ugun/z05
         FLWkkq2x0pHdHf5lUzTdi26ZNWaBRT7Ml6jwdUk81HuenB7fhHdSb3OSZymbm01Bktgd
         OJw8u3pdBVmVEVU/Gtc2ME2F5njJ7yxjE5RPWbYJyYKP0QkfZUgmyjkSIH1VZV6uDiIS
         Iz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687809050; x=1690401050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLNU8vglhxSW0Yp8DajldsDaNQcJhRVHcG3K5ySBXmo=;
        b=LGcQmx1qJvCkDpj3D2wtnkEDehTh725LSbyOzHgaaIo3klJX3ogrkIU3CWtf0ZxvdG
         q36HfFcVaToTrMSsdAAmIUme65rri5vj4oSqgxoqx0gNE4/FMS5TMMrItOLPGzFdTTpQ
         2YX6CHUj2ViCqx5AjMiAxkk3G6Gb8CD+yH9hn9Z5bJHAuMnNWXYlYjY9GSfS6S87Dw7Z
         Oc36FwBOpVzHkPrd4J+Nml4UUlq4XPrO6kAtgghQI+i5Vh1MO9QZgcwqqj70WmxBqcdP
         Vck7dx97YWTJaw0LkoztzjasJ2//n6akEkVyD88TLWvnM3h0pILGslAN/okqW5206pO5
         SFAA==
X-Gm-Message-State: AC+VfDw+N3+nQaSHGc4Rk4pKHFuvraQywS4Dei0/kVrEusU18U2ja5D3
        sdKy35y5mrw0FiWZJaT/r+5svHWwKToDM9WKbjcvpkFRc9NIeA==
X-Google-Smtp-Source: ACHHUZ6sj6TJFiu/49NlyfT/iPuQm+e5t6/fiaOZVAUKK9ZqLg44lQwLNtj6Z+LvlBiA5IOnOIsnPVMRyIeybrb6AT4=
X-Received: by 2002:a05:651c:1031:b0:2b4:5b65:c914 with SMTP id
 w17-20020a05651c103100b002b45b65c914mr17284828ljm.24.1687809050325; Mon, 26
 Jun 2023 12:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230623073842.16466-1-iulia.tanasescu@nxp.com> <20230623073842.16466-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230623073842.16466-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Jun 2023 12:50:38 -0700
Message-ID: <CABBYNZLnfFHEHHuK3=p1a3=361A7YEcPcSmbjz8z+9bn4wWuyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Notify user space about failed bis connections
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

On Fri, Jun 23, 2023 at 12:43=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> Some use cases require the user to be informed if BIG synchronization
> fails. This commit makes it so that even if the BIG sync established
> event arrives with error status, a new hconn is added for each BIS,
> and the iso layer is notified about the failed connections.
>
> Unsuccesful bis connections will be marked using the BT_BIG_SYNC_FAILED
> state. From the iso layer, the POLLERR event is triggered on the newly
> allocated bis sockets, before adding them to the accept list of the
> parent socket.
>
> From user space, a new fd for each failed bis connection will be
> obtained by calling accept. The user should check for the POLLERR
> event on the new socket, to determine if the connection was successful
> or not.
>
> To ensure proper cleanup of the unsuccessful bises, the le_bis_cleanup
> work callback has been added, similar to le_scan_cleanup. The callback
> deletes the hci connection and notifies the disconnect to the iso layer,
> so the socket is also cleaned up.
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
>  include/net/bluetooth/bluetooth.h |  5 +-
>  include/net/bluetooth/hci_core.h  | 25 ++++++++++
>  net/bluetooth/hci_conn.c          | 78 +++++++++++++++++++++++++++++--
>  net/bluetooth/hci_event.c         | 21 +++++++--
>  net/bluetooth/iso.c               | 37 ++++++++++-----
>  5 files changed, 145 insertions(+), 21 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 34998ae8ed78..b05147cf4c57 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -292,7 +292,8 @@ enum {
>         BT_CONNECT2,
>         BT_CONFIG,
>         BT_DISCONN,
> -       BT_CLOSED
> +       BT_CLOSED,
> +       BT_BIG_SYNC_FAILED,

I would mess around with these states, they are generic for all sockets.

>  };
>
>  /* If unused will be removed by compiler */
> @@ -317,6 +318,8 @@ static inline const char *state_to_string(int state)
>                 return "BT_DISCONN";
>         case BT_CLOSED:
>                 return "BT_CLOSED";
> +       case BT_BIG_SYNC_FAILED:
> +               return "BT_BIG_SYNC_FAILED";
>         }
>
>         return "invalid state";
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 05a9b3ab3f56..81e83ecdd267 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -761,6 +761,7 @@ struct hci_conn {
>         struct delayed_work idle_work;
>         struct delayed_work le_conn_timeout;
>         struct work_struct  le_scan_cleanup;
> +       struct work_struct  le_bis_cleanup;

Also not a fan of adding yet another work, le_scan_cleanup already
have its own problems:

https://patchwork.kernel.org/project/bluetooth/patch/45455ee45ccb3313618a48=
c01be714e14d372257.1687525956.git.pav@iki.fi/

In fact Im not sure why we couldn't use conn->cleanup?

>
>         struct device   dev;
>         struct dentry   *debugfs;
> @@ -978,6 +979,7 @@ enum {
>         HCI_CONN_PER_ADV,
>         HCI_CONN_BIG_CREATED,
>         HCI_CONN_CREATE_CIS,
> +       HCI_CONN_BIG_SYNC,
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
> index 62a7ccfdfe63..e4aa7731b987 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -207,6 +207,36 @@ static void le_scan_cleanup(struct work_struct *work=
)
>         hci_conn_put(conn);
>  }
>
> +static void le_bis_cleanup(struct work_struct *work)
> +{
> +       struct hci_conn *conn =3D container_of(work, struct hci_conn,
> +                                            le_bis_cleanup);
> +       struct hci_dev *hdev =3D conn->hdev;
> +       struct hci_conn *c =3D NULL;
> +
> +       BT_DBG("%s hcon %p", hdev->name, conn);
> +
> +       hci_dev_lock(hdev);
> +
> +       /* Check that the hci_conn is still around */
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> +               if (c =3D=3D conn)
> +                       break;
> +       }
> +       rcu_read_unlock();
> +
> +       if (c =3D=3D conn) {
> +               conn->state =3D BT_CLOSED;
> +               hci_disconn_cfm(conn, hci_proto_disconn_ind(conn));
> +               hci_conn_del(conn);
> +       }
> +
> +       hci_dev_unlock(hdev);
> +       hci_dev_put(hdev);
> +       hci_conn_put(conn);
> +}
> +
>  static void hci_connect_le_scan_remove(struct hci_conn *conn)
>  {
>         BT_DBG("%s hcon %p", conn->hdev->name, conn);
> @@ -229,6 +259,28 @@ static void hci_connect_le_scan_remove(struct hci_co=
nn *conn)
>         schedule_work(&conn->le_scan_cleanup);
>  }
>
> +static void hci_bis_remove(struct hci_conn *conn)
> +{
> +       BT_DBG("%s hcon %p", conn->hdev->name, conn);
> +
> +       /* We can't call hci_conn_del/hci_conn_cleanup here since that
> +        * could deadlock with another hci_conn_del() call that's holding
> +        * hci_dev_lock and doing cancel_delayed_work_sync(&conn->disc_wo=
rk).
> +        * Instead, grab temporary extra references to the hci_dev and
> +        * hci_conn and perform the necessary cleanup in a separate work
> +        * callback.
> +        */
> +
> +       hci_dev_hold(conn->hdev);
> +       hci_conn_get(conn);
> +
> +       /* Even though we hold a reference to the hdev, many other
> +        * things might get cleaned up meanwhile, including the hdev's
> +        * own workqueue, so we can't use that for scheduling.
> +        */
> +       schedule_work(&conn->le_bis_cleanup);
> +}

This is a bad idea, we are already dealing with the same shortcomings
with respect to scan le, what we could probably do is to defer
queue_sync, but I'd wait until we find a proper solution to scan so we
apply here as well.

>  static void hci_acl_create_connection(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> @@ -686,6 +738,12 @@ static void hci_conn_timeout(struct work_struct *wor=
k)
>                 return;
>         }
>
> +       /* Cleanup bises that failed to be established */
> +       if (conn->state =3D=3D BT_BIG_SYNC_FAILED) {
> +               hci_bis_remove(conn);
> +               return;
> +       }
> +
>         hci_abort_conn(conn, hci_proto_disconn_ind(conn));
>  }
>
> @@ -793,6 +851,7 @@ struct iso_list_data {
>         int count;
>         struct iso_cig_params pdu;
>         bool big_term;
> +       bool big_sync_term;
>  };
>
>  static void bis_list(struct hci_conn *conn, void *data)
> @@ -880,24 +939,26 @@ static int big_terminate_sync(struct hci_dev *hdev,=
 void *data)
>         if (d->count)
>                 return 0;
>
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
> @@ -933,8 +994,14 @@ static void bis_cleanup(struct hci_conn *conn)
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
> @@ -1067,6 +1134,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev,=
 int type, bdaddr_t *dst,
>         INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
>         INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
>         INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
> +       INIT_WORK(&conn->le_bis_cleanup, le_bis_cleanup);
>
>         atomic_set(&conn->refcnt, 0);
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index b1aefe4bb751..5629a118ece4 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7020,9 +7020,6 @@ static void hci_le_big_sync_established_evt(struct =
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
> @@ -7046,9 +7043,25 @@ static void hci_le_big_sync_established_evt(struct=
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
> +                       bis->state =3D BT_BIG_SYNC_FAILED;
> +                       hci_connect_cfm(bis, ev->status);
> +               }
> +
>         hci_dev_unlock(hdev);
>  }
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 84d238d0639a..a2571d8ea055 100644
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
> +                       /* Trigger error signal on chilld socket */
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
> +       if (!status || hcon->state =3D=3D BT_BIG_SYNC_FAILED) {
>                 struct iso_conn *conn;
>
>                 conn =3D iso_conn_add(hcon);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
