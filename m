Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C518CBED
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415909; cv=none; b=BOQpslrZ/W5dllpdypw4jYxJmBA6+D4sOC0TdlTJikMKpF0qVjn3HhE1MeL6Rifd1AzORHCXALJIHpl6BBdhh/jiV4xeWrDAtSlwF5Z8qrmJLmggYALUq4ZMd51Uc3J4+wOPgBMq4HyqB+/vOyCJm1vpK+pN1CUzEz0Lhok6QKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415909; c=relaxed/simple;
	bh=vmvhNgsFs5tuYruoCbgJfQK8ubVJs0QMPah0tA/rKKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuO1Wbb0tx1g3ChTHAkiyImaIoCoq4ryTC+dBjmT5J7kjW2o53ntynOY7hvudXow0Hm+UY95m5gYzZvsaElkBC4Rp6T1I0FbGl+wz0ZKh6kOS6enq7XPkXBJEb2KCcAJfjKB68A6AYgvNoP2p+tNndJpRLbOL0Y7DnDQvpQJAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHKUi362; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHKUi362"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65f880c56b1so40496737b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722415907; x=1723020707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vmvhNgsFs5tuYruoCbgJfQK8ubVJs0QMPah0tA/rKKo=;
        b=zHKUi362vy6KiT8Kgb4qyUrMeBf0STzSnfsRkp89Sq8Fc7WjmFibaD3DYEfFSuM7nh
         rmsuVIYTU6QnD+irLQOHCTQJF9ph41tZxeLnlR/8CVTJEEMXbP4JOInPQtFIuG85tIBw
         5ZxOyzLH1twqRfzC5+Z5SCOxdaBhk9vO6DfFWi8i4plLywv8Wse7yCx38DEU8WCCc22Y
         rMQUaYWcwzW3YW54Xf8B4RSRBcmNeh2noCD4Q2TfQFcPRyBqcyiWRaHj2dMUi0CBFIf4
         oWURP8NhEFkVqBJtPeXaltTskBOlhjfAp6YX3H7JPm07wD2R/J1CdRBi1ByPvEJbdxQJ
         hlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722415907; x=1723020707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmvhNgsFs5tuYruoCbgJfQK8ubVJs0QMPah0tA/rKKo=;
        b=qv5MXaiqrbZOOrc8U4PZE7R7QT+hhhPU/Yq4ZmDjONUcNTUSSl3ifv4PjG16twsji3
         CLVvwaCKntf2JT7nVgHTkztlhKDPSDj2nwrsIT72qkUWDLr8dWUWQy2Y8LR1205CxZTF
         hEBaIrCxs05hGy6QAf1ImrkqZ8Iqx9msMl/7MkXVcnjhpMPWuzHxbSVVln3vzFDtISoA
         D6hF51q3n63KHuQ7hHmvOi+L9zP1HPzyYlvB0lTnoGUHUPbOpN7kN97KHwm1/1zfP9+4
         q+vbAVvo+O6fwyj7GANIUPMiukU+kUgacTJPTuykJtJ08b/2QFIaxvI7M+zSb97bEyf+
         3z4A==
X-Forwarded-Encrypted: i=1; AJvYcCUA+Lj84lr7xKeU0YgYGbEcwzitWqU+6YWN+pDCOifMbMPrqR5FNiCdzpBgnSe2uGtchJlXeXwudRipRI8wbBX8zD86ACkiA9701dA030Y9
X-Gm-Message-State: AOJu0YxH/gZRb6P0JRWILk9uqThAOWat8e0e0l3BMCmLZhiv5fIqrXcS
	apk713eGzaC8we1lf8meA/dy5Rv5oglz6FJSCZ2C2cd/vF0+XVv974q1EeH2j8x/G2qkC6WDkeC
	iA//lR8qapIBKUxVAoMtsIuMhxr5hs5ghwxZtbDLzmzDaa+Ns+C8=
X-Google-Smtp-Source: AGHT+IEMU2DVaRlsRPLZgTJ5cex+ots8qXFwhpYoDAlWTm0I47htZ6N1GkpQmg2LrvYyRZ4lf4WaNI+0QXpiOTRYtL0=
X-Received: by 2002:a0d:f886:0:b0:63c:aa2:829d with SMTP id
 00721157ae682-67a0a139c12mr143029337b3.44.1722415907287; Wed, 31 Jul 2024
 01:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org> <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org> <b1061ec0-5f8f-44af-8955-2d6fa11f94b3@penguintechs.org>
 <CACMJSet3H3B1rz2eZyxUr_ySUOdhTkAognfKpFZ=Kzto8UsxMQ@mail.gmail.com> <534cff38-7bbf-4e9d-90c5-c4a4ba331a8e@penguintechs.org>
In-Reply-To: <534cff38-7bbf-4e9d-90c5-c4a4ba331a8e@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 31 Jul 2024 10:51:36 +0200
Message-ID: <CACMJSett7WOHWnfNGwtWL0sQQ3K9rqr08W9KDF5U=rJbpBZfzA@mail.gmail.com>
Subject: Re: QCA6390 broken in current kernel
To: Wren Turkal <wt@penguintechs.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 22:05, Wren Turkal <wt@penguintechs.org> wrote:
> >
> > Hi Wren,
> >
> > Thanks for the report. I was made aware of this yesterday. I had some
> > more regressions on my plate but with those now fixed, I will take
> > care of the Bluetooth breakage tomorrow morning.
> >
> > Bartosz
> >
> >> I will next try Zijun's suggested patch.
> >>
> >> wt
> >> --
> >> You're more amazing than you think!
> >>
>
> Thanks! If there is anything I can do to help, like test a patch, please
> feel free to include me. I'd really like to help you, if I can.
>
> wt
> --
> You're more amazing than you think!
>

The issue Dmitry reported to me happens with qca6174 not qca6390 which
makes me think it's a different issue after all.

The laptop you're using is not supported by upstream device-tree, is it?

Is the device tree publicly available?

I'm thinking that - since we switched qca6390 to using the power
sequencer exclusively in the driver (we could do it as there were no
DT bindings in place that would say otherwise so no ABI contract) -
out-of-tree DT sources could potentially stop working. You may need to
update it to reflect the true internal architecture of the qca6390.

Bartosz
