Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62121D3D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447865; cv=none; b=Z3cbdXskekXDo6bNTCNoPIKAuParnKiRNBe9XTQiOTnA5iL6XO1hQ55V6EJQwFD/PrLNPRx4U+QoL6t8LeoWWQrXzgEyN0IL+3ctzyvrzpeATP1ojZvuoS3/VHRWPvqQCWG4lKn4PgDD8p/DHikaBECyGlZgaPw+llT+SB9kowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447865; c=relaxed/simple;
	bh=yzqgDzTGf/8C6C+JiXBBSxWVkV9g4M2mkZZB9M3Fjgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re4gE2tvZlLpYrb/sUR9wWOF1eFKUH1n8udX1V9DcnNfM0rYbQStTR8rp0SkS0d21CdaGfEBOncYe8jXxaEy/cgXrPnvn3VTuFrvl1usyS9pch+Z9tXeHgfj3r3lXmPNUDpZj4LYNe5n3ykc64Etcs2mbBwfvKXNxi0oVfII5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BmZ8DQav; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmZ8DQav"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e589c258663so916568276.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739447862; x=1740052662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAeTsbP8grO1Y1/oZD12vcfULFlMlyIveKrhN6hNGEI=;
        b=BmZ8DQavkVD9Z95BQtugJILjJHgagnK1TT4UANbdnVLI0Uvg6IMSMg5U+XGZDA6DRK
         M8KRZ5U46ho7vaEFIyZ9PT5RskQZMrxtLcPWdOHeJ4CkiinMwKkcnGiKywy8tQxSVkAm
         A72uCu1Yb8XphMW+usdYrwwgaPGwDK/cdku7rxYsFH3m93DUHLJvImcXSGNqca1dszkt
         ZhvARr4EimXEmo7ZNXQXz93CeHdl0bH1ucCOcdsC5HiLt2o6y2LGwW3UmsFr5490beZ+
         L8VvqjIKMa4wUVko9KnZFQC6pnG/3H0dauwUN3Oteih/Qo9RMY05H59It/yJ9qYgMTS+
         XuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447862; x=1740052662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAeTsbP8grO1Y1/oZD12vcfULFlMlyIveKrhN6hNGEI=;
        b=vF/dlOQvv6s/149/FHDHToJLFKoMMAScSq3BW39nBM+HX4DaHCKre4tdBcJMqFq3bf
         ZNIwGurtqF3i7yWvs3T4BsUTNef85OwAMkzYYfiITVW6JZU/gSOhJ8KSO7jgP61mH8hm
         /Oe+URmVuP8z7dNiAmxnsv2/kSrbtJcURVx8Y8oDEVrl/6UuJnpZBXcWEE3TVgyzJT9t
         htaLCDrcrnPxwsxupgm/U9FbA/lkLTW4oN3dU/3em4HH/dfe77UJKjGzf1yDXqoj2Xr8
         VD9tRKIHYU7/FS8zF0Ul1+cck412FfsBY5t6QI2VH2qlu3LmXfaRlRHOZTaeFSU/t9P3
         dfmA==
X-Gm-Message-State: AOJu0YzY9g7M5J91zY4AdjOI/4zCfMbby8ZJGSxpUb3CLYMB36JQ92ij
	TJPnTO4kgNafEuZ3DnRnki2VNGB1Nc2iU+B+DUBlsGFSIkgXOXkNdI9fc4EXHRo3WQ+YRFPRCwK
	IQvDLk4NxjnmsEM4j4T7W4NgzS5EbgvqK8+tF
X-Gm-Gg: ASbGncsgCTkN67cwLKGLjsugfHCpILty5d5WuDsEnVz2p8C2WR5TK+xRuc9tviVStVj
	mb9dUFllGdnVAM+yBvoqbQNqMY0fYBqPmdELA4GEh3bHEvZrj/uxS5AoOorAAErTkeZzmAQ==
X-Google-Smtp-Source: AGHT+IHTHu2Wq5Nkq1URd0WoKprD88+1HOlz9mbdLilD1o4mfqGQKrXJqnLzk82cnP2aJxrlsMsgC1wNWJ75V9QJuq0=
X-Received: by 2002:a05:6902:2102:b0:e5a:c5d6:3948 with SMTP id
 3f1490d57ef6-e5d9efe9db7mr6943660276.0.1739447862000; Thu, 13 Feb 2025
 03:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh>
In-Reply-To: <2025021352-dairy-whomever-f8bd@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 19:57:15 +0800
X-Gm-Features: AWEUYZlq75LIFYPIrtEvnz3TB7WFuT6LMkfSPqyFE9VT04sCMSzyEJ2iGUZu7t0
Message-ID: <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The btusb driver data is allocated by devm_kzalloc and is
automatically freed on driver detach, so I guess we don't have
anything to do here.
Or perhaps we should move btusb_disconnect's content here? Luiz, what
do you think?

On Thu, Feb 13, 2025 at 6:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 13, 2025 at 11:43:59AM +0800, Hsin-chen Chuang wrote:
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Expose the isoc_alt attr with device group to avoid the racing.
> >
> > Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> > it also becomes the parent device of hci dev.
> >
> > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control =
USB alt setting")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Create a dev node for btusb. It's now hci dev's parent and the
> >   isoc_alt now belongs to it.
> > - Since the changes is almost limitted in btusb, no need to add the
> >   callbacks in hdev anymore.
> >
> > Changes in v3:
> > - Make the attribute exported only when the isoc_alt is available.
> > - In btusb_probe, determine data->isoc before calling hci_alloc_dev_pri=
v
> >   (which calls hci_init_sysfs).
> > - Since hci_init_sysfs is called before btusb could modify the hdev,
> >   add new argument add_isoc_alt_attr for btusb to inform hci_init_sysfs=
.
> >
> >  drivers/bluetooth/btusb.c        | 98 +++++++++++++++++++++++++-------
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_sysfs.c        |  3 +-
> >  3 files changed, 79 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 1caf7a071a73..cb3db18bb72c 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -920,6 +920,8 @@ struct btusb_data {
> >       int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> >
> >       struct qca_dump_info qca_dump;
> > +
> > +     struct device dev;
> >  };
> >
> >  static void btusb_reset(struct hci_dev *hdev)
> > @@ -3693,6 +3695,9 @@ static ssize_t isoc_alt_store(struct device *dev,
> >       int alt;
> >       int ret;
> >
> > +     if (!data->hdev)
> > +             return -ENODEV;
> > +
> >       if (kstrtoint(buf, 10, &alt))
> >               return -EINVAL;
> >
> > @@ -3702,6 +3707,34 @@ static ssize_t isoc_alt_store(struct device *dev=
,
> >
> >  static DEVICE_ATTR_RW(isoc_alt);
> >
> > +static struct attribute *btusb_sysfs_attrs[] =3D {
> > +     NULL,
> > +};
> > +ATTRIBUTE_GROUPS(btusb_sysfs);
> > +
> > +static void btusb_sysfs_release(struct device *dev)
> > +{
> > +     // Resource release is managed in btusb_disconnect
>
> That is NOT how the driver model works, do NOT provide an empty
> release() function just to silence the driver core from complaining
> about it.
>
> If for some reason the code thinks it is handling devices differently
> than it should be, fix that instead.
>
> thanks,
>
> greg k-h

--=20
Best Regards,
Hsin-chen
