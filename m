Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD46DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 20:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9503E6103D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 20:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhJLUgh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJLUgg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 16:36:36 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF7C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 13:34:34 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id m199so272453vka.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7LrTBLh42sX3zt76SRMqTop+IPVwQ3cxF76xw3y2vWc=;
        b=Iw88lQYYhsIwWPN0EhfSzo9R3FJpcjYIulEaDdH8Qw/8gqFkGDiyWIiP8DVp6S69pH
         4U1pqRV8EUxlrflQvu3vatcOoDngslkU4uG2BZwOlc9Kykatujn37veQjK3WvLzN6swU
         gntN5zrgLUXaXFkjFGc/oexWULQFHKfQRxqwpb8Qu6G/eJiNtS7HSjTc/gpPX4+5h8by
         X6qoCm8+rjksDjC7lRHvDFgJjUI05cOsjfDMpajvwO/s/rVnMF/WodLPhm1sn7aLm4H3
         BLwV4j6XeJAuMff8/BUJY3TGA9zISrakc36rHauWTOf7bP2xO/XlM2osfa+hD6u9aK9f
         w5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7LrTBLh42sX3zt76SRMqTop+IPVwQ3cxF76xw3y2vWc=;
        b=GGfxU6+obAHTtqP/GJlIGmjgqaQWsNcrnITJT8WQVQQmyDSK1MtBdz8L4AJ//YelOU
         hLaDPo9X+d7tV/GUbD+ABVyvLVF2vScVudKp+1szR17yUEdhUPUpJLg+17ubbSN0cNVc
         nArx8g41xOBJ64coKscYIJkE663frgg80JV1U4e/usR/2PyL9BatiMWwKrcUQESIDCbN
         rVxnunp5V+0H55PyfukYhYv9p612ckFIrUK7ZxjbhYgntKzTytHb3fcsmJboTj2dHglV
         C8Rwezcq9miGDiulJVKwDhetDYYT9eVvPnnB6hu58NF8Cwrvi7XjbBnj8ERW2ecxepsv
         BWoA==
X-Gm-Message-State: AOAM532W98TrfprfxZlLWddwIHUXkAJJZeDQAZIcKA7858SZzudQ6IF+
        3997Q9+iijgPPjYI4ejhMj5mqdBFY/7NBW44p3RRyoBA5JI=
X-Google-Smtp-Source: ABdhPJxjfD7NY2vptiY6wx8ZfClj/kjGh6JxkYTIlrrbiL4YhbYdGnKEerqmhVCSO2/QUOy2pinM8XrJ8iHcZuT6SLE=
X-Received: by 2002:a1f:d782:: with SMTP id o124mr29393918vkg.6.1634070873189;
 Tue, 12 Oct 2021 13:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211012075634.8041-1-weiyongjun1@huawei.com> <3EC78E44-6E60-4B99-B880-2F5CC468C424@holtmann.org>
In-Reply-To: <3EC78E44-6E60-4B99-B880-2F5CC468C424@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Oct 2021 13:34:22 -0700
Message-ID: <CABBYNZL=wSZaLsLAm7Btg6Tmv=K7z903kQxfvRRVPPH0nAcsOA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix memory leak of hci device
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Wei, Marcel,

On Tue, Oct 12, 2021 at 8:54 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Wei,
>
> > Fault injection test reported memory leak of hci device as follows:
> >
> > unreferenced object 0xffff88800b858000 (size 8192):
> >  comm "kworker/0:2", pid 167, jiffies 4294955747 (age 557.148s)
> >  hex dump (first 32 bytes):
> >    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    00 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
> >  backtrace:
> >    [<0000000070eb1059>] kmem_cache_alloc_trace mm/slub.c:3208
> >    [<00000000015eb521>] hci_alloc_dev_priv include/linux/slab.h:591
> >    [<00000000dcfc1e21>] bpa10x_probe include/net/bluetooth/hci_core.h:1=
240
> >    [<000000005d3028c7>] usb_probe_interface drivers/usb/core/driver.c:3=
97
> >    [<00000000cbac9243>] really_probe drivers/base/dd.c:517
> >    [<0000000024cab3f0>] __driver_probe_device drivers/base/dd.c:751
> >    [<00000000202135cb>] driver_probe_device drivers/base/dd.c:782
> >    [<000000000761f2bc>] __device_attach_driver drivers/base/dd.c:899
> >    [<00000000f7d63134>] bus_for_each_drv drivers/base/bus.c:427
> >    [<00000000c9551f0b>] __device_attach drivers/base/dd.c:971
> >    [<000000007f79bd16>] bus_probe_device drivers/base/bus.c:487
> >    [<000000007bb8b95a>] device_add drivers/base/core.c:3364
> >    [<000000009564d9ea>] usb_set_configuration drivers/usb/core/message.=
c:2171
> >    [<00000000e4657087>] usb_generic_driver_probe drivers/usb/core/gener=
ic.c:239
> >    [<0000000071ede518>] usb_probe_device drivers/usb/core/driver.c:294
> >    [<00000000cbac9243>] really_probe drivers/base/dd.c:517
> >
> > hci_alloc_dev() do not init the device's flag. And hci_free_dev()
> > using put_device() to free the memory allocated for this device,
> > but it calls just kfree(dev) only in case of HCI_UNREGISTER flag
> > is set. So any error handing before hci_register_dev() success
> > will cause memory leak.
> >
> > To avoid this behaviour we need to set hdev HCI_UNREGISTER flag
> > in hci_alloc_dev_priv().
> >
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 8a47a3017d61..42410f568e90 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3876,6 +3876,11 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_pr=
iv)
> >       INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
> >       INIT_DELAYED_WORK(&hdev->ncmd_timer, hci_ncmd_timeout);
> >
> > +     /* We need to set HCI_UNREGISTER flag to correctly release
> > +      * the device in hci_free_dev()
> > +      */
> > +     hci_dev_set_flag(hdev, HCI_UNREGISTER);
> > +
>
> I can see the point in the bug report, but I don=E2=80=99t see that the f=
ix is correct. Can you prove that this fix is correct when hci_register_dev=
 is actually called.

I also wonder where is the actual check for HCI_UNREGISTER that the
commit description says prevents the kfree? hci_free_dev itself just
calls put_device, so perhaps it is actually talking about the check in
bt_host_release, anyway in for this to work the HCI_UNREGISTER would
have to be cleared by hci_register_dev otherwise the likes of
hci_dev_do_open don't work as it checks if HCI_UNREGISTER had been
called.

We also would need to check if it is safe to call hci_release_dev if
the workqueues, etc, had not been initialized yet, or perhaps don't
really use HCI_UNREGISTER and just do something like this:

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 7827639ecf5c..81c50b47183f 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -86,6 +86,9 @@ static void bt_host_release(struct device *dev)

        if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
                hci_release_dev(hdev);
+       else
+               kfree(hdev);
+
        module_put(THIS_MODULE);

If this doesn't fix all the leaks that probably means part of the
hci_release_dev still needs to be executed which can probably be done
by having the check for HCI_UNREGISTER around the code that does
actually depend on hci_register_dev.

--=20
Luiz Augusto von Dentz
