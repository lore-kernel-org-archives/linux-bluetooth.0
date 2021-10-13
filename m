Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF567C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 21:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24826117A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 21:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhJMVbU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhJMVbU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 17:31:20 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF78C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 14:29:16 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id q13so7432574uaq.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A565fyX9bJRWFHIsQqOSrgSfk9qDFEDgNdYYPEdpi/0=;
        b=eyf2FoynMypnAtE4d0ywc4JRSMAsuPkI+cP6froCS1Nkgw+6wZ3pCXmCdbTdbkeyiT
         1wMKjSrLysLxHNiXEBvVvVNwZ0u6UdPTVYpjdaP7FAsxN8Dk+Jm4yMag6+EL71n6XfnY
         BKJz+r4ENz353ugIVMQ6ShPDKfa/oNfnL2/TEPWijHo4xeAmYXF4GaxYQiidAopvUlb7
         5eFZuVsIYDbbrEfoD9UGBzSraS/iuPmKxUibr2hxE67QIb8AqQ91A8vsdlG+XiAXEO2e
         84ZbaVlruheb+M71ahjcCeOQrXN11d8yOKHKTToW4J80Rz5Po6hT8YnBTouWNuknDGPO
         YVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A565fyX9bJRWFHIsQqOSrgSfk9qDFEDgNdYYPEdpi/0=;
        b=MOvBVt7yGFIpSLJW3v0l/7oZaj/icZ+g6YgkYBtYxBsf6knfhOtAiLw9fypVa5SdmB
         qQu1a7JGbaLtXYrStizdoL+PkVDDaBfuvY/Nh8V4eo6hkl6c53L/OttQuG8ENrvhJCtY
         7PRis14a6cw4l66yztB5bob2XT7EOMEr9dpwtLG7tvyaFEulH3lPJZCB4PWYiO1R/s7v
         l5Bvi1kE0D/n4kvt59KlaTjjf+AZnftgwA4sqB98XQamOTtiLJP9NFPeJTH6VdzNO9tV
         J3mSBYC61H9nKeBhkcC+fKOm1Fvzy9gtirC38Nxzzuh0v9VveCWfnZ/BpjFSTNT4AmIo
         8BGA==
X-Gm-Message-State: AOAM531r8YZxuGudFUfLDQk1jJxHtWgp5KQbFVaij4UGPQL7Z0brvzL4
        N5Cvd5FAM9yXTmFEYEo77vhLdum+9ne7zs6P8/OLIsgZ
X-Google-Smtp-Source: ABdhPJzeQp8AlzNIfVXCm6UIk/vS1ubWNMJ2UveMJDikqmBNRi69iC4UBMVgQ+3pu99LWTnawzQPvjBw1ChOr+g2prw=
X-Received: by 2002:ab0:5741:: with SMTP id t1mr2144255uac.72.1634160555550;
 Wed, 13 Oct 2021 14:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211013003055.2664728-1-luiz.dentz@gmail.com>
 <20211013003055.2664728-4-luiz.dentz@gmail.com> <C7BF6917-DDB0-4B3A-87CD-46E5A68A9C12@holtmann.org>
In-Reply-To: <C7BF6917-DDB0-4B3A-87CD-46E5A68A9C12@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Oct 2021 14:29:04 -0700
Message-ID: <CABBYNZKEt=ncL_Q=VBHMOzd8_8n7F0693+7gfp7_Gve3ZRdvGw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Bluetooth: vhci: Add support for setting aosp_capable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Oct 12, 2021 at 11:46 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> > This adds a debugfs entry to set aosp_capable enabling vhci to emulate
> > controllers with AOSP extension support.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/hci_vhci.c | 68 +++++++++++++++++++++++++++++++++---
> > 1 file changed, 64 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.=
c
> > index 68a970db8db1..f9aa3fe14995 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -45,6 +45,9 @@ struct vhci_data {
> > #if IS_ENABLED(CONFIG_BT_MSFTEXT)
> >       __u16 msft_opcode;
> > #endif
> > +#if IS_ENABLED(CONFIG_BT_AOSPEXT)
> > +     __u16 aosp_capable;
> > +#endif
> > };
> >
> > static int vhci_open_dev(struct hci_dev *hdev)
> > @@ -223,18 +226,68 @@ static int msft_opcode_get(void *data, u64 *val)
> > DEFINE_DEBUGFS_ATTRIBUTE(msft_opcode_fops, msft_opcode_get, msft_opcode=
_set,
> >                        "%llu\n");
> >
> > +#endif /* CONFIG_BT_MSFTEXT */
> > +
> > +#if IS_ENABLED(CONFIG_BT_AOSPEXT)
> > +
> > +static ssize_t aosp_capable_read(struct file *file, char __user *user_=
buf,
> > +                              size_t count, loff_t *ppos)
> > +{
> > +     struct vhci_data *vhci =3D file->private_data;
> > +     char buf[3];
> > +
> > +     buf[0] =3D vhci->aosp_capable ? 'Y' : 'N';
> > +     buf[1] =3D '\n';
> > +     buf[2] =3D '\0';
> > +     return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> > +}
> > +
> > +static ssize_t aosp_capable_write(struct file *file,
> > +                               const char __user *user_buf, size_t cou=
nt,
> > +                               loff_t *ppos)
> > +{
> > +     struct vhci_data *vhci =3D file->private_data;
> > +     bool enable;
> > +     int err;
> > +
> > +     err =3D kstrtobool_from_user(user_buf, count, &enable);
> > +     if (err)
> > +             return err;
> > +
> > +     if (vhci->aosp_capable =3D=3D enable)
> > +             return -EALREADY;
> > +
> > +     vhci->aosp_capable =3D enable;
> > +
> > +     return count;
> > +}
> > +
> > +static const struct file_operations aosp_capable_fops =3D {
> > +     .open           =3D simple_open,
> > +     .read           =3D aosp_capable_read,
> > +     .write          =3D aosp_capable_write,
> > +     .llseek         =3D default_llseek,
> > +};
> > +
> > +#endif /* CONFIG_BT_AOSEXT */
> > +
> > static int vhci_setup(struct hci_dev *hdev)
> > {
> >       struct vhci_data *vhci =3D hci_get_drvdata(hdev);
> >
> > +#if IS_ENABLED(CONFIG_BT_MSFTEXT)
> >       if (vhci->msft_opcode)
> >               hci_set_msft_opcode(hdev, vhci->msft_opcode);
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_BT_AOSPEXT)
> > +     if (vhci->aosp_capable)
> > +             hci_set_aosp_capable(hdev);
> > +#endif
>
> this is too much ifdef for me. And you are not really saving anything her=
e since this is a test driver and who cares if we waste an additional 3 byt=
es memory for vhci_data struct.
>
> So really just do this unconditionally
>
>         hci_set_msft_opcode(hdev, vhci->msft_opcode);
>         hci_set_aosp_capable(hdev);
>
> And frankly, do both vendor extensions in one patch.

Ack.

> >
> >       return 0;
> > }
> >
> > -#endif /* CONFIG_BT_MSFTEXT */
> > -
> > static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> > {
> >       struct hci_dev *hdev;
> > @@ -278,8 +331,10 @@ static int __vhci_create_device(struct vhci_data *=
data, __u8 opcode)
> >       hdev->get_codec_config_data =3D vhci_get_codec_config_data;
> >       hdev->wakeup =3D vhci_wakeup;
> >
> > -     /* Enable custom setup if CONFIG_BT_MSFTEXT is selected */
> > -#if IS_ENABLED(CONFIG_BT_MSFTEXT)
> > +     /* Enable custom setup if CONFIG_BT_MSFTEXT or CONFIG_BT_AOSPEXT =
is
> > +      * selected.
> > +      */
> > +#if IS_ENABLED(CONFIG_BT_MSFTEXT) || IS_ENABLED(CONFIG_BT_AOSPEXT)
> >       hdev->setup =3D vhci_setup;
> >       set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> > #endif
>
> Even this one is not worth it, just have it run through hdev->setup all t=
he time. If nothing is run, then there is no harm.

Ack

> > @@ -311,6 +366,11 @@ static int __vhci_create_device(struct vhci_data *=
data, __u8 opcode)
> >                           &msft_opcode_fops);
> > #endif
> >
> > +#if IS_ENABLED(CONFIG_BT_AOSPEXT)
> > +     debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> > +                         &aosp_capable_fops);
> > +#endif
> > +
>
> This is the ifdef check we should keep. If not enabled, then we should no=
t expose the debugfs setting. Just wrap it in an if-clause from C so that t=
he compiler doesn=E2=80=99t warn us for unused functions.

Got it.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
