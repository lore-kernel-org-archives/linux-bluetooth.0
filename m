Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFC242910
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455618; cv=none; b=ODdBDrEU0G1R+KMg+NK5nV4PFqGauco4w0rcuHmwr1z2a9konZWghcCVZCEAA1qbjCPD2ZW1T9SqvVsg0siWOa+TWmofL3hBRdZyuzj7hD2QEiwhzoTfC1ntLzIeJKNLgHcZdxg6rFPMGIv3YNnTHUksCfn8sQAd+Vlc2EeO4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455618; c=relaxed/simple;
	bh=RhLnZ4v0ULKWu0iDwJ0sh3qj5XEB/ULxdttsDFS1KZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nekIKxYsTb4C7uVgw8u46WUrNGnUNuEeOSpFQmpAms80FHN5YN85OBNzx7PcEeZPnse6KxdhWryS5Jc9nBIrrd246a4zM+8z/j97IZOcpfjinjCYwb5QwDfE2WBkZaI4vsRXvM2Op8YexYfILqW+vBi6yClbRsvqYOKG29j47Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGBtmAOT; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGBtmAOT"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so786251276.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 06:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739455616; x=1740060416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+s+afruOes/BeN3oETSozjf5b7KtJvFcnsAPWmxBXE=;
        b=jGBtmAOTh3l67r1MgaI3mBZy/RhqISfjGT4PcnhGD7V7Vf7uUlAsYY3BnrspP5G3XF
         KfV/QB4hnIfWYWxiOtPesPduvrR+/QeTRxenvXaSLxy/0v8Y1N8YHM7AxLAW+J6QmWZJ
         5fUIq0KZpViP9z+vPmUgIgFgXFxncPAhotgDBDKK9vIkA5YzZUC+FDECkbdI5Xl1dBRX
         fEY4l4rtSfJQx5guiKE/PayDqFnEf85lDaMFegEXBfCVyqZUyiI1ZEft5DQf5X2oGEIw
         B776jlUaDlmCxVStHNih5qLzHhjgD8G9tf6b9Jj5rlrNxbV0OYM8EFX8X6K/tOgXoZSk
         e04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455616; x=1740060416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+s+afruOes/BeN3oETSozjf5b7KtJvFcnsAPWmxBXE=;
        b=iMLf7RW+0BbOuxsp5bryLTPr5z1QVLuMNmRljCGAwoIB+5yt8u08XKdY1VCqudNPGK
         Rd3X1sH9NBjqjjP/xsreuoW5sMsm0vb+wDNZoV/tLy7TjjZOrwZCsHuH6z2zGpSmN/Lp
         yMMYJbeI3l9DHS//Fmr5z/E0+Ltn0eFXNz4go9DiVNz3sE8OOrZcEEI/buYenGGyWfCA
         +TIweWDfE6kyQdvvqhExVBCQQvK7K8v/D4+RnUmniUjxE1LEB/YiwDrEDLGPaSeswn0q
         RKm+I6HCduGp8Wkd+9M6nYcIKApVDB6co8B4xBmvbRwLkOnl4NFdN3dHqal+LRTWEjxr
         i5Fw==
X-Gm-Message-State: AOJu0YwabJNKr7nNe3SYo7X59KQt7W0KwBp2ZI8fqU1au7Y+7asb0YrB
	EDUvfj4jsbx9d4mIOSXDdU0xnoxqYM7Fp07tT+rWsue9o4+KRJ1F/fK7HPdj/Vf8rZ1/MzO/da7
	iVElqktvitxm/ljhMxfRNTQEQtb8CORvLoYlX
X-Gm-Gg: ASbGncsiN+7mn8l5xUy3h2DjsL+9iNo39H/5wPsTh+rzSvnFZutR9Yer2g1Jj5G2ZEl
	+ngPIb7Y6GbcAJ4ULiKG3TkdmFaxVVPuQjZUuWk7saMISekrKwGZYycwKB65BO2DREBtnWg==
X-Google-Smtp-Source: AGHT+IHp4oKPpDwKn7fG2TZzfyhaRjClxyo44F1t8DHE32SHPkpBM0l/RG3OXzwrkmmXl3IBHPn6cwzhD7yCo0ce5l0=
X-Received: by 2002:a05:6902:168c:b0:e5d:a934:701e with SMTP id
 3f1490d57ef6-e5da9347252mr2175525276.45.1739455615450; Thu, 13 Feb 2025
 06:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh> <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh> <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
 <2025021318-regretful-factsheet-79a1@gregkh>
In-Reply-To: <2025021318-regretful-factsheet-79a1@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 22:06:28 +0800
X-Gm-Features: AWEUYZk7KS1Z1NcVHtfdSpQsvsw9_eZGxVqxrJuVNvRinHaH1zuC1_kaAxufDe4
Message-ID: <CADg1FFf5hGrMM8fxiKFF5ZqEMZbsJzByp6+VuaXjJZnDPN2oUg@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 9:45=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 13, 2025 at 09:33:34PM +0800, Hsin-chen Chuang wrote:
> > On Thu, Feb 13, 2025 at 8:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > A: http://en.wikipedia.org/wiki/Top_post
> > > Q: Were do I find info about this thing called top-posting?
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > >
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > >
> > > http://daringfireball.net/2007/07/on_top
> > >
> > > On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > > > The btusb driver data is allocated by devm_kzalloc and is
> > > > automatically freed on driver detach, so I guess we don't have
> > > > anything to do here.
> > >
> > > What?  A struct device should NEVER be allocated with devm_kzalloc.
> > > That's just not going to work at all.
> >
> > Noted. Perhaps that needs to be refactored together.
> >
> > >
> > > > Or perhaps we should move btusb_disconnect's content here? Luiz, wh=
at
> > > > do you think?
> > >
> > > I think something is really wrong here.  Why are you adding a new str=
uct
> > > device to the system?  What requires that?  What is this new device
> > > going to be used for?
> >
> > The new device is only for exposing a new sysfs attribute.
>
> That feels crazy.
>
> > So originally we had a device called hci_dev, indicating the
> > implementation of the Bluetooth HCI layer. hci_dev is directly the
> > child of the usb_interface (the Bluetooth chip connected through USB).
> > Now I would like to add an attribute for something that's not defined
> > in the HCI layer, but lower layer only in Bluetooth USB.
> > Thus we want to rephrase the structure: usb_interface -> btusb (new
> > device) -> hci_dev, and then we could place the new attribute in the
> > new device.
> >
> > Basically I kept the memory management in btusb unchanged in this
> > patch, as the new device is only used for a new attribute.
> > Would you suggest we revise the memory management since we added a
> > device in this module?
>
> If you add a new device in the tree, it HAS to work properly with the
> driver core (i.e. life cycles are unique, you can't have empty release
> functions, etc.)  Put it on the proper bus it belongs to, bind the
> needed drivers to it, and have it work that way, don't make a "fake"
> device for no good reason.

Got it. Thanks for the info.

Hi Luiz, I will work on v5 to make btusb resources managed by device.
Any concern?

>
> thanks,

>
> greg k-h

--
Best Regards,
Hsin-chen
