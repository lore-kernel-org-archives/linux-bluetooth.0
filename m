Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC2C282DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 22:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23A22072A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 22:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQXcDvOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgAGWEb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:04:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37604 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgAGWEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 17:04:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so1583171otn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 14:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1I3Lap1UdY96YmZUp8nXYk0JsSpFaHiT7thuc+prAw=;
        b=BQXcDvOTBUczhBjo0p2Dq7aCm/0vdbyjEzQqgglxED3soRAuGUl87KE30n9ECvYppu
         PUnTb6V0acFbX/DdG/Act8mZxO+ZlbpbgYkaXDrLbR3S0nYUzW1ERty4TJFqLTm/r+8h
         Ni4OInSeUY9wHYqGpZXlHoSU6jNCeJxHC5kZ6zsyEpBmM0X3RWx+WmzWV1HZWEjSqlNi
         szj8kQywsKDo6sgMIcdiGLhbPud1Pof+wSFDpda2YpJ5xjOb1PHyk2SFRljrz7K8r1qh
         1urMN6zV8ZqN8F7najBn6cGtdFR8A2fHZye8pzWg3OJCISLR9Ezw2oh9nAiddCgf3oXi
         KKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1I3Lap1UdY96YmZUp8nXYk0JsSpFaHiT7thuc+prAw=;
        b=Tef7eW58Qy18qul+eBHbWH3HJL7fbUU0O08BhOL4Qs7zSXdXT0e2UbwgkHXquyEenB
         QJBXR7LbpekGYPYEWAKivkOHxyx+XsZfce9kp+l5ckSiPpTqmbZ5E+Df5hNSh3CO4S1C
         Fl1O1BcBdlozrVhyd+3vE72JE+QuZi7tiS7/FR0kcyCAC+qZDR7D950blzbolGAarNEH
         kye65s7BNGnkk755W14uE13DkNlFIUWGBUeMc0ucx3JsJCndx/g5u3/9JDEbKNlxN6JV
         7b0++wqtIvPs9gPrvfhN+o7/vMKU1ruK9BZeoBYhNGRdtTcvnudezMle+gG4wDDmKyEM
         Pksw==
X-Gm-Message-State: APjAAAV8xbS4ggrqfl3309HrsfhUklmt+O1LaRY87n7fvmQsF2tKybBH
        1xiudA4yZKtvqPePCl6qsmsZ6s1sVQ5i2Xb8wzQ=
X-Google-Smtp-Source: APXvYqzOwdaP+PInkexUy/VaUKzRwpEHEVHTaBxjm88/b0ik90QIl1AG017bE3M6Bp9AsEOvW4GzXK5pemabwCn2ii8=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr1758339oti.146.1578434670156;
 Tue, 07 Jan 2020 14:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20200102230057.31326-1-luiz.dentz@gmail.com> <20200102230057.31326-2-luiz.dentz@gmail.com>
 <4DB89428-A3CC-4035-AED8-B2CE7090FBD1@holtmann.org>
In-Reply-To: <4DB89428-A3CC-4035-AED8-B2CE7090FBD1@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jan 2020 14:04:17 -0800
Message-ID: <CABBYNZ+ykViH4h1usdsfudJ=iGGvqd2NkBoxNJT90bSO=g7zKQ@mail.gmail.com>
Subject: Re: [RFC 2/3] Bluetooth: Add BT_PHYS socket option
To:     Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sat, Jan 4, 2020 at 1:56 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds BT_PHYS socket option which can be used to read the PHYs in
> > use by the underline connection.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h | 17 ++++++++
> > include/net/bluetooth/hci_core.h  |  2 +
> > net/bluetooth/hci_conn.c          | 64 +++++++++++++++++++++++++++++++
> > net/bluetooth/l2cap_sock.c        | 13 +++++++
> > net/bluetooth/sco.c               | 13 +++++++
> > 5 files changed, 109 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index e42bb8e03c09..69c0e7eb26d9 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -121,6 +121,23 @@ struct bt_voice {
> >
> > #define BT_SNDMTU             12
> > #define BT_RCVMTU             13
> > +#define BT_PHYS                      14
> > +
> > +#define BT_PHY_BR_1M_1SLOT   0x00000001
> > +#define BT_PHY_BR_1M_3SLOT   0x00000002
> > +#define BT_PHY_BR_1M_5SLOT   0x00000004
> > +#define BT_PHY_EDR_2M_1SLOT  0x00000008
> > +#define BT_PHY_EDR_2M_3SLOT  0x00000010
> > +#define BT_PHY_EDR_2M_5SLOT  0x00000020
> > +#define BT_PHY_EDR_3M_1SLOT  0x00000040
> > +#define BT_PHY_EDR_3M_3SLOT  0x00000080
> > +#define BT_PHY_EDR_3M_5SLOT  0x00000100
> > +#define BT_PHY_LE_1M_TX              0x00000200
> > +#define BT_PHY_LE_1M_RX              0x00000400
> > +#define BT_PHY_LE_2M_TX              0x00000800
> > +#define BT_PHY_LE_2M_RX              0x00001000
> > +#define BT_PHY_LE_CODED_TX   0x00002000
> > +#define BT_PHY_LE_CODED_RX   0x00004000
> >
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index faebe3859931..03cf3f0f22b9 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1467,6 +1467,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> > struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> >                            const void *param, u32 timeout);
> >
> > +u32 hci_conn_get_phys(struct hci_conn *conn);
> > +
> > /* ----- HCI Sockets ----- */
> > void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
> > void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 87691404d0c6..386e6b0bd2ab 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1725,3 +1725,67 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
> >
> >       return hchan;
> > }
> > +
> > +u32 hci_conn_get_phys(struct hci_conn *conn)
> > +{
> > +     u32 phys = 0;
> > +
> > +     hci_dev_lock(conn->hdev);
> > +
> > +     switch (conn->type) {
> > +     case ACL_LINK:
> > +     case SCO_LINK:
> > +             phys |= BT_PHY_BR_1M_1SLOT;
> > +
> > +             if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
> > +                     phys |= BT_PHY_BR_1M_3SLOT;
> > +
> > +             if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
> > +                     phys |= BT_PHY_BR_1M_5SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_2DH1))
> > +                     phys |= BT_PHY_EDR_2M_1SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_2DH3))
> > +                     phys |= BT_PHY_EDR_2M_3SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_2DH5))
> > +                     phys |= BT_PHY_EDR_2M_5SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_3DH1))
> > +                     phys |= BT_PHY_EDR_3M_1SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_3DH3))
> > +                     phys |= BT_PHY_EDR_3M_3SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_3DH5))
> > +                     phys |= BT_PHY_EDR_3M_5SLOT;
> > +
> > +             break;
>
> Actually ACL packet types and eSCO packet types are different. You need to split this into packet helpers for L2CAP BR/EDR and LE and SCO/eSCO packet types.

Right the SCO and ESCO actually use EV packet types, though the
question is then should we map them to new bit-fields on BT_PHY
namespace or just use the same defines (RATE+SLOT) since the socket
family should be enough to indicate if they are EV rather than DH
packets? @Pali do you need the exact packet type for sco/esco, afaik
there is not so much use of them in that case because the codecs are
normally fixed rate over HFP.

> I hope we actually do this all correctly to track the packets types. Especially since the host just sets the allowed packet types and the controller can choose whatever type they want.

At least we do seem to store them properly for ACL.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
