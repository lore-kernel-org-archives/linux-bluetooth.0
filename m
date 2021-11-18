Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF481613A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 17:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhKRRU6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 12:20:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38259 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhKRRU6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 12:20:58 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 94A28CED10;
        Thu, 18 Nov 2021 18:17:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for queuing during polling
 interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKZy0BqctmeD7Mn1fU47MtRcQuMWk9ej3m-n6gUmg54Pw@mail.gmail.com>
Date:   Thu, 18 Nov 2021 18:17:55 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0153AC76-BFF7-4AEE-9C44-CF269101C15C@holtmann.org>
References: <20211108230210.931731-1-luiz.dentz@gmail.com>
 <949D7592-D56E-486D-BD59-F10D346C92DD@holtmann.org>
 <CABBYNZKZy0BqctmeD7Mn1fU47MtRcQuMWk9ej3m-n6gUmg54Pw@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This makes btusb to queue ACL and events during a polling interval
>>> by using of a delayed work, with the interval working as a time window
>>> where frames received from different endpoints are considered to be
>>> arrived at same time and then attempt to resolve potential conflics by
>>> processing the events ahead of ACL packets.
>>> 
>>> It worth noting though that priorizing events over ACL data may result
>>> in inverting the order compared to how they appeared over the air, for
>>> instance there may be packets received before a disconnect event that
>>> will be discarded and unencrypted packets received before encryption
>>> change which would considered encrypted, because of these potential
>>> changes on the order the support for queuing during the polling
>>> interval is not enabled by default so platforms have the following
>>> means to enable it:
>>> 
>>> At runtime with use of module option:
>>> 
>>>   enable_poll_sync
>> 
>> is this still needed?
> 
> Yes, it is not enabled by default but I can change that or perhaps we
> shall use a quirk instead so models that don't have a workaround in
> the firmware shall mark that quirk?
> 
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 89 +++++++++++++++++++++++++++++++++------
>>> 1 file changed, 77 insertions(+), 12 deletions(-)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 46d892bbde62..29aa0f346ace 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -31,7 +31,7 @@
>>> static bool disable_scofix;
>>> static bool force_scofix;
>>> static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
>>> -
>>> +static bool enable_poll_sync;
>>> static bool reset = true;
>>> 
>>> static struct usb_driver btusb_driver;
>>> @@ -550,8 +550,12 @@ struct btusb_data {
>>> 
>>>      unsigned long flags;
>>> 
>>> -     struct work_struct work;
>>> -     struct work_struct waker;
>>> +     int intr_interval;
>>> +     struct work_struct  work;
>>> +     struct work_struct  waker;
>>> +     struct delayed_work rx_work;
>>> +
>>> +     struct sk_buff_head acl_q;
>>> 
>>>      struct usb_anchor deferred;
>>>      struct usb_anchor tx_anchor;
>>> @@ -588,8 +592,8 @@ struct btusb_data {
>>>      int isoc_altsetting;
>>>      int suspend_count;
>>> 
>>> -     int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
>>>      int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
>>> +     int (*recv_event)(struct btusb_data *data, struct sk_buff *skb);
>> 
>> This change is a bit unfortunate since I really wanted to allow recv_event = hci_recv_frame assignment.
> 
> I can probably change it back and then use hci_get_drvdata if it needs queuing.
> 
>>>      int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
>>> 
>>>      int (*setup_on_usb)(struct hci_dev *hdev);
>>> @@ -761,7 +765,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>>> 
>>>              if (!hci_skb_expect(skb)) {
>>>                      /* Complete frame */
>>> -                     data->recv_event(data->hdev, skb);
>>> +                     data->recv_event(data, skb);
>>>                      skb = NULL;
>>>              }
>>>      }
>>> @@ -772,6 +776,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>>>      return err;
>>> }
>>> 
>>> +static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
>>> +{
>>> +     if (!enable_poll_sync)
>>> +             return data->recv_acl(data->hdev, skb);
>>> +
>>> +     skb_queue_tail(&data->acl_q, skb);
>>> +
>>> +     schedule_delayed_work(&data->rx_work, data->intr_interval);
>>> +
>>> +     return 0;
>>> +}
>>> +
>> 
>> Starting to think about this, I really have a problem with these massive if-one-or-another checks in the main receive path. The idea was really that only hardware that needs special handling assigns different callbacks.
>> 
>> This means if we really want to support this, then we need to have independent recv_acl and recv_event callbacks depending on sync_poll behavior is enabled or not.
> 
> Yep, I can change that to use dedicated sync_poll callbacks variants.
> 
>> We also need to bind switching the behavior to controllers that are powered down. Otherwise this really becomes a mess. Checking a module parameter variable on every receiving packet is not a good idea.
> 
> Not sure what do you mean by bind switching, the module's parameters
> cannot be changed while the module is loaded, right? So it shouldn't
> really change during the lifetime of an hci_dev if that is your
> concern, but yes I got the idea that we shouldn't need to check it on
> every packet so using dedicated callbacks makes sense.

you can change the module parameter at runtime. See the mode in module_param(enable_poll_sync, bool, 0644);.

Regards

Marcel

