Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF83AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 01:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8747964EC3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 01:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhBZBE0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:04:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55759 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBZBEJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Feb 2021 20:04:09 -0500
Received: from [123.112.65.122] (helo=[192.168.0.106])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1lFRXP-0000aY-E5; Fri, 26 Feb 2021 01:03:23 +0000
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Hans de Goede <hdegoede@redhat.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20210218123728.17067-1-hdegoede@redhat.com>
 <20210218123728.17067-2-hdegoede@redhat.com>
 <90d8996d-a376-2e9c-37ce-ce50b8660fd1@canonical.com>
 <4510935f-a30b-445d-a048-683619f2855b@redhat.com>
 <6CE927B6-449A-472C-9196-AF98895AA5E1@holtmann.org>
 <2bf12891-eeae-e55f-ab46-7434dffbad76@redhat.com>
 <CABBYNZ+euV5rwx=LeLKOGSL0AwnPfE7paEHhNhMiUpXGYixgBw@mail.gmail.com>
 <2fc373c2-0255-63b6-3e4a-9aa83f6986e1@redhat.com>
 <d14b2eac-c09d-8ca1-fcb6-a7cc13e84b6a@canonical.com>
 <2b08b29c-d6e8-cfcf-8107-792f3a1751b5@redhat.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <c0b17797-cfea-ea35-88d0-0f70dd0c4868@canonical.com>
Date:   Fri, 26 Feb 2021 09:03:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2b08b29c-d6e8-cfcf-8107-792f3a1751b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 2/25/21 10:17 PM, Hans de Goede wrote:
> Hi,
>
> On 2/25/21 5:37 AM, Hui Wang wrote:
>> On 2/19/21 5:24 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 2/19/21 12:41 AM, Luiz Augusto von Dentz wrote:
>>>
[...]
> There is no balance this is not a (reference)counted thing. It is a straight forward bool,
> which is either enabled or disabled. So who or what-ever sets its value last *wins*
> there is *no balancing* / *no counting* !
>
> All drivers using this to opt-in to auto-suspend by default call usb_enable_autosuspend()
> from their probe function and leave it at that, without making any further calls on remove.
>
> What is necessary here is a straight-forward revert of your commit, as I submitted and
> nothing else.
>
> If you can reply with an Acked-by or Reviewed-by to my original revert/patch then
> that would be greatly appreciated.
OK, got it.
>
> Regards,
>
> Hans
>
>
> p.s.
>
> Calling usb_disable_autosuspend(data->udev) on driver unbind is a bad idea
> because it would break like e.g. this:
>
> 1. userspace writes auto to /sys/.../power/control, as is done from
> udev rules as we have seen already, or could be done manually
> by the user. The device now autosuspends
>
> 2. btusb binds, the devices now autosuspends when not in use
>
> 3. btusb unbinds and disables autosuspend
>
> 4. The device is now constant on despite userspace having requested
> that it should be autosuspended.
>
> With just a straight forward revert this problem does not happen.
>
>
>
What I thought is there are many many devices which are not controlled 
by userspace.
>
>
>
>
>> According to this idea, the fixing patch is like below:
> Again this is WRONG. Please STOP submitting patches for code where
> you clearly do not grasp the full implications of the changes which
> you are making.
>
OK, got it.


Thanks,

Hui.


>
>
>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 52683fd22e05..a0811e00a5a7 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -4849,8 +4849,8 @@ static int btusb_probe(struct usb_interface *intf,
>>                          data->diag = NULL;
>>          }
>>
>> -       if (!enable_autosuspend)
>> -               usb_disable_autosuspend(data->udev);
>> +       if (enable_autosuspend)
>> +               usb_enable_autosuspend(data->udev);
>>
>>          err = hci_register_dev(hdev);
>>          if (err < 0)
>> @@ -4888,6 +4888,10 @@ static void btusb_disconnect(struct usb_interface *intf)
>>
>>          hci_unregister_dev(hdev);
>>
>> +       /* if the autosuspend is enabled in _probe, we disable it here for keeping balance */
>> +       if (enable_autosuspend)
>> +               usb_disable_autosuspend(data->udev);
>> +
>>          if (intf == data->intf) {
>>                  if (data->isoc)
>> usb_driver_release_interface(&btusb_driver, data->isoc);
>> @@ -4910,9 +4914,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>>                  gpiod_put(data->reset_gpio);
>>
>>          hci_free_dev(hdev);
>> -
>> -       if (!enable_autosuspend)
>> -               usb_enable_autosuspend(data->udev);
>>   }
>>
>> Regards,
>>
>> Hui.
>>
>>> }
>>>
>>> static int btusb_close(struct hci_dev *hdev)
>>> {
>>>      ...
>>>      data->intf->needs_remote_wakeup = 0;
>>>      ...
>>> }
>>>
>>> Regards,
>>>
>>> Hans
>>>
