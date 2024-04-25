Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DB1E892
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033825; cv=none; b=NpdDoBG8t1Qq/e3WyO70KKDDOKYdkRfDfVLJ5oUVFQKw8htdue7IOHH8fj5cV8+btLkD0vlyDR9huo3XCGewitxrkhAw0qYCA0DdenvglsG3IPDrjWdIdYD5flaic5EXNqy82Iwpzu/4zJK5EVx9pZ/qSH2tU3q0FA4AJes0fHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033825; c=relaxed/simple;
	bh=RDk21kKYvU1WGp0zBpBg5fsvRfDWWG2feqziSMNsqOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWjb3BRg/8YgXdF6zZul0HnMbqRus9uSxECS+vFyQ4qRHhYXf5NfM+aDfFuDixjU08HTEgOfj6LaL3PKsxG0LPVUgw6VKVv7BEeaTEHMAqrFsqVugqN0I8dHstFfauo47FcW2K8yEkKSwLz9huVK3iIMF2o4gv9uiX+XGcXBsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8hnXsrl; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8hnXsrl"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de54c2a4145so911839276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714033823; x=1714638623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDk21kKYvU1WGp0zBpBg5fsvRfDWWG2feqziSMNsqOs=;
        b=B8hnXsrloYdciGFpwzSdBylKgCbUgayjZtkhZ8+m1t0HsDwdd2+CzeQ3H5RQkSGIpU
         vNZvu/0mDu4+p4SqCLyTx03jfnPr2hO7XwifjHvoWMYikYzCA7ITHAqmXNdc4SHIM6wR
         29TMN/EIEi6q839grZo2fvFjby3skRNaSvbUg2pG2oOdN0jt+XFGvhWn9lmlmoQBauZo
         1mVW2xc+33BrWAHT+8/HlU16ZujSvTpyrNyCBfm72+ftR0GG3CtECG4g3h2zHrYBRMw9
         EnFO7FOC6qyvmLFYAp4fR3YtpxOSC+MpJAIm3eR5FUhybR+EUPwutN5miFl02LkAE9ww
         FPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714033823; x=1714638623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDk21kKYvU1WGp0zBpBg5fsvRfDWWG2feqziSMNsqOs=;
        b=jaWtkEjwCL+cbIfVgquUl4wxSinQXumUEv6Qu6IfGOwIjrQubu7KdCj9UzcyyYiC0g
         hhNOAtxDb/2BRKyAdLDooVJlsfmkSdJrqZ8s+h4K4YHKOT0yMCnG9k/8Nqci+LIHXFX9
         pA5zqW0Gxm8NCwfMlOXZ9tuJpQCxKYNqDGrj2cXUextUiFSLKWk4ojLeTK+1sYu1knGl
         K4ch32qKAmPuemGMTvUjGi6HHJyCO+sxquUXVQQuHfo3VgTSh7wPcitrUQ/143lV+Tvm
         oOXkYClxEfZlocaK8ZIhDt93WYbwKBmRWMly4VTEcl2XwQXg8hg/ZryoGSLz9W+Ly3CF
         UfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCoW7IJBSI8A1JhyPf2ubaJUk8jnyaEkVA2GUrd5BabG7iZ933b4lyJ5+lpxQAmziRP5BHFj2RIKNMiWqO1x6SW38eaxKQIY1hoFyONRY1
X-Gm-Message-State: AOJu0YxYgdaWym99gKHuGVRvCcWE5YhTnFfTLf7KMB5XIQLmN11FJ5A3
	fEqeELNYaxZF06RSPN5ZzK1PHcdjXET+lQXEmhqIbMCEzbjLDM1+tBKSxBLGxFgjsO+kXgoiR3z
	VBI8JpBtSA5uxpMkc9EAU+loBlPyOJiZ0cM0bmw==
X-Google-Smtp-Source: AGHT+IHKM4YPDpuevFQJfqgtbpCZPQXsU1jskA/YJSC/utcG0tynd+yjkQ+LkYUW7fS9XqJqghwLH65UgNSKnn5ssvg=
X-Received: by 2002:a25:2643:0:b0:de5:5572:6236 with SMTP id
 m64-20020a252643000000b00de555726236mr5573879ybm.4.1714033822947; Thu, 25 Apr
 2024 01:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
 <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org> <0cba3838-917b-48af-ba8b-2ef60714943a@quicinc.com>
 <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org> <c1632816-f754-42c6-8448-2daff8221b58@penguintechs.org>
 <368e70e0-edc2-44fd-a9a2-72efa0d9f864@linaro.org> <f372c661-d82a-4f6f-b2de-8dd241d6b107@penguintechs.org>
In-Reply-To: <f372c661-d82a-4f6f-b2de-8dd241d6b107@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 25 Apr 2024 10:30:12 +0200
Message-ID: <CACMJSesk+DYFDwM7hUoPs9Xy+i1q8w+5CFu4_RdreUXudk18zw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: qca: Correct property enable-gpios handling
 logic for WCN6750 and WCN6855
To: Wren Turkal <wt@penguintechs.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 08:30, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 11:05 PM, Krzysztof Kozlowski wrote:
> > On 25/04/2024 00:01, Wren Turkal wrote:
> >>>>
> >>>> 3) only care about the case property enable-gpios is not configured,
> >>>> the original BT driver design logic indeed matches with binging spec's
> >>>> requirements before bartosz's wrong change
> >>>
> >>> What? There is no such case according to bindings. I told you already
> >>> two times: Either change bindings or this is not valid.
> >>
> >> @krzysztof, I'm curious. There is no entry in the binding specifically
> >> for qca6390. Should there be?
> >
> > qca6390 is documented in the bindings, but you are right that it lacks
> > if:then: entry narrowing/choosing specific supplies and pins. It should
> > have one, indeed.
>
> Would creating an entry for the qca6390 hardware fix the issue you are
> worried about?
>
> Again, sorry for all the, what I assume are, basic questions. I am so
> far out of my depth here. I am just trying to figure out how to move
> forward. I really do appreciate your guidance here.
>

Wren, Krzysztof: I cannot stop you from doing this but I'm afraid this
will complicate the power sequencing work unnecessarily. The QCA6390
PMU bindings I'm proposing[1] are consumers of the BT enable GPIOs. In
my series I also create an entry for QCA6390 Bluetooth[2] but without
enable-gpios and with the inputs from the PMU, not host. Please
consider that if you decide to go with this.

Bartosz

[1] https://lore.kernel.org/linux-arm-kernel/20240410124628.171783-2-brgl@bgdev.pl/
[2] https://lore.kernel.org/linux-arm-kernel/20240410124628.171783-4-brgl@bgdev.pl/
