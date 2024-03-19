Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEC823CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864678; cv=none; b=WuXUk8LsrLogoRFzHalCtMpHi4H13ebZ5DN0vk7fkvAmTwLcwxDOcOEi2PC08HqVuAHFAbIUCtnb6IjnuzWDUYCRlBUA6mWJJqBLUF6PFkmbR3sMNAlJAgwxfBLOhby/pYLPWvxjPq3PdLsfWqpxRyzKu4wni5JTj0hGSs6vTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864678; c=relaxed/simple;
	bh=rYjMj7ePgUflQEILg5XkDq3SlXHXtDYoYHvIrr8ecTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alG4fw0KTPB+dLv7zfQC1AO6pn5QAmXPkU6eV3IP3dq8g/RuACe7RBO8sUjDAkQkI/624aZv37oUIvmp9DrlNKpsjOKz9oRMvqzb2Z+m2nCQz1yFXrjMoocHUUYwHEVxvy1gOWzdn3y/BRc6Ab9F8s7Uora8cO3LNXbiBU5Q9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lF4Ir/Fw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lF4Ir/Fw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-781753f52afso314800385a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864673; x=1711469473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riAPw+X1m6DmK1tPVpYKEJDjgOP8E/jPhgqRZJ5EE70=;
        b=lF4Ir/FwKWl4PUdieCSv+Zv7EdBjdE+sm/bOgiFIEBq5uCwDsryMcKLQ5m0lf7Hk9x
         l66LD2jd8mIMh6/xNRfvq9dlEe0VU9q8jwypVLz5u+G8y9ewoyWFuqhCBT50atSE6ij5
         uPGRX0ra4yj+53w58X70+UgmxIDJwAzLiHaRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864673; x=1711469473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riAPw+X1m6DmK1tPVpYKEJDjgOP8E/jPhgqRZJ5EE70=;
        b=VpyFoHlIAGI1pkLLOL0EBq1OpQLeO8aydhCvTihTOcKSPSzmpiwMkiFFbxBiYhXHA2
         r5jNXtrj3xrE+auXhnCaFou2/l8305GGRHCJ57rXL1DeYb44SOLxz3sSeUqf2YfLYdJV
         feiCUSnRGyGX23jrla8q+qmN38pOTCUNEZufobCHkUiSvlO4HOsu4bhJfwdvcsTeKaRM
         QGAp91Y3Qn3hX7k1h4HaqDyEjY1qvM9ovWyKO9V54zubh7+wGBu68KrvLkBRbdBQ6IQj
         B5PgDjrvbR47tiofJ7S7UBZrmYQckoP7ir6fA+btv47CjJVzWey2EyqEcSO346QpmLop
         1vdw==
X-Forwarded-Encrypted: i=1; AJvYcCXsX1t2JVyVYgAub4D8szdy5Q+BnbG7ChMpDV8DFjw7qNPD4TkJScPNlK5XZu1gwuRsLxLE0ZN/HdBT3CuFV7pH+chlVMjNJsL45eka0mXH
X-Gm-Message-State: AOJu0Yy9wM49BlBWd3/gtdFN9tlYKfvS0mNu0BWec3FOgQOVAPyb1i4Z
	xUQ66yoLKYfa/k+zoncHBI8AzWvETgwhieZz5V19DwLya7V5AMokrmF9f8bssV4x0DcyRbXh8FE
	=
X-Google-Smtp-Source: AGHT+IHjLJDbjxr8xkUHzJyD5Whg7YfRLpHg6cBfZRTiAJ3UNsrBmID16wzVT2pbO+hYWEwmD9Xfxw==
X-Received: by 2002:a0c:f741:0:b0:696:3ca7:536 with SMTP id e1-20020a0cf741000000b006963ca70536mr1155433qvo.29.1710864672875;
        Tue, 19 Mar 2024 09:11:12 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id gc13-20020a056214230d00b00690c99e7ad5sm6529243qvb.110.2024.03.19.09.11.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:11:11 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-428405a0205so374251cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ5fpRiDAR0jeJpXnpaQgLHeBBJTfAZj8RL58Y2/x1nHTeROKV4iia3aKi6zj3xcXcuoOvYes/SwTVPavMsbKFloWF/JY6V7KgmvMHfHDB
X-Received: by 2002:ac8:7c44:0:b0:430:bcaa:187 with SMTP id
 o4-20020ac87c44000000b00430bcaa0187mr392494qtv.18.1710864671219; Tue, 19 Mar
 2024 09:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-6-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ut0pOAFxD5KELqK+_bkaKOBaYWTth0aVgO5LmMKraPyg@mail.gmail.com>
Message-ID: <CAD=FV=Ut0pOAFxD5KELqK+_bkaKOBaYWTth0aVgO5LmMKraPyg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sc7180-trogdor: mark bluetooth
 address as broken
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
>
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
>
> The boot firmware in SC7180 Trogdor Chromebooks is known to be affected
> so mark the 'local-bd-address' property as broken to maintain backwards
> compatibility with older firmware when fixing the underlying driver bug.
>
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
>
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogd=
or and lazor dt")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Assuming DT bindings folks Ack the binding, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
