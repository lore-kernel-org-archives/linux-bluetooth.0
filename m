Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33F4315D
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732712087; cv=none; b=Ml59ybWd8IWoo2afZVSlXdjWve0dSBA3xzMinAnxMrdqv+FzUnTMDwwYpgG2vNr+41sg+5wKASFhsV8rRMdY0pMP/A8+FbEq3XckAcNrO3SJEt/ym9yAt+VtmL1cipp55bAmKsiMq+v67lL5wmr55wP4/WoAEoY93UjuTUzBNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732712087; c=relaxed/simple;
	bh=Lh+K93JZ+oSO4iAA1pLiUmBkVGI7gz64mN0R2XehEKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcpX9sbFnXPVn5yCOfN5fsNFcn17hGoD3G0eVfz2TmXNPw/Z/ZSdPF10/WhT5wgfdgYTI0lo9K0Pzep9uwu+k6wO8TuS2aKDlXxz+g5mBop2zDI6VQvUN59ilfKciZFim91Lq5a1BRIR9BMkQxowx7iIJVSCvI5V4OTIrKYL6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VFjp4YnR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VFjp4YnR"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de92be287so3560964e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 04:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732712084; x=1733316884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMlguYsXBaHTG8IIPiymhg5zN1IoRUyw9vVeQdmNnoE=;
        b=VFjp4YnR2BMoy20IxOEMJ6AK3Ujrzz3qmqIca2qOFLtkK55WJsWT28V1CueF2zG9oA
         obvV4ErO6bOWG4IoF9wTGVCsRzKyKxGlc1aUqRrTHzjWb0AFe1QVeXte1QXSQNi/Fy9h
         ZDqJZrq9ZY5pdpybQD0+pDTk/X/IyN4E+fD7GMadGmvERoPh9zQijAE4j1em4simzM0z
         RNVJzhnGtNKpW4usO8p2lPDZdkI7/cOnkHbnKpAPZtECWpT8mKCGuIGuEhHIW2WP4UFP
         oWvuf8iJR9xR47rt3XMM0mFg/L2TVpUfUHKFj9SPPKxO4RMU4k68P0JHutPQYPkSRbV+
         wJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732712084; x=1733316884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMlguYsXBaHTG8IIPiymhg5zN1IoRUyw9vVeQdmNnoE=;
        b=hvfpKzli82R/DVF61rdjtMDZxyRzGfa2TEcLgE3NmTCKT2pmfvoQ94UV+ghvxIYvPJ
         kNu/zEWoiIJ4GkUNhdMn6IBkfYh5P8EjcD+RWAt/orzbo94SyJ02BE8bh20MsqGbirw8
         JIeXqX80FiNsfivlUH4qtMNau8Y1W6+c5ADNIEfvPyCN+OP5aERgdnVKuPMdxvBfj7AG
         4obtAogOcxIy3pNK5J0E0V2MjBkgRFvOGIXdISvmlh31WE+bwM/Qj6UnjzvFpSi4aah8
         JkrBZpCfPmsAw+fKpx19jgAJjwi3a9OSiy2mHZyltW0KA/+svJevyIZANV68vdiGCFB3
         09KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDTDP5Hfdvoj1bxYzUZjEuvV/YRbtOlu6kun1/ioYEDhFtaZa3LBPqqHaqPNjGGNBuDd1HYJHxoWraiVdoSKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJm5rb2A3Y5vuwYsqBUQyGNl8dOACvdbsctrwGj/+fl8YDYsNJ
	QEqll7wGrSmUtIP8yOliprK9cHJvGA3F9GBz0HR0DVeX+zYIry+74Q7tMRbk8c7Pef2n8Oltc8e
	ZuL197Tp1D6nAc9am242gxfuuz5INqjMmoBiMvw==
X-Gm-Gg: ASbGncvbPG8usRBz0wtLgrvsu2rSkC816dgmFPrIzhVe62rJ1D0M+4C8bhs0w+SNE5t
	/emjZ4CLWTdMAIQMg9P7Vr11MvlXD4AjPueQ+kUsdKhmuTcCMClDr/Caoh2acXQE=
X-Google-Smtp-Source: AGHT+IHx709SaQ1FKdkFFszRfWrjL9xRjWY5udSKu4C3NKATAFjJLfJrvyExi7rrNp0NGOcrVq8wkyZ207HqatYcYLA=
X-Received: by 2002:a05:6512:b26:b0:53d:efc7:70c6 with SMTP id
 2adb3069b0e04-53df00d9d1fmr2573513e87.30.1732712083923; Wed, 27 Nov 2024
 04:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
In-Reply-To: <20241127115107.11549-1-quic_janathot@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Nov 2024 13:54:32 +0100
Message-ID: <CAMRc=McvKvHy8sxhHE2-5LO7-MAjtPMLks6x9bufTjmpG4cT6Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Enable Bluetooth on qcs6490-rb3gen2 board
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 12:51=E2=80=AFPM Janaki Ramaiah Thota
<quic_janathot@quicinc.com> wrote:
>
> - Patch 1/2 enable WCN6750 Bluetooth node for qcs6490-rb3gen2 board
>   along with onchip PMU.
> - Patch 2/2 add qcom,wcn6750-pmu bindings.
>
> Janaki Ramaiah Thota (2):
>   arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
>   regulator: dt-bindings: qcom,qca6390-pmu: document WCN6750
>
>  .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 174 +++++++++++++++++-
>  drivers/bluetooth/hci_qca.c                   |   2 +-
>  drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>  4 files changed, 223 insertions(+), 2 deletions(-)
>
> --

Is there no associated change to the pwrseq-qcom-wcn driver?

Bart
