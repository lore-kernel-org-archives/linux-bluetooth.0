Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29144C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 00:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D647C64DBD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 00:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhA0X75 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhA0X7w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 18:59:52 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9629C061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 15:59:11 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id d3so1393140uap.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 15:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElWAJmRHY2PpMUtGYuWnaZ8HYZ1gnwntzArA14PMapA=;
        b=S1BHzdmQJLmZ2x5YirzvtuX+Ytb2ITcPYA4w2RyFj8fw/HYCTIwSkxQq57MzmobshS
         T9lWSSdZwdNhQ2JI+WwuXZJS7m6eggt11e1gZJFvCuiVuylhw8gWNOtKrWdwi7hHn4yt
         RI6rcWOxmhygzLk2+rIhogLcKhfsd5sRhadt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElWAJmRHY2PpMUtGYuWnaZ8HYZ1gnwntzArA14PMapA=;
        b=Ul8CGH/ofPHduzIh0i5bY9fy7b2oELz9H2b+LfFf9yfGOTt5kaqt+Rjk7shROc7mEw
         4McY4AnWvyoA4/beQSCePiL4L/SPi/Mp42IUEqmS/gMJfMlt+rcefi3uA+wxMI2LKq3w
         38lw2Hu3Ht5QiR8aAgttb7uS8BsNynk2PGBSkIgJxwRjkBfpdxL8jiDic4GKDQSa2LQ4
         zRMDGLOXZaThX4dXIBy3bAEdGljR3OriheucAsbOyjMrZqWrQEuA2d75STIP0Kz8N+Gu
         KoiqPSE/optfDKzqdkE683/8VzmoHY1gyR/VJz0DtmKXB7AYzy6tcKd0KVgtO5iyNGS4
         GfkQ==
X-Gm-Message-State: AOAM530XaLbUTA8N1wztqDqsAdy3hc8E77aRITq+cUMvTuzkhUT83gUO
        i2RMkIuEwz4fmIzHPIvNOCKF6OyNSISIfzEnNo9CJw==
X-Google-Smtp-Source: ABdhPJyxqEGevEZCX5kv6NkP68zFj2ljc1zkHugAuk4MnNARYflp0560WzC9ymn9J3DNRF/gvvtaY5YTZbZFUtIQK3A=
X-Received: by 2002:ab0:659a:: with SMTP id v26mr10085142uam.136.1611791950852;
 Wed, 27 Jan 2021 15:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20210127215834.9367-1-hdegoede@redhat.com>
In-Reply-To: <20210127215834.9367-1-hdegoede@redhat.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 27 Jan 2021 15:58:58 -0800
Message-ID: <CANFp7mUK27wSXnBKEyrTTRPCDtSxawYEDVCbqOuJhRKnCFFm9w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: Disable the hci_suspend_notifier for
 btrtl devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

You can also implement hdev->prevent_wake to prevent configure wake
from running. hci_unregister_dev will also clear any tasks during
resume, unregister the pm notifier and cancel the suspend work so if
reprobe takes <2s (default suspend work timeout), you shouldn't see a
delay or any errors.

I'm not 100% confident that the reprobe worker and the pm notifier
won't race so I'm ok with this change as well. I would prefer if the
driver only set a quirk and the actual register/unregister was handled
entirely inside hci_core though.

Thanks,
Abhishek

On Wed, Jan 27, 2021 at 1:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The hci_suspend_notifier which was introduced last year, is causing
> problems for uart attached btrtl devices. These devices may loose their
> firmware and their baudrate setting over a suspend/resume.
>
> Since we don't even know the baudrate after a suspend/resume recovering
> from this is tricky. The driver solves this by treating these devices
> the same as USB BT HCIs which drop of the bus during suspend.
>
> Specifically the driver:
> 1. Simply unconditionally turns the device fully off during
>    system-suspend to save maximum power.
> 2. Calls device_reprobe() from a workqueue to fully re-init the device
>    from scratch on system-resume (unregistering the old HCI and
>    registering a new HCI).
>
> This means that these devices do not benefit from the suspend / resume
> handling work done by the hci_suspend_notifier. At best this unnecessarily
> adds some time to the suspend/resume time.
>
> But in practice this is actually causing problems:
>
> 1. These btrtl devices seem to not like the HCI_OP_WRITE_SCAN_ENABLE(
> SCAN_DISABLED) request being send to them when entering the
> BT_SUSPEND_CONFIGURE_WAKE state. The same request send on
> BT_SUSPEND_DISCONNECT works fine, but the second one send (unnecessarily?)
> from the BT_SUSPEND_CONFIGURE_WAKE transition causes the device to hang:
>
> [  573.497754] PM: suspend entry (s2idle)
> [  573.554615] Filesystems sync: 0.056 seconds
> [  575.837753] Bluetooth: hci0: Timed out waiting for suspend events
> [  575.837801] Bluetooth: hci0: Suspend timeout bit: 4
> [  575.837925] Bluetooth: hci0: Suspend notifier action (3) failed: -110
>
> 2. The PM_POST_SUSPEND / BT_RUNNING transition races with the
> driver-unbinding done by the device_reprobe() work.
> If the hci_suspend_notifier wins the race it is talking to a dead
> device leading to the following errors being logged:
>
> [  598.686060] Bluetooth: hci0: Timed out waiting for suspend events
> [  598.686124] Bluetooth: hci0: Suspend timeout bit: 5
> [  598.686237] Bluetooth: hci0: Suspend notifier action (4) failed: -110
>
> In both cases things still work, but the suspend-notifier is causing
> these ugly errors getting logged and ut increase both the suspend- and
> the resume-time by 2 seconds.
>
> This commit works around these problems by disabling (unregistering)
> the hci_suspend_notifier.
>
> Note that any eventual hci_unregister_dev() will call
> unregister_pm_notifier() a second time, this is fine it will
> simply fail with -ENOENT and hci_unregister_dev() ignores the
> return value.
>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/bluetooth/hci_h5.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 7be16a7f653b..acbcc676d6c2 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_device.h>
>  #include <linux/serdev.h>
>  #include <linux/skbuff.h>
> +#include <linux/suspend.h>
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -876,6 +877,13 @@ static int h5_btrtl_setup(struct h5 *h5)
>         bool flow_control;
>         int err;
>
> +       /*
> +        * Since h5_btrtl_resume() does a device_reprobe() the suspend handling
> +        * done by the hci_suspend_notifier is not necessary; it actually causes
> +        * delays and a bunch of errors to get logged, so disable it.
> +        */
> +       unregister_pm_notifier(&h5->hu->hdev->suspend_notifier);
> +
>         btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
>         if (IS_ERR(btrtl_dev))
>                 return PTR_ERR(btrtl_dev);
> --
> 2.29.2
>
