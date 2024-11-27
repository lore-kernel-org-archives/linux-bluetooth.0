Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A81FA27E
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732712927; cv=none; b=O8HPUY3Kj88gtKbBfZGhVWJKHjmndHvKhLWo2qescjugNSiMCIkgoECNrqzGrKGgnN5J358iS5NfJhzkazrj3etPkPQLWj0r/eCxCSe8zwQ5dG0ZeGn/zQ5oIeWNgHZ6OJgMuEhPR81r/yt5k1Y0wcbaU2uYWe0kxDHDGzKHUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732712927; c=relaxed/simple;
	bh=STCfL3GsKf/AOQi4vbhGaEdxgftPACg3jwZIG7ref3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXm6852ooNTXMRYxQnpr61XOFcXFnnA1fW36EAQkmZdbvR9npwX1v7wwUUFclUhzSmWQ5ODFogEd9U7LoD3YsGqerQyyjiFFWDD9HKxR51L4X5+0E73YIP3YUlbnI/jaQOdknDbpbxvsJZafDjoYaeALWU+632mJqgaTODhcTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fDPxZ2n1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fDPxZ2n1"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de880c77eso2617150e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 05:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732712923; x=1733317723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dpswvTaRge66vj7YjaC/6aZT4nt4DTSU3DINcL/KGM=;
        b=fDPxZ2n1R9eKxnkE0yTKyg8cwuboimFdA1BJowBdLAKXlzvSnRu59uUbyiy+e8HZYF
         Eyvsfytc6o5t7E/sKElx4Hn4IBWcgs+5hAucEY+Phh63m5w7MaD84c2ZvXSWanc0K6aS
         50HRXPi9deK5tpAml1mzZFjfkjkAh8EOe/UjjpNm8zgfDtx69hRLQwLsNOsNVfQzXZHu
         hQXdEu+0FhbgkJ6TaskJRijZneXDHBOrolHoQdNWAVC2arD8ZFOoc0wfYgpjGryRZqPF
         wmbz0NbHEaTCcx3PWKEcmtr1owWQNg/tuGqMe3U1qqmLix2OIdmMs6ZHfmW/0cbul/hw
         ZA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732712923; x=1733317723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dpswvTaRge66vj7YjaC/6aZT4nt4DTSU3DINcL/KGM=;
        b=qVJz8c1WR1KMILFX+5DcgCKhDDKlNMwwp7cm99Kax5vH0m/QcNwbAEXFMdvNc3Q5Bf
         dhG7cvuz0nKUXFx8Kw1+FGeUNel6kzGufyPRdbzOiRme8evN/ZAAy1D0dhYBMJmPrz2B
         Qc1knT0ciLgWJHUP7nOej+UUAvc/RnqNYDKvaPZMxsqet1VS8ztrtTMhUVZ4UXMFrAFE
         7DiiChHPObxt6mOwG10tBfoPh7fymPvL1wSwpqte9zWYhaWjAe5Jdzql4EyN0lyXjC18
         OI5sn+K10EbtDXGFtmWQOuVwL/OxWSnPtyU4222ANdscJVfmDNydN7kdEU7Cl+9hVj33
         eReg==
X-Forwarded-Encrypted: i=1; AJvYcCUv1YH+RAWakL0ISloVJ4Hwhw74xZOsCUW3W9UlLczS7aluitjMaM4WPUPJMXA2PWMBSOWdvrbyrxGjDPU41pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQi28K/B1TxNsSo+v9MxTYFiB1B+mjO+WQqLxEzBgOpKERt44
	/B6UQozICgMiZL20ofxuxh2Rn99G+khXTtUE7memYqMCyvaw/f2i7rkK5G3LTN3RQMDE7HG0fDE
	mKESG+wQTBB79yX51ukGd5ULYWlwjFolnou7NXQ==
X-Gm-Gg: ASbGncvVkXwBMcMfvXcbS3AQgfULZdkQHXgXXmt0ZSJGvDsj7Sy9q3GCMIAQy2jm4i2
	3DQ92h3/lK79LuY/0HxoAjNJw0ObStoRSE/6ma12ESX8qR9nSd4G+4xSpB0RS03w=
X-Google-Smtp-Source: AGHT+IFqryFgOZJLLptnd4IzLulOUkyCGy+nqG1q8FUpptIWr2Y34pCBKnW7QjQl4HqmdUnAxe95e40GRyaOYV61QJI=
X-Received: by 2002:a05:6512:124f:b0:53d:ed6c:30de with SMTP id
 2adb3069b0e04-53df0016b58mr1784542e87.0.1732712923117; Wed, 27 Nov 2024
 05:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
 <20241127115107.11549-2-quic_janathot@quicinc.com> <873e45b4-bcca-43fa-ab90-81754b28629f@kernel.org>
In-Reply-To: <873e45b4-bcca-43fa-ab90-81754b28629f@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Nov 2024 14:08:32 +0100
Message-ID: <CAMRc=Mf-cO9M9=P50mhPDvRRBSYVZUDrEVa1jcMvAsjdAq6VLw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 2:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 27/11/2024 12:51, Janaki Ramaiah Thota wrote:
> > Add a PMU node for the WCN6750 module present on the qcs6490-rb3gen boa=
rd
> > and use the power sequencer for the same.
> >
> > Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 174 ++++++++++++++++++-
> >  drivers/bluetooth/hci_qca.c                  |   2 +-
> >  drivers/power/sequencing/pwrseq-qcom-wcn.c   |  22 +++
> >  3 files changed, 196 insertions(+), 2 deletions(-)
>
> DTS is always separate and cannot go via the same (driver) tree,
>
> Missing bindings.
>
> Missing changelog, it's v4 so what happened here?
>
> Best regards,
> Krzysztof

Ah, so this is where the driver change is at.

Janaki: the DT binding lives under the "regulator" namespace so it's
Mark Brown who typically takes changes to it via his tree. I pick up
driver changes into the pwrseq tree. Bjorn takes the DTS changes. Luiz
and Marcel are responsible for Bluetooth changes so you will have to
split all these changes into separate commits.

Bart
