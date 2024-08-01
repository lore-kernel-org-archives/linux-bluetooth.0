Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571221EB490
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499757; cv=none; b=r69e0XHF5tarxO8A1/DLfUHLH604n9ehLCH+V4G9WPy4z8valQbJ74S2uvKSx8Nlv3Vk8WjBl7jkZCqY4Io23GEHWzEupTyW26I/4dBnQ5WshJgAO6Ad1+eCwYN/X0/LBUugmN3Q/54e0FzfCOOrJ3Gvb0LKEz/zlfiWiDZmuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499757; c=relaxed/simple;
	bh=IvkcJPRsLJL/kSY9pOtqT+Uo6JQwIJNeaSIruS8V99A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZW+9xg8QrOqLsPiFgq2pMU6K5GY+0lucpelAaQU2wYK3p5ZXfA9nnQ+KCr7bg7i4A+2h7sZlGkOZyDMu+bEylQok1b/+tnddhG+5y+6WVVztCIks2XZoTD4/7wtJBPSHTPO0wzpX/r5TZEL9LOWhvZbNBNiCimSZ6uZVaAinYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVZwjp2a; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVZwjp2a"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-661d7e68e89so15404267b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722499754; x=1723104554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IvkcJPRsLJL/kSY9pOtqT+Uo6JQwIJNeaSIruS8V99A=;
        b=VVZwjp2aQ/HCmTcHD7mxkPBzmQTjRUVU1j5v7AZt1Kr8kN+el6NWZ+9NzqPeIeV26I
         qbUQDyISa0cdKTA2qdVv5gc79f7EW3pGC9FnqvIzKkWvx2rA9cA96FmRup0H30mNvfQl
         MOOyp5+FqsPiyVRm1nwUf5fkh/Z0wQbxo4Lzqj0NYdPUJwc0MUR9J1cDFovcIAZtjCZ4
         YQVgWHlyNMJnMVV5ODJxviOJGZzHgQhrKro8b20T39RQ1Liea8C3fAb5r4jEoxD0Jk2f
         jAMtT5w2qHeV4cb6p0AS6qp/3Kn1w4NuJwOKTaNNdS9tWPGGziPyBpJbfFth45CidJdG
         3E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722499754; x=1723104554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvkcJPRsLJL/kSY9pOtqT+Uo6JQwIJNeaSIruS8V99A=;
        b=VxuGymidVoACtspvkXm0Zw1DOKIxJATABlV3h97fpXy74sbmj9Bzus85duPn/j0ljs
         HEn0IMz1xJEYgK9Rlczi7fU2s0rnlwVKlle40KIdmRHf+nC0XaOyo20//SV02LIaQYXh
         6MEkmmWci8XaPm2L2y7IeeyFPZrkq/fyLxLnddAtABM0lDA2gU7cPqi1X8zvffHvVImh
         cs+MYB2XMHUZngYy8fH1KHZHr1rHMrqY+l1m408oHCqXaAvHFenR/AqVmoxlu+uPuve0
         MLh+XPdPnRmmKluW+jnQv14fOC1w8q1nUQJWUQEdAyqsk6JH60fcyooMdfbCzuzmWyh9
         47Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUD+iAQUtalQGCsa4JQdJ1OCb99mXWR+0CRYa5GmL4yrjdBxNJ6MWMjZpg453q3eb1YAmeX3GXcl8QE+Jeuxv+wob/9v+CS9yBJvaUUSMp5
X-Gm-Message-State: AOJu0Yy452ENELFexILPLGLh/6gMfFzSglts8OEMUmokNU8otcWnKdkx
	YhhG6pMvXlPQGuq0kKd6S9kG7Eavv41s5L+tYjiWxZ3rj4qqReUTvqMUMldYnrdkro4tCZb9XSA
	zRfyV161hnPYVFj3BK6knXadGTYprPZhCApqsPQ==
X-Google-Smtp-Source: AGHT+IGz0UyhAohu1QAtEh045Ksj+CKA+FhvPQd6DNHDRe8vkEM2HwS0qZ/5aGELfcDkyVK9kf/1Bo1bIn/SIhPuYV0=
X-Received: by 2002:a81:b40a:0:b0:644:4a1c:1868 with SMTP id
 00721157ae682-688556cfd66mr3426677b3.24.1722499754277; Thu, 01 Aug 2024
 01:09:14 -0700 (PDT)
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
 <CACMJSet3H3B1rz2eZyxUr_ySUOdhTkAognfKpFZ=Kzto8UsxMQ@mail.gmail.com>
 <534cff38-7bbf-4e9d-90c5-c4a4ba331a8e@penguintechs.org> <CACMJSett7WOHWnfNGwtWL0sQQ3K9rqr08W9KDF5U=rJbpBZfzA@mail.gmail.com>
 <CAA8EJprdmXfJYx2xk5fcV4UgWqeBPekrgv1iv7F7FugaBH6=KA@mail.gmail.com>
 <CACMJSesML_Q-Z79XyAZd0sJuE=AbGQ-TWozPWTRmdF3sMh7VHg@mail.gmail.com> <3dc56ebc-d378-4ba0-aed8-03c93e0aea20@penguintechs.org>
In-Reply-To: <3dc56ebc-d378-4ba0-aed8-03c93e0aea20@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 1 Aug 2024 10:09:03 +0200
Message-ID: <CACMJSetaLXr8a9ffpSN3GpH6YOcHn-o2seL4fj9q6iFbfEUxDg@mail.gmail.com>
Subject: Re: QCA6390 broken in current kernel
To: Wren Turkal <wt@penguintechs.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Aug 2024 at 09:59, Wren Turkal <wt@penguintechs.org> wrote:
> >
> > Indeed. I don't know why I assumed it must be an ARM laptop. I will
> > come up with a fix shortly.
>
> I have a question, does this fact have anything to do with the problem
> with failing to intialize the QCA6390 BT hardware on my laptop after a
> warm reboot? As I didn't understand the connection to DT in that other
> issue, does this fact change anything about how to approach that issue?
> I only ask because that issue still very much exists.
>

Can you remind me if you had bisected it to a specific offending commit?

Bart
