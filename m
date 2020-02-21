Return-Path: <SRS0=Dxuj=4J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28472C3565B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C876A206DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 18:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV8eikNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBUS01 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:26:27 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45323 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgBUS01 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Feb 2020 13:26:27 -0500
Received: by mail-oi1-f173.google.com with SMTP id v19so2483925oic.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2020 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DqNzLGwCKo8r0EiqOsgZAefmLD8m1TE7lfSD7tBmNuQ=;
        b=jV8eikNw/dBgdYHx0qEc2iWcJf43U9VS8hm6+OogDQ21X30463ZZHuWBHKMmFX4+u7
         63u3IO2ZG5rJtMVUKQTNCbd0kegQiG6M2k9txkeuL9Ky19fn7S2Ol+GkOI8ksudwt11K
         BlnYMU04um/hly+h4UelLh8Gio+9Q2VjwIHP7ZIDGEveR0uGjevvr1l+chGRH9OjVDCW
         rX7wK5mZuc1GAGuxibg2mrGPv1wj2nb4eCnhCON0IYlww1JICJTk+E83vfylKnz/SgD3
         GmSvawZx92AEuJ6QP5X0OdhRFsfG8uflUm645UwiJFcn2C9UnmlFmh/IXYvnqRkgjSy1
         XRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DqNzLGwCKo8r0EiqOsgZAefmLD8m1TE7lfSD7tBmNuQ=;
        b=uPZsCz9Iw0Ge7OeNbwFFfqlHt+FxK4A2z8h28qCnXGhHmyC4iVsUdbVtOF3/Qd7a3H
         MClAKuSH+Z2t6WSIjx3flFtlm+BGEZ4sJjR+hAz16e8KVKNmTpbLzi3MemLcyjqyTSGW
         D1P98mH2TVvfXesEyxiVhkr6Yct9IDxCC4cX3773KHR3vmOUUwCMzdYCORwh4y+Zf0lQ
         dylGvhEsjs3vvZBeducCCxyerUiSzUjJVDtzj76SZ3Ip90l8q75ylkadKb0Quq0HXHXX
         AhHSCK4CZrEK8/gOQg12YuGw14F4KzeygHgPkJUyfW5k+apQl83Old/L8aK6md4f0Hkx
         C9Kg==
X-Gm-Message-State: APjAAAWtZrB7ZME1wLAl7B93rRv4rxntMHomCpehpAsSvbPUOB5k+FHD
        devl1reePx2ck5dxOTKpZqjD3IZG3tOz1tjWgTM=
X-Google-Smtp-Source: APXvYqyxhlPdZ8BFsCdO7CVYNaiLVAtFCx7xHvvmmEX3VOwswA0fF8oqNNE2bdvC6OF8IHpSMQ8MSZqmNA+YMqYRqik=
X-Received: by 2002:a05:6808:98e:: with SMTP id a14mr2965795oic.8.1582309584568;
 Fri, 21 Feb 2020 10:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20200116212743.21016-1-luiz.dentz@gmail.com> <20200116212743.21016-2-luiz.dentz@gmail.com>
 <845FE55B-5172-4A4D-8A0F-2C971A084B8A@holtmann.org> <CABBYNZJEphsTt4U_ruunQS_7hAdLVO2NsZeT8swMRA7127nAGA@mail.gmail.com>
 <EB03C334-FCEA-40E4-9E03-84D08DE993B7@holtmann.org> <CABBYNZJFmcu_myCpgGHVffzx-x1qE2qQraZ964DnuDU1ud-Rjg@mail.gmail.com>
 <25E14F04-A53A-4B33-A085-2E1B971CAC60@holtmann.org> <CABBYNZLO4eMR5CxbbnUNi5ne-BWPnSHm+GNsAZWCvp4GS-s2Hg@mail.gmail.com>
 <7C43E4FA-57C7-4CC4-B113-3D19EC3BEBB2@holtmann.org> <CABBYNZJbk7xfQONPHh1S+M2cozkEkBz-xN=m33jB4M_+5fmjrQ@mail.gmail.com>
 <68E3B5AF-23D0-45D2-8540-3F154F5004EF@holtmann.org>
In-Reply-To: <68E3B5AF-23D0-45D2-8540-3F154F5004EF@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Feb 2020 10:26:12 -0800
Message-ID: <CABBYNZJe4SCB2Wk0ZV3_cjJAhVVvVkL4K4E+AiRPC03Dd4FZiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: L2CAP: Add initial code for Enhanced
 Credit Based Mode
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Feb 21, 2020 at 12:14 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> >>>>>>>>> This adds the initial code for Enhanced Credit Based Mode which
> >>>>>>>>> introduces a new socket mode called L2CAP_MODE_EXT_FLOWCTL, whi=
ch for
> >>>>>>>>> the most part work the same as L2CAP_MODE_LE_FLOWCTL but uses d=
ifferent
> >>>>>>>>> PDUs to setup the connections and also works over BR/EDR.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com=
>
> >>>>>>>>> ---
> >>>>>>>>> include/net/bluetooth/l2cap.h |   4 +
> >>>>>>>>> net/bluetooth/l2cap_core.c    | 510 +++++++++++++++++++++++++++=
++++++-
> >>>>>>>>> net/bluetooth/l2cap_sock.c    |  39 +--
> >>>>>>>>> 3 files changed, 521 insertions(+), 32 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/blueto=
oth/l2cap.h
> >>>>>>>>> index b9ea88cfd2d2..11ae4c93354b 100644
> >>>>>>>>> --- a/include/net/bluetooth/l2cap.h
> >>>>>>>>> +++ b/include/net/bluetooth/l2cap.h
> >>>>>>>>> @@ -295,6 +295,8 @@ struct l2cap_conn_rsp {
> >>>>>>>>> #define L2CAP_CR_LE_ENCRYPTION                0x0008
> >>>>>>>>> #define L2CAP_CR_LE_INVALID_SCID      0x0009
> >>>>>>>>> #define L2CAP_CR_LE_SCID_IN_USE               0X000A
> >>>>>>>>> +#define L2CAP_CR_LE_UNACCEPT_PARAMS  0X000B
> >>>>>>>>> +#define L2CAP_CR_LE_INVALID_PARAMS   0X000C
> >>>>>>>>>
> >>>>>>>>> /* connect/create channel status */
> >>>>>>>>> #define L2CAP_CS_NO_INFO      0x0000
> >>>>>>>>> @@ -964,6 +966,7 @@ void l2cap_cleanup_sockets(void);
> >>>>>>>>> bool l2cap_is_socket(struct socket *sock);
> >>>>>>>>>
> >>>>>>>>> void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan);
> >>>>>>>>> +void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan);
> >>>>>>>>> void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
> >>>>>>>>>
> >>>>>>>>> int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le1=
6 psm);
> >>>>>>>>> @@ -973,6 +976,7 @@ struct l2cap_chan *l2cap_chan_create(void);
> >>>>>>>>> void l2cap_chan_close(struct l2cap_chan *chan, int reason);
> >>>>>>>>> int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16=
 cid,
> >>>>>>>>>                  bdaddr_t *dst, u8 dst_type);
> >>>>>>>>> +int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu)=
;
> >>>>>>>>> int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg=
, size_t len);
> >>>>>>>>> void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
> >>>>>>>>> int l2cap_chan_check_security(struct l2cap_chan *chan, bool ini=
tiator);
> >>>>>>>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_c=
ore.c
> >>>>>>>>> index 195459a1e53e..a528526cffac 100644
> >>>>>>>>> --- a/net/bluetooth/l2cap_core.c
> >>>>>>>>> +++ b/net/bluetooth/l2cap_core.c
> >>>>>>>>> @@ -532,6 +532,17 @@ static void l2cap_le_flowctl_init(struct l=
2cap_chan *chan, u16 tx_credits)
> >>>>>>>>>   skb_queue_head_init(&chan->tx_q);
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> +static void l2cap_ecred_init(struct l2cap_chan *chan, u16 tx_c=
redits)
> >>>>>>>>> +{
> >>>>>>>>> +     l2cap_le_flowctl_init(chan, tx_credits);
> >>>>>>>>> +
> >>>>>>>>> +     /* L2CAP implementations shall support a minimum MPS of 6=
4 octets */
> >>>>>>>>> +     if (chan->mps < L2CAP_ECRED_MIN_MPS) {
> >>>>>>>>> +             chan->mps =3D L2CAP_ECRED_MIN_MPS;
> >>>>>>>>> +             chan->rx_credits =3D (chan->imtu / chan->mps) + 1=
;
> >>>>>>>>> +     }
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_cha=
n *chan)
> >>>>>>>>> {
> >>>>>>>>>   BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
> >>>>>>>>> @@ -638,6 +649,7 @@ void l2cap_chan_del(struct l2cap_chan *chan=
, int err)
> >>>>>>>>>           break;
> >>>>>>>>>
> >>>>>>>>>   case L2CAP_MODE_LE_FLOWCTL:
> >>>>>>>>> +     case L2CAP_MODE_EXT_FLOWCTL:
> >>>>>>>>>           skb_queue_purge(&chan->tx_q);
> >>>>>>>>>           break;
> >>>>>>>>>
> >>>>>>>>> @@ -1260,6 +1272,17 @@ static void l2cap_move_done(struct l2cap=
_chan *chan)
> >>>>>>>>>   }
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> +static bool l2cap_mode_ready(struct l2cap_chan *chan)
> >>>>>>>>> +{
> >>>>>>>>> +     switch (chan->mode) {
> >>>>>>>>> +     case L2CAP_MODE_LE_FLOWCTL:
> >>>>>>>>> +     case L2CAP_MODE_EXT_FLOWCTL:
> >>>>>>>>> +             return chan->tx_credits ? true : false;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     return true;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> static void l2cap_chan_ready(struct l2cap_chan *chan)
> >>>>>>>>> {
> >>>>>>>>>   /* The channel may have already been flagged as connected in
> >>>>>>>>> @@ -1273,7 +1296,7 @@ static void l2cap_chan_ready(struct l2cap=
_chan *chan)
> >>>>>>>>>   chan->conf_state =3D 0;
> >>>>>>>>>   __clear_chan_timer(chan);
> >>>>>>>>>
> >>>>>>>>> -     if (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL && !chan->tx_=
credits)
> >>>>>>>>> +     if (!l2cap_mode_ready(chan))
> >>>>>>>>>           chan->ops->suspend(chan);
> >>>>>>>>
> >>>>>>>>     switch (chan->mode) {
> >>>>>>>>     case ..
> >>>>>>>>     case ..
> >>>>>>>>             if (!chan->tx_credits)
> >>>>>>>>                     chan->ops->suspend(chan);
> >>>>>>>>             break;
> >>>>>>>>     }
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>   chan->state =3D BT_CONNECTED;
> >>>>>>>>> @@ -1306,6 +1329,31 @@ static void l2cap_le_connect(struct l2ca=
p_chan *chan)
> >>>>>>>>>                  sizeof(req), &req);
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> +static void l2cap_ecred_connect(struct l2cap_chan *chan)
> >>>>>>>>> +{
> >>>>>>>>> +     struct l2cap_conn *conn =3D chan->conn;
> >>>>>>>>> +     struct {
> >>>>>>>>> +             struct l2cap_ecred_conn_req req;
> >>>>>>>>> +             __le16 scid;
> >>>>>>>>> +     } __packed pdu;
> >>>>>>>>> +
> >>>>>>>>> +     if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->fla=
gs))
> >>>>>>>>> +             return;
> >>>>>>>>> +
> >>>>>>>>> +     l2cap_ecred_init(chan, 0);
> >>>>>>>>> +
> >>>>>>>>> +     pdu.req.psm     =3D chan->psm;
> >>>>>>>>> +     pdu.req.mtu     =3D cpu_to_le16(chan->imtu);
> >>>>>>>>> +     pdu.req.mps     =3D cpu_to_le16(chan->mps);
> >>>>>>>>> +     pdu.req.credits =3D cpu_to_le16(chan->rx_credits);
> >>>>>>>>> +     pdu.scid        =3D cpu_to_le16(chan->scid);
> >>>>>>>>> +
> >>>>>>>>> +     chan->ident =3D l2cap_get_ident(conn);
> >>>>>>>>> +
> >>>>>>>>> +     l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_CONN_REQ,
> >>>>>>>>> +                    sizeof(pdu), &pdu);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> static void l2cap_le_start(struct l2cap_chan *chan)
> >>>>>>>>> {
> >>>>>>>>>   struct l2cap_conn *conn =3D chan->conn;
> >>>>>>>>> @@ -1318,8 +1366,12 @@ static void l2cap_le_start(struct l2cap_=
chan *chan)
> >>>>>>>>>           return;
> >>>>>>>>>   }
> >>>>>>>>>
> >>>>>>>>> -     if (chan->state =3D=3D BT_CONNECT)
> >>>>>>>>> -             l2cap_le_connect(chan);
> >>>>>>>>> +     if (chan->state =3D=3D BT_CONNECT) {
> >>>>>>>>> +             if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL)
> >>>>>>>>> +                     l2cap_ecred_connect(chan);
> >>>>>>>>> +             else
> >>>>>>>>> +                     l2cap_le_connect(chan);
> >>>>>>>>> +     }
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> static void l2cap_start_connection(struct l2cap_chan *chan)
> >>>>>>>>> @@ -2505,6 +2557,7 @@ int l2cap_chan_send(struct l2cap_chan *ch=
an, struct msghdr *msg, size_t len)
> >>>>>>>>>
> >>>>>>>>>   switch (chan->mode) {
> >>>>>>>>>   case L2CAP_MODE_LE_FLOWCTL:
> >>>>>>>>> +     case L2CAP_MODE_EXT_FLOWCTL:
> >>>>>>>>>           /* Check outgoing MTU */
> >>>>>>>>>           if (len > chan->omtu)
> >>>>>>>>>                   return -EMSGSIZE;
> >>>>>>>>> @@ -3773,6 +3826,42 @@ void __l2cap_le_connect_rsp_defer(struct=
 l2cap_chan *chan)
> >>>>>>>>>                  &rsp);
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> +void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
> >>>>>>>>> +{
> >>>>>>>>> +     struct l2cap_ecred_conn_rsp rsp;
> >>>>>>>>> +     struct l2cap_conn *conn =3D chan->conn;
> >>>>>>>>> +     u16 ident =3D chan->ident;
> >>>>>>>>> +     int i =3D 0;
> >>>>>>>>> +
> >>>>>>>>> +     if (!ident) {
> >>>>>>>>> +             return;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>
> >>>>>>>> No { } here.
> >>>>>>>>
> >>>>>>>>> +     BT_DBG("chan %p ident %d", chan, ident);
> >>>>>>>>> +
> >>>>>>>>> +     rsp.mtu     =3D cpu_to_le16(chan->imtu);
> >>>>>>>>> +     rsp.mps     =3D cpu_to_le16(chan->mps);
> >>>>>>>>> +     rsp.credits =3D cpu_to_le16(chan->rx_credits);
> >>>>>>>>> +     rsp.result  =3D cpu_to_le16(L2CAP_CR_LE_SUCCESS);
> >>>>>>>>> +
> >>>>>>>>> +     mutex_lock(&conn->chan_lock);
> >>>>>>>>> +
> >>>>>>>>> +     list_for_each_entry(chan, &conn->chan_l, list) {
> >>>>>>>>> +             if (chan->ident !=3D ident)
> >>>>>>>>> +                     continue;
> >>>>>>>>> +
> >>>>>>>>> +             /* Reset ident so only one response is sent */
> >>>>>>>>> +             chan->ident =3D 0;
> >>>>>>>>> +
> >>>>>>>>> +             /* Include all channels pending with the same ide=
nt */
> >>>>>>>>> +             rsp.dcid[i++] =3D cpu_to_le16(chan->scid);
> >>>>>>>>
> >>>>>>>> This doesn=E2=80=99t work. The sizeof(rsp) has no dcid in there.=
 You are overflowing into conn struct here.
> >>>>>>>>
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     mutex_unlock(&conn->chan_lock);
> >>>>>>>>> +
> >>>>>>>>> +     l2cap_send_cmd(conn, ident, L2CAP_ECRED_CONN_RSP, sizeof(=
rsp), &rsp);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
> >>>>>>>>> {
> >>>>>>>>>   struct l2cap_conn_rsp rsp;
> >>>>>>>>> @@ -5714,6 +5803,347 @@ static inline int l2cap_le_credits(stru=
ct l2cap_conn *conn,
> >>>>>>>>>   return 0;
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> +static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn=
,
> >>>>>>>>> +                                    struct l2cap_cmd_hdr *cmd,=
 u16 cmd_len,
> >>>>>>>>> +                                    u8 *data)
> >>>>>>>>> +{
> >>>>>>>>> +     struct l2cap_ecred_conn_req *req =3D (void *) data;
> >>>>>>>>> +     struct {
> >>>>>>>>> +             struct l2cap_ecred_conn_rsp rsp;
> >>>>>>>>> +             __le16 dcid[5];
> >>>>>>>>> +     } __packed pdu;
> >>>>>>>>> +     struct l2cap_chan *chan, *pchan;
> >>>>>>>>> +     u16 credits, mtu, mps;
> >>>>>>>>> +     __le16 psm;
> >>>>>>>>> +     u8 result, len =3D 0;
> >>>>>>>>> +     int i;
> >>>>>>>>> +     bool defer =3D false;
> >>>>>>>>> +
> >>>>>>>>> +     if (cmd_len < sizeof(*req))
> >>>>>>>>> +             return -EPROTO;
> >>>>>>>>> +
> >>>>>>>>> +     mtu  =3D __le16_to_cpu(req->mtu);
> >>>>>>>>> +     mps  =3D __le16_to_cpu(req->mps);
> >>>>>>>>> +
> >>>>>>>>> +     if (mtu < L2CAP_ECRED_MIN_MTU || mps < L2CAP_ECRED_MIN_MP=
S) {
> >>>>>>>>> +             result =3D L2CAP_CR_LE_UNACCEPT_PARAMS;
> >>>>>>>>> +             goto response;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     psm  =3D req->psm;
> >>>>>>>>> +     credits =3D 0;
> >>>>>>>>> +
> >>>>>>>>> +     BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), m=
tu, mps);
> >>>>>>>>> +
> >>>>>>>>> +     memset(&pdu, 0, sizeof(pdu));
> >>>>>>>>> +
> >>>>>>>>> +     /* Check if we have socket listening on psm */
> >>>>>>>>> +     pchan =3D l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn-=
>hcon->src,
> >>>>>>>>> +                                      &conn->hcon->dst, LE_LIN=
K);
> >>>>>>>>> +     if (!pchan) {
> >>>>>>>>> +             result =3D L2CAP_CR_LE_BAD_PSM;
> >>>>>>>>> +             goto response;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     mutex_lock(&conn->chan_lock);
> >>>>>>>>> +     l2cap_chan_lock(pchan);
> >>>>>>>>> +
> >>>>>>>>> +     if (!smp_sufficient_security(conn->hcon, pchan->sec_level=
,
> >>>>>>>>> +                                  SMP_ALLOW_STK)) {
> >>>>>>>>> +             result =3D L2CAP_CR_LE_AUTHENTICATION;
> >>>>>>>>> +             goto unlock;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     result =3D L2CAP_CR_LE_SUCCESS;
> >>>>>>>>> +
> >>>>>>>>> +     for (i =3D 0, cmd_len -=3D sizeof(req); cmd_len >=3D size=
of(u16);
> >>>>>>>>> +          i++, cmd_len -=3D sizeof(u16)) {
> >>>>>>>>
> >>>>>>>> Can we simplify the loop statement or switch to while statement?
> >>>>>>>>
> >>>>>>>>> +             u16 scid =3D __le16_to_cpu(req->scid[i]);
> >>>>>>>>> +
> >>>>>>>>> +             BT_DBG("scid[%d] 0x%4.4x", i, scid);
> >>>>>>>>> +
> >>>>>>>>> +             pdu.dcid[i] =3D 0x0000;
> >>>>>>>>> +             len +=3D sizeof(*pdu.dcid);
> >>>>>>>>> +
> >>>>>>>>> +             /* Check for valid dynamic CID range */
> >>>>>>>>> +             if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CI=
D_LE_DYN_END) {
> >>>>>>>>> +                     result =3D L2CAP_CR_LE_INVALID_SCID;
> >>>>>>>>> +                     continue;
> >>>>>>>>> +             }
> >>>>>>>>> +
> >>>>>>>>> +             /* Check if we already have channel with that dci=
d */
> >>>>>>>>> +             if (__l2cap_get_chan_by_dcid(conn, scid)) {
> >>>>>>>>> +                     result =3D L2CAP_CR_LE_SCID_IN_USE;
> >>>>>>>>> +                     continue;
> >>>>>>>>> +             }
> >>>>>>>>> +
> >>>>>>>>> +             chan =3D pchan->ops->new_connection(pchan);
> >>>>>>>>> +             if (!chan) {
> >>>>>>>>> +                     result =3D L2CAP_CR_LE_NO_MEM;
> >>>>>>>>> +                     continue;
> >>>>>>>>> +             }
> >>>>>>>>> +
> >>>>>>>>> +             bacpy(&chan->src, &conn->hcon->src);
> >>>>>>>>> +             bacpy(&chan->dst, &conn->hcon->dst);
> >>>>>>>>> +             chan->src_type =3D bdaddr_src_type(conn->hcon);
> >>>>>>>>> +             chan->dst_type =3D bdaddr_dst_type(conn->hcon);
> >>>>>>>>> +             chan->psm  =3D psm;
> >>>>>>>>> +             chan->dcid =3D scid;
> >>>>>>>>> +             chan->omtu =3D mtu;
> >>>>>>>>> +             chan->remote_mps =3D mps;
> >>>>>>>>> +
> >>>>>>>>> +             __l2cap_chan_add(conn, chan);
> >>>>>>>>> +
> >>>>>>>>> +             l2cap_ecred_init(chan, __le16_to_cpu(req->credits=
));
> >>>>>>>>> +
> >>>>>>>>> +             /* Init response */
> >>>>>>>>> +             if (!pdu.rsp.credits) {
> >>>>>>>>> +                     pdu.rsp.mtu =3D cpu_to_le16(chan->imtu);
> >>>>>>>>> +                     pdu.rsp.mps =3D cpu_to_le16(chan->mps);
> >>>>>>>>> +                     pdu.rsp.credits =3D cpu_to_le16(chan->rx_=
credits);
> >>>>>>>>> +             }
> >>>>>>>>> +
> >>>>>>>>> +             pdu.dcid[i] =3D cpu_to_le16(chan->scid);
> >>>>>>>>> +
> >>>>>>>>> +             __set_chan_timer(chan, chan->ops->get_sndtimeo(ch=
an));
> >>>>>>>>> +
> >>>>>>>>> +             chan->ident =3D cmd->ident;
> >>>>>>>>> +
> >>>>>>>>> +             if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
> >>>>>>>>> +                     l2cap_state_change(chan, BT_CONNECT2);
> >>>>>>>>> +                     defer =3D true;
> >>>>>>>>> +                     chan->ops->defer(chan);
> >>>>>>>>> +             } else {
> >>>>>>>>> +                     l2cap_chan_ready(chan);
> >>>>>>>>> +             }
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +unlock:
> >>>>>>>>> +     l2cap_chan_unlock(pchan);
> >>>>>>>>> +     mutex_unlock(&conn->chan_lock);
> >>>>>>>>> +     l2cap_chan_put(pchan);
> >>>>>>>>> +
> >>>>>>>>> +response:
> >>>>>>>>> +     pdu.rsp.result =3D cpu_to_le16(result);
> >>>>>>>>> +
> >>>>>>>>> +     if (defer)
> >>>>>>>>> +             return 0;
> >>>>>>>>> +
> >>>>>>>>> +     l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_CONN_RSP,
> >>>>>>>>> +                    sizeof(pdu.rsp) + len, &pdu);
> >>>>>>>>> +
> >>>>>>>>> +     return 0;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn=
,
> >>>>>>>>> +                                    struct l2cap_cmd_hdr *cmd,=
 u16 cmd_len,
> >>>>>>>>> +                                    u8 *data)
> >>>>>>>>> +{
> >>>>>>>>> +     struct l2cap_ecred_conn_rsp *rsp =3D (void *) data;
> >>>>>>>>> +     struct hci_conn *hcon =3D conn->hcon;
> >>>>>>>>> +     u16 mtu, mps, credits, result;
> >>>>>>>>> +     struct l2cap_chan *chan;
> >>>>>>>>> +     int err =3D 0, sec_level;
> >>>>>>>>> +     int i =3D 0;
> >>>>>>>>> +
> >>>>>>>>> +     if (cmd_len < sizeof(*rsp))
> >>>>>>>>> +             return -EPROTO;
> >>>>>>>>> +
> >>>>>>>>> +     mtu     =3D __le16_to_cpu(rsp->mtu);
> >>>>>>>>> +     mps     =3D __le16_to_cpu(rsp->mps);
> >>>>>>>>> +     credits =3D __le16_to_cpu(rsp->credits);
> >>>>>>>>> +     result  =3D __le16_to_cpu(rsp->result);
> >>>>>>>>> +
> >>>>>>>>> +     BT_DBG("mtu %u mps %u credits %u result 0x%4.4x", mtu, mp=
s, credits,
> >>>>>>>>> +            result);
> >>>>>>>>> +
> >>>>>>>>> +     mutex_lock(&conn->chan_lock);
> >>>>>>>>> +
> >>>>>>>>> +     cmd_len -=3D sizeof(*rsp);
> >>>>>>>>> +
> >>>>>>>>> +     list_for_each_entry(chan, &conn->chan_l, list) {
> >>>>>>>>> +             u16 dcid;
> >>>>>>>>> +
> >>>>>>>>> +             if (chan->ident !=3D cmd->ident ||
> >>>>>>>>> +                 chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL ||
> >>>>>>>>> +                 chan->state =3D=3D BT_CONNECTED)
> >>>>>>>>> +                     continue;
> >>>>>>>>> +
> >>>>>>>>> +             l2cap_chan_lock(chan);
> >>>>>>>>> +
> >>>>>>>>> +             /* Check that there is a dcid for each pending ch=
annel */
> >>>>>>>>> +             if (cmd_len < sizeof(dcid)) {
> >>>>>>>>> +                     l2cap_chan_del(chan, ECONNREFUSED);
> >>>>>>>>> +                     l2cap_chan_unlock(chan);
> >>>>>>>>> +                     continue;
> >>>>>>>>> +             }
> >>>>>>>>> +
> >>>>>>>>> +             dcid =3D __le16_to_cpu(rsp->dcid[i++]);
> >>>>>>>>> +             cmd_len -=3D sizeof(u16);
> >>>>>>>>> +
> >>>>>>>>> +             BT_DBG("dcid[%d] 0x%4.4x", i, dcid);
> >>>>>>>>> +
> >>>>>>>>> +             /* Check if dcid is already in use */
> >>>>>>>>> +             if (dcid && __l2cap_get_chan_by_dcid(conn, dcid))=
 {
> >>>>>>>>> +                     /* If a device receives a
> >>>>>>>>> +                      * L2CAP_CREDIT_BASED_CONNECTION_RSP pack=
et with an
> >>>>>>>>> +                      * already-assigned Destination CID, then=
 both the
> >>>>>>>>> +                      * original channel and the new channel s=
hall be
> >>>>>>>>> +                      * immediately discarded and not used.
> >>>>>>>>> +                      */
> >>>>>>>>> +                     l2cap_chan_del(chan, ECONNREFUSED);
> >>>>>>>>> +                     l2cap_chan_unlock(chan);
> >>>>>>>>> +                     chan =3D __l2cap_get_chan_by_dcid(conn, d=
cid);
> >>>>>>>>> +                     l2cap_chan_lock(chan);
> >>>>>>>>> +                     l2cap_chan_del(chan, ECONNRESET);
> >>>>>>>>> +                     l2cap_chan_unlock(chan);
> >>>>>>>>> +                     continue;
> >>>>>>>>> +             }
> >>>>>>>>> +
> >>>>>>>>> +             switch (result) {
> >>>>>>>>> +             case L2CAP_CR_LE_AUTHENTICATION:
> >>>>>>>>> +             case L2CAP_CR_LE_ENCRYPTION:
> >>>>>>>>> +                     /* If we already have MITM protection we =
can't do
> >>>>>>>>> +                      * anything.
> >>>>>>>>> +                      */
> >>>>>>>>> +                     if (hcon->sec_level > BT_SECURITY_MEDIUM)=
 {
> >>>>>>>>> +                             l2cap_chan_del(chan, ECONNREFUSED=
);
> >>>>>>>>> +                             break;
> >>>>>>>>> +                     }
> >>>>>>>>> +
> >>>>>>>>> +                     sec_level =3D hcon->sec_level + 1;
> >>>>>>>>> +                     if (chan->sec_level < sec_level)
> >>>>>>>>> +                             chan->sec_level =3D sec_level;
> >>>>>>>>> +
> >>>>>>>>> +                     /* We'll need to send a new Connect Reque=
st */
> >>>>>>>>> +                     clear_bit(FLAG_ECRED_CONN_REQ_SENT, &chan=
->flags);
> >>>>>>>>> +
> >>>>>>>>> +                     smp_conn_security(hcon, chan->sec_level);
> >>>>>>>>> +                     break;
> >>>>>>>>> +
> >>>>>>>>> +             case L2CAP_CR_LE_BAD_PSM:
> >>>>>>>>> +                     l2cap_chan_del(chan, ECONNREFUSED);
> >>>>>>>>> +                     break;
> >>>>>>>>> +
> >>>>>>>>> +             default:
> >>>>>>>>> +                     /* If dcid was not set it means channels =
was refused */
> >>>>>>>>> +                     if (!dcid) {
> >>>>>>>>> +                             l2cap_chan_del(chan, ECONNREFUSED=
);
> >>>>>>>>> +                             break;
> >>>>>>>>> +                     }
> >>>>>>>>> +
> >>>>>>>>> +                     chan->ident =3D 0;
> >>>>>>>>> +                     chan->dcid =3D dcid;
> >>>>>>>>> +                     chan->omtu =3D mtu;
> >>>>>>>>> +                     chan->remote_mps =3D mps;
> >>>>>>>>> +                     chan->tx_credits =3D credits;
> >>>>>>>>> +                     l2cap_chan_ready(chan);
> >>>>>>>>> +                     break;
> >>>>>>>>> +             }
> >>>>>>>>> +
> >>>>>>>>> +             l2cap_chan_unlock(chan);
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     mutex_unlock(&conn->chan_lock);
> >>>>>>>>> +
> >>>>>>>>> +     return err;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static inline int l2cap_ecred_reconf_req(struct l2cap_conn *co=
nn,
> >>>>>>>>> +                                      struct l2cap_cmd_hdr *cm=
d, u16 cmd_len,
> >>>>>>>>> +                                      u8 *data)
> >>>>>>>>> +{
> >>>>>>>>> +     struct l2cap_ecred_reconf_req *req =3D (void *) data;
> >>>>>>>>> +     struct l2cap_ecred_reconf_rsp rsp;
> >>>>>>>>> +     u16 mtu, mps, result;
> >>>>>>>>> +     struct l2cap_chan *chan;
> >>>>>>>>> +     int i;
> >>>>>>>>> +
> >>>>>>>>> +     if (cmd_len < sizeof(*req)) {
> >>>>>>>>> +             result =3D L2CAP_CR_LE_INVALID_PARAMS;
> >>>>>>>>> +             goto respond;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     mtu =3D __le16_to_cpu(req->mtu);
> >>>>>>>>> +     mps =3D __le16_to_cpu(req->mps);
> >>>>>>>>> +
> >>>>>>>>> +     BT_DBG("mtu %u mps %u", mtu, mps);
> >>>>>>>>> +
> >>>>>>>>> +     if (mtu < L2CAP_ECRED_MIN_MTU) {
> >>>>>>>>> +             result =3D L2CAP_RECONF_INVALID_MTU;
> >>>>>>>>> +             goto respond;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     if (mps < L2CAP_ECRED_MIN_MPS) {
> >>>>>>>>> +             result =3D L2CAP_RECONF_INVALID_MPS;
> >>>>>>>>> +             goto respond;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     result =3D L2CAP_RECONF_SUCCESS;
> >>>>>>>>> +
> >>>>>>>>> +     for (i =3D 0, cmd_len -=3D sizeof(*req); cmd_len < sizeof=
(u16);
> >>>>>>>>> +          i++, cmd_len -=3D sizeof(u16)) {
> >>>>>>>>
> >>>>>>>> Same comment as above.
> >>>>>>>>
> >>>>>>>>> +             u16 scid;
> >>>>>>>>> +
> >>>>>>>>> +             scid =3D __le16_to_cpu(req->scid[i]);
> >>>>>>>>> +             if (!scid)
> >>>>>>>>> +                     return -EPROTO;
> >>>>>>>>> +
> >>>>>>>>> +             chan =3D __l2cap_get_chan_by_dcid(conn, scid);
> >>>>>>>>> +             if (!chan)
> >>>>>>>>> +                     continue;
> >>>>>>>>> +
> >>>>>>>>> +             /* If the MTU value is decreased for any of the i=
ncluded
> >>>>>>>>> +              * channels, then the receiver shall disconnect a=
ll
> >>>>>>>>> +              * included channels.
> >>>>>>>>> +              */
> >>>>>>>>> +             if (chan->omtu > mtu) {
> >>>>>>>>> +                     BT_ERR("chan %p decreased MTU %u -> %u", =
chan,
> >>>>>>>>> +                            chan->omtu, mtu);
> >>>>>>>>> +                     result =3D L2CAP_RECONF_INVALID_MTU;
> >>>>>>>>> +             }
> >>>>>>>>> +
> >>>>>>>>> +             chan->omtu =3D mtu;
> >>>>>>>>> +             chan->remote_mps =3D mps;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +respond:
> >>>>>>>>> +     rsp.result =3D cpu_to_le16(result);
> >>>>>>>>> +
> >>>>>>>>> +     l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_RECONF_RSP, =
sizeof(rsp),
> >>>>>>>>> +                    &rsp);
> >>>>>>>>> +
> >>>>>>>>> +     return 0;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *co=
nn,
> >>>>>>>>> +                                      struct l2cap_cmd_hdr *cm=
d, u16 cmd_len,
> >>>>>>>>> +                                      u8 *data)
> >>>>>>>>> +{
> >>>>>>>>> +     struct l2cap_chan *chan;
> >>>>>>>>> +     struct l2cap_ecred_conn_rsp *rsp =3D (void *) data;
> >>>>>>>>> +     u16 result;
> >>>>>>>>> +
> >>>>>>>>> +     if (cmd_len < sizeof(*rsp))
> >>>>>>>>> +             return -EPROTO;
> >>>>>>>>> +
> >>>>>>>>> +     result =3D __le16_to_cpu(rsp->result);
> >>>>>>>>> +
> >>>>>>>>> +     BT_DBG("result 0x%4.4x", rsp->result);
> >>>>>>>>> +
> >>>>>>>>> +     if (!result)
> >>>>>>>>> +             return 0;
> >>>>>>>>> +
> >>>>>>>>> +     list_for_each_entry(chan, &conn->chan_l, list) {
> >>>>>>>>> +             if (chan->ident !=3D cmd->ident)
> >>>>>>>>> +                     continue;
> >>>>>>>>> +
> >>>>>>>>> +             l2cap_chan_del(chan, ECONNRESET);
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     return 0;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
> >>>>>>>>>                                  struct l2cap_cmd_hdr *cmd, u16=
 cmd_len,
> >>>>>>>>>                                  u8 *data)
> >>>>>>>>> @@ -5769,6 +6199,22 @@ static inline int l2cap_le_sig_cmd(struc=
t l2cap_conn *conn,
> >>>>>>>>>           err =3D l2cap_le_credits(conn, cmd, cmd_len, data);
> >>>>>>>>>           break;
> >>>>>>>>>
> >>>>>>>>> +     case L2CAP_ECRED_CONN_REQ:
> >>>>>>>>> +             err =3D l2cap_ecred_conn_req(conn, cmd, cmd_len, =
data);
> >>>>>>>>> +             break;
> >>>>>>>>> +
> >>>>>>>>> +     case L2CAP_ECRED_CONN_RSP:
> >>>>>>>>> +             err =3D l2cap_ecred_conn_rsp(conn, cmd, cmd_len, =
data);
> >>>>>>>>> +             break;
> >>>>>>>>> +
> >>>>>>>>> +     case L2CAP_ECRED_RECONF_REQ:
> >>>>>>>>> +             err =3D l2cap_ecred_reconf_req(conn, cmd, cmd_len=
, data);
> >>>>>>>>> +             break;
> >>>>>>>>> +
> >>>>>>>>> +     case L2CAP_ECRED_RECONF_RSP:
> >>>>>>>>> +             err =3D l2cap_ecred_reconf_rsp(conn, cmd, cmd_len=
, data);
> >>>>>>>>> +             break;
> >>>>>>>>> +
> >>>>>>>>>   case L2CAP_DISCONN_REQ:
> >>>>>>>>>           err =3D l2cap_disconnect_req(conn, cmd, cmd_len, data=
);
> >>>>>>>>>           break;
> >>>>>>>>> @@ -6814,11 +7260,13 @@ static void l2cap_chan_le_send_credits(=
struct l2cap_chan *chan)
> >>>>>>>>>   struct l2cap_le_credits pkt;
> >>>>>>>>>   u16 return_credits;
> >>>>>>>>>
> >>>>>>>>> -     return_credits =3D ((chan->imtu / chan->mps) + 1) - chan-=
>rx_credits;
> >>>>>>>>> +     return_credits =3D (chan->imtu / chan->mps) + 1;
> >>>>>>>>>
> >>>>>>>>> -     if (!return_credits)
> >>>>>>>>> +     if (chan->rx_credits >=3D return_credits)
> >>>>>>>>>           return;
> >>>>>>>>>
> >>>>>>>>> +     return_credits -=3D chan->rx_credits;
> >>>>>>>>> +
> >>>>>>>>>   BT_DBG("chan %p returning %u credits to sender", chan, return=
_credits);
> >>>>>>>>>
> >>>>>>>>>   chan->rx_credits +=3D return_credits;
> >>>>>>>>> @@ -6831,7 +7279,7 @@ static void l2cap_chan_le_send_credits(st=
ruct l2cap_chan *chan)
> >>>>>>>>>   l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pk=
t), &pkt);
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> -static int l2cap_le_recv(struct l2cap_chan *chan, struct sk_bu=
ff *skb)
> >>>>>>>>> +static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk=
_buff *skb)
> >>>>>>>>> {
> >>>>>>>>>   int err;
> >>>>>>>>>
> >>>>>>>>> @@ -6846,7 +7294,7 @@ static int l2cap_le_recv(struct l2cap_cha=
n *chan, struct sk_buff *skb)
> >>>>>>>>>   return err;
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> -static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct s=
k_buff *skb)
> >>>>>>>>> +static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struc=
t sk_buff *skb)
> >>>>>>>>> {
> >>>>>>>>>   int err;
> >>>>>>>>>
> >>>>>>>>> @@ -6894,7 +7342,7 @@ static int l2cap_le_data_rcv(struct l2cap=
_chan *chan, struct sk_buff *skb)
> >>>>>>>>>           }
> >>>>>>>>>
> >>>>>>>>>           if (skb->len =3D=3D sdu_len)
> >>>>>>>>> -                     return l2cap_le_recv(chan, skb);
> >>>>>>>>> +                     return l2cap_ecred_recv(chan, skb);
> >>>>>>>>>
> >>>>>>>>>           chan->sdu =3D skb;
> >>>>>>>>>           chan->sdu_len =3D sdu_len;
> >>>>>>>>> @@ -6926,7 +7374,7 @@ static int l2cap_le_data_rcv(struct l2cap=
_chan *chan, struct sk_buff *skb)
> >>>>>>>>>   skb =3D NULL;
> >>>>>>>>>
> >>>>>>>>>   if (chan->sdu->len =3D=3D chan->sdu_len) {
> >>>>>>>>> -             err =3D l2cap_le_recv(chan, chan->sdu);
> >>>>>>>>> +             err =3D l2cap_ecred_recv(chan, chan->sdu);
> >>>>>>>>>           if (!err) {
> >>>>>>>>>                   chan->sdu =3D NULL;
> >>>>>>>>>                   chan->sdu_last_frag =3D NULL;
> >>>>>>>>> @@ -6987,7 +7435,8 @@ static void l2cap_data_channel(struct l2c=
ap_conn *conn, u16 cid,
> >>>>>>>>>
> >>>>>>>>>   switch (chan->mode) {
> >>>>>>>>>   case L2CAP_MODE_LE_FLOWCTL:
> >>>>>>>>> -             if (l2cap_le_data_rcv(chan, skb) < 0)
> >>>>>>>>> +     case L2CAP_MODE_EXT_FLOWCTL:
> >>>>>>>>> +             if (l2cap_ecred_data_rcv(chan, skb) < 0)
> >>>>>>>>>                   goto drop;
> >>>>>>>>>
> >>>>>>>>>           goto done;
> >>>>>>>>> @@ -7214,8 +7663,8 @@ int l2cap_chan_connect(struct l2cap_chan =
*chan, __le16 psm, u16 cid,
> >>>>>>>>>   struct hci_dev *hdev;
> >>>>>>>>>   int err;
> >>>>>>>>>
> >>>>>>>>> -     BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", &chan->src, =
dst,
> >>>>>>>>> -            dst_type, __le16_to_cpu(psm));
> >>>>>>>>> +     BT_DBG("%pMR -> %pMR (type %u) psm 0x%4.4x mode 0x%2.2x",=
 &chan->src,
> >>>>>>>>> +            dst, dst_type, __le16_to_cpu(psm), chan->mode);
> >>>>>>>>>
> >>>>>>>>>   hdev =3D hci_get_route(dst, &chan->src, chan->src_type);
> >>>>>>>>>   if (!hdev)
> >>>>>>>>> @@ -7244,6 +7693,8 @@ int l2cap_chan_connect(struct l2cap_chan =
*chan, __le16 psm, u16 cid,
> >>>>>>>>>           break;
> >>>>>>>>>   case L2CAP_MODE_LE_FLOWCTL:
> >>>>>>>>>           break;
> >>>>>>>>> +     case L2CAP_MODE_EXT_FLOWCTL:
> >>>>>>>>> +             break;
> >>>>>>>>
> >>>>>>>> No need to do another break. Just put it under LE_FLOWCTL.
> >>>>>>>>
> >>>>>>>>>   case L2CAP_MODE_ERTM:
> >>>>>>>>>   case L2CAP_MODE_STREAMING:
> >>>>>>>>>           if (!disable_ertm)
> >>>>>>>>> @@ -7368,6 +7819,38 @@ int l2cap_chan_connect(struct l2cap_chan=
 *chan, __le16 psm, u16 cid,
> >>>>>>>>> }
> >>>>>>>>> EXPORT_SYMBOL_GPL(l2cap_chan_connect);
> >>>>>>>>>
> >>>>>>>>> +static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
> >>>>>>>>> +{
> >>>>>>>>> +     struct l2cap_conn *conn =3D chan->conn;
> >>>>>>>>> +     struct {
> >>>>>>>>> +             struct l2cap_ecred_reconf_req req;
> >>>>>>>>> +             __le16 scid;
> >>>>>>>>> +     } pdu;
> >>>>>>>>> +
> >>>>>>>>> +     pdu.req.mtu =3D cpu_to_le16(chan->imtu);
> >>>>>>>>> +     pdu.req.mps =3D cpu_to_le16(chan->mps);
> >>>>>>>>> +     pdu.scid    =3D cpu_to_le16(chan->scid);
> >>>>>>>>> +
> >>>>>>>>> +     chan->ident =3D l2cap_get_ident(conn);
> >>>>>>>>> +
> >>>>>>>>> +     l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
> >>>>>>>>> +                    sizeof(pdu), &pdu);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu)
> >>>>>>>>> +{
> >>>>>>>>> +     if (chan->imtu > mtu)
> >>>>>>>>> +             return -EINVAL;
> >>>>>>>>> +
> >>>>>>>>> +     BT_DBG("chan %p mtu 0x%4.4x", chan, mtu);
> >>>>>>>>> +
> >>>>>>>>> +     chan->imtu =3D mtu;
> >>>>>>>>> +
> >>>>>>>>> +     l2cap_ecred_reconfigure(chan);
> >>>>>>>>> +
> >>>>>>>>> +     return 0;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> /* ---- L2CAP interface with lower layer (HCI) ---- */
> >>>>>>>>>
> >>>>>>>>> int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
> >>>>>>>>> @@ -7579,7 +8062,8 @@ static void l2cap_security_cfm(struct hci=
_conn *hcon, u8 status, u8 encrypt)
> >>>>>>>>>                   else
> >>>>>>>>>                           __set_chan_timer(chan, L2CAP_DISC_TIM=
EOUT);
> >>>>>>>>>           } else if (chan->state =3D=3D BT_CONNECT2 &&
> >>>>>>>>> -                        chan->mode !=3D L2CAP_MODE_LE_FLOWCTL)=
 {
> >>>>>>>>> +                        !(chan->mode =3D=3D L2CAP_MODE_EXT_FLO=
WCTL ||
> >>>>>>>>> +                         chan->mode =3D=3D L2CAP_MODE_LE_FLOWC=
TL)) {
> >>>>>>>>
> >>>>>>>> Please double check that this line is correctly aligned after th=
e (.
> >>>>>>>>
> >>>>>>>>>                   struct l2cap_conn_rsp rsp;
> >>>>>>>>>                   __u16 res, stat;
> >>>>>>>>>
> >>>>>>>>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_s=
ock.c
> >>>>>>>>> index a7be8b59b3c2..12c557f7f40f 100644
> >>>>>>>>> --- a/net/bluetooth/l2cap_sock.c
> >>>>>>>>> +++ b/net/bluetooth/l2cap_sock.c
> >>>>>>>>> @@ -232,7 +232,7 @@ static int l2cap_sock_connect(struct socket=
 *sock, struct sockaddr *addr,
> >>>>>>>>>                   return -EINVAL;
> >>>>>>>>>   }
> >>>>>>>>>
> >>>>>>>>> -     if (chan->psm && bdaddr_type_is_le(chan->src_type))
> >>>>>>>>> +     if (chan->psm && bdaddr_type_is_le(chan->src_type) && !ch=
an->mode)
> >>>>>>>>>           chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >>>>>>>>>
> >>>>>>>>>   err =3D l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.=
l2_cid),
> >>>>>>>>> @@ -273,6 +273,7 @@ static int l2cap_sock_listen(struct socket =
*sock, int backlog)
> >>>>>>>>>   switch (chan->mode) {
> >>>>>>>>>   case L2CAP_MODE_BASIC:
> >>>>>>>>>   case L2CAP_MODE_LE_FLOWCTL:
> >>>>>>>>> +     case L2CAP_MODE_EXT_FLOWCTL:
> >>>>>>>>>           break;
> >>>>>>>>>   case L2CAP_MODE_ERTM:
> >>>>>>>>>   case L2CAP_MODE_STREAMING:
> >>>>>>>>> @@ -408,16 +409,6 @@ static int l2cap_sock_getsockopt_old(struc=
t socket *sock, int optname,
> >>>>>>>>>
> >>>>>>>>>   switch (optname) {
> >>>>>>>>>   case L2CAP_OPTIONS:
> >>>>>>>>> -             /* LE sockets should use BT_SNDMTU/BT_RCVMTU, but=
 since
> >>>>>>>>> -              * legacy ATT code depends on getsockopt for
> >>>>>>>>> -              * L2CAP_OPTIONS we need to let this pass.
> >>>>>>>>> -              */
> >>>>>>>>> -             if (bdaddr_type_is_le(chan->src_type) &&
> >>>>>>>>> -                 chan->scid !=3D L2CAP_CID_ATT) {
> >>>>>>>>> -                     err =3D -EINVAL;
> >>>>>>>>> -                     break;
> >>>>>>>>> -             }
> >>>>>>>>> -
> >>>>>>>>
> >>>>>>>> Should this be a separate patch. How do we keep this legacy beha=
vior.
> >>>>>>>
> >>>>>>> I kind have forgotten to fix this one, I guess we will need a new
> >>>>>>> option in order to read the mode without using the old L2CAP_OPTI=
ONS
> >>>>>>> then, or do you have anything against introducing yet another opt=
ion?
> >>>>>>
> >>>>>> so what is the problem here? Is this because L2CAP by itself can n=
ot tell if enhanced credit mode is supported by the peer?
> >>>>>
> >>>>> Yep, afaik there is no means to detect the support transparently,
> >>>>> otherwise could always prefer to use EXT_FLOWCTL instead of
> >>>>> LE_FLOWCTL, it seems at the point we introduced LE_FLOWCTL option w=
e
> >>>>> had always assumed there would not be any mode one could use when t=
he
> >>>>> address type is LE.
> >>>>>
> >>>>>> Do you actually want to create a new mode socket options with defi=
ned values by us to allow selected the mode of operation?
> >>>>>
> >>>>> I woud assume that is the only safe option here, though what I did =
was
> >>>>> to enable L2CAP_OPTIONS to work with LE addresses which I assume is
> >>>>> safe as previously it would cause an error no one would be using it=
.
> >>>>
> >>>> that is what I was afraid of. So can we use BT_SNDMTU and BT_RCVMTU =
and then only a mode property is missing? Or do we have other options that =
we want to configure.
> >>>
> >>> Not sure I follow, do you prefer chaning an existing option to add a
> >>> new field? I though having an option to set the mode would be better
> >>> but perhaps you want to combine it something else, well maybe some
> >>> sort of QOS interface, the problem is that the field are quite
> >>> different depending on the mode so Im afraid that would take a lot
> >>> more time to define.
> >>
> >> Let me ask this differently. What options do we want to be able to con=
figure if we deprecate L2CAP_OPTIONS?
> >
> > Coming back to this perhaps we could infer the mode if in case there
> > are multiple connection being made, the only question is if the spec
> > actually allow connection with the lagacy command if the remote side
> > is listen on PSM that is for ECRED mode like EATT, if it does require
> > maybe we can use BT_DEFER_SETUP to trigger it but I don't really like
> > reusing BT_DEFER_SETUP like that since it was introduced for a very
> > different purpose it may confuse people.
>
> you still haven=E2=80=99t answered my question. What kind of options do w=
e want the socket user to configure?

The current solution is using just the mode so it could detect if the
PSM is intended to use the new signalling or not, the spec don't seem
to be very clear if connection made to the PSM shall only accept the
new signalling or not, in theory I guess it doesn't since the PSM
domain is global connecting with legacy signalling should work as
well, it just don't allow connecting multiple sockets at once.

So my thingking is, if the there are pending l2cap_chan with
DEFER_SETUP set then use the new command, otherwise stick to the old
one, so the new signalling commands would only really be used when
there is more than one socket connecting, how about that?

> >> Anyhow, maybe we first introduce a debugfs option that says attempt_ec=
red_mode_first and only when the attempt fails fall back to credit based fl=
ow control mode.
> >
> > I was thinking in something like the following so we only use the new
> > mode if it is enabled, well provided we can remove it later:
> >
> > https://gist.github.com/Vudentz/35ca4a39b58e64e8ecbde3ff6ada2d61
>
> That looks fine to me.
>
> >> Btw. do we have at least a supported features bit in L2CAP hinting tha=
t ecred mode is supported over BR/EDR. It would be good to have some way of=
 knowing it for BR/EDR ahead of time.
> >
> > I don't remember it being added, but yes it would make a lot of sense
> > to have it when using over BR/EDR.
>
> If not, then we should file an erratum for it.
>
> >>>> For the multi-connect case, I was thinking that we use something sim=
ilar to DEFER_SETUP. If we set a DEFER_SETUP on an outgoing socket, then yo=
u can call connect() on a socket and succeeds. However no POLLIN | POLLOUT =
would be signaled. When calling a connect() without that option set, then a=
ll sockets become ready at the same time on success.
> >>>
> >>> As initiator I don't think we have a good match in the socket API as
> >>> it only return one fd at time, so currently it still doing the
> >>> connection one by one, what I though we could do is to delay a little
> >>> to group the request in a single L2CAP request, thought that creates
> >>> an extra latency for initiating the connection and can be racy.
> >>> Another option would be to allow bind to bind to multiple sockets at
> >>> once, so when you issue the connect in one socket it would connect al=
l
> >>> socket bound.
> >>
> >> Let me try to explain this in pseudo code.
> >>
> >>        fd1 =3D socket();
> >>        setsockopt(fd1, BT_DEFER_SETUP);
> >>        connect(fd1);
> >>        0 =3D poll(fd1);
> >>
> >>        fd2 =3D socket();
> >>        setsockopt(fd2, BT_DEFER_SETUP);
> >>        connect(fd2);
> >>        0 =3D poll(fd2);
> >>
> >>        fd3 =3D socket();
> >>        connect(fd3);
> >>        POLLOUT =3D poll(fd1);
> >>        POLLOUT =3D poll(fd2);
> >>        POLLOUT =3D poll(fd3);
> >>
> >> Essentially all the connect() call with BT_DEFER_SETUP will succeed, b=
ut POLLOUT will not signal. So you have the fd, but you can not write to it=
. When we have the connect() without BT_DEFER_SETUP set, then L2CAP will co=
nnect all channels at the same time and assign them to the given sockets. A=
nd now all fds become POLLOUT.
> >
> > Should work, btw couldn't we just use bind for the first 2 sockets?
> > That imo would make things a little cleaner since we only do connect
> > when it is really ready to connect and we don't have to even consider
> > poll until then, that said we would need to group these sockets either
> > way so we need to do this per processs, actually the order would be:
> >
> > fd# =3D socket()
> > bind(fd#)
> > setsockopt(fd#, BT_DEFER_SETUP)
> >
> > Since bind sets the address then on setsockopt we can check if there
> > is anything else pending to be connected for the same address and then
> > just proceed.
>
> With bind() you set the local address. With connect() you select the remo=
te address. I don=E2=80=99t see how bind() only would get us there.
>
> And the poll() part is not a problem btw. We should be doing asynchronous=
 write/send anyway. It is just that we have been a bit lazy with some of th=
e protocol implementation and execute write/send right away without checkin=
g with poll if the socket is actually writable. If we fix that then this wi=
ll be all dead simple. It is no different than an asynchronous connect() an=
yway. There you have to wait for poll() as well. I really doubt we are usin=
g blocking connect() calls. And if we do, we need to fix that.

You are right, here is a draft implementing this (not tested):

https://gist.github.com/Vudentz/5f4e34358f7a76518c054cfcd6bbf4fd

--=20
Luiz Augusto von Dentz
