Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BECC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 19:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762A560D43
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 19:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhJLT6H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhJLT6G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 15:58:06 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE6C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 12:56:04 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id j8so806970uak.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOyiTEnl01qfIDx+++4mzHeV5yh+AfNtyCGcWEKZ7/E=;
        b=p20XjeqGQWU0F/qCa4P5aWpoLHL6X2yymsmPQQBjiDB3oVHpf1fvjAeLhKCnQvpJtP
         IeqJ23r+iydIlCldXNqySz0f6Uw7k5MdRUumJebi0LFmOK+Egk0v0vNtebKZEqMieWhb
         od1DNemtsojGaJZe46wtFy7lJopypY+VntDczvT/L//koNXwutvnJn5Xq3wBcSm7yr3B
         Z2y5K7I3FFw1inVqvcqE2w0a3AjydrsCKwTh7Zff5s/uvhck55N1XGvJ9Jo+sIoXJ4ru
         cJluTWRpEuoHU6mjbdyqj5Tf5CQ2IIJ5v2motBzzLbiK7qbRDvXuNpipQY36tqttfhgY
         70Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOyiTEnl01qfIDx+++4mzHeV5yh+AfNtyCGcWEKZ7/E=;
        b=iNiP4rsUkHxcBPzQb/oDaw4pyuatnQVHneyZ5UCOPrt7du1VWqCXzxuy5WVN6FTaB8
         JEy3nl/jc+9FNziOnkxhsWxU7WKxAWNGkWLoQANCAOWiKo9XSNr4H4kZXtDNMUGJeKLW
         AXj1U9Rvs8/ohvMNh9LkcHxicK884Due63vEE69/4tpk76PeDiiGZpYJ3fLC90A8E/nF
         oZ3HwnxlcSKcgZxoqKTNcQuYwDxjPETdK0I0mmvxy5lT7B+geCczGMvi2iDPCdrPP9pC
         7BRHab3r1RBpsEQ3cQX5ikBybEUewK1kOq29MHcG8r9jP2xFl91azsuOEgjtfWDIm50S
         TKCg==
X-Gm-Message-State: AOAM5309U5ZtWXyp9LAM8HXogWcwRfu4+0WX9oFH1OeTVd5DP63+eeMv
        PblH8KW+c0dG52h3Jnd5ABj0YXLk+PXRjhwoD58jlyuVGx8=
X-Google-Smtp-Source: ABdhPJwfGV/tybfMpA6Qrtlo74e3ZnvwoPerXFKSj2BT4IT6evC9OfuCp1Na2cjPN7OqATdWuGQZ2NJ0mKq2s7pW1VE=
X-Received: by 2002:ab0:72d5:: with SMTP id g21mr13877189uap.102.1634068563164;
 Tue, 12 Oct 2021 12:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211011211147.2379624-1-luiz.dentz@gmail.com> <7288E0DB-FF22-4174-A24B-026EFA8A0E23@holtmann.org>
In-Reply-To: <7288E0DB-FF22-4174-A24B-026EFA8A0E23@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Oct 2021 12:55:52 -0700
Message-ID: <CABBYNZKWjuMc7chJaFFzqeZZQS15=VvhDC11qZf55NYgOw0G8g@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: vhci: Add support for setting msft_opcode
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Oct 12, 2021 at 8:50 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds a debugfs entry to set msft_opcode enabling vhci to emulate
> > controllers with MSFT extention support.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/hci_vhci.c | 32 ++++++++++++++++++++++++++++++++
> > 1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > index 56c6b22be10b..ac122299bacc 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -194,6 +194,34 @@ static const struct file_operations force_wakeup_fops = {
> >       .llseek         = default_llseek,
> > };
> >
> > +
> > +static int msft_opcode_set(void *data, u64 val)
> > +{
> > +     struct vhci_data *vhci = data;
> > +     uint16_t ogf = (val & 0xffff >> 10);
> > +
> > +     if (val > 0xffff || ogf != 0x3f)
>
> I would actually just include it here to avoid any 16-bit overflow.
>
>         if (val > 0xffff || (val & 0xffff >> 10) != 0x3f)

Ack.

> > +             return -EINVAL;
> > +
> > +     hci_set_msft_opcode(vhci->hdev, val);
> > +
> > +     return 0;
> > +}
> > +
> > +static int msft_opcode_get(void *data, u64 *val)
> > +{
> > +     struct vhci_data *vhci = data;
> > +
> > +     hci_dev_lock(vhci->hdev);
> > +     *val = vhci->hdev->msft_opcode;
> > +     hci_dev_unlock(vhci->hdev);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(msft_opcode_fops, msft_opcode_get, msft_opcode_set,
> > +                      "%llu\n");
> > +
> > static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> > {
> >       struct hci_dev *hdev;
> > @@ -259,6 +287,10 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> >       debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> >                           &force_wakeup_fops);
> >
> > +     if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> > +             debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> > +                                 &msft_opcode_fops);
> > +
>
> So my concern is that you can modify this value when the device is up and running. That will cause havoc.
>
> Just checking HCI_UP is kinda bad since we just removed that access from the drivers.

Right but we could add a check to HCI_UP inside hci_set_msft_opcode
and make it return an error, actually this might be a good idea anyway
even with existing so we prevent bad usage of hci_set_msft_opcode when
already up.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
