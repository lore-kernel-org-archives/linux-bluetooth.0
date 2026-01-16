Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC139446C
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574555; cv=none; b=RLcAmZILi8nGPDRR+t1xq3uwqcLwnZqUljT0MA9Kr5JlBEhT5XVOSZv2xaSTS/uCM9d9DhCAzuM/j1ShdgsIx0tZqpy/j1hcwpF9PGC28iHbwrgHqV1TLqfPrSZ9lAsadh56Cuj3vJoa6sx9Wq05grKq96PqfBSI+iGleboyBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574555; c=relaxed/simple;
	bh=KX2IErmnbLgLJTuS0TqC6Ce02SpKwHVKEysgCsr18GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajRgwibe04IBh1nLRleFQV1S/7EXD+rc29Zrev5Ej1KMtCqsQNmsidX9KB/4EvISp0vrTlh+v8O+qa7TYK5vKzk1zVlhQ1wyx3+mgPs0Qi1oL+Mj2tMVl+aCwrnC9QY4NjISaJZ/k0/iZ0D/2uEV7H2lSuxvuvt4APdW0t5V3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxm/VcE3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxm/VcE3"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7927261a3acso20739127b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 06:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768574552; x=1769179352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0Wu6AiQkkS9+nilzgzJB3rMYTbS0yo7XGq1n41xVt8=;
        b=Rxm/VcE32t8SMJh3xjpZeY8t3pVt4CmxUbjEl9LWH+rgZso13cQ4bCS/kVpVtLkxRX
         yZu9GEelMDIa2tDnC8ycKTSELBaHkpwR8hQc8EpGiL7nbAJvCZy9z3tMFVnLdN71Fuo+
         q1euxx3NAmv0hvfssy6YGSuQh4KAz1Mu+JlIKR30bMhkUUXAJvWfdOVdulfQCcgITKD9
         M1Nc4bX4RnSvlcgk2OdktrtHUmKb75SNVnEhBNzLJz9s5+bTLvB0SK0Cqt4CGC1sYFr6
         ZiFoeRkR+ywalXaRESedd8XycHDuK89wOJYd+z5M1mPtkSUOao/TkO7AHw3zZu53oYpQ
         eB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768574552; x=1769179352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0Wu6AiQkkS9+nilzgzJB3rMYTbS0yo7XGq1n41xVt8=;
        b=COqcwDgZRxGpuVqdnr8LlMRdFjoSw1B1Ca0IXBdQStnd+wtI523LLDJClF2Y0DmkKy
         6UTtWdwo9/M//N2eNakllHgVSkjf99P75DHzOWNOeqryfkUKpRBb8GJipCd3kXtnroZJ
         dFUCPpW1AK+VZfcdPneIOkSWqNBkQm+qYT4X1tN29kpHnh0UiDplk6s8G8hfUjBxYJvz
         OKuF8tB/R+2lFn+tk6p0bg68LUJEMQ8nu+gdIYp/vrCmFE2uwBv7Aln/SvxY6kSgKLgQ
         3moVhHU6bFbt+bmmVAviTfnEHnAoro7yIvKOz/wOWFcJ+Y6lZtq4K0UwabSBfyBZq7i7
         jOpg==
X-Forwarded-Encrypted: i=1; AJvYcCX6tM3kjLyKaKeCO2OfY4HUYz29td9ObxdDtY+0URI6fA6AwCWR8/B0Hb14gVoQtNYWgPmLWpkzrsalMU14k18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqOQqiHZXwBi2tDGo+oyXX0OzV2DwUybzn81vD6gyqZi8eWB9
	arYpz43GXqHgZfaHIGlV+AzPddnmaBPOO8m3bUHFDeJZDbYOcp6miFohVZ/nZ41l+aJYTFvPdt/
	cFnm1k1oNbYQ2xLyPuBS1KkHlGeJaj6s=
X-Gm-Gg: AY/fxX4dVYXuN/gBKYu8fHT0nXocveMBQWT0X72yonV13tnkdbcfjcn1XbM5e62rpuw
	vxpviFzQI0lrKf8hfU8JuTvSRwvPWb+l7i9hHk3ZEyLIVUjjXoHBoc3bm4r5U+n7Oeqb20VpXv/
	Gc0DeJkOrZUvF7v7deagOQ6okV6X9okWjCXyz/8b9ZEqbBRCpG+lqYc73gfVz65IMgTTj8izZOp
	dPXG3xcMtIHVEKQIJWk4DdhZG5LO37iF2SXrQn8/hg9rIftNsXnX5N4tpWgd0047KnHq5Kam4gI
	yfvrTMvpWYgNt+MT7CjZUjOSmhlufGFMCkQ47cpNeM0M+csAAJJ7dVfQP/q8j4fMzzgW
X-Received: by 2002:a05:690c:6609:b0:792:7828:b709 with SMTP id
 00721157ae682-793c66f4bd6mr24042237b3.22.1768574551609; Fri, 16 Jan 2026
 06:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
 <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com>
 <212ec89d-0acd-4759-a793-3f25a5fbe778@oss.qualcomm.com> <CAMRc=MdoUvcMrMga6nNYt8d-o8P-r3M_xY_JHznP3ffmZv8vkQ@mail.gmail.com>
 <96472b7c-9288-4f81-9673-d91376189a18@oss.qualcomm.com>
In-Reply-To: <96472b7c-9288-4f81-9673-d91376189a18@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Jan 2026 09:42:20 -0500
X-Gm-Features: AZwV_QhPiDz6MueN4sUXp8m2kkBxLdWM5NMAxLszIhWWEfsuGtFDaz5gEkCX6YU
Message-ID: <CABBYNZ+5ry0FWFSgOskw60jja9mE6WG5AwOi2pKxrkzqMn9bkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Shuai Zhang <quic_shuaz@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Fri, Jan 16, 2026 at 4:48=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> Hi Luiz, Marcel
>
> On 1/16/2026 5:20 PM, Bartosz Golaszewski wrote:
> > On Fri, Jan 16, 2026 at 9:37=E2=80=AFAM Shuai Zhang
> > <shuai.zhang@oss.qualcomm.com> wrote:
> >> Hi Bartosz
> >>
> >> On 11/7/2025 11:37 PM, Bartosz Golaszewski wrote:
> >>> On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.co=
m> said:
> >>>> This patch series fixes delayed hw_error handling during SSR.
> >>>>
> >>>> Patch 1 adds a wakeup to ensure hw_error is processed promptly after=
 coredump collection.
> >>>> Patch 2 corrects the timeout unit from jiffies to ms.
> >>>>
> >>>> Changes v3:
> >>>> - patch2 add Fixes tag
> >>>> - Link to v2
> >>>>     https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@=
quicinc.com/
> >>>>
> >>>> Changes v2:
> >>>> - Split timeout conversion into a separate patch.
> >>>> - Clarified commit messages and added test case description.
> >>>> - Link to v1
> >>>>     https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@=
quicinc.com/
> >>>>
> >>>> Shuai Zhang (2):
> >>>>     Bluetooth: qca: Fix delayed hw_error handling due to missing wak=
eup
> >>>>       during SSR
> >>>>     Bluetooth: hci_qca: Convert timeout from jiffies to ms
> >>>>
> >>>>    drivers/bluetooth/hci_qca.c | 6 +++---
> >>>>    1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> --
> >>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>    Just a gentle ping. This patch series has been Acked but I haven=E2=
=80=99t
> >> seen it picked up by linux-next.
> >>
> >> Do you need anything else from me?
> > I don't pick up bluetooth patches, Luiz or Marcel do.
> >
> > Thanks,
> > Bartosz
>
> Could you please help clarify this?

There were no Fixes: or Cc: Stable in your changes to indicate they
need to be applied to the currently RC and stable trees, in which case
it will only be merged to next-next at a later stage.

If that is not correct then lets us know if that needs either a Fixes
or stable tag so I can send a pull request immediately.

>
> Thanks=EF=BC=8C
>
> Shuai
>


--=20
Luiz Augusto von Dentz
