Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C346435
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963491; cv=none; b=kVDAOZxMuYSXbmiPjC/bsJovXg2JuVIHw0jxOQ/OlBbwmxmzsuvH9SZFlPG2Wxv5Rftn/bZSwBkS38gmIUhS4JC7dDFzHePseRjld4YPheZrc1/u8HG77SCed+5vVdHo+HJlfLlDbhQPc75L6ornmd3dlLEAIPsB7xabFmeGojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963491; c=relaxed/simple;
	bh=bSmiXrrngk3nVYD1ESlkMmhOh9YwC4mUMCtZmjMqvBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dp9gJMfqaJ2DsRhh0j3eoI5jMg6zx659/Qa9a98ECGZ0yMPgpP9NGYmOIgt6pf5P6GT04rIJRZQi5YqfgFx9VsueN5oPKzAtHYkKfrVL+sjc/6tayo8jbgFmGdtXNokdns3QjLG2THoZyZlpi8lg7RxcP3JS2V7TrSTAjtEvwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YxPBbcXl; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxPBbcXl"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed0710c74so5986843276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713963488; x=1714568288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSmiXrrngk3nVYD1ESlkMmhOh9YwC4mUMCtZmjMqvBo=;
        b=YxPBbcXldo3fu8hqM3OeHg8qilyCfpJMiOD9uryKPr4ZYYKROFAylAk06DrCprKTXx
         +I7sLdpOHvsbFzqDCcuiCIOGKVwXTv/MHhpdqKSKCoXmSn3KOtYHAY/s5WvyE6HURcHE
         slrrY2Row9m/CK9ehy6gvvKCu0Lyf9tTlLcXejAKlx+bBG7ihLUn8M4sbiuiJ46R2FlQ
         VbQONwSUS06W7KLaebLE1357UmlVAM0gWOY3UmcaZO0BBhq+HifFpTygTtOF/P6djuFx
         19biVC6XCXKWn85YEm8ah9Ly4DhC4Q/ai10HuVwQJk9/LK8xB+ICoyIF6aswrmVV+1w8
         +C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963488; x=1714568288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSmiXrrngk3nVYD1ESlkMmhOh9YwC4mUMCtZmjMqvBo=;
        b=FzSqrx2hpnJENNCa8NzhmWYWLwzkt7lnqOFTN8OlhxaunG7WzZEkOsPMVxv3ONlQiE
         IAbNZ/Wqw+h9wPAh+1gG7b+ny77lXLBhtpdiyIAQtrXgK/k8KvWYDJqkTZseU7wZA9Kp
         D6ISlpnoAjCMoGOuafnmi54Oe0i3Opg29DU9vfSorspDD25qQoJXQFJdFxgGQqT0Vqj7
         O2/DTFFbDJVu0UgF36dr3Kj4uOd54wjwbsc6LOqgHZy8p2IhKCPyhH8GwfBsmSeoF3jo
         N1NNHejzNMYpKogb61i6cQ0fIHFKIjzOfl9ZqBi1hsld8Uk7MBl483IgxPeb6zYAcMmB
         FdGg==
X-Forwarded-Encrypted: i=1; AJvYcCU1266GlMgpV2ZK2oxJjLzzA9eEI4jFKlZzv56XjBtfIDsrsmHj+3gRtfX+Z4WCJwVHfEv2VGDceIr+4BYR8aXaRwho7CDkTquq2a1Av5GA
X-Gm-Message-State: AOJu0Yz3XjFngydVw87OW/PXRu3s1oAdmMIyAFLio4p0PATLcQgP+EjE
	4Tbw9laWA1eLqob3IaQMTbhzv72HpihWQoUCuNRkl3Gcj5nFIC/9Ia4wq48yGNNWT4EFD1Qq3K9
	EVl42ExTmULU9LMjnm0sD0EX5yGyTPEWdrMTDcQ==
X-Google-Smtp-Source: AGHT+IF0SeaFBpzWYEpTIWay1McelyuIqowaka9D5+ZW53B6hEDrr8A5zyXzstUikgoJK/sUowrhBgt1SUT5qI0VrBc=
X-Received: by 2002:a25:c187:0:b0:dcd:b76f:36de with SMTP id
 r129-20020a25c187000000b00dcdb76f36demr2615198ybf.1.1713963487846; Wed, 24
 Apr 2024 05:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org> <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org> <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org> <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
 <835f54a6-bdf7-447b-b76b-185cdde99450@penguintechs.org>
In-Reply-To: <835f54a6-bdf7-447b-b76b-185cdde99450@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 14:57:56 +0200
Message-ID: <CACMJSetN0XVW0y5Sse5oeBWn6O73MtcrXApUFAjjBvkRHJxFiw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 14:30, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 5:27 AM, Bartosz Golaszewski wrote:
> > On Wed, Apr 24, 2024 at 2:24=E2=80=AFPM Wren Turkal <wt@penguintechs.or=
g> wrote:
> >>>>>
> >>>>> That's OK, we have the first part right. Let's now see if we can re=
use
> >>>>> patch 2/2 from Zijun.
> >>>>
> >>>> I'm compiling it right now. Be back soon.
> >>>>
> >>>
> >>> Well I doubt it's correct as it removed Krzysztof's fix which looks
> >>> right. If I were to guess I'd say we need some mix of both.
> >>
> >> Patch 2/2 remove K's fix? I thought only 1/2 did that.
> >>
> >> To be specific, I have applied your patch and Zijun's 2/2 only.
> >>
> >
> > No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
> > Krzysztof's changes and replaces them with a different if else. This
> > patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
> > Krzysztof handle it.
>
> Got it. Thx.
>
> BTW, should this patch's commit message include the following?
>
> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>

Please respond with this tag under the v2 patch and b4, patchwork or
whatever other tools the maintainer will use will pick it up.

Thanks,
Bartosz

> If so, please feel free to add it.
>
> wt
> --
> You're more amazing than you think!
