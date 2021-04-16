Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C873C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 05:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F536100C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 05:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhDPFXy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 01:23:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33629 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPFXx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 01:23:53 -0400
Received: from marcel-macbook.holtmann.net (p4ff9f74c.dip0.t-ipconnect.de [79.249.247.76])
        by mail.holtmann.org (Postfix) with ESMTPSA id 82FADCED15;
        Fri, 16 Apr 2021 07:31:11 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [BlueZ] monitor: Fix the incorrect vendor name
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJQfnxFirWC+ned2sCrJb7nAiBqjCkO6guMNZU_5NCqkAdKzpg@mail.gmail.com>
Date:   Fri, 16 Apr 2021 07:23:25 +0200
Cc:     "An, Tedd" <tedd.an@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <852D4FDC-5A9E-45B0-83AD-95DB203022B0@holtmann.org>
References: <tedd.an@intel.com> <20210414043857.371176-1-hj.tedd.an@gmail.com>
 <6D9FBA0A-3058-4C96-8CFD-6BE5B585DE8E@holtmann.org>
 <34494443-5CE2-40F1-95DF-EF05914BD741@intel.com>
 <CAJQfnxFirWC+ned2sCrJb7nAiBqjCkO6guMNZU_5NCqkAdKzpg@mail.gmail.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

>>> This patch fixes the vendor name is alwasy shown as "Microsoft" even
>>> though a different vendor.
>>> 
>>> < HCI Command: Microsoft Secure Send (0x3f|0x0009) plen 249
>>>       Type: Data fragment (0x01)
>>>> HCI Event: Command Complete (0x0e) plen 4
>>>     Microsoft Secure Send (0x3f|0x0009) ncmd 31
>>>       Status: Success (0x00)
>>> ---
>>> monitor/packet.c | 12 +++---------
>>> 1 file changed, 3 insertions(+), 9 deletions(-)
>>> 
>>> diff --git a/monitor/packet.c b/monitor/packet.c
>>> index d729a01cc..91d2294ff 100644
>>> --- a/monitor/packet.c
>>> +++ b/monitor/packet.c
>>> @@ -9325,18 +9325,12 @@ static const char *get_supported_command(int bit)
>>> 
>>> static const char *current_vendor_str(void)
>>> {
>>> - uint16_t manufacturer, msft_opcode;
>>> + uint16_t manufacturer;
>>> 
>>> - if (index_current < MAX_INDEX) {
>>> + if (index_current < MAX_INDEX)
>>>          manufacturer = index_list[index_current].manufacturer;
>>> -         msft_opcode = index_list[index_current].msft_opcode;
>>> - } else {
>>> + else
>>>          manufacturer = fallback_manufacturer;
>>> -         msft_opcode = BT_HCI_CMD_NOP;
>>> - }
>>> -
>>> - if (msft_opcode != BT_HCI_CMD_NOP)
>>> -         return "Microsoft";
>> 
>>    seems we have a bug here, but the fix can not be correct either. If we are running on Intel firmware and the Microsoft extension is used, it should show Microsoft and not Intel for the vendor commands.
>> 
>> I submitted v2 and I think I took care of the msft_opcode handling but I realized that the msft_event_opcode is also like msft_opcode - each vendor will have a different value.
>> I know the msft_event_code for Intel, which is 0x50, but don't know for Realtek. (Do you happen to know?)
> 
> On my Realtek device the msft_event_code is 8 bytes long: 0x23 0x79
> 0x54 0x33 0x77 0x88 0x97 0x68.


I remember having seen different event prefixes for Realtek controllers. However after re-testing it seems to be the same.

My latest 5.1 dongle has this:

> HCI Event: Command Complete (0x0e) plen 22
      Microsoft Extension (0x3f|0x00f0) ncmd 2
      Read Supported Features (0x00)
        Status: Success (0x00)
        Features: 0x3f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          RSSI Monitoring feature for BR/EDR
          RSSI Monitoring feature for LE connections
          RSSI Monitoring of LE advertisements
          Advertising Monitoring of LE advertisements
          Verifying the validity of P-192 and P-256 keys
          Continuous Advertising Monitoring
        Event prefix length: 8
        23 79 54 33 77 88 97 68 

And my older 4.2 dongle has this:

> HCI Event: Command Complete (0x0e) plen 22
      Microsoft Extension (0x3f|0x00f0) ncmd 2
      Read Supported Features (0x00)
        Status: Success (0x00)
        Features: 0x0f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          RSSI Monitoring feature for BR/EDR
          RSSI Monitoring feature for LE connections
          RSSI Monitoring of LE advertisements
          Advertising Monitoring of LE advertisements
        Event prefix length: 8
        23 79 54 33 77 88 97 68

Regards

Marcel

