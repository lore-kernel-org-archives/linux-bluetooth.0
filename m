Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93C194A53
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741780; cv=none; b=INBcHIBFzKh0xW2x3bqjnGGJXrFBr2y+cexCyhm5OuDI20nW8XOIHg1pcDMbDHt0gAOOiOGPD0Y6Kzyzz+GtIkqnLgh0ZGw92svh9+IDSM63uU9YBD4ZkJ0UZehdkQtiDiZBmzQJO+EWXMy/WSGBSpj9AzV8cNbQ9jwuP4njsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741780; c=relaxed/simple;
	bh=MvjEr+QmcBYSFD+4yOMfFy5J+y5/erO43wRjxGBp134=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyZNU8z+y7+UrVX5SJ1ubsBFH+5sJqn3djtef5sSWq4aDb+rp6pakrmYm7rnuzxcWd3kGz5UMplGaEcYOG/9jEkO7HYY/kWa9//n4taz0FZnU4bpTQKPxYP+06EhBJ6qV5vLCohRrrqnPGFeeQPwHi1TzYpSOpjDcxbDQ3hb1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJ3NfQyg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJ3NfQyg"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so1131830e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741777; x=1734346577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1LCGkepE9BNY41wwancZQPMjgbX9qpsMb1C/mBNuBo=;
        b=cJ3NfQygvrCnHUz1YhqypYJYiFuhT4uUwvhmpez3mjHDRzZZRMBdFD3aBlcQocSGVP
         QMi9lDv2NlEC9MDche/rEAOuJn0/+NKCZUQaM3JZvP/s0eavqk9x/oZQ4/8i0OwnNJ79
         y7OWe777vevFgqZ4gsWQJG1FpXm50ZYyihn5tOKOw6sqz/MX7fJW1/rQru9iQDUpLZc2
         gSgyqQQAM9ODTyP99A1dr+DRz2hUgN5NXcaPNJv7NREy0v+kAma9Zaj3qbG9AqFLpkC/
         yyrxMf5SSXNA24r+g0+leBQupql+B1aG1LhQANzOnk9wwS880CRLDnL/cUHnEhSPFNmX
         9w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741777; x=1734346577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1LCGkepE9BNY41wwancZQPMjgbX9qpsMb1C/mBNuBo=;
        b=kIKBPb3tuylggrtw//vKea70+jW7WcTS2UCtuOi09bgyqOxVkr5zgfCk+/ubvB9NQc
         gJfZdmUuiDUBlqYu8WW2lcNNowX+haeTNu4M8sBYTkmiALc9bEubR4+D0l28YQRb9hIv
         d+1I7W0iheeIDnRZEo5A5Cq2r8iCMHM3c7JKwhhVokzyA4ASR6TzfX0DbZ+LrwN0vVqS
         kYi6YwuI5V0oRaTDeHV/d2pQrhJfwVk6e5aHkKWHNdSS2+666MEqbfn2FcdlQYAWIYqD
         bK3zpOAIsJS94miMJDl4YLYgCDBXWg7M3q2e43FJVXASTYzxKCsh3Z6otpGoC67VO1GK
         LLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoYVpWX7lKf6NuhVjIsT3Rsb7ass69eYBiVqKBdDd93Xrzas91oFitP5X2joZuK6diSd+tqEY84MpM05XcIc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Pk9n64jE4oUIQ8w5bMS+8doeQUkIdkJwX/t2ExOWgg+tzpHb
	CSx3bCNWEQ+ahPy1paMyubugktJD5pZ2QT6CncTVDv0LDrCjRRzxcjYq3NX21Qo=
X-Gm-Gg: ASbGncv2u2aC9084pQdW/FHmdImviqKE7OBHlAd+j8HkiBy/E2ypIKIfod02u5/iQR5
	WRNSfYGKuXoaBO86/9dKvf+CzBtN0rKr+5kWKIoGFhCCcdXq+gSTD8x6qEO2Ukh5q8LoLI583wK
	6IeTib8R8W3bZf8TMyOyJ7kGraBf0oDf49Z+p6FESsnXbEdWN8+nw5oRdBDn01lrpz+nZPgq6Rg
	dPAs3XHWVJdlNXZhfWVim3/giOwAVDVx24KG3qw/ALBgCAA7huwKMoFt13LfixuXxQpxF/K6e5v
	I1LndVLwRUjV7rJ0hyecZDZGF9Ux9w==
X-Google-Smtp-Source: AGHT+IHLQhW4yrOheTO3FKBH2BMc3+YO6hNqRhmWtxjdDrWhydjjQ8nuO7eWSOcahHRapkZ5ee4u3A==
X-Received: by 2002:a05:6512:3990:b0:53d:a321:db74 with SMTP id 2adb3069b0e04-5402411a69cmr1638e87.50.1733741777425;
        Mon, 09 Dec 2024 02:56:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3745b0bbsm930193e87.185.2024.12.09.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:56:17 -0800 (PST)
Date: Mon, 9 Dec 2024 12:56:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
Message-ID: <cros4yf4mwtu24xdpevpixlmtt5si6ywjzacezemhsmkfsomgx@gtjaznwqvjsm>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
 <20241209103455.9675-3-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209103455.9675-3-quic_janathot@quicinc.com>

On Mon, Dec 09, 2024 at 04:04:53PM +0530, Janaki Ramaiah Thota wrote:
> Add the PMU node for WCN6750 present on the qcs6490-rb3gen
> board and assign its power outputs to the Bluetooth module.
> 
> In WCN6750 module sw_ctrl and wifi-enable pins are handled
> in the wifi controller firmware. Therefore, it is not required
> to have those pins' entries in the PMU node.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 168 ++++++++++++++++++-
>  1 file changed, 167 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
