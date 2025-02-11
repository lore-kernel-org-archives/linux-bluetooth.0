Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183991B3934
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739247803; cv=none; b=f2LMb0w8ti5AI+bvG562RDyniXK1UwUMCNvjOk8vBci+q1c4elUkB4DLjfwz52S1XjRT/BzO3IQDO/d+iLSPKAjUbHP1adRSOuayCxBP5h8exdMG/UWm+RKGWp/Pjrkj36N93ANTYEJpWzfb98qhugvl02OA0ktqPaKP/pIsBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739247803; c=relaxed/simple;
	bh=R0t/C1XKlZv20LTZa+7WfqHAu50Wp/qHlyPWRmFj1rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZxBKHKVQm7JsFGek/N4OeYM78M0aBuHJl8sulL9EpFGsgke8cmaqZE+4myZqW5KaDXYWC//iji/aEffPTmkJtb8kT267rr8Hw7oLNHY8dRuJA3u9zilM00VIluxH9I4Tzvh8vCnH7Xja/itJtxsrH1hz0/TYL/kVD8TJndhY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnfzKnst; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnfzKnst"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f9b1bc594dso30247117b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 20:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739247801; x=1739852601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l72HB9rJKeYDJipFoW423nUmM/ApGr/EuReUdhuYps8=;
        b=ZnfzKnstmcW8Z3UuRjRSU+Pjv/cdOqG3KOUcaw1LK7g4IGHKx+YzJURGxwS90NCxOJ
         Y2vzAbXYrn+LfMgzs7TAKF2Yr6ycH0dTaVOWJUuX9eYLkk6KjRP5aH5FiklMRyYohTaf
         2+NMAAKNQjtMw2WZ56UGp3RUCGFv5RjnqXCDzy0bbXkQhC5oiMu9nZ3QP/I/Z5Xihkyf
         JNyC5i8QxmkzNImnm2OFUEaX+kCGix1W920Ga/pEcygiLdknMjLc3bFvt5QqUVWWFB1v
         cx9axX1gIcR2SwwRD8LPi05SIe/AtyOqfNn1HxTc4MDeGbpbm3SeZnG2J+CHLPrzD0wf
         b7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739247801; x=1739852601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l72HB9rJKeYDJipFoW423nUmM/ApGr/EuReUdhuYps8=;
        b=bBZGikzeZaIeYN5dO1v21w8xiVhpCcEImzIJfki8Dhubml7PZnMtfXaZeUNcNCvNhT
         HcYnR41EF4Ku+mMDMkSRe0N9FPqjj7S1mtc7aFHHSkwF68kXbeFsEnfNAWIx5GVTcwqM
         R1BufmT404f/NLfkjgvUqSqkqqngOxwRuK7UD7euMccHal3XwbSzMKjTLSa5zrY2pINq
         5FULKld6zzvRtNyGUXmL+goUUdr9Pj9WztqPY4X21uzrTBPRHGFCWsJsvLQDnDbNN+TJ
         QRgGjUhbvAVgYIZmycdQZqjxtwMJoJkjnNiQq2ulnm5nCJv6tGsEcHZvDLGhklwusY/x
         HRDg==
X-Gm-Message-State: AOJu0YwFrJ1P1BJVODJABVK5bOFL+qg4O5GUyyLUFOUvQb9JuFNLdTO6
	DDxbkmU4q5Yfdbqzr0if2iaZ4+sTjx2QCXsbRTfH+sKKn8wr6DNuVJUd8oJoEMzGwcOZ5fryIjr
	RysrD2Wgki876MmFobGehIKWLx6FHhn2OzUW+
X-Gm-Gg: ASbGnctzFjNBigIQ424HV0oLqBlJ/VotKCabNGSH9w1ojbi3blLLIo9545L8PrTFIfL
	cA5yZtd73fCy6bg37o8y9n+hd+uM++K3hSk/fLZslouC1oOeuDVuGnjSQWCXQnx94PlCIlLZQlw
	==
X-Google-Smtp-Source: AGHT+IEaHSJgcTwNMe8gtMuNNKBGW5+JvqlPIxfElKzdLCmXoQQG9xeg40ledl/Pm2YjwEfekIy/qPMn28eoO8+uYLE=
X-Received: by 2002:a05:690c:4513:b0:6ef:7fc0:a378 with SMTP id
 00721157ae682-6f9b2873da5mr146546727b3.9.1739247800730; Mon, 10 Feb 2025
 20:23:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250210103244.646150-1-chharry@google.com> <CABBYNZJ1LbN_3H1pJsZ6mH1nY7ijb9nbuPSJJwqyvJnC0=U6PQ@mail.gmail.com>
In-Reply-To: <CABBYNZJ1LbN_3H1pJsZ6mH1nY7ijb9nbuPSJJwqyvJnC0=U6PQ@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Tue, 11 Feb 2025 12:22:53 +0800
X-Gm-Features: AWEUYZlMsFS0a8TBCzZxdEjcC3RUJx4_kVp2AhxUPsPyauDsGgauUhDUrF1occM
Message-ID: <CADg1FFe1DeDFmudxWZp3_thvTnm1N=ZOjXts0sJ7mxaUsFxE5Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org, 
	Ying Hsu <yinghsu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks for the feedback.

On Tue, Feb 11, 2025 at 2:17=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Mon, Feb 10, 2025 at 5:32=E2=80=AFAM Hsin-chen Chuang <chharry@google.=
com> wrote:
> >
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > The functionality was completed in commit 5e5c3898ef49 ("Bluetooth: Fix
> > possible race with userspace of sysfs isoc_alt")
> >
> > Fixes: 5e5c3898ef49 ("Bluetooth: Fix possible race with userspace of sy=
sfs isoc_alt")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  Documentation/ABI/stable/sysfs-class-bluetooth | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documenta=
tion/ABI/stable/sysfs-class-bluetooth
> > index 36be02471174..1168e0318e35 100644
> > --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> > +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> > @@ -7,3 +7,15 @@ Description:   This write-only attribute allows users =
to trigger the vendor reset
> >                 The reset may or may not be done through the device tra=
nsport
> >                 (e.g., UART/USB), and can also be done through an out-o=
f-band
> >                 approach such as GPIO.
> > +
> > +What:          /sys/class/bluetooth/hci<index>/isoc_alt
> > +Date:          10-Feb-2025
> > +KernelVersion: 6.13
> > +Contact:       linux-bluetooth@vger.kernel.org
> > +Description:   This attribute allows users to configure the USB Altern=
ate setting
> > +               for the specific HCI device. Reading this attribute ret=
urns the
> > +               current setting, and writing any supported numbers woul=
d change
> > +               the setting. See the USB Alternate setting definition i=
n Bluetooth
> > +               core spec 5, vol 4, part B, table 2.1.
> > +               If the data is not a valid number, the write fails with=
 -EINVAL.
> > +               The other failures are vendor specific.
>
> Still not really convinced this is the right way to expose it, it is
> not an HCI attribute to begin with, not sure if we couldn't perhaps

Could you tell more about why this is not an HCI attr to begin with?
The alt setting is bonded to the USB device which is now under btusb's
control, and btusb creates a sysfs node for this. This attr location
decision seems natural to me.

> add another node to control it or add via USB device?

I feel allowing this in the USB sysfs API might be an overkill as that
makes all USB devices' alt settings be controllable from the user
space. Limiting this usage in the scope of BT makes more sense to me.

>
> --
> Luiz Augusto von Dentz

--=20
Best Regards,
Hsin-chen
