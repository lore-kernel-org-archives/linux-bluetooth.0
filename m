Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD522C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DF525448
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 07:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgFVHOI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:14:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57530 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgFVHOI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 03:14:08 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8E349CED25;
        Mon, 22 Jun 2020 09:23:58 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1] bluetooth: use configured params for ext adv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_XLRELJhe1n9AVq2w9fQYkgGLC+bdXQ-1-M4f-cUfEwGQ@mail.gmail.com>
Date:   Mon, 22 Jun 2020 09:14:05 +0200
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <7EE6323C-B4C7-471F-A831-F33995E6B662@holtmann.org>
References: <20200618210659.142284-1-alainm@chromium.org>
 <C5D30F5E-B50F-4DE7-A909-F48F6C555661@holtmann.org>
 <CALWDO_XLRELJhe1n9AVq2w9fQYkgGLC+bdXQ-1-M4f-cUfEwGQ@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>>> index 29decd7e8051..08818b9bf89f 100644
>>> --- a/net/bluetooth/hci_request.c
>>> +++ b/net/bluetooth/hci_request.c
>>> @@ -1799,8 +1799,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
>>>      int err;
>>>      struct adv_info *adv_instance;
>>>      bool secondary_adv;
>>> -     /* In ext adv set param interval is 3 octets */
>>> -     const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
>>> +     /* In ext adv set param interval is 3 octets in le format */
>>> +     const __le32 min_adv_interval = cpu_to_le32(hdev->le_adv_min_interval);
>>> +     const __le32 max_adv_interval = cpu_to_le32(hdev->le_adv_max_interval);
>> 
>> Scrap the const here.
> 
> I'd like to understand why it isn't prefered to use const when you
> don't intend to modify it in the code.

does the const make a difference for integer values? For me this the difference between adding value and extra noise.

>> 
>> 
>> And it is wrong since your hdev->le_adv_{min,max}_interval is actually __u16. So that first needs to be extended to a __u16 value.
> 
> The macro actually leads to a function call that has a __u32 as a
> parameter so the __u16 gets upcasted to a __u32 already.

That is true, but lets be clean and use a proper storage size in the first place. Eventually we want to use the larger intervals at some point. And then you end up hunting that root cause for a complete day ;)

>> 
>> 
>> That said, if we have this in the Load Default System Configuration list, we should extended it to __le32 there as well.
> 
> I agree, this means the range of default system configuration may not
> be sufficient to accept all possible values that the newer command
> supports, although I think this is a separate issue from what this
> patch is trying to solve.

Separate issue and separate patch, but needs to be addressed.

>> 
>> 
>>>      if (instance > 0) {
>>>              adv_instance = hci_find_adv_instance(hdev, instance);
>>> @@ -1833,8 +1834,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
>>> 
>>>      memset(&cp, 0, sizeof(cp));
>>> 
>>> -     memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
>>> -     memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
>>> +     /* take least significant 3 bytes */
>>> +     memcpy(cp.min_interval, &min_adv_interval, sizeof(cp.min_interval));
>>> +     memcpy(cp.max_interval, &max_adv_interval, sizeof(cp.max_interval));
>> 
>> This is dangerous and I think it actually break in case of unaligned access platforms.
> 
> Since it is in le format already and the 3 bytes from the cmd struct
> are raw, I'm not sure how this can be dangerous.  It effectively
> yields the exact same results as your suggestions below.

It is only fine on architectures that do the unaligned access correctly. In case they don’t this will result in a funny value.

Regards

Marcel

