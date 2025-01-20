Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152C7E1
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737362975; cv=none; b=SAt9/0FvCfUbjJpMvscH6dBXv0TZs6qxrEbMt0srNQ8oQk/SplkogSljZVtj0FGhB/pZZI49nn1xmQ3vncLWRuRDx7MUzSAK7dqZFDGMvpgLgi5oiS2RsUAWqNPxs9Kw0o1spKWAmktT99bC2vy2THd4mih+IAjecC9UEoLyFbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737362975; c=relaxed/simple;
	bh=QZReFX1cK9W7jNnFJd7EJeGwqzMmvu9g08Vf3KEyAGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgdYO7Me0RCXgfHX4OV7xKLGIlHO13TJJ8HXIBKvTqn/t2IDmw3upyNfgGIaBmkWL8vbvK+2whJ+iDxA9OUkusmYQz+sqopB8sh7iN5NKTX+JADrLkvqYBr1kQzeNNjFUnh8rnYnK9D4rgfvREkuEiaK3WH5Jq/uS0ypE9t0qfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VI9T6b3N; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VI9T6b3N"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so6324309276.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 00:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737362973; x=1737967773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YiK6Kfuudtbwvi3s3oPbXeHhqsN4fI2a9MZKoJavfc=;
        b=VI9T6b3No2JmW4XOtGP5merzo0dR3+vHxtmy6iSYtDsdp4Py7zXGeIAYwte9OPJv4o
         25Zm+T21tld1VgStxdg2w2javGtX+mHlVPMyyEbmLYpIDMa8amO02QPY8+eWama7iiMn
         3j3bIQeX7+8gkbWXK3edYYOpLljcdHBwAFmaaN8rFxod9WYnROxZjMwrwrARPDyeT+0Q
         xRTLFw9zIKtRN5vTHbLRETjhAL+HrCB3oVqEhkl2bdm9MZZkZR/AT+LdAw/ACTs5j5/X
         BsMsawsiY5D3hyRMt24XjOaVIkkvMrtmqTK3C7DOWHQbIXyU9WmC0Dz4fVN+4BX0GOqJ
         II+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737362973; x=1737967773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YiK6Kfuudtbwvi3s3oPbXeHhqsN4fI2a9MZKoJavfc=;
        b=tKOYnN0dRBzngqG+9ohaa9TX9CyNXzCpGGnSlNEca1TpL5gemqSW6dpSQzQLbIcIRs
         U5deECw1MO18SSqfelZG8tuQKNAsyVhIU2IF9HG+a+RyBSVOgUoewpkSE/MvmVe8fyKR
         yCUK/Y1klxh5XCJmsFBO2czSVcXATKjmXZzQgcPWfK+C6fiTLDY5DABwuA0c52tM1y7r
         6VPGFKD0jQcbiKzZr67l8iyfIaFOA4cuYhK3+QJKveNrJUBL2bI5CWZcpv9tKAtsSxbI
         drITT2ZCYUjtzrwahYitqok8nRaixvBEdeqJhO9eOnSXln1qIA40JaNoh99rjTpnj9Tq
         z1Ww==
X-Gm-Message-State: AOJu0YwLnGCo1kuJ/s2p4bE9YXZyU10AvN6fj0k2QOiFRRLMc03SkS5E
	i5OWyvQJfO4kYDdiLru1OZavxPetQ9BBXh5hwv2DeoRju4EZb6cghZbAC2zstAklcB2XfyPebeZ
	AIznV/rYo960qsis+h1X9/YXxKEgMiqrv4jbC
X-Gm-Gg: ASbGncsknKyJSqVDDJEWWLfhUzHAWrpwshkAzvazOmQ/XJYsqawoT008BouWw6MvTSY
	tNRG4CnIkqjgBF9szpNOhKOdQAWTBC90HCjKXait8dMPK3s9KXFHOxsTr6l3nM90=
X-Google-Smtp-Source: AGHT+IHcoblwxqBRfjIv0Q4aPxQRu6LXqAfaCFMjBRWtirRIYNxpOErSdlv8bHousCcHd6Qnkus/0LDpWDtKVO5o+B8=
X-Received: by 2002:a05:6902:20c4:b0:e56:c350:5973 with SMTP id
 3f1490d57ef6-e57b1349f96mr7956459276.45.1737362973080; Mon, 20 Jan 2025
 00:49:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120162456.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
 <0ad410cf-f4f1-4519-96fe-9a2a07865963@molgen.mpg.de>
In-Reply-To: <0ad410cf-f4f1-4519-96fe-9a2a07865963@molgen.mpg.de>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 20 Jan 2025 16:49:06 +0800
X-Gm-Features: AbW1kvZjdTGzWdf64o_OXrufLq5M5mhxi6Q1_gnX2Hh9NpLTWiyLTTOZ-h46TmA
Message-ID: <CADg1FFdre243fQ595vkFVRxKUsK9L9NmK_EqZ6kCQS5jSQJQ2w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add ABI doc for sysfs reset
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Thanks for the quick response. I have uploaded the v2 patch, thanks.


On Mon, Jan 20, 2025 at 4:32=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Hsin-chen,
>
>
> Thank you for your patch.
>
>
> Am 20.01.25 um 09:24 schrieb Hsin-chen Chuang:
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > The functionality was implemented in commit 0f8a00137411 ("Bluetooth:
> > Allow reset via sysfs")
>
> Add a Fixes: tag?
>
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> >   Documentation/ABI/stable/sysfs-class-bluetooth | 9 +++++++++
> >   MAINTAINERS                                    | 1 +
> >   2 files changed, 10 insertions(+)
> >   create mode 100644 Documentation/ABI/stable/sysfs-class-bluetooth
> >
> > diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documenta=
tion/ABI/stable/sysfs-class-bluetooth
> > new file mode 100644
> > index 000000000000..e794ce706582
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> > @@ -0,0 +1,9 @@
> > +What:                /sys/class/bluetooth/hci<index>/reset
> > +Date:                14-Jan-2025
> > +KernelVersion:       6.13
> > +Contact:     linux-bluetooth@vger.kernel.org
> > +Description:         This write-only attribute allows users to trigger=
 the vendor reset
> > +             method on the Bluetooth device when an arbitrary data is =
written.
>
> *data* is plural, so =E2=80=9Cwhen arbitrary data is written=E2=80=9D?
>
> > +             The reset may or may not be done through the device trans=
port
> > +             (e.g., UART/USB), and can through an out-of-band approach=
 such as
>
> =E2=80=A6, and can *also be done* through =E2=80=A6
>
> > +             GPIO.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 797e94ba74f7..e949c3ac7846 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4058,6 +4058,7 @@ S:      Supported
> >   W:  http://www.bluez.org/
> >   T:  git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth.git
> >   T:  git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth-next.git
> > +F:   Documentation/ABI/stable/sysfs-class-bluetooth
> >   F:  include/net/bluetooth/
> >   F:  net/bluetooth/
> >
>
>
> Kind regards,
>
> Paul

--=20
Best Regards,
Hsin-chen
