Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7315D5C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966978; cv=none; b=WH/1FCPw3C/3n/rHEOgUkno4Rk7mqBS+mto0Abx1BS7v3H3pSrYdrrOlLVLl8ixhBcVFnsw/+eiuX0gi7scDmN5VZya/Dx/7RuYB0Hp42hcmVg67RbXs/GHee7TfLD4VrtqrVbmnJp/p67dD3KK/tH+yVui7FTxdpmPgXv+eWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966978; c=relaxed/simple;
	bh=25nDsIMgZ2HeG8QMinIGq2/PgGv73H9aW1N1Y9zUInk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEoSlvl6PQOIsi+0Q56Ssm+xSz6RZTaPwh1yqsUxjA64aqKfLDpWAc05OtZ+MFZGyZMhukor4JgHXib8X1kTzPIPdX+iJRC2DKdwVkKtXBBI4ez1coIcOvUVLmg/zs9UQAL4rFSXWTrxP03uwl/mNCWAalujkwcNGJ9Lu8xPYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGNnaQpb; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGNnaQpb"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so118695421fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966975; x=1714571775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV0CXA+ylMXkr9COBOzretOakNx5+NjvGyfHdPO4aZE=;
        b=eGNnaQpbNg1evp2OIQOuYqUd8IzFynosInIq49KObkt9cN4nbklJJOecgu0AE8rk5P
         ja+NOH9/Q5gRp7JqUzzkxSCwqY2uNCPCeVMrOXPWL5zm38C7hxTQgici7wcDLlMgJq8F
         4m4PqqW+lGJLMjFP2BTc3/lXAyitR7jfH1kCMMN08j042AwlpdvJWQIJ/lpgrVaDjBvA
         mGWaAIDI4hEbavqp5PdbgcT400J1qp5NSZEoksptHa36roi6XZwEB1h5LMkPBaP9ijmU
         nNnn9pIO5aumcyORy61Il1rbwZl+TVCTvB3/p5vK7V1XQSdcqtTyBQxTmrAVx45HXei7
         vrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966975; x=1714571775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV0CXA+ylMXkr9COBOzretOakNx5+NjvGyfHdPO4aZE=;
        b=T9rtvzxC5g312xn6ZOwEsWiUbyNaLpsKdvpdHNHTCxhckJ6JAO0nUfvWzDKxyAlWrl
         GaQ6he0MKE6wcDSSyRaPt0t2wxZLvYmeX5Dlr/X1oUsv/llR3pVPsR+kWEPUSsokMRma
         qf2bg82b1IcpNwXwB3grOuUiwjeXQP1Y4GIdmHrPzKeCabTin+FsKrpfDxl/5iYRMgfi
         eqRR0B7o6Adh0anxtWj3Hq2Flg6vSJaeDpcaxkheD+iGXVt9SjDDLF/XnNzEuKzK2htO
         OOdVAoKwj734nusF9ShtDTOKOK2mQU2nrD6f7Gb0ESs0L2AL3umgwV0ADmCzfv6YxOqU
         5tkA==
X-Forwarded-Encrypted: i=1; AJvYcCVwd1IYwlI7D7Se3NJnYh9HD2hQBDr8c9F+MMoW8Ezvtvu5sbgSJ3asZ6CiXWCRrdAuuy+jAUtqsdxT8JeG4t0JxbByrF1+aBjRubgMuGXF
X-Gm-Message-State: AOJu0YymK9rXZ7gU0L93S/A0bQml7XWmvNGijoXVhHCexK8W9JvgR6oU
	dY82OasSrXB+pfPKhwcMiM/odxPSFh7NBcwwC8HTdWHIZoZRhGdMmamWvpjoCoWZxK4FCKg9yhz
	dzz192HkmHbpIWaidkYInXnjJ9IpLyQ==
X-Google-Smtp-Source: AGHT+IEJhNzcywJPU2XvXQGqzs4wqHlyZJPGQcXUfVhLkzMvYBYCqpR1klo8PifVf10EtjFqFwAMyXGl/d1j/rZ3wOo=
X-Received: by 2002:a2e:3a0f:0:b0:2de:22b2:ab3d with SMTP id
 h15-20020a2e3a0f000000b002de22b2ab3dmr2219301lja.7.1713966974687; Wed, 24 Apr
 2024 06:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org> <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org> <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org> <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
 <053f51ae-1eb7-4ea8-bb04-38bfa1e0b8f5@quicinc.com>
In-Reply-To: <053f51ae-1eb7-4ea8-bb04-38bfa1e0b8f5@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Apr 2024 09:56:01 -0400
Message-ID: <CABBYNZKt0B9bKfAsP+wUJAeSoc93Otm8NFpos15AgoLV0hwrCA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Wren Turkal <wt@penguintechs.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	bartosz.golaszewski@linaro.org, regressions@lists.linux.dev, 
	kernel@quicinc.com, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quic_zijuhu,

On Wed, Apr 24, 2024 at 1:33=E2=80=AFAM quic_zijuhu <quic_zijuhu@quicinc.co=
m> wrote:
>
> On 4/24/2024 1:04 PM, Wren Turkal wrote:
> > On 4/23/24 9:31 PM, Krzysztof Kozlowski wrote:
> >> On 24/04/2024 06:18, quic_zijuhu wrote:
> >>> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
> >>>> On 24/04/2024 06:07, quic_zijuhu wrote:
> >>>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
> >>>>>> On 24/04/2024 02:46, Zijun Hu wrote:
> >>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NUL=
L()
> >>>>>>> with gpiod_get_optional()") will cause below serious regression
> >>>>>>> issue:
> >>>>>>>
> >>>>>>> BT can't be enabled any more after below steps:
> >>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
> >>>>>>> if property enable-gpios is not configured within DT|ACPI for
> >>>>>>> QCA6390.
> >>>>>>>
> >>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for
> >>>>>>> this
> >>>>>>> case as shown by its below code applet and causes this serious
> >>>>>>> issue.
> >>>>>>> qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "enable",
> >>>>>>>                                                 GPIOD_OUT_LOW);
> >>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> >>>>>>> + if (IS_ERR(qcadev->bt_en)) {
> >>>>>>>        dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> >>>>>>>     power_ctrl_enabled =3D false;
> >>>>>>>    }
> >>>>>>>
> >>>>>>> Fixed by reverting the mentioned commit for QCA6390.
> >>>>>>>
> >>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use
> >>>>>>> IS_ERR_OR_NULL() with gpiod_get_optional()")
> >>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
> >>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218726
> >>>>>>> Link:
> >>>>>>> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5=
eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> >>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
> >>>>>>
> >>>>>> No, Bartosz' patch should go.
> >>>>>>
> >>>>> what is Bartosz' patch.
> >>>>
> >>>> Srsly? You were Cc'ed on it. How many upstream patches on upstream
> >>>> mailing lists do you receive that you lost track of them?
> >>>>
> >>> Bartosz' patch have basic serious mistook and logic error and have no
> >>> any help for QCA6390, and it is not suitable regarding DTS usage.
> >>
> >> Really? Why you did not respond with comments then? Considering how
> >> imprecise and vague you are in describing real issues, I have doubts i=
n
> >> your judgment here as well.
> >
> > Please slow down here. Zijun's patch works and Bartosz's patch does not=
.
> > I don't think Zijun means any ill intent. I am replying to Bartosz's
> > patch right now.
> >
> this is reporter's latest verification results. actually i don't have
> much time for kernel upstream. i really hope my fix is able to merged
> ASAP, it will help us to solve other possible impacted QCA controllers.

Well I really hope we get some more support upstream because things
don't look quite clean right now and it should be a lesson that you
guys need to spend more time reviewing what goes upstream otherwise
things escalate since there isn't much documentation about your
hardware we can rely on.

> >>
> >> Best regards,
> >> Krzysztof
> >>
> >
>


--=20
Luiz Augusto von Dentz
