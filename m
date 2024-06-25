Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC4146D7E
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301677; cv=none; b=jFVUXD1jH2pc/O4DErxwhAbQk4wG3V/BjXOPSjEZMMNxTm8zfU2fV90I6ax/cGH1jPMD/OncuLx5xlQ+vO/RNZlOc9gRMBDqF/2keUUme2HezGL+CfkDmq9T5LHvVuvGuiOQpRj8FSu46ZH4fLlvkQ7eXqOMywwwBg2Zim9A7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301677; c=relaxed/simple;
	bh=AIasVcZh8Q9n26/oWIJ49tLdGx5/eCZCzhQn5GDgxIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aamJAV2CYwNAQeHRzQiWU3AFmfA0QbfUdd0jxPeJ0rFlRx6RqO1dJqwnpxVh2ubW/iK4hCMWf2TL+uen5qIF3h1H4fdWHZlVQ57Q3C3fIyuk+JzU6xlDnjbXaiKtiq1jPwEZ7kmIn/G74AiPYVswWTS4gVBQl2H+ZiyD990qPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jB933lXx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jB933lXx"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e02c4983f3bso5235039276.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719301675; x=1719906475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIasVcZh8Q9n26/oWIJ49tLdGx5/eCZCzhQn5GDgxIU=;
        b=jB933lXxJHgiJDXjFqxQRRD98B4tHfLPNcxAuy2owL4WVPuZyRJqt9laD6KUYDwX/e
         wT0fZkyCKRwmqFZcHg/wbuicc1KrXAOY37nd91ohfKWxOqa3xcMIhEh+6P+3mLf8d+ls
         icR3XEjm4HKamEh/PI8PyZpxXnsmsZHqevTfNS8AZhTdRDTwe4iA3TnactzknKtPoUrS
         c+OI6gH/IL9KLBFIkfLvy+XcwqLxATf/V+tcwAecbX2Er1AsvC5nwla5XsH+nCoGQDrd
         8ZsiEzmn1KLPu/bSV+TFl1hcZqcF5oqknmBPCXK57bGrHrURkP/mH2Z5amyYyD43Yomc
         Zhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301675; x=1719906475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIasVcZh8Q9n26/oWIJ49tLdGx5/eCZCzhQn5GDgxIU=;
        b=rUUYtlEUD2bRY/OYjnefCY4spW3kG5dWomvvkloBvCb6c5Jv6POxLzAFejQp+D7cQW
         8NBbO3WmKR0dAZelAUTXWUlBbqUA164n6+LsbbsC1ymJ61abyNo0vT+GJkZ2DXK8BmNy
         FWQLpouU8BsFn6vO6RhAz3x6peXdR4N+mQL272jUFWdhqvcRl9KDdlwzHQza7bC4wAhN
         p56M32rRjqioLMwgmVzzmXiBTMhFtlikyguVa+dQMicLJ8AM8S68/uK9LbJRD7VVdTAP
         lCSfVpGc4uf0sb4FiV+8KqnBekkcVf/DwL1NXGAus4XtmuWAiJHa6tHNSmcd26waekMY
         h+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxkLVpb//EY7LWejucDwhIKCLJwbe9Q44KvEamAO4PcJ6dB/DaFpmiT5+uBZYxXIhn7nFAieAaQ9GvG8PZnPPcs+V/GX7gLVTZl3DaDCYL
X-Gm-Message-State: AOJu0YzwA5XITgjrQCYLPxiUw1bB+SP7d0edvVEWh7nQXOtKrD/1o6tp
	fEwn0QFN7ArnVHo19MIqUikX/YcPk2K6ZLeyGDPTQILaTFt9bNKDcz5qo87HMNPqCm2H3uQRDlE
	iSCWtgXe02augtVws1qVGzJqYdAma5/8RD69Ebg==
X-Google-Smtp-Source: AGHT+IFvv5BbMIX5MciguKgsROfR6aiLN3eEUI5FPNBiBB3EVQOmv25+Nxm+8DYBYtBabe/U5eqWJPBqviOYInnZPdo=
X-Received: by 2002:a25:949:0:b0:dff:2e48:7aea with SMTP id
 3f1490d57ef6-e0304014774mr6889264276.43.1719301675146; Tue, 25 Jun 2024
 00:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com> <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com>
In-Reply-To: <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 10:47:44 +0300
Message-ID: <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 at 10:46, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > >
> > > Neither of these has clocks that need to be driven by linux. The only
> > > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> > > before so no commitment was ever made.
> >
> > This might make some laptop users unhappy.
>
> Like I said: without upstreamed DT bindings, we have never made any
> commitment about the device properties. I doubt anyone will complain
> though, I haven't seen any DT with QCA6390 with clock properties yet.
> I wouldn't stress it for now.

I was thinking about x86 laptops / M.2 cards. I'll see if I can locate one.

--=20
With best wishes
Dmitry
