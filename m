Return-Path: <SRS0=Gzv7=AE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC85C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D39F20724
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgFWMcZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:32:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51717 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgFWMcZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jun 2020 08:32:25 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id E544ECECC3;
        Tue, 23 Jun 2020 14:42:14 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1] bluetooth: use configured params for ext adv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLJQRCzcrCCVGkeVSDhi8B35dc9z4SAh4dFbgT9DVm4Mg@mail.gmail.com>
Date:   Tue, 23 Jun 2020 14:32:21 +0200
Cc:     Alain Michaud <alainmichaud@google.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <8B47E3EE-682C-4022-8096-2F1FCA59B661@holtmann.org>
References: <20200618210659.142284-1-alainm@chromium.org>
 <C5D30F5E-B50F-4DE7-A909-F48F6C555661@holtmann.org>
 <CALWDO_XLRELJhe1n9AVq2w9fQYkgGLC+bdXQ-1-M4f-cUfEwGQ@mail.gmail.com>
 <CABBYNZLEsUXFW_hrmcvSALRpeZwkmvk=c9SYPt+owO7tn+hMBw@mail.gmail.com>
 <CALWDO_V2Hnc-HHYQQ5LfnW8a2FWzkTBOE1Cti0ZQzyw4CouAgw@mail.gmail.com>
 <9DA76AAC-F625-408C-8C74-DAE3ED42AC45@holtmann.org>
 <CABBYNZLJQRCzcrCCVGkeVSDhi8B35dc9z4SAh4dFbgT9DVm4Mg@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>>>> please use “Bluetooth: “ prefix for the subject.
>>>>> 
>>>>> ack.
>>>>>> 
>>>>>> 
>>>>>>> When the extended advertisement feature is enabled, a hardcoded min and
>>>>>>> max interval of 0x8000 is used.  This patches fixes this issue by using
>>>>>>> the configured min/max value.
>>>>>>> 
>>>>>>> This was validated by setting min/max in main.conf and making sure the
>>>>>>> right setting is applied:
>>>>>>> 
>>>>>>> < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen
>>>>>>> 25                                          #93 [hci0] 10.953011
>>>>>>> …
>>>>>>> Min advertising interval: 181.250 msec (0x0122)
>>>>>>> Max advertising interval: 181.250 msec (0x0122)
>>>>>>> …
>>>>>>> 
>>>>>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>>>>>>> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
>>>>>>> 
>>>>>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
>>>>>> 
>>>>>> The Reviewed-by lines go after your Signed-off-by.
>>>>> 
>>>>> ack.
>>>>>> 
>>>>>> 
>>>>>>> ---
>>>>>>> 
>>>>>>> net/bluetooth/hci_request.c | 10 ++++++----
>>>>>>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>>>>>> 
>>>>>>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>>>>>>> index 29decd7e8051..08818b9bf89f 100644
>>>>>>> --- a/net/bluetooth/hci_request.c
>>>>>>> +++ b/net/bluetooth/hci_request.c
>>>>>>> @@ -1799,8 +1799,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
>>>>>>>     int err;
>>>>>>>     struct adv_info *adv_instance;
>>>>>>>     bool secondary_adv;
>>>>>>> -     /* In ext adv set param interval is 3 octets */
>>>>>>> -     const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
>>>>>>> +     /* In ext adv set param interval is 3 octets in le format */
>>>>>>> +     const __le32 min_adv_interval = cpu_to_le32(hdev->le_adv_min_interval);
>>>>>>> +     const __le32 max_adv_interval = cpu_to_le32(hdev->le_adv_max_interval);
>>>>>> 
>>>>>> Scrap the const here.
>>>>> 
>>>>> I'd like to understand why it isn't prefered to use const when you
>>>>> don't intend to modify it in the code.
>>>>>> 
>>>>>> 
>>>>>> And it is wrong since your hdev->le_adv_{min,max}_interval is actually __u16. So that first needs to be extended to a __u16 value.
>>>>> 
>>>>> The macro actually leads to a function call that has a __u32 as a
>>>>> parameter so the __u16 gets upcasted to a __u32 already.
>>>>>> 
>>>>>> 
>>>>>> That said, if we have this in the Load Default System Configuration list, we should extended it to __le32 there as well.
>>>>> 
>>>>> I agree, this means the range of default system configuration may not
>>>>> be sufficient to accept all possible values that the newer command
>>>>> supports, although I think this is a separate issue from what this
>>>>> patch is trying to solve.
>>>>>> 
>>>>>> 
>>>>>>>     if (instance > 0) {
>>>>>>>             adv_instance = hci_find_adv_instance(hdev, instance);
>>>>>>> @@ -1833,8 +1834,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
>>>>>>> 
>>>>>>>     memset(&cp, 0, sizeof(cp));
>>>>>>> 
>>>>>>> -     memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
>>>>>>> -     memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
>>>>>>> +     /* take least significant 3 bytes */
>>>>>>> +     memcpy(cp.min_interval, &min_adv_interval, sizeof(cp.min_interval));
>>>>>>> +     memcpy(cp.max_interval, &max_adv_interval, sizeof(cp.max_interval));
>>>>>> 
>>>>>> This is dangerous and I think it actually break in case of unaligned access platforms.
>>>>> 
>>>>> Since it is in le format already and the 3 bytes from the cmd struct
>>>>> are raw, I'm not sure how this can be dangerous.  It effectively
>>>>> yields the exact same results as your suggestions below.
>>>> 
>>>> In zephyr we end up doing helper functions for 24 bits:
>>>> 
>>>> https://github.com/zephyrproject-rtos/zephyr/blob/master/include/sys/byteorder.h#L316
>>>> 
>>>> I guess that is safer in terms of alignment access and it would work
>>>> independent of the host order which apparently was not the case in the
>>>> code above since it doesn't do the conversion to le32 (or perhaps the
>>>> intervals are already in le32), anyway having something like that is
>>>> probably much simpler to maintain given that most intervals use for
>>>> things like ISO are also 24 bits long.
>>> I like this. Would you put this in hci.h or keep to a lower scope?
>>> 
>>> static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
>>> {
>>> dst[0] = val & 0xff;
>>> dst[1] = (val & 0xff00) >> 8;
>>> dst[2] = (val & 0xff0000) >> 16;
>>> }
>> 
>> hmmm, how many 24-bit fields do we have in Bluetooth HCI spec? If it is just one, then lets keep it close to the usage, if not, I have also no object to put it in a higher level.
> 
> These are the instances of 24-bit fields:
> 
> include/net/bluetooth/hci.h:    __u8      min_interval[3];
> include/net/bluetooth/hci.h:    __u8      max_interval[3];
> include/net/bluetooth/hci.h:    __u8    m_interval[3];
> include/net/bluetooth/hci.h:    __u8    s_interval[3];
> include/net/bluetooth/hci.h:    __u8  cig_sync_delay[3];
> include/net/bluetooth/hci.h:    __u8  cis_sync_delay[3];
> include/net/bluetooth/hci.h:    __u8  m_latency[3];
> include/net/bluetooth/hci.h:    __u8  s_latency[3];
> 
> I guess they all could benefit from having such a helper so we don't
> have to resort in cpu_to_32 + memcpy.

I see, the new ISO channel support also used 24-bit variables heavily.

Regards

Marcel

