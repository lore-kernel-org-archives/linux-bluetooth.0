Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB8354706
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654646; cv=none; b=sLGCFVkyOugkiGUO8NwgAd3gkT2714uLEm/0jle1STJSAIkkXMVO/aMnSy6zvcGOqA7Zk8yOi1QsxAYeggPeqz98EXIscFBFuELxUm+hOGg7OFj1cVN6rTtHrXUzdjWAxshbeGKl2vrhs3WDGDLmNlB+x7SdnAIapT0LSPcnn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654646; c=relaxed/simple;
	bh=Qb9ji47YdqM6JQH3Sq66VuJDGcwTvIOYKKH+WPKDmE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghMy6E2zoswKEV1OzLLNz/TcLRu6Yg2fhDzXdX7xb0zTtG+R3D/DSfgprd6VsREXmZht5M/3AwC+tzeywJzkl3iZ4hYt/MLbL65xRBpEHNBCvT6ASdDldlqe7mqRYMoebec7ueUFKHsoCENyQSASaXfsJuuhNp3nvjcCF0e/qJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D61RJZ2+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D61RJZ2+"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so1595964a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763654640; x=1764259440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KFVSiRsFKVCEm70VbQUdMygEFtu/siEtryQmrUxVK4=;
        b=D61RJZ2+4DShh+qqQhy4cd0jCVPrMT5tN1qz7P/2p45xT1jqpLSneLncEhrNv/AKFS
         Gdk57udSiYtPrLql0k554XR5IIrGOr7r0Rml7fhk5sEtIUTPqJLVtcjgkTLEQ8XZjI12
         qgmQrGk0yMi0XmCvUNXfgcn0QvVxNm1uZ0Mks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654640; x=1764259440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KFVSiRsFKVCEm70VbQUdMygEFtu/siEtryQmrUxVK4=;
        b=LvnnK8dKxwx30h9JtSyBp97YYg5sKRCKH7jM+CzeRzKOjs2KN5FP48rvdcj8+hQ8ws
         g396LtUgCR4INf3W5ZbtlCKNs2LdASk7Ghzau9GxuLyyr/NSo5rMDfsbzimlIWu8mCFD
         7N8wauCNO1y353++vASubMPmCFsM5pTON+air1hGMVy/Cj+bA6SBak2XWpMYs8yZvhhx
         KqFp7J3HFZsZ3f9xi9A8Ns2nlcmDjkRiVgC/b7lLjRGnkaTnMDh3xz7K+FI2Izhshfjv
         hIBN/QNOWr0I4l3Md5ORpZJggUhlv6Dz5FOmC3xXJq/Ne2iJGQ0uc5ONv1Cgh2elw9yK
         YOng==
X-Forwarded-Encrypted: i=1; AJvYcCW3ENUNbI2l/g3QJUMhftogUdbB8AEHjLkHJbYxFxdU0pk/fR+xjAMbWtjpqrp0goCEu5MZoa3iN2m9nmxf+Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXT3yD8Gs5YSpx9iqhV/CUHZMxV/h387l8t918hVQJUQ8Ery1
	ceNTJM0tPUtHFxNnNhMf7u2kDkEDE7cjI+p4W1IkWO2Ox3lgOJWftmA2cjsxQ5Uj2Ei76ZnGKC+
	MEnjAQ1pP
X-Gm-Gg: ASbGncuUnbSXRCEorZpsqeoOzvjFy0CmyL/fXNIUFpHu4TBHjs01KCbBQ09Au/Gwo7l
	yP/cIJq8T/xnuZ3a1yxmmXgHs0UJj6EgREM6dcPL0MyBwWUaRx0A9tx4NoUZJ9rTSclCbNj2U1w
	BDZ5XYeilYIfi/MMFWPaTvXr7sRtQhzEyMnT8q+7JC4VytvxQVPx+ZpDp1tPZindWmjuN7CVNfg
	f1pft+E5B1lnZBu91aS63UWrPDQm+y+Lt5qsZz0a4GYH07Polwxms4YKIQkSg3Fd66uVSFlXTDj
	elCihr+pnxi/KbviLITYvufuUl7dvYEisnZwEYE7fD7xQe4e8ACaGHOmkzv00UJoIswK6JJaYy/
	Nvt4CvvGIOSDSbxFGA5670QHq0J4TApGqjYUQXgfVK0WHxs2CBI5u1vUspOedIMiF5muVigqKRh
	r5reb9Bm/CTS5tsQttUkMdw2Ow26iMRinGmMeu0i9UybFHVT2MNQ==
X-Google-Smtp-Source: AGHT+IEOcCtFBnXNlf67DqBedoE9KNRO3qh4TEyc05Xg2hmrXl0rqrIdbUGup8Lxkz810yHOin+PFQ==
X-Received: by 2002:a05:6402:27d1:b0:641:78b7:d326 with SMTP id 4fb4d7f45d1cf-64536450c90mr3500910a12.28.1763654639273;
        Thu, 20 Nov 2025 08:03:59 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d3e1sm2322728a12.18.2025.11.20.08.03.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 08:03:57 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso1830269a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 08:03:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfh5JiGIliJnO2E3eyTHyux8oZKN1Bhg0nEypvAGRhIn8aXrZlyjaYYBhUdWXreSFvkeJv+kZJjtG75u4RiH4=@vger.kernel.org
X-Received: by 2002:a17:907:3f2a:b0:b73:82df:7a3 with SMTP id
 a640c23a62f3a-b7654dfdf85mr459822666b.20.1763654636786; Thu, 20 Nov 2025
 08:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
 <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info> <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com>
 <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me>
 <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com>
 <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me>
 <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com>
 <5vLxmZlxKXfznaWPi2ndxyj90dJN1FML_fINz027uaJP2rZK_nQu_41m7WA7Gnc1yy_XLw8KMWF18Y_keW-qKjHy0BBOQl0A92QiY7Kg004=@proton.me>
 <CAD=FV=WRYYYB+G4-7y7uVR8QCEEMp2iRfmtsAa29UfyNCVD=4Q@mail.gmail.com> <YrzH4CVQLf1BjCQDuWEnQ5oxWGrsTge_CHmEViJEDklOFwbMEylpl2KnmeiG1EgCm62OKNFG1JRu_b2bOVUbZZOZQwcSNHbUO1gR1GiN1rI=@proton.me>
In-Reply-To: <YrzH4CVQLf1BjCQDuWEnQ5oxWGrsTge_CHmEViJEDklOFwbMEylpl2KnmeiG1EgCm62OKNFG1JRu_b2bOVUbZZOZQwcSNHbUO1gR1GiN1rI=@proton.me>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Nov 2025 08:03:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XUFEMAuLiFUR7pvPsWJP=_A=6=UGrFX9mobTV1M0gN=w@mail.gmail.com>
X-Gm-Features: AWmQ_bmns0n46-hrBsBm11ElrwzJB-TB74eWjZFHpGOhpLoxviwv1q2qGLIXbGU
Message-ID: <CAD=FV=XUFEMAuLiFUR7pvPsWJP=_A=6=UGrFX9mobTV1M0gN=w@mail.gmail.com>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized
 since v6.13.2
To: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, 
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 20, 2025 at 2:14=E2=80=AFAM <incogcyberpunk@proton.me> wrote:
>
>
> On Thursday, November 20th, 2025 at 12:16 PM <dianders@chromium.org> wrot=
e:
> > In 6.13.1, the following could happen:
> >
> > 1. We'd be running btusb_mtk_setup()
> >
> > 2. In btusb_mtk_setup(), we'd run:
> >   btmtk_data->isopkt_intf =3D usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM=
)
> >
> > 3. If usb_ifnum_to_if() returned NULL, "btmtk_data->isopkt_intf" would =
be NULL.
> >
> > 4. Next, btusb_mtk_setup() would call btusb_mtk_claim_iso_intf().
> >
> > 5. btusb_mtk_claim_iso_intf() would pass "btmtk_data->isopkt_intf"
> > (NULL) to usb_driver_claim_interface() as "iface".
> >
> > 6. usb_driver_claim_interface() would see that its parameter "iface"
> > is NULL and would return an error.
> >
> > 7. btusb_mtk_claim_iso_intf() would notice the error, print "Failed to
> > claim iso interface: %d", and return.
> >
> >
> > In 6.13.2 after commit e9087e828827 ("Bluetooth: btusb: mediatek: Add
> > locks for usb_driver_claim_interface()"), we'd add in this step after
> > step 4:
> >
> > 4.5 btusb_mtk_claim_iso_intf() would call:
> >   device_lock(&btmtk_data->isopkt_intf->dev);
> >
> > If "btmtk_data->isopkt_intf" is NULL, this is the same as
> > "&(NULL->dev)", so we'd pass a number that's very close to NULL in as
> > the dev pointer. Then device_lock() would try to dereference that and
> > crash.
>
>
> Sorry for the lack of knowledge on my part, but could you provide insight=
s as how the bluetooth was functioning wihout errors in 6.13.1 :
>
> 1. Is it because there was no device_lock() checks in 6.13.1 and is becau=
se of the newly added `device_lock()` added on 6.13.2 ?
> 2. Is it because there was `device_lock()` in 6.13.1 that despite being p=
rovided a NULL pointer,`device_lock()` could dereference and the bluetooth =
adapter would turn on BUT in 6.13.2 , `device_lock()` would be provided a n=
umber close to NULL which could not be dereferenced and hence the bluetooth=
 adapter wouldn't turn on ?

Right. There was no "device_lock()" checks in 6.13.1. The lack of
"device_lock()" caused a different kind of crash (sometimes), which is
why I added it. ...but I missed that we need to check for NULL before
calling device_lock().

-Doug
