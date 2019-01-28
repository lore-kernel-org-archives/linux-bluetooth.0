Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAD2C282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 15:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A31F2148E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 15:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyQLAEQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfA1PhC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:37:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36609 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfA1PhB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 10:37:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so14979532otk.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jan 2019 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vhtlGnvKrWAeYt9e73HuiGK8znj1JqTkJdXCL6Zpu8M=;
        b=tyQLAEQmdDrHnLJjp7VxGP5e0B2v5PPQrQSat8bOYBSZju+F1OuMcimI2O5VK7XNjK
         fd4Lr8nEBANNmrMhgMvLQwcglI1HnwVIXsBsDXhEllyYRrSf7BB0Br0KRUYtbJHUFkLw
         4Ae2qVgha1GOGwuzkhLkt2C+nNkqulSlearJNhWx8ELg64Up7ZbO3myZcpZf1de63eQv
         CAGdOoHwvurKN2hFdRzfWrb6P3EhNhcyAGAZ3gdKt9xnL/5SpOTUbg49lInQw09D2+dM
         xuZnD4mJiiHkX3L/bNwzrblX4aCcn8gcIXUH0VfVplPOZ3k1fXe03sIaKVYRZoAWlyQS
         dxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vhtlGnvKrWAeYt9e73HuiGK8znj1JqTkJdXCL6Zpu8M=;
        b=cMoIh5fWW+rHgbQnORNJtcWYm6dpsADQ7HOOZXX8Io+sIyOnkccDIipWQCPJJR7aiz
         1dG/EQLnarx0Ec7F6bH8y52PiBclDqRxGYztEwd6Stt7pmA0cuKg8TbYDlYjqNUeDQrm
         fGLDJMVMLzadmvkw9xHDfMpyWpFYe6FADUWNVfFTWJo1Pc/SOBRMJdSyxFMVZejwGYws
         yGJc2xBKO7IYGpIpykmIqNJPBiB/yM8nmxDtxuLPaB73o49QAqQ/PP6UQdJ7/jaXy91h
         4bUchoZ9CzncPv1uoNJIbAQ/B2g+F8wHZeATPkiSgHXQQ9L8ARLP2KpKSUJXxhopmlKI
         sDyQ==
X-Gm-Message-State: AJcUukfHP9EFq1W0KyEy5oJNCvq7U+vAbQbDO29dBYoflcm7zctZpb4z
        Wm5k3o4iU5PXx/aj1iH26JqQyOCKsk93i/rN3ek=
X-Google-Smtp-Source: ALg8bN6mzZQtN2LzwFi0zN232sEvuMhJBeQrvYwF2QbWr2ZxlD9/zMxf1Mmm4DY92GMNrE55N+4FgiCqZLuwin3WlCU=
X-Received: by 2002:a9d:754f:: with SMTP id b15mr16042001otl.231.1548689820606;
 Mon, 28 Jan 2019 07:37:00 -0800 (PST)
MIME-Version: 1.0
References: <1548665625-23742-1-git-send-email-raghuram.hegde@intel.com> <91F174CE-3CBE-4D3B-B0C9-E350C01F3DDF@holtmann.org>
In-Reply-To: <91F174CE-3CBE-4D3B-B0C9-E350C01F3DDF@holtmann.org>
From:   chethan tn <chethantn@gmail.com>
Date:   Mon, 28 Jan 2019 21:06:49 +0530
Message-ID: <CAMH2TCqtZM++VSboKbFB9htTCuP=8Z+8PmGDymdkSgrEXKr2Og@mail.gmail.com>
Subject: Re: [PATCH] btusb: Add shutdown routine for BTUSB_INTEL_NEW devices
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Raghuram Hegde <raghuram.hegde@intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Jan 28, 2019 at 5:37 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Raghuram,
>
> > btusb_shutdown_intel routine shall reset the controller
> > and stop all BT operation.
> > Advantages:
> >       1. Power save on the platform
> >       2. Host and controller will be in Sync.
> >
> > Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > ---
> > drivers/bluetooth/btusb.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 5de0c2e59b97..66483ca3d870 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3139,6 +3139,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >               hdev->manufacturer =3D 2;
> >               hdev->send =3D btusb_send_frame_intel;
> >               hdev->setup =3D btusb_setup_intel_new;
> > +             hdev->shutdown =3D btusb_shutdown_intel;
> >               hdev->hw_error =3D btintel_hw_error;
> >               hdev->set_diag =3D btintel_set_diag;
> >               hdev->set_bdaddr =3D btintel_set_bdaddr;
>
> I assumed that this was only needed for the older ROM versions of the Int=
el controllers and not the newer RAM versions. I have been told they don=E2=
=80=99t inherit the LED issue that we tried to fix with this. Please read t=
he comments in btusb_shutdown_intel and amend comments if needed and provid=
e a detailed commit message.
Yes you're absolutely right about the LED issue on the older ROM products.
But in the recent day we have observed that in case BT
operation(Inquiry/LE Scan) were triggered through the stack and
further BT was turned off through "hciconfig hci0 down". In this case
controller would active doing BT operation and consume power and also
might cause race condition on the next BT on as the controller might
try to push the events that were queued up before processing the reset
command. So to make sure when BT is turned off either through stack or
through command line thought it would be better approach to reset the
controller(This is applicable for ROM or RAM products).
>
> Regards
>
> Marcel
>
