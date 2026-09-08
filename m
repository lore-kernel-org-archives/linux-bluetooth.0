Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4313290DB
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848236; cv=pass; b=mK6d8TNsw6jbcVGgYcsbqRAXfdvVrckHzNKTs46GZ3/ELyWvzWdy++Ro7cKH3fSsklFARKp8hm/1075Vmkx7UrlNfC54+XY/DTQRid+0kYIvrD0UyapY94NPRAYEeUkIQwvOkPY0l7iG1XTonG+Xo19GbOlf6LLZcnE4NcJsrms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848236; c=relaxed/simple;
	bh=1NgBz3a7Sjc82pVPmpM2bihEnkIfGTA5GgOxYc9yoT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcxniUT+5n36YDfE1nXKNJGcFuJAk5fRAE0fVxOJCjbFEOsPWCk0IOHBKA3zOcWdqoCJQB3tc1XhxJRRJamLs0tUef71jz6PBbifizd+LiqXf8Hh1B+w+yj+hBceMTy7Tz73Ad9yA/zX+FulOpAcDl0OOcxnAfZC/0ZsIyu4Wfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYL7Luv8; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYL7Luv8"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b523efb0bfso2801122e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 23:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788848229; cv=none;
        d=google.com; s=arc-20260327;
        b=lVGrVhFeko3on874y5aLW0xnvoGTxkC4Q2z7VwEZnTs/F7t6N7v1+qFk2xhC8rpwTF
         NQs/qF/WiwtEKEa+BVAhC6ORbFLmfZnwKcwB1GftVVTmcNBrwJvPfnVdrwz2+tb3czuJ
         HtNrsNt8hEeaAW6xnWdEPbl6PlXOGIIkYb+j5JRQXpaL+HdMSljdLwilR3IXZuUF5INz
         AbnVrAAikG/LbmKA1tKlj15Zq7DFJwMi1YfLxvtIubrJIwdFeiG+K/D6xzOw8FDaXdwp
         4MjdBxVA29+YNAqV2loMAdyNN/J0/HeboYcS5nfmtUNqVXtuDET0wtC4RHSSAsh1gx+m
         bz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AwI0LwqyHhjgDtst5s0PxI0QDScbBljDRluNcb2RYLU=;
        fh=aemqw+JRRdLW4Dm9G1gPiXuIyazF8RujTPbfzHhFvjg=;
        b=pukdcokQdhHo2+wqg7yJCR+eQGZyEBn1tFJuuobLcQKLpeCg8fIu9Sth+6b7zDevjA
         gMGeeCOR5cCyqdHkOzxS5wXSG0zw66/NWgnOlNl+kR/72W9hfL7zfgsSeTS+s1jO7jXD
         dCRhxRpt9ziZaH6xtq/toUyMFhse8WtxPLmo9JIDWzeAlmE8Uv56yRbj+34G2ujYnQra
         cdzw28Co7dr9TF3+XyUlcwH2XeHHTVsIalb8aHpNcPh2XZzcqurfC36pI6g9OrIixSOV
         L6fpAAzvYND2glGZ7AmloJtG4rbIczaOIJJnh/64jVlaJuRA9yfeyCdsXYKkrtg1d1WF
         iBww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788848229; x=1789453029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AwI0LwqyHhjgDtst5s0PxI0QDScbBljDRluNcb2RYLU=;
        b=bYL7Luv8tq66nAOdH51/Qlyqp8qnwML364/kNci4PFCp7kskxybHqKCGYkZjFj7xE4
         uCJYLbPRrQVNMTybAhx+ACX+MWJAk4N/4alh0EX1G6xiEtMUmgAyTtms0zeelZRpAOdh
         3q1i1vnGrgV/XgBTL91jPrrOklHCdjOjnC0WWOB+ENaPHtrIJ4tL7Pz9PPsTL0EWFbKU
         XRcc34HV538FN763/6d0qFFfsA6m1DtlLeWL1MWTlsDh43eDBhRKDnp20iEEYTqJj9EH
         SaY7DbiCmFsehn7oduwsf4jtw73ZlwSGAz+a8F4RDEb6wO+EVRjKhLIDrjh4vaivuMeI
         YVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848229; x=1789453029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwI0LwqyHhjgDtst5s0PxI0QDScbBljDRluNcb2RYLU=;
        b=JO3BVVJUhMxiIVil1VMvSGE4BYr9yXr6k7HL92WL3mw+MDtArQdaT5INgT9cWtoDoz
         xHzqmVXrzkLC56c7DxvulOGdkzgoCBVMBJavxBlCVnsUY0marD9fGzFarJNFJdBiYB7k
         5z/xUi2Y394ktM2h3RHnQErDeanPhRLzBNA7qXaRsJx35+DRKockeTwluVjd/t+4erzy
         lFIukjpoSCV2YAi91FwSp55xUNxKyuCmISKLf2m91kgzsdohSG16pawjhjXr8GFwfzh9
         oyuB4qwIKzHiERi1qpD6IVVUT4bY0l+r4+lPLlmccKbAbatruhUwvSTTNGAG7aewy1eS
         86AA==
X-Forwarded-Encrypted: i=1; AKwUvBwrm7gTJyutEopf5T749JjYy/thulIuMFSk5bwoP2D95sb+kM0Ec44Aiz4GM7IuFwciAed5fVb5kSO7cZ5j7k4=@vger.kernel.org
X-Gm-Message-State: AFuF++m1XyFEfb2sOCqPQ4r6MT25hgQgX/yUA5zWGXRIen3W4I08lDlt
	EU0yR/SlLIy6gYtP9XQIvXBt1woFHb52V0uzidbf1l623aDI1U8vD/ESo2Lqv9Jqxj8BKVTMrJy
	Jh3o4ZPuw6D6bj/MsTZd+fPfnVmTbh1xOBJPO
X-Gm-Gg: AYBFou1zffQySixT0Bbb/RpRNuCSW5vlO3JwKqusLrb/A9hnJXaKrCMIQ+ZXRhE1isE
	85RCQD9rAi22r54VAE4mwELlI9TsXFAapmL8HKeZ9Wi3tAscN7xcac028Q/9h0vAwvscFORkskz
	sDiliHBB1inkf3OEjJWsrnplZv8jyrp6ftMIfBTLctxWE394ogrM3+Oop4fvyS4aGX6MoYodisH
	NE1R2I8rX60Ej9VFF7zsakM/UvfqlDThKb1V/aqU/PjX6f0V/quq+fRBV4/sl6dK09rqY6bkmpA
	RFfyTLirqJ6PpqAP+73i5binVxJ6h9YKUXOC8iPi/GFrUFsrVC3Kk8+pc7JpVsA08c3i1jTOsyH
	iGV17796Hz/UlpyPJFNeMFj6TLWVJ8t4OUw==
X-Received: by 2002:a05:6512:3502:b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b616ed4b1dmr8420185e87.6.1788848228754; Mon, 07 Sep 2026
 23:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com> <CALHNRZ9ofDZ61YW-ZN07sf8sZ6gx4n-8SusSR_vop7R_vqbGFA@mail.gmail.com>
In-Reply-To: <CALHNRZ9ofDZ61YW-ZN07sf8sZ6gx4n-8SusSR_vop7R_vqbGFA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 8 Sep 2026 01:16:57 -0500
X-Gm-Features: AcwNN1VgNWSczffYbVkpMII3iSIGGLuXysgoIqRynjyRK0gNvf16cPtdnFgElDw
Message-ID: <CALHNRZ-D1Yz1bgp5hJjwBW32Lhd4Lbt0dQj=3wq-xWqp6uSC7g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
To: webgeek1234@gmail.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:34=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
>
> On Fri, Jul 17, 2026 at 4:41=E2=80=AFPM Aaron Kling via B4 Relay
> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> >
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This patch adds the device ID for the bluetooth chip used in the
> > Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/bluetooth/btbcm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > index 463d59890befe..14acea7325478 100644
> > --- a/drivers/bluetooth/btbcm.c
> > +++ b/drivers/bluetooth/btbcm.c
> > @@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_subve=
r_table[] =3D {
> >         { 0x6606, "BCM4345C5"   },      /* 003.006.006 */
> >         { 0x230f, "BCM4356A2"   },      /* 001.003.015 */
> >         { 0x2310, "BCM4343A2"   },      /* 001.003.016 */
> > +       { 0x2409, "BCM4356A3"   },      /* 001.004.009 */
> >         { 0x220e, "BCM20702A1"  },      /* 001.002.014 */
> >         { 0x420d, "BCM4349B1"   },      /* 002.002.013 */
> >         { 0x420e, "BCM4349B1"   },      /* 002.002.014 */
> >
> > ---
> > base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> > change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8
> >
> > Best regards,
> > --
> > Aaron Kling <webgeek1234@gmail.com>
>
> Are there any thoughts on this change? If not, could it get picked up ple=
ase?

I see other changes were picked up a few days ago. Is there a reason
this one hasn't been picked up yet?

Aaron
