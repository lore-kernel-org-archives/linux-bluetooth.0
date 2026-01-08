Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C2A86347
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885745; cv=none; b=TfYgnkDxtXsNxA2YyOLmKKkkbeyy25T6OUKy0WOO8jB1oDOHpzOypbXhmIsZaGBA+TfqU/NUP/1JXmArV4oowC+G4xoqTVkT/85HM7Eir9BD23/fLVWsobW8+hoJbO5v4GUXru8N1ESLGID0eDqso5Ku498r/5AI5xTmWPCZ9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885745; c=relaxed/simple;
	bh=ELsBd5ylv33lMqvy+hEWDOsky2gZq+7ygyp2EwWV/4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xba0P/Aecvjgsvk+oU4zxDGvwEJVJkAIEw046KH7x2wtP0dJk0POAZ4CtLzKpHvYqhwXqVa3EyuzVyxXyRTJ9xyZwUdlZkkJ0gWLapaglzBuYlnaK+ck/1UhJxZVJnvpGPH4d0+CnD247XF+713kKYSULY8M7Dw4tf8MsjraPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai+8WHvq; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai+8WHvq"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-790b7b3e581so30470397b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 07:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767885743; x=1768490543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ubv1cC/wetHyZTxz0TlMz0v8CxYB1pjALJuv1zH90g=;
        b=ai+8WHvqI4mBK935S3JDMb0OanZ8UmTg1Ufk37CDSNUGmtu5s+iR+kWPye9tM6R+V8
         4NSSUZsmZg97+tc2LarQtfOT2xpEqnVmA8wv5n41Gv4HVmPqI+MDkE96VdbaI2xDPwjt
         II/0rtNY3bDqNubhIeaKoDJPSMlMBPJ8hsMnufeaq4DnrgyfL/DQHPid79qzLN1+9nkT
         7O57FLh6k6p9r9EUHQqLZ4rUuoeZSjPekjpkbJEzuMQDHibkOpUxwqInc7NQnbhUHpWL
         69VFwIyOPBmRoE6BUG57p30g/a/KHcSwEuOFgT/JEvV18OAPjPBAOr7O2NZJBz1GrgrQ
         wkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885743; x=1768490543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ubv1cC/wetHyZTxz0TlMz0v8CxYB1pjALJuv1zH90g=;
        b=BtMYVnMTtL4ZT96D8bxYgaoZ4j9qwJy7PUThhp3ayBBZNZ1EzvJJ6H5bPx8MsyIUsC
         93t5nU1gEvgxjI3PSU56stXPJ0FLR7VHiKqou3tWnU7OGR+9U6kKJNBczecBqM98HG4G
         7Ymaemccliw8d7B/9wMDgvSgnlFPm0oH1dtGnk5TkvJqbjzR+2WrLsDkkB8WorKMaUQC
         wOPCsrR6IPKSLVFxKA0aNPvXWSOr1csbkkeOHthdIHLLCFuI9XCXqnuUGn3hUnW2Zqx+
         cvl5mMWeYv1POyEhnzqTRQGqPeZSbTFMSAbJZCDiVHELXnenTEH0yvpTFONyQr3PG6Gb
         6h7A==
X-Forwarded-Encrypted: i=1; AJvYcCVIlrXS0UMOONpulSKyznTyqH3cjSM7pjIc/iCTZOIX/yr8U3QSY/xOVciBh9li0Ay0hse7oplM500xptWXKN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKeoCbl8MeBjThl5yTOCdxIhmRJoCEPqZs01ePkVLRlczXnzS1
	Ge1AF8l1UE0dAHj7vnelaIV2SD0SIjbhUbCl8fQ/g5aXrD7oPht1L1DEoawqoPvxJ2gq10NtxrE
	lSyVoG/o+LxLLVf0F2YrTWqPpEVDyjxCfrIKx
X-Gm-Gg: AY/fxX6ahOJ7yNQIGiKvCRjrGFruJ40bX4ePDRu1Hg/bFPv3kBwLrhKwn0bKeZwf3VQ
	F5gRPqW/n00NPwkO7QeGRogA4vETsGgJXYAouXkJvJQl+ToNnd4QUXyInZeOnY/aa7hfF5oVBnI
	2oc5orXkxMv59FDVrB1TkQvHAzmKsB7QK8X4dPt6smxN3Zh5vmVjejehyo3iK7+G37RMMU2l4Ux
	xj1lRPa8RWboXNZYk87EpLXQ+4GfempbQrPwatK6LdBYwHqOtIaW3nokcnMNTWhq4ZnzOtPCpXW
	m7XnQiS4cbL0hSDrNHSTNP1jQSmECf4w8E2VQ5BGWyuJqLgfEvBvEgt4dQ==
X-Google-Smtp-Source: AGHT+IH9qGa3lpodqLWP0JxS8mqmxVJBktZSar5s78Hg8U1ffRAZmV7FymDwhHiGTzZqHJZY/0d8/1PNJxJU1mONU6c=
X-Received: by 2002:a05:690e:140d:b0:644:50c7:a50a with SMTP id
 956f58d0204a3-6470d2f3e09mr8799232d50.32.1767885743449; Thu, 08 Jan 2026
 07:22:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+Zq2HYsfGbOi7V=pnV1GczSv6--rMEbi+=yCXE4p+-6g@mail.gmail.com>
 <20260108020633.1729637-1-lilinmao@kylinos.cn> <19c219ec-a4a2-45a1-b50c-db42fb6db4be@kylinos.cn>
In-Reply-To: <19c219ec-a4a2-45a1-b50c-db42fb6db4be@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Jan 2026 10:22:12 -0500
X-Gm-Features: AQt7F2rikSMfkpaYfUDePUUN5QrfAlswNGlT70OKL10pf3VsVRrBYSPReiskwJc
Message-ID: <CABBYNZJR9SB4EAMi5C0bf-ezMSa0rt02W8zVM0ypBwrqqxcPuQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Reject autosuspend if discovery is active
To: Linmao Li <lilinmao@kylinos.cn>
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linmao,

On Wed, Jan 7, 2026 at 9:53=E2=80=AFPM Linmao Li <lilinmao@kylinos.cn> wrot=
e:
>
> =E5=9C=A8 2026/1/8 10:06, Linmao Li =E5=86=99=E9=81=93:
>
> > If USB autosuspend occurs while discovery is active, the ongoing
> > HCI operation may not complete successfully. On some devices, this
> > can leave discovery.state stuck in DISCOVERY_FINDING.
> >
> > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> > ---
> >   drivers/bluetooth/btusb.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index ded09e94d296..565e276be3b2 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -4469,10 +4469,11 @@ static int btusb_suspend(struct usb_interface *=
intf, pm_message_t message)
> >
> >       BT_DBG("intf %p", intf);
> >
> > -     /* Don't auto-suspend if there are connections; external suspend =
calls
> > -      * shall never fail.
> > +     /* Don't auto-suspend if there are connections or discovery in
> > +      * progress; external suspend calls shall never fail.
> >        */
> > -     if (PMSG_IS_AUTO(message) && hci_conn_count(data->hdev))
> > +     if (PMSG_IS_AUTO(message) &&
> > +         (hci_conn_count(data->hdev) || hci_discovery_active(data->hde=
v)))
> >               return -EBUSY;
> >
> >       if (data->suspend_count++)
> Hi Luiz,
>
> I found that hci_discovery_active() is not exported, so btusb as a
> module cannot use it:
>
> ERROR: modpost: "hci_discovery_active" [drivers/bluetooth/btusb.ko]
> undefined!
>
> Should I send a separate patch to export hci_discovery_active(), or
> revert to v1 using test_bit(HCI_INQUIRY) and hci_dev_test_flag(HCI_LE_SCA=
N)?

Just add a patch exporting it.

--=20
Luiz Augusto von Dentz
