Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C3BC77B7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjEQRzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEQRz1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 13:55:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D385213E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 10:55:24 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af12685274so3520351fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684346123; x=1686938123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O30n9ItK9tsEKlXdU5ByEy3UPYKjojKTlDhYnAkNP8=;
        b=DrmBU02w585D3Deso+sfhKwzg/I2EHpUqEt4Azbf3TnhIopAwZ8Z/USAwmZPUtXvpl
         jngyGXNSZDggF5ljMRATvCMsu2Ku8RRJvICi8Fm3coNiXJsFnH9wSTWmFxJ2B+MI5eIU
         mgzcpVBgN+PtUxettFZITfcNWcqWlnHY6fWpxr1g6fNOVTWS30uTkfoNSElXwRn5PwNC
         3QjB0xJXjiOcryiD4OxFDaTu7ZMX3x1qyp2GwxWXWBlJg0J+YlWhpu38qhsblHjAdMCe
         lDAi/VsdoFpDeIot02Zmt7ilSdI6Vb0HAyloa+kD0pkuZzxOJQunsGDGbYMBK4BhSR29
         70ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346123; x=1686938123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O30n9ItK9tsEKlXdU5ByEy3UPYKjojKTlDhYnAkNP8=;
        b=e4lJMvmb5YXAO55WmyH52HJaHpDp7ZI80N2fRgJt1CXwnqg92hk2tPnhN4HsfM/OAU
         DKbsiSTLKYIXVq+DT6/fyciTN5hP0pxHpX9yx9qQmRO4VHT1oa5VgrwCfaHsdh2l/tbh
         yXg1v8+1DZbp8TcAZA/99UCQx281s2+g5nsxTzYZgAUHZduYcY/STZzrjA7pyCAf4Mnl
         5eDj8vy7RsFkrboiaZT1Ff4rzJT3YG+T+KnL52cYV2vDNvJBpvzDz6gpngqH/Jeg9rnX
         WLF/E7oJwBP5PTViXtzupZOp0KgKye+Re710cQjq5V3PvA+xjjnqLRd2jmB+uIWPDK1P
         dlSw==
X-Gm-Message-State: AC+VfDxV7m4ObVL4YCet0MaqbKJTViRMjUsQtjL1iyNIhLg7Ft+ccfQL
        df0kxUmHbjUi2nIWBIGf8ks/0kVPu+v9X4bc3LVUxdrMIR8=
X-Google-Smtp-Source: ACHHUZ6b/De8hNe+UWxdRcIlCmUNj6o5cfGnMtwA0O2RSCyEPewZ3ulOYfar9fsfWY+zKUBbV2PW3aoRmgvudnC2O54=
X-Received: by 2002:a2e:9ad2:0:b0:2ac:667b:bb36 with SMTP id
 p18-20020a2e9ad2000000b002ac667bbb36mr12688004ljj.33.1684346122448; Wed, 17
 May 2023 10:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230517072706.5988-1-iulia.tanasescu@nxp.com> <20230517072706.5988-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230517072706.5988-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 May 2023 10:55:09 -0700
Message-ID: <CABBYNZ+mRgkn_PiL5=4NuQQudrQZQvdYqVuab3m_S7pRvj9YeQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: Add support for creating multiple BISes
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Wed, May 17, 2023 at 12:32=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> It is required for some configurations to have multiple BISes as part
> of the same BIG, which is now covered by iso-tester in the following test
> case:
>
>     ISO Broadcaster AC 13 - Success
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/bluetooth.h |   2 +
>  include/net/bluetooth/hci.h       |   7 ++
>  include/net/bluetooth/hci_core.h  |  32 ++++++-
>  include/net/bluetooth/iso.h       |  14 +++
>  net/bluetooth/hci_conn.c          | 150 ++++++++++++++++++++++++------
>  net/bluetooth/hci_core.c          |  18 ++++
>  net/bluetooth/hci_event.c         |  98 +++++++++++++++----
>  net/bluetooth/iso.c               |   4 +
>  8 files changed, 277 insertions(+), 48 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 1b4230cd42a3..28a3b105fdf3 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -198,6 +198,8 @@ struct bt_iso_bcast_qos {
>         __u8  sync_cte_type;
>         __u8  mse;
>         __u16 timeout;
> +       __u8  dummy[2]; /* Dummy octets for padding compatibility with ol=
d BlueZ */
> +       __u8  num_bis;

Don't think that is going to work, each BIS should have its own
dedicated socket otherwise we have multiplex/demultiplex at userspace
level which is not what we intended with the current design.

I think we can just use a similar design as to how we group CIG with
use of DEFER_SETUP so userspace can bind all BIS/socket to a BIG
before we created it:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/net/bluetooth/iso.c#n366

And we something like hci_le_create_cis_sync does when creating the
BIG which is to wait until hci_conn->state is set to BT_CONNECT to
issue the Create BIG with all the BIS:

 https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.g=
it/tree/net/bluetooth/hci_sync.c#n6192

>  };
>
>  struct bt_iso_qos {
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 07df96c47ef4..7567cbecf937 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1,6 +1,7 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> +   Copyright 2023 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> @@ -2812,6 +2813,12 @@ struct hci_evt_le_create_big_complete {
>         __le16  bis_handle[];
>  } __packed;
>
> +#define HCI_EVT_LE_TERM_BIG_COMPLETE   0x1c
> +struct hci_evt_le_term_big_complete {
> +       __u8    handle;
> +       __u8    reason;
> +} __packed;
> +
>  #define HCI_EVT_LE_BIG_SYNC_ESTABILISHED 0x1d
>  struct hci_evt_le_big_sync_estabilished {
>         __u8    status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 8baf34639939..2b2f25bea6bd 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -583,6 +583,7 @@ struct hci_dev {
>         struct list_head        pend_le_reports;
>         struct list_head        blocked_keys;
>         struct list_head        local_codecs;
> +       struct list_head        bigs;
>
>         struct hci_dev_stats    stat;
>
> @@ -973,7 +974,6 @@ enum {
>         HCI_CONN_NEW_LINK_KEY,
>         HCI_CONN_SCANNING,
>         HCI_CONN_AUTH_FAILURE,
> -       HCI_CONN_PER_ADV,

Not really sure why you are removing this flag?

>  };
>
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> @@ -1258,6 +1258,31 @@ static inline struct hci_conn *hci_conn_hash_looku=
p_big(struct hci_dev *hdev,
>         return NULL;
>  }
>
> +static inline struct hci_conn *
> +hci_conn_hash_lookup_big_state(struct hci_dev *hdev,
> +                              __u8 handle, __u16 state)
> +{
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       struct hci_conn  *c;
> +
> +       rcu_read_lock();
> +
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               if (bacmp(&c->dst, BDADDR_ANY) || c->type !=3D ISO_LINK |=
|
> +                                               c->state !=3D state)
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
> @@ -1369,6 +1394,8 @@ void hci_conn_enter_active_mode(struct hci_conn *co=
nn, __u8 force_active);
>
>  void hci_conn_failed(struct hci_conn *conn, u8 status);
>
> +int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos);
> +
>  /*
>   * hci_conn_get() and hci_conn_put() are used to control the life-time o=
f an
>   * "hci_conn" object. They do not guarantee that the hci_conn object is =
running,
> @@ -1576,6 +1603,9 @@ struct hci_conn_params *hci_pend_le_action_lookup(s=
truct list_head *list,
>                                                   bdaddr_t *addr,
>                                                   u8 addr_type);
>
> +struct iso_big *hci_bigs_list_lookup(struct list_head *list,
> +                                    __u8 handle);
> +
>  void hci_uuids_clear(struct hci_dev *hdev);
>
>  void hci_link_keys_clear(struct hci_dev *hdev);
> diff --git a/include/net/bluetooth/iso.h b/include/net/bluetooth/iso.h
> index 3f4fe8b78e1b..2deddb80499d 100644
> --- a/include/net/bluetooth/iso.h
> +++ b/include/net/bluetooth/iso.h
> @@ -3,6 +3,7 @@
>   * BlueZ - Bluetooth protocol stack for Linux
>   *
>   * Copyright (C) 2022 Intel Corporation
> + * Copyright 2023 NXP
>   */
>
>  #ifndef __ISO_H
> @@ -29,4 +30,17 @@ struct sockaddr_iso {
>         struct sockaddr_iso_bc iso_bc[];
>  };
>
> +struct iso_bis {
> +       __u16   handle;
> +       bool    assigned;
> +};
> +
> +/* hdev BIG list entry */
> +struct iso_big {
> +       struct list_head        list;
> +       __u8                    handle;
> +       __u8                    num_bis;
> +       struct iso_bis          bis[ISO_MAX_NUM_BIS];
> +};
> +
>  #endif /* __ISO_H */
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index f75ef12f18f7..57e52de6f21d 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -35,6 +35,7 @@
>  #include <net/bluetooth/mgmt.h>
>
>  #include "hci_request.h"
> +#include "hci_debugfs.h"
>  #include "smp.h"
>  #include "a2mp.h"
>  #include "eir.h"
> @@ -826,13 +827,6 @@ static int terminate_big_sync(struct hci_dev *hdev, =
void *data)
>
>         hci_remove_ext_adv_instance_sync(hdev, d->bis, NULL);
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
>         return hci_le_terminate_big_sync(hdev, d->big,
>                                          HCI_ERROR_LOCAL_HOST_TERM);
>  }
> @@ -914,11 +908,25 @@ static int hci_le_big_terminate(struct hci_dev *hde=
v, u8 big, u16 sync_handle)
>  static void bis_cleanup(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> +       struct iso_list_data data;
> +       struct iso_big *big;
>
>         bt_dev_dbg(hdev, "conn %p", conn);
>
>         if (conn->role =3D=3D HCI_ROLE_MASTER) {
> -               if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
> +               big =3D hci_bigs_list_lookup(&hdev->bigs, conn->iso_qos.b=
cast.big);
> +
> +               for (int i =3D 0; i < big->num_bis; i++)
> +                       if (!big->bis[i].assigned)
> +                               return;
> +
> +               data.count =3D 0;
> +               data.big =3D conn->iso_qos.bcast.big;
> +               data.bis =3D conn->iso_qos.bcast.bis;
> +
> +               hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_CON=
NECTED,
> +                                        &data);
> +               if (data.count)
>                         return;
>
>                 hci_le_terminate_big(hdev, conn->iso_qos.bcast.big,
> @@ -1486,13 +1494,40 @@ static int qos_set_bis(struct hci_dev *hdev, stru=
ct bt_iso_qos *qos)
>         return 0;
>  }
>
> +static int hci_match_bis_params(struct hci_dev *hdev, struct bt_iso_qos =
*qos,
> +                               __u8 base_len, __u8 *base, __u16 bis_stat=
e)
> +{
> +       struct hci_conn *conn;
> +       __u8 eir[HCI_MAX_PER_AD_LENGTH];
> +
> +       if (base_len && base)
> +               base_len =3D eir_append_service_data(eir, 0,  0x1851, bas=
e, base_len);
> +
> +       conn =3D hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, bis=
_state);
> +
> +       if (memcmp(qos, &conn->iso_qos, sizeof(*qos)) ||
> +           base_len !=3D conn->le_per_adv_data_len ||
> +           memcmp(conn->le_per_adv_data, eir, base_len))
> +               return -EADDRINUSE;
> +
> +       return 0;
> +}
> +
>  /* This function requires the caller holds hdev->lock */
>  static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
> -                                   struct bt_iso_qos *qos)
> +                                   struct bt_iso_qos *qos, __u8 base_len=
,
> +                                   __u8 *base, bool *big_create,
> +                                   bool *connected)
>  {
>         struct hci_conn *conn;
>         struct iso_list_data data;
>         int err;
> +       int i;
> +       struct iso_big *big;
> +       __u16 handle;
> +
> +       *big_create =3D false;
> +       *connected =3D false;
>
>         /* Let's make sure that le is enabled.*/
>         if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
> @@ -1509,26 +1544,71 @@ static struct hci_conn *hci_add_bis(struct hci_de=
v *hdev, bdaddr_t *dst,
>         if (err)
>                 return ERR_PTR(err);
>
> -       data.big =3D qos->bcast.big;
> -       data.bis =3D qos->bcast.bis;
> -       data.count =3D 0;
> +       /* Check if BIG is already created */
> +       big =3D hci_bigs_list_lookup(&hdev->bigs, qos->bcast.big);
> +       if (!big) {
> +               /* Check if there are other BISes bound to the same BIG *=
/
> +               data.big =3D qos->bcast.big;
> +               data.bis =3D qos->bcast.bis;
> +               data.count =3D 0;
>
> -       /* Check if there is already a matching BIG/BIS */
> -       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_BOUND, &dat=
a);
> -       if (data.count)
> -               return ERR_PTR(-EADDRINUSE);
> +               hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_BOU=
ND, &data);
> +               if (data.count) {
> +                       /* Check QoS and base parameters against the
> +                        * other BOUND connections
> +                        */
> +                       err =3D hci_match_bis_params(hdev, qos, base_len,=
 base, BT_BOUND);
> +                       goto done;
> +               }
>
> -       conn =3D hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big, qos-=
>bcast.bis);
> -       if (conn)
> -               return ERR_PTR(-EADDRINUSE);
> +               *big_create =3D true;
> +               goto done;
> +       }
> +
> +       conn =3D hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, BT_=
CONNECTED);
> +       if (!conn) {
> +               /* BIG is in the process of terminating.
> +                * Check BIS parameters against other BOUND connections i=
f any,
> +                * and mark BIS as bound for the BIG. BIG will be recreat=
ed
> +                * after receiving the HCI_EVT_LE_TERM_BIG_COMPLETE event
> +                */
> +               err =3D hci_match_bis_params(hdev, qos, base_len, base, B=
T_BOUND);
> +               goto done;
> +       }
> +
> +       /* BIG is already created. Check that QoS and
> +        * base parameters match the BIG
> +        */
> +       err =3D hci_match_bis_params(hdev, qos, base_len, base, BT_CONNEC=
TED);
> +       if (!err) {
> +               /* Try to assign a bis handle */
> +               for (i =3D 0; i < big->num_bis; i++) {
> +                       if (big->bis[i].assigned)
> +                               continue;
> +
> +                       handle =3D big->bis[i].handle;
> +                       big->bis[i].assigned =3D true;
> +                       *connected =3D true;
> +                       break;
> +               }
> +
> +               if (i =3D=3D big->num_bis)
> +                       err =3D -EADDRINUSE;
> +       }
> +
> +done:
> +       if (err)
> +               return ERR_PTR(err);
>
>         conn =3D hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
>         if (!conn)
>                 return ERR_PTR(-ENOMEM);
>
> -       set_bit(HCI_CONN_PER_ADV, &conn->flags);
>         conn->state =3D BT_CONNECT;
>
> +       if (*connected)
> +               conn->handle =3D handle;
> +
>         hci_conn_hold(conn);
>         return conn;
>  }
> @@ -1736,7 +1816,7 @@ static void cis_list(struct hci_conn *conn, void *d=
ata)
>         cis_add(d, &conn->iso_qos);
>  }
>
> -static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *q=
os)
> +int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
>         struct hci_cp_le_create_big cp;
> @@ -1745,7 +1825,7 @@ static int hci_le_create_big(struct hci_conn *conn,=
 struct bt_iso_qos *qos)
>
>         cp.handle =3D qos->bcast.big;
>         cp.adv_handle =3D qos->bcast.bis;
> -       cp.num_bis  =3D 0x01;
> +       cp.num_bis  =3D qos->bcast.num_bis;
>         hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
>         cp.bis.sdu =3D cpu_to_le16(qos->bcast.out.sdu);
>         cp.bis.latency =3D  cpu_to_le16(qos->bcast.out.latency);
> @@ -2156,9 +2236,12 @@ struct hci_conn *hci_connect_bis(struct hci_dev *h=
dev, bdaddr_t *dst,
>  {
>         struct hci_conn *conn;
>         int err;
> +       bool big_create =3D false;
> +       bool connected =3D false;
>
>         /* We need hci_conn object using the BDADDR_ANY as dst */
> -       conn =3D hci_add_bis(hdev, dst, qos);
> +       conn =3D hci_add_bis(hdev, dst, qos, base_len, base,
> +                          &big_create, &connected);
>         if (IS_ERR(conn))
>                 return conn;
>
> @@ -2171,18 +2254,27 @@ struct hci_conn *hci_connect_bis(struct hci_dev *=
hdev, bdaddr_t *dst,
>                 conn->le_per_adv_data_len =3D base_len;
>         }
>
> -       /* Queue start periodic advertising and create BIG */
> -       err =3D hci_cmd_sync_queue(hdev, create_big_sync, conn,
> -                                create_big_complete);
> -       if (err < 0) {
> -               hci_conn_drop(conn);
> -               return ERR_PTR(err);
> +       if (big_create) {
> +               /* Queue start periodic advertising and create BIG */
> +               err =3D hci_cmd_sync_queue(hdev, create_big_sync, conn,
> +                                        create_big_complete);
> +               if (err < 0) {
> +                       hci_conn_drop(conn);
> +                       return ERR_PTR(err);
> +               }
>         }
>
>         hci_iso_qos_setup(hdev, conn, &qos->bcast.out,
>                           conn->le_tx_phy ? conn->le_tx_phy :
>                           hdev->le_tx_def_phys);
>
> +       if (connected) {
> +               conn->state =3D BT_CONNECTED;
> +               hci_debugfs_create_conn(conn);
> +               hci_conn_add_sysfs(conn);
> +               hci_iso_setup_path(conn);
> +       }
> +
>         return conn;
>  }
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a856b1051d35..0dd9161f7157 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2,6 +2,7 @@
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>     Copyright (C) 2011 ProFUSION Embedded Systems
> +   Copyright 2023 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> @@ -38,6 +39,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/l2cap.h>
> +#include <net/bluetooth/iso.h>
>  #include <net/bluetooth/mgmt.h>
>
>  #include "hci_request.h"
> @@ -2264,6 +2266,20 @@ struct hci_conn_params *hci_pend_le_action_lookup(=
struct list_head *list,
>         return NULL;
>  }
>
> +/* This function requires the caller holds hdev->lock */
> +struct iso_big *hci_bigs_list_lookup(struct list_head *list,
> +                                    __u8 handle)
> +{
> +       struct iso_big *big;
> +
> +       list_for_each_entry(big, list, list) {
> +               if (big->handle =3D=3D handle)
> +                       return big;
> +       }
> +
> +       return NULL;
> +}
> +
>  /* This function requires the caller holds hdev->lock */
>  struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
>                                             bdaddr_t *addr, u8 addr_type)
> @@ -2525,6 +2541,8 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>         INIT_LIST_HEAD(&hdev->monitored_devices);
>
>         INIT_LIST_HEAD(&hdev->local_codecs);
> +       INIT_LIST_HEAD(&hdev->bigs);
> +
>         INIT_WORK(&hdev->rx_work, hci_rx_work);
>         INIT_WORK(&hdev->cmd_work, hci_cmd_work);
>         INIT_WORK(&hdev->tx_work, hci_tx_work);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d00ef6e3fc45..ddf55fa4703a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -30,6 +30,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/mgmt.h>
> +#include <net/bluetooth/iso.h>
>
>  #include "hci_request.h"
>  #include "hci_debugfs.h"
> @@ -3903,6 +3904,11 @@ static void hci_cs_le_create_big(struct hci_dev *h=
dev, u8 status)
>         bt_dev_dbg(hdev, "status 0x%2.2x", status);
>  }
>
> +static void hci_cs_le_term_big(struct hci_dev *hdev, u8 status)
> +{
> +       bt_dev_dbg(hdev, "status 0x%2.2x", status);
> +}
> +
>  static u8 hci_cc_set_per_adv_param(struct hci_dev *hdev, void *data,
>                                    struct sk_buff *skb)
>  {
> @@ -4275,6 +4281,7 @@ static const struct hci_cs {
>         HCI_CS(HCI_OP_LE_EXT_CREATE_CONN, hci_cs_le_ext_create_conn),
>         HCI_CS(HCI_OP_LE_CREATE_CIS, hci_cs_le_create_cis),
>         HCI_CS(HCI_OP_LE_CREATE_BIG, hci_cs_le_create_big),
> +       HCI_CS(HCI_OP_LE_TERM_BIG, hci_cs_le_term_big),
>  };
>
>  static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
> @@ -6910,6 +6917,9 @@ static void hci_le_create_big_complete_evt(struct h=
ci_dev *hdev, void *data,
>  {
>         struct hci_evt_le_create_big_complete *ev =3D data;
>         struct hci_conn *conn;
> +       struct iso_big *big;
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       __u8 bis_idx =3D 0;
>
>         BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
>
> @@ -6919,30 +6929,78 @@ static void hci_le_create_big_complete_evt(struct=
 hci_dev *hdev, void *data,
>
>         hci_dev_lock(hdev);
>
> -       conn =3D hci_conn_hash_lookup_big(hdev, ev->handle);
> -       if (!conn)
> -               goto unlock;
> +       if (!ev->status) {
> +               /* Add the created BIG to the list */
> +               big =3D kzalloc(sizeof(*big), GFP_KERNEL);
> +               if (!big)
> +                       return;
>
> -       if (conn->type !=3D ISO_LINK) {
> -               bt_dev_err(hdev,
> -                          "Invalid connection link type handle 0x%2.2x",
> -                          ev->handle);
> -               goto unlock;
> +               big->handle =3D ev->handle;
> +               big->num_bis =3D ev->num_bis;
> +
> +               for (int i =3D 0; i < ev->num_bis; i++) {
> +                       big->bis[i].handle =3D __le16_to_cpu(ev->bis_hand=
le[i]);
> +                       big->bis[i].assigned =3D false;
> +               }
> +
> +               list_add(&big->list, &hdev->bigs);
>         }
>
> -       if (ev->num_bis)
> -               conn->handle =3D __le16_to_cpu(ev->bis_handle[0]);
> +       rcu_read_lock();
>
> -       if (!ev->status) {
> -               conn->state =3D BT_CONNECTED;
> -               hci_debugfs_create_conn(conn);
> -               hci_conn_add_sysfs(conn);
> -               hci_iso_setup_path(conn);
> -               goto unlock;
> +       /* Connect all BISes that are bound to the BIG */
> +       list_for_each_entry_rcu(conn, &h->list, list) {
> +               if (bacmp(&conn->dst, BDADDR_ANY) || conn->type !=3D ISO_=
LINK ||
> +                   conn->state !=3D BT_BOUND ||
> +                   conn->iso_qos.bcast.big !=3D ev->handle)
> +                       continue;
> +
> +               if (ev->status) {
> +                       hci_connect_cfm(conn, ev->status);
> +                       hci_conn_del(conn);
> +               }
> +
> +               if (big->num_bis > bis_idx) {
> +                       conn->handle =3D __le16_to_cpu(big->bis[bis_idx].=
handle);
> +                       big->bis[bis_idx].assigned =3D true;
> +                       bis_idx++;
> +
> +                       conn->state =3D BT_CONNECTED;
> +                       hci_debugfs_create_conn(conn);
> +                       hci_conn_add_sysfs(conn);
> +                       hci_iso_setup_path(conn);
> +                       continue;
> +               }
>         }
>
> -       hci_connect_cfm(conn, ev->status);
> -       hci_conn_del(conn);
> +       rcu_read_unlock();
> +       hci_dev_unlock(hdev);
> +}
> +
> +static void hci_le_term_big_complete_evt(struct hci_dev *hdev, void *dat=
a,
> +                                        struct sk_buff *skb)
> +{
> +       struct hci_evt_le_term_big_complete *ev =3D data;
> +       struct iso_big *big;
> +       struct hci_conn *conn;
> +
> +       BT_DBG("%s reason 0x%2.2x", hdev->name, ev->reason);
> +
> +       hci_dev_lock(hdev);
> +
> +       big =3D hci_bigs_list_lookup(&hdev->bigs, ev->handle);
> +
> +       if (big) {
> +               list_del(&big->list);
> +               kfree(big);
> +       }
> +
> +       /* If there are any bound connections to the BIG, recreate it */
> +       conn =3D hci_conn_hash_lookup_big_state(hdev, ev->handle, BT_BOUN=
D);
> +       if (!conn)
> +               goto unlock;
> +
> +       hci_le_create_big(conn, &conn->iso_qos);
>
>  unlock:
>         hci_dev_unlock(hdev);
> @@ -7089,6 +7147,10 @@ static const struct hci_le_ev {
>                      hci_le_create_big_complete_evt,
>                      sizeof(struct hci_evt_le_create_big_complete),
>                      HCI_MAX_EVENT_SIZE),
> +       /* [0x1c =3D HCI_EVT_LE_TERM_BIG_COMPLETE] */
> +       HCI_LE_EV(HCI_EVT_LE_TERM_BIG_COMPLETE,
> +                 hci_le_term_big_complete_evt,
> +                 sizeof(struct hci_evt_le_term_big_complete)),
>         /* [0x1d =3D HCI_EV_LE_BIG_SYNC_ESTABILISHED] */
>         HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
>                      hci_le_big_sync_established_evt,
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 34d55a85d8f6..416ed416fffa 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -717,6 +717,7 @@ static struct bt_iso_qos default_qos =3D {
>                 .sync_cte_type          =3D 0x00,
>                 .mse                    =3D 0x00,
>                 .timeout                =3D 0x4000,
> +               .num_bis                =3D 0x01,
>         },
>  };
>
> @@ -1249,6 +1250,9 @@ static bool check_bcast_qos(struct bt_iso_qos *qos)
>         if (qos->bcast.timeout < 0x000a || qos->bcast.timeout > 0x4000)
>                 return false;
>
> +       if (qos->bcast.num_bis < 0x01 || qos->bcast.num_bis > ISO_MAX_NUM=
_BIS)
> +               return false;
> +
>         return true;
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
