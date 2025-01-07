Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6BE1EC014;
	Tue,  7 Jan 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268712; cv=none; b=lj5M2HJaJrKSoUryI6eX6khi8rm6m7fwqewo6K/A/peizSkagrHL2xekebIsftBYmeCptHFY5AkkrIJ2f7edzDTYXMZWAbCuJkYme7ljHgj22+DMJID7bfRhu8/I+B1hiOYdE7zGw8jUWwO/K+octqFA81je0hHnSncb45zDBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268712; c=relaxed/simple;
	bh=2D1Zu25zVj4Un4NODSaxTUJ2BYBx6OcMZnw01MDbvKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FInjS+Zi3F2+mcLWYteCrZ45IBJ2jJr9Yw1GPMyF/ysaG0P7Bdu1eiikqYZAR524t7YRpiDAvLLx6jWROeRmqpgbb9eC2T+bCPcxyrJfQLbMmA2bAEKnQxrAvjIbt42yJJkl+JftDa76eAJ40mc5pJlB8F00LEyRt0NT8nStMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfEnaiSM; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfEnaiSM"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3003943288bso179376511fa.0;
        Tue, 07 Jan 2025 08:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736268707; x=1736873507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju7NwoFmWefwWuXenVWv/0xSbHi9EYHcYNWBb6aZOYE=;
        b=NfEnaiSM5e5N//3fdni9Eo/WZNrCb2TL5a82YqX2yEk9GJDI9bxh6CYJXA09cbQohD
         JKCwMP0Jn0zD4Ub1EfbTejuSsDg2NZebyb1dxdSc3VP5XRjjQvLxfuU9uITTTiLrTh06
         BaZDFS1dfRlqT+zvSMWd7LdqQ0zF9gv5iFFdAjQGA9WoripY2GbFtm6ItT0bUVjUzu6e
         iXnfeY02u1DO2wieFVpnSujXB/PBueKTruKYTaYhQNP16JBjVbtQ4yxflQVKrTVqOG5H
         UEatudB4yjfdeuPA3B3cn6MQNhOWtbN/FoFCAuAbMkhVvgoEblYwxRQpSVAwyaOh0ssd
         t1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268707; x=1736873507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju7NwoFmWefwWuXenVWv/0xSbHi9EYHcYNWBb6aZOYE=;
        b=ut+V79OHTRgPoFdgCfl99egIT0eczY9DXBzuCQhsuI3Rlzx+RQUZMtGX1ZoXWFJ6mz
         p+eHqyV28WDCSCkP0h7dwpED9rBIry3wXZgZNUu6BJDq66qnupcmTxQhmPxl2qZzN87Y
         fkdc4emy05SjcuJVkfg/+hPs5Xb78GW3+UlXu4WwMDZcX1ofhSfHEFZWJdescCXFl4NR
         K9IHkm1NDhevSpMOic3Vb51fOwglRW6l461d2BD6x0GgfNjMM3Tnt13z2fR7Og88C1jc
         Q21dJjhkfY9NmKD7UM7zj6mpDVXV/Mpm1t7aK7NNepFbGAl1tD7uP6ZX5nLFtoOKJMKF
         uWuw==
X-Forwarded-Encrypted: i=1; AJvYcCXwZY6JaoUQ2LVNiFqW+8KmkGNDdiKj0mvI7DfouLrWV6bIzlSte2LSijmrjQ9fnWtyq08JdTTYGCy9NvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytizSS5BCW49RYNZoyk+lvw2e72mCqwG4fvQyc2IcWgQCQMh55
	o+GmoIlWtS/zfhoR+2pMn1lMCd6ahVL81XAoq/CREhPMJ9Zh3G4YP0J7ffqXsOFIu2PLXxZA0/+
	JxHLNRA4QlmT41beQC4+aZoc3DYMgog==
X-Gm-Gg: ASbGnctUG1bh9IhlkEcR7DVge/Lg0UN3tjUIA8hWd8CrV/jH7y3zBThZw+NSMNfZDlV
	4Z4hljGXl6YuApXT4hPrsM0rTr59KM1hs3v9izEs=
X-Google-Smtp-Source: AGHT+IH1njKqOefDd9mztk5voWKtI9qQ2zk75hADht949ZAghRRIzOYOvRFvbSwoXGiQyE7C/7gFDuSwrpke4GAklhU=
X-Received: by 2002:a05:651c:b0a:b0:300:360b:bc3f with SMTP id
 38308e7fff4ca-304685527edmr164018371fa.15.1736268706615; Tue, 07 Jan 2025
 08:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
 <CABBYNZKDRm7vf1RewwW-+0fBwHTS0RXKqxNME_HpyB-q-mNLYQ@mail.gmail.com> <CAG=_-8cMgr_NqtX_zEV_7K1hunmOzQB4mgGDAiBPaX-vd9E=4A@mail.gmail.com>
In-Reply-To: <CAG=_-8cMgr_NqtX_zEV_7K1hunmOzQB4mgGDAiBPaX-vd9E=4A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Jan 2025 11:51:34 -0500
X-Gm-Features: AbW1kvYmIFyGoIU5XVgHoRq9IynyLVlsr1OjzSfWZAUsDQv_xmSK162nWMIrUM8
Message-ID: <CABBYNZJrtvPDW-Mn_qRxcC=rVR8z3Kt8K_o+ACce3yNv39v_-w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Allow reset via sysfs
To: Hsin-chen Chuang <chharry@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Tue, Jan 7, 2025 at 2:21=E2=80=AFAM Hsin-chen Chuang <chharry@chromium.o=
rg> wrote:
>
> Hi Luiz,
>
> This is not btusb specific, and is not limited to USB reset.
>
> The cmd_timeout handler can also be found in the QCA uart and the MTK
> sdio controller drivers. It's up to the vendors to implement a reliable
> reset mechanism, and we welcome - or prefer - an OOB solution such as
> reset over GPIO.

My bad, I didn't realize it was under hci_sysfs, which makes sense,
that said I do wonder if it wouldn't be better to name the callback as
reset rather than cmd_timeout and we should probably move them from
btusb if there are not usb specific, in fact there is already a reset
callback but it doesn't seem to be used which I think it is a mistake
and we should actually make the vendor reset the callback o
hdev->reset not have hdev->cmd_timeout -> vendor_cmd_timeout ->
btusb_reset -> hdev->reset but rather btusb_reset -> hdev->reset ->
vendor_reset then we can get rid of cmd_timeout.

> This patch involves some btusb changes because the handlers in btusb
> can only do something after being called 5 times, while the other
> handlers don't.

Ok, then please have these changes splitted since they have different purpo=
ses.

>
>
> On Tue, Jan 7, 2025 at 12:29=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hsin-chen,
> >
> > On Thu, Jan 2, 2025 at 10:21=E2=80=AFPM Hsin-chen Chuang <chharry@chrom=
ium.org> wrote:
> > >
> > > Allow sysfs to trigger reset via the cmd_timeout function in hci devi=
ce.
> > > This is required to recover devices that are not responsive from
> > > userspace.
> >
> > Don't we have a similar control over USB to reset the device? I think
> > that would be better than introducing something btusb specific.
> >
> > > Also remove the cmd timeout count in btusb since we only ever allow o=
ne
> > > command in flight at a time. We should always reset after a single
> > > command times out.
> > >
> > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > ---
> > > This commit has been tested on a Chromebook by running
> > > `echo 1 > /sys/class/bluetooth/hci0/reset`
> > >
> > >  drivers/bluetooth/btusb.c | 10 ----------
> > >  net/bluetooth/hci_sysfs.c | 19 +++++++++++++++++++
> > >  2 files changed, 19 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 279fe6c115fac..a4810c77fa0da 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -879,7 +879,6 @@ struct btusb_data {
> > >         int (*disconnect)(struct hci_dev *hdev);
> > >
> > >         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> > > -       unsigned cmd_timeout_cnt;
> > >
> > >         struct qca_dump_info qca_dump;
> > >  };
> > > @@ -912,9 +911,6 @@ static void btusb_intel_cmd_timeout(struct hci_de=
v *hdev)
> > >         struct gpio_desc *reset_gpio =3D data->reset_gpio;
> > >         struct btintel_data *intel_data =3D hci_get_priv(hdev);
> > >
> > > -       if (++data->cmd_timeout_cnt < 5)
> > > -               return;
> > > -
> > >         if (intel_data->acpi_reset_method) {
> > >                 if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_d=
ata->flags)) {
> > >                         bt_dev_err(hdev, "acpi: last reset failed ? N=
ot resetting again");
> > > @@ -997,9 +993,6 @@ static void btusb_rtl_cmd_timeout(struct hci_dev =
*hdev)
> > >
> > >         btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
> > >
> > > -       if (++data->cmd_timeout_cnt < 5)
> > > -               return;
> > > -
> > >         if (!reset_gpio) {
> > >                 btusb_reset(hdev);
> > >                 return;
> > > @@ -1044,9 +1037,6 @@ static void btusb_qca_cmd_timeout(struct hci_de=
v *hdev)
> > >                 return;
> > >         }
> > >
> > > -       if (++data->cmd_timeout_cnt < 5)
> > > -               return;
> > > -
> > >         if (reset_gpio) {
> > >                 bt_dev_err(hdev, "Reset qca device via bt_en gpio");
> > >
> > > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > > index 4b54dbbf0729a..7bf2b10b0a7cf 100644
> > > --- a/net/bluetooth/hci_sysfs.c
> > > +++ b/net/bluetooth/hci_sysfs.c
> > > @@ -90,9 +90,28 @@ static void bt_host_release(struct device *dev)
> > >         module_put(THIS_MODULE);
> > >  }
> > >
> > > +static ssize_t reset_store(struct device *dev, struct device_attribu=
te *attr,
> > > +                          const char *buf, size_t count)
> > > +{
> > > +       struct hci_dev *hdev =3D to_hci_dev(dev);
> > > +
> > > +       if (hdev->cmd_timeout)
> > > +               hdev->cmd_timeout(hdev);
> > > +
> > > +       return count;
> > > +}
> > > +static DEVICE_ATTR_WO(reset);
> > > +
> > > +static struct attribute *bt_host_attrs[] =3D {
> > > +       &dev_attr_reset.attr,
> > > +       NULL,
> > > +};
> > > +ATTRIBUTE_GROUPS(bt_host);
> > > +
> > >  static const struct device_type bt_host =3D {
> > >         .name    =3D "host",
> > >         .release =3D bt_host_release,
> > > +       .groups =3D bt_host_groups,
> > >  };
> > >
> > >  void hci_init_sysfs(struct hci_dev *hdev)
> > > --
> > > 2.47.1.613.gc27f4b7a9f-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> --
> Best Regards,
> Hsin-chen



--=20
Luiz Augusto von Dentz
