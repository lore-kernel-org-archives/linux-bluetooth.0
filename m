Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF1CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 20:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjJKUIo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJKUIn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 16:08:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D694
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 13:08:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso2933151fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697054919; x=1697659719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG0oEJnuUGVl1BtY14y52xnkdje6KfDTa/p7TtYfb+s=;
        b=RNpNvdHSo2Fw0kPIRFpWQAZJRgomNqj2sdQeX5LW/VsutQ7XrySOXeMsyK3M0iVzUT
         y6gwPdrcG2ngpWmJ5ZY5PmKqovKlvbDMEAoI9cFtpBfYKGTPtWnamfcw1NHKqHIvGGxR
         6H/M9lps34UOoibryp3BU9vZSCzDGGF6Ux0MW77/8OEEWY3wprCMfOCQRuLL/C0l6nLx
         k4FVmnDCZeui72lUD4tm1seig9oDamiIfoHyykJU+1VWEAOMxuZHD70MktQAQrx0MFBV
         WkmeIpPlxO43zUvptVDqHQn3bNj+67SPZD8+rKmD/mUjkiMqW1Ly6s29Aa4pbJf1cdbw
         4Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697054919; x=1697659719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YG0oEJnuUGVl1BtY14y52xnkdje6KfDTa/p7TtYfb+s=;
        b=B6v5xsoYeJn+aG8B9van1JfOnWJLOpOQhWCEecN8CxOacvlqfJQ4xiYUQz2o98cYl5
         FCG77LkaEbXwbnACcQcL3uMiNJIWtw0+WtmpxWef+xurfih8WZ8OKAHBC1UAHYEesscS
         KYPxIVXGF5Dow1vv0D1OcfcoPDmRfOzExy83ShRkO6468XWxGiC5a1CmURlHACGwxIVj
         /o9H9Q3wMtIDVk7bQ5g2Rp/TotGw+ucV6qLHrY4VIV8/EECeerx2RwJKavEp4k6rDP8z
         IlwnCbCXaxzA+IDp+I3sUi1TzOjIunLlVMIVbbf5yGTatLhnPxwakqco5WWR1xfgppqD
         Zp6w==
X-Gm-Message-State: AOJu0YyNHaGIFvcoCA4Zap1vcDebXq9KAbCcB17OZfs1/T0AuUPcRWbb
        nkOKu8/827VQAKCHW/3ry/RvsxVhPCh/mxlQSV0K9i2rVRdRPLjCKws=
X-Google-Smtp-Source: AGHT+IFrX/dALSPZQCrjWPeaybQNFL1ywYdxDaIKlIuBuVSMvvNKid3zPhog73IG2TSaHc0mXlkGlm7xIagR9MeXlws=
X-Received: by 2002:a05:651c:20c:b0:2bf:fae0:5cf1 with SMTP id
 y12-20020a05651c020c00b002bffae05cf1mr19354351ljn.14.1697054919154; Wed, 11
 Oct 2023 13:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231011142408.5529-1-iulia.tanasescu@nxp.com> <20231011142408.5529-3-iulia.tanasescu@nxp.com>
In-Reply-To: <20231011142408.5529-3-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 11 Oct 2023 13:08:26 -0700
Message-ID: <CABBYNZ+0NPDrLGvpB3mU9RoCqRPmCOcLc0eszws8JXGgSWB==Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetoth: ISO: Fix broadcast event handling
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

On Wed, Oct 11, 2023 at 7:24=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This fixes the way broadcast events are handled by the ISO layer:
> A new slave BIS hcon is notified after the Command Complete for
> LE Setup ISO Data Path is received, not after BIG Sync Established.
>
> The iso_match_pa_sync_flag function has been replaced with more
> specific matching functions, depending on the event being handled.
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/hci_core.h |   3 +-
>  net/bluetooth/hci_core.c         |  50 ++++++++++-----
>  net/bluetooth/iso.c              | 101 +++++++++++++++++++++++++------
>  3 files changed, 119 insertions(+), 35 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 99865c23e461..a85c47abd88d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2127,7 +2127,8 @@ void hci_send_sco(struct hci_conn *conn, struct sk_=
buff *skb);
>  void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
>
>  void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> -void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
> +void *hci_le_meta_evt_data(struct hci_dev *hdev, __u8 subevent);
> +void *hci_cmd_complete_data(struct hci_dev *hdev, __u16 opcode);
>
>  u32 hci_conn_get_phy(struct hci_conn *conn);
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 195aea2198a9..5ccc6ef1b66b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3120,10 +3120,11 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u=
16 opcode)
>         return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
>  }
>
> -/* Get data from last received event */
> -void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
> +/* Get data from last received LE Meta event */
> +void *hci_le_meta_evt_data(struct hci_dev *hdev, __u8 subevent)
>  {
>         struct hci_event_hdr *hdr;
> +       struct hci_ev_le_meta *ev;
>         int offset;
>
>         if (!hdev->recv_event)
> @@ -3132,21 +3133,42 @@ void *hci_recv_event_data(struct hci_dev *hdev, _=
_u8 event)
>         hdr =3D (void *)hdev->recv_event->data;
>         offset =3D sizeof(*hdr);
>
> -       if (hdr->evt !=3D event) {
> -               /* In case of LE metaevent check the subevent match */
> -               if (hdr->evt =3D=3D HCI_EV_LE_META) {
> -                       struct hci_ev_le_meta *ev;
> +       if (hdr->evt !=3D HCI_EV_LE_META)
> +               return NULL;
>
> -                       ev =3D (void *)hdev->recv_event->data + offset;
> -                       offset +=3D sizeof(*ev);
> -                       if (ev->subevent =3D=3D event)
> -                               goto found;
> -               }
> +       ev =3D (void *)hdev->recv_event->data + offset;
> +       offset +=3D sizeof(*ev);
> +       if (ev->subevent !=3D subevent)
> +               return NULL;
> +
> +       bt_dev_dbg(hdev, "subevent 0x%2.2x", subevent);
> +
> +       return hdev->recv_event->data + offset;
> +}
> +
> +/* Get data from last received Command Complete event */
> +void *hci_cmd_complete_data(struct hci_dev *hdev, __u16 opcode)
> +{
> +       struct hci_event_hdr *hdr;
> +       struct hci_ev_cmd_complete *ev;
> +       int offset;
> +
> +       if (!hdev->recv_event)
> +               return NULL;
> +
> +       hdr =3D (void *)hdev->recv_event->data;
> +       offset =3D sizeof(*hdr);
> +
> +       if (hdr->evt !=3D HCI_EV_CMD_COMPLETE)
> +               return NULL;
> +
> +       ev =3D (void *)hdev->recv_event->data + offset;
> +       offset +=3D sizeof(*ev);
> +
> +       if (__le16_to_cpu(ev->opcode) !=3D opcode)
>                 return NULL;
> -       }
>
> -found:
> -       bt_dev_dbg(hdev, "event 0x%2.2x", event);
> +       bt_dev_dbg(hdev, "command complete event for 0x%4.4x", opcode);
>
>         return hdev->recv_event->data + offset;
>  }
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 8ab7ea5ebedf..76c186f951d1 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1560,6 +1560,16 @@ struct iso_list_data {
>         int count;
>  };
>
> +static bool iso_match_big_flag(struct sock *sk, void *data)
> +{
> +       struct hci_evt_le_big_sync_estabilished *ev =3D data;
> +
> +       if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> +               return false;
> +
> +       return ev->handle =3D=3D iso_pi(sk)->qos.bcast.big;
> +}
> +
>  static bool iso_match_big(struct sock *sk, void *data)
>  {
>         struct hci_evt_le_big_sync_estabilished *ev =3D data;
> @@ -1567,15 +1577,28 @@ static bool iso_match_big(struct sock *sk, void *=
data)
>         return ev->handle =3D=3D iso_pi(sk)->qos.bcast.big;
>  }
>
> -static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
> +static bool iso_match_conn_big_flag(struct sock *sk, void *data)
> +{
> +       struct hci_conn *hcon =3D data;
> +
> +       if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> +               return false;
> +
> +       return hcon->iso_qos.bcast.big =3D=3D iso_pi(sk)->qos.bcast.big;
> +}
> +
> +static bool iso_match_conn_big(struct sock *sk, void *data)
>  {
> -       return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
> +       struct hci_conn *hcon =3D data;
> +
> +       return hcon->iso_qos.bcast.big =3D=3D iso_pi(sk)->qos.bcast.big;
>  }
>
>  static void iso_conn_ready(struct iso_conn *conn)
>  {
>         struct sock *parent =3D NULL;
>         struct sock *sk =3D conn->sk;
> +       struct hci_rp_le_setup_iso_path *rp =3D NULL;
>         struct hci_ev_le_big_sync_estabilished *ev =3D NULL;
>         struct hci_ev_le_pa_sync_established *ev2 =3D NULL;
>         struct hci_evt_le_big_info_adv_report *ev3 =3D NULL;
> @@ -1590,29 +1613,56 @@ static void iso_conn_ready(struct iso_conn *conn)
>                 if (!hcon)
>                         return;
>
> -               if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
> -                   test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
> -                       ev =3D hci_recv_event_data(hcon->hdev,
> -                                                HCI_EVT_LE_BIG_SYNC_ESTA=
BILISHED);
> +               if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags)) {
> +                       rp =3D hci_cmd_complete_data(hcon->hdev,
> +                                                  HCI_OP_LE_SETUP_ISO_PA=
TH);
>
> -                       /* Get reference to PA sync parent socket, if it =
exists */
> -                       parent =3D iso_get_sock_listen(&hcon->src,
> -                                                    &hcon->dst,
> -                                                    iso_match_pa_sync_fl=
ag, NULL);
> -                       if (!parent && ev)
> +                       if (rp) {
> +                               /* If defer setup was used to listen for =
this
> +                                * event, get reference to the socket mar=
ked
> +                                * with the BT_SK_PA_SYNC flag.
> +                                */
>                                 parent =3D iso_get_sock_listen(&hcon->src=
,
>                                                              &hcon->dst,
> -                                                            iso_match_bi=
g, ev);
> +                                                            iso_match_co=
nn_big_flag,
> +                                                            hcon);
> +
> +                               if (!parent)
> +                                       parent =3D iso_get_sock_listen(&h=
con->src,
> +                                                                    &hco=
n->dst,
> +                                                                    iso_=
match_conn_big,
> +                                                                    hcon=
);
> +                       }
> +               } else if (test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flag=
s)) {
> +                       ev =3D hci_le_meta_evt_data(hcon->hdev,
> +                                                 HCI_EVT_LE_BIG_SYNC_EST=
ABILISHED);
> +
> +                       if (ev) {
> +                               /* If defer setup was used to listen for =
this
> +                                * event, get reference to the socket mar=
ked
> +                                * with the BT_SK_PA_SYNC flag.
> +                                */
> +                               parent =3D iso_get_sock_listen(&hcon->src=
,
> +                                                            &hcon->dst,
> +                                                            iso_match_bi=
g_flag,
> +                                                            ev);
> +
> +                               if (!parent)
> +                                       parent =3D iso_get_sock_listen(&h=
con->src,
> +                                                                    &hco=
n->dst,
> +                                                                    iso_=
match_big,
> +                                                                    ev);
> +                       }
>                 } else if (test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags=
)) {
> -                       ev2 =3D hci_recv_event_data(hcon->hdev,
> -                                                 HCI_EV_LE_PA_SYNC_ESTAB=
LISHED);
> +                       ev2 =3D hci_le_meta_evt_data(hcon->hdev,
> +                                                  HCI_EV_LE_PA_SYNC_ESTA=
BLISHED);
>                         if (ev2)
>                                 parent =3D iso_get_sock_listen(&hcon->src=
,
>                                                              &hcon->dst,
>                                                              iso_match_si=
d, ev2);
>                 } else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
> -                       ev3 =3D hci_recv_event_data(hcon->hdev,
> -                                                 HCI_EVT_LE_BIG_INFO_ADV=
_REPORT);
> +                       ev3 =3D hci_le_meta_evt_data(hcon->hdev,
> +                                                  HCI_EVT_LE_BIG_INFO_AD=
V_REPORT);
>                         if (ev3)
>                                 parent =3D iso_get_sock_listen(&hcon->src=
,
>                                                              &hcon->dst,

I really regret putting the handling of HCI in iso.c, it doesn't seem
to be the right place to be processing HCI traffic and should be left
to just handle socket related operations. The main problem with
broadcast is that it requires multiples commands to setup but it
should be possible to enclosure that into a cmd_sync function that
properly serializes everything, we may need to do some cleanups first
since he have been running cmd_sync callbacks in different files when
that shall always be done hci_sync.c to make it simpler to reuse, then
we can probably inline the sending of HCI_OP_LE_SETUP_ISO_PATH, etc,
so we don't have to keep process them asynchronously via hci_event.c.

> @@ -1700,6 +1750,16 @@ static bool iso_match_sid(struct sock *sk, void *d=
ata)
>         return ev->sid =3D=3D iso_pi(sk)->bc_sid;
>  }
>
> +static bool iso_match_sync_handle_flag(struct sock *sk, void *data)
> +{
> +       struct hci_evt_le_big_info_adv_report *ev =3D data;
> +
> +       if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> +               return false;
> +
> +       return le16_to_cpu(ev->sync_handle) =3D=3D iso_pi(sk)->sync_handl=
e;
> +}
> +
>  static bool iso_match_sync_handle(struct sock *sk, void *data)
>  {
>         struct hci_evt_le_big_info_adv_report *ev =3D data;
> @@ -1740,7 +1800,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>          * in iso_pi(sk)->base so it can be passed up to user, in the cas=
e of a
>          * broadcast sink.
>          */
> -       ev1 =3D hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
> +       ev1 =3D hci_le_meta_evt_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED)=
;
>         if (ev1) {
>                 sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_mat=
ch_sid,
>                                          ev1);
> @@ -1750,11 +1810,12 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_=
t *bdaddr, __u8 *flags)
>                 goto done;
>         }
>
> -       ev2 =3D hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT)=
;
> +       ev2 =3D hci_le_meta_evt_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT=
);
>         if (ev2) {
>                 /* Try to get PA sync listening socket, if it exists */
>                 sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> -                                               iso_match_pa_sync_flag, N=
ULL);
> +                                               iso_match_sync_handle_fla=
g,
> +                                               ev2);
>                 if (!sk)
>                         sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
>                                                  iso_match_sync_handle, e=
v2);
> @@ -1780,7 +1841,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>                 }
>         }
>
> -       ev3 =3D hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
> +       ev3 =3D hci_le_meta_evt_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
>         if (ev3) {
>                 sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
>                                          iso_match_sync_handle_pa_report,=
 ev3);
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
