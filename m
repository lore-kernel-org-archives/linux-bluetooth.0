Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1BCC7619A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 18:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCTSvw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCTSuy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 14:50:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8063A852
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 11:44:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br6so16123792lfb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679337850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UJGYd6PJ0rOjjW2aHynoWWRYS7Z0hNWaP+QdGsup54=;
        b=AiMFJyY10LLqlGPgTSiT2EMzTziwnQ0pyGfdQOLyDAPT8RquRw8NDorcwjI4di7WnQ
         TNqJuWIyyN5efh1A4cfQjnptqFvMLmN/ULAH5UiWmgLw2UM7QoFN4VyvpfZ3YZJ+ciSg
         mP5GgAyE2zR7GbCpm8PjGlRhoOLJJY23OXYNmK12gP1pEZqgGkQdjLQ63FcRjADTbrt/
         Nzih8DzBRgtFfnwvdeOs+Tly8X8bh0knjjLlP1VmocMmV8uzT2q+NK96ucj9dDGYHj+u
         Ec4ivTf41+l2Slq5RRmwrJfEa4WyhP9O2gL0tEN0/K3Fr3/+DVZ8uwjKdgyTIUBehN2P
         tcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UJGYd6PJ0rOjjW2aHynoWWRYS7Z0hNWaP+QdGsup54=;
        b=cC51UvZWgazGJN9WWAbmEPfneYAdWUKuYXwQhUpS3RFO+ipb5fArvLIkwBYA9xbVXB
         3fpxL+90wQejlxeGY8D5kQpp6mMEoxWvl6g/p4y22JScVreOHcNM0GQiCde13HjAez8D
         oKTpHGUT0Bb4QzrgEdSd+oQJvaCroBOnq14in6YGs6/sS6fotw/IixEvfA0Wj0BI1APn
         E3CF3R1Lp3VW+mWlnp6l2SaqiJbFMdsP1vCkfBuZOk9ILjiJOjmaB8xtrSCtvbAgsnBo
         hZlNXSbDBlF6zx4g+gN7UDAvJLBqEf1nPkHq1/JgT1ZAN3gQtzDEAPuMUZglw0y3DOcZ
         1VzA==
X-Gm-Message-State: AO0yUKVOJruvBFWMTLhlznhSyckNvChXEK2YDrKNh6ZhlxTpv9LwZKgs
        3FAvpNdzh/avsMKzEXtrq3wmPlx0eIUEy8JQGO9Zo3Ovg4mDTg==
X-Google-Smtp-Source: AK7set+5lwhK92QBerUr9E3T8r2hZ5od4eP4bhX4Y4CStqMlgKJ1xRO22VfQKhG2e//U6wfQWKvHL3g8MxItPvCqeaw=
X-Received: by 2002:ac2:46cd:0:b0:4e9:609f:2572 with SMTP id
 p13-20020ac246cd000000b004e9609f2572mr16524lfo.10.1679337849353; Mon, 20 Mar
 2023 11:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230320143608.25399-1-iulia.tanasescu@nxp.com> <20230320143608.25399-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230320143608.25399-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Mar 2023 11:43:57 -0700
Message-ID: <CABBYNZJTvEFAESfLqebuUrq6mUAw1ZcQbSMqpfgbMLkGbH_k8A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Mon, Mar 20, 2023 at 7:38=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Split bt_iso_qos into dedicated unicast and broadcast
> structures and add missing broadcast parameters
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/bluetooth.h |  47 ++++--
>  include/net/bluetooth/hci_core.h  |  21 +--
>  net/bluetooth/hci_conn.c          | 104 ++++++++-----
>  net/bluetooth/hci_event.c         |  38 +++--
>  net/bluetooth/iso.c               | 247 ++++++++++++++++++++++++++----
>  5 files changed, 346 insertions(+), 111 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index bcc5a4cd2c17..24d303783ea4 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -1,6 +1,7 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> +   Copyright 2023 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> @@ -155,11 +156,14 @@ struct bt_voice {
>
>  #define BT_SCM_PKT_STATUS      0x03
>
> -#define BT_ISO_QOS             17
> +#define BT_ISO_UNICAST_QOS     17

Lets keep a single opcode for setting QoS parameters.

>  #define BT_ISO_QOS_CIG_UNSET   0xff
>  #define BT_ISO_QOS_CIS_UNSET   0xff
>
> +#define BT_ISO_BCAST_SINK_QOS  18
> +#define BT_ISO_BCAST_SOURCE_QOS        19
> +
>  #define BT_ISO_QOS_BIG_UNSET   0xff
>  #define BT_ISO_QOS_BIS_UNSET   0xff
>
> @@ -171,25 +175,40 @@ struct bt_iso_io_qos {
>         __u8  rtn;
>  };
>
> -struct bt_iso_qos {
> -       union {
> -               __u8  cig;
> -               __u8  big;
> -       };
> -       union {
> -               __u8  cis;
> -               __u8  bis;
> -       };
> -       union {
> -               __u8  sca;
> -               __u8  sync_interval;
> -       };
> +struct bt_iso_unicast_qos {
> +       __u8  cig;
> +       __u8  cis;
> +       __u8  sca;
>         __u8  packing;
>         __u8  framing;
>         struct bt_iso_io_qos in;
>         struct bt_iso_io_qos out;
>  };


How about something like:

struct bt_iso_qos {
    union {
        struct bt_iso_ucast_qos ucast;
        struct bt_iso_bcast_qos bcast;
    };
};

struct bt_iso_bcast_qos {
   union {
        struct bt_iso_bcast_src_qos bsrc;
        struct bt_iso_bcast_snk_qos bsnk;
    };
};

> +struct bt_iso_bcast_sink_qos {
> +       __u8  options;
> +       __u16 skip;
> +       __u16 sync_timeout;
> +       __u8  sync_cte_type;
> +       __u8  big;
> +       __u8  encryption;
> +       __u8  bcode[16];
> +       __u8  mse;
> +       __u16 timeout;
> +       struct bt_iso_io_qos in;
> +};
> +
> +struct bt_iso_bcast_source_qos {
> +       __u8  sync_interval;
> +       __u8  big;
> +       __u8  bis;
> +       __u8  packing;
> +       __u8  framing;
> +       __u8  encryption;
> +       __u8  bcode[16];
> +       struct bt_iso_io_qos out;
> +};
> +
>  #define BT_ISO_PHY_1M          0x01
>  #define BT_ISO_PHY_2M          0x02
>  #define BT_ISO_PHY_CODED       0x04
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 53d3328c2b8b..60b6acb1be2b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1,6 +1,7 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
> +   Copyright 2023 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> @@ -730,7 +731,9 @@ struct hci_conn {
>         __s8            rssi;
>         __s8            tx_power;
>         __s8            max_tx_power;
> -       struct bt_iso_qos iso_qos;
> +       struct bt_iso_unicast_qos iso_unicast_qos;
> +       struct bt_iso_bcast_sink_qos iso_sink_qos;
> +       struct bt_iso_bcast_source_qos iso_source_qos;
>         unsigned long   flags;
>
>         enum conn_reasons conn_reason;
> @@ -1090,7 +1093,7 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_bis(struct hci_dev *hdev,
>                 if (bacmp(&c->dst, ba) || c->type !=3D ISO_LINK)
>                         continue;
>
> -               if (c->iso_qos.big =3D=3D big && c->iso_qos.bis =3D=3D bi=
s) {
> +               if (c->iso_source_qos.big =3D=3D big && c->iso_source_qos=
.bis =3D=3D bis) {
>                         rcu_read_unlock();
>                         return c;
>                 }
> @@ -1199,7 +1202,7 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_cig(struct hci_dev *hdev,
>                 if (c->type !=3D ISO_LINK)
>                         continue;
>
> -               if (handle =3D=3D c->iso_qos.cig) {
> +               if (handle =3D=3D c->iso_unicast_qos.cig) {
>                         rcu_read_unlock();
>                         return c;
>                 }
> @@ -1222,7 +1225,7 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_big(struct hci_dev *hdev,
>                 if (bacmp(&c->dst, BDADDR_ANY) || c->type !=3D ISO_LINK)
>                         continue;
>
> -               if (handle =3D=3D c->iso_qos.big) {
> +               if (handle =3D=3D c->iso_source_qos.big) {
>                         rcu_read_unlock();
>                         return c;
>                 }
> @@ -1324,15 +1327,15 @@ struct hci_conn *hci_connect_acl(struct hci_dev *=
hdev, bdaddr_t *dst,
>  struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_=
t *dst,
>                                  __u16 setting, struct bt_codec *codec);
>  struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
> -                             __u8 dst_type, struct bt_iso_qos *qos);
> +                             __u8 dst_type, struct bt_iso_unicast_qos *q=
os);
>  struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
> -                                __u8 dst_type, struct bt_iso_qos *qos);
> +                                __u8 dst_type, struct bt_iso_unicast_qos=
 *qos);
>  struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
> -                                __u8 dst_type, struct bt_iso_qos *qos,
> +                                __u8 dst_type, struct bt_iso_bcast_sourc=
e_qos *qos,
>                                  __u8 data_len, __u8 *data);
>  int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_typ=
e,
> -                      __u8 sid);
> -int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
> +                      __u8 sid, struct bt_iso_bcast_sink_qos *qos);
> +int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_bcast_sin=
k_qos *qos,
>                            __u16 sync_handle, __u8 num_bis, __u8 bis[]);
>  int hci_conn_check_link_mode(struct hci_conn *conn);
>  int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 17b946f9ba31..77f0c89a9089 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1,6 +1,7 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
> +   Copyright 2023 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> @@ -771,13 +772,22 @@ struct iso_list_data {
>  static void bis_list(struct hci_conn *conn, void *data)
>  {
>         struct iso_list_data *d =3D data;
> +       u8 check_big;
> +       u8 check_bis =3D BT_ISO_QOS_BIS_UNSET;
>
>         /* Skip if not broadcast/ANY address */
>         if (bacmp(&conn->dst, BDADDR_ANY))
>                 return;
>
> -       if (d->big !=3D conn->iso_qos.big || d->bis =3D=3D BT_ISO_QOS_BIS=
_UNSET ||
> -           d->bis !=3D conn->iso_qos.bis)
> +       if (conn->role =3D=3D HCI_ROLE_MASTER) {
> +               check_big =3D conn->iso_source_qos.big;
> +               check_bis =3D conn->iso_source_qos.bis;
> +       } else {
> +               check_big =3D conn->iso_sink_qos.big;
> +       }
> +
> +       if (d->big !=3D check_big || d->bis =3D=3D BT_ISO_QOS_BIS_UNSET |=
|
> +           d->bis !=3D check_bis)
>                 return;
>
>         d->count++;
> @@ -897,10 +907,10 @@ static void bis_cleanup(struct hci_conn *conn)
>                 if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
>                         return;
>
> -               hci_le_terminate_big(hdev, conn->iso_qos.big,
> -                                    conn->iso_qos.bis);
> +               hci_le_terminate_big(hdev, conn->iso_source_qos.big,
> +                                    conn->iso_source_qos.bis);
>         } else {
> -               hci_le_big_terminate(hdev, conn->iso_qos.big,
> +               hci_le_big_terminate(hdev, conn->iso_sink_qos.big,
>                                      conn->sync_handle);
>         }
>  }
> @@ -940,7 +950,7 @@ static void cis_cleanup(struct hci_conn *conn)
>         struct iso_list_data d;
>
>         memset(&d, 0, sizeof(d));
> -       d.cig =3D conn->iso_qos.cig;
> +       d.cig =3D conn->iso_unicast_qos.cig;
>
>         /* Check if ISO connection is a CIS and remove CIG if there are
>          * no other connections using it.
> @@ -949,7 +959,7 @@ static void cis_cleanup(struct hci_conn *conn)
>         if (d.count)
>                 return;
>
> -       hci_le_remove_cig(hdev, conn->iso_qos.cig);
> +       hci_le_remove_cig(hdev, conn->iso_unicast_qos.cig);
>  }
>
>  struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *=
dst,
> @@ -1398,12 +1408,12 @@ static int hci_explicit_conn_params_set(struct hc=
i_dev *hdev,
>         return 0;
>  }
>
> -static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
> +static int qos_set_big(struct hci_dev *hdev, uint8_t *big)
>  {
>         struct iso_list_data data;
>
>         /* Allocate a BIG if not set */
> -       if (qos->big =3D=3D BT_ISO_QOS_BIG_UNSET) {
> +       if (*big =3D=3D BT_ISO_QOS_BIG_UNSET) {
>                 for (data.big =3D 0x00; data.big < 0xef; data.big++) {
>                         data.count =3D 0;
>                         data.bis =3D 0xff;
> @@ -1418,13 +1428,14 @@ static int qos_set_big(struct hci_dev *hdev, stru=
ct bt_iso_qos *qos)
>                         return -EADDRNOTAVAIL;
>
>                 /* Update BIG */
> -               qos->big =3D data.big;
> +               *big =3D data.big;
>         }
>
>         return 0;
>  }
>
> -static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
> +static int qos_set_bis(struct hci_dev *hdev,
> +                      struct bt_iso_bcast_source_qos *qos)
>  {
>         struct iso_list_data data;
>
> @@ -1455,7 +1466,7 @@ static int qos_set_bis(struct hci_dev *hdev, struct=
 bt_iso_qos *qos)
>
>  /* This function requires the caller holds hdev->lock */
>  static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
> -                                   struct bt_iso_qos *qos)
> +                                   struct bt_iso_bcast_source_qos *qos)
>  {
>         struct hci_conn *conn;
>         struct iso_list_data data;
> @@ -1468,7 +1479,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev =
*hdev, bdaddr_t *dst,
>                 return ERR_PTR(-EOPNOTSUPP);
>         }
>
> -       err =3D qos_set_big(hdev, qos);
> +       err =3D qos_set_big(hdev, &qos->big);
>         if (err)
>                 return ERR_PTR(err);
>
> @@ -1636,7 +1647,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hd=
ev, int type, bdaddr_t *dst,
>         return sco;
>  }
>
> -static void cis_add(struct iso_list_data *d, struct bt_iso_qos *qos)
> +static void cis_add(struct iso_list_data *d, struct bt_iso_unicast_qos *=
qos)
>  {
>         struct hci_cis_params *cis =3D &d->pdu.cis[d->pdu.cp.num_cis];
>
> @@ -1659,8 +1670,8 @@ static void cis_list(struct hci_conn *conn, void *d=
ata)
>         if (!bacmp(&conn->dst, BDADDR_ANY))
>                 return;
>
> -       if (d->cig !=3D conn->iso_qos.cig || d->cis =3D=3D BT_ISO_QOS_CIS=
_UNSET ||
> -           d->cis !=3D conn->iso_qos.cis)
> +       if (d->cig !=3D conn->iso_unicast_qos.cig || d->cis =3D=3D BT_ISO=
_QOS_CIS_UNSET ||
> +           d->cis !=3D conn->iso_unicast_qos.cis)
>                 return;
>
>         d->count++;
> @@ -1669,10 +1680,11 @@ static void cis_list(struct hci_conn *conn, void =
*data)
>             d->count >=3D ARRAY_SIZE(d->pdu.cis))
>                 return;
>
> -       cis_add(d, &conn->iso_qos);
> +       cis_add(d, &conn->iso_unicast_qos);
>  }
>
> -static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *q=
os)
> +static int hci_le_create_big(struct hci_conn *conn,
> +                            struct bt_iso_bcast_source_qos *qos)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
>         struct hci_cp_le_create_big cp;
> @@ -1689,13 +1701,14 @@ static int hci_le_create_big(struct hci_conn *con=
n, struct bt_iso_qos *qos)
>         cp.bis.phy  =3D qos->out.phy;
>         cp.bis.packing =3D qos->packing;
>         cp.bis.framing =3D qos->framing;
> -       cp.bis.encryption =3D 0x00;
> -       memset(&cp.bis.bcode, 0, sizeof(cp.bis.bcode));
> +       cp.bis.encryption =3D qos->encryption;
> +       memcpy(&cp.bis.bcode, qos->bcode, sizeof(cp.bis.bcode));
>
>         return hci_send_cmd(hdev, HCI_OP_LE_CREATE_BIG, sizeof(cp), &cp);
>  }
>
> -static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_q=
os *qos)
> +static bool hci_le_set_cig_params(struct hci_conn *conn,
> +                                 struct bt_iso_unicast_qos *qos)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
>         struct iso_list_data data;
> @@ -1779,7 +1792,7 @@ static bool hci_le_set_cig_params(struct hci_conn *=
conn, struct bt_iso_qos *qos)
>  }
>
>  struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
> -                             __u8 dst_type, struct bt_iso_qos *qos)
> +                             __u8 dst_type, struct bt_iso_unicast_qos *q=
os)
>  {
>         struct hci_conn *cis;
>
> @@ -1797,7 +1810,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev,=
 bdaddr_t *dst,
>
>         /* Check if CIS has been set and the settings matches */
>         if (cis->state =3D=3D BT_BOUND &&
> -           !memcmp(&cis->iso_qos, qos, sizeof(*qos)))
> +           !memcmp(&cis->iso_unicast_qos, qos, sizeof(*qos)))
>                 return cis;
>
>         /* Update LINK PHYs according to QoS preference */
> @@ -1833,7 +1846,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev,=
 bdaddr_t *dst,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       cis->iso_qos =3D *qos;
> +       cis->iso_unicast_qos =3D *qos;
>         cis->state =3D BT_BOUND;
>
>         return cis;
> @@ -1843,10 +1856,19 @@ bool hci_iso_setup_path(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
>         struct hci_cp_le_setup_iso_path cmd;
> +       struct bt_iso_io_qos *in =3D NULL;
> +       struct bt_iso_io_qos *out =3D NULL;
>
>         memset(&cmd, 0, sizeof(cmd));
>
> -       if (conn->iso_qos.out.sdu) {
> +       if (bacmp(&conn->dst, BDADDR_ANY)) {
> +               in =3D &conn->iso_unicast_qos.in;
> +               out =3D &conn->iso_unicast_qos.out;
> +       } else {
> +               out =3D &conn->iso_source_qos.out;
> +       }
> +
> +       if (out->sdu) {
>                 cmd.handle =3D cpu_to_le16(conn->handle);
>                 cmd.direction =3D 0x00; /* Input (Host to Controller) */
>                 cmd.path =3D 0x00; /* HCI path if enabled */
> @@ -1857,7 +1879,7 @@ bool hci_iso_setup_path(struct hci_conn *conn)
>                         return false;
>         }
>
> -       if (conn->iso_qos.in.sdu) {
> +       if (in && in->sdu) {
>                 cmd.handle =3D cpu_to_le16(conn->handle);
>                 cmd.direction =3D 0x01; /* Output (Controller to Host) */
>                 cmd.path =3D 0x00; /* HCI path if enabled */
> @@ -1884,7 +1906,7 @@ static int hci_create_cis_sync(struct hci_dev *hdev=
, void *data)
>         cmd.cis[0].acl_handle =3D cpu_to_le16(conn->link->handle);
>         cmd.cis[0].cis_handle =3D cpu_to_le16(conn->handle);
>         cmd.cp.num_cis++;
> -       cig =3D conn->iso_qos.cig;
> +       cig =3D conn->iso_unicast_qos.cig;
>
>         hci_dev_lock(hdev);
>
> @@ -1894,7 +1916,7 @@ static int hci_create_cis_sync(struct hci_dev *hdev=
, void *data)
>                 struct hci_cis *cis =3D &cmd.cis[cmd.cp.num_cis];
>
>                 if (conn =3D=3D data || conn->type !=3D ISO_LINK ||
> -                   conn->state =3D=3D BT_CONNECTED || conn->iso_qos.cig =
!=3D cig)
> +                   conn->state =3D=3D BT_CONNECTED || conn->iso_unicast_=
qos.cig !=3D cig)
>                         continue;
>
>                 /* Check if all CIS(s) belonging to a CIG are ready */
> @@ -1991,19 +2013,19 @@ static void hci_iso_qos_setup(struct hci_dev *hde=
v, struct hci_conn *conn,
>  }
>
>  static void hci_bind_bis(struct hci_conn *conn,
> -                        struct bt_iso_qos *qos)
> +                        struct bt_iso_bcast_source_qos *qos)
>  {
>         /* Update LINK PHYs according to QoS preference */
>         conn->le_tx_phy =3D qos->out.phy;
>         conn->le_tx_phy =3D qos->out.phy;
> -       conn->iso_qos =3D *qos;
> +       conn->iso_source_qos =3D *qos;
>         conn->state =3D BT_BOUND;
>  }
>
>  static int create_big_sync(struct hci_dev *hdev, void *data)
>  {
>         struct hci_conn *conn =3D data;
> -       struct bt_iso_qos *qos =3D &conn->iso_qos;
> +       struct bt_iso_bcast_source_qos *qos =3D &conn->iso_source_qos;
>         u16 interval, sync_interval =3D 0;
>         u32 flags =3D 0;
>         int err;
> @@ -2023,7 +2045,7 @@ static int create_big_sync(struct hci_dev *hdev, vo=
id *data)
>         if (err)
>                 return err;
>
> -       return hci_le_create_big(conn, &conn->iso_qos);
> +       return hci_le_create_big(conn, &conn->iso_source_qos);
>  }
>
>  static void create_pa_complete(struct hci_dev *hdev, void *data, int err=
)
> @@ -2054,7 +2076,7 @@ static int create_pa_sync(struct hci_dev *hdev, voi=
d *data)
>  }
>
>  int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_typ=
e,
> -                      __u8 sid)
> +                      __u8 sid,  struct bt_iso_bcast_sink_qos *qos)
>  {
>         struct hci_cp_le_pa_create_sync *cp;
>
> @@ -2067,15 +2089,19 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdad=
dr_t *dst, __u8 dst_type,
>                 return -ENOMEM;
>         }
>
> +       cp->options =3D qos->options;
>         cp->sid =3D sid;
>         cp->addr_type =3D dst_type;
> +       cp->skip =3D qos->skip;
> +       cp->sync_timeout =3D qos->sync_timeout;
> +       cp->sync_cte_type =3D qos->sync_cte_type;
>         bacpy(&cp->addr, dst);
>
>         /* Queue start pa_create_sync and scan */
>         return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_com=
plete);
>  }
>
> -int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
> +int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_bcast_sin=
k_qos *qos,
>                            __u16 sync_handle, __u8 num_bis, __u8 bis[])
>  {
>         struct _packed {
> @@ -2087,13 +2113,17 @@ int hci_le_big_create_sync(struct hci_dev *hdev, =
struct bt_iso_qos *qos,
>         if (num_bis > sizeof(pdu.bis))
>                 return -EINVAL;
>
> -       err =3D qos_set_big(hdev, qos);
> +       err =3D qos_set_big(hdev, &qos->big);
>         if (err)
>                 return err;
>
>         memset(&pdu, 0, sizeof(pdu));
>         pdu.cp.handle =3D qos->big;
>         pdu.cp.sync_handle =3D cpu_to_le16(sync_handle);
> +       pdu.cp.encryption =3D qos->encryption;
> +       memcpy(pdu.cp.bcode, qos->bcode, sizeof(pdu.cp.bcode));
> +       pdu.cp.mse =3D qos->mse;
> +       pdu.cp.timeout =3D qos->timeout;
>         pdu.cp.num_bis =3D num_bis;
>         memcpy(pdu.bis, bis, num_bis);
>
> @@ -2115,7 +2145,7 @@ static void create_big_complete(struct hci_dev *hde=
v, void *data, int err)
>  }
>
>  struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
> -                                __u8 dst_type, struct bt_iso_qos *qos,
> +                                __u8 dst_type, struct bt_iso_bcast_sourc=
e_qos *qos,
>                                  __u8 base_len, __u8 *base)
>  {
>         struct hci_conn *conn;
> @@ -2151,7 +2181,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hd=
ev, bdaddr_t *dst,
>  }
>
>  struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
> -                                __u8 dst_type, struct bt_iso_qos *qos)
> +                                __u8 dst_type, struct bt_iso_unicast_qos=
 *qos)
>  {
>         struct hci_conn *le;
>         struct hci_conn *cis;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 8d8547fa9032..8428a3f75ef7 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1,6 +1,7 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
> +   Copyright 2023 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> @@ -3843,7 +3844,7 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *=
hdev, void *data,
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
> -               if (conn->type !=3D ISO_LINK || conn->iso_qos.cig !=3D rp=
->cig_id ||
> +               if (conn->type !=3D ISO_LINK || conn->iso_unicast_qos.cig=
 !=3D rp->cig_id ||
>                     conn->state =3D=3D BT_CONNECTED)
>                         continue;
>
> @@ -3877,6 +3878,7 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *=
hdev, void *data,
>         struct hci_rp_le_setup_iso_path *rp =3D data;
>         struct hci_cp_le_setup_iso_path *cp;
>         struct hci_conn *conn;
> +       bool cfm;
>
>         bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
>
> @@ -3900,12 +3902,14 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev=
 *hdev, void *data,
>         /* Input (Host to Controller) */
>         case 0x00:
>                 /* Only confirm connection if output only */
> -               if (conn->iso_qos.out.sdu && !conn->iso_qos.in.sdu)
> +               cfm =3D !bacmp(&conn->dst, BDADDR_ANY) ||
> +                       (conn->iso_unicast_qos.out.sdu && !conn->iso_unic=
ast_qos.in.sdu);
> +               if (cfm)
>                         hci_connect_cfm(conn, rp->status);
>                 break;
>         /* Output (Controller to Host) */
>         case 0x01:
> -               /* Confirm connection since conn->iso_qos is always confi=
gured
> +               /* Confirm connection since Output is always configured
>                  * last.
>                  */
>                 hci_connect_cfm(conn, rp->status);
> @@ -6822,15 +6826,15 @@ static void hci_le_cis_estabilished_evt(struct hc=
i_dev *hdev, void *data,
>                 memset(&interval, 0, sizeof(interval));
>
>                 memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
> -               conn->iso_qos.in.interval =3D le32_to_cpu(interval);
> +               conn->iso_unicast_qos.in.interval =3D le32_to_cpu(interva=
l);
>                 memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
> -               conn->iso_qos.out.interval =3D le32_to_cpu(interval);
> -               conn->iso_qos.in.latency =3D le16_to_cpu(ev->interval);
> -               conn->iso_qos.out.latency =3D le16_to_cpu(ev->interval);
> -               conn->iso_qos.in.sdu =3D le16_to_cpu(ev->c_mtu);
> -               conn->iso_qos.out.sdu =3D le16_to_cpu(ev->p_mtu);
> -               conn->iso_qos.in.phy =3D ev->c_phy;
> -               conn->iso_qos.out.phy =3D ev->p_phy;
> +               conn->iso_unicast_qos.out.interval =3D le32_to_cpu(interv=
al);
> +               conn->iso_unicast_qos.in.latency =3D le16_to_cpu(ev->inte=
rval);
> +               conn->iso_unicast_qos.out.latency =3D le16_to_cpu(ev->int=
erval);
> +               conn->iso_unicast_qos.in.sdu =3D le16_to_cpu(ev->c_mtu);
> +               conn->iso_unicast_qos.out.sdu =3D le16_to_cpu(ev->p_mtu);
> +               conn->iso_unicast_qos.in.phy =3D ev->c_phy;
> +               conn->iso_unicast_qos.out.phy =3D ev->p_phy;
>         }
>
>         if (!ev->status) {
> @@ -6904,8 +6908,8 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev=
, void *data,
>                 cis->handle =3D cis_handle;
>         }
>
> -       cis->iso_qos.cig =3D ev->cig_id;
> -       cis->iso_qos.cis =3D ev->cis_id;
> +       cis->iso_unicast_qos.cig =3D ev->cig_id;
> +       cis->iso_unicast_qos.cis =3D ev->cis_id;
>
>         if (!(flags & HCI_PROTO_DEFER)) {
>                 hci_le_accept_cis(hdev, ev->cis_handle);
> @@ -6992,13 +6996,13 @@ static void hci_le_big_sync_established_evt(struc=
t hci_dev *hdev, void *data,
>                         bis->handle =3D handle;
>                 }
>
> -               bis->iso_qos.big =3D ev->handle;
> +               bis->iso_sink_qos.big =3D ev->handle;
>                 memset(&interval, 0, sizeof(interval));
>                 memcpy(&interval, ev->latency, sizeof(ev->latency));
> -               bis->iso_qos.in.interval =3D le32_to_cpu(interval);
> +               bis->iso_sink_qos.in.interval =3D le32_to_cpu(interval);
>                 /* Convert ISO Interval (1.25 ms slots) to latency (ms) *=
/
> -               bis->iso_qos.in.latency =3D le16_to_cpu(ev->interval) * 1=
25 / 100;
> -               bis->iso_qos.in.sdu =3D le16_to_cpu(ev->max_pdu);
> +               bis->iso_sink_qos.in.latency =3D le16_to_cpu(ev->interval=
) * 125 / 100;
> +               bis->iso_sink_qos.in.sdu =3D le16_to_cpu(ev->max_pdu);
>
>                 hci_connect_cfm(bis, ev->status);
>         }
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 8d136a730163..e660e1c5ea11 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -3,6 +3,7 @@
>   * BlueZ - Bluetooth protocol stack for Linux
>   *
>   * Copyright (C) 2022 Intel Corporation
> + * Copyright 2023 NXP
>   */
>
>  #include <linux/module.h>
> @@ -58,7 +59,9 @@ struct iso_pinfo {
>         __u8                    bc_bis[ISO_MAX_NUM_BIS];
>         __u16                   sync_handle;
>         __u32                   flags;
> -       struct bt_iso_qos       qos;
> +       struct bt_iso_unicast_qos       unicast_qos;
> +       struct bt_iso_bcast_sink_qos    sink_qos;
> +       struct bt_iso_bcast_source_qos  source_qos;
>         __u8                    base_len;
>         __u8                    base[BASE_MAX_LENGTH];
>         struct iso_conn         *conn;
> @@ -265,14 +268,14 @@ static int iso_connect_bis(struct sock *sk)
>         }
>
>         /* Fail if out PHYs are marked as disabled */
> -       if (!iso_pi(sk)->qos.out.phy) {
> +       if (!iso_pi(sk)->source_qos.out.phy) {
>                 err =3D -EINVAL;
>                 goto unlock;
>         }
>
>         hcon =3D hci_connect_bis(hdev, &iso_pi(sk)->dst,
>                                le_addr_type(iso_pi(sk)->dst_type),
> -                              &iso_pi(sk)->qos, iso_pi(sk)->base_len,
> +                              &iso_pi(sk)->source_qos, iso_pi(sk)->base_=
len,
>                                iso_pi(sk)->base);
>         if (IS_ERR(hcon)) {
>                 err =3D PTR_ERR(hcon);
> @@ -337,7 +340,7 @@ static int iso_connect_cis(struct sock *sk)
>         }
>
>         /* Fail if either PHYs are marked as disabled */
> -       if (!iso_pi(sk)->qos.in.phy && !iso_pi(sk)->qos.out.phy) {
> +       if (!iso_pi(sk)->unicast_qos.in.phy && !iso_pi(sk)->unicast_qos.o=
ut.phy) {
>                 err =3D -EINVAL;
>                 goto unlock;
>         }
> @@ -346,7 +349,7 @@ static int iso_connect_cis(struct sock *sk)
>         if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
>                 hcon =3D hci_bind_cis(hdev, &iso_pi(sk)->dst,
>                                     le_addr_type(iso_pi(sk)->dst_type),
> -                                   &iso_pi(sk)->qos);
> +                                   &iso_pi(sk)->unicast_qos);
>                 if (IS_ERR(hcon)) {
>                         err =3D PTR_ERR(hcon);
>                         goto unlock;
> @@ -354,7 +357,7 @@ static int iso_connect_cis(struct sock *sk)
>         } else {
>                 hcon =3D hci_connect_cis(hdev, &iso_pi(sk)->dst,
>                                        le_addr_type(iso_pi(sk)->dst_type)=
,
> -                                      &iso_pi(sk)->qos);
> +                                      &iso_pi(sk)->unicast_qos);
>                 if (IS_ERR(hcon)) {
>                         err =3D PTR_ERR(hcon);
>                         goto unlock;
> @@ -400,24 +403,40 @@ static int iso_connect_cis(struct sock *sk)
>         return err;
>  }
>
> -static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
> +static struct bt_iso_unicast_qos *iso_sock_get_unicast_qos(struct sock *=
sk)
>  {
>         if (sk->sk_state =3D=3D BT_CONNECTED || sk->sk_state =3D=3D BT_CO=
NNECT2)
> -               return &iso_pi(sk)->conn->hcon->iso_qos;
> +               return &iso_pi(sk)->conn->hcon->iso_unicast_qos;
>
> -       return &iso_pi(sk)->qos;
> +       return &iso_pi(sk)->unicast_qos;
>  }
>
> -static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
> +static struct bt_iso_bcast_sink_qos *iso_sock_get_bcast_sink_qos(struct =
sock *sk)
> +{
> +       if (sk->sk_state =3D=3D BT_CONNECTED || sk->sk_state =3D=3D BT_CO=
NNECT2)
> +               return &iso_pi(sk)->conn->hcon->iso_sink_qos;
> +
> +       return &iso_pi(sk)->sink_qos;
> +}
> +
> +static struct bt_iso_bcast_source_qos *iso_sock_get_bcast_source_qos(str=
uct sock *sk)
> +{
> +       if (sk->sk_state =3D=3D BT_CONNECTED || sk->sk_state =3D=3D BT_CO=
NNECT2)
> +               return &iso_pi(sk)->conn->hcon->iso_source_qos;
> +
> +       return &iso_pi(sk)->source_qos;
> +}
> +
> +static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
> +                         struct bt_iso_io_qos *out)
>  {
>         struct iso_conn *conn =3D iso_pi(sk)->conn;
> -       struct bt_iso_qos *qos =3D iso_sock_get_qos(sk);
>         struct hci_iso_data_hdr *hdr;
>         int len =3D 0;
>
>         BT_DBG("sk %p len %d", sk, skb->len);
>
> -       if (skb->len > qos->out.sdu)
> +       if (skb->len > out->sdu)
>                 return -EMSGSIZE;
>
>         len =3D skb->len;
> @@ -679,7 +698,7 @@ static struct proto iso_proto =3D {
>         .rtn            =3D 2u, \
>  }
>
> -static struct bt_iso_qos default_qos =3D {
> +static struct bt_iso_unicast_qos default_unicast_qos =3D {
>         .cig            =3D BT_ISO_QOS_CIG_UNSET,
>         .cis            =3D BT_ISO_QOS_CIS_UNSET,
>         .sca            =3D 0x00,
> @@ -689,6 +708,30 @@ static struct bt_iso_qos default_qos =3D {
>         .out            =3D DEFAULT_IO_QOS,
>  };
>
> +static struct bt_iso_bcast_sink_qos default_sink_qos =3D {
> +       .options        =3D 0x00,
> +       .skip           =3D 0x0000,
> +       .sync_timeout   =3D 0x4000,
> +       .sync_cte_type  =3D 0x0000,
> +       .big            =3D BT_ISO_QOS_BIG_UNSET,
> +       .encryption     =3D 0x00,
> +       .bcode          =3D {0x00},
> +       .mse            =3D 0x00,
> +       .timeout        =3D 0x4000,
> +       .in             =3D DEFAULT_IO_QOS,
> +};
> +
> +static struct bt_iso_bcast_source_qos default_source_qos =3D {
> +       .sync_interval  =3D 0x07,
> +       .big            =3D BT_ISO_QOS_BIG_UNSET,
> +       .bis            =3D BT_ISO_QOS_BIS_UNSET,
> +       .packing        =3D 0x00,
> +       .framing        =3D 0x00,
> +       .encryption     =3D 0x00,
> +       .bcode          =3D {0x00},
> +       .out            =3D DEFAULT_IO_QOS,
> +};
> +
>  static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
>                                    int proto, gfp_t prio, int kern)
>  {
> @@ -712,7 +755,9 @@ static struct sock *iso_sock_alloc(struct net *net, s=
truct socket *sock,
>         /* Set address type as public as default src address is BDADDR_AN=
Y */
>         iso_pi(sk)->src_type =3D BDADDR_LE_PUBLIC;
>
> -       iso_pi(sk)->qos =3D default_qos;
> +       iso_pi(sk)->unicast_qos =3D default_unicast_qos;
> +       iso_pi(sk)->sink_qos =3D default_sink_qos;
> +       iso_pi(sk)->source_qos =3D default_source_qos;

No need to keep 3 different structures for the QoS, the socket can
only be used for 1 at the time and we should be able to detect what
defaults to load when allocating, this is another reason why I don't
want multiple QoS options since it make user to believe they can setup
a socket for both unicast and broadcast when in fact this shall not be
possible.

>         bt_sock_link(&iso_sk_list, sk);
>         return sk;
> @@ -895,7 +940,7 @@ static int iso_listen_bis(struct sock *sk)
>
>         err =3D hci_pa_create_sync(hdev, &iso_pi(sk)->dst,
>                                  le_addr_type(iso_pi(sk)->dst_type),
> -                                iso_pi(sk)->bc_sid);
> +                                iso_pi(sk)->bc_sid, &iso_pi(sk)->sink_qo=
s);
>
>         hci_dev_put(hdev);
>
> @@ -1086,10 +1131,15 @@ static int iso_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
>
>         lock_sock(sk);
>
> -       if (sk->sk_state =3D=3D BT_CONNECTED)
> -               err =3D iso_send_frame(sk, skb);
> -       else
> +       if (sk->sk_state =3D=3D BT_CONNECTED) {
> +               if (bacmp(&conn->hcon->dst, BDADDR_ANY))
> +                       err =3D iso_send_frame(sk, skb, &iso_sock_get_uni=
cast_qos(sk)->out);
> +               else
> +                       err =3D iso_send_frame(sk, skb,
> +                                            &iso_sock_get_bcast_source_q=
os(sk)->out);
> +       } else {
>                 err =3D -ENOTCONN;
> +       }
>
>         release_sock(sk);
>
> @@ -1154,7 +1204,7 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
>         return true;
>  }
>
> -static bool check_qos(struct bt_iso_qos *qos)
> +static bool check_unicast_qos(struct bt_iso_unicast_qos *qos)
>  {
>         if (qos->sca > 0x07)
>                 return false;
> @@ -1174,12 +1224,60 @@ static bool check_qos(struct bt_iso_qos *qos)
>         return true;
>  }
>
> +static bool check_bcast_sink_qos(struct bt_iso_bcast_sink_qos *qos)
> +{
> +       if (qos->options > 0x07)
> +               return false;
> +
> +       if (qos->skip > 0x01f3)
> +               return false;
> +
> +       if (qos->sync_timeout < 0x000a || qos->sync_timeout > 0x4000)
> +               return false;
> +
> +       if (qos->sync_cte_type > 0x1f)
> +               return false;
> +
> +       if (qos->encryption > 0x01)
> +               return false;
> +
> +       if (qos->mse > 0x1f)
> +               return false;
> +
> +       if (qos->timeout < 0x000a || qos->timeout > 0x4000)
> +               return false;
> +
> +       if (!check_io_qos(&qos->in))
> +               return false;
> +
> +       return true;
> +}
> +
> +static bool check_bcast_source_qos(struct bt_iso_bcast_source_qos *qos)
> +{
> +       if (qos->sync_interval > 0x07)
> +               return false;
> +
> +       if (qos->packing > 0x01)
> +               return false;
> +
> +       if (qos->framing > 0x01)
> +               return false;
> +
> +       if (qos->encryption > 0x01)
> +               return false;
> +
> +       if (!check_io_qos(&qos->out))
> +               return false;
> +
> +       return true;
> +}
> +
>  static int iso_sock_setsockopt(struct socket *sock, int level, int optna=
me,
>                                sockptr_t optval, unsigned int optlen)
>  {
>         struct sock *sk =3D sock->sk;
>         int len, err =3D 0;
> -       struct bt_iso_qos qos;
>         u32 opt;
>
>         BT_DBG("sk %p", sk);
> @@ -1204,32 +1302,96 @@ static int iso_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>                         clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
>                 break;
>
> -       case BT_ISO_QOS:
> +       case BT_ISO_UNICAST_QOS:
> +               struct bt_iso_unicast_qos unicast_qos;
> +
> +               if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOU=
ND &&
> +                   sk->sk_state !=3D BT_CONNECT2) {
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               len =3D min_t(unsigned int, sizeof(unicast_qos), optlen);
> +               if (len !=3D sizeof(unicast_qos)) {
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               memset(&unicast_qos, 0, sizeof(unicast_qos));
> +
> +               if (copy_from_sockptr(&unicast_qos, optval, len)) {
> +                       err =3D -EFAULT;
> +                       break;
> +               }
> +
> +               if (!check_unicast_qos(&unicast_qos)) {
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               iso_pi(sk)->unicast_qos =3D unicast_qos;
> +
> +               break;
> +
> +       case BT_ISO_BCAST_SINK_QOS:
> +               struct bt_iso_bcast_sink_qos sink_qos;
> +
>                 if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOU=
ND &&
>                     sk->sk_state !=3D BT_CONNECT2) {
>                         err =3D -EINVAL;
>                         break;
>                 }
>
> -               len =3D min_t(unsigned int, sizeof(qos), optlen);
> -               if (len !=3D sizeof(qos)) {
> +               len =3D min_t(unsigned int, sizeof(sink_qos), optlen);
> +               if (len !=3D sizeof(sink_qos)) {
>                         err =3D -EINVAL;
>                         break;
>                 }
>
> -               memset(&qos, 0, sizeof(qos));
> +               memset(&sink_qos, 0, sizeof(sink_qos));
>
> -               if (copy_from_sockptr(&qos, optval, len)) {
> +               if (copy_from_sockptr(&sink_qos, optval, len)) {
>                         err =3D -EFAULT;
>                         break;
>                 }
>
> -               if (!check_qos(&qos)) {
> +               if (!check_bcast_sink_qos(&sink_qos)) {
>                         err =3D -EINVAL;
>                         break;
>                 }
>
> -               iso_pi(sk)->qos =3D qos;
> +               iso_pi(sk)->sink_qos =3D sink_qos;
> +
> +               break;
> +
> +       case BT_ISO_BCAST_SOURCE_QOS:
> +               struct bt_iso_bcast_source_qos source_qos;
> +
> +               if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOU=
ND &&
> +                   sk->sk_state !=3D BT_CONNECT2) {
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               len =3D min_t(unsigned int, sizeof(source_qos), optlen);
> +               if (len !=3D sizeof(source_qos)) {
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               memset(&source_qos, 0, sizeof(source_qos));
> +
> +               if (copy_from_sockptr(&source_qos, optval, len)) {
> +                       err =3D -EFAULT;
> +                       break;
> +               }
> +
> +               if (!check_bcast_source_qos(&source_qos)) {
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               iso_pi(sk)->source_qos =3D source_qos;
>
>                 break;
>
> @@ -1270,7 +1432,6 @@ static int iso_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>  {
>         struct sock *sk =3D sock->sk;
>         int len, err =3D 0;
> -       struct bt_iso_qos *qos;
>         u8 base_len;
>         u8 *base;
>
> @@ -1294,11 +1455,29 @@ static int iso_sock_getsockopt(struct socket *soc=
k, int level, int optname,
>
>                 break;
>
> -       case BT_ISO_QOS:
> -               qos =3D iso_sock_get_qos(sk);
> +       case BT_ISO_UNICAST_QOS:
> +               struct bt_iso_unicast_qos *unicast_qos =3D iso_sock_get_u=
nicast_qos(sk);
> +
> +               len =3D min_t(unsigned int, len, sizeof(*unicast_qos));
> +               if (copy_to_user(optval, unicast_qos, len))
> +                       err =3D -EFAULT;
> +
> +               break;
> +
> +       case BT_ISO_BCAST_SINK_QOS:
> +               struct bt_iso_bcast_sink_qos *sink_qos =3D iso_sock_get_b=
cast_sink_qos(sk);
> +
> +               len =3D min_t(unsigned int, len, sizeof(*sink_qos));
> +               if (copy_to_user(optval, sink_qos, len))
> +                       err =3D -EFAULT;
> +
> +               break;
> +
> +       case BT_ISO_BCAST_SOURCE_QOS:
> +               struct bt_iso_bcast_source_qos *source_qos =3D iso_sock_g=
et_bcast_source_qos(sk);
>
> -               len =3D min_t(unsigned int, len, sizeof(*qos));
> -               if (copy_to_user(optval, qos, len))
> +               len =3D min_t(unsigned int, len, sizeof(*source_qos));
> +               if (copy_to_user(optval, source_qos, len))
>                         err =3D -EFAULT;
>
>                 break;
> @@ -1419,7 +1598,7 @@ static bool iso_match_big(struct sock *sk, void *da=
ta)
>  {
>         struct hci_evt_le_big_sync_estabilished *ev =3D data;
>
> -       return ev->handle =3D=3D iso_pi(sk)->qos.big;
> +       return ev->handle =3D=3D iso_pi(sk)->sink_qos.big;
>  }
>
>  static void iso_conn_ready(struct iso_conn *conn)
> @@ -1550,7 +1729,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>                                 iso_pi(sk)->bc_num_bis =3D ev2->num_bis;
>
>                         err =3D hci_le_big_create_sync(hdev,
> -                                                    &iso_pi(sk)->qos,
> +                                                    &iso_pi(sk)->sink_qo=
s,
>                                                      iso_pi(sk)->sync_han=
dle,
>                                                      iso_pi(sk)->bc_num_b=
is,
>                                                      iso_pi(sk)->bc_bis);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
