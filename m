Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7552FD7D5
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898220; cv=none; b=K47pehHSGT6Bhjm3ackZpw46yZ8Vp4Yy9Fu0nmLx9MQMHK0uPqjFQ3DfQ5Mqp0OaHMFhbgO7piQmA0iXLvrTmu7144TMxBMX1dwcuBjmysZLdBETX8/Wjg8zre+VWI6vYXEwOHgiVowmsAoboD5Is0NGLbgvg2DOhRZCmMxQI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898220; c=relaxed/simple;
	bh=YdFks0+yLsq/m7powkDCpB3ulz18eg5GSQxRKu2VqgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AILnFYj2jVKIhREFeNpUpChD2iwIytv9Pkcyu5/EOecE5higweMcAoDmvw/n5r2+6/mlA0v7y+R0pRDoireD7rIqDlwQrV9pS5600oj7ShoUj0eW414pfVW1S3cdmbOc9elmZkNPBTpvvUxWAHlJWX08GkCJgmdzUjNfdl8ExWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfim639d; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfim639d"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64daeb28c56so5383242a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767898218; x=1768503018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPFXSSpv2jCr8WnWF3Wp3QAbz0DZpRLzmZnpgCOUCww=;
        b=lfim639dOfiHbu1l/w7btHJL905YeSCwoKHvzElUoPYdsi5Z3C17Iz4DOjIwTs05ic
         998Hu04Wc37gqW/x8qJVKHZVBd9LrUQem2mRyiO/WFEn+iWFIC48d8y+NH8GdZweyqDN
         ki2kqfYDthwR3epdYrs/zx80bPMN+hexXsmFOk33AJZlBxnsVKV0Yn1uAvs8axF/fSA/
         ObpyIQF5U6s3K1iDtG5MtZ7a18BdN5HpxYcYbYF7SN4Hv4raKlyIctCuv2JMK+zJWBaz
         dBAMTVSwG9Yhrq0xJyoqJFhQIGi5GGUYSaLhCgkGABS3xjN63A2WRCxXvqvQZA1o66Kz
         tNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767898218; x=1768503018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPFXSSpv2jCr8WnWF3Wp3QAbz0DZpRLzmZnpgCOUCww=;
        b=tiBxDdh1nUKvkmpo630sjrEH1KNTIl8MH3wjpDCq1pFVGXNKGuFysDi7e62AYGCEee
         1Q2NHWUoAUkUA+SI8iI9ea69W1sc4Zo8BDxUmDEilUbOtBo6YFEVEOlPWBy4qyioEfEH
         bZV/Vf7egMPhK+Q2UHLloTNWeg+FneLdipLAB7/UdzkaSUQ78z2TVFL/KHiW9DSLQRgM
         YCsg8NrjtI+LtC5OtW4Gr0SdCINkH+9YRX5xIBwpyaf0nJQMcia9OEPghzyBbCwW+wEo
         FjFCuk0ASxEw41bfEWcxmHksJby4aJXSgEdHksnSkxgRii/gvaWsbulT7fTYqegxqkcm
         aKDg==
X-Gm-Message-State: AOJu0Yyh4lDsMwG7ev065tPijod9ywi4bKQatIsluS8DA3EqpdsDtXD1
	P5+t84dFSJm0DPpjDtPPDX4Ib5akdmC+IJaMl7AasG0qO0nkZDcGPK+mknPj1y5yZ93ZJMlzEl3
	Co+0ZSDZDyrjlpBbUkAYFkZvbHU/5hB2Wiq/R
X-Gm-Gg: AY/fxX7A79eCUO3LkzqCB8r1XTYGrx8FAcYHKHc5JOt0uvZIDW3RtplMMd5oYmI5vzB
	zf40x0bmFfBgA81hz746/R+SdduFuG2zld4HMOR5WYaKeOOgq0FC4e9WBzLu+u7dcyBvjrTxuTo
	Rx687IyAfxLQCryoeKHd2AlcBLpKA2f+6n6BpIPOiUKvpWfJi4yLGl5+KbuEtO69Y2ZIo5p8jAv
	hBDMJvt8fADvXp5SX0qYEHyL3je9eQevu0D4Q9Jt23RbCM+5i1ws8LOjIU/m0tfhJOHnqoWTlsL
	9i4sj4zRzpi5v/dNNMnwRlsrPjnutCP5Z1wRsdg=
X-Google-Smtp-Source: AGHT+IHmTi5b9FNu/kVQER7LTe6q4vVom8BPTaoq14e1zR9Q/JaAF2QxQfxhxbVssseo+NbkrPbH4d3/652LKNkPphw=
X-Received: by 2002:a05:6402:3481:b0:64b:6ebf:b65b with SMTP id
 4fb4d7f45d1cf-65097dd295bmr6056302a12.5.1767898217512; Thu, 08 Jan 2026
 10:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108100136.486675-1-dalegaard@gmail.com> <20260108100136.486675-2-dalegaard@gmail.com>
 <CABBYNZKT91_1arQSNSxzy-4RVVnAX+BV=Vw6qBMyCHjQSdE_KA@mail.gmail.com>
In-Reply-To: <CABBYNZKT91_1arQSNSxzy-4RVVnAX+BV=Vw6qBMyCHjQSdE_KA@mail.gmail.com>
From: Lasse Dalegaard <dalegaard@gmail.com>
Date: Thu, 8 Jan 2026 19:50:04 +0100
X-Gm-Features: AQt7F2p3FbPtjlAgHFzN3F0uDV3_vEK-qgVJ6grZk5lqUjLkGaSfqdWVbKSBij8
Message-ID: <CAJWtJbasVwvFsdhOpc_fBUW_vSyS6=YbRza7LRw3e8mWH44ZbQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] device: fix memory leak
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, Jan 8, 2026 at 4:28=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Lasse,
>
> On Thu, Jan 8, 2026 at 7:29=E2=80=AFAM Lasse Dalegaard <dalegaard@gmail.c=
om> wrote:
> >
> > device_add_eir_uuids creates a list of added UUIDs, but it was never
> > freed.
>
> This seems valid, how did you find it though, I don't recall seeing it
> with the likes of valgrind, anyway it would be great to have the
> information how this was detected.

This was detected with the address sanitizer leak checker.

>
> > ---
> >  src/device.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index c8aaf042f..0842becde 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -2453,6 +2453,7 @@ void device_add_eir_uuids(struct btd_device *dev,=
 GSList *uuids)
> >         }
> >
> >         device_probe_profiles(dev, added);
> > +       g_slist_free(added);
> >  }
> >
> >  static void add_manufacturer_data(void *data, void *user_data)
> > --
> > 2.52.0
> >
> >
>
>
> --
> Luiz Augusto von Dentz

Best regards,
Lasse
