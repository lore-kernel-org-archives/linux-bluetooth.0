Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937F180A82
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152202; cv=none; b=Jf4DwYFtL9N9HnG5/0iuFFapgRtGULqcWEgP9T1y3pIU58F2e4OIKuW4I3d0yQ9B4kuAeH/nAJFoyXD2mOtksBYvRengqmG0ZPtAnrQyIItAjhggIT5es3tiVKFp9WR29Lz3+fva6AeLHEzRbHVziDXauylwQlOXUUiVOSlqMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152202; c=relaxed/simple;
	bh=TbAqAZMa48AEaJa5lPdAp3ni2GqN7/ZGJWpLUJXyUQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7MOjZmTuuZ9WP7yGvkwzF9o9CH6gqBnvWqOsc81bc/KUjds3WdZblWFSPcQJesKDq8l4xeM/GpjZ26SocJ2dGFA3mog8eF+bJLs8M/ZvYdrK5mGJmji5EzndY5SKYf70Ec+ksU9IWhnZY2CBDDbO6mXNjBUSKMTaV8sF/daWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CX2YRQHZ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CX2YRQHZ"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de46da8ced2so2713713276.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714152199; x=1714756999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UJceFXtAj6qD9Iyu1pCp/3Owr12F1F0llf1/MqSjXo=;
        b=CX2YRQHZ0XnZ0z6mL4+jRpPpju8zmhm6gWj9wVptAfmANvhZHZg2Wvs+FuFGedK88b
         HAYyS4busKpDaLfqHFTST4GPkzDGSdNv0t9vYv4xKiJXHHvbVfRqi9EhgqtnCSQDP0ZE
         pKHJ3vteVcbVjdjuvCq+tcrfHjxLBi/l6J+ijtk9QSLn0aZ/rZzZ36gc0+0NkYUDITf/
         pYKtKjC9m6532FLREOlMmCbWqyRvoLnug8KF6CTYDuQTCO4ruwRIbU6SW7bdh9vCOtXK
         KYxYDS3OCgMmdfi4F13r28MQWxm4tWXZG9vB2xddRZJfVY2/1Z4fFAhDjy2RqIpClWtZ
         IXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152199; x=1714756999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UJceFXtAj6qD9Iyu1pCp/3Owr12F1F0llf1/MqSjXo=;
        b=SYXSHSal4FeT25jv6BgK/XODHuBUUI0zWO+y0ht/oiF6CmmCvPbgsaK+g7xdUrxsku
         s8TUSaAgob/8mzbeR6V2UPLbPy7N/lyUqNeOLr3LZ8NGKPNl1lOjL3U5/3FU1BNwzItd
         rGhXN9s75n31Vr+qulpq94dGPm19fcXMoJBHXzt/No7oto2DeKLFUpvUomK8qC1c111R
         4yMN4SQUHZ2cRmk1UsmuK9obt87QvTZ9P8zAVf06XYaMpJ8DdBgMFgDk3CasspRtqYRQ
         I01an5+7WtmRbQTew4ZDtjTRpJp0tWU/l5MG1qX87N3ha1NzhSJGPJ84anHx1fW7UWx5
         7d5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBZ9R2zciBbDk93JUBUnTESQjhPhCM8787XYoyyqbncrDMkbXaOPiFJUZBTZpimyPl9/UJc0oVDfuLmZ9d4blRCavtrX4lUNq7yoUEP3WZ
X-Gm-Message-State: AOJu0YxQTUv0ZT0eEcQmO1agywcWfuUbM6PfOuVRsieWsU2iRuFlLJA6
	zumwqtophC+la1Ry5GEKCtvlC+YqvF4OK287RQ0PmOBsXWczL68gqNX0z7LmbIeFqQyQqu40i74
	1Hh5uWFMG7MFkOb9FgjgHr9BX+EZFD7xXwzbnaA==
X-Google-Smtp-Source: AGHT+IGDmBlE4gfNnmV7uJbF2QRoEiDRzqeAQnXvvB4EdKVF0e4x8T6P8C28xhKLIKrDnt4aQk1wZKmN320JvvxlSfQ=
X-Received: by 2002:a05:6902:4cb:b0:dc6:6307:d188 with SMTP id
 v11-20020a05690204cb00b00dc66307d188mr3324902ybs.25.1714152199442; Fri, 26
 Apr 2024 10:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <171397322792.12898.8815870206676100532.git-patchwork-notify@kernel.org>
 <CAMRc=McMMtRid6OaYsc0PO0qsS6z+Ny127YxwNcjbo7R2Mze2Q@mail.gmail.com> <CABBYNZJOdccb4HKVBnuqK=_xVzViJ2D2+QJPSyyFGE2_Y1VXCg@mail.gmail.com>
In-Reply-To: <CABBYNZJOdccb4HKVBnuqK=_xVzViJ2D2+QJPSyyFGE2_Y1VXCg@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 26 Apr 2024 19:23:08 +0200
Message-ID: <CACMJSetqjsu=zcS9GvtgDnODB__s21FfFxfK7_kVkCLvbKy49Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, marcel@holtmann.org, krzysztof.kozlowski@linaro.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wt@penguintechs.org, quic_zijuhu@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Apr 2024 at 17:09, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Fri, Apr 26, 2024 at 10:37=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > On Wed, 24 Apr 2024 17:40:27 +0200, patchwork-bot+bluetooth@kernel.org =
said:
> > > Hello:
> > >
> > > This patch was applied to bluetooth/bluetooth-next.git (master)
> > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> > >
> > > On Wed, 24 Apr 2024 14:29:32 +0200 you wrote:
> > >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >>
> > >> Any return value from gpiod_get_optional() other than a pointer to a
> > >> GPIO descriptor or a NULL-pointer is an error and the driver should
> > >> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci=
_qca:
> > >> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer set=
s
> > >> power_ctrl_enabled on NULL-pointer returned by
> > >> devm_gpiod_get_optional(). Restore this behavior but bail-out on err=
ors.
> > >> While at it: also bail-out on error returned when trying to get the
> > >> "swctrl" GPIO.
> > >>
> > >> [...]
> > >
> > > Here is the summary with links:
> > >   - [v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by g=
piod_get_optional()
> > >     https://git.kernel.org/bluetooth/bluetooth-next/c/48a9e64a533b
> > >
> > > You are awesome, thank you!
> > > --
> > > Deet-doot-dot, I am a bot.
> > > https://korg.docs.kernel.org/patchwork/pwbot.html
> > >
> > >
> > >
> >
> > Luiz,
> >
> > I think patchwork borked when picking up this one, here's what the comm=
it
> > trailer looks like in next:
> >
> >     Reported-by: Wren Turkal <wt@penguintechs.org>
> >     Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >     Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-=
git-send-email-quic_zijuhu@quicinc.com/
> >     Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use
> > IS_ERR_OR_NULL() with gpiod_get_optional()")
> >     Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >     Tested-by: Wren Turkal" <wt@penguintechs.org>
> >     Reported-by: Wren Turkal <wt@penguintechs.org>
> >     Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >     Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> >     Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Reported-by and Reviewed-by tags are duplicated. One of the RB tags is =
missing
> > a space.
>
> Oh crap, should probably not trust patchwork would pick up the tags
> properly, that said the pull-request was already merged, not sure if
> we can do something about it now?
>

Nope, if it's gone upstream then it's too late.

BTW As a fresh b4 convert I highly recommend it for managing patches. :)

Bart

> --
> Luiz Augusto von Dentz
