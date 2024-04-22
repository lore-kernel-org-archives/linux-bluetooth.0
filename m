Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346314A0AC
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790972; cv=none; b=Z8Q4JNVujaQxBiblyoArE1ykr9Y+0MxDkOApdKI2iHPHIRCVuK8sj6ykl6JnBnK/L5BaeheK3uLXiN8JoDlvHL+aKZPhom+/k4KKeW5buvCIZR1hV5a69oJ7duOn2279OMzakbKeo0hjT+AxJTDm2m27pDEkeBkCYBhGbLe4cVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790972; c=relaxed/simple;
	bh=+Cq4aokMbWo87EMNuSZpHsDDMzRKgaUub2cLGzrZNZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csLXEk22U3XkhS5AILrDmome0LIDXOGgMyyhI78ixPj3BhTFKQqHU2vi3nPeFtdVVw/aURE4v7B1maXSBUeS1A6JLNgZ4dMXht4ZFzb23AGwbMpjQIt39oOp23nJfSemygZoCcwUAjKBF5WNLZssiAqYia0lQbFke0r8Bnks4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OaCydT8y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaCydT8y"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61ac183ee82so43860267b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713790968; x=1714395768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cq4aokMbWo87EMNuSZpHsDDMzRKgaUub2cLGzrZNZ8=;
        b=OaCydT8y3xYyejJrQ4QW2Ov05xsZves46V0IvLdhs6QZzPAqKeMWzjcvs7hSoD4hiA
         tDnwDymEuZR4yCrqvKWLmikZN7cJN+0LVbreSUUkshc6slvnFHx9ORjFaoDkhUZulemg
         u2mZLNBqeYD9TArqE6cRCqow9XS7Cfny/5o7QfAX1QQ6erWlaL7GxgkCjaZrom10y8CB
         gxld2QFo0e12JyC20rjnHANufWUyqkRaskG/OnrtM2VBLZDprfMm1wwIrhAhbG4gSQe8
         SvsCbQglnTu5T+XMz43WModRhZ708vPTTR6mebPerXNbkxtPrCyO99r3dno8F9bL1+IU
         zXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790968; x=1714395768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Cq4aokMbWo87EMNuSZpHsDDMzRKgaUub2cLGzrZNZ8=;
        b=PBX9s3v4M1VZL+nmI0LrACM8QpgjIFZ3zvSzWWDlcwv1RgglqwlbbwfIJLgTfizrTe
         0oOaAH4ayjHZTuvaqB5c67rtP4cNz3v8USjB5exhGz+vKqTmodYIJBOLtl89+eSyj0cB
         l4TatXjxppTtkj4zXX0nHS9FFQmc9XHIrrXkiegzEU7yMomro0dDG59MUOPPHPJzksCV
         qA7aUzo0icMG3+KcKHN2TrsOKfoSn5coQmzjEmZ4ICxQBekqZGRZp9SwXR04upMR7uPJ
         Ueftvki9s2BwBv/kQBJBO8GNHQ/1If9PYKnmhA/KRDyoBluRAoUunN3s8qGQ5olrB/E8
         olPw==
X-Forwarded-Encrypted: i=1; AJvYcCVLZU30q/YszDKQOwfhHjttfjeX6E+71k4N/JVLxheUjeEGn0efxg4UJbXyX8oyUpu5Qc5dLQdO32HtL2AKDhVY0A1W0FcGgKby6qvqlS+w
X-Gm-Message-State: AOJu0YwxVH3mmusD148m3MEvcLPjgpUbzuacGaZHDZxuztXP0HipKBUV
	u9Igcr8HlMlfj2EENj+eTZVEFW/u3Gs4opzV9D1EYH+TFDEAVzOOtb8qGfTJhUEGAs+CoSpuU6w
	nczLfn9lPNfaxwG323kRMiAL7oGpwnUB/Cs0UyA==
X-Google-Smtp-Source: AGHT+IHerH6GOkHsD8OHWFPyVWXygrWO3rG6LpK6SV9ja2GjSfh6qAzzo2Cj7TtuGSpU6sBRx/BRBRdxUbdN9pELSjQ=
X-Received: by 2002:a25:8051:0:b0:dc6:f0ac:6b53 with SMTP id
 a17-20020a258051000000b00dc6f0ac6b53mr8238555ybn.15.1713790968038; Mon, 22
 Apr 2024 06:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <369512e2-f091-4370-bce5-9ac32178dc4d@penguintechs.org> <a6ae69ad-b602-4cfc-9f76-8932f357d30b@kernel.org>
 <c0f7036d-c129-400b-85a2-1414ec3d2622@quicinc.com> <dc17aea1-9399-4c2b-8775-fa0a7f602035@penguintechs.org>
 <CACMJSevocRot6J06uvridRw9MZFftJrkCyYBgXhLnwfapVPnCw@mail.gmail.com> <5da9ecae-35c7-4968-9f16-3f10e04c2b1a@penguintechs.org>
In-Reply-To: <5da9ecae-35c7-4968-9f16-3f10e04c2b1a@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 22 Apr 2024 15:02:37 +0200
Message-ID: <CACMJSetZ14Pm=m9e1ka+m9pUbSwCfV2agcaWBd7aWJu2ngWmbA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Fix two regression issues for QCA controllers
To: Wren Turkal <wt@penguintechs.org>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, Krzysztof Kozlowski <krzk@kernel.org>, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 12:42, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/22/24 1:51 AM, Bartosz Golaszewski wrote:
> >
> > This all sounds plausible. However just reverting this patch is a
> > waste of time as checking IS_ERR_OR_NULL() on the return value of
> > gpiod_get_optional() and continuing on error is wrong as I explained
> > several times under Ziju's emails already. I provided a suggestion:
> > bail out on error returned from gpiod_get_optional() even if the
> > driver could technically continue in some cases. I don't want to have
> > to argue this anymore.
>
> I'm not trying to argue. I am trying to find a path forward as a
> concerned user. I am also trying to figure out if there is any way I can
> help resolve this. I am not a kernel developer, but I would really like
> to contribute in some way, if possible.
>

Can you test the patch[1] I just sent?

Bart

[1] https://lore.kernel.org/linux-bluetooth/20240422130036.31856-1-brgl@bgdev.pl/
