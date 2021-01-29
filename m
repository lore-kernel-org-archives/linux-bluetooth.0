Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042ACC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC71864E06
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 17:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhA2RqX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhA2RoL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 12:44:11 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF583C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 09:43:30 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id f22so5261910vsk.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57BUbyn13JrH5xnhkMr0s7HX48MC/gXRX8DIWZyZ5+4=;
        b=QUo3AD8fqVt/QisE9h/en+0h+zZPLhgWx+ERLJGYM0ivNUzJ6BvHr8WSmQDVmRX7xX
         PgxHOrGwrH7Yh56Cjo3cQSB96lNmvdOsl11yErL18daziLd7EEmA9jRL3PXZzwFM2LkP
         CAfOULPfwB3cWDlov1Ic9rWK9Yj/XV+372wHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57BUbyn13JrH5xnhkMr0s7HX48MC/gXRX8DIWZyZ5+4=;
        b=oawVkUBAxuyqJ4hWcXhWPgyGV7+g0ZsOTQVgf0MK8QzFc6xOgumuuqVTnXoqwmURiq
         ZALAF5avkxOiVPdMrF1g17OR4OxqnOSvOM88myv9dqbleq2fvTGHwKUIeV4gO7366OJt
         4yxfgUHxm9MS2FA4TVc5lczBRrOl2MAAlla7HxKBsk8kzuMTwZMvYH+EqLBMi0QwhpmE
         D+sBvm6sPMCNqRrDUBsoAm8ga71loY13VVsNMxX1pSp6TiM7NEY4GW26nqROCWRuq9Yv
         EE5e+hDhJuWg4GNiyvtfBnfFH5dHY77HCXB8ZZW0/xhmbOSLMnohFjUpGRlHmBMej9S8
         xeBw==
X-Gm-Message-State: AOAM533rFjnHOMpvul/wAqkOACJPb2otsgiu75W3aGZBJjVVCvYv2Sst
        pM3XrjFgZ0swrUXWIUNLK2phhwxXC856Mepmo2bjbw==
X-Google-Smtp-Source: ABdhPJzePhzfFrjBoxVrCx9vQop+yEEuvXlamZWYESIpwDsDbCR8+FpOeRpQlRLNcRiifig2L2ZrZ8rzcGlaU2FcpCA=
X-Received: by 2002:a05:6102:20c8:: with SMTP id i8mr3356852vsr.59.1611942210112;
 Fri, 29 Jan 2021 09:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20210128163313.426404-1-hdegoede@redhat.com> <20210128163313.426404-2-hdegoede@redhat.com>
 <CANFp7mW7rC565QY21+RO0=57Xa4DC8YFUR5fHpiOy+-maZfe-Q@mail.gmail.com>
 <08495ef71c9d47199fe2994958f4584c@realtek.com> <0335f343-876e-51f1-52ec-722e7b0f79a6@redhat.com>
In-Reply-To: <0335f343-876e-51f1-52ec-722e7b0f79a6@redhat.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 29 Jan 2021 09:43:18 -0800
Message-ID: <CANFp7mXadQYr=wT_yTXFbNcwg8ivFE1sGDZ3Q9KaqFjrWKw5Jg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_h5: Disable the hci_suspend_notifier
 for btrtl devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Max Chou <max.chou@realtek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Claire Chang <tientzu@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jan 29, 2021 at 6:28 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/29/21 9:25 AM, Max Chou wrote:
> > Hi,
> >
> >> I'm not sure we should enable this for all RTL devices rather than based on the specific project. RTL8822C will also be using hci_h5 but intends to support wake on bt (meaning it shouldn't be losing firmware around suspend).
> >
> >> + Max Chou: You are proposing a change to add project id to btrtl.
> >> Should we use that instead to set this quirk for 8723 devices (and others which lose fw around suspend)?
> >> (https://patchwork.kernel.org/project/bluetooth/patch/20210127030152.3940-1-max.chou@realtek.com/)
> >
> > Agree. Recommend to use the same way as Abhishek mentions that limiting the quirk only for RTL8723B devices if this patch is necessary.
> > Therefore, some of the projects use RTL8822C devices with BT UART interface would apply BT wakes Host.
> > So far, I've not heard the issue as this topic.
>
> So I just checked because I was not aware that the hci_h5 code was also being used for the RTL8822C.
> I mainly focus on x86/ACPI use and there is no 8822 ACPI device-id in the h5_acpi_match table, but
> there is indeed a match for this in the rtl_bluetooth_of_match table.
>
> But ATM the code is treating the 8822 exactly the same as the 8723, including doing a device_reprobe
> on resume. So to me it makes sense to set the HCI_UART_NO_SUSPEND_NOTIFIER unconditionally to, as
> it is used because of the device_reprobe being done.
>
> Now it might be a good idea to opt out of the device_reprobe for 8822 devices, and/or maybe even for
> all devicetree enumerated cases (the device being completely shutoff is an ACPI thing, with dt/of we
> should have more control).
>
> To me it seems that since for now the device_reprobe() is unconditional that the matching setting
> of the HCI_UART_NO_SUSPEND_NOTIFIER flag should be unconditional too; and then when the device_reprobe()
> stuff is made unconditional, then we can make the setting of the flag unconditional using the same check.

I didn't realize this was currently unconditional in code. In that
case, I think it's fine for you to add the flag unconditionally in
hci_h5. When we add support for wake on bt to the h5 driver, we should
make this flag conditional based on whether the driver reprobes on
resume.

I will go back and +1 the original patch.

Thanks,
Abhishek

>
> With that said if people really want it I'm happy to respin this to only apply to the 8723 case,
> but that seems weird given that the device_reprobe ATM is being done on the 8822 too.
>
> > +Clair: Have you met this issue during suspend/resume when BT controller is RTL8822C with BT UART interface?
> > Please see the patchwork. https://patchwork.kernel.org/project/bluetooth/list/?series=423915
>
> Regards,
>
> Hans
>
