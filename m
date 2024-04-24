Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5315D5B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966562; cv=none; b=e660a1VPLhXAQrbTcF40h7+eOAI6QX+D16hrOgCmAHhsR96wbTOwBtkER3kml8XA7nHwVi660iG9zJHcEBA6zvyDPTjRkrwtdX2ToNHZJOKmbYavoB8IwICiE2jJElmaazjmXMv9ECi3Sy1l1BY2K95BaN/HIdBOJS0KNTSHn0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966562; c=relaxed/simple;
	bh=MhZBQBp84TPByg54trWqck4iqHKnX8KYkagDZZlGwb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQF/+rOYJdNKT/kqB4OLvQq/vAxw5i8Wb+Mt4xD5vriVaqj/51HpDQUYhHAZwykGHtsGhsCkkXqFEYxQGhVx57xkYCZ4vvmUFvm7RwLWVIiIW25DsFhr3Wawwif+C2+rEq7kY8N1DIZ4Ll6SK++N5+zxPDm4XczG66RrKjB3mxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuN2y1WF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuN2y1WF"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so91269191fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966559; x=1714571359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sF1JQ44Dat+BvhpKfJnSWpswqIUZ9E20D3rBpoIixw=;
        b=FuN2y1WFnfBMXbtoXNP6ujymViSPA7GqaPtYgrPhZ6ZcrdhkQowT0efPVrrAtBGPW3
         2RvTfWDgB1zK/Q5wbdL96rF+U8cr5G3+DxUNpNgVqvbTKdnwNwJpURwu1xk0jXaaeAvS
         8FvGkOAz45u/APRPA79Ym9tJ6H+3hdymYNLRctaZxr8iXQrX/jmdRjy51sl0jo08hWVo
         inS6S4MT+ZRmSMUvAnxHJ/b0VhhbJMx8dbyuG5+e8iVsE79Dg5khMQuxvceWfEqrUiLT
         JjLC78HJWW7M+Pq/qsarw+7pjk62u8LXpQNExuAS2fK8HV5qSO9EVxGiTNsypGSx8RHm
         mGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966559; x=1714571359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sF1JQ44Dat+BvhpKfJnSWpswqIUZ9E20D3rBpoIixw=;
        b=wMQ8dLLY2QTueG2AQMr0l4WwBJm/nj3yknzwvHvoLKN3P40Cga+9zQYAO9aOaXLj+f
         cTi0S0eWRjU/ts44MaxS7gzMrYG3fStN4aNjH8T6rDR0K4YlqQNZM3AcfoCLV/HHig3/
         lCwYX7mMTlFAumsU+3dZsg2ePHKSknykbSYBbzWd8wZB+lgpSWZ04cLDfLvuIML057kK
         fbHdrndFauVBhSvF7TTK1NpcObEoYI3mGc4TBTE+iGXqon83BKpZR/c0Q+xhq/HD04vJ
         hkF0kRSjNWRWvWSbLK0NoACPtHc7cxknbguXKWA14ddQe2pYGMNmdVvy90Nm5CXUoLZe
         UKWA==
X-Forwarded-Encrypted: i=1; AJvYcCWN2gR/OhqnnqTpBlCbViatfFgzUMhPzySK/K//xhzA7UqHM74aCUbyKxXXxogzXwjzVFMg8xoI813jL5TNX97f5tuGR3u5g/9aDzzVjZet
X-Gm-Message-State: AOJu0YxAcXSeT05YZUiyt9sMU1KBxw1RvPyX3QDCFzIsgE/eZM8/DubY
	mZ/8hz0zwVIwVyNb2JBO2wzJs8c8NAqT1FzT4OiGx6z5smMgGXoFeX3hL0TfAzJJHTk/S2b+0Wq
	cBM8CZ9jy2WVct/0rh+jh+AwBbF+aBQ==
X-Google-Smtp-Source: AGHT+IEDioyNmr/d1jAk6wQ/bYJdnZTM8LraRWD7zfqK5QkJ9zy9UuJ2gb36ysaSir4RfZUVbWY+IMdNyjT0kJ4qfw0=
X-Received: by 2002:a2e:960c:0:b0:2d6:d351:78ae with SMTP id
 v12-20020a2e960c000000b002d6d35178aemr1561268ljh.29.1713966558892; Wed, 24
 Apr 2024 06:49:18 -0700 (PDT)
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
In-Reply-To: <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Apr 2024 09:49:05 -0400
Message-ID: <CABBYNZJLCPaLTaFEfeTEn+2FpxLS8Z-W2kT1ry4jKB_W=XYNjA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Wren Turkal <wt@penguintechs.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, quic_zijuhu <quic_zijuhu@quicinc.com>, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org, 
	regressions@lists.linux.dev, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wren,

On Wed, Apr 24, 2024 at 1:04=E2=80=AFAM Wren Turkal <wt@penguintechs.org> w=
rote:
>
> On 4/23/24 9:31 PM, Krzysztof Kozlowski wrote:
> > On 24/04/2024 06:18, quic_zijuhu wrote:
> >> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
> >>> On 24/04/2024 06:07, quic_zijuhu wrote:
> >>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
> >>>>> On 24/04/2024 02:46, Zijun Hu wrote:
> >>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL=
()
> >>>>>> with gpiod_get_optional()") will cause below serious regression is=
sue:
> >>>>>>
> >>>>>> BT can't be enabled any more after below steps:
> >>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
> >>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6=
390.
> >>>>>>
> >>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for =
this
> >>>>>> case as shown by its below code applet and causes this serious iss=
ue.
> >>>>>> qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "enable",
> >>>>>>                                                 GPIOD_OUT_LOW);
> >>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> >>>>>> + if (IS_ERR(qcadev->bt_en)) {
> >>>>>>          dev_warn(&serdev->dev, "failed to acquire enable gpio\n")=
;
> >>>>>>  power_ctrl_enabled =3D false;
> >>>>>>    }
> >>>>>>
> >>>>>> Fixed by reverting the mentioned commit for QCA6390.
> >>>>>>
> >>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL=
() with gpiod_get_optional()")
> >>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
> >>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218726
> >>>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-a=
e42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> >>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
> >>>>>
> >>>>> No, Bartosz' patch should go.
> >>>>>
> >>>> what is Bartosz' patch.
> >>>
> >>> Srsly? You were Cc'ed on it. How many upstream patches on upstream
> >>> mailing lists do you receive that you lost track of them?
> >>>
> >> Bartosz' patch have basic serious mistook and logic error and have no
> >> any help for QCA6390, and it is not suitable regarding DTS usage.
> >
> > Really? Why you did not respond with comments then? Considering how
> > imprecise and vague you are in describing real issues, I have doubts in
> > your judgment here as well.
>
> Please slow down here. Zijun's patch works and Bartosz's patch does not.
> I don't think Zijun means any ill intent. I am replying to Bartosz's
> patch right now.

Ok, that is great feedback, so I might be picking up the Zijun v7 set
if we don't find any major problems with it.

> >
> > Best regards,
> > Krzysztof
> >
>
> --
> You're more amazing than you think!



--=20
Luiz Augusto von Dentz
