Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5C267735;
	Tue, 11 Feb 2025 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311265; cv=none; b=ksvEbiQovxcnD7QueP1pUFzLemN8gv/z2wx4ONJByz5eGkLoDXyvJLVwAoriPv/JfP3PavJTjAOvncUSqgCW52w8feETxxY31us/2d2brbSn/iIqYUxFk9ID2ssmzlc0kpmenevj9tfKHigq00ghZk+yLYHCHlujJrhwwoagcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311265; c=relaxed/simple;
	bh=GuH3Xw0HWE/B7hWsyzMiU5RPcuf3s5ZFvK5M9bd5hso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAXoFqJCKm/naO9NwWWxuIjULHDVobJrd0p4KXOgUG8c0afHp0Mlzd9TkoItYOmspl4rv8lemeM696oqZ9uy3h/tYofpWpIpbKO7Puf+TgHog738mIBHLAByixLWhxMpnrp1NePyZ9mBUCD5P9v+JaK6jmVFODdHOyoH04zcpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWntDGlu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWntDGlu"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-308f141518cso25096191fa.2;
        Tue, 11 Feb 2025 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739311262; x=1739916062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH0GdYMy8pz+jJrNXKtFU7Jsn2P+rBGG1+in1lbsGGI=;
        b=PWntDGluqsT671zPX3a3NuIEpTS9coRTtbPaYnnhdP5H3PVPFoDO6Bz61xioAOEE+p
         zwdy/NmdFg4Yj/hAJzSDQmmGCaGTQ+6VpwKgaoWLkpxECtuYl03KWWltXeutYMkizP2k
         iUXOeCRTtCSqYyrOZ68bg3pQgGdg+1pmTJQRr7OMd358+b6Bfexp2XW8v6OX1ruZjAhc
         ZKFlgtd9Pv+yfozj/9k48FKZNzpBpDkhV/r45VVl538Yoidj0oI9T0LaA3RtFEebC8EJ
         SZ2OdMJWlmAyCLq8xGKgCJ7SwxCynHv4eF7sJpdzv2z5ls/+qSKkCbJfXqvbYlluMgXQ
         jsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739311262; x=1739916062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH0GdYMy8pz+jJrNXKtFU7Jsn2P+rBGG1+in1lbsGGI=;
        b=Ag57nUkUa4zA7ia8A0Q8PIw1jmplsGVQiqG7b2ZpdjEPRrL8VjMclXcZAxagSR0sXS
         LProb0QOoRI1ux21dH8C7SxbqrvdyTVILNKX65lsbWUN/EDTK+GOXw+0dnOsrP/zb61f
         Zb7X3LmR0004mGQQmpA+XmFDoWR4yR85/of8gy9q3XzGEcJfBRBZXlq9RFchjIH9g4de
         eRQV8OQ9iBHmoSIH0VPQrdwF96N+8BkJOn6Z/7PSJB74jb/nKLV2+O6jnmwS0H9wVyb/
         4jOUv4W4pfBH3+lIHcre3mb3mAalZCFS73hOJ6NB2SNZp2htyjTdJMRArpVYEeUrnLo+
         PYwA==
X-Forwarded-Encrypted: i=1; AJvYcCUVNObEUp8HwqKLI8C0aTLKlqUnhPCtlvv40gCu+44LVHL/YDNAj51XaPoJlCXbxBhjFY9op9rcWtEo+yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywBmEVStYshXhZfrILwLwPdDsQviCothabfiwkuAbK6DOk+Y8R
	P1VN4uwE0AWXJ1UmsSGk3PRgD5pO8yAwixvcdxVvPmsdoO/PJaEySmEoZcIqf1z8ggCRwfRT9KI
	+LCeOPjZmDiMwDknZourjUH9ytDM=
X-Gm-Gg: ASbGnctEM1rvQ02PeEXB+PmBhNC2G8QBqt6oH6uEBQjXoLNb0tf2Y6tl8lijdqnp5mp
	Ie7bxt0OrL3SNHJfqB6hIcaigMbP8jgkcIXo7jCwURUVqSHGjW9kTUrj8O8bblYE/49hg+x45bQ
	==
X-Google-Smtp-Source: AGHT+IHzCAtMKaVIdmyqVtpg7GiB7UO6jzPNX/gawtcEZqDckoCITjFsdc8OQza+K+ZBqvia2Qn/1A+0GbvUz2Gtvjg=
X-Received: by 2002:a05:651c:1b11:b0:300:3bcd:8d05 with SMTP id
 38308e7fff4ca-30904ffcd24mr1219661fa.15.1739311261863; Tue, 11 Feb 2025
 14:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250210103244.646150-1-chharry@google.com> <CABBYNZJ1LbN_3H1pJsZ6mH1nY7ijb9nbuPSJJwqyvJnC0=U6PQ@mail.gmail.com>
 <CADg1FFe1DeDFmudxWZp3_thvTnm1N=ZOjXts0sJ7mxaUsFxE5Q@mail.gmail.com>
In-Reply-To: <CADg1FFe1DeDFmudxWZp3_thvTnm1N=ZOjXts0sJ7mxaUsFxE5Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Feb 2025 17:00:49 -0500
X-Gm-Features: AWEUYZnpY4Kq3DoNYOptzkzGa5JZEwFH7EJ3zIsQ9bxSY0Qtmw_qyh_q-k8KCg8
Message-ID: <CABBYNZK8-8k5eZ8TZLM-g4KC_wt8VQ+jx_iryS9_xGxHt+u=1g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org, 
	Ying Hsu <yinghsu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Mon, Feb 10, 2025 at 11:23=E2=80=AFPM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> Hi Luiz,
>
> Thanks for the feedback.
>
> On Tue, Feb 11, 2025 at 2:17=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hsin-chen,
> >
> > On Mon, Feb 10, 2025 at 5:32=E2=80=AFAM Hsin-chen Chuang <chharry@googl=
e.com> wrote:
> > >
> > > From: Hsin-chen Chuang <chharry@chromium.org>
> > >
> > > The functionality was completed in commit 5e5c3898ef49 ("Bluetooth: F=
ix
> > > possible race with userspace of sysfs isoc_alt")
> > >
> > > Fixes: 5e5c3898ef49 ("Bluetooth: Fix possible race with userspace of =
sysfs isoc_alt")
> > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  Documentation/ABI/stable/sysfs-class-bluetooth | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documen=
tation/ABI/stable/sysfs-class-bluetooth
> > > index 36be02471174..1168e0318e35 100644
> > > --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> > > +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> > > @@ -7,3 +7,15 @@ Description:   This write-only attribute allows user=
s to trigger the vendor reset
> > >                 The reset may or may not be done through the device t=
ransport
> > >                 (e.g., UART/USB), and can also be done through an out=
-of-band
> > >                 approach such as GPIO.
> > > +
> > > +What:          /sys/class/bluetooth/hci<index>/isoc_alt
> > > +Date:          10-Feb-2025
> > > +KernelVersion: 6.13
> > > +Contact:       linux-bluetooth@vger.kernel.org
> > > +Description:   This attribute allows users to configure the USB Alte=
rnate setting
> > > +               for the specific HCI device. Reading this attribute r=
eturns the
> > > +               current setting, and writing any supported numbers wo=
uld change
> > > +               the setting. See the USB Alternate setting definition=
 in Bluetooth
> > > +               core spec 5, vol 4, part B, table 2.1.
> > > +               If the data is not a valid number, the write fails wi=
th -EINVAL.
> > > +               The other failures are vendor specific.
> >
> > Still not really convinced this is the right way to expose it, it is
> > not an HCI attribute to begin with, not sure if we couldn't perhaps
>
> Could you tell more about why this is not an HCI attr to begin with?
> The alt setting is bonded to the USB device which is now under btusb's
> control, and btusb creates a sysfs node for this. This attr location
> decision seems natural to me.

Well alt setting is (obviously) not covered as part of HCI
specification, USB is one possible transport bus of HCI, but that
itself is already saying that we would be mixing the transport with
actual HCI protocol.

> > add another node to control it or add via USB device?
>
> I feel allowing this in the USB sysfs API might be an overkill as that
> makes all USB devices' alt settings be controllable from the user
> space. Limiting this usage in the scope of BT makes more sense to me.

Not all, just btusb ones, that said what we could add another level to
control transport specific attribute e.g
/sys/class/bluetooth/usb#/isoc_alt than that becomes the parent of
/sys/class/bluetooth/hci<index>

> >
> > --
> > Luiz Augusto von Dentz
>
> --
> Best Regards,
> Hsin-chen



--=20
Luiz Augusto von Dentz
