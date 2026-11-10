Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337091;
	b=f4z26cw3JTGqsoVnblleODacK+X/n1vpgyOKxSn+gKnSEscJ6A7UYFLndc0MLfHoUGI4
	 9jy9F58JlQGotLvZZdnBETKXG2ciEdGtdq1w+6ZrJlSh4opF41W5E/gsqmXr6LqZPhd3e
	 nzjbmu9qHHbRabjC/DCfhPq+rP/jP5z6ShKGxjRNFoi0/KWaQksqCzxZ9eApHGEJUTTXk
	 1rzJ4NgNvhLLHexlqx7J/Yr2T2d/X11tYX+2sBuMvSzdhW0D6bbISzRqsg3aegSk5XtTy
	 Utf5KYeP8vrmOSgH0S+iCfwVJGelQz7Eoh8Rud/giegmKqGoYb4ZhHh9eqBE0BdkjMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
	b=1RW/q9cbqZ2XfoohUI8tMfODNIxtcZHQe0bfNPqCjuDS1Q4t0bVrfQmSIMBmhQNBN9Nf
	 pEhPpPpsvSOK1tCIep9AYTdjnTJ3B1WUOt/zmUcEixPbML+KhtSFAf1mXDOXDaHlws/FI
	 BQhb2rxVdoUsMDLo1YwKGgd5OYZpmCnDToaJm39vi1VxqW4FYMM+7i1UYBE8tKQne8S9w
	 2G3VkIlt2KqMQhAvStUsllAG8uZwTsUBtq+P41Po+kZHXGAJ9AMqv6tgD8/cefbj6h/NH
	 l8C639enj3Dv7s5ENZnnT2ScXALBUEznwBxaNuKRWK4PWfvgUyO1vMmLini/Z2RNySQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hC8j81W4;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC63606A339
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 18:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FC63606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hC8j81W4
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f22a8515eso192374485a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337089; x=1794941889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
        b=hC8j81W4XVy6GM6NSCd0k/bnKZL9dDfHbCnjIHZEMV4YCCxJo+rbG8Q2gJ1ziBpLGq
         b/WGl7uM+GbW0ScCbcGRV81gVeRTeNgz0MizF5kMHCM5ZPPdbitL1rbaLNattI6y9fcm
         0DpQSnY4WXKFOr6Wn7dT2dmcAELqKsJEKzR++vApSbK2g+bqtAQ3mQs5BCzW7QtRSntj
         GWWCQkNu74fERR+RfULkWg5huVt0eR7NbF0yCDO4S9QOY3TsdNE17R5IVmsDeMYlMoLP
         36wy31vJ31vDKQ9MKJyqWq+R6e/unEw5WoidBXKtWmZIODw2TxbkPGzvtWf17iNMm5uC
         b7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337089; x=1794941889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
        b=MHeMMT6mm/0PlAT89nz8orBMf/q4+8Mv1nmPGLxuEocCRsXlfrme63fd4aOHonSg23
         rhJRQBLxF1KAZfM+B4rZo0LjrYQX9mzXlYqS7Z2AxzpH0ZAe1G41cqqnaW1fZO0025AW
         0UpaksXLnfWO5ZL2tndGwF37Jb1jpY3VgNtAXkQAULkYWuvO7BxUAVzF6rNMV3ojAmga
         TNbteYGhXFi14Bx+0SCKKuZ7Oossj89a0ezBY1+AUo/EOxcyG/iM1NNxATOerwlDxqG7
         a1255cBF7ye5dhgpMjRIGu1zaQkbvg/pf2AK3h5/9VA61Aqjf1EuqiDr5r76k4IRgxaq
         nRDQ==
X-Forwarded-Encrypted: i=1; AL+hErHNMBI+wp9nth9IfXSP9WxQCty4X8yxAyLqLA4pi72uj1/4hRwruETlzbh2k8cj/WDgWQacmllGIXR/HmcRv7k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jxAWIF/VAnljQrW81rRg5SOA+xVK361yTe7pvdOdiLJYRjgaq
	/TVeLF5puARI1o5up+QUASX6B9YB4LDj4yaf8qXs8L1CYscA6PWIxNtz
X-Gm-Gg: AYBFou3owBzemram2xbLbFqUR9VA+W1Y1+73cNuXrlraFxTXWwpKF76JTF3V3YVY2Bm
	EZ/6ZSGc2APcs8ECBzk8i3XkFp4Lct8MoU3vMGlnNHj8ORcFLzb1Lgnt9r9w4svtDm3hlptFeIz
	kt05DcUDHABRJjMyk/+/1uCo2SBYjv3IXD8xG05V3spxfeS03bvnjICs+brq8zv4ItBgOchnQkg
	0hUWBk4rUBDCMirTiulsas8e6yfGG4XWMHZCZ6Z39OmfcZnEgEJ2RlUlvC6xfF+rTlRgPjOCk5K
	nN6cmU5XoS8YIOsKB38g8iA1HhppAhUGR9TkVdlSWavfakW01HuBGycUR2MErTfJkWIToXi17Z2
	pAUdwYDFlLrvdzYkZYTaZtksvRF4e+OrWO6Z6hfEU2voQ6XaSgsTW09VxuqM/iLdRbBHrgwsis3
	UCNg9+YFhHhMW/407bGJh9wOJwRlCrkGQl4nTzmezd3UCBEMa8uAeMGRg8yEQcLuJ97l5eUUnU2
	4I5elt3NCl1nOv9rBz4XrLeWyoMhCb/lK/C+lPRSHKS4RcB4oHH/BKcx/vu3umgFPfWDyJFiQj3
	EkTD6awH6hXTVB8Zcfq5DiY6T2c247DJEVl9+NmpKqKavXkgMZWv9H65ho6jtrRSAPbrVopRqDW
	ecenFjFIULLHUiffNFRSLMbi/ALtlC57Mam4nEYc+r6Js484I7YMEZC/vZGW6jPD6bzzLLOGFkv
	kG9md/fPhMBBfc05IxLsha4Zrep1bAL+wwjJL45YDqRgXqjcL+HJqjMx5rE61o/7jqyjteCLfIS
	mB6osfsj4skCJEMsc5UQPUFWdElubP4NxNqmOe1sf1usg==
X-Received: by 2002:a05:620a:4041:b0:93e:c12c:f127 with SMTP id af79cd13be357-9479f38d707mr575616785a.83.1794337089011;
        Tue, 10 Nov 2026 10:58:09 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net ([2600:4041:5024:4b00:940a:c6ea:f292:3644])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e619affsm290954085a.4.2026.11.10.10.58.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 10:58:08 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
Date: Tue, 10 Nov 2026 13:58:04 -0500
Message-ID: <20261110185804.56861-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on an ASUS Zenbook A16 (UX3607OA, X2 Elite), whose mainline DT
connects Bluetooth through the M.2 E connector (W_DISABLE2# on GPIO
116), with the QCC2072 support from [1] on top. Without this patch
hci_qca asks for a "bluetooth" pwrseq target the connector doesn't
provide, W_DISABLE2# stays asserted and reading the version times out
(-110). With it, W_DISABLE2# is released, setup completes and a phone
connects.

[1] https://lore.kernel.org/r/20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com

Tested-by: Jesse Casco <jesse.casco@gmail.com> # ASUS Zenbook A16 (UX3607OA)
