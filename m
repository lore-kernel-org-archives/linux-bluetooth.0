Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCA7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 22:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhLIWKj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhLIWKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 17:10:38 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0617C061746
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 14:07:04 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id n6so13577452uak.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Dec 2021 14:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mUxual7TokvcF9b88TK0pO/lHdVBUbkTIL6GCr5Dv9M=;
        b=ICElgNODKdOXFrZglB1m+cL9ZOwV/CMCIhGCkOpSAZ6gKDYz8d8qR+J6US93RhDNUI
         ntAG5vllBkYUSM6PF42k0xeRfGdSJfVQ3yy6OibSbmvw1lhMiCdivF1XOdR2hA02HYhh
         LvmK4OlTKRMOr1ofG90h03Rd4gd7ureGv62E4Dh1wg0P8WC9rvj6GLNGl5DsjpfSYcDB
         wfRfJPruiIFo849mVddXeQwYzac9k7SB68hOeCpxaJBd0Xw8iL/81HzdRQU9HiYmxKBU
         vofkhbw6gOWv2bJxQjVTAg6fM/IZdy37Hp2zGErLeBaEu0jedTMGl+KPckptGnvgoRfq
         6ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mUxual7TokvcF9b88TK0pO/lHdVBUbkTIL6GCr5Dv9M=;
        b=EnWz629+QoVuOpbQDWaRJZfn/wc2ToQ9NksjgVLn5E54EhmxOYF4JxcMB1CYHXbkdO
         yGvg5rvuB2kbQVgqFKWu1URvtX/vZ1E5lxVEXGZBfvBeQNxveR3zh2byMRHKRGALG0XP
         9kDJ1XxKLDHF/62urfc6sVEDTxQYmkd0TXdK9ntF/Ukw2qb/rvQBD0L42erA/jCGauup
         wjWhmZIR2km4bEecyuzfiQ4a8mH+CtcRiyHkSgjILkgw1nEq5MwDPe02+dQpd9hg0M7/
         GvtGRd/Bo5w8QDle6LsHPw4p8e7OQG04tjVpK5kH5v/PoneiYlCrFlitv20MzuEcl+IW
         UdeA==
X-Gm-Message-State: AOAM532MvWPwNqc6PIW/FNpChTY3Azm32kmULQPbs9OGq3wlLQWbgzO9
        9bKXASrz5h8MKyrVLmtedjPHSL5ijyW3bJ/wDkOqXdrTWfI=
X-Google-Smtp-Source: ABdhPJzLIqU5QEAA8yLgpEZArEDWX5YXvR4O21fwBh+MWX1OO+CqnW1xAAREU248F3hIyGJ8giO/+yW432lfLQso3LM=
X-Received: by 2002:a67:3093:: with SMTP id w141mr11308457vsw.24.1639087623087;
 Thu, 09 Dec 2021 14:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20211208234325.521207-1-luiz.dentz@gmail.com> <20211208234325.521207-2-luiz.dentz@gmail.com>
 <3FD8B82A-A9DD-45F1-B5DD-C74CAC290A0C@holtmann.org>
In-Reply-To: <3FD8B82A-A9DD-45F1-B5DD-C74CAC290A0C@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 9 Dec 2021 14:06:52 -0800
Message-ID: <CABBYNZJ8ySFasBUztd4=4RHKk5sya2CAJ50Lm6RKViwGc2q7yg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_sync: Add hci_le_create_conn_sync
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

 aHi Marcel,

On Thu, Dec 9, 2021 at 2:53 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds hci_le_create_conn_sync and make hci_le_connect use it instea=
d
> > of queueing multiple commands which may conflict with the likes of
> > hci_update_passive_scan which uses hci_cmd_sync_queue.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/hci_core.h |   1 +
> > include/net/bluetooth/hci_sync.h |   4 +
> > net/bluetooth/hci_conn.c         | 304 ++-----------------------------
> > net/bluetooth/hci_request.c      |  50 -----
> > net/bluetooth/hci_request.h      |   2 -
> > net/bluetooth/hci_sync.c         | 295 ++++++++++++++++++++++++++++++
> > 6 files changed, 315 insertions(+), 341 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 4d69dcfebd63..c41ad7847d9d 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -646,6 +646,7 @@ struct hci_conn {
> >       __u8            init_addr_type;
> >       bdaddr_t        resp_addr;
> >       __u8            resp_addr_type;
> > +     bdaddr_t        direct_rpa;
>
> isn=E2=80=99t this a separate fix we might want to do first?

It is related to the changes since Im using hci_cmd_sync_queue and I
was passing hci_conn so I used it to store the address used in case
the remote device is using a directed advertising, I could use some
other field e.g. init_addr but that would require some other changes
as well.

> >       __u8            adv_instance;
> >       __u16           handle;
> >       __u16           state;
> > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/h=
ci_sync.h
> > index f4034bf8f1ce..0d2a75d88e7c 100644
> > --- a/include/net/bluetooth/hci_sync.h
> > +++ b/include/net/bluetooth/hci_sync.h
> > @@ -101,3 +101,7 @@ int hci_stop_discovery_sync(struct hci_dev *hdev);
> >
> > int hci_suspend_sync(struct hci_dev *hdev);
> > int hci_resume_sync(struct hci_dev *hdev);
> > +
> > +struct hci_conn;
> > +
> > +int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *con=
n);
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index cd6e1cf7e396..254c0e4ed181 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -911,267 +911,45 @@ void hci_le_conn_failed(struct hci_conn *conn, u=
8 status)
> >       hci_enable_advertising(hdev);
> > }
> >
> > -static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u=
16 opcode)
> > +static void create_le_conn_complete(struct hci_dev *hdev, void *data, =
int err)
> > {
> > -     struct hci_conn *conn;
> > +     struct hci_conn *conn =3D data;
> >
> >       hci_dev_lock(hdev);
> >
> > -     conn =3D hci_lookup_le_connect(hdev);
> > -
> > -     if (hdev->adv_instance_cnt)
> > -             hci_req_resume_adv_instances(hdev);
> > -
> > -     if (!status) {
> > +     if (!err) {
> >               hci_connect_le_scan_cleanup(conn);
> >               goto done;
> >       }
> >
> > -     bt_dev_err(hdev, "request failed to create LE connection: "
> > -                "status 0x%2.2x", status);
> > +     bt_dev_err(hdev, "request failed to create LE connection: err %d"=
, err);
> >
> >       if (!conn)
> >               goto done;
> >
> > -     hci_le_conn_failed(conn, status);
> > +     hci_le_conn_failed(conn, err);
> >
> > done:
> >       hci_dev_unlock(hdev);
> > }
> >
> > -static bool conn_use_rpa(struct hci_conn *conn)
> > +static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
> > {
> > -     struct hci_dev *hdev =3D conn->hdev;
> > +     struct hci_conn *conn =3D data;
> >
> > -     return hci_dev_test_flag(hdev, HCI_PRIVACY);
> > -}
> > +     bt_dev_dbg(hdev, "conn %p", conn);
> >
> > -static void set_ext_conn_params(struct hci_conn *conn,
> > -                             struct hci_cp_le_ext_conn_param *p)
> > -{
> > -     struct hci_dev *hdev =3D conn->hdev;
> > -
> > -     memset(p, 0, sizeof(*p));
> > -
> > -     p->scan_interval =3D cpu_to_le16(hdev->le_scan_int_connect);
> > -     p->scan_window =3D cpu_to_le16(hdev->le_scan_window_connect);
> > -     p->conn_interval_min =3D cpu_to_le16(conn->le_conn_min_interval);
> > -     p->conn_interval_max =3D cpu_to_le16(conn->le_conn_max_interval);
> > -     p->conn_latency =3D cpu_to_le16(conn->le_conn_latency);
> > -     p->supervision_timeout =3D cpu_to_le16(conn->le_supv_timeout);
> > -     p->min_ce_len =3D cpu_to_le16(0x0000);
> > -     p->max_ce_len =3D cpu_to_le16(0x0000);
> > -}
> > -
> > -static void hci_req_add_le_create_conn(struct hci_request *req,
> > -                                    struct hci_conn *conn,
> > -                                    bdaddr_t *direct_rpa)
> > -{
> > -     struct hci_dev *hdev =3D conn->hdev;
> > -     u8 own_addr_type;
> > -
> > -     /* If direct address was provided we use it instead of current
> > -      * address.
> > -      */
> > -     if (direct_rpa) {
> > -             if (bacmp(&req->hdev->random_addr, direct_rpa))
> > -                     hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
> > -                                                             direct_rp=
a);
> > -
> > -             /* direct address is always RPA */
> > -             own_addr_type =3D ADDR_LE_DEV_RANDOM;
> > -     } else {
> > -             /* Update random address, but set require_privacy to fals=
e so
> > -              * that we never connect with an non-resolvable address.
> > -              */
> > -             if (hci_update_random_address(req, false, conn_use_rpa(co=
nn),
> > -                                           &own_addr_type))
> > -                     return;
> > -     }
> > -
> > -     if (use_ext_conn(hdev)) {
> > -             struct hci_cp_le_ext_create_conn *cp;
> > -             struct hci_cp_le_ext_conn_param *p;
> > -             u8 data[sizeof(*cp) + sizeof(*p) * 3];
> > -             u32 plen;
> > -
> > -             cp =3D (void *) data;
> > -             p =3D (void *) cp->data;
> > -
> > -             memset(cp, 0, sizeof(*cp));
> > -
> > -             bacpy(&cp->peer_addr, &conn->dst);
> > -             cp->peer_addr_type =3D conn->dst_type;
> > -             cp->own_addr_type =3D own_addr_type;
> > -
> > -             plen =3D sizeof(*cp);
> > -
> > -             if (scan_1m(hdev)) {
> > -                     cp->phys |=3D LE_SCAN_PHY_1M;
> > -                     set_ext_conn_params(conn, p);
> > -
> > -                     p++;
> > -                     plen +=3D sizeof(*p);
> > -             }
> > -
> > -             if (scan_2m(hdev)) {
> > -                     cp->phys |=3D LE_SCAN_PHY_2M;
> > -                     set_ext_conn_params(conn, p);
> > -
> > -                     p++;
> > -                     plen +=3D sizeof(*p);
> > -             }
> > -
> > -             if (scan_coded(hdev)) {
> > -                     cp->phys |=3D LE_SCAN_PHY_CODED;
> > -                     set_ext_conn_params(conn, p);
> > -
> > -                     plen +=3D sizeof(*p);
> > -             }
> > -
> > -             hci_req_add(req, HCI_OP_LE_EXT_CREATE_CONN, plen, data);
> > -
> > -     } else {
> > -             struct hci_cp_le_create_conn cp;
> > -
> > -             memset(&cp, 0, sizeof(cp));
> > -
> > -             cp.scan_interval =3D cpu_to_le16(hdev->le_scan_int_connec=
t);
> > -             cp.scan_window =3D cpu_to_le16(hdev->le_scan_window_conne=
ct);
> > -
> > -             bacpy(&cp.peer_addr, &conn->dst);
> > -             cp.peer_addr_type =3D conn->dst_type;
> > -             cp.own_address_type =3D own_addr_type;
> > -             cp.conn_interval_min =3D cpu_to_le16(conn->le_conn_min_in=
terval);
> > -             cp.conn_interval_max =3D cpu_to_le16(conn->le_conn_max_in=
terval);
> > -             cp.conn_latency =3D cpu_to_le16(conn->le_conn_latency);
> > -             cp.supervision_timeout =3D cpu_to_le16(conn->le_supv_time=
out);
> > -             cp.min_ce_len =3D cpu_to_le16(0x0000);
> > -             cp.max_ce_len =3D cpu_to_le16(0x0000);
> > -
> > -             hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> > -     }
> > -
> > -     conn->state =3D BT_CONNECT;
> > -     clear_bit(HCI_CONN_SCANNING, &conn->flags);
> > -}
> > -
> > -static void hci_req_directed_advertising(struct hci_request *req,
> > -                                      struct hci_conn *conn)
> > -{
> > -     struct hci_dev *hdev =3D req->hdev;
> > -     u8 own_addr_type;
> > -     u8 enable;
> > -
> > -     if (ext_adv_capable(hdev)) {
> > -             struct hci_cp_le_set_ext_adv_params cp;
> > -             bdaddr_t random_addr;
> > -
> > -             /* Set require_privacy to false so that the remote device=
 has a
> > -              * chance of identifying us.
> > -              */
> > -             if (hci_get_random_address(hdev, false, conn_use_rpa(conn=
), NULL,
> > -                                        &own_addr_type, &random_addr) =
< 0)
> > -                     return;
> > -
> > -             memset(&cp, 0, sizeof(cp));
> > -
> > -             cp.evt_properties =3D cpu_to_le16(LE_LEGACY_ADV_DIRECT_IN=
D);
> > -             cp.own_addr_type =3D own_addr_type;
> > -             cp.channel_map =3D hdev->le_adv_channel_map;
> > -             cp.tx_power =3D HCI_TX_POWER_INVALID;
> > -             cp.primary_phy =3D HCI_ADV_PHY_1M;
> > -             cp.secondary_phy =3D HCI_ADV_PHY_1M;
> > -             cp.handle =3D 0; /* Use instance 0 for directed adv */
> > -             cp.own_addr_type =3D own_addr_type;
> > -             cp.peer_addr_type =3D conn->dst_type;
> > -             bacpy(&cp.peer_addr, &conn->dst);
> > -
> > -             /* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
> > -              * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
> > -              * does not supports advertising data when the advertisin=
g set already
> > -              * contains some, the controller shall return erroc code =
'Invalid
> > -              * HCI Command Parameters(0x12).
> > -              * So it is required to remove adv set for handle 0x00. s=
ince we use
> > -              * instance 0 for directed adv.
> > -              */
> > -             __hci_req_remove_ext_adv_instance(req, cp.handle);
> > -
> > -             hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp)=
, &cp);
> > -
> > -             if (own_addr_type =3D=3D ADDR_LE_DEV_RANDOM &&
> > -                 bacmp(&random_addr, BDADDR_ANY) &&
> > -                 bacmp(&random_addr, &hdev->random_addr)) {
> > -                     struct hci_cp_le_set_adv_set_rand_addr cp;
> > -
> > -                     memset(&cp, 0, sizeof(cp));
> > -
> > -                     cp.handle =3D 0;
> > -                     bacpy(&cp.bdaddr, &random_addr);
> > -
> > -                     hci_req_add(req,
> > -                                 HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> > -                                 sizeof(cp), &cp);
> > -             }
> > -
> > -             __hci_req_enable_ext_advertising(req, 0x00);
> > -     } else {
> > -             struct hci_cp_le_set_adv_param cp;
> > -
> > -             /* Clear the HCI_LE_ADV bit temporarily so that the
> > -              * hci_update_random_address knows that it's safe to go a=
head
> > -              * and write a new random address. The flag will be set b=
ack on
> > -              * as soon as the SET_ADV_ENABLE HCI command completes.
> > -              */
> > -             hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > -
> > -             /* Set require_privacy to false so that the remote device=
 has a
> > -              * chance of identifying us.
> > -              */
> > -             if (hci_update_random_address(req, false, conn_use_rpa(co=
nn),
> > -                                           &own_addr_type) < 0)
> > -                     return;
> > -
> > -             memset(&cp, 0, sizeof(cp));
> > -
> > -             /* Some controllers might reject command if intervals are=
 not
> > -              * within range for undirected advertising.
> > -              * BCM20702A0 is known to be affected by this.
> > -              */
> > -             cp.min_interval =3D cpu_to_le16(0x0020);
> > -             cp.max_interval =3D cpu_to_le16(0x0020);
> > -
> > -             cp.type =3D LE_ADV_DIRECT_IND;
> > -             cp.own_address_type =3D own_addr_type;
> > -             cp.direct_addr_type =3D conn->dst_type;
> > -             bacpy(&cp.direct_addr, &conn->dst);
> > -             cp.channel_map =3D hdev->le_adv_channel_map;
> > -
> > -             hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp=
);
> > -
> > -             enable =3D 0x01;
> > -             hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable)=
,
> > -                         &enable);
> > -     }
> > -
> > -     conn->state =3D BT_CONNECT;
> > +     return hci_le_create_conn_sync(hdev, conn);
> > }
> >
> > struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> >                               u8 dst_type, bool dst_resolved, u8 sec_le=
vel,
> >                               u16 conn_timeout, u8 role, bdaddr_t *dire=
ct_rpa)
> > {
> > -     struct hci_conn_params *params;
> >       struct hci_conn *conn;
> >       struct smp_irk *irk;
> > -     struct hci_request req;
> >       int err;
> >
> > -     /* This ensures that during disable le_scan address resolution
> > -      * will not be disabled if it is followed by le_create_conn
> > -      */
> > -     bool rpa_le_conn =3D true;
> > -
> >       /* Let's make sure that le is enabled.*/
> >       if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
> >               if (lmp_le_capable(hdev))
> > @@ -1230,68 +1008,16 @@ struct hci_conn *hci_connect_le(struct hci_dev =
*hdev, bdaddr_t *dst,
> >       conn->sec_level =3D BT_SECURITY_LOW;
> >       conn->conn_timeout =3D conn_timeout;
> >
> > -     hci_req_init(&req, hdev);
> > -
> > -     /* Disable advertising if we're active. For central role
> > -      * connections most controllers will refuse to connect if
> > -      * advertising is enabled, and for peripheral role connections we
> > -      * anyway have to disable it in order to start directed
> > -      * advertising. Any registered advertisements will be
> > -      * re-enabled after the connection attempt is finished.
> > -      */
> > -     if (hci_dev_test_flag(hdev, HCI_LE_ADV))
> > -             __hci_req_pause_adv_instances(&req);
> > -
> > -     /* If requested to connect as peripheral use directed advertising=
 */
> > -     if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> > -             /* If we're active scanning most controllers are unable
> > -              * to initiate advertising. Simply reject the attempt.
> > -              */
> > -             if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
> > -                 hdev->le_scan_type =3D=3D LE_SCAN_ACTIVE) {
> > -                     hci_req_purge(&req);
> > -                     hci_conn_del(conn);
> > -                     return ERR_PTR(-EBUSY);
> > -             }
> > -
> > -             hci_req_directed_advertising(&req, conn);
> > -             goto create_conn;
> > -     }
> > -
> > -     params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
> > -     if (params) {
> > -             conn->le_conn_min_interval =3D params->conn_min_interval;
> > -             conn->le_conn_max_interval =3D params->conn_max_interval;
> > -             conn->le_conn_latency =3D params->conn_latency;
> > -             conn->le_supv_timeout =3D params->supervision_timeout;
> > -     } else {
> > -             conn->le_conn_min_interval =3D hdev->le_conn_min_interval=
;
> > -             conn->le_conn_max_interval =3D hdev->le_conn_max_interval=
;
> > -             conn->le_conn_latency =3D hdev->le_conn_latency;
> > -             conn->le_supv_timeout =3D hdev->le_supv_timeout;
> > -     }
> > -
> > -     /* If controller is scanning, we stop it since some controllers a=
re
> > -      * not able to scan and connect at the same time. Also set the
> > -      * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
> > -      * handler for scan disabling knows to set the correct discovery
> > -      * state.
> > -      */
> > -     if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
> > -             hci_req_add_le_scan_disable(&req, rpa_le_conn);
> > -             hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
> > -     }
> > +     if (direct_rpa)
> > +             bacpy(&conn->direct_rpa, direct_rpa);
> >
> > -     hci_req_add_le_create_conn(&req, conn, direct_rpa);
> > +     conn->state =3D BT_CONNECT;
> > +     clear_bit(HCI_CONN_SCANNING, &conn->flags);
> >
> > -create_conn:
> > -     err =3D hci_req_run(&req, create_le_conn_complete);
> > +     err =3D hci_cmd_sync_queue(hdev, hci_connect_le_sync, conn,
> > +                              create_le_conn_complete);
> >       if (err) {
> >               hci_conn_del(conn);
> > -
> > -             if (hdev->adv_instance_cnt)
> > -                     hci_req_resume_adv_instances(hdev);
> > -
> >               return ERR_PTR(err);
> >       }
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 329c66456cf1..b61373ac7bb7 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -818,56 +818,6 @@ static void cancel_adv_timeout(struct hci_dev *hde=
v)
> >       }
> > }
> >
> > -/* This function requires the caller holds hdev->lock */
> > -void __hci_req_pause_adv_instances(struct hci_request *req)
> > -{
> > -     bt_dev_dbg(req->hdev, "Pausing advertising instances");
> > -
> > -     /* Call to disable any advertisements active on the controller.
> > -      * This will succeed even if no advertisements are configured.
> > -      */
> > -     __hci_req_disable_advertising(req);
> > -
> > -     /* If we are using software rotation, pause the loop */
> > -     if (!ext_adv_capable(req->hdev))
> > -             cancel_adv_timeout(req->hdev);
> > -}
> > -
> > -/* This function requires the caller holds hdev->lock */
> > -static void __hci_req_resume_adv_instances(struct hci_request *req)
> > -{
> > -     struct adv_info *adv;
> > -
> > -     bt_dev_dbg(req->hdev, "Resuming advertising instances");
> > -
> > -     if (ext_adv_capable(req->hdev)) {
> > -             /* Call for each tracked instance to be re-enabled */
> > -             list_for_each_entry(adv, &req->hdev->adv_instances, list)=
 {
> > -                     __hci_req_enable_ext_advertising(req,
> > -                                                      adv->instance);
> > -             }
> > -
> > -     } else {
> > -             /* Schedule for most recent instance to be restarted and =
begin
> > -              * the software rotation loop
> > -              */
> > -             __hci_req_schedule_adv_instance(req,
> > -                                             req->hdev->cur_adv_instan=
ce,
> > -                                             true);
> > -     }
> > -}
> > -
> > -/* This function requires the caller holds hdev->lock */
> > -int hci_req_resume_adv_instances(struct hci_dev *hdev)
> > -{
> > -     struct hci_request req;
> > -
> > -     hci_req_init(&req, hdev);
> > -     __hci_req_resume_adv_instances(&req);
> > -
> > -     return hci_req_run(&req, NULL);
> > -}
> > -
> > static bool adv_cur_instance_is_scannable(struct hci_dev *hdev)
> > {
> >       return hci_adv_instance_is_scannable(hdev, hdev->cur_adv_instance=
);
> > diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
> > index 8d39e9416861..7f8df258e295 100644
> > --- a/net/bluetooth/hci_request.h
> > +++ b/net/bluetooth/hci_request.h
> > @@ -80,8 +80,6 @@ void hci_req_add_le_passive_scan(struct hci_request *=
req);
> > void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state=
 next);
> >
> > void hci_req_disable_address_resolution(struct hci_dev *hdev);
> > -void __hci_req_pause_adv_instances(struct hci_request *req);
> > -int hci_req_resume_adv_instances(struct hci_dev *hdev);
> > void hci_req_reenable_advertising(struct hci_dev *hdev);
> > void __hci_req_enable_advertising(struct hci_request *req);
> > void __hci_req_disable_advertising(struct hci_request *req);
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index fd15fb37a52a..57a96a66f007 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -4974,3 +4974,298 @@ int hci_resume_sync(struct hci_dev *hdev)
> >
> >       return 0;
> > }
> > +
> > +static bool conn_use_rpa(struct hci_conn *conn)
> > +{
> > +     struct hci_dev *hdev =3D conn->hdev;
> > +
> > +     return hci_dev_test_flag(hdev, HCI_PRIVACY);
> > +}
> > +
> > +static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
> > +                                             struct hci_conn *conn)
> > +{
> > +     struct hci_cp_le_set_ext_adv_params cp;
> > +     int err;
> > +     bdaddr_t random_addr;
> > +     u8 own_addr_type;
> > +
> > +     err =3D hci_update_random_address_sync(hdev, false, conn_use_rpa(=
conn),
> > +                                          &own_addr_type);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Set require_privacy to false so that the remote device has a
> > +      * chance of identifying us.
> > +      */
> > +     err =3D hci_get_random_address(hdev, false, conn_use_rpa(conn), N=
ULL,
> > +                                  &own_addr_type, &random_addr);
> > +     if (err)
> > +             return err;
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +
> > +     cp.evt_properties =3D cpu_to_le16(LE_LEGACY_ADV_DIRECT_IND);
> > +     cp.own_addr_type =3D own_addr_type;
> > +     cp.channel_map =3D hdev->le_adv_channel_map;
> > +     cp.tx_power =3D HCI_TX_POWER_INVALID;
> > +     cp.primary_phy =3D HCI_ADV_PHY_1M;
> > +     cp.secondary_phy =3D HCI_ADV_PHY_1M;
> > +     cp.handle =3D 0x00; /* Use instance 0 for directed adv */
> > +     cp.own_addr_type =3D own_addr_type;
> > +     cp.peer_addr_type =3D conn->dst_type;
> > +     bacpy(&cp.peer_addr, &conn->dst);
> > +
> > +     /* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
> > +      * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
> > +      * does not supports advertising data when the advertising set al=
ready
> > +      * contains some, the controller shall return erroc code 'Invalid
> > +      * HCI Command Parameters(0x12).
> > +      * So it is required to remove adv set for handle 0x00. since we =
use
> > +      * instance 0 for directed adv.
> > +      */
> > +     err =3D hci_remove_ext_adv_instance_sync(hdev, cp.handle, NULL);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
> > +                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Check if random address need to be updated */
> > +     if (own_addr_type =3D=3D ADDR_LE_DEV_RANDOM &&
> > +         bacmp(&random_addr, BDADDR_ANY) &&
> > +         bacmp(&random_addr, &hdev->random_addr)) {
> > +             err =3D hci_set_adv_set_random_addr_sync(hdev, 0x00,
> > +                                                    &random_addr);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     return hci_enable_ext_advertising_sync(hdev, 0x00);
> > +}
> > +
> > +static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
> > +                                         struct hci_conn *conn)
> > +{
> > +     struct hci_cp_le_set_adv_param cp;
> > +     u8 status;
> > +     u8 own_addr_type;
> > +     u8 enable;
> > +
> > +     if (ext_adv_capable(hdev))
> > +             return hci_le_ext_directed_advertising_sync(hdev, conn);
> > +
> > +     /* Clear the HCI_LE_ADV bit temporarily so that the
> > +      * hci_update_random_address knows that it's safe to go ahead
> > +      * and write a new random address. The flag will be set back on
> > +      * as soon as the SET_ADV_ENABLE HCI command completes.
> > +      */
> > +     hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > +
> > +     /* Set require_privacy to false so that the remote device has a
> > +      * chance of identifying us.
> > +      */
> > +     status =3D hci_update_random_address_sync(hdev, false, conn_use_r=
pa(conn),
> > +                                             &own_addr_type);
> > +     if (status)
> > +             return status;
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +
> > +     /* Some controllers might reject command if intervals are not
> > +      * within range for undirected advertising.
> > +      * BCM20702A0 is known to be affected by this.
> > +      */
> > +     cp.min_interval =3D cpu_to_le16(0x0020);
> > +     cp.max_interval =3D cpu_to_le16(0x0020);
> > +
> > +     cp.type =3D LE_ADV_DIRECT_IND;
> > +     cp.own_address_type =3D own_addr_type;
> > +     cp.direct_addr_type =3D conn->dst_type;
> > +     bacpy(&cp.direct_addr, &conn->dst);
> > +     cp.channel_map =3D hdev->le_adv_channel_map;
> > +
> > +     status =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_PARAM,
> > +                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +     if (status)
> > +             return status;
> > +
> > +     enable =3D 0x01;
> > +
> > +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> > +                                  sizeof(enable), &enable, HCI_CMD_TIM=
EOUT);
> > +}
> > +
> > +static void set_ext_conn_params(struct hci_conn *conn,
> > +                             struct hci_cp_le_ext_conn_param *p)
> > +{
> > +     struct hci_dev *hdev =3D conn->hdev;
> > +
> > +     memset(p, 0, sizeof(*p));
> > +
> > +     p->scan_interval =3D cpu_to_le16(hdev->le_scan_int_connect);
> > +     p->scan_window =3D cpu_to_le16(hdev->le_scan_window_connect);
> > +     p->conn_interval_min =3D cpu_to_le16(conn->le_conn_min_interval);
> > +     p->conn_interval_max =3D cpu_to_le16(conn->le_conn_max_interval);
> > +     p->conn_latency =3D cpu_to_le16(conn->le_conn_latency);
> > +     p->supervision_timeout =3D cpu_to_le16(conn->le_supv_timeout);
> > +     p->min_ce_len =3D cpu_to_le16(0x0000);
> > +     p->max_ce_len =3D cpu_to_le16(0x0000);
> > +}
> > +
> > +int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn =
*conn,
> > +                             u8 own_addr_type)
> > +{
> > +     struct hci_cp_le_ext_create_conn *cp;
> > +     struct hci_cp_le_ext_conn_param *p;
> > +     u8 data[sizeof(*cp) + sizeof(*p) * 3];
> > +     u32 plen;
> > +
> > +     cp =3D (void *)data;
> > +     p =3D (void *)cp->data;
> > +
> > +     memset(cp, 0, sizeof(*cp));
> > +
> > +     bacpy(&cp->peer_addr, &conn->dst);
> > +     cp->peer_addr_type =3D conn->dst_type;
> > +     cp->own_addr_type =3D own_addr_type;
> > +
> > +     plen =3D sizeof(*cp);
> > +
> > +     if (scan_1m(hdev)) {
> > +             cp->phys |=3D LE_SCAN_PHY_1M;
> > +             set_ext_conn_params(conn, p);
> > +
> > +             p++;
> > +             plen +=3D sizeof(*p);
> > +     }
> > +
> > +     if (scan_2m(hdev)) {
> > +             cp->phys |=3D LE_SCAN_PHY_2M;
> > +             set_ext_conn_params(conn, p);
> > +
> > +             p++;
> > +             plen +=3D sizeof(*p);
> > +     }
> > +
> > +     if (scan_coded(hdev)) {
> > +             cp->phys |=3D LE_SCAN_PHY_CODED;
> > +             set_ext_conn_params(conn, p);
> > +
> > +             plen +=3D sizeof(*p);
> > +     }
> > +
> > +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
> > +                                  plen, data, HCI_CMD_TIMEOUT);
> > +}
> > +
> > +int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *con=
n)
> > +{
> > +     struct hci_cp_le_create_conn cp;
> > +     struct hci_conn_params *params;
> > +     u8 own_addr_type;
> > +     int err;
> > +
> > +     /* Disable advertising if we're active. For central role
> > +      * connections most controllers will refuse to connect if
> > +      * advertising is enabled, and for peripheral role connections we
> > +      * anyway have to disable it in order to start directed
> > +      * advertising. Any registered advertisements will be
> > +      * re-enabled after the connection attempt is finished.
> > +      */
> > +     hci_pause_advertising_sync(hdev);
> > +
> > +     /* If requested to connect as peripheral use directed advertising=
 */
> > +     if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> > +             /* If we're active scanning most controllers are unable
> > +              * to initiate advertising. Simply reject the attempt.
> > +              */
> > +             if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
> > +                 hdev->le_scan_type =3D=3D LE_SCAN_ACTIVE) {
> > +                     hci_conn_del(conn);
> > +                     return -EBUSY;
> > +             }
> > +
> > +             err =3D hci_le_directed_advertising_sync(hdev, conn);
> > +             goto done;
> > +     }
> > +
> > +     params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
> > +     if (params) {
> > +             conn->le_conn_min_interval =3D params->conn_min_interval;
> > +             conn->le_conn_max_interval =3D params->conn_max_interval;
> > +             conn->le_conn_latency =3D params->conn_latency;
> > +             conn->le_supv_timeout =3D params->supervision_timeout;
> > +     } else {
> > +             conn->le_conn_min_interval =3D hdev->le_conn_min_interval=
;
> > +             conn->le_conn_max_interval =3D hdev->le_conn_max_interval=
;
> > +             conn->le_conn_latency =3D hdev->le_conn_latency;
> > +             conn->le_supv_timeout =3D hdev->le_supv_timeout;
> > +     }
> > +
> > +     /* If direct address was provided we use it instead of current
> > +      * address.
> > +      */
> > +     if (bacmp(&conn->direct_rpa, BDADDR_ANY)) {
> > +             if (bacmp(&hdev->random_addr, &conn->direct_rpa)) {
> > +                     err =3D __hci_cmd_sync_status(hdev,
> > +                                                 HCI_OP_LE_SET_RANDOM_=
ADDR,
> > +                                                 6, &conn->direct_rpa,
> > +                                                 HCI_CMD_TIMEOUT);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +
> > +             /* direct address is always RPA */
> > +             own_addr_type =3D ADDR_LE_DEV_RANDOM;
> > +     } else {
> > +             /* Update random address, but set require_privacy to fals=
e so
> > +              * that we never connect with an non-resolvable address.
> > +              */
> > +             err =3D hci_update_random_address_sync(hdev, false,
> > +                                                  conn_use_rpa(conn),
> > +                                                  &own_addr_type);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     /* If controller is scanning, we stop it since some controllers a=
re
> > +      * not able to scan and connect at the same time. Also set the
> > +      * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
> > +      * handler for scan disabling knows to set the correct discovery
> > +      * state.
> > +      */
> > +     if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
> > +             hci_scan_disable_sync(hdev);
> > +             hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
> > +     }
> > +
> > +     if (use_ext_conn(hdev)) {
> > +             err =3D hci_le_ext_create_conn_sync(hdev, conn, own_addr_=
type);
> > +             goto done;
> > +     }
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +
> > +     cp.scan_interval =3D cpu_to_le16(hdev->le_scan_int_connect);
> > +     cp.scan_window =3D cpu_to_le16(hdev->le_scan_window_connect);
> > +
> > +     bacpy(&cp.peer_addr, &conn->dst);
> > +     cp.peer_addr_type =3D conn->dst_type;
> > +     cp.own_address_type =3D own_addr_type;
> > +     cp.conn_interval_min =3D cpu_to_le16(conn->le_conn_min_interval);
> > +     cp.conn_interval_max =3D cpu_to_le16(conn->le_conn_max_interval);
> > +     cp.conn_latency =3D cpu_to_le16(conn->le_conn_latency);
> > +     cp.supervision_timeout =3D cpu_to_le16(conn->le_supv_timeout);
> > +     cp.min_ce_len =3D cpu_to_le16(0x0000);
> > +     cp.max_ce_len =3D cpu_to_le16(0x0000);
> > +
> > +     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN,
> > +                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +
> > +done:
> > +     hci_resume_advertising_sync(hdev);
> > +     return err;
> > +}
>
> so while we can do that as interim, I think we need spent a few cycles th=
inking about on how we want to do commands that have a command status and t=
hen a dedicated event.
>
> The pattern of doing synchronous things like this:
>
>         pause_advertising
>
>         send_connect + wait_for_cmd_status
>
>         resume_advertising
>
> Is in general a good pattern, but especially with the connect handling, w=
e always end up having to send further commands after a successful connect =
complete event.

I guess you are saying that we should wait for Connection Complete
before we resume the advertising, which I guess that would correct but
the existing code in hci_req_add_le_create_conn doesn't seems to be
doing that so that would be a change in the behavior so I'd prefer to
have as a separate patch.

> So maybe we really need a __hci_cmd_sync_event(opcode, evcode, callback) =
type of handling that when the callback is called, you are back in a workqu=
eue where you can send new commands with __hci_cmd_sync. Except for inquiry=
 (which is weird with its own timeout handling), this might be good enough =
for all HCI commands that take some time and come back with an event. Of co=
urse there needs a way to cancel the command somehow.
>
> I am saying this, since eventually our hci_event.c handling should be the=
re for updating core status in case some external hcitool sends a command.
>
> That said, I am happy to apply this patch and then move forward with re-f=
actoring, but I am having a hard time reviewing this thing since it is rath=
er large and complex. Do we have enough test coverage on it?

There is some code already in the form of
__hci_cmd_sync_ev/__hci_cmd_sync_sk where one can have a dedicated
event to wait for, we do use it in hci_disconnect_sync where we wait
for HCI_EV_DISCONN_COMPLETE instead of HCI_EV_CMD_STATUS:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/net/bluetooth/hci_sync.c#n4300

I suspect we want something similar for
HCI_OP_LE_CREATE_CONN/HCI_OP_LE_EXT_CREATE_CONN, something like the
following:

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 57a96a66f007..94c42fd9bdec 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5157,8 +5157,10 @@ int hci_le_ext_create_conn_sync(struct hci_dev
*hdev, struct hci_conn *conn,
                plen +=3D sizeof(*p);
        }

-       return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
-                                    plen, data, HCI_CMD_TIMEOUT);
+       return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN,
+                                       plen, data,
+                                       HCI_EV_LE_ENHANCED_CONN_COMPLETE,
+                                       HCI_CMD_TIMEOUT, NULL);
 }

 int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -5262,8 +5264,9 @@ int hci_le_create_conn_sync(struct hci_dev
*hdev, struct hci_conn *conn)
        cp.min_ce_len =3D cpu_to_le16(0x0000);
        cp.max_ce_len =3D cpu_to_le16(0x0000);

-       err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN,
-                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
+                                      sizeof(cp), &cp, HCI_EV_LE_CONN_COMP=
LETE,
+                                      HCI_CMD_TIMEOUT, NULL);

 done:
        hci_resume_advertising_sync(hdev);

The problem is that hci_event_packet code don't seem to be able to
wait for LE subevents like above, so it only works with events in
hci_ev_table while we want also the LE subevents in hci_le_ev_table,
so we would likely need to extend the req_event matching and perhaps
add something like req_le_event to get this working properly.

--=20
Luiz Augusto von Dentz
