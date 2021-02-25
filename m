Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5D2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Feb 2021 04:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8911964ED6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Feb 2021 04:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhBYEiI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Feb 2021 23:38:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50520 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhBYEiG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Feb 2021 23:38:06 -0500
Received: from [123.112.65.122] (helo=[192.168.0.106])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1lF8Ov-0006AJ-Df; Thu, 25 Feb 2021 04:37:21 +0000
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
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <d14b2eac-c09d-8ca1-fcb6-a7cc13e84b6a@canonical.com>
Date:   Thu, 25 Feb 2021 12:37:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2fc373c2-0255-63b6-3e4a-9aa83f6986e1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 2/19/21 5:24 PM, Hans de Goede wrote:
> Hi,
>
> On 2/19/21 12:41 AM, Luiz Augusto von Dentz wrote:
>> Hi Hans,
>>
>> On Thu, Feb 18, 2021 at 2:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi Marcel,
>>>
>>> On 2/18/21 9:01 PM, Marcel Holtmann wrote:
>>>> Hi Hans,
>>>>
>>>>
Hi Marcel and Hans,

Looks like this reverting patch is not applied yet, If it is already 
applied, please ignore the below content.

My patch really introduces a regression, that makes the autosuspend 
can't be enabled by btusb.c anymore.

When the usb core layer calls the usb_driver->probe(), the autosuspend 
is disabled by pm_runtime_forbid(), if users set 
btusb.enable_autosuspend=1 or enable the CONFIG_BT_HCIBTUSB_AUTOSUSPEND, 
the probe() should enable the autosuspend by calling 
usb_enable_autosuspend() which will call pm_runtime_allow().

For keeping balance, when executing disconnect(), if probe() enabled the 
autosuspend, disconect() should disable it by calling 
usb_disable_autosuspend() which will call pm_runtime_forbid(). This 
could guarantee the kernel parameter enable_autosuspend works as 
expected when users repeatedly run "rmmod btusb;modporbe btusb 
enable_autosuspend=1/0".

The users could also enable or disable autosuspend by echoing "auto" or 
"on" to /sys/.../power/control, btusb doesn't know users change the 
autosuspend from userspace, so btusb only keeps the autosuspend balanced 
in itself, and userspace should keep balance from userspace, btusb has 
no capability to detect and control the userspace operation.

According to this idea, the fixing patch is like below:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 52683fd22e05..a0811e00a5a7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4849,8 +4849,8 @@ static int btusb_probe(struct usb_interface *intf,
                         data->diag = NULL;
         }

-       if (!enable_autosuspend)
-               usb_disable_autosuspend(data->udev);
+       if (enable_autosuspend)
+               usb_enable_autosuspend(data->udev);

         err = hci_register_dev(hdev);
         if (err < 0)
@@ -4888,6 +4888,10 @@ static void btusb_disconnect(struct usb_interface 
*intf)

         hci_unregister_dev(hdev);

+       /* if the autosuspend is enabled in _probe, we disable it here 
for keeping balance */
+       if (enable_autosuspend)
+               usb_disable_autosuspend(data->udev);
+
         if (intf == data->intf) {
                 if (data->isoc)
usb_driver_release_interface(&btusb_driver, data->isoc);
@@ -4910,9 +4914,6 @@ static void btusb_disconnect(struct usb_interface 
*intf)
                 gpiod_put(data->reset_gpio);

         hci_free_dev(hdev);
-
-       if (!enable_autosuspend)
-               usb_enable_autosuspend(data->udev);
  }

Regards,

Hui.

> }
>
> static int btusb_close(struct hci_dev *hdev)
> {
> 	...
> 	data->intf->needs_remote_wakeup = 0;
> 	...
> }
>
> Regards,
>
> Hans
>
