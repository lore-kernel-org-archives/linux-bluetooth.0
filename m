Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6839CCE2
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280485; cv=none; b=DLT2rzzW7Cfkk9s63RabxIXNNecY3uPMYOypSJbIGml4muNkSc4yxGBy8r+qRzzZapLK9hGjCFzSkytyGpZKjWvB+rLPCmd2u5pLCCeeCK6ACcP4gEuwKVKh7dNPxvvOJxCKe3XBsWR8BkHgMd/X3PYj/m2uKLi5f54qcdDmP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280485; c=relaxed/simple;
	bh=4ZGf7UP3zl3e70veS8oxZPoqDiTbCuZqWoFE8AEdZMU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W531/UE2h80GJA5LbxZbuwfMqOdtyJJqelqUtpwCazax6xZQCPlzMhjqkrNeAvuLpyVpqji9ui1EtSFsO8+yLZ+HAvJC8ckBvPiMJiALuA4ijVmkrIz6tHXDUjZw0lzPUp8xOYs+zDC8hQsKchFbK9BqPNhIt4KP+i1AHa0n1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luWLz1YK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luWLz1YK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008B51F00ADB
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280483;
	bh=4ZGf7UP3zl3e70veS8oxZPoqDiTbCuZqWoFE8AEdZMU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=luWLz1YKy9PHNHfFDg5f0U8COuuUl+1UpD7Ct+V/o8HVQuIS/ZPjaUoGmYxdaFbwd
	 /1le9xj+j44CfwfAo9ArcoORtJ+Z8WMHIbLy//ssfvjdifaNqsb7sFIxXVbR8s3oX9
	 7AXvxpKUhoaFj7qbDfsoTJM3GxEGN9J7kW+5I8L3yTMZewbRr9UkYBcJ/M9hwXu904
	 KFRStgw87LqBb8V5AoO/FhmUwLputxWRyqLiUOqMAVfHa9J6HaaTheG1pZeBNGf6Qq
	 sSvkyRZb0WTTVn1ieRsuIe5Wb8aZW9vyhWQJwgcA0Qz4QOxjtYwi6+UhIYw/pygEVr
	 W6JdUofaVeHIw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b159850b16so3914467e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 02:28:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqCm7gbZVhS1cJ1yAmF7WqFomxAOPzfrZcKZF3MUKfVEAL484MG9WqWOr1nbtRMB9dS1/CLob6AETEXG9lzvE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1ygBxLB1YCRKHHTk1H2Z41MLKBxwgAHWzJvKShrUFQh5Ao6s
	CmWLNBtThRKNGq8wGyzxBP+z7F6M67Ny8B20gg7Ebz8xwHBK8J+rWgarYlILNjsEVsEZJ7ei7sL
	pUZfeFNoRtqqsxj9eOekN32aqNb5q5f8esKMNUnpzYQ==
X-Received: by 2002:a05:6512:1386:b0:5b1:5afc:1727 with SMTP id
 2adb3069b0e04-5b28faba838mr543668e87.57.1784280481673; Fri, 17 Jul 2026
 02:28:01 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:27:59 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:27:59 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-9-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-9-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 02:27:59 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf8qof+jcJdL8NnO=E8M05=Fgb-pLgVcmHBvXDLWy=PRA@mail.gmail.com>
X-Gm-Features: AUfX_mzWTRVO5Ehi6fuXebIcMrT3i6w8g-wcOYK8C0cB3JSQGImsbJT66idcqFM
Message-ID: <CAMRc=Mf8qof+jcJdL8NnO=E8M05=Fgb-pLgVcmHBvXDLWy=PRA@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] dt-bindings: connector: pcie-m2-e: Add vendor
 LGA connector compatible
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 18:18:26 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> Key E interface signals but are physically soldered as an LGA package
> rather than plugged into a real M.2 Key E connector socket. Such designs
> are not actual M.2 Key E connectors, so describe them with a dedicated
> vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> fallback for the shared signal semantics.
>
> Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
> Arduino Ventuno Q (Monaco Monza).
>
> Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
> The Lenovo Thinkpad T14s.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
