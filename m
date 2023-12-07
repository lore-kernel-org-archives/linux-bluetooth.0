Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bn5DxgBU"
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F2DD5E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 06:01:53 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58dd3528497so360167eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 06:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701957712; x=1702562512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgofkDV1QE+maxkL3S2zjSbu6oUy+IWDuYDQrR9vz/Y=;
        b=bn5DxgBUnGSxosVGKf/1iQfI+3Fao4pQFZYZSwTiR3BlvgJxWaJQ4YW29MdieD60AZ
         JqGWwhfGKZiPrafKGq7o5jKklPgi/m0jVKbsU1ODXtMwojZ1izUmm/WfpeC5PXbgqeqa
         8vhGYMJIo4dobjnAA1a6sL3zMWD/HzKacYCBizpitBiyVbEWigOSwjLuBiCpohi04Iu2
         8H1FI431fPwq/Qv9QvZoEO5uwiBN7UELAZ8esHT4ASzt8zF6vIJRTDsrLcdJvMIvI2ob
         cDhLjWiFSlap+VB3dC00F5qwPUw8ykDCFqqdLuNZfFjsjhg+W+cyrxQA9oCKrF89NaoS
         7e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957712; x=1702562512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgofkDV1QE+maxkL3S2zjSbu6oUy+IWDuYDQrR9vz/Y=;
        b=gaijLijDRxCWiz/Doynh6Z/vT27OCwY29A9AcySmuOLW2ChihVcx8TTp9iN8IW3J4M
         jpT2ytjwtfIvIKydrX9GkAF1VIpuR5Ma/UIodC4E7C+ynbOLpqHirmjt+OlkHLcsdM9K
         47uZn5muyuzfYcRXenpKH2CL7vcVMVZ/rJ6PB2C/R19bdBgPuSNau9aT5OKqrRuFRIaq
         lH7+WKgizqupF7w+UNoSGe2RexTnGWZCUpL+H7q1BN0TcmX8dOiXg3MDpoboBbOlPGFl
         BfZkTlJTyO9Qgjuex2aMwagzclAmU+F4e0+tDVaQpO2C5ZqJMXRjuOSpVSTuuqvp58Pd
         O5Qw==
X-Gm-Message-State: AOJu0YzOn7RtPVT3KW5HCFOkokAMYgtE8Y7l31yRnZ4RhGS0ypUKr31H
	kZEI7S0SEjGYPGRoMYHbycq5yyci2w3twRKdi90STQ==
X-Google-Smtp-Source: AGHT+IH4M1aBn/CT31gTrrwolpvSe2SEDODFou3tTJp1e3rmuWcBNBzkdyGi0z/PBvz1FAZx5dIKms1bMl6jOkL3qeU=
X-Received: by 2002:a05:6358:7201:b0:170:21b6:627f with SMTP id
 h1-20020a056358720100b0017021b6627fmr3209750rwa.14.1701957712079; Thu, 07 Dec
 2023 06:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207091202.19231-1-brgl@bgdev.pl> <20231207091202.19231-3-brgl@bgdev.pl>
 <e58c7338-b01c-4327-9835-a3f4f8986a4e@kernel.org>
In-Reply-To: <e58c7338-b01c-4327-9835-a3f4f8986a4e@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 7 Dec 2023 15:01:40 +0100
Message-ID: <CAMRc=MfGzVODRmhxSjSc16TjwNrLSXS-WWgeSPTDkEkFo9mS4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: net: bluetooth: qualcomm: add
 regulators for QCA6390
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 2:26=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 07/12/2023 10:12, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add regulator properties for QCA6390 that are missing from the bindings
> > and enforce required properties for this model as well.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
>
> Please kindly resend and include all necessary To/Cc entries.
>
> Best regards,
> Krzysztof
>

Sorry, I just used the command I used last but this time there were
additional dt-bindings patches. Will resend it tomorrow.

Bart
