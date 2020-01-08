Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E214C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6769220656
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgAHUwy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:52:54 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42951 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgAHUwx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 15:52:53 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id E2EB0CECFA;
        Wed,  8 Jan 2020 22:02:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [RFC 2/3] Bluetooth: Add BT_PHYS socket option
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+ykViH4h1usdsfudJ=iGGvqd2NkBoxNJT90bSO=g7zKQ@mail.gmail.com>
Date:   Wed, 8 Jan 2020 21:52:51 +0100
Cc:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EA740B73-BCB4-47E8-9A65-FFB15962C4DA@holtmann.org>
References: <20200102230057.31326-1-luiz.dentz@gmail.com>
 <20200102230057.31326-2-luiz.dentz@gmail.com>
 <4DB89428-A3CC-4035-AED8-B2CE7090FBD1@holtmann.org>
 <CABBYNZ+ykViH4h1usdsfudJ=iGGvqd2NkBoxNJT90bSO=g7zKQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds BT_PHYS socket option which can be used to read the PHYs in
>>> use by the underline connection.
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> include/net/bluetooth/bluetooth.h | 17 ++++++++
>>> include/net/bluetooth/hci_core.h  |  2 +
>>> net/bluetooth/hci_conn.c          | 64 +++++++++++++++++++++++++++++++
>>> net/bluetooth/l2cap_sock.c        | 13 +++++++
>>> net/bluetooth/sco.c               | 13 +++++++
>>> 5 files changed, 109 insertions(+)
>>> 
>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>> index e42bb8e03c09..69c0e7eb26d9 100644
>>> --- a/include/net/bluetooth/bluetooth.h
>>> +++ b/include/net/bluetooth/bluetooth.h
>>> @@ -121,6 +121,23 @@ struct bt_voice {
>>> 
>>> #define BT_SNDMTU             12
>>> #define BT_RCVMTU             13
>>> +#define BT_PHYS                      14
>>> +
>>> +#define BT_PHY_BR_1M_1SLOT   0x00000001
>>> +#define BT_PHY_BR_1M_3SLOT   0x00000002
>>> +#define BT_PHY_BR_1M_5SLOT   0x00000004
>>> +#define BT_PHY_EDR_2M_1SLOT  0x00000008
>>> +#define BT_PHY_EDR_2M_3SLOT  0x00000010
>>> +#define BT_PHY_EDR_2M_5SLOT  0x00000020
>>> +#define BT_PHY_EDR_3M_1SLOT  0x00000040
>>> +#define BT_PHY_EDR_3M_3SLOT  0x00000080
>>> +#define BT_PHY_EDR_3M_5SLOT  0x00000100
>>> +#define BT_PHY_LE_1M_TX              0x00000200
>>> +#define BT_PHY_LE_1M_RX              0x00000400
>>> +#define BT_PHY_LE_2M_TX              0x00000800
>>> +#define BT_PHY_LE_2M_RX              0x00001000
>>> +#define BT_PHY_LE_CODED_TX   0x00002000
>>> +#define BT_PHY_LE_CODED_RX   0x00004000
>>> 
>>> __printf(1, 2)
>>> void bt_info(const char *fmt, ...);
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index faebe3859931..03cf3f0f22b9 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -1467,6 +1467,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
>>> struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
>>>                           const void *param, u32 timeout);
>>> 
>>> +u32 hci_conn_get_phys(struct hci_conn *conn);
>>> +
>>> /* ----- HCI Sockets ----- */
>>> void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
>>> void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index 87691404d0c6..386e6b0bd2ab 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -1725,3 +1725,67 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
>>> 
>>>      return hchan;
>>> }
>>> +
>>> +u32 hci_conn_get_phys(struct hci_conn *conn)
>>> +{
>>> +     u32 phys = 0;
>>> +
>>> +     hci_dev_lock(conn->hdev);
>>> +
>>> +     switch (conn->type) {
>>> +     case ACL_LINK:
>>> +     case SCO_LINK:
>>> +             phys |= BT_PHY_BR_1M_1SLOT;
>>> +
>>> +             if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
>>> +                     phys |= BT_PHY_BR_1M_3SLOT;
>>> +
>>> +             if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
>>> +                     phys |= BT_PHY_BR_1M_5SLOT;
>>> +
>>> +             if (!(conn->pkt_type & HCI_2DH1))
>>> +                     phys |= BT_PHY_EDR_2M_1SLOT;
>>> +
>>> +             if (!(conn->pkt_type & HCI_2DH3))
>>> +                     phys |= BT_PHY_EDR_2M_3SLOT;
>>> +
>>> +             if (!(conn->pkt_type & HCI_2DH5))
>>> +                     phys |= BT_PHY_EDR_2M_5SLOT;
>>> +
>>> +             if (!(conn->pkt_type & HCI_3DH1))
>>> +                     phys |= BT_PHY_EDR_3M_1SLOT;
>>> +
>>> +             if (!(conn->pkt_type & HCI_3DH3))
>>> +                     phys |= BT_PHY_EDR_3M_3SLOT;
>>> +
>>> +             if (!(conn->pkt_type & HCI_3DH5))
>>> +                     phys |= BT_PHY_EDR_3M_5SLOT;
>>> +
>>> +             break;
>> 
>> Actually ACL packet types and eSCO packet types are different. You need to split this into packet helpers for L2CAP BR/EDR and LE and SCO/eSCO packet types.
> 
> Right the SCO and ESCO actually use EV packet types, though the
> question is then should we map them to new bit-fields on BT_PHY
> namespace or just use the same defines (RATE+SLOT) since the socket
> family should be enough to indicate if they are EV rather than DH
> packets? @Pali do you need the exact packet type for sco/esco, afaik
> there is not so much use of them in that case because the codecs are
> normally fixed rate over HFP.

I am fine using the same definitions that we use in MGMT API. Do we plan also allowing to change packet types and also set up the initial packet types. So you can do socket(), ioctl(BT_PHYS), connect().

Regards

Marcel

