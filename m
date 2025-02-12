Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF797271834
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335740; cv=none; b=LIsG/wqISZmC6ZhNTtyndl/vrGuP8T4IRMdwyGFsd49JBvvgLnBtabmrbEa6dacC0b/MSksFYiP7fsLKZa2OxhNT1uk0NDlcybGFMr4MC5OksrEn3Wgkpnyj30vHaQhxlCYKNFygTILf+WVlL8jVU+Hxo3UYuwiGy7dzeATWeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335740; c=relaxed/simple;
	bh=K4goNeS5jx9vOeqxSj6nPJuEvuvWZ7J5t9DWFPlyReg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3Tt70XiGuZwEbb5fYi2vPharN+J2r585LyZl6utrnv/bPBjof+r6DH+pHW1D7FQ21XZcg1pTi7jLFWsK6hj1Lo49qy6c9Fj14HxY+Y/R8bccjAf2XsnwMg7LrtSq95yqxPQ3TqK/fwhSRa4S0w1ByGBg/PVQIVsZ0LbyHDxr34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0lMFWp1T; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0lMFWp1T"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e461015fbd4so4960733276.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 20:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739335736; x=1739940536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4vbUZUTkpqr3rG0okFJsZLaxVBB5/ZaX+q2Q50aqnk=;
        b=0lMFWp1TdCwacy3kz8YACkjR08+KWkzayCjpXQiLuW7PpJ2hDYLa50UZQfwraf6moE
         rnlD7L9haNaWJhbGxgwJNxFfCvVO2TJ1vNboLSwhP+Slca/akeQHgEya9dbPIkdeA3U9
         A0zB111syKdCiqXtcBQ20FCUkCnrTrudRzgapGoPPD6ktzrhZGAn0rU546xy/BcddT9W
         mVaVTGQ4UAuPkaUWNO2zRlhp7lbScglv9XjSpg5fYDUHp8lyadvahiGDXhBoksdlZbna
         eiAY7xqw/Bj25wdHIB/TZZH3sH5E2tQdx8K5jIPRdYJ3fwih749XirhQD9Wtd/mchSqv
         le0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739335736; x=1739940536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4vbUZUTkpqr3rG0okFJsZLaxVBB5/ZaX+q2Q50aqnk=;
        b=eRm4GheT8npaEUPQWcB+LFYHv/IhbgIMSXftsTpfkbij4jep8kN/HG09atKK9XWM4t
         pYxHiTnbqE4afTFkQMhFl0smsR+OOslhcZXzz/cXungIl9UWZ7VtlbfBTeVA8JxEPAJ7
         OQ9JgLDdKpDD24JrFfGrh2r3rGRqUiA0EnSYWzY4PlDwkYqRWwbAOpCnbAk3OpX40A0r
         WFsEPC/lFS1DFtkSDnN4iAWGqCBHWlPkX+9b0Wa7WFwu8hxG5okS3/DwY9nzj9q9waMx
         kl40zyGZ0QALVFR7bL0wr+yyCTEd8B/C+NZgXcq3ILroJY7JZrtaITTNoC2+v2rDSwJf
         Axdw==
X-Gm-Message-State: AOJu0YxcF5YkZPHSd3/XmqGzzJJGk8oKfU6RDMq+e5WXlmRJJEELYHxM
	mOQqAAl1wfOpL9tQSd8/Mym4SI0NLZKyHrR8TezjCIfKVctkZu4CDn0mQy6B5mebor6527Mw5ZU
	uZEmFJhlmqoADiBEz04f67yuLT+WrWTjLZuN0
X-Gm-Gg: ASbGncvAKwl0jeSz30zG8Xbor+D4zjEynCKL77WoSeDkceDwjpONT1GI+kVnR2VO/rZ
	fmWKptDdeAGywRw797A0W6X849VHVqvAPUMD3o0x0jVAM/90G7btV73FK4cyqdt8eaDicWGjGvA
	==
X-Google-Smtp-Source: AGHT+IE5Xh1/6K2tzqDbm+0FgeX0MVlUKWJGOy0qo7qYqOw3FVUwjaXyDF+x/vvLQfzMSijU6o6iB9CfCXWL7WTL7BE=
X-Received: by 2002:a05:6902:2d08:b0:e58:173e:abcc with SMTP id
 3f1490d57ef6-e5d9f0d2103mr1847516276.8.1739335736473; Tue, 11 Feb 2025
 20:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250210103244.646150-1-chharry@google.com> <CABBYNZJ1LbN_3H1pJsZ6mH1nY7ijb9nbuPSJJwqyvJnC0=U6PQ@mail.gmail.com>
 <CADg1FFe1DeDFmudxWZp3_thvTnm1N=ZOjXts0sJ7mxaUsFxE5Q@mail.gmail.com> <CABBYNZK8-8k5eZ8TZLM-g4KC_wt8VQ+jx_iryS9_xGxHt+u=1g@mail.gmail.com>
In-Reply-To: <CABBYNZK8-8k5eZ8TZLM-g4KC_wt8VQ+jx_iryS9_xGxHt+u=1g@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Wed, 12 Feb 2025 12:48:29 +0800
X-Gm-Features: AWEUYZk8ctHJOT5ECfu-lAdE4F3G2Nsn_DGEWQAHoeAfkXDpGisSwXscNHVUMjw
Message-ID: <CADg1FFcsYSM2SsyYULBzqmML67+4Hx9ipemACOv_oLCrwweiWg@mail.gmail.com>
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

Thanks, that makes sense to me. I'll resolve this comment in the next versi=
on.

On Wed, Feb 12, 2025 at 6:01=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Mon, Feb 10, 2025 at 11:23=E2=80=AFPM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > Hi Luiz,
> >
> > Thanks for the feedback.
> >
> > On Tue, Feb 11, 2025 at 2:17=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hsin-chen,
> > >
> > > On Mon, Feb 10, 2025 at 5:32=E2=80=AFAM Hsin-chen Chuang <chharry@goo=
gle.com> wrote:
> > > >
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > The functionality was completed in commit 5e5c3898ef49 ("Bluetooth:=
 Fix
> > > > possible race with userspace of sysfs isoc_alt")
> > > >
> > > > Fixes: 5e5c3898ef49 ("Bluetooth: Fix possible race with userspace o=
f sysfs isoc_alt")
> > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  Documentation/ABI/stable/sysfs-class-bluetooth | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Docum=
entation/ABI/stable/sysfs-class-bluetooth
> > > > index 36be02471174..1168e0318e35 100644
> > > > --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> > > > +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> > > > @@ -7,3 +7,15 @@ Description:   This write-only attribute allows us=
ers to trigger the vendor reset
> > > >                 The reset may or may not be done through the device=
 transport
> > > >                 (e.g., UART/USB), and can also be done through an o=
ut-of-band
> > > >                 approach such as GPIO.
> > > > +
> > > > +What:          /sys/class/bluetooth/hci<index>/isoc_alt
> > > > +Date:          10-Feb-2025
> > > > +KernelVersion: 6.13
> > > > +Contact:       linux-bluetooth@vger.kernel.org
> > > > +Description:   This attribute allows users to configure the USB Al=
ternate setting
> > > > +               for the specific HCI device. Reading this attribute=
 returns the
> > > > +               current setting, and writing any supported numbers =
would change
> > > > +               the setting. See the USB Alternate setting definiti=
on in Bluetooth
> > > > +               core spec 5, vol 4, part B, table 2.1.
> > > > +               If the data is not a valid number, the write fails =
with -EINVAL.
> > > > +               The other failures are vendor specific.
> > >
> > > Still not really convinced this is the right way to expose it, it is
> > > not an HCI attribute to begin with, not sure if we couldn't perhaps
> >
> > Could you tell more about why this is not an HCI attr to begin with?
> > The alt setting is bonded to the USB device which is now under btusb's
> > control, and btusb creates a sysfs node for this. This attr location
> > decision seems natural to me.
>
> Well alt setting is (obviously) not covered as part of HCI
> specification, USB is one possible transport bus of HCI, but that
> itself is already saying that we would be mixing the transport with
> actual HCI protocol.
>
> > > add another node to control it or add via USB device?
> >
> > I feel allowing this in the USB sysfs API might be an overkill as that
> > makes all USB devices' alt settings be controllable from the user
> > space. Limiting this usage in the scope of BT makes more sense to me.
>
> Not all, just btusb ones, that said what we could add another level to
> control transport specific attribute e.g
> /sys/class/bluetooth/usb#/isoc_alt than that becomes the parent of
> /sys/class/bluetooth/hci<index>
>
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > --
> > Best Regards,
> > Hsin-chen
>
>
>
> --
> Luiz Augusto von Dentz
