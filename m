Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0D1C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852EA64E17
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 17:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhA1RgH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 12:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhA1Rff (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 12:35:35 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A564C061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jan 2021 09:34:54 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id v23so2228186uam.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jan 2021 09:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HMaNY+QX5HnsLbyC0sbQpdp0PwQub9fmrJ5Fyff+dg=;
        b=Wm53LLSMt3h2v4qJnrD+Emmyh2vUS4pp8Q1GB3Y+FjI43i51ACxP+5ngZgLC28g8uM
         Dlxz9L8bx07S+pNGRCpOYkhTCOMi/afQ/LiUnid60eDxycuO+mF+cJt5ueM6WN1MMwif
         50GstgLjaOJhPP3G6uOOk2R6YGTrXJ3I1Dv/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HMaNY+QX5HnsLbyC0sbQpdp0PwQub9fmrJ5Fyff+dg=;
        b=X8fQ98WkCg+7WOsbhSWC34Gz3v5SVROnSYhcdP57S/d0UgID7v9Jyelsws2k5tTHFH
         bAMRVSZMsj6araDG7pFW2nGsWnARusZF1xVLV28NsTKF8EJ08M6MSSf0TXWSM3jcbwUb
         8yZo20Ug64m7DygrvHkjpopav9RDg8tmu7DZgv83mNydp/PHNLoLnt1mucsTotSxMwrH
         sSGC+0Yf/+3zAt79QSrF3zLfuc1I3cB0SB6qeDEjPgFIHP2ejHNhAM4mMvvGk4zMWXTV
         yfUYeX6p4GOIBgjGS+g7xg7KwAYJyy2gpzPTZeLuzGwhflk05zjLCn6DnUUuF60KiA0b
         sTvQ==
X-Gm-Message-State: AOAM530aZtUSbJT+jiRDSudHVFUoJgN+8KVAQjT20ZZjXUDhYMoBQes6
        rBJnDC+V030iYaQ7LQlIWOekh/FkVb59vq1ZreKcUg==
X-Google-Smtp-Source: ABdhPJz6Yuu7bE5F03eK0G0vsQDwuPloagkscFGTmv3RBIEA65v964q0DEJpjKp5+AE9eEPKk7cUAr60wQi0nb40VqU=
X-Received: by 2002:ab0:1c10:: with SMTP id a16mr303370uaj.100.1611855293224;
 Thu, 28 Jan 2021 09:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20210128163313.426404-1-hdegoede@redhat.com> <20210128163313.426404-2-hdegoede@redhat.com>
In-Reply-To: <20210128163313.426404-2-hdegoede@redhat.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 28 Jan 2021 09:34:41 -0800
Message-ID: <CANFp7mW7rC565QY21+RO0=57Xa4DC8YFUR5fHpiOy+-maZfe-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_h5: Disable the hci_suspend_notifier
 for btrtl devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>, max.chou@realtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Jan 28, 2021 at 8:34 AM Hans de Goede <hdegoede@redhat.com> wrote:
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
> This commit avoids these problems by disabling the hci_suspend_notifier.
>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Use the new HCI_QUIRK_NO_SUSPEND_NOTIFIER quirk, instead of directly
>   unregistering the notifier from hci_h5.c
> ---
>  drivers/bluetooth/hci_h5.c     |  7 +++++++
>  drivers/bluetooth/hci_serdev.c |  3 +++
>  drivers/bluetooth/hci_uart.h   | 13 +++++++------
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 7be16a7f653b..e8f3afab6587 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -914,6 +914,13 @@ static int h5_btrtl_setup(struct h5 *h5)
>
>  static void h5_btrtl_open(struct h5 *h5)
>  {
> +       /*
> +        * Since h5_btrtl_resume() does a device_reprobe() the suspend handling
> +        * done by the hci_suspend_notifier is not necessary; it actually causes
> +        * delays and a bunch of errors to get logged, so disable it.
> +        */
> +       set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->hdev_flags);

I'm not sure we should enable this for all RTL devices rather than
based on the specific project. RTL8822C will also be using hci_h5 but
intends to support wake on bt (meaning it shouldn't be losing firmware
around suspend).

+ Max Chou: You are proposing a change to add project id to btrtl.
Should we use that instead to set this quirk for 8723 devices (and
others which lose fw around suspend)?
(https://patchwork.kernel.org/project/bluetooth/patch/20210127030152.3940-1-max.chou@realtek.com/)

> +
>         /* Devices always start with these fixed parameters */
>         serdev_device_set_flow_control(h5->hu->serdev, false);
>         serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
> index ef96ad06fa54..dbc14b8ac477 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -349,6 +349,9 @@ int hci_uart_register_device(struct hci_uart *hu,
>         if (test_bit(HCI_UART_EXT_CONFIG, &hu->hdev_flags))
>                 set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
>
> +       if (test_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &hu->hdev_flags))
> +               set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
> +
>         if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
>                 hdev->dev_type = HCI_AMP;
>         else
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 4e039d7a16f8..4df2330ac103 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -35,12 +35,13 @@
>  #define HCI_UART_NOKIA 10
>  #define HCI_UART_MRVL  11
>
> -#define HCI_UART_RAW_DEVICE    0
> -#define HCI_UART_RESET_ON_INIT 1
> -#define HCI_UART_CREATE_AMP    2
> -#define HCI_UART_INIT_PENDING  3
> -#define HCI_UART_EXT_CONFIG    4
> -#define HCI_UART_VND_DETECT    5
> +#define HCI_UART_RAW_DEVICE            0
> +#define HCI_UART_RESET_ON_INIT         1
> +#define HCI_UART_CREATE_AMP            2
> +#define HCI_UART_INIT_PENDING          3
> +#define HCI_UART_EXT_CONFIG            4
> +#define HCI_UART_VND_DETECT            5
> +#define HCI_UART_NO_SUSPEND_NOTIFIER   6
>
>  struct hci_uart;
>  struct serdev_device;
> --
> 2.29.2
>
