Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020B3314C4
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067607; cv=none; b=kUTrlRAZwrwT+hnlEIliR1/oWI2+Hcsq7yNJmQodCqjQHwYPBgB+4i7F5CkwwJX0cL2tGC3QJSQqww+xJBxLBrohqFtDTAanhs7ALZhNbXSHywCVm/4lfpTf+9DTJnbBv93vN0NWqrMeottNXxmQ3GzawdUDZkwD/tikxAVRIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067607; c=relaxed/simple;
	bh=CPeHWVKQaBYEElBX0g0QRy6Vj/Qst736Zlo1/X2BtdQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jR0k9aINcP+53FX5z9/mne3y69r6LO44G0uEqQwONKABWt7hSnzM2y0QFQ8jU8gl/GRFpyKafRVpC15/DbS2FSbaXXru+PRF1TChdu13pm9eUfEhcW9DyhNrv25mf2EiTdq1fnD2+Yh6maPUEEMK6cbPpVahgwiTPt6XsjG7uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZcxPhHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZcxPhHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0341F000E9
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783067605;
	bh=BuHOPCYtm8jRcWC4IRKKtDvQPRYY12Dv6Etighlt/fc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=WZcxPhHOLCuZj4W4qqqDbVwqS4/yKChxlA3wlcPFrdKd1d2ZOLS2219syDplN66Kz
	 z+PeghNxn2HFujrWkYCV+TnlRo++lrCUTcKEM1XnhR9b6jMyM1kjY5deqPgcbNg9Tz
	 5GAseF5x644KDEjtYVvRCiiOEsRN3HVOOtd1FNNvnrJ6GTN+m7XnqX3rhNboa6xos9
	 8ckcdHazDS7Ec/NSIIQP7GjhKa5ZewX5W3Qp1//Uc0SgKuPN8mCac87MN8XfQdih7I
	 PzamV2zDikXieecRdweWO7dVBGw9TYDvsGSnIUb9SgZUEYdv2I+djd52v/9FDmESrf
	 X+VionvTbc9Tg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39b14a7e53aso2968361fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 01:33:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RovS7iwTIew1sebCfJCYzrdan/rdZCealm0cxNFIg9bAct6bLcMBlmIvdCuKy1/WHGXqCIhR6UccS9v221EaYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/4TVCKZuIuvIjB7sy5jYepwwb9vITgb9pMivmRTyFmu3oyPX
	F6naSEBTqti6Bjuyei9Ziq13LX581ykgb+ZlljdOFAZw+fUe/Rk3YvLBojRs2pGPNnbfxay5TAF
	0Z5z0ZY65fV1P68zpAZ67JsbCezWNp59SZ6ha0DRcJw==
X-Received: by 2002:a2e:a907:0:b0:39b:100e:a582 with SMTP id
 38308e7fff4ca-39b34102a63mr18832421fa.38.1783067604615; Fri, 03 Jul 2026
 01:33:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:33:23 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:33:23 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703-ipq5018-bluetooth-v3-6-62da72818ab3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-ipq5018-bluetooth-v3-0-62da72818ab3@outlook.com> <20260703-ipq5018-bluetooth-v3-6-62da72818ab3@outlook.com>
Date: Fri, 3 Jul 2026 03:33:23 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mej5MtZuZATjKNtzHB0YYRJR5EBpcqzZUqs5=8jQELA8w@mail.gmail.com>
X-Gm-Features: AVVi8Cfz8fxokF08uKqFvZaKM_8PpWqL9iATWbe1q-OjIVsquKGm6K1w9Q2wkBc
Message-ID: <CAMRc=Mej5MtZuZATjKNtzHB0YYRJR5EBpcqzZUqs5=8jQELA8w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] MAINTAINERS: Add entry for Qualcomm IPQ5018
 Bluetooth driver
To: george.moussalem@outlook.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jul 2026 07:01:54 +0200, George Moussalem via B4 Relay
<devnull+george.moussalem.outlook.com@kernel.org> said:
> From: George Moussalem <george.moussalem@outlook.com>
>
> Add maintainers entry for Qualcomm IPQ5018 Bluetooth driver.
>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0b9d7c8276ac..60f7251d1a16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22289,6 +22289,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
>  F:	drivers/regulator/vqmmc-ipq4019-regulator.c
>
> +QUALCOMM IPQ5018 BLUETOOTH DRIVER
> +M:	George Moussalem <george.moussalem@outlook.com>
> +L:	linux-bluetooth@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
> +F:	drivers/bluetooth/btqcomipc.c
> +
>  QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
>  M:	Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>  M:	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>
> --
> 2.53.0
>
>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
