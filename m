Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBBE347FD1
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683669; cv=none; b=gJnLvvdSczgEyI62kdT2md4c4QdF5LpaiHF4IlxU2K9wMI4e/XrTuCMgCC20W6d6EULemRA9vtfBZIIJ0hbG2y0U2SYBE0zqgl/reMRazFUoqFvpOe23NmlQp8q4qPj/jKqbokBsGCpxMsqnB0biucQ0i7Hg9tyQcg4YzjN0bIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683669; c=relaxed/simple;
	bh=oo6sD9eeKJmgF8y+Mv9/ziuyg8LqE/RcnPFXODHSQBc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=BZpySO/qF3ClOrov74OUWKqdyvpJCeVl6NitR6Gq8M1M3caXewKTNwVUR/RUXnm6jw1ZSb5H+3pvC+JBcaTgQYleIYDumccXMgLNZZ7GDbb18AN79Lb+tqG8aozuMfQEP0E3xZMMHOtV2oKhwSda5P4afVmpo980SJt85aFerJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=IBn20ZWW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="IBn20ZWW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso34029365e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1776683664; x=1777288464; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dympeeiEyneZdFEwmKLL4dnrMWqI+ctP12odqcxsjA4=;
        b=IBn20ZWWmHujVbwaKsnlG6/fA6O6Z2q5Etxdiy0Rpua1Flfio5iuvHphA6Htwq45Ru
         s3mMLDbJzJitCNYGwhR3cCaaAbvB/WQVHdTXYCLx9Ml+1bXMjxqtxGNQ5GUGgh2cPEOt
         xWbSHmOvSqUrozSX3EIfXn1/Kjql5WN+xOBy+pyku4K/+NQjwg1Q+P5EfcFZYHDnpRgP
         093Q9FGcg5Ieo1vfOMYe13KsQZ+l+748XCsqGjAh7oX71k0klpCXcJNDTRHAcj6xVpKo
         JSTzSSLYe5WGW3+LEp0U6l0aG7rirexfpwixmMKCzWA4FtFNnMJOFXXYXH4foGTAh1DV
         JKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683664; x=1777288464;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dympeeiEyneZdFEwmKLL4dnrMWqI+ctP12odqcxsjA4=;
        b=HeeC7YCO1YyVLTFaexNvZl6Rm+6GGQnlIGgigCTGnX28/tHxNDIR6IhMeG4m4+Nqwp
         34sEFelzQNKgbBQA4u6b037GsV7Wh+AbM8uQ980u/brHQwu07bPn7F/f6ARH7DPI+KbO
         F5yUsvRfvQrf24LTt1JieD1UZhayUPVIb7IKHlBK6Hn8ilBqGu4mPuMfTB/Wfp+ty52n
         O83vQ1M2px9WPnlpCCr6unqn0D3X3hWoVD3kxAZ0cclhEXPol/IX+U/yqz3YKuGmKJkc
         Njv86HY6fabtCmgU8Q9HGFipaRd3hjAFAyE+IJh8rRvYb+ZEFZN4H+W0Jc9lkjRjTZpt
         ndfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+M92wiIQ7QzX3hSyBZwPuKx/joa8X5vk/9pV6KZksIhQcHppK+bK6QZcFrxkMS4PVD947GKwOat2wwaMgTFBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjis8u4lpi1Csf5BftiKpl/RT7jYj2dM6WZBWqC9S1HF0ZICMF
	sW3dpq0NnVVF+R2O5cO8oC7rLHZ+DqaeuZMT2hbKgSSyIG34j5kqYUyOg5+WUH/5yEs=
X-Gm-Gg: AeBDieszDqTdGk+gVJ4EwlBi/2qfwA674bnuj+w6Ee858lKiK1mM4xoU4jSciSpyL3V
	zh0ZNBofAoYUSTddd5iYt8aD3HFse4YZuqPISiBZBQrusysQ/tIz6wA/56jD1A8J7xcfjQj9b7K
	GVFNOmeEWsKCzt3rAnNE+Udq59oIVb5QMIEUb7hL71TO1eSpVFX7Wdw3so+TT2psUvRZqJ0bw5M
	T/R1op9Q+Wykm7EL+b1p72uNmVVRBIwLLPNzsLqBLBXGT1l6Uli2HYeCa6pfsdTwm6RN8V0WQpx
	Ei4a2cxQKWCVp1QKMrTMRVFYoXY3u/a0scdyU26EYlPAuwq1GP4ZXIDhPKIBIOrBGktg37tN0eb
	UzaqZJXBb209wHMSTQhR6zOhfkACi0TMann1QS5aqYRITZWXAjsYPZtn8oInZH9/nfOLLemCq81
	ZfLAWHaNGzwYXqoSOmVJ9tECfc4SfO+ZbWm4kC4DwUdFN2Z0f8t6ZO8hmi/y2pBQ8/iPJPt2DjI
	IEeo5lcqFYAbePUuk0=
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a07615b87mr18212465e9.8.1776683663648;
        Mon, 20 Apr 2026 04:14:23 -0700 (PDT)
Received: from localhost (84-115-213-130.cable.dynamic.surfer.at. [84.115.213.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489393ddd69sm10775525e9.10.2026.04.20.04.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 13:14:01 +0200
Message-Id: <DHXXSDE9V52E.33D6CI1LWMHFP@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Marcel Holtmann"
 <marcel@holtmann.org>, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Jeff Johnson" <jjohnson@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Balakrishna Godavarthi" <quic_bgodavar@quicinc.com>, "Matthias Kaehlcke"
 <mka@chromium.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-bluetooth@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath10k@lists.infradead.org>, <linux-pm@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Bartosz Golaszewski"
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
 <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
 <hdypom3nioc6tk26gh647imy5ykhcjqvknideilnbc2b5p7eo7@hm7fsscleutf>
In-Reply-To: <hdypom3nioc6tk26gh647imy5ykhcjqvknideilnbc2b5p7eo7@hm7fsscleutf>

On Sat Apr 18, 2026 at 9:38 PM CEST, Dmitry Baryshkov wrote:
> On Thu, Apr 16, 2026 at 12:06:09PM +0200, Luca Weiss wrote:
>> Hi Dmitry,
>>=20
>> On Mon Jan 19, 2026 at 6:07 PM CET, Dmitry Baryshkov wrote:
>> > The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreadi=
ng
>> > voltages over internal rails. Implement support for using powersequenc=
er
>> > for this family of ATH10k devices in addition to using regulators.
>> >
>> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> > ---
>> >  drivers/net/wireless/ath/ath10k/snoc.c | 53 +++++++++++++++++++++++++=
+++++++--
>> >  drivers/net/wireless/ath/ath10k/snoc.h |  3 ++
>> >  2 files changed, 53 insertions(+), 3 deletions(-)
>> >
>> > +	ar_snoc->pwrseq =3D devm_pwrseq_get(&pdev->dev, "wlan");
>> > +	if (IS_ERR(ar_snoc->pwrseq)) {
>> > +		ret =3D PTR_ERR(ar_snoc->pwrseq);
>> > +		ar_snoc->pwrseq =3D NULL;
>> > +		if (ret !=3D -EPROBE_DEFER)
>> > +			goto err_free_irq;
>>=20
>> I'm fairly sure this is now broken with CONFIG_POWER_SEQUENCING=3Dn sinc=
e
>> then pwrseq_get() is returning ERR_PTR(-ENOSYS) which is not handled
>> here.
>>=20
>> I'm observing my ath10k_snoc is now failing to probe "with error -38"
>> which definitely seems to be related, but I haven't debugged it further
>> yet.
>
> Posted https://patch.msgid.link/20260418-ath10k-snoc-pwrseq-v1-1-832594ba=
3294@oss.qualcomm.com

Thanks Dmitry!
