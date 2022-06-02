Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DD5C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiFBPam convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiFBPal (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 11:30:41 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D418913C1FA
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 08:30:38 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fc30.dip0.t-ipconnect.de [79.249.252.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5068CCED1B;
        Thu,  2 Jun 2022 17:30:38 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH 1/3] Bluetooth: Add bt_status
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLurFxPz6MKzX3RmCO_usvayZoxK29eVBahWN_WFu4LtA@mail.gmail.com>
Date:   Thu, 2 Jun 2022 17:30:37 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D618974A-6335-4EE1-B980-F84808E0437E@holtmann.org>
References: <20220513234611.1360704-1-luiz.dentz@gmail.com>
 <83CE64EC-65DE-4DE9-994B-4729A35A6F64@holtmann.org>
 <CABBYNZ+Pd-5VbptVNwyd+7J2cFYr3rPUtPPc+L2s8cqzbBkKLg@mail.gmail.com>
 <56E87E28-21A2-400B-AB1B-EBEE2DBBC849@holtmann.org>
 <CABBYNZLurFxPz6MKzX3RmCO_usvayZoxK29eVBahWN_WFu4LtA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>>> This adds bt_status which can be used to convert Unix errno to
>>>>> Bluetooth status.
>>>>> 
>>>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>> ---
>>>>> include/net/bluetooth/bluetooth.h | 1 +
>>>>> net/bluetooth/lib.c | 71 +++++++++++++++++++++++++++++++
>>>>> 2 files changed, 72 insertions(+)
>>>>> 
>>>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>>>> index 6b48d9e2aab9..cfe6159f26bc 100644
>>>>> --- a/include/net/bluetooth/bluetooth.h
>>>>> +++ b/include/net/bluetooth/bluetooth.h
>>>>> @@ -521,6 +521,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
>>>>> }
>>>>> 
>>>>> int bt_to_errno(u16 code);
>>>>> +__u8 bt_status(int err);
>>>>> 
>>>>> void hci_sock_set_flag(struct sock *sk, int nr);
>>>>> void hci_sock_clear_flag(struct sock *sk, int nr);
>>>>> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
>>>>> index 5326f41a58b7..469a0c95b6e8 100644
>>>>> --- a/net/bluetooth/lib.c
>>>>> +++ b/net/bluetooth/lib.c
>>>>> @@ -135,6 +135,77 @@ int bt_to_errno(__u16 code)
>>>>> }
>>>>> EXPORT_SYMBOL(bt_to_errno);
>>>>> 
>>>>> +/* Unix errno to Bluetooth error codes mapping */
>>>>> +__u8 bt_status(int err)
>>>>> +{
>>>>> + /* Don't convert if already positive value */
>>>>> + if (err >= 0)
>>>>> + return err;
>>>>> +
>>>>> + switch (err) {
>>>>> + case -EBADRQC:
>>>>> + return 0x01;
>>>>> +
>>>>> + case -ENOTCONN:
>>>>> + return 0x02;
>>>>> +
>>>>> + case -EIO:
>>>>> + return 0x03;
>>>>> +
>>>>> + case -EHOSTDOWN:
>>>>> + return 0x04;
>>>>> +
>>>>> + case -EACCES:
>>>>> + return 0x05;
>>>>> +
>>>>> + case -EBADE:
>>>>> + return 0x06;
>>>>> +
>>>>> + case -ENOMEM:
>>>>> + return 0x07;
>>>>> +
>>>>> + case -ETIMEDOUT:
>>>>> + return 0x08;
>>>>> +
>>>>> + case -EMLINK:
>>>>> + return 0x09;
>>>>> +
>>>>> + case EALREADY:
>>>>> + return 0x0b;
>>>>> +
>>>>> + case -EBUSY:
>>>>> + return 0x0c;
>>>>> +
>>>>> + case -ECONNREFUSED:
>>>>> + return 0x0d;
>>>>> +
>>>>> + case -EOPNOTSUPP:
>>>>> + return 0x11;
>>>>> +
>>>>> + case -EINVAL:
>>>>> + return 0x12;
>>>>> +
>>>>> + case -ECONNRESET:
>>>>> + return 0x13;
>>>>> +
>>>>> + case -ECONNABORTED:
>>>>> + return 0x16;
>>>>> +
>>>>> + case ELOOP:
>>>>> + return 0x17;
>>>>> +
>>>>> + case -EPROTONOSUPPORT:
>>>>> + return 0x1a;
>>>>> +
>>>>> + case -EPROTO:
>>>>> + return 0x19;
>>>>> +
>>>>> + default:
>>>>> + return 0x1f;
>>>>> + }
>>>>> +}
>>>>> +EXPORT_SYMBOL(bt_status);
>>>>> +
>>>> 
>>>> why are exporting this?
>>> 
>>> Isn't it supposed to be exported since it is part of lib.c? All
>>> functions in this file use it.
>> 
>> is it used outside of bluetooth.ko?
> 
> Currently not, I just thought it would be convenient to have it
> accessible for the drivers as well since it is complementary to
> bt_to_errno.

drivers should really not need this. They should not have to look at HCI error status. They are pure transport drivers.

Regards

Marcel

