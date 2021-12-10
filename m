Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7079C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Dec 2021 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbhLJVnN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Dec 2021 16:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbhLJVnN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Dec 2021 16:43:13 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BBAC061746
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Dec 2021 13:39:37 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 84so6841197vkc.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Dec 2021 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8SxNqnUKirLu6diwy1neAH8lkyPDQAkRZ+49Tramtb4=;
        b=Zs2UAF4r6Yitf/uJWYz5/gn0HDVpyFwfIcjAm1ntabVoW6XUiZ7mD7FGDhs27MaM/M
         SpEkR+eH6edG+pvdLarjKcdUXelrnH7K/W+LdlDygqsn878GyL8BdmZkw4EAEh9s13Lm
         CxjfI44W2pExMPvrho8xD65R2QQdGHS8nRXL9QJ77DjA2PU0FWGSh+YvOTi75yAKVYKW
         ZBu0l41KD/3JTouuw/pf1xeFPpM6U0ThB9BBXKhd9vs/cO6ZRJo/92I+CLTwJFoml+fT
         X78ZkrIbMFgSxQfnAIUcnMiBskLji4GJg5NACLbOoxmpUX56Fck0e+T49tsUIRs3LPfv
         Ly4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8SxNqnUKirLu6diwy1neAH8lkyPDQAkRZ+49Tramtb4=;
        b=i/Mk1FSOtjW2RVcTA7UNLxEE9vW5aGn/EPWmhb98NiWaTqshj3h5Itaj0imHs7jqrq
         gCMLyiIhYXDz0Jb1PMKAytFKxOpwyrFHtwPp3LXjGeJhYxICWfMn+U12VuKsY9oVm+Kq
         GXmuZO04v6Nm+4lmqgSaiGsq8LNEFfBTKnOW6syx8sYcvf6G5HCSEqfxtqRUwSoNiWGp
         p3OG5EFYtslNQDkkkeIhqUpB0JLo8J5AhwkMFTn1rxw8WdqgTP0hyWrKLEfb125ioap+
         0SMMtbVHST5hUxtMO2bSHmFE0MvsMT0ltp63pMrva7cPM4+f84qtZSpyjL2NyVkop0fj
         a/UA==
X-Gm-Message-State: AOAM533+ucgSopjEc2XoqLJpA1UoCvOoif/26vJASOJM1nA8xWqDRB/A
        rrVpXu3vFM/NRRrOUS3DcLF5OyRCW6IVcyUkRvzFY4q7PEY=
X-Google-Smtp-Source: ABdhPJxmEtVZ6ImuvDC9haAKu1EzgSfmsPt7xdSQvmSOBlCEdy5rb8ZMO7kabPdCObK5mPYM66lCt9F7LSUvo9af7c0=
X-Received: by 2002:a05:6122:d8d:: with SMTP id bc13mr22510947vkb.22.1639172375989;
 Fri, 10 Dec 2021 13:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20211208234325.521207-1-luiz.dentz@gmail.com> <20211208234325.521207-2-luiz.dentz@gmail.com>
 <3FD8B82A-A9DD-45F1-B5DD-C74CAC290A0C@holtmann.org> <CABBYNZJ8ySFasBUztd4=4RHKk5sya2CAJ50Lm6RKViwGc2q7yg@mail.gmail.com>
 <3A7497EC-D3D6-4F6C-82F5-5BF16E3CF56C@holtmann.org>
In-Reply-To: <3A7497EC-D3D6-4F6C-82F5-5BF16E3CF56C@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Dec 2021 13:39:25 -0800
Message-ID: <CABBYNZJ-CxA=B80v+2vnyZ4uZ_E8+so_XLDBkPGSnyAO6G7MPQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_sync: Add hci_le_create_conn_sync
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Dec 10, 2021 at 6:52 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> >>> This adds hci_le_create_conn_sync and make hci_le_connect use it inst=
ead
> >>> of queueing multiple commands which may conflict with the likes of
> >>> hci_update_passive_scan which uses hci_cmd_sync_queue.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> include/net/bluetooth/hci_core.h |   1 +
> >>> include/net/bluetooth/hci_sync.h |   4 +
> >>> net/bluetooth/hci_conn.c         | 304 ++----------------------------=
-
> >>> net/bluetooth/hci_request.c      |  50 -----
> >>> net/bluetooth/hci_request.h      |   2 -
> >>> net/bluetooth/hci_sync.c         | 295 ++++++++++++++++++++++++++++++
> >>> 6 files changed, 315 insertions(+), 341 deletions(-)
> >>>
> >>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> >>> index 4d69dcfebd63..c41ad7847d9d 100644
> >>> --- a/include/net/bluetooth/hci_core.h
> >>> +++ b/include/net/bluetooth/hci_core.h
> >>> @@ -646,6 +646,7 @@ struct hci_conn {
> >>>      __u8            init_addr_type;
> >>>      bdaddr_t        resp_addr;
> >>>      __u8            resp_addr_type;
> >>> +     bdaddr_t        direct_rpa;
> >>
> >> isn=E2=80=99t this a separate fix we might want to do first?
> >
> > It is related to the changes since Im using hci_cmd_sync_queue and I
> > was passing hci_conn so I used it to store the address used in case
> > the remote device is using a directed advertising, I could use some
> > other field e.g. init_addr but that would require some other changes
> > as well.
>
> at some point, we need to clean this up as well. We are storing too many =
addresses there. It is really a waste.

Actually I looking into this again it seems that what we are doing is
not right, the controller would only generate the directed report if
the address matches with the scanning, so if this is happening due to
address rotation it is is likely that HCI_OP_LE_SET_RANDOM_ADDR is
pending but we only update hdev->random_addr has the old address so
this wouldn't make any difference except that it would return rollback
the address.

> >
> >>>      __u8            adv_instance;
> >>>      __u16           handle;
> >>>      __u16           state;
> >>> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth=
/hci_sync.h
> >>> index f4034bf8f1ce..0d2a75d88e7c 100644
> >>> --- a/include/net/bluetooth/hci_sync.h
> >>> +++ b/include/net/bluetooth/hci_sync.h
> >>> @@ -101,3 +101,7 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)=
;
> >>>
> >>> int hci_suspend_sync(struct hci_dev *hdev);
> >>> int hci_resume_sync(struct hci_dev *hdev);
> >>> +
> >>> +struct hci_conn;
> >>> +
> >>> +int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *c=
onn);
> >>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >>> index cd6e1cf7e396..254c0e4ed181 100644
> >>> --- a/net/bluetooth/hci_conn.c
> >>> +++ b/net/bluetooth/hci_conn.c
> >>> @@ -911,267 +911,45 @@ void hci_le_conn_failed(struct hci_conn *conn,=
 u8 status)
> >>>      hci_enable_advertising(hdev);
> >>> }
> >>>
> >>> -static void create_le_conn_complete(struct hci_dev *hdev, u8 status,=
 u16 opcode)
> >>> +static void create_le_conn_complete(struct hci_dev *hdev, void *data=
, int err)
> >>> {
> >>> -     struct hci_conn *conn;
> >>> +     struct hci_conn *conn =3D data;
> >>>
> >>>      hci_dev_lock(hdev);
> >>>
> >>> -     conn =3D hci_lookup_le_connect(hdev);
> >>> -
> >>> -     if (hdev->adv_instance_cnt)
> >>> -             hci_req_resume_adv_instances(hdev);
> >>> -
> >>> -     if (!status) {
> >>> +     if (!err) {
> >>>              hci_connect_le_scan_cleanup(conn);
> >>>              goto done;
> >>>      }
> >>>
> >>> -     bt_dev_err(hdev, "request failed to create LE connection: "
> >>> -                "status 0x%2.2x", status);
> >>> +     bt_dev_err(hdev, "request failed to create LE connection: err %=
d", err);
> >>>
> >>>      if (!conn)
> >>>              goto done;
> >>>
> >>> -     hci_le_conn_failed(conn, status);
> >>> +     hci_le_conn_failed(conn, err);
> >>>
> >>> done:
> >>>      hci_dev_unlock(hdev);
> >>> }
> >>>
> >>> -static bool conn_use_rpa(struct hci_conn *conn)
> >>> +static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
> >>> {
> >>> -     struct hci_dev *hdev =3D conn->hdev;
> >>> +     struct hci_conn *conn =3D data;
> >>>
> >>> -     return hci_dev_test_flag(hdev, HCI_PRIVACY);
> >>> -}
> >>> +     bt_dev_dbg(hdev, "conn %p", conn);
> >>>
> >>> -static void set_ext_conn_params(struct hci_conn *conn,
> >>> -                             struct hci_cp_le_ext_conn_param *p)
> >>> -{
> >>> -     struct hci_dev *hdev =3D conn->hdev;
> >>> -
> >>> -     memset(p, 0, sizeof(*p));
> >>> -
> >>> -     p->scan_interval =3D cpu_to_le16(hdev->le_scan_int_connect);
> >>> -     p->scan_window =3D cpu_to_le16(hdev->le_scan_window_connect);
> >>> -     p->conn_interval_min =3D cpu_to_le16(conn->le_conn_min_interval=
);
> >>> -     p->conn_interval_max =3D cpu_to_le16(conn->le_conn_max_interval=
);
> >>> -     p->conn_latency =3D cpu_to_le16(conn->le_conn_latency);
> >>> -     p->supervision_timeout =3D cpu_to_le16(conn->le_supv_timeout);
> >>> -     p->min_ce_len =3D cpu_to_le16(0x0000);
> >>> -     p->max_ce_len =3D cpu_to_le16(0x0000);
> >>> -}
> >>> -
> >>> -static void hci_req_add_le_create_conn(struct hci_request *req,
> >>> -                                    struct hci_conn *conn,
> >>> -                                    bdaddr_t *direct_rpa)
> >>> -{
> >>> -     struct hci_dev *hdev =3D conn->hdev;
> >>> -     u8 own_addr_type;
> >>> -
> >>> -     /* If direct address was provided we use it instead of current
> >>> -      * address.
> >>> -      */
> >>> -     if (direct_rpa) {
> >>> -             if (bacmp(&req->hdev->random_addr, direct_rpa))
> >>> -                     hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
> >>> -                                                             direct_=
rpa);
> >>> -
> >>> -             /* direct address is always RPA */
> >>> -             own_addr_type =3D ADDR_LE_DEV_RANDOM;

This is probably broken with LL Privacy since it doesn't really use
hdev->random_addr in that case.

> >>> -     } else {
> >>> -             /* Update random address, but set require_privacy to fa=
lse so
> >>> -              * that we never connect with an non-resolvable address=
.
> >>> -              */
> >>> -             if (hci_update_random_address(req, false, conn_use_rpa(=
conn),
> >>> -                                           &own_addr_type))
> >>> -                     return;
> >>> -     }
> >>> -
> >>> -     if (use_ext_conn(hdev)) {
> >>> -             struct hci_cp_le_ext_create_conn *cp;
> >>> -             struct hci_cp_le_ext_conn_param *p;
> >>> -             u8 data[sizeof(*cp) + sizeof(*p) * 3];
> >>> -             u32 plen;
> >>> -
> >>> -             cp =3D (void *) data;
> >>> -             p =3D (void *) cp->data;
> >>> -
> >>> -             memset(cp, 0, sizeof(*cp));
> >>> -
> >>> -             bacpy(&cp->peer_addr, &conn->dst);
> >>> -             cp->peer_addr_type =3D conn->dst_type;
> >>> -             cp->own_addr_type =3D own_addr_type;
> >>> -
> >>> -             plen =3D sizeof(*cp);
> >>> -
> >>> -             if (scan_1m(hdev)) {
> >>> -                     cp->phys |=3D LE_SCAN_PHY_1M;
> >>> -                     set_ext_conn_params(conn, p);
> >>> -
> >>> -                     p++;
> >>> -                     plen +=3D sizeof(*p);
> >>> -             }
> >>> -
> >>> -             if (scan_2m(hdev)) {
> >>> -                     cp->phys |=3D LE_SCAN_PHY_2M;
> >>> -                     set_ext_conn_params(conn, p);
> >>> -
> >>> -                     p++;
> >>> -                     plen +=3D sizeof(*p);
> >>> -             }
> >>> -
> >>> -             if (scan_coded(hdev)) {
> >>> -                     cp->phys |=3D LE_SCAN_PHY_CODED;
> >>> -                     set_ext_conn_params(conn, p);
> >>> -
> >>> -                     plen +=3D sizeof(*p);
> >>> -             }
> >>> -
> >>> -             hci_req_add(req, HCI_OP_LE_EXT_CREATE_CONN, plen, data)=
;
> >>> -
> >>> -     } else {
> >>> -             struct hci_cp_le_create_conn cp;
> >>> -
> >>> -             memset(&cp, 0, sizeof(cp));
> >>> -
> >>> -             cp.scan_interval =3D cpu_to_le16(hdev->le_scan_int_conn=
ect);
> >>> -             cp.scan_window =3D cpu_to_le16(hdev->le_scan_window_con=
nect);
> >>> -
> >>> -             bacpy(&cp.peer_addr, &conn->dst);
> >>> -             cp.peer_addr_type =3D conn->dst_type;
> >>> -             cp.own_address_type =3D own_addr_type;
> >>> -             cp.conn_interval_min =3D cpu_to_le16(conn->le_conn_min_=
interval);
> >>> -             cp.conn_interval_max =3D cpu_to_le16(conn->le_conn_max_=
interval);
> >>> -             cp.conn_latency =3D cpu_to_le16(conn->le_conn_latency);
> >>> -             cp.supervision_timeout =3D cpu_to_le16(conn->le_supv_ti=
meout);
> >>> -             cp.min_ce_len =3D cpu_to_le16(0x0000);
> >>> -             cp.max_ce_len =3D cpu_to_le16(0x0000);
> >>> -
> >>> -             hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp=
);
> >>> -     }
> >>> -
> >>> -     conn->state =3D BT_CONNECT;
> >>> -     clear_bit(HCI_CONN_SCANNING, &conn->flags);
> >>> -}
> >>> -
> >>> -static void hci_req_directed_advertising(struct hci_request *req,
> >>> -                                      struct hci_conn *conn)
> >>> -{
> >>> -     struct hci_dev *hdev =3D req->hdev;
> >>> -     u8 own_addr_type;
> >>> -     u8 enable;
> >>> -
> >>> -     if (ext_adv_capable(hdev)) {
> >>> -             struct hci_cp_le_set_ext_adv_params cp;
> >>> -             bdaddr_t random_addr;
> >>> -
> >>> -             /* Set require_privacy to false so that the remote devi=
ce has a
> >>> -              * chance of identifying us.
> >>> -              */
> >>> -             if (hci_get_random_address(hdev, false, conn_use_rpa(co=
nn), NULL,
> >>> -                                        &own_addr_type, &random_addr=
) < 0)
> >>> -                     return;
> >>> -
> >>> -             memset(&cp, 0, sizeof(cp));
> >>> -
> >>> -             cp.evt_properties =3D cpu_to_le16(LE_LEGACY_ADV_DIRECT_=
IND);
> >>> -             cp.own_addr_type =3D own_addr_type;
> >>> -             cp.channel_map =3D hdev->le_adv_channel_map;
> >>> -             cp.tx_power =3D HCI_TX_POWER_INVALID;
> >>> -             cp.primary_phy =3D HCI_ADV_PHY_1M;
> >>> -             cp.secondary_phy =3D HCI_ADV_PHY_1M;
> >>> -             cp.handle =3D 0; /* Use instance 0 for directed adv */
> >>> -             cp.own_addr_type =3D own_addr_type;
> >>> -             cp.peer_addr_type =3D conn->dst_type;
> >>> -             bacpy(&cp.peer_addr, &conn->dst);
> >>> -
> >>> -             /* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
> >>> -              * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
> >>> -              * does not supports advertising data when the advertis=
ing set already
> >>> -              * contains some, the controller shall return erroc cod=
e 'Invalid
> >>> -              * HCI Command Parameters(0x12).
> >>> -              * So it is required to remove adv set for handle 0x00.=
 since we use
> >>> -              * instance 0 for directed adv.
> >>> -              */
> >>> -             __hci_req_remove_ext_adv_instance(req, cp.handle);
> >>> -
> >>> -             hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(c=
p), &cp);
> >>> -
> >>> -             if (own_addr_type =3D=3D ADDR_LE_DEV_RANDOM &&
> >>> -                 bacmp(&random_addr, BDADDR_ANY) &&
> >>> -                 bacmp(&random_addr, &hdev->random_addr)) {
> >>> -                     struct hci_cp_le_set_adv_set_rand_addr cp;
> >>> -
> >>> -                     memset(&cp, 0, sizeof(cp));
> >>> -
> >>> -                     cp.handle =3D 0;
> >>> -                     bacpy(&cp.bdaddr, &random_addr);
> >>> -
> >>> -                     hci_req_add(req,
> >>> -                                 HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> >>> -                                 sizeof(cp), &cp);
> >>> -             }
> >>> -
> >>> -             __hci_req_enable_ext_advertising(req, 0x00);
> >>> -     } else {
> >>> -             struct hci_cp_le_set_adv_param cp;
> >>> -
> >>> -             /* Clear the HCI_LE_ADV bit temporarily so that the
> >>> -              * hci_update_random_address knows that it's safe to go=
 ahead
> >>> -              * and write a new random address. The flag will be set=
 back on
> >>> -              * as soon as the SET_ADV_ENABLE HCI command completes.
> >>> -              */
> >>> -             hci_dev_clear_flag(hdev, HCI_LE_ADV);
> >>> -
> >>> -             /* Set require_privacy to false so that the remote devi=
ce has a
> >>> -              * chance of identifying us.
> >>> -              */
> >>> -             if (hci_update_random_address(req, false, conn_use_rpa(=
conn),
> >>> -                                           &own_addr_type) < 0)
> >>> -                     return;
> >>> -
> >>> -             memset(&cp, 0, sizeof(cp));
> >>> -
> >>> -             /* Some controllers might reject command if intervals a=
re not
> >>> -              * within range for undirected advertising.
> >>> -              * BCM20702A0 is known to be affected by this.
> >>> -              */
> >>> -             cp.min_interval =3D cpu_to_le16(0x0020);
> >>> -             cp.max_interval =3D cpu_to_le16(0x0020);
> >>> -
> >>> -             cp.type =3D LE_ADV_DIRECT_IND;
> >>> -             cp.own_address_type =3D own_addr_type;
> >>> -             cp.direct_addr_type =3D conn->dst_type;
> >>> -             bacpy(&cp.direct_addr, &conn->dst);
> >>> -             cp.channel_map =3D hdev->le_adv_channel_map;
> >>> -
> >>> -             hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &=
cp);
> >>> -
> >>> -             enable =3D 0x01;
> >>> -             hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enabl=
e),
> >>> -                         &enable);
> >>> -     }
> >>> -
> >>> -     conn->state =3D BT_CONNECT;
> >>> +     return hci_le_create_conn_sync(hdev, conn);
> >>> }
> >>>
> >>> struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> >>>                              u8 dst_type, bool dst_resolved, u8 sec_l=
evel,
> >>>                              u16 conn_timeout, u8 role, bdaddr_t *dir=
ect_rpa)
> >>> {
> >>> -     struct hci_conn_params *params;
> >>>      struct hci_conn *conn;
> >>>      struct smp_irk *irk;
> >>> -     struct hci_request req;
> >>>      int err;
> >>>
> >>> -     /* This ensures that during disable le_scan address resolution
> >>> -      * will not be disabled if it is followed by le_create_conn
> >>> -      */
> >>> -     bool rpa_le_conn =3D true;
> >>> -
> >>>      /* Let's make sure that le is enabled.*/
> >>>      if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
> >>>              if (lmp_le_capable(hdev))
> >>> @@ -1230,68 +1008,16 @@ struct hci_conn *hci_connect_le(struct hci_de=
v *hdev, bdaddr_t *dst,
> >>>      conn->sec_level =3D BT_SECURITY_LOW;
> >>>      conn->conn_timeout =3D conn_timeout;
> >>>
> >>> -     hci_req_init(&req, hdev);
> >>> -
> >>> -     /* Disable advertising if we're active. For central role
> >>> -      * connections most controllers will refuse to connect if
> >>> -      * advertising is enabled, and for peripheral role connections =
we
> >>> -      * anyway have to disable it in order to start directed
> >>> -      * advertising. Any registered advertisements will be
> >>> -      * re-enabled after the connection attempt is finished.
> >>> -      */
> >>> -     if (hci_dev_test_flag(hdev, HCI_LE_ADV))
> >>> -             __hci_req_pause_adv_instances(&req);
> >>> -
> >>> -     /* If requested to connect as peripheral use directed advertisi=
ng */
> >>> -     if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> >>> -             /* If we're active scanning most controllers are unable
> >>> -              * to initiate advertising. Simply reject the attempt.
> >>> -              */
> >>> -             if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
> >>> -                 hdev->le_scan_type =3D=3D LE_SCAN_ACTIVE) {
> >>> -                     hci_req_purge(&req);
> >>> -                     hci_conn_del(conn);
> >>> -                     return ERR_PTR(-EBUSY);
> >>> -             }
> >>> -
> >>> -             hci_req_directed_advertising(&req, conn);
> >>> -             goto create_conn;
> >>> -     }
> >>> -
> >>> -     params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_t=
ype);
> >>> -     if (params) {
> >>> -             conn->le_conn_min_interval =3D params->conn_min_interva=
l;
> >>> -             conn->le_conn_max_interval =3D params->conn_max_interva=
l;
> >>> -             conn->le_conn_latency =3D params->conn_latency;
> >>> -             conn->le_supv_timeout =3D params->supervision_timeout;
> >>> -     } else {
> >>> -             conn->le_conn_min_interval =3D hdev->le_conn_min_interv=
al;
> >>> -             conn->le_conn_max_interval =3D hdev->le_conn_max_interv=
al;
> >>> -             conn->le_conn_latency =3D hdev->le_conn_latency;
> >>> -             conn->le_supv_timeout =3D hdev->le_supv_timeout;
> >>> -     }
> >>> -
> >>> -     /* If controller is scanning, we stop it since some controllers=
 are
> >>> -      * not able to scan and connect at the same time. Also set the
> >>> -      * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
> >>> -      * handler for scan disabling knows to set the correct discover=
y
> >>> -      * state.
> >>> -      */
> >>> -     if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
> >>> -             hci_req_add_le_scan_disable(&req, rpa_le_conn);
> >>> -             hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
> >>> -     }
> >>> +     if (direct_rpa)
> >>> +             bacpy(&conn->direct_rpa, direct_rpa);
> >>>
> >>> -     hci_req_add_le_create_conn(&req, conn, direct_rpa);
> >>> +     conn->state =3D BT_CONNECT;
> >>> +     clear_bit(HCI_CONN_SCANNING, &conn->flags);
> >>>
> >>> -create_conn:
> >>> -     err =3D hci_req_run(&req, create_le_conn_complete);
> >>> +     err =3D hci_cmd_sync_queue(hdev, hci_connect_le_sync, conn,
> >>> +                              create_le_conn_complete);
> >>>      if (err) {
> >>>              hci_conn_del(conn);
> >>> -
> >>> -             if (hdev->adv_instance_cnt)
> >>> -                     hci_req_resume_adv_instances(hdev);
> >>> -
> >>>              return ERR_PTR(err);
> >>>      }
> >>>
> >>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.=
c
> >>> index 329c66456cf1..b61373ac7bb7 100644
> >>> --- a/net/bluetooth/hci_request.c
> >>> +++ b/net/bluetooth/hci_request.c
> >>> @@ -818,56 +818,6 @@ static void cancel_adv_timeout(struct hci_dev *h=
dev)
> >>>      }
> >>> }
> >>>
> >>> -/* This function requires the caller holds hdev->lock */
> >>> -void __hci_req_pause_adv_instances(struct hci_request *req)
> >>> -{
> >>> -     bt_dev_dbg(req->hdev, "Pausing advertising instances");
> >>> -
> >>> -     /* Call to disable any advertisements active on the controller.
> >>> -      * This will succeed even if no advertisements are configured.
> >>> -      */
> >>> -     __hci_req_disable_advertising(req);
> >>> -
> >>> -     /* If we are using software rotation, pause the loop */
> >>> -     if (!ext_adv_capable(req->hdev))
> >>> -             cancel_adv_timeout(req->hdev);
> >>> -}
> >>> -
> >>> -/* This function requires the caller holds hdev->lock */
> >>> -static void __hci_req_resume_adv_instances(struct hci_request *req)
> >>> -{
> >>> -     struct adv_info *adv;
> >>> -
> >>> -     bt_dev_dbg(req->hdev, "Resuming advertising instances");
> >>> -
> >>> -     if (ext_adv_capable(req->hdev)) {
> >>> -             /* Call for each tracked instance to be re-enabled */
> >>> -             list_for_each_entry(adv, &req->hdev->adv_instances, lis=
t) {
> >>> -                     __hci_req_enable_ext_advertising(req,
> >>> -                                                      adv->instance)=
;
> >>> -             }
> >>> -
> >>> -     } else {
> >>> -             /* Schedule for most recent instance to be restarted an=
d begin
> >>> -              * the software rotation loop
> >>> -              */
> >>> -             __hci_req_schedule_adv_instance(req,
> >>> -                                             req->hdev->cur_adv_inst=
ance,
> >>> -                                             true);
> >>> -     }
> >>> -}
> >>> -
> >>> -/* This function requires the caller holds hdev->lock */
> >>> -int hci_req_resume_adv_instances(struct hci_dev *hdev)
> >>> -{
> >>> -     struct hci_request req;
> >>> -
> >>> -     hci_req_init(&req, hdev);
> >>> -     __hci_req_resume_adv_instances(&req);
> >>> -
> >>> -     return hci_req_run(&req, NULL);
> >>> -}
> >>> -
> >>> static bool adv_cur_instance_is_scannable(struct hci_dev *hdev)
> >>> {
> >>>      return hci_adv_instance_is_scannable(hdev, hdev->cur_adv_instanc=
e);
> >>> diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.=
h
> >>> index 8d39e9416861..7f8df258e295 100644
> >>> --- a/net/bluetooth/hci_request.h
> >>> +++ b/net/bluetooth/hci_request.h
> >>> @@ -80,8 +80,6 @@ void hci_req_add_le_passive_scan(struct hci_request=
 *req);
> >>> void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_sta=
te next);
> >>>
> >>> void hci_req_disable_address_resolution(struct hci_dev *hdev);
> >>> -void __hci_req_pause_adv_instances(struct hci_request *req);
> >>> -int hci_req_resume_adv_instances(struct hci_dev *hdev);
> >>> void hci_req_reenable_advertising(struct hci_dev *hdev);
> >>> void __hci_req_enable_advertising(struct hci_request *req);
> >>> void __hci_req_disable_advertising(struct hci_request *req);
> >>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >>> index fd15fb37a52a..57a96a66f007 100644
> >>> --- a/net/bluetooth/hci_sync.c
> >>> +++ b/net/bluetooth/hci_sync.c
> >>> @@ -4974,3 +4974,298 @@ int hci_resume_sync(struct hci_dev *hdev)
> >>>
> >>>      return 0;
> >>> }
> >>> +
> >>> +static bool conn_use_rpa(struct hci_conn *conn)
> >>> +{
> >>> +     struct hci_dev *hdev =3D conn->hdev;
> >>> +
> >>> +     return hci_dev_test_flag(hdev, HCI_PRIVACY);
> >>> +}
> >>> +
> >>> +static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev=
,
> >>> +                                             struct hci_conn *conn)
> >>> +{
> >>> +     struct hci_cp_le_set_ext_adv_params cp;
> >>> +     int err;
> >>> +     bdaddr_t random_addr;
> >>> +     u8 own_addr_type;
> >>> +
> >>> +     err =3D hci_update_random_address_sync(hdev, false, conn_use_rp=
a(conn),
> >>> +                                          &own_addr_type);
> >>> +     if (err)
> >>> +             return err;
> >>> +
> >>> +     /* Set require_privacy to false so that the remote device has a
> >>> +      * chance of identifying us.
> >>> +      */
> >>> +     err =3D hci_get_random_address(hdev, false, conn_use_rpa(conn),=
 NULL,
> >>> +                                  &own_addr_type, &random_addr);
> >>> +     if (err)
> >>> +             return err;
> >>> +
> >>> +     memset(&cp, 0, sizeof(cp));
> >>> +
> >>> +     cp.evt_properties =3D cpu_to_le16(LE_LEGACY_ADV_DIRECT_IND);
> >>> +     cp.own_addr_type =3D own_addr_type;
> >>> +     cp.channel_map =3D hdev->le_adv_channel_map;
> >>> +     cp.tx_power =3D HCI_TX_POWER_INVALID;
> >>> +     cp.primary_phy =3D HCI_ADV_PHY_1M;
> >>> +     cp.secondary_phy =3D HCI_ADV_PHY_1M;
> >>> +     cp.handle =3D 0x00; /* Use instance 0 for directed adv */
> >>> +     cp.own_addr_type =3D own_addr_type;
> >>> +     cp.peer_addr_type =3D conn->dst_type;
> >>> +     bacpy(&cp.peer_addr, &conn->dst);
> >>> +
> >>> +     /* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
> >>> +      * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
> >>> +      * does not supports advertising data when the advertising set =
already
> >>> +      * contains some, the controller shall return erroc code 'Inval=
id
> >>> +      * HCI Command Parameters(0x12).
> >>> +      * So it is required to remove adv set for handle 0x00. since w=
e use
> >>> +      * instance 0 for directed adv.
> >>> +      */
> >>> +     err =3D hci_remove_ext_adv_instance_sync(hdev, cp.handle, NULL)=
;
> >>> +     if (err)
> >>> +             return err;
> >>> +
> >>> +     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAM=
S,
> >>> +                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >>> +     if (err)
> >>> +             return err;
> >>> +
> >>> +     /* Check if random address need to be updated */
> >>> +     if (own_addr_type =3D=3D ADDR_LE_DEV_RANDOM &&
> >>> +         bacmp(&random_addr, BDADDR_ANY) &&
> >>> +         bacmp(&random_addr, &hdev->random_addr)) {
> >>> +             err =3D hci_set_adv_set_random_addr_sync(hdev, 0x00,
> >>> +                                                    &random_addr);
> >>> +             if (err)
> >>> +                     return err;
> >>> +     }
> >>> +
> >>> +     return hci_enable_ext_advertising_sync(hdev, 0x00);
> >>> +}
> >>> +
> >>> +static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
> >>> +                                         struct hci_conn *conn)
> >>> +{
> >>> +     struct hci_cp_le_set_adv_param cp;
> >>> +     u8 status;
> >>> +     u8 own_addr_type;
> >>> +     u8 enable;
> >>> +
> >>> +     if (ext_adv_capable(hdev))
> >>> +             return hci_le_ext_directed_advertising_sync(hdev, conn)=
;
> >>> +
> >>> +     /* Clear the HCI_LE_ADV bit temporarily so that the
> >>> +      * hci_update_random_address knows that it's safe to go ahead
> >>> +      * and write a new random address. The flag will be set back on
> >>> +      * as soon as the SET_ADV_ENABLE HCI command completes.
> >>> +      */
> >>> +     hci_dev_clear_flag(hdev, HCI_LE_ADV);
> >>> +
> >>> +     /* Set require_privacy to false so that the remote device has a
> >>> +      * chance of identifying us.
> >>> +      */
> >>> +     status =3D hci_update_random_address_sync(hdev, false, conn_use=
_rpa(conn),
> >>> +                                             &own_addr_type);
> >>> +     if (status)
> >>> +             return status;
> >>> +
> >>> +     memset(&cp, 0, sizeof(cp));
> >>> +
> >>> +     /* Some controllers might reject command if intervals are not
> >>> +      * within range for undirected advertising.
> >>> +      * BCM20702A0 is known to be affected by this.
> >>> +      */
> >>> +     cp.min_interval =3D cpu_to_le16(0x0020);
> >>> +     cp.max_interval =3D cpu_to_le16(0x0020);
> >>> +
> >>> +     cp.type =3D LE_ADV_DIRECT_IND;
> >>> +     cp.own_address_type =3D own_addr_type;
> >>> +     cp.direct_addr_type =3D conn->dst_type;
> >>> +     bacpy(&cp.direct_addr, &conn->dst);
> >>> +     cp.channel_map =3D hdev->le_adv_channel_map;
> >>> +
> >>> +     status =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_PARAM,
> >>> +                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT=
);
> >>> +     if (status)
> >>> +             return status;
> >>> +
> >>> +     enable =3D 0x01;
> >>> +
> >>> +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> >>> +                                  sizeof(enable), &enable, HCI_CMD_T=
IMEOUT);
> >>> +}
> >>> +
> >>> +static void set_ext_conn_params(struct hci_conn *conn,
> >>> +                             struct hci_cp_le_ext_conn_param *p)
> >>> +{
> >>> +     struct hci_dev *hdev =3D conn->hdev;
> >>> +
> >>> +     memset(p, 0, sizeof(*p));
> >>> +
> >>> +     p->scan_interval =3D cpu_to_le16(hdev->le_scan_int_connect);
> >>> +     p->scan_window =3D cpu_to_le16(hdev->le_scan_window_connect);
> >>> +     p->conn_interval_min =3D cpu_to_le16(conn->le_conn_min_interval=
);
> >>> +     p->conn_interval_max =3D cpu_to_le16(conn->le_conn_max_interval=
);
> >>> +     p->conn_latency =3D cpu_to_le16(conn->le_conn_latency);
> >>> +     p->supervision_timeout =3D cpu_to_le16(conn->le_supv_timeout);
> >>> +     p->min_ce_len =3D cpu_to_le16(0x0000);
> >>> +     p->max_ce_len =3D cpu_to_le16(0x0000);
> >>> +}
> >>> +
> >>> +int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_con=
n *conn,
> >>> +                             u8 own_addr_type)
> >>> +{
> >>> +     struct hci_cp_le_ext_create_conn *cp;
> >>> +     struct hci_cp_le_ext_conn_param *p;
> >>> +     u8 data[sizeof(*cp) + sizeof(*p) * 3];
> >>> +     u32 plen;
> >>> +
> >>> +     cp =3D (void *)data;
> >>> +     p =3D (void *)cp->data;
> >>> +
> >>> +     memset(cp, 0, sizeof(*cp));
> >>> +
> >>> +     bacpy(&cp->peer_addr, &conn->dst);
> >>> +     cp->peer_addr_type =3D conn->dst_type;
> >>> +     cp->own_addr_type =3D own_addr_type;
> >>> +
> >>> +     plen =3D sizeof(*cp);
> >>> +
> >>> +     if (scan_1m(hdev)) {
> >>> +             cp->phys |=3D LE_SCAN_PHY_1M;
> >>> +             set_ext_conn_params(conn, p);
> >>> +
> >>> +             p++;
> >>> +             plen +=3D sizeof(*p);
> >>> +     }
> >>> +
> >>> +     if (scan_2m(hdev)) {
> >>> +             cp->phys |=3D LE_SCAN_PHY_2M;
> >>> +             set_ext_conn_params(conn, p);
> >>> +
> >>> +             p++;
> >>> +             plen +=3D sizeof(*p);
> >>> +     }
> >>> +
> >>> +     if (scan_coded(hdev)) {
> >>> +             cp->phys |=3D LE_SCAN_PHY_CODED;
> >>> +             set_ext_conn_params(conn, p);
> >>> +
> >>> +             plen +=3D sizeof(*p);
> >>> +     }
> >>> +
> >>> +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
> >>> +                                  plen, data, HCI_CMD_TIMEOUT);
> >>> +}
> >>> +
> >>> +int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *c=
onn)
> >>> +{
> >>> +     struct hci_cp_le_create_conn cp;
> >>> +     struct hci_conn_params *params;
> >>> +     u8 own_addr_type;
> >>> +     int err;
> >>> +
> >>> +     /* Disable advertising if we're active. For central role
> >>> +      * connections most controllers will refuse to connect if
> >>> +      * advertising is enabled, and for peripheral role connections =
we
> >>> +      * anyway have to disable it in order to start directed
> >>> +      * advertising. Any registered advertisements will be
> >>> +      * re-enabled after the connection attempt is finished.
> >>> +      */
> >>> +     hci_pause_advertising_sync(hdev);
> >>> +
> >>> +     /* If requested to connect as peripheral use directed advertisi=
ng */
> >>> +     if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> >>> +             /* If we're active scanning most controllers are unable
> >>> +              * to initiate advertising. Simply reject the attempt.
> >>> +              */
> >>> +             if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
> >>> +                 hdev->le_scan_type =3D=3D LE_SCAN_ACTIVE) {
> >>> +                     hci_conn_del(conn);
> >>> +                     return -EBUSY;
> >>> +             }
> >>> +
> >>> +             err =3D hci_le_directed_advertising_sync(hdev, conn);
> >>> +             goto done;
> >>> +     }
> >>> +
> >>> +     params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_t=
ype);
> >>> +     if (params) {
> >>> +             conn->le_conn_min_interval =3D params->conn_min_interva=
l;
> >>> +             conn->le_conn_max_interval =3D params->conn_max_interva=
l;
> >>> +             conn->le_conn_latency =3D params->conn_latency;
> >>> +             conn->le_supv_timeout =3D params->supervision_timeout;
> >>> +     } else {
> >>> +             conn->le_conn_min_interval =3D hdev->le_conn_min_interv=
al;
> >>> +             conn->le_conn_max_interval =3D hdev->le_conn_max_interv=
al;
> >>> +             conn->le_conn_latency =3D hdev->le_conn_latency;
> >>> +             conn->le_supv_timeout =3D hdev->le_supv_timeout;
> >>> +     }
> >>> +
> >>> +     /* If direct address was provided we use it instead of current
> >>> +      * address.
> >>> +      */
> >>> +     if (bacmp(&conn->direct_rpa, BDADDR_ANY)) {
> >>> +             if (bacmp(&hdev->random_addr, &conn->direct_rpa)) {
> >>> +                     err =3D __hci_cmd_sync_status(hdev,
> >>> +                                                 HCI_OP_LE_SET_RANDO=
M_ADDR,
> >>> +                                                 6, &conn->direct_rp=
a,
> >>> +                                                 HCI_CMD_TIMEOUT);
> >>> +                     if (err)
> >>> +                             return err;
> >>> +             }
> >>> +
> >>> +             /* direct address is always RPA */
> >>> +             own_addr_type =3D ADDR_LE_DEV_RANDOM;
> >>> +     } else {
> >>> +             /* Update random address, but set require_privacy to fa=
lse so
> >>> +              * that we never connect with an non-resolvable address=
.
> >>> +              */
> >>> +             err =3D hci_update_random_address_sync(hdev, false,
> >>> +                                                  conn_use_rpa(conn)=
,
> >>> +                                                  &own_addr_type);
> >>> +             if (err)
> >>> +                     return err;
> >>> +     }
> >>> +
> >>> +     /* If controller is scanning, we stop it since some controllers=
 are
> >>> +      * not able to scan and connect at the same time. Also set the
> >>> +      * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
> >>> +      * handler for scan disabling knows to set the correct discover=
y
> >>> +      * state.
> >>> +      */
> >>> +     if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
> >>> +             hci_scan_disable_sync(hdev);
> >>> +             hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
> >>> +     }
> >>> +
> >>> +     if (use_ext_conn(hdev)) {
> >>> +             err =3D hci_le_ext_create_conn_sync(hdev, conn, own_add=
r_type);
> >>> +             goto done;
> >>> +     }
> >>> +
> >>> +     memset(&cp, 0, sizeof(cp));
> >>> +
> >>> +     cp.scan_interval =3D cpu_to_le16(hdev->le_scan_int_connect);
> >>> +     cp.scan_window =3D cpu_to_le16(hdev->le_scan_window_connect);
> >>> +
> >>> +     bacpy(&cp.peer_addr, &conn->dst);
> >>> +     cp.peer_addr_type =3D conn->dst_type;
> >>> +     cp.own_address_type =3D own_addr_type;
> >>> +     cp.conn_interval_min =3D cpu_to_le16(conn->le_conn_min_interval=
);
> >>> +     cp.conn_interval_max =3D cpu_to_le16(conn->le_conn_max_interval=
);
> >>> +     cp.conn_latency =3D cpu_to_le16(conn->le_conn_latency);
> >>> +     cp.supervision_timeout =3D cpu_to_le16(conn->le_supv_timeout);
> >>> +     cp.min_ce_len =3D cpu_to_le16(0x0000);
> >>> +     cp.max_ce_len =3D cpu_to_le16(0x0000);
> >>> +
> >>> +     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN,
> >>> +                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >>> +
> >>> +done:
> >>> +     hci_resume_advertising_sync(hdev);
> >>> +     return err;
> >>> +}
> >>
> >> so while we can do that as interim, I think we need spent a few cycles=
 thinking about on how we want to do commands that have a command status an=
d then a dedicated event.
> >>
> >> The pattern of doing synchronous things like this:
> >>
> >>        pause_advertising
> >>
> >>        send_connect + wait_for_cmd_status
> >>
> >>        resume_advertising
> >>
> >> Is in general a good pattern, but especially with the connect handling=
, we always end up having to send further commands after a successful conne=
ct complete event.
> >
> > I guess you are saying that we should wait for Connection Complete
> > before we resume the advertising, which I guess that would correct but
> > the existing code in hci_req_add_le_create_conn doesn't seems to be
> > doing that so that would be a change in the behavior so I'd prefer to
> > have as a separate patch.
>
> That I am not sure. If we just have to wait for the cmd status, then we s=
hould only do that. Otherwise we have to deal with supervision timeout and =
will not advertise for a long time. So as long as the hardware allows us to=
 re-start advertising after issuing the connect request, we should do that.=
 We should at least verify that with our own hardware generations.
>
> >
> >> So maybe we really need a __hci_cmd_sync_event(opcode, evcode, callbac=
k) type of handling that when the callback is called, you are back in a wor=
kqueue where you can send new commands with __hci_cmd_sync. Except for inqu=
iry (which is weird with its own timeout handling), this might be good enou=
gh for all HCI commands that take some time and come back with an event. Of=
 course there needs a way to cancel the command somehow.
> >>
> >> I am saying this, since eventually our hci_event.c handling should be =
there for updating core status in case some external hcitool sends a comman=
d.
> >>
> >> That said, I am happy to apply this patch and then move forward with r=
e-factoring, but I am having a hard time reviewing this thing since it is r=
ather large and complex. Do we have enough test coverage on it?

Yep, I made sure it even tests with directed advertising as well so
I'd leave the refactoring after I'm done cleaning up the existing code
that uses hci_request.c.

> > There is some code already in the form of
> > __hci_cmd_sync_ev/__hci_cmd_sync_sk where one can have a dedicated
> > event to wait for, we do use it in hci_disconnect_sync where we wait
> > for HCI_EV_DISCONN_COMPLETE instead of HCI_EV_CMD_STATUS:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/tree/net/bluetooth/hci_sync.c#n4300
> >
> > I suspect we want something similar for
> > HCI_OP_LE_CREATE_CONN/HCI_OP_LE_EXT_CREATE_CONN, something like the
> > following:
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 57a96a66f007..94c42fd9bdec 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5157,8 +5157,10 @@ int hci_le_ext_create_conn_sync(struct hci_dev
> > *hdev, struct hci_conn *conn,
> >                plen +=3D sizeof(*p);
> >        }
> >
> > -       return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
> > -                                    plen, data, HCI_CMD_TIMEOUT);
> > +       return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN=
,
> > +                                       plen, data,
> > +                                       HCI_EV_LE_ENHANCED_CONN_COMPLET=
E,
> > +                                       HCI_CMD_TIMEOUT, NULL);
> > }
> >
> > int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn=
)
> > @@ -5262,8 +5264,9 @@ int hci_le_create_conn_sync(struct hci_dev
> > *hdev, struct hci_conn *conn)
> >        cp.min_ce_len =3D cpu_to_le16(0x0000);
> >        cp.max_ce_len =3D cpu_to_le16(0x0000);
> >
> > -       err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN,
> > -                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
> > +                                      sizeof(cp), &cp, HCI_EV_LE_CONN_=
COMPLETE,
> > +                                      HCI_CMD_TIMEOUT, NULL);
> >
> > done:
> >        hci_resume_advertising_sync(hdev);
> >
> > The problem is that hci_event_packet code don't seem to be able to
> > wait for LE subevents like above, so it only works with events in
> > hci_ev_table while we want also the LE subevents in hci_le_ev_table,
> > so we would likely need to extend the req_event matching and perhaps
> > add something like req_le_event to get this working properly.
>
> Besides the fact that we also have to deal with LE subevents, I was more =
after that long-term we should introduce a simplified HCI API handling so t=
hat we can extend with new features in a synchronous fashion. There are cer=
tain HCI transaction we have to do after a connection complete event and be=
fore running L2CAP or SMP. Right now they are all triggered from hci_event.=
c and that will backfire really quickly as well.
>
> In general we should have two things, one being:
>
>         give_me_hci_cmd_context(callback)
>
> And that drops you into an appropriate and locked workqueue where you can=
 issue HCI commands via sync interfaces. We pretty much have this already, =
but need to ensure it is used everything and a really simple API which is u=
seful for HCI commands with cmd complete.
>
> The second part is something like this:
>
>         send_hci_command_and_give_me_hci_context_when_event_happens(callb=
ack)
>
> So it actually send the HCI command in sync fashion waiting for cmd statu=
s. However later on you are dropped in a proper context for your callback. =
And then you can execute further HCI commands in sync fashion.
>
> In addition, we will have a few events that are coming in without a HCI c=
ommand prompting them. Like for example HCI Disconnect event. We need to di=
fferentiate between it triggered by a local command or unsolicited. So addi=
tional we need.
>
>         register_unsolicited_event_and_give_me_hci_context(callback)
>
> When that happens you can also be dropped into a context to take further =
action if needed.
>
> As I said, I am happy to apply 1/3 patch if you are sure we have enough t=
est coverage for it. However we need to slowly move towards cleaning this H=
CI API mess up and starting to drop all this weird legacy sending of HCI co=
mmands and its central event handling switch statement.
>
> That we keep track of everything is awesome and that even commands issued=
 by hcitool cmd will be considered and recorded. However I think that shoul=
d be done separately and also tracked separately. And we should have KConfi=
g options that limit hcitool cmd to vendor commands only. Overall I want to=
 shrink the stack size.
>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
