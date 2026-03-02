Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080BF383C9E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441995; cv=none; b=eiVLehZCZC0nmDXFHItn9j0UB7Flre2BhlKy067yQ7eUAVuezsp3f5OQ308UJQknpc2zxysRNAdR1TTxHk3WhMCN28lyRbmjQyONvVZYDlwMwUGKhndHQ5XJeAeBbgACwzAicDQZXy5kyLiCNo83NHlMR6YHCAACiVKIZ3zwMro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441995; c=relaxed/simple;
	bh=SvPeN1kJrAIIVNxddrVdHl5aOSSXTPULv14zLvpdJAk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5myhxFBpq9fTJqoxIE1emA5ZK4K7Ku0kr3PJQ0VowxexiVrI9tBrpVHPBN5/7cvBrpYtlFdHFGccXmCpt68LXDVdQJWFYd/98xMPWDx+GuPI4pr7qfeszVoa4HCvT8wx0jmtFIksAIW+HEjVSQJq/O2o6CsO5Jq48PlQO5BYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOnfePRk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOnfePRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1945C4AF0D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772441994;
	bh=SvPeN1kJrAIIVNxddrVdHl5aOSSXTPULv14zLvpdJAk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=XOnfePRk8NIGp5OHCLJGRJuIPt0XbG9Mwq4tFtXxWbqgn0vp8jlzU9t8ZtUWv7NzR
	 J65eRpTqpBbxJOTzh+OWRbn4+bEP7m8m+HLUvLiCZcg+LVbW0AqWpEnuGlIX4M9DS0
	 QD/q2YKBH7eCbS8NbyglTk5Go27WDZ6edgm4ici0DVIee2JxlTHaqLMsytsVQH87aY
	 nj4tX1xhZQYX+sdfxYuc+li+gEQ0Ia1QsJ/eJJNWzaK/3BTwVDmlM4THG9NOQXi5E6
	 vLBoMg33OLKf+SqCSB0jx19XTCqKWhatkBhUYCY9xzsPZ9v46VEQHldrv++AbFwPs8
	 2wslEacKD3JSw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-386b553c70eso63593521fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 00:59:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEf14oNh8s/xcjT5E7aFNDjuWskO9X7uQctNQCiXibZhaZTz/7w6LKkyQ4RfxcQ8yu7kWr8LeG8JKQldbBmQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2BYPtzb5yO8mAvJkyqNAaTLROaGlZv3GB5ujswq3ccVchlay
	V8MyjnXPAiFhaLpB2VwpHHz5cFJKRhqopswO1xkIdMIrjc9/Pc1dKii+Q9NREpXfrTwVHazlEjg
	s98Ilvjn+PQu2zLZoKpl4MjBTzcVQ3Oc7qHYvY7Q9uw==
X-Received: by 2002:a2e:a10b:0:b0:388:127c:224d with SMTP id
 38308e7fff4ca-389ff34fa10mr77104021fa.22.1772441993417; Mon, 02 Mar 2026
 00:59:53 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Mar 2026 00:59:52 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Mar 2026 00:59:52 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260302024658.2836798-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302024658.2836798-1-wei.deng@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 00:59:52 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeY0_rNT4ng0WZHOrqNDeuoaK7_n_4AC1s8hyd-Y62v7w@mail.gmail.com>
X-Gm-Features: AaiRm50IT-IkRZbkJzPK8EJLXNS2M1eqFcgkqWrA1jntjUthioKMMjctQpL20FY
Message-ID: <CAMRc=MeY0_rNT4ng0WZHOrqNDeuoaK7_n_4AC1s8hyd-Y62v7w@mail.gmail.com>
Subject: Re: [PATCH V4] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Mar 2026 03:46:58 +0100, Wei Deng <wei.deng@oss.qualcomm.com> said:
> Enable BT on qcs8300-ride by adding a BT device tree node.
>
> Since the platform uses the QCA6698 Bluetooth chip. While
> the QCA6698 shares the same IP core as the WCN6855, it has
> different RF components and RAM sizes, requiring new firmware
> files. Use the firmware-name property to specify the NVM and
> rampatch firmware to load.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
