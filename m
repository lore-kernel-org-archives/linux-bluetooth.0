Return-Path: <SRS0=GIG2=4C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46960C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 07:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2448D20675
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 07:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgBNHwq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:52:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60218 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgBNHwq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Feb 2020 02:52:46 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id C26BDCECE1;
        Fri, 14 Feb 2020 09:02:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: Add BT_PHY socket option
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+MqBhjwCaU7UmezrT8nZ9h5WUZ4Fmrq+cXE_mQSy1E4g@mail.gmail.com>
Date:   Fri, 14 Feb 2020 08:52:44 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <4C035186-EB33-40B1-8A0D-227FBC2269BD@holtmann.org>
References: <20200207190055.15249-1-luiz.dentz@gmail.com>
 <13F78412-516A-4383-AD3F-F15296AA747B@holtmann.org>
 <CABBYNZJZZVzWe3CueUfNYUn8LJVTZinD7oSszPTbNBpTha4L3g@mail.gmail.com>
 <CABBYNZ+MqBhjwCaU7UmezrT8nZ9h5WUZ4Fmrq+cXE_mQSy1E4g@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>> This adds BT_PHY socket option (read-only) which can be used to read
>>>> the PHYs in use by the underline connection.
>>>> 
>>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>> ---
>>>> include/net/bluetooth/bluetooth.h | 17 ++++++
>>>> include/net/bluetooth/hci_core.h  |  2 +
>>>> net/bluetooth/hci_conn.c          | 88 +++++++++++++++++++++++++++++++
>>>> net/bluetooth/l2cap_sock.c        | 13 +++++
>>>> net/bluetooth/sco.c               | 13 +++++
>>>> 5 files changed, 133 insertions(+)
>>>> 
>>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>>> index e42bb8e03c09..1576353a2773 100644
>>>> --- a/include/net/bluetooth/bluetooth.h
>>>> +++ b/include/net/bluetooth/bluetooth.h
>>>> @@ -121,6 +121,23 @@ struct bt_voice {
>>>> 
>>>> #define BT_SNDMTU             12
>>>> #define BT_RCVMTU             13
>>>> +#define BT_PHY                       14
>>>> +
>>>> +#define BT_PHY_BR_1M_1SLOT   0x00000001
>>>> +#define BT_PHY_BR_1M_3SLOT   0x00000002
>>>> +#define BT_PHY_BR_1M_5SLOT   0x00000004
>>>> +#define BT_PHY_EDR_2M_1SLOT  0x00000008
>>>> +#define BT_PHY_EDR_2M_3SLOT  0x00000010
>>>> +#define BT_PHY_EDR_2M_5SLOT  0x00000020
>>>> +#define BT_PHY_EDR_3M_1SLOT  0x00000040
>>>> +#define BT_PHY_EDR_3M_3SLOT  0x00000080
>>>> +#define BT_PHY_EDR_3M_5SLOT  0x00000100
>>>> +#define BT_PHY_LE_1M_TX              0x00000200
>>>> +#define BT_PHY_LE_1M_RX              0x00000400
>>>> +#define BT_PHY_LE_2M_TX              0x00000800
>>>> +#define BT_PHY_LE_2M_RX              0x00001000
>>>> +#define BT_PHY_LE_CODED_TX   0x00002000
>>>> +#define BT_PHY_LE_CODED_RX   0x00004000
>>>> 
>>>> __printf(1, 2)
>>>> void bt_info(const char *fmt, ...);
>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>>> index 89ecf0a80aa1..dcc0dc6e2624 100644
>>>> --- a/include/net/bluetooth/hci_core.h
>>>> +++ b/include/net/bluetooth/hci_core.h
>>>> @@ -1477,6 +1477,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
>>>> struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
>>>>                           const void *param, u32 timeout);
>>>> 
>>>> +u32 hci_conn_get_phy(struct hci_conn *conn);
>>>> +
>>>> /* ----- HCI Sockets ----- */
>>>> void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
>>>> void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
>>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>>> index 87691404d0c6..9ff2611b272f 100644
>>>> --- a/net/bluetooth/hci_conn.c
>>>> +++ b/net/bluetooth/hci_conn.c
>>>> @@ -1725,3 +1725,91 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
>>>> 
>>>>      return hchan;
>>>> }
>>>> +
>>>> +u32 hci_conn_get_phy(struct hci_conn *conn)
>>>> +{
>>>> +     u32 phys = 0;
>>>> +
>>>> +     hci_dev_lock(conn->hdev);
>>>> +
>>>> +     switch (conn->type) {
>>>> +     case SCO_LINK:
>>>> +             phys |= BT_PHY_BR_1M_1SLOT;
>>>> +
>>>> +             break;
>>> 
>>> something is missing here. The SCO links can also be 3 and 5 slots.
>> 
>> I couldn't find any information regarding the slot for HV1, HV2, HV3
>> and DV so I assume they were all using 1 slot.
> 
> It is actually 1 slot, see:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 2, Part B
> page 471
> Table 6.2: Packets defined for synchronous, asynchronous, and CSB
> logical transport types

good call. I even managed to expunge that from my brain after 20 years of Bluetooth 1.1 spec ;)

Regards

Marcel

