Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824122DAFDF
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233190; cv=pass; b=CEVfyLaHZyx4jm3STklPLEmAXSjMTTrgumFMEU4wszFXIWXrsvCfRMDJwjtR9Uj3D91nM2NlWoKOroccQ33D1HC8N7hw1moBh//m0FTGXgxz7Us/I/oeuQahHh+ymKG0mTa2xaKLM3SNtuTmzg2Ij4EgiJEMn61L1gUb8xvKiNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233190; c=relaxed/simple;
	bh=+rXDDFLQDArOQ3OpBWPr6bJky/k/FwKl4uLEemWTr3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTvHeFvhtvokv5cWmimhGh2lRJQIgWhEreRPHZpZdkno5gysB26hfJbCkMZ9CY7i9npyYZLlQ+giV+xXieVph9engVDFigS/RpDtst9k6vuDDPTz3/rJTsQQMhABTTn8ByCRqwCekH9yl/A1NV9I2SPRF4oNBaD9IuqgpSKrob8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAowWgm+; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAowWgm+"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6501c0399c4so1898671d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 09:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233188; cv=none;
        d=google.com; s=arc-20240605;
        b=eU0B2VplnYuIW0MvlFFucsJFBUAKBRBitLUys1WgnnyK7eWgpcC1kxfU0qqIsnuKXU
         V/q3Df+kvJAb/stSYiITa5tINNHmAhFEJsVA8TtpuV8wl5yLRZoiaZJiuypY8Kx/yzRc
         F6YgFUlUTvHRUbLS/8hOfk0mUw4v08EkArXnSUzmWp0t8+Z0iND8WQPjM2PlVRRcVPtV
         YDJx5kdE4VwXWeafh3XVys4/Kh6ZtkRcgYi4HQLNN00nxPH1aZsVIocLrUR7U5f9Cj9c
         4lnCuKSiJDqwBs7xJ5PtVIqs2YlQZqgb6qlKGf4XJL0Ajar06Mk1adC7zpigit1+m50U
         57hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+rXDDFLQDArOQ3OpBWPr6bJky/k/FwKl4uLEemWTr3M=;
        fh=tbbRaNhvA16tEsUG1IZx+w7ONEd5uTk2n4iN5iGITFo=;
        b=UYCmeAVC7zuVHbgFMYtSkHJ91W2+OoC18XYYYfvFNkFiUqpZfPRgXeE2L5LhXTSf76
         OvmhoApdzN3ulFFYi6R+xIxUcm22E+HZIbiilj00lOgYPJcsm/xVDFNso1CHi9l3haeN
         MzINz3CBiKYZ1uHU6vGTukXe92QvhBlgxMXs6w4F9pV1yv1jfHDO6WZD3ySQKx14dxpV
         G55hwfyYCwCy1+Qeryp+/22A+vBsx4RCqBFqbRmzxhiVekc2uAjRrh8yu4cj+jAaf18A
         sQFHc9stoWXDfM9xwwWy44H6nKMreF3J+kXUNXY52SZ9Wh2PL3sNlAetqC/cvs9FPeng
         h9Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775233188; x=1775837988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rXDDFLQDArOQ3OpBWPr6bJky/k/FwKl4uLEemWTr3M=;
        b=lAowWgm+5soIPA1UC9FAgu5uLgWgetQlN2G0N0fXAI440rbKEda1wrx2ep1PmMyotp
         MlFUqdqZ3zUQwtZanKDgUsEGzMntx8qkGETnWucdmbZPSFB8iDZ64be2lj4OiWbaK9kb
         pfYh9XxPZ8N55/XSQvVydC44s0tAVrCtIyMisyMYP+HOGJuHzTOuy1q95k6kH97hMzDS
         w8vbGhDqdp4pR1Zrb0OYwn+vgPlAdq9OCaj99KckkbiSXQT+no3otMrl036pEIyToSAj
         2wrnvyQtqcHTkQqZp02qT5+uhYGZlL9MQbiMGiRy++i/oC2cTMfNdlB3sfUJqsioMEg9
         2JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233188; x=1775837988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rXDDFLQDArOQ3OpBWPr6bJky/k/FwKl4uLEemWTr3M=;
        b=T6eVLB2ub2ALrF9WYa18shbxBjdUrmgTtJbwxm8JBGSs2gYdnNe2x6wHz7Xk8eppnH
         40KS96UuEt470t9JRKGemwesAnRQgurcsYo/ICsIfNPj0uKaSbai77kYRRqwyh1DxqLZ
         W00DZYoRCd7YqXEldpH/ZG43lNloHYECUVHMvO+JAjnXh+589ei28fzQbthHk7WzSUGU
         31T3Z1Lfo1rvCMNxzSNWUILFUGVcrXBivN73Tqf6/HyI3YjsJdSkESvhwZpoMU0qNxxq
         IgyHpK3oPdwVGHwDf0zAvf6XlNfLZvRs7GNlvyjbIloWgsWHp4JH/lzpxKtwpypUT7Dm
         bCWg==
X-Gm-Message-State: AOJu0Yw7h7A29MLSP242dlXQra+h9HbXyglhAQD4jIP7tU/uwgm6wgaj
	OuDAe+Xlkl8lUDVv1s3WHDfz0KjXkIbSFvhCu4HTbTv+XskclPCTFJeMrsA9iT6cFMGFCWGHIPv
	/PRwRukOUtNGDt2CzQn0F+MQg87tRn0774RjgEVw=
X-Gm-Gg: AeBDietlc1yPRaiYDT5QgFmYKnHI+GJLzR3Bpw5O+OwClQTBMPHmt+lpd9WKIyKCiEe
	LiGs8prucZrxkukwPAc8WhZn0xi4vw6Fb/VSD1rb3KF0W9nqSn8mIVFqGsL/7vExgEHOrHZosi2
	1K6cn+a9J4bvtqn1FhAbFo3ZNhfFhkNDJWeXPx5veF6lPeZgqyqRrUZzZN9Szs5cekNw8DMJBXv
	509+v6EhSFurK/7uAPdtSh8eeN30tee6CCiuGvJT4UqNFBGh3F4awghycD5BbHCA+EK4gPdfvZi
	1ZLXsJK9m9DwaChR71/4qX7gu0RF2WRF0QrMU92XVwfmxYv6TV9s+TzUoSCBJhbLoepMFA==
X-Received: by 2002:a05:690e:1208:b0:650:5316:1722 with SMTP id
 956f58d0204a3-650531620f8mr108916d50.46.1775233188210; Fri, 03 Apr 2026
 09:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403023513.25151-1-phx0fer@gmail.com> <69cf4a08.050a0220.114c76.66b8@mx.google.com>
In-Reply-To: <69cf4a08.050a0220.114c76.66b8@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Apr 2026 12:19:36 -0400
X-Gm-Features: AQROBzDD7fj7UZcXaLyALWIgpyh66_bRYpsXftzEBlGUB2MFFhEHY_q-1J84hC0
Message-ID: <CABBYNZ+4ptA5NB28vJ3G7cq5hE6UyQBP8CaWtb82cGB7xhzRBQ@mail.gmail.com>
Subject: Re: Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
To: linux-bluetooth@vger.kernel.org
Cc: phx0fer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dudu,

On Fri, Apr 3, 2026 at 1:03=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be appli=
ed to the current HEAD of the repository.
>
> ----- Output -----
>
> error: corrupt patch at line 26
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.
>
>
> ---
> Regards,
> Linux Bluetooth

Didn't seem to be properly formatted for git am ingestion, did you use
git format-patch?

--=20
Luiz Augusto von Dentz
