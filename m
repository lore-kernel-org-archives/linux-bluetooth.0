Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3CBC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 09:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0AF23104
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 09:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbhAZJTx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 04:19:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50682 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbhAZJRZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 04:17:25 -0500
Received: from marcel-macpro.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3C4C2CECE2;
        Tue, 26 Jan 2021 10:24:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [RESEND 1/2] Bluetooth: btusb: Add support for queuing during
 polling interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLu7nqgp8x6AWYfQOCXG4_Z6Da8PF=v=XAK9mj7Vg5FjQ@mail.gmail.com>
Date:   Tue, 26 Jan 2021 10:16:34 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <341754CA-5C47-4FA7-BC34-210229FBC5CB@holtmann.org>
References: <20210113232858.1181251-1-luiz.dentz@gmail.com>
 <52613EEA-D992-4BDB-BA8A-E91DC4125F70@holtmann.org>
 <CABBYNZLu7nqgp8x6AWYfQOCXG4_Z6Da8PF=v=XAK9mj7Vg5FjQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
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
>>> At build-time:
>>> 
>>>   CONFIG_BT_HCIBTUSB_INTERVAL=y
>>> 
>>> At runtime with use of module option:
>>> 
>>>   enable_interval
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> drivers/bluetooth/Kconfig |  7 ++++
>>> drivers/bluetooth/btusb.c | 88 ++++++++++++++++++++++++++++++++++-----
>>> 2 files changed, 84 insertions(+), 11 deletions(-)
>>> 
>>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>>> index 4e73a531b377..2f20a853d946 100644
>>> --- a/drivers/bluetooth/Kconfig
>>> +++ b/drivers/bluetooth/Kconfig
>>> @@ -41,6 +41,13 @@ config BT_HCIBTUSB_AUTOSUSPEND
>>>        This can be overridden by passing btusb.enable_autosuspend=[y|n]
>>>        on the kernel commandline.
>>> 
>>> +config BT_HCIBTUSB_INTERVAL
>>> +     bool "Enable notification of USB polling interval"
>>> +     depends on BT_HCIBTUSB
>>> +     help
>>> +       Say Y here to enable notification of USB polling interval for
>>> +       Bluetooth USB devices by default.
>>> +
>>> config BT_HCIBTUSB_BCM
>>>      bool "Broadcom protocol support"
>>>      depends on BT_HCIBTUSB
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index b14102fba601..38cb5448fc69 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -30,7 +30,7 @@
>>> static bool disable_scofix;
>>> static bool force_scofix;
>>> static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
>>> -
>>> +static bool enable_interval = IS_ENABLED(CONFIG_BT_HCIBTUSB_INTERVAL);
>>> static bool reset = true;
>>> 
>>> static struct usb_driver btusb_driver;
>>> @@ -519,8 +519,12 @@ struct btusb_data {
>>> 
>>>      unsigned long flags;
>>> 
>>> -     struct work_struct work;
>>> -     struct work_struct waker;
>>> +     struct work_struct  work;
>>> +     struct work_struct  waker;
>>> +     struct delayed_work rx_work;
>>> +
>>> +     struct sk_buff_head acl_q;
>>> +     struct sk_buff_head evt_q;
>> 
>> so does it make sense to keep them separate if we delay processing anyway.
> 
> 
> We need them to reorder in case they are received at the same time
> (within the same polling interval), we could reorder in place but then
> will need to iterate into the queue to find where to insert events,
> using 2 queues is a lot simpler to understand and probably perform
> better.

do we actually have to queue the HCI event as well. Or just make sure that the bulk endpoints are processed at the same interval as the interrupt endpoint?

Regards

Marcel

