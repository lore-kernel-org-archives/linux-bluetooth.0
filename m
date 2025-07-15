Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B052561AE
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584714; cv=none; b=jVQL6gYlTCKteoR9fdjjR2Swi+PUE9vVj5g/BHONX6yZiF8hklJ/iVerDvjm+Rd4GfLPooHfri5d6N2Uh8M6arXfDAGP352sfQmG+4eW+9UUpKscYZCM8F+SRe2CwCy7MLBLTYMhygVaTdVOTCy3kg3MnBROfrC1u08Uked7pts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584714; c=relaxed/simple;
	bh=TkRO9Lw1KYkQlcdDcIdO4cxBWjQtpyRV7Bxj58Ummng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLF6Dxy95ukJTBnDE/5X7pV21UAvBEiSDPD0bu5qtgT8TdOaSMFxINs+iaukKMP9j7e/57J+gSwUKK8R4hfGMLlKa+YvI/0prXLaq9Bx6B1HYeOU+pR0VKpdGktV2Q4+zU2twQ5OWrKOHtpiAOyVOXl0eWAr+0CPwq6aRuWneVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHpk6Pde; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHpk6Pde"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32f1df5703aso42231261fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752584711; x=1753189511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9McuSj5bGlrPvDm7dptJI0nxqv/cTjO0Ir2uBBZlyE=;
        b=SHpk6PdejobGllHAgeJzW5EN7DhaiQ3DApnxYYhnGrh9IbGIHl40iSwJw3mwslsIDO
         D6dJvpIG7v5oTKRHMm9Pauuc2UltBly/n886+dSFVdM5NiBL0YVYhZvQIFKeLD0hVG4A
         VrSO6gGhLZbSsnSD2csDqmAV1mD76u5Vi2BEU+9AZQR+5ddv+dj7lakd/y9MiM2qaa5L
         DH1nbIAgcbd0vlCArbarp+oXvd2gOpBpGOrgHrh9IMHZb9ia3WI00qsZf3j6rH6yC96A
         4sixtAWYLXj1uNYlQD7l458pl/oE7XDAcJUBz2e29hkTpyiMOOOSDd7AUqTE0/fotuiM
         k5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752584711; x=1753189511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9McuSj5bGlrPvDm7dptJI0nxqv/cTjO0Ir2uBBZlyE=;
        b=vw3HfCP1We1l5OFGDG8t45GhUwAOht2tadskRu3+zM5+r3bOVTB/+2WPuaMBbTgRa2
         cHE6mGrX03CyE2mRzs577vGkrGZb5uJIEsmy2CAZHuCjIFfTnKPY9RtB5ftIHfkorvr/
         w2byO10wCm8N26YevERJ2Ll24KgTH5ckHzQFfre26kjzW4iJL/mfUIqoYhP6vU50bn5z
         msJt1s0AwwlhC0ysjha48on+toNKxU6mN9cULiMsKuS0kjiWre7iKqzIfyNtXUFl9/MP
         Pxh6i0IUvX7WyeskI0HSlPUQl2KQ6u+MZQmuIqYbZwutqJLnYnWqO2SeOigvWP0tvf/V
         He3w==
X-Forwarded-Encrypted: i=1; AJvYcCX7ua+UFBksmHL6m1+j+tY3pU7422cXRO6183I0c7rjGDl/QC7inlCYHr8VtSCmOuiV89BRbX+UaoSN8On8iBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxc4X/pRQgjdYN+K2EGZHqi2aMAVEvfz6ctmMVDpeVmzNnPbeQ
	Y2h1iGNP13S8B8D/jeCPjWNshbsFZCVk+3W+DTcjAP3JewLm4qP70hwRDuiblj5vQchT3kQpQBE
	w66helfGuTiCejiddI3eNYx9WqEFJgYs=
X-Gm-Gg: ASbGncs06zBTqm/LiWMMpZbBPZ2mnb3F/Nmj8AeIpYCbjqjJRXn/99AoG6khCf6brkc
	75bBoI9QefBsQTNgFCvgSe3Bir/1e0n0fvPqtEkOaeUNedClCw5nWf/bcvNfRspTFFSGMXxtAqT
	0mOCmo/jWrP5rtoUrQ3PfO+SbK9hWk5W3q26lDD+LwMOf8EKEMX+i8MNh+zObAbmdpHWcQaA8dt
	NjUqw==
X-Google-Smtp-Source: AGHT+IEF/xYM8KoYoD69alhrgeWT2FOhlPjgCj9XEg8Vdu/6wrXCqouG9S46acNW8zujhNPogAvcWJIsFz5FB5gAGug=
X-Received: by 2002:a05:651c:b24:b0:32b:82bf:cc53 with SMTP id
 38308e7fff4ca-33055085f43mr57367641fa.31.1752584710115; Tue, 15 Jul 2025
 06:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715030318.1007009-1-kiran.k@intel.com> <bvbhdxatxi4flaybmt73lncrvqmhxru5eshweclt7ivyfarkj7@x5vkfbr67a4r>
In-Reply-To: <bvbhdxatxi4flaybmt73lncrvqmhxru5eshweclt7ivyfarkj7@x5vkfbr67a4r>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Jul 2025 09:04:57 -0400
X-Gm-Features: Ac12FXyG4pxJWsJsY6KJiS9WKH-Y6HSIwjaEtSchaW5EWw1e6Wz6pXFVUJHO5VU
Message-ID: <CABBYNZ+S3wmsrM4oecohiPGF-QVVL2=8rRQ2ECSXf1SOk0S_Jw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_ll: Fix compilation issue
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, ceggers@arri.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran, Ivan,

On Tue, Jul 15, 2025 at 12:31=E2=80=AFAM Ivan Pravdin
<ipravdin.official@gmail.com> wrote:
>
> On Tue, Jul 15, 2025 at 08:33:18AM GMT, Kiran K wrote:
> > hci_ll.c: In function =E2=80=98ll_setup=E2=80=99:
> > hci_ll.c:656:68: error: =E2=80=98struct hci_dev=E2=80=99 has no member
> >                  named =E2=80=98quirks=E2=80=99
> >       set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
> >
> > Fixes: be736f5f89d5 ("Bluetooth: hci_dev: replace 'quirks' integer by '=
quirk_flags' bitmap")
> > Signed-off-by: Kiran K <kiran.k@intel.com>

I went ahead and amend the original change adding your signed-off and teste=
d-by.

> > ---
> >  drivers/bluetooth/hci_ll.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> > index e19e9bd49555..7044c86325ce 100644
> > --- a/drivers/bluetooth/hci_ll.c
> > +++ b/drivers/bluetooth/hci_ll.c
> > @@ -649,11 +649,11 @@ static int ll_setup(struct hci_uart *hu)
> >               /* This means that there was an error getting the BD addr=
ess
> >                * during probe, so mark the device as having a bad addre=
ss.
> >                */
> > -             set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
> > +             hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
> >       } else if (bacmp(&lldev->bdaddr, BDADDR_ANY)) {
> >               err =3D ll_set_bdaddr(hu->hdev, &lldev->bdaddr);
> >               if (err)
> > -                     set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quir=
ks);
> > +                     hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR)=
;
> >       }
> >
> >       /* Operational speed if any */
> > --
> > 2.43.0
> >
>
> Tested-by: Ivan Pravdin <ipravdin.official@gmail.com>
>
>         Ivan Pravdin
>


--=20
Luiz Augusto von Dentz
