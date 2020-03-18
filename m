Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A5C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBCC2072C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 19:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCRT1U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:27:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38219 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRT1U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 15:27:20 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5FF49CECFD;
        Wed, 18 Mar 2020 20:36:49 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 2/2] Bluetooth: Add BT_MODE socket option
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJ70enQjBcMPkXaHP+p4dno4ADnafhutFwzB3458Ywgpg@mail.gmail.com>
Date:   Wed, 18 Mar 2020 20:27:18 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <80F7E75C-EC6D-4BE4-A97F-603FD9EFABB4@holtmann.org>
References: <20200312222454.5079-1-luiz.dentz@gmail.com>
 <20200312222454.5079-3-luiz.dentz@gmail.com>
 <9F37D24D-BB2A-45B4-922D-8E2E1AB31C2C@holtmann.org>
 <CABBYNZJ70enQjBcMPkXaHP+p4dno4ADnafhutFwzB3458Ywgpg@mail.gmail.com>
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
>>> include/net/bluetooth/bluetooth.h |  2 +
>>> net/bluetooth/l2cap_sock.c        | 79 +++++++++++++++++++++++++------
>>> 2 files changed, 66 insertions(+), 15 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>> index 1576353a2773..c361ec7b06aa 100644
>>> --- a/include/net/bluetooth/bluetooth.h
>>> +++ b/include/net/bluetooth/bluetooth.h
>>> @@ -139,6 +139,8 @@ struct bt_voice {
>>> #define BT_PHY_LE_CODED_TX    0x00002000
>>> #define BT_PHY_LE_CODED_RX    0x00004000
>>> 
>>> +#define BT_MODE                      15
>>> +
>> 
>> I would cleanly define the BT_MODE_xx constants here. They don’t need to match spec numbers from L2CAP actually. I would also leave the not used BR/EDR constants out of it and just add modes we do support.
> 
> Id leave the same values since it makes easier to fallback if BT_MODE
> is not supported e.g. BT_IO_MODE would have to declare 2 different
> namespaces for the new and the old sockopt.

I would actually not do that since we already made up a mode that isn’t in spec. And I don’t want to keep having to make up modes until this tiny namespace explodes. We need to accept that for BlueZ we have to define our own API and can not rely on values defined in the specification. It was fine for Bluetooth 2.1 and earlier, but it isn’t anymore.

> 
>>> __printf(1, 2)
>>> void bt_info(const char *fmt, ...);
>>> __printf(1, 2)
>>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>>> index e43a90e05972..7a8a199c373d 100644
>>> --- a/net/bluetooth/l2cap_sock.c
>>> +++ b/net/bluetooth/l2cap_sock.c
>>> @@ -619,6 +619,21 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
>>>                      err = -EFAULT;
>>>              break;
>>> 
>>> +     case BT_MODE:
>>> +             if (!enable_ecred) {
>>> +                     err = -ENOPROTOOPT;
>>> +                     break;
>>> +             }
>>> +
>>> +             if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>>> +                     err = -EINVAL;
>>> +                     break;
>>> +             }
>>> +
>>> +             if (put_user(chan->mode, (u8 __user *) optval))
>>> +                     err = -EFAULT;
>>> +             break;
>>> +
>>>      default:
>>>              err = -ENOPROTOOPT;
>>>              break;
>>> @@ -644,6 +659,29 @@ static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
>>>      return true;
>>> }
>>> 
>>> +static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
>>> +{
>>> +     switch (chan->mode) {
>>> +     case L2CAP_MODE_LE_FLOWCTL:
>>> +     case L2CAP_MODE_EXT_FLOWCTL:
>>> +             break;
>>> +     case L2CAP_MODE_BASIC:
>>> +             clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
>>> +             break;
>>> +     case L2CAP_MODE_ERTM:
>>> +     case L2CAP_MODE_STREAMING:
>>> +             if (!disable_ertm)
>>> +                     break;
>>> +             /* fall through */
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     chan->mode = mode;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
>>>                                   char __user *optval, unsigned int optlen)
>>> {
>>> @@ -693,22 +731,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
>>>                      break;
>>>              }
>>> 
>>> -             chan->mode = opts.mode;
>>> -             switch (chan->mode) {
>>> -             case L2CAP_MODE_LE_FLOWCTL:
>>> -                     break;
>>> -             case L2CAP_MODE_BASIC:
>>> -                     clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
>>> -                     break;
>>> -             case L2CAP_MODE_ERTM:
>>> -             case L2CAP_MODE_STREAMING:
>>> -                     if (!disable_ertm)
>>> -                             break;
>>> -                     /* fall through */
>>> -             default:
>>> -                     err = -EINVAL;
>>> +             err = l2cap_set_mode(chan, opts.mode);
>>> +             if (err)
>>>                      break;
>>> -             }
>>> 
>> 
>> I would not yet try to break this out into a separate helper. I think L2CAP_OPTIONS should maybe just stay as it is. And as noted above, we define our own list of constants.
> 
> That would complicate userspace code a little to much since that means
> we would have 2 different namespace for BT_IO_MODE, as mentioned about
> Id keep the same values for modes as in L2CAP_OPTIONS just adding new
> definitions names, otherwise we will need a new option for bt_io to
> avoid the namespaces to overlap but I rather not do that as BT_IO_MODE
> already maps quite well to BT_MODE.

Actually we need to change BT_IO_MODE to be abstract and handle it internally. Most likely BT_IO_MODE should just follow what we do for BT_MODE and internally it should re-map it to L2CAP_OPTIONS if needed.

> 
>>>              BT_DBG("mode 0x%2.2x", chan->mode);
>>> 
>>> @@ -963,6 +988,30 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>>> 
>>>              break;
>>> 
>>> +     case BT_MODE:
>>> +             if (!enable_ecred) {
>>> +                     err = -ENOPROTOOPT;
>>> +                     break;
>>> +             }
>>> +
>>> +             if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>>> +                     err = -EINVAL;
>>> +                     break;
>>> +             }
>> 
>> Especially here I would also check if the mode is valid on the choose transport. For me this would also mean we should require a bind() before allowing to set the mode. So we have at least some idea what transport is planned to be used.
> 
> I will make it check for BOUND state, though l2cap_set_mode does check
> the mode already, or you are saying that if we do use a different
> namespace we would have to convert, well I guess this further
> reinforces my argument that making the values compatible makes things
> a lot simpler.

I care about the new socket options that they are clean and well defined when it comes to error conditions.

Regards

Marcel

