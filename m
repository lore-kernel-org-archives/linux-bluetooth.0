Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7737EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 20:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FBC6103D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 20:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhJLU0B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:26:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54676 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhJLU0B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 16:26:01 -0400
Received: from smtpclient.apple (p4fefcb73.dip0.t-ipconnect.de [79.239.203.115])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1901FCECE7;
        Tue, 12 Oct 2021 22:23:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC] Bluetooth: vhci: Add support for setting msft_opcode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKWjuMc7chJaFFzqeZZQS15=VvhDC11qZf55NYgOw0G8g@mail.gmail.com>
Date:   Tue, 12 Oct 2021 22:23:57 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <9F215D6E-682D-406B-A83B-6DB394460860@holtmann.org>
References: <20211011211147.2379624-1-luiz.dentz@gmail.com>
 <7288E0DB-FF22-4174-A24B-026EFA8A0E23@holtmann.org>
 <CABBYNZKWjuMc7chJaFFzqeZZQS15=VvhDC11qZf55NYgOw0G8g@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds a debugfs entry to set msft_opcode enabling vhci to emulate
>>> controllers with MSFT extention support.
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> drivers/bluetooth/hci_vhci.c | 32 ++++++++++++++++++++++++++++++++
>>> 1 file changed, 32 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
>>> index 56c6b22be10b..ac122299bacc 100644
>>> --- a/drivers/bluetooth/hci_vhci.c
>>> +++ b/drivers/bluetooth/hci_vhci.c
>>> @@ -194,6 +194,34 @@ static const struct file_operations force_wakeup_fops = {
>>>      .llseek         = default_llseek,
>>> };
>>> 
>>> +
>>> +static int msft_opcode_set(void *data, u64 val)
>>> +{
>>> +     struct vhci_data *vhci = data;
>>> +     uint16_t ogf = (val & 0xffff >> 10);
>>> +
>>> +     if (val > 0xffff || ogf != 0x3f)
>> 
>> I would actually just include it here to avoid any 16-bit overflow.
>> 
>>        if (val > 0xffff || (val & 0xffff >> 10) != 0x3f)
> 
> Ack.
> 
>>> +             return -EINVAL;
>>> +
>>> +     hci_set_msft_opcode(vhci->hdev, val);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int msft_opcode_get(void *data, u64 *val)
>>> +{
>>> +     struct vhci_data *vhci = data;
>>> +
>>> +     hci_dev_lock(vhci->hdev);
>>> +     *val = vhci->hdev->msft_opcode;
>>> +     hci_dev_unlock(vhci->hdev);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +DEFINE_DEBUGFS_ATTRIBUTE(msft_opcode_fops, msft_opcode_get, msft_opcode_set,
>>> +                      "%llu\n");
>>> +
>>> static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
>>> {
>>>      struct hci_dev *hdev;
>>> @@ -259,6 +287,10 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
>>>      debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
>>>                          &force_wakeup_fops);
>>> 
>>> +     if (IS_ENABLED(CONFIG_BT_MSFTEXT))
>>> +             debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
>>> +                                 &msft_opcode_fops);
>>> +
>> 
>> So my concern is that you can modify this value when the device is up and running. That will cause havoc.
>> 
>> Just checking HCI_UP is kinda bad since we just removed that access from the drivers.
> 
> Right but we could add a check to HCI_UP inside hci_set_msft_opcode
> and make it return an error, actually this might be a good idea anyway
> even with existing so we prevent bad usage of hci_set_msft_opcode when
> already up.

I did mean actually HCI_RUNNING, but this still won't work out since you should be able to set the opcode from hdev->setup.

You might be able to craft enough tests around HCI_INIT and HCI_SETUP to make it fail hci_set_msft_opcode. So that might be the safest way after all.

One other option is to actually just store the msft_opcode from debugfs in vhci_data. And then only set it from within hdev->setup. You need to set HCI_QUIRK_NON_PERSISTENT_SETUP for this, but that might actually work best then.

Note: you need an aosp_capable debugfs setting as well.

Regards

Marcel

