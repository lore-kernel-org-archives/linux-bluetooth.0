Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF64EDCAB
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665558; cv=pass; b=gDI39BG6JxscJENq1/QuFQylxNhkvITIDY2klrCdw2jmF4TKpXURZp38B5AGxj8rwHbgyGA+dt2scwTrOxS3WyYvqyr7TcdABoncLEp3JPKd31onfcNgIHolHaOoWf8p5SzTedF0Iyasop3yzvPT8IwYA3KCUH8vCqesnEJUcvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665558; c=relaxed/simple;
	bh=nmR0VZI/qSZnCk+5uLQVurAYpAKP16KdlUm/1lXJbHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poI/+iwLqEm0OlUFiVYg8zWXuo5Yu8lqfEqkXGTncmRAruEco40SkAmyVZ1k2bTNAAf2wELwG7K8HfXuuUK//+iwjoR2zyIZ+RYE5Goh47Y6WnyIKk5NIuj80wYPqu63gSIAvxRvohvWjgZ7pZjkem4gfmRHvaPkXk5vSZkIEJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilb04RGy; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilb04RGy"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aac9321so1058994d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 10:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789665556; cv=none;
        d=google.com; s=arc-20260327;
        b=XWsZsnPPVyuJaUNv5ZRuf6VWuEG/zMk7vCoz17OeL3DW6s7ao34iF6UknDmqdPz2oG
         GuaO1RHdORNZOMCX31UpRBDCMLzokZKNlmTh8ybSt4ZBFwJk1zqLKiXLS5Ql+Zu5XpI3
         P2KXRgdkpisfnOuCyl6d3e5iCt/HDJ90tSBfagQYNZfsJ2fSZxksx5HS/7oNvukKyTqm
         Ez4hU6Yn7PHRyI+JX50UWPzkAGySTTRqMKLzyxAl9FSBH/ooq4ilrPnMs0Wi1uhmmrqX
         jZPLzsuhPDw6qyMGu74jwfUkt1upKawOjDczhah6EZhpBei2cinjkbjRjE0iH6zW0g+I
         a71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XR1MF6C9tcNALFSHCEqxJl4Hxsak8WMdJhGwxV/H/BY=;
        fh=qAH+aihDSgv1N3sG6yQZYv6Uk7UBGnF6kjAp7XgfRwE=;
        b=QQWiMxJ2DWeto9EUwfGD9NXQCIl+eHNa/BHNUIBobKkejYgpArXfDxTOtyKNG91fWJ
         973QOJHn/et3X7IQTNTXq2eNn2ivA3TW2cXoUotYJxozBAwWY4v6pZjGqjuuorx59YzM
         YsmexQ+L+Zw1+6AwVW3SKqfgkUa7yW6MZJ4FghCo30zino1CndSfy2WpsGC06dlndI3s
         gYsvXPiO6uHNr4n4D5YQYEEVs+CMMQfAfteOla7UOkLydQw94A7DVAFZ+c3ehzlt+TMU
         J8GYR2zVvtQsoto6OwN8kzmnxFwVF92HamYfTxiRYwNX+wfmSngL6hOREiYTa0ZDqndC
         E8mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789665556; x=1790270356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XR1MF6C9tcNALFSHCEqxJl4Hxsak8WMdJhGwxV/H/BY=;
        b=ilb04RGyDEGxNQHeFRg+OPOMko+ceilREocvXkp5QYOhvsHQuaPVQIlTMsbIuSiX2D
         FgmwdPhrEc19ekvXvBohzKTVtcRXlCoixAGu6cLWR7ewhH5i208mH7Fy3NoiFKTcF3Si
         c+zkWY49H1+Aes7xVLW4cdYOl21Wyb7Lc2dewdsB7o73xzTy7kIoyKlJbJ7Ed+/g/mtD
         eidBX3CAAe0Emm8K3y8O1ZPe9hCiSsB8oj7P2f+FwXhvbiOcXESc7EeiMbZHsesaC7Q0
         usNpS75Je7Ivy5ifeDQw92unBpt8JeQ2xVRaSdfovzRfAIV+/ryYgiwwmCgfax2d5LZ4
         ZUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789665556; x=1790270356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XR1MF6C9tcNALFSHCEqxJl4Hxsak8WMdJhGwxV/H/BY=;
        b=guqgZ8m/UmvdnsWE5VoLGK9I1welV9RDCt21aB/4Chhn43XadVWBRO1EqhRJJs+E0I
         baaliIZGYrL2uaD/MX87NldpGeQuC8dcrLQ4ySQJmvoKkekXycmo0i99rxm2sLSohdgP
         E6k0T/97boMu+mfxr5E72Q0RgFc4YFW2e1MtqtxmQyOZkjKU9QjcrPQII0ET14OGW2vE
         2jWl2ndcwaAvNkjWWywgNIVzol4PcPZ1jQaXsdbMYQVzN/XRIERBiKJAOzklb8g9FWjv
         DBZWHz/sRq//Ge4Qx9UyohtgkDwxeUGKaY3Lw7j/IW7ZRFjRmPUXOu6xPh+2TgTd+mvi
         M9gA==
X-Forwarded-Encrypted: i=1; AKwUvBwb871URxGlHbZacBa1j5kURBDqhX3o0SkrCjjjaF9R+sqvVYQq7wFwldZozHvjFktj7QyYadCc3ytmA2h1SaM=@vger.kernel.org
X-Gm-Message-State: AFuF++mr8SjyvD0mZ43IACeDhwjTg2VeFQOMRLrKeuBBfxqeNgjTArz2
	Ew4J/+KlBhG9Aax/2YuEES1TZdV+eqivNMnpdMwRUfBWd9ekpXpuAXji5x+x2totAHrRs5uddE4
	KN3DxQ5d5pSj8VTGH9vAULZVYFfsEufc=
X-Gm-Gg: AYBFou2zRP5XUezC8vhvDjLJ5JKkkZinwIt9P2xyus1uk93PXZGLitlbxht0gQIGTfV
	AgtA8HFTQ6n7FUone9o7wTU99PHVoH4bVWQ4034B9evG//afHQsKQrebIlO/BdGLwn+MEMVxz4k
	I/aG/GBBkZUdo8wH3W/iSuBBYxmBrWHwIMSG2al/aF8v/gDym1zE37ZdrPt4OXCkuZRQA6PR0Ff
	QteCFCC6mYmyr1B1hY2Vmrmuhz40gh7g3vVjUf4809BdDn1Gx75tHKHV/NGzsOnjl4beQ977BVW
	3CxtgicwrKq3ed13Tc/oyhAZXsb9keFmIcKfV/2ZHApJaCAFKiy9+ahpzJ17xPNlBz8K0rYapLM
	cbV3pPp/h9SULdC0ZuPbI8s+Ngoht6N7Fl09mzGe6Hw==
X-Received: by 2002:a05:690e:191b:b0:671:3cf6:e1ab with SMTP id
 956f58d0204a3-6716320b6ddmr2187286d50.32.1789665555810; Thu, 17 Sep 2026
 10:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-bcm4356a3-bt-v1-1-ce44d0abb5db@gmail.com>
 <CABBYNZ+553teDOW-43qkf_TCyNr31LP8gS1vQ7YfKvAZ9UnzLw@mail.gmail.com> <CALHNRZ9FeNaT65WTEJAe8H9ux2CtGVkdoL1-nDVMrdGi5mTxvA@mail.gmail.com>
In-Reply-To: <CALHNRZ9FeNaT65WTEJAe8H9ux2CtGVkdoL1-nDVMrdGi5mTxvA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Sep 2026 13:19:04 -0400
X-Gm-Features: AcwNN1W2gvFWQgBUSg99tLXNuJ4sP8849NgXLBaweXbuu21Km6VDFmulPCNXC9E
Message-ID: <CABBYNZJ4+WBSOSDkYExT1b4i4_ZyLa4AzvED9QgwgxCTTwrdVQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Mon, Sep 14, 2026 at 12:41=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com=
> wrote:
>
> On Mon, Sep 14, 2026 at 9:13=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Mon, Sep 14, 2026 at 5:38=E2=80=AFAM Aaron Kling via B4 Relay
> > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > >
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > This patch adds the device ID for the bluetooth chip used in the
> > > Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  drivers/bluetooth/btbcm.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > > index 463d59890befe..14acea7325478 100644
> > > --- a/drivers/bluetooth/btbcm.c
> > > +++ b/drivers/bluetooth/btbcm.c
> > > @@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_sub=
ver_table[] =3D {
> > >         { 0x6606, "BCM4345C5"   },      /* 003.006.006 */
> > >         { 0x230f, "BCM4356A2"   },      /* 001.003.015 */
> > >         { 0x2310, "BCM4343A2"   },      /* 001.003.016 */
> > > +       { 0x2409, "BCM4356A3"   },      /* 001.004.009 */
> > >         { 0x220e, "BCM20702A1"  },      /* 001.002.014 */
> > >         { 0x420d, "BCM4349B1"   },      /* 002.002.013 */
> > >         { 0x420e, "BCM4349B1"   },      /* 002.002.014 */
> > >
> > > ---
> > > base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> > > change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8
> >
> > We need some more information, such as:
> >
> >     Test log:
> >
> >       Bluetooth: hci0: BCM: chip id 206
> >       Bluetooth: hci0: BCM: features 0x0f
> >       Bluetooth: hci0: BCM4384B0
> >       Bluetooth: hci0: BCM4384B0 (002.001.025) build 0000
> >       Bluetooth: hci0: BCM4384B0 'brcm/BCM4384B0.hcd' Patch
> >       Bluetooth: hci0: BCM: features 0x0f
> >       Bluetooth: hci0: BCM4384B0 AP6684P CN iPA [Version: 1030.1021]
> >       Bluetooth: hci0: BCM4384B0 (002.001.025) build 1021
> >       Bluetooth: hci0: BCM: Using default device address (43:84:b0:00:7=
6:93)
>
> Sure. This is from a Nvidia SHIELD TV 2019 Pro:
>
> [    9.802656] Bluetooth: hci0: BCM: chip id 122
> [    9.808481] Bluetooth: hci0: BCM: features 0x0f
> [    9.835172] Bluetooth: hci0: BCM4356A3
> [    9.837341] Bluetooth: hci0: BCM4356A3 (001.004.009) build 0000
> [    9.844428] Bluetooth: hci0: BCM4356A3
> 'brcm/BCM4356A3.nvidia,p2894-2551-b00.hcd' Patch
> [   12.171393] Bluetooth: hci0: BCM: features 0x0f
> [   12.198153] Bluetooth: hci0: BCM4356A3 37.4MHz Class 1.5 Nvidia mDarcy=
-0108
> [   12.203520] Bluetooth: hci0: BCM4356A3 (001.004.009) build 0109

Please respin including this information.


--=20
Luiz Augusto von Dentz
