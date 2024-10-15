Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307A1AC420
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979560; cv=none; b=efHZGQHy1yKiLqBix+jhMcH8jQ0HhuABnnmh1zayz6zPu1beDc9F/7Z+EGMac5viOC06XwXtxGxiO/qskGn/FQ87MGNHzpyEjorjFEc76NGX42HHkqo00dh8T3voJTU8jR14KLZmz9JawjyL9gbQcYXf7b7rE7gdejyCt7oIBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979560; c=relaxed/simple;
	bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEk4nTgmfbucvRiPVbLPbMC7h+ydo+qPMEbk7+1hzbFSSZQSU5B33KC7Pifx2SkUrJvNR05HZo5uCa1rhxX1hGRxjTyRGTQnXj0rP8pBMTmj43IfZRFQzgNVV4WRIqoGQ7gZNDKSxSlt51d+Or8GSqLAv2XzmCholudeTMKVdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIy00g5u; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIy00g5u"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so6720176a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979556; x=1729584356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
        b=uIy00g5uc5/MNXBoMMXjv/FkTQ1e2ymwkzCw8jBH62o4ZHiIODDL+m6fGgbnWboRLB
         jxX6arD5E7wtF4tCumoAth6sQ85E8Gqna2bh71o23NDFzITPk7/P1MXWYYCY5ypkMBuB
         A0XfS4mObQ1jxr6aX0dCL3HkR6vx44zSut4FqLYFAqx9IU9nvLNjhjoS4IMAvp9P/UXx
         Ewt8HiLpOlUwz4bJ26VmBxRSeox6KxaC22AHY3Z249mGHo3e7MbPZfAKICQ7ZeFPJQPk
         wr5j+wbfWp89DquCFjB/z6CHFiIAYlTt8clpVCFq6yEY4Bf83H+y1OtpMGVC4L60arSS
         z4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979556; x=1729584356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
        b=kRDIM8Af11Zhff4NzFbqARhKcbCBph+jXBdKStyCf1NMXtl1+vU3n1qUf8FnqIvNUz
         AAumUr2/bZlGnbje9J2KCdN53ygJBkmAKZhV+7oIDpp6yNd0eDgThbVZ4EZhcdCVW4PW
         mKzgAQezIxuJhv9h/4l0f+IZ4Nuz2+8Cd+Pyl/1/5oyPVyK+HFZdJvjFgjFF75oKksd6
         1aG75Qgkl9i0M1dFpgwxph/pzbOpFmA7iTt5cRtOCMc5mnoO/TYMp147oArjEy/xqyc5
         D7yG4aSV8WaBPR9zsMIZrUFSUDi5BQhkwp9+CSYCdatOTZCcfJtqgVwFw5xn2+yb5wwb
         RUhA==
X-Forwarded-Encrypted: i=1; AJvYcCWtn2tu2XbgkrQKFYXu9uL8+zB7niXBLZgkgRh90P/0Y74xgKgcv29Z9XENSWlVrE624l5B0nrWzIG9kC61fyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIV8R5OPrAeNOUs8Yrn1UEryjZOu4qRoBcu7n61GbMq+o+lxF
	ySspxrXBQneM5Cx7XlCuQj4LgeciZw0j4gaKFPHMDJ0BbGzbr/X0RoxNi6Zc/CEvnSHZmW70TlG
	4NxDCTJpxQ9lGniaW+RlHtOxPUH5fO4Vid0T5
X-Google-Smtp-Source: AGHT+IF0xxh48FLIEsnDmDAKak+sCF3RjcMU7ZWLhjOUWb3x23/TajMFkARYnF26YLJz7ZmTIiE7WFXReASZlV8NFgM=
X-Received: by 2002:a05:6402:2690:b0:5c8:9f3d:391b with SMTP id
 4fb4d7f45d1cf-5c948d4faa2mr11526448a12.28.1728979556044; Tue, 15 Oct 2024
 01:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-7-ignat@cloudflare.com> <20241014213705.99272-1-kuniyu@amazon.com>
In-Reply-To: <20241014213705.99272-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:05:44 +0200
Message-ID: <CANn89iLMgdebS-EZHo4mcQtgrG1AmvK7xKTmPL4PNEmK1PzDVA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/9] net: inet: do not leave a dangling sk
 pointer in inet_create()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:37=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:05 +0100
> > sock_init_data() attaches the allocated sk object to the provided sock
> > object. If inet_create() fails later, the sk object is freed, but the
> > sock object retains the dangling pointer, which may create use-after-fr=
ee
> > later.
> >
> > Clear the sk pointer in the sock object on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
