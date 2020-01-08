Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EEBC282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AF0206DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuRqM6qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgAHVJF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:09:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43829 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHVJF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:09:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so3944604oif.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fudWpVzANWH+0RPB6OJU9y62NdCPUiEiF9mzFkkgDjc=;
        b=VuRqM6qgDOVoRrnHEhewUQbUrhnZix7XHPV5a+H6QH6SV4neT8bFTGJqTWdlMjWEtp
         Q2seKTx6k0Eu4+BUM69b50pyySqmoZE6VBYvYGVD09jJVf0bO1ONCHAzUeS/I6zz2//E
         tHjdeFgFRvS/IGrqquu+1KeQp2sCDLHzo9fA5FwkkO4m/qeFON9VU98IL8uZBIJvnoUg
         YzMf3A3nA/i6q+iSr57RC2fUnjp4L50qSjPzr+tPMc59Gl+K4VmZieJ1+EILJKYN02ju
         a79mRP84VhyuA6NTScM2ztiqyzSKplXuNglETzXkON8CzYxBZB43xXokrSkeA2PkKimY
         azYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fudWpVzANWH+0RPB6OJU9y62NdCPUiEiF9mzFkkgDjc=;
        b=dgGJSEx/e5b6Fgs3qSI60AunKDSMwlKfLENRWhEEj7faXFYG3WFV44cjf+7OZsOga3
         zsPZEzRo5/kCwUzrdCPN/8a2Y7NUas5UUYVVwZKHzehCMRhg3B+43NMVgCuM13V628zN
         SbfPDarIBo7VmRu9CYpXdO8UaNTzvqGi90er/b3lrKMlqpcJc4D3uok3xP5XQHLdCkXE
         AZ0VVXC54whge3fZMQNTdaI6DqUa6zjf5hltELc2XPFi346eHhtPKrznGbJZBMvvY5rh
         9aqBz2a9HurySSdm7NpA1UcKZ996eg1/oxW2x7eBbbhv7uq71l7IDMb+kz49f+6xpvuM
         rAbQ==
X-Gm-Message-State: APjAAAV5QfZlmpLBNHdDr8axYVxCXrZlNVv6t0KH4Hipsi24mMO8mgzq
        b5CKYwOvr6V1Y33RdL9MMk/QRiKdw1KQmwE27zVZ7gku
X-Google-Smtp-Source: APXvYqwivs/R/VJEQDEiOSciR8rp7rnC44Yy/Aom7bxo5Sc5eqksmB9gZwmHjIA09BP92GzQ6lv8W0/nfR/dlMvsMBM=
X-Received: by 2002:aca:d610:: with SMTP id n16mr495352oig.108.1578517744219;
 Wed, 08 Jan 2020 13:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20200102230057.31326-1-luiz.dentz@gmail.com> <20200102230057.31326-2-luiz.dentz@gmail.com>
 <4DB89428-A3CC-4035-AED8-B2CE7090FBD1@holtmann.org> <CABBYNZ+ykViH4h1usdsfudJ=iGGvqd2NkBoxNJT90bSO=g7zKQ@mail.gmail.com>
 <EA740B73-BCB4-47E8-9A65-FFB15962C4DA@holtmann.org>
In-Reply-To: <EA740B73-BCB4-47E8-9A65-FFB15962C4DA@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 13:08:51 -0800
Message-ID: <CABBYNZJ54CZHqqY1Rr7mjjf9Hmm6pdHNf4aBFRJ71ebXKCLRnw@mail.gmail.com>
Subject: Re: [RFC 2/3] Bluetooth: Add BT_PHYS socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Jan 8, 2020 at 12:52 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >>> This adds BT_PHYS socket option which can be used to read the PHYs in
> >>> use by the underline connection.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> include/net/bluetooth/bluetooth.h | 17 ++++++++
> >>> include/net/bluetooth/hci_core.h  |  2 +
> >>> net/bluetooth/hci_conn.c          | 64 +++++++++++++++++++++++++++++++
> >>> net/bluetooth/l2cap_sock.c        | 13 +++++++
> >>> net/bluetooth/sco.c               | 13 +++++++
> >>> 5 files changed, 109 insertions(+)
> >>>
> >>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> >>> index e42bb8e03c09..69c0e7eb26d9 100644
> >>> --- a/include/net/bluetooth/bluetooth.h
> >>> +++ b/include/net/bluetooth/bluetooth.h
> >>> @@ -121,6 +121,23 @@ struct bt_voice {
> >>>
> >>> #define BT_SNDMTU             12
> >>> #define BT_RCVMTU             13
> >>> +#define BT_PHYS                      14
> >>> +
> >>> +#define BT_PHY_BR_1M_1SLOT   0x00000001
> >>> +#define BT_PHY_BR_1M_3SLOT   0x00000002
> >>> +#define BT_PHY_BR_1M_5SLOT   0x00000004
> >>> +#define BT_PHY_EDR_2M_1SLOT  0x00000008
> >>> +#define BT_PHY_EDR_2M_3SLOT  0x00000010
> >>> +#define BT_PHY_EDR_2M_5SLOT  0x00000020
> >>> +#define BT_PHY_EDR_3M_1SLOT  0x00000040
> >>> +#define BT_PHY_EDR_3M_3SLOT  0x00000080
> >>> +#define BT_PHY_EDR_3M_5SLOT  0x00000100
> >>> +#define BT_PHY_LE_1M_TX              0x00000200
> >>> +#define BT_PHY_LE_1M_RX              0x00000400
> >>> +#define BT_PHY_LE_2M_TX              0x00000800
> >>> +#define BT_PHY_LE_2M_RX              0x00001000
> >>> +#define BT_PHY_LE_CODED_TX   0x00002000
> >>> +#define BT_PHY_LE_CODED_RX   0x00004000
> >>>
> >>> __printf(1, 2)
> >>> void bt_info(const char *fmt, ...);
> >>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >>> index faebe3859931..03cf3f0f22b9 100644
> >>> --- a/include/net/bluetooth/hci_core.h
> >>> +++ b/include/net/bluetooth/hci_core.h
> >>> @@ -1467,6 +1467,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> >>> struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> >>>                           const void *param, u32 timeout);
> >>>
> >>> +u32 hci_conn_get_phys(struct hci_conn *conn);
> >>> +
> >>> /* ----- HCI Sockets ----- */
> >>> void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
> >>> void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> >>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >>> index 87691404d0c6..386e6b0bd2ab 100644
> >>> --- a/net/bluetooth/hci_conn.c
> >>> +++ b/net/bluetooth/hci_conn.c
> >>> @@ -1725,3 +1725,67 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
> >>>
> >>>      return hchan;
> >>> }
> >>> +
> >>> +u32 hci_conn_get_phys(struct hci_conn *conn)
> >>> +{
> >>> +     u32 phys = 0;
> >>> +
> >>> +     hci_dev_lock(conn->hdev);
> >>> +
> >>> +     switch (conn->type) {
> >>> +     case ACL_LINK:
> >>> +     case SCO_LINK:
> >>> +             phys |= BT_PHY_BR_1M_1SLOT;
> >>> +
> >>> +             if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
> >>> +                     phys |= BT_PHY_BR_1M_3SLOT;
> >>> +
> >>> +             if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
> >>> +                     phys |= BT_PHY_BR_1M_5SLOT;
> >>> +
> >>> +             if (!(conn->pkt_type & HCI_2DH1))
> >>> +                     phys |= BT_PHY_EDR_2M_1SLOT;
> >>> +
> >>> +             if (!(conn->pkt_type & HCI_2DH3))
> >>> +                     phys |= BT_PHY_EDR_2M_3SLOT;
> >>> +
> >>> +             if (!(conn->pkt_type & HCI_2DH5))
> >>> +                     phys |= BT_PHY_EDR_2M_5SLOT;
> >>> +
> >>> +             if (!(conn->pkt_type & HCI_3DH1))
> >>> +                     phys |= BT_PHY_EDR_3M_1SLOT;
> >>> +
> >>> +             if (!(conn->pkt_type & HCI_3DH3))
> >>> +                     phys |= BT_PHY_EDR_3M_3SLOT;
> >>> +
> >>> +             if (!(conn->pkt_type & HCI_3DH5))
> >>> +                     phys |= BT_PHY_EDR_3M_5SLOT;
> >>> +
> >>> +             break;
> >>
> >> Actually ACL packet types and eSCO packet types are different. You need to split this into packet helpers for L2CAP BR/EDR and LE and SCO/eSCO packet types.
> >
> > Right the SCO and ESCO actually use EV packet types, though the
> > question is then should we map them to new bit-fields on BT_PHY
> > namespace or just use the same defines (RATE+SLOT) since the socket
> > family should be enough to indicate if they are EV rather than DH
> > packets? @Pali do you need the exact packet type for sco/esco, afaik
> > there is not so much use of them in that case because the codecs are
> > normally fixed rate over HFP.
>
> I am fine using the same definitions that we use in MGMT API. Do we plan also allowing to change packet types and also set up the initial packet types. So you can do socket(), ioctl(BT_PHYS), connect().

I guess we could enable BT_PHYS on setsocketopt, though we would need
to have some logic to aggregate in case there are multiple sockets
requesting different things, we would have to decide on the likes of
latency over bandwidth or vice versa, with this we could in theory
allow overwriting the ISO packets types instead of always using the
defaults from the spec (which some people claims are not the great),
for ACL Im not sure it would make much of a difference since we allow
the controller to use any of the packets it would support, for LE
though it might be useful to allow user to use 1M if 2M doesn't work
for some reason.

-- 
Luiz Augusto von Dentz
