Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D4C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 19:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjE2T71 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 15:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2T70 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 15:59:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0FCF
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 12:59:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2afb2874e83so38758211fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685390362; x=1687982362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1KBlHe9HzTLin8wiW3Ar9xljrlGwvViNB5S3PanfXQ=;
        b=eFnPDCK35nPjraPNu0kKUH+YUvAy8jHD8jBKdA9ExNvcf9Y2yONDIOQaZrOYJTxiSE
         KePgX99dsc5hR4kt2uEukeF2qRjHWslGmwU0OnReGjLCvU/2G3XsONJmkeK9aWWGrgKw
         eTKG+0K4MBX/ZyDPJzTFsJoApe7IuEgXyJtAMMjFp8qZjQ7+FVA3eO1AVEa7P+hGkmwe
         5oJPOraqjPOE4MwL1iun25Bmn50D5ZDvOk+4xJMfopH7DotOyT4so5AhSqf+itqECPlk
         hl9QQoSBUT6USXfM31ghhJKuSPyjXMNUKTmFTIXMWYVyEElQwJ65k9E+yXx1tN2cGPb8
         BRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685390362; x=1687982362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1KBlHe9HzTLin8wiW3Ar9xljrlGwvViNB5S3PanfXQ=;
        b=SJJoBm9iS1/7FBVvjiymbUrzQbGgVDgWOweMUGO1t5Zi0Yb9Syrx8GzipBetxWcbMH
         N9WiGeBKjLZQ9lElmrjR3jZBdNpAVYjpJJKmCXnRpXYad1YO2HaXwTpsOyw4meMqHH2n
         VCQky8Xs17iEteRYXrEVfgTWyHvBWs9HnxISyKnV9CyxnVPLLaUKkol37xLsPV5SJ+iJ
         h2JDgXxlfFvBJBSTLrfYUKI1nIQzH678CLgTBWAUqLoombwQADgdt9q5A3/CocKYaTUh
         fWd4vQjqOcAKtLL65sr6bB1zmU9ITPtkJFhFSafd/XEmYB4BHgvsXBBfwXFDryPQ6Jfj
         FGfw==
X-Gm-Message-State: AC+VfDyL7q2kqgAomafrLIbBi3vJ6fnbrQK85y/RZZa4IkpydC5/d/De
        mq1UfZXFXFGfKpxoJYN8ZJUVoOAdWk1kPMRJ20E=
X-Google-Smtp-Source: ACHHUZ5pWBQnbY9zslczda0G4WOs71F6aVVAHMI6ec8yUYEeOys84r+2yGpk8MlB+ffIxtpaG/yZtZOWDSCvKfwgwTg=
X-Received: by 2002:a2e:8185:0:b0:2af:2908:8ff3 with SMTP id
 e5-20020a2e8185000000b002af29088ff3mr4038620ljg.33.1685390361293; Mon, 29 May
 2023 12:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230529061057.3107-1-iulia.tanasescu@nxp.com> <20230529061057.3107-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230529061057.3107-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 May 2023 12:59:07 -0700
Message-ID: <CABBYNZJprifOeUJ8p+2Lc3vgpMqrDy5jJS34st-wdP=im10H_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: ISO: Add support for connecting
 multiple BISes
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Sun, May 28, 2023 at 11:14=E2=80=AFPM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> It is required for some configurations to have multiple BISes as part
> of the same BIG.
>
> Similar to the flow implemented for unicast, DEFER_SETUP will also be
> used to bind multiple BISes for the same BIG, before starting Periodic
> Advertising and creating the BIG.
>
> The user will have to open a new socket for each BIS. By setting the
> BT_DEFER_SETUP socket option and calling connect, a new connection
> will be added for the BIG and advertising handle set by the socket
> QoS parameters. Since all BISes will be bound for the same BIG and
> advertising handle, the socket QoS options and base parameters should
> match for all connections.
>
> By calling connect on a socket that does not have the BT_DEFER_SETUP
> option set, periodic advertising will be started and the BIG will
> be created, with a BIS for each previously bound connection. Since
> a BIG cannot be reconfigured with additional BISes after creation,
> no more connections can be bound for the BIG after the start periodic
> advertising and create BIG commands have been queued.
>
> The bis_cleanup function has also been updated, so that the advertising
> set and the BIG will not be terminated unless there are no more
> bound or connected BISes.
>
> The HCI_CONN_BIG_CREATED connection flag has been added to indicate
> that the BIG has been successfully created. This flag is checked at
> bis_cleanup, so that the BIG is only terminated if the
> HCI_LE_Create_BIG_Complete has been received.
>
> This implementation has been tested on hardware, using the "isotest"
> tool with an additional command line option, to specify the number of
> BISes to create as part of the desired BIG:
>
>     tools/isotest -i hci0 -s 00:00:00:00:00:00 -N 2 -G 1 -T 1
>
> The btmon log shows that a BIG containing 2 BISes has been created:
>
> < HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068) plen 3=
1
>         Handle: 0x01
>         Advertising Handle: 0x01
>         Number of BIS: 2
>         SDU Interval: 10000 us (0x002710)
>         Maximum SDU size: 40
>         Maximum Latency: 10 ms (0x000a)
>         RTN: 0x02
>         PHY: LE 2M (0x02)
>         Packing: Sequential (0x00)
>         Framing: Unframed (0x00)
>         Encryption: 0x00
>         Broadcast Code: 00000000000000000000000000000000
>
> > HCI Event: Command Status (0x0f) plen 4
>       LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
>         Status: Success (0x00)
>
> > HCI Event: LE Meta Event (0x3e) plen 23
>       LE Broadcast Isochronous Group Complete (0x1b)
>         Status: Success (0x00)
>         Handle: 0x01
>         BIG Synchronization Delay: 1974 us (0x0007b6)
>         Transport Latency: 1974 us (0x0007b6)
>         PHY: LE 2M (0x02)
>         NSE: 3
>         BN: 1
>         PTO: 1
>         IRC: 3
>         Maximum PDU: 40
>         ISO Interval: 10.00 msec (0x0008)
>         Connection Handle #0: 10
>         Connection Handle #1: 11
>
> < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
>         Handle: 10
>         Data Path Direction: Input (Host to Controller) (0x00)
>         Data Path: HCI (0x00)
>         Coding Format: Transparent (0x03)
>         Company Codec ID: Ericsson Technology Licensing (0)
>         Vendor Codec ID: 0
>         Controller Delay: 0 us (0x000000)
>         Codec Configuration Length: 0
>         Codec Configuration:
>
> > HCI Event: Command Complete (0x0e) plen 6
>       LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>         Status: Success (0x00)
>         Handle: 10
>
> < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
>         Handle: 11
>         Data Path Direction: Input (Host to Controller) (0x00)
>         Data Path: HCI (0x00)
>         Coding Format: Transparent (0x03)
>         Company Codec ID: Ericsson Technology Licensing (0)
>         Vendor Codec ID: 0
>         Controller Delay: 0 us (0x000000)
>         Codec Configuration Length: 0
>         Codec Configuration:
>
> > HCI Event: Command Complete (0x0e) plen 6
>       LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>         Status: Success (0x00)
>         Handle: 11
>
> < ISO Data TX: Handle 10 flags 0x02 dlen 44
>
> < ISO Data TX: Handle 11 flags 0x02 dlen 44
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 10
>         Count: 1
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 11
>         Count: 1
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/hci_core.h |  30 +++++++
>  net/bluetooth/hci_conn.c         | 147 ++++++++++++++++++++++---------
>  net/bluetooth/hci_event.c        |  50 ++++++-----
>  net/bluetooth/iso.c              |  28 ++++--
>  4 files changed, 186 insertions(+), 69 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 9f37326c1c05..74ec1f40ab6b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -975,6 +975,7 @@ enum {
>         HCI_CONN_SCANNING,
>         HCI_CONN_AUTH_FAILURE,
>         HCI_CONN_PER_ADV,
> +       HCI_CONN_BIG_CREATED,
>  };
>
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> @@ -1116,6 +1117,32 @@ static inline struct hci_conn *hci_conn_hash_looku=
p_bis(struct hci_dev *hdev,
>         return NULL;
>  }
>
> +static inline struct hci_conn *
> +hci_conn_hash_lookup_per_adv_bis(struct hci_dev *hdev,
> +                                bdaddr_t *ba,
> +                                __u8 big, __u8 bis)
> +{
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       struct hci_conn  *c;
> +
> +       rcu_read_lock();
> +
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               if (bacmp(&c->dst, ba) || c->type !=3D ISO_LINK ||
> +                       !test_bit(HCI_CONN_PER_ADV, &c->flags))
> +                       continue;
> +
> +               if (c->iso_qos.bcast.big =3D=3D big &&
> +                   c->iso_qos.bcast.bis =3D=3D bis) {
> +                       rcu_read_unlock();
> +                       return c;
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return NULL;
> +}
> +
>  static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_de=
v *hdev,
>                                                                 __u16 han=
dle)
>  {
> @@ -1351,6 +1378,9 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hd=
ev, int type, bdaddr_t *dst,
>                                  __u16 setting, struct bt_codec *codec);
>  struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
>                               __u8 dst_type, struct bt_iso_qos *qos);
> +struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
> +                             struct bt_iso_qos *qos,
> +                             __u8 base_len, __u8 *base);
>  struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
>                                  __u8 dst_type, struct bt_iso_qos *qos);
>  struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 1f906f8508bc..0838c0256a7e 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -790,6 +790,7 @@ struct iso_list_data {
>                 struct hci_cp_le_set_cig_params cp;
>                 struct hci_cis_params cis[0x11];
>         } pdu;
> +       bool big_term;
>  };
>
>  static void bis_list(struct hci_conn *conn, void *data)
> @@ -826,11 +827,8 @@ static int terminate_big_sync(struct hci_dev *hdev, =
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
> +       /* Only terminate BIG if it has been created */
> +       if (!d->big_term)
>                 return 0;
>
>         return hci_le_terminate_big_sync(hdev, d->big,
> @@ -842,7 +840,8 @@ static void terminate_big_destroy(struct hci_dev *hde=
v, void *data, int err)
>         kfree(data);
>  }
>
> -static int hci_le_terminate_big(struct hci_dev *hdev, u8 big, u8 bis)
> +static int hci_le_terminate_big(struct hci_dev *hdev, u8 big, u8 bis,
> +                               bool big_term)
>  {
>         struct iso_list_data *d;
>         int ret;
> @@ -855,6 +854,7 @@ static int hci_le_terminate_big(struct hci_dev *hdev,=
 u8 big, u8 bis)
>
>         d->big =3D big;
>         d->bis =3D bis;
> +       d->big_term =3D big_term;
>
>         ret =3D hci_cmd_sync_queue(hdev, terminate_big_sync, d,
>                                  terminate_big_destroy);
> @@ -914,6 +914,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev,=
 u8 big, u16 sync_handle)
>  static void bis_cleanup(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> +       struct hci_conn *bis;
>
>         bt_dev_dbg(hdev, "conn %p", conn);
>
> @@ -921,8 +922,19 @@ static void bis_cleanup(struct hci_conn *conn)
>                 if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
>                         return;
>
> +               /* Check if ISO connection is a BIS and terminate adverti=
sing
> +                * set and BIG if there are no other connections using it=
.
> +                */
> +               bis =3D hci_conn_hash_lookup_bis(hdev, BDADDR_ANY,
> +                                              conn->iso_qos.bcast.big,
> +                                              conn->iso_qos.bcast.bis);
> +               if (bis)
> +                       return;
> +
>                 hci_le_terminate_big(hdev, conn->iso_qos.bcast.big,
> -                                    conn->iso_qos.bcast.bis);
> +                                    conn->iso_qos.bcast.bis,
> +                                    test_and_clear_bit(HCI_CONN_BIG_CREA=
TED,
> +                                                       &conn->flags));

Im not really following why you decided to pass a flag if the big has
to be terminated or not, I mean if it has not been created the this
should be a nop so instead you could do just:

if (test_and_clear_bit(HCI_CONN_BIG_CREATED,...))
    hci_le_terminate_big(...)

Or better yet just incorporate the code above into
hci_le_terminate_big and pass the conn to it so it checks the flags,
etc.

>         } else {
>                 hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
>                                      conn->sync_handle);
> @@ -1491,10 +1503,10 @@ static int qos_set_bis(struct hci_dev *hdev, stru=
ct bt_iso_qos *qos)
>
>  /* This function requires the caller holds hdev->lock */
>  static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
> -                                   struct bt_iso_qos *qos)
> +                                   struct bt_iso_qos *qos, __u8 base_len=
,
> +                                   __u8 *base)
>  {
>         struct hci_conn *conn;
> -       struct iso_list_data data;
>         int err;
>
>         /* Let's make sure that le is enabled.*/
> @@ -1512,24 +1524,27 @@ static struct hci_conn *hci_add_bis(struct hci_de=
v *hdev, bdaddr_t *dst,
>         if (err)
>                 return ERR_PTR(err);
>
> -       data.big =3D qos->bcast.big;
> -       data.bis =3D qos->bcast.bis;
> -       data.count =3D 0;
> -
> -       /* Check if there is already a matching BIG/BIS */
> -       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_BOUND, &dat=
a);
> -       if (data.count)
> +       /* Check if the LE Create BIG command has already been sent */
> +       conn =3D hci_conn_hash_lookup_per_adv_bis(hdev, dst, qos->bcast.b=
ig,
> +                                               qos->bcast.big);
> +       if (conn)
>                 return ERR_PTR(-EADDRINUSE);
>
> -       conn =3D hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big, qos-=
>bcast.bis);
> -       if (conn)
> +       /* Check BIS settings against other bound BISes, since all
> +        * BISes in a BIG must have the same value for all parameters
> +        */
> +       conn =3D hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big,
> +                                       qos->bcast.bis);
> +
> +       if (conn && (memcmp(qos, &conn->iso_qos, sizeof(*qos)) ||
> +                    base_len !=3D conn->le_per_adv_data_len ||
> +                    memcmp(conn->le_per_adv_data, base, base_len)))
>                 return ERR_PTR(-EADDRINUSE);
>
>         conn =3D hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
>         if (!conn)
>                 return ERR_PTR(-ENOMEM);
>
> -       set_bit(HCI_CONN_PER_ADV, &conn->flags);
>         conn->state =3D BT_CONNECT;
>
>         hci_conn_hold(conn);
> @@ -1743,12 +1758,21 @@ static int hci_le_create_big(struct hci_conn *con=
n, struct bt_iso_qos *qos)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
>         struct hci_cp_le_create_big cp;
> +       struct iso_list_data data;
>
>         memset(&cp, 0, sizeof(cp));
>
> +       data.big =3D qos->bcast.big;
> +       data.bis =3D qos->bcast.bis;
> +       data.count =3D 0;
> +
> +       /* Create a BIS for each bound connection */
> +       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK,
> +                                BT_BOUND, &data);
> +
>         cp.handle =3D qos->bcast.big;
>         cp.adv_handle =3D qos->bcast.bis;
> -       cp.num_bis  =3D 0x01;
> +       cp.num_bis  =3D data.count;
>         hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
>         cp.bis.sdu =3D cpu_to_le16(qos->bcast.out.sdu);
>         cp.bis.latency =3D  cpu_to_le16(qos->bcast.out.latency);
> @@ -2020,16 +2044,6 @@ static void hci_iso_qos_setup(struct hci_dev *hdev=
, struct hci_conn *conn,
>                 qos->latency =3D conn->le_conn_latency;
>  }
>
> -static void hci_bind_bis(struct hci_conn *conn,
> -                        struct bt_iso_qos *qos)
> -{
> -       /* Update LINK PHYs according to QoS preference */
> -       conn->le_tx_phy =3D qos->bcast.out.phy;
> -       conn->le_tx_phy =3D qos->bcast.out.phy;
> -       conn->iso_qos =3D *qos;
> -       conn->state =3D BT_BOUND;
> -}
> -
>  static int create_big_sync(struct hci_dev *hdev, void *data)
>  {
>         struct hci_conn *conn =3D data;
> @@ -2152,27 +2166,80 @@ static void create_big_complete(struct hci_dev *h=
dev, void *data, int err)
>         }
>  }
>
> -struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
> -                                __u8 dst_type, struct bt_iso_qos *qos,
> -                                __u8 base_len, __u8 *base)
> +struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
> +                             struct bt_iso_qos *qos,
> +                             __u8 base_len, __u8 *base)
>  {
>         struct hci_conn *conn;
> -       int err;
> +       __u8 eir[HCI_MAX_PER_AD_LENGTH];
> +
> +       if (base_len && base)
> +               base_len =3D eir_append_service_data(eir, 0,  0x1851,
> +                                                  base, base_len);
>
>         /* We need hci_conn object using the BDADDR_ANY as dst */
> -       conn =3D hci_add_bis(hdev, dst, qos);
> +       conn =3D hci_add_bis(hdev, dst, qos, base_len, eir);
>         if (IS_ERR(conn))
>                 return conn;
>
> -       hci_bind_bis(conn, qos);
> +       /* Update LINK PHYs according to QoS preference */
> +       conn->le_tx_phy =3D qos->bcast.out.phy;
> +       conn->le_tx_phy =3D qos->bcast.out.phy;
>
>         /* Add Basic Announcement into Peridic Adv Data if BASE is set */
>         if (base_len && base) {
> -               base_len =3D eir_append_service_data(conn->le_per_adv_dat=
a, 0,
> -                                                  0x1851, base, base_len=
);
> +               memcpy(conn->le_per_adv_data,  eir, sizeof(eir));
>                 conn->le_per_adv_data_len =3D base_len;
>         }
>
> +       hci_iso_qos_setup(hdev, conn, &qos->bcast.out,
> +                         conn->le_tx_phy ? conn->le_tx_phy :
> +                         hdev->le_tx_def_phys);
> +
> +       conn->iso_qos =3D *qos;
> +       conn->state =3D BT_BOUND;
> +
> +       return conn;
> +}
> +
> +static void bis_mark_per_adv(struct hci_conn *conn, void *data)
> +{
> +       struct iso_list_data *d =3D data;
> +
> +       /* Skip if not broadcast/ANY address */
> +       if (bacmp(&conn->dst, BDADDR_ANY))
> +               return;
> +
> +       if (d->big !=3D conn->iso_qos.bcast.big ||
> +           d->bis =3D=3D BT_ISO_QOS_BIS_UNSET ||
> +           d->bis !=3D conn->iso_qos.bcast.bis)
> +               return;
> +
> +       set_bit(HCI_CONN_PER_ADV, &conn->flags);
> +}
> +
> +struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
> +                                __u8 dst_type, struct bt_iso_qos *qos,
> +                                __u8 base_len, __u8 *base)
> +{
> +       struct hci_conn *conn;
> +       int err;
> +       struct iso_list_data data;
> +
> +       conn =3D hci_bind_bis(hdev, dst, qos, base_len, base);
> +       if (IS_ERR(conn))
> +               return conn;
> +
> +       data.big =3D qos->bcast.big;
> +       data.bis =3D qos->bcast.bis;
> +
> +       /* Set HCI_CONN_PER_ADV for all bound connections, to mark that
> +        * the start periodic advertising and create BIG commands have
> +        * been queued
> +        */
> +       hci_conn_hash_list_state(hdev, bis_mark_per_adv, ISO_LINK,
> +                                BT_BOUND, &data);
> +
>         /* Queue start periodic advertising and create BIG */
>         err =3D hci_cmd_sync_queue(hdev, create_big_sync, conn,
>                                  create_big_complete);
> @@ -2181,10 +2248,6 @@ struct hci_conn *hci_connect_bis(struct hci_dev *h=
dev, bdaddr_t *dst,
>                 return ERR_PTR(err);
>         }
>
> -       hci_iso_qos_setup(hdev, conn, &qos->bcast.out,
> -                         conn->le_tx_phy ? conn->le_tx_phy :
> -                         hdev->le_tx_def_phys);
> -
>         return conn;
>  }
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d00ef6e3fc45..c24958af525a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6910,6 +6910,7 @@ static void hci_le_create_big_complete_evt(struct h=
ci_dev *hdev, void *data,
>  {
>         struct hci_evt_le_create_big_complete *ev =3D data;
>         struct hci_conn *conn;
> +       __u8 bis_idx =3D 0;
>
>         BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
>
> @@ -6918,33 +6919,42 @@ static void hci_le_create_big_complete_evt(struct=
 hci_dev *hdev, void *data,
>                 return;
>
>         hci_dev_lock(hdev);
> +       rcu_read_lock();
>
> -       conn =3D hci_conn_hash_lookup_big(hdev, ev->handle);
> -       if (!conn)
> -               goto unlock;
> +       /* Connect all BISes that are bound to the BIG */
> +       list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
> +               if (bacmp(&conn->dst, BDADDR_ANY) ||
> +                   conn->type !=3D ISO_LINK ||
> +                   conn->iso_qos.bcast.big !=3D ev->handle)
> +                       continue;
>
> -       if (conn->type !=3D ISO_LINK) {
> -               bt_dev_err(hdev,
> -                          "Invalid connection link type handle 0x%2.2x",
> -                          ev->handle);
> -               goto unlock;
> -       }
> +               conn->handle =3D __le16_to_cpu(ev->bis_handle[bis_idx++])=
;
>
> -       if (ev->num_bis)
> -               conn->handle =3D __le16_to_cpu(ev->bis_handle[0]);
> +               if (!ev->status) {
> +                       conn->state =3D BT_CONNECTED;
> +                       set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
> +                       hci_debugfs_create_conn(conn);
> +                       hci_conn_add_sysfs(conn);
> +                       hci_iso_setup_path(conn);
> +                       continue;
> +               }
>
> -       if (!ev->status) {
> -               conn->state =3D BT_CONNECTED;
> -               hci_debugfs_create_conn(conn);
> -               hci_conn_add_sysfs(conn);
> -               hci_iso_setup_path(conn);
> -               goto unlock;
> +               hci_connect_cfm(conn, ev->status);
> +               rcu_read_unlock();
> +               hci_conn_del(conn);
> +               rcu_read_lock();
>         }
>
> -       hci_connect_cfm(conn, ev->status);
> -       hci_conn_del(conn);
> +       if (!ev->status && !bis_idx)
> +               /* If no BISes have been connected for the BIG,
> +                * terminate. This is in case all bound connections
> +                * have been closed before the BIG creation
> +                * has completed.
> +                */
> +               hci_le_terminate_big_sync(hdev, ev->handle,
> +                                         HCI_ERROR_LOCAL_HOST_TERM);
>
> -unlock:
> +       rcu_read_unlock();
>         hci_dev_unlock(hdev);
>  }
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 34d55a85d8f6..485348fcc030 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -284,13 +284,24 @@ static int iso_connect_bis(struct sock *sk)
>                 goto unlock;
>         }
>
> -       hcon =3D hci_connect_bis(hdev, &iso_pi(sk)->dst,
> -                              le_addr_type(iso_pi(sk)->dst_type),
> -                              &iso_pi(sk)->qos, iso_pi(sk)->base_len,
> -                              iso_pi(sk)->base);
> -       if (IS_ERR(hcon)) {
> -               err =3D PTR_ERR(hcon);
> -               goto unlock;
> +       /* Just bind if DEFER_SETUP has been set */
> +       if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> +               hcon =3D hci_bind_bis(hdev, &iso_pi(sk)->dst,
> +                                   &iso_pi(sk)->qos, iso_pi(sk)->base_le=
n,
> +                                   iso_pi(sk)->base);
> +               if (IS_ERR(hcon)) {
> +                       err =3D PTR_ERR(hcon);
> +                       goto unlock;
> +               }
> +       } else {
> +               hcon =3D hci_connect_bis(hdev, &iso_pi(sk)->dst,
> +                                      le_addr_type(iso_pi(sk)->dst_type)=
,
> +                                      &iso_pi(sk)->qos, iso_pi(sk)->base=
_len,
> +                                      iso_pi(sk)->base);
> +               if (IS_ERR(hcon)) {
> +                       err =3D PTR_ERR(hcon);
> +                       goto unlock;
> +               }
>         }
>
>         conn =3D iso_conn_add(hcon);
> @@ -315,6 +326,9 @@ static int iso_connect_bis(struct sock *sk)
>         if (hcon->state =3D=3D BT_CONNECTED) {
>                 iso_sock_clear_timer(sk);
>                 sk->sk_state =3D BT_CONNECTED;
> +       } else if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> +               iso_sock_clear_timer(sk);
> +               sk->sk_state =3D BT_CONNECT;
>         } else {
>                 sk->sk_state =3D BT_CONNECT;
>                 iso_sock_set_timer(sk, sk->sk_sndtimeo);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
