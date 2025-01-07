Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E3185E7F
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234519; cv=none; b=smKC4TbOGHEPX5OcPAIBz4VCGcwk6MaKFFw3sMHK5uAd0d/KGUPBQ5HNS3NH+LB6bSPWYoN1P1yqu2nbV14biJ2hI6sdI25gG3htZcWouUQnSjOUW7STTLioH/RUo2lTbgqRWoR/A4+5CWTwBKV2IKqDz7AEQV2ukQOwCRJolVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234519; c=relaxed/simple;
	bh=zivr+trRtT0kiMrPw6cItxu9uApUcrhADnjihW3jnZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za+ijvhGjY658j4lcFrtF57UgdSb3zRAPkLJUE0Rln51+wN2cv7PuC5vIgrNkGeywgbjMdOuJ4vZfBhrPDE9w4EnLK4I0yVi1X/6enQxQ+zsf0mLpombtzId4LTL+uJNjAQo5oCd7WNJIqqfs1KQaPqrMD98/URk1G3S2G0Pdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P8ZKnAwP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8ZKnAwP"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d8c1950da7so14940887a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2025 23:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736234515; x=1736839315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD62p6byufxhRwvsBzm7HwTit5xByqP2uw+LQ7NlUYY=;
        b=P8ZKnAwPiokjd74M5SXtG8K2nRYMhT+3FCkpgW7Oz8oCDif+RyNeub2ntI+Jr5psVr
         ZOUQUrs/itbkBEW1lEEAVkDPECzqKz0BS3WznWec7uQpyrKx1sn3Lk6Ek778T2hOEbqd
         Il9DIAaZ4i+0385SdvwFeSN2+4+9671bVYR0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736234515; x=1736839315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD62p6byufxhRwvsBzm7HwTit5xByqP2uw+LQ7NlUYY=;
        b=sHyJN5zzSBh6Yf5+oVlaknHGnIOxeLA+nwRtxQulfuqbI+x8U/HjsENBKTADasD9BD
         Cd5bOQqxgsGkwLe0xfyqZUeY0J6s3DfptFHABBWLnTGiKasrCjnnOHCgdlolyKPDBpa5
         9HGL1abjh6wG/q9AHKbotdgSB+T8BfUpPmau4MnrJgCsIV9kmcCZlw3Dp2dG9EpLzfot
         OYDERdOJSsAdXu26azzv+HzG1J71k15bT6JE5Ug9VQ90Pedym2XEwAqeNoz7OhStJs57
         xgOa/XQo12OaI5bAnOmzlS3vuKW8HChF7LzyGNOpjQ8Y+iRqpTpr+jcNE5xU2/al0CuX
         WdVQ==
X-Gm-Message-State: AOJu0Yx4PnjZUy06KVqlXnulxPj59DfPCguS16lBAXS9TRySkH9tI/LW
	AERBf5DOGgXib+YYVwfYMHiwpZV1xWr4GSWFwzF76FUykDDKV0MC9E0Va6VRt+pRSPlC3FLQykx
	U0NCO9mkKL+1ZKVshRd14b+GGOEiYbrH8YYRo
X-Gm-Gg: ASbGncupq6jRiNC6IxCkgI281MvOXYu7SnQ5Y3xqEOGMbXiC0yCZIsp7/tK8FwlMNul
	/AitKDhEi3lMiCXMBEFeFizk1vsJIHnNCUXFhP58=
X-Google-Smtp-Source: AGHT+IFOF/4mk2379eRTnhJppYMPeYVYPCiFBAo5Sx5rFZCITJ+ZIid8aXKcs2Rq3+249Z/HYAhLF2lnC0aLbYExdco=
X-Received: by 2002:a05:6402:43cf:b0:5d3:e79b:3b4c with SMTP id
 4fb4d7f45d1cf-5d81de38c50mr52608062a12.31.1736234514969; Mon, 06 Jan 2025
 23:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
 <CABBYNZKDRm7vf1RewwW-+0fBwHTS0RXKqxNME_HpyB-q-mNLYQ@mail.gmail.com>
In-Reply-To: <CABBYNZKDRm7vf1RewwW-+0fBwHTS0RXKqxNME_HpyB-q-mNLYQ@mail.gmail.com>
From: Hsin-chen Chuang <chharry@chromium.org>
Date: Tue, 7 Jan 2025 15:21:42 +0800
Message-ID: <CAG=_-8cMgr_NqtX_zEV_7K1hunmOzQB4mgGDAiBPaX-vd9E=4A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Allow reset via sysfs
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

This is not btusb specific, and is not limited to USB reset.

The cmd_timeout handler can also be found in the QCA uart and the MTK
sdio controller drivers. It's up to the vendors to implement a reliable
reset mechanism, and we welcome - or prefer - an OOB solution such as
reset over GPIO.

This patch involves some btusb changes because the handlers in btusb
can only do something after being called 5 times, while the other
handlers don't.



On Tue, Jan 7, 2025 at 12:29=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Thu, Jan 2, 2025 at 10:21=E2=80=AFPM Hsin-chen Chuang <chharry@chromiu=
m.org> wrote:
> >
> > Allow sysfs to trigger reset via the cmd_timeout function in hci device=
.
> > This is required to recover devices that are not responsive from
> > userspace.
>
> Don't we have a similar control over USB to reset the device? I think
> that would be better than introducing something btusb specific.
>
> > Also remove the cmd timeout count in btusb since we only ever allow one
> > command in flight at a time. We should always reset after a single
> > command times out.
> >
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> > This commit has been tested on a Chromebook by running
> > `echo 1 > /sys/class/bluetooth/hci0/reset`
> >
> >  drivers/bluetooth/btusb.c | 10 ----------
> >  net/bluetooth/hci_sysfs.c | 19 +++++++++++++++++++
> >  2 files changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 279fe6c115fac..a4810c77fa0da 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -879,7 +879,6 @@ struct btusb_data {
> >         int (*disconnect)(struct hci_dev *hdev);
> >
> >         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> > -       unsigned cmd_timeout_cnt;
> >
> >         struct qca_dump_info qca_dump;
> >  };
> > @@ -912,9 +911,6 @@ static void btusb_intel_cmd_timeout(struct hci_dev =
*hdev)
> >         struct gpio_desc *reset_gpio =3D data->reset_gpio;
> >         struct btintel_data *intel_data =3D hci_get_priv(hdev);
> >
> > -       if (++data->cmd_timeout_cnt < 5)
> > -               return;
> > -
> >         if (intel_data->acpi_reset_method) {
> >                 if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_dat=
a->flags)) {
> >                         bt_dev_err(hdev, "acpi: last reset failed ? Not=
 resetting again");
> > @@ -997,9 +993,6 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *h=
dev)
> >
> >         btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
> >
> > -       if (++data->cmd_timeout_cnt < 5)
> > -               return;
> > -
> >         if (!reset_gpio) {
> >                 btusb_reset(hdev);
> >                 return;
> > @@ -1044,9 +1037,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev =
*hdev)
> >                 return;
> >         }
> >
> > -       if (++data->cmd_timeout_cnt < 5)
> > -               return;
> > -
> >         if (reset_gpio) {
> >                 bt_dev_err(hdev, "Reset qca device via bt_en gpio");
> >
> > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > index 4b54dbbf0729a..7bf2b10b0a7cf 100644
> > --- a/net/bluetooth/hci_sysfs.c
> > +++ b/net/bluetooth/hci_sysfs.c
> > @@ -90,9 +90,28 @@ static void bt_host_release(struct device *dev)
> >         module_put(THIS_MODULE);
> >  }
> >
> > +static ssize_t reset_store(struct device *dev, struct device_attribute=
 *attr,
> > +                          const char *buf, size_t count)
> > +{
> > +       struct hci_dev *hdev =3D to_hci_dev(dev);
> > +
> > +       if (hdev->cmd_timeout)
> > +               hdev->cmd_timeout(hdev);
> > +
> > +       return count;
> > +}
> > +static DEVICE_ATTR_WO(reset);
> > +
> > +static struct attribute *bt_host_attrs[] =3D {
> > +       &dev_attr_reset.attr,
> > +       NULL,
> > +};
> > +ATTRIBUTE_GROUPS(bt_host);
> > +
> >  static const struct device_type bt_host =3D {
> >         .name    =3D "host",
> >         .release =3D bt_host_release,
> > +       .groups =3D bt_host_groups,
> >  };
> >
> >  void hci_init_sysfs(struct hci_dev *hdev)
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >
>
>
> --
> Luiz Augusto von Dentz

--=20
Best Regards,
Hsin-chen
