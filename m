Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0008DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Feb 2021 14:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EA664F11
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Feb 2021 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhBYOSy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Feb 2021 09:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbhBYOSw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Feb 2021 09:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614262644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFdJU7noVV4dr1GCkZ9fw1Es5kw0pdDUAE8aXjhFTUI=;
        b=SIMdxtoUJnQ1FrzygfZaFyy9HxhFXBlqoAPpXMZi1d1+ccgOlQxFPrPEvSpbaLFQsC8BeV
        YDvls48ZvpxWbuSe2rNnMDuOgD1F/8CN9bMefYB8zB3h/XjMp/ucdxr16OLPujqG6lb3/b
        9eNxWfJ9u99DDhf/RP36ZJMqi0asnPE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-iixV88y8PhyPMmXhJj8rCw-1; Thu, 25 Feb 2021 09:17:23 -0500
X-MC-Unique: iixV88y8PhyPMmXhJj8rCw-1
Received: by mail-ed1-f70.google.com with SMTP id g20so2753313edy.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Feb 2021 06:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MFdJU7noVV4dr1GCkZ9fw1Es5kw0pdDUAE8aXjhFTUI=;
        b=FvAZvRincgrpnuVuRu/tDcOetQLe6oI7f6lXkFuQQwEPwuC1NBNP/9EqhNGOIkkWzs
         nrlPg8+L2/UagXhkiBZJ7jkLrWf7XkwYUR+lIlPa4ljWRpaxzCNUhCVv/Cw523FEP30h
         ts/aHM9bYDKZcHT0ogakHqiDsDpMJQJo95ljbpE4pdz5Dha3oy/3TI9N9gjrGTKWoj6S
         nmvLbyAQfu0dUMH+1QANhrLbfw822DFjzU5pw0tbgZkVI9RG3hAdPU36mLD5ovombWo5
         SGucLJtgdFwOwGoJH1A/U8xRPZHlM40cRUYeQY0q7hTmDHFDXxZhC3bzpFxxYws7KYuB
         kOeg==
X-Gm-Message-State: AOAM532fZChREzMIodrG54c+ejnZjnezy5YT9lJ9w77T5b+uW6N8fwtK
        KN/Q6mWHe78HZnUXDmxRvaUPpMBbgDu+tXe11tBqBFS8/i4/aMrv8tuAnS8EOEpNRzcBBN0sDUS
        2cGHkkK5GmFqfF3up3On2OiwKq8jrRReT6ctV9dksrMHz1V41m0LRiRgls39ZHMpoGh9jUYbUc9
        /A4nOd
X-Received: by 2002:a17:906:d18e:: with SMTP id c14mr2755632ejz.62.1614262641389;
        Thu, 25 Feb 2021 06:17:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwDRSDi/2eNtUaJSuuuwyxDPWnRONfP1nOcJaJKqdkCpyTrsqDj4LWAXKMFJywsMhB6rYSLA==
X-Received: by 2002:a17:906:d18e:: with SMTP id c14mr2755604ejz.62.1614262641132;
        Thu, 25 Feb 2021 06:17:21 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e19sm3555047eds.10.2021.02.25.06.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 06:17:20 -0800 (PST)
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Hui Wang <hui.wang@canonical.com>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2b08b29c-d6e8-cfcf-8107-792f3a1751b5@redhat.com>
Date:   Thu, 25 Feb 2021 15:17:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d14b2eac-c09d-8ca1-fcb6-a7cc13e84b6a@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 2/25/21 5:37 AM, Hui Wang wrote:
> 
> On 2/19/21 5:24 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 2/19/21 12:41 AM, Luiz Augusto von Dentz wrote:
>>> Hi Hans,
>>>
>>> On Thu, Feb 18, 2021 at 2:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi Marcel,
>>>>
>>>> On 2/18/21 9:01 PM, Marcel Holtmann wrote:
>>>>> Hi Hans,
>>>>>
>>>>>
> Hi Marcel and Hans,
> 
> Looks like this reverting patch is not applied yet, If it is already applied, please ignore the below content.
> 
> My patch really introduces a regression, that makes the autosuspend can't be enabled by btusb.c anymore.
> 
> When the usb core layer calls the usb_driver->probe(), the autosuspend is disabled by pm_runtime_forbid(), if users set btusb.enable_autosuspend=1 or enable the CONFIG_BT_HCIBTUSB_AUTOSUSPEND, the probe() should enable the autosuspend by calling usb_enable_autosuspend() which will call pm_runtime_allow().
> 
> For keeping balance, when executing disconnect(), if probe() enabled the autosuspend, disconect() should disable it by calling usb_disable_autosuspend() which will call pm_runtime_forbid(). This could guarantee the kernel parameter enable_autosuspend works as expected when users repeatedly run "rmmod btusb;modporbe btusb enable_autosuspend=1/0".
> 
> The users could also enable or disable autosuspend by echoing "auto" or "on" to /sys/.../power/control, btusb doesn't know users change the autosuspend from userspace, so btusb only keeps the autosuspend balanced in itself, and userspace should keep balance from userspace, btusb has no capability to detect and control the userspace operation.

There is no balance this is not a (reference)counted thing. It is a straight forward bool,
which is either enabled or disabled. So who or what-ever sets its value last *wins*
there is *no balancing* / *no counting* !

All drivers using this to opt-in to auto-suspend by default call usb_enable_autosuspend()
from their probe function and leave it at that, without making any further calls on remove.

What is necessary here is a straight-forward revert of your commit, as I submitted and
nothing else.

If you can reply with an Acked-by or Reviewed-by to my original revert/patch then
that would be greatly appreciated.

Regards,

Hans


p.s.

Calling usb_disable_autosuspend(data->udev) on driver unbind is a bad idea
because it would break like e.g. this:

1. userspace writes auto to /sys/.../power/control, as is done from
udev rules as we have seen already, or could be done manually
by the user. The device now autosuspends

2. btusb binds, the devices now autosuspends when not in use

3. btusb unbinds and disables autosuspend

4. The device is now constant on despite userspace having requested
that it should be autosuspended.

With just a straight forward revert this problem does not happen.








> According to this idea, the fixing patch is like below:

Again this is WRONG. Please STOP submitting patches for code where
you clearly do not grasp the full implications of the changes which
you are making.





> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 52683fd22e05..a0811e00a5a7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4849,8 +4849,8 @@ static int btusb_probe(struct usb_interface *intf,
>                         data->diag = NULL;
>         }
> 
> -       if (!enable_autosuspend)
> -               usb_disable_autosuspend(data->udev);
> +       if (enable_autosuspend)
> +               usb_enable_autosuspend(data->udev);
> 
>         err = hci_register_dev(hdev);
>         if (err < 0)
> @@ -4888,6 +4888,10 @@ static void btusb_disconnect(struct usb_interface *intf)
> 
>         hci_unregister_dev(hdev);
> 
> +       /* if the autosuspend is enabled in _probe, we disable it here for keeping balance */
> +       if (enable_autosuspend)
> +               usb_disable_autosuspend(data->udev);
> +
>         if (intf == data->intf) {
>                 if (data->isoc)
> usb_driver_release_interface(&btusb_driver, data->isoc);
> @@ -4910,9 +4914,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>                 gpiod_put(data->reset_gpio);
> 
>         hci_free_dev(hdev);
> -
> -       if (!enable_autosuspend)
> -               usb_enable_autosuspend(data->udev);
>  }
> 
> Regards,
> 
> Hui.
> 
>> }
>>
>> static int btusb_close(struct hci_dev *hdev)
>> {
>>     ...
>>     data->intf->needs_remote_wakeup = 0;
>>     ...
>> }
>>
>> Regards,
>>
>> Hans
>>
> 

