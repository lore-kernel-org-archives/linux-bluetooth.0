Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24D9C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45182076F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgCXSh2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:37:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40575 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgCXSh2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 14:37:28 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 45085CECBE;
        Tue, 24 Mar 2020 19:46:58 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v5 3/3] Bluetooth: Add BT_MODE socket option
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJefwjHOJdLHe_pj6g_sZzSdAqWgprfAs3bgQOY8=ESHA@mail.gmail.com>
Date:   Tue, 24 Mar 2020 19:37:25 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BE08FB57-ED55-486F-85F9-180025895569@holtmann.org>
References: <20200323203458.24733-1-luiz.dentz@gmail.com>
 <20200323203458.24733-4-luiz.dentz@gmail.com>
 <90C51C98-B30D-44A6-9E87-321A4758C684@holtmann.org>
 <CABBYNZJefwjHOJdLHe_pj6g_sZzSdAqWgprfAs3bgQOY8=ESHA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds BT_MODE socket option which can be used to set L2CAP modes,
>>> including modes only supported over LE which were not supported using
>>> the L2CAP_OPTIONS.
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> include/net/bluetooth/bluetooth.h |   8 ++
>>> include/net/bluetooth/l2cap.h     |   6 ++
>>> net/bluetooth/l2cap_sock.c        | 124 ++++++++++++++++++++++++++++++
>>> 3 files changed, 138 insertions(+)
>>> 
>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>> index 1576353a2773..3fa7b1e3c5d9 100644
>>> --- a/include/net/bluetooth/bluetooth.h
>>> +++ b/include/net/bluetooth/bluetooth.h
>>> @@ -139,6 +139,14 @@ struct bt_voice {
>>> #define BT_PHY_LE_CODED_TX    0x00002000
>>> #define BT_PHY_LE_CODED_RX    0x00004000
>>> 
>>> +#define BT_MODE                      15
>>> +
>>> +#define BT_MODE_BASIC                0x00
>>> +#define BT_MODE_ERTM         0x01
>>> +#define BT_MODE_STREAMING    0x02
>>> +#define BT_MODE_LE_FLOWCTL   0x03
>>> +#define BT_MODE_EXT_FLOWCTL  0x04
>>> +
>>> __printf(1, 2)
>>> void bt_info(const char *fmt, ...);
>>> __printf(1, 2)
>>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>>> index dada14d0622c..56f727ba23bd 100644
>>> --- a/include/net/bluetooth/l2cap.h
>>> +++ b/include/net/bluetooth/l2cap.h
>>> @@ -720,9 +720,15 @@ struct l2cap_user {
>>> /* ----- L2CAP socket info ----- */
>>> #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
>>> 
>>> +#define L2CAP_PI_OPTION_UNSET                0x00
>>> +#define L2CAP_PI_OPTION_LEGACY               0x01
>>> +#define L2CAP_PI_OPTION_BT_MODE              0x02
>>> +
>>> struct l2cap_pinfo {
>>>      struct bt_sock          bt;
>>>      struct l2cap_chan       *chan;
>>> +     u8                      option;
>>> +     u8                      bt_mode;
>>>      struct sk_buff          *rx_busy_skb;
>>> };
>> 
>> why do you want to store bt_mode here. Whatever we have in l2cap_chan should be plenty.
> 
> Ive thought it would be cleaner to mess with types that comes from the
> spec itself so l2cap_chan would continue to use them.

Actually the LE_FLOWCTL and EXT_FLOWCTL are not spec values either. Frankly I don’t care which ones we store right now. I am fine keeping the spec one for now and just translate it to BT_MODE.

>> I also looked at l2cap_sock_setsockopt_old and if you use L2CAP_OPTIONS and want to read BT_MODE, then everything should be fine. Same as setting BT_MODE (except EXT_FLOWCTL) and then reading L2CAP_OPTIONS is fine as well. We can all translate this properly and with have EINVAL return errors for not supported / disabled modes.
>> 
>> So the only time L2CAP_OPTIONS read should fail is if you use BT_MODE with EXT_FLOWCTL as mode. So you can just check the mode set in l2cap_chan. And we start using our new mode definition there and then convert it for L2CAP_OPTIONS.
> 
> Sure, I thought it would be more efficient to not have conversions
> back and forth but Im fine either way.

In the end it makes the code simpler to just do the conversion. And once we add a kernel option to disable setsockopt_old, we have less code.

Regards

Marcel

