Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A42E8B98
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216265; cv=none; b=VhkRmuy2Y8moUuu5OKwt9LzSTV6ONgFw3u4crak9L9vmJ/aIq3acDYeVWcb4VlkmFaU7NSSVQUCUxldBOUrtjCU1Bu3UDp5venbEr4qfdoI31zasB3npAoDOav2axN7yPO4jz7BQPmQG+q0yKeb5x9XKn42UIZ3i5aiQxULjRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216265; c=relaxed/simple;
	bh=khDVMinyRktjp81VmTv78vhuR5dfLwAEQX0dFp8erl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Y+VTiKaGqg0iwp9I5//dFV4eaI9TrPwrHVO7ASDM8TODKyqN/DGaxi8R4LO4TZ+ZVVV6c7jSSHO0OfqeNG/XcWoov+aBFhCnc9xy6SY/Eol4/S39jf/hhFcuJO9ahJET76ifkscZFsrRvzkmpXRPfDaO3mwBxdlNOZ9uizMGZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=oUqoX8kq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="oUqoX8kq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b95c0fc928bso724019566b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1773216262; x=1773821062; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSG8jCrZgvSAYH3ST0w7E15BQnOuBJZtxXBK3xYNciI=;
        b=oUqoX8kqAP89jNayDviF3q4pftyP1lM14c5hxiJpdKaU9ScxErvL8+kNw/uZrRFBFJ
         HzZWhtoEzEu3bHw/CkOX29AXUMUO1dJGGdhJ+/gEG0D9QD4JA4IVLoV0EAz/uBCRnF7w
         svTFaOFM8EMKKb/8/n1dz5/xzHbzzY6OUm7cW2rGzrk+N6x8a2QIz76lDwjOjdjaPyFW
         16PqMotxrtSDONDngnDtikJRVJaIWvQhmeAC5w/Cga0nczajBEwibTIvtDNG8zn3PBbQ
         5mk5BGgwpMGzKWOOhZ8IZwg75OKNVGCbQBZcLFrtVfGGbNrxAFyNUDKb2JAAYT4nkPB1
         HXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773216262; x=1773821062;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSG8jCrZgvSAYH3ST0w7E15BQnOuBJZtxXBK3xYNciI=;
        b=Qbo/Gt0px2u8P27sAKOjHV5OQdmhxlVWnnEjCB03s1pYS8u9wsU3dtAc+x1rYHeR9V
         6ZAfqNjUvRplTEMIDNxyXvEQtEQrTYCtbRcepyhVxDqfeQ7iB51cK020/l6acOaHofIL
         +chK4R6C7VhyqafPtaazNI77uBwZuMWKJ06TTrbk6e1LQsxnxTgqJJh9x/Vh4z+VSc8y
         Nh7sSR/klTCIu7yzXb8vztILwh3oXXHc0UO1sNdQOgjIlUHPnGB3IruXWWku5pk06OP8
         wuposkc3ur6SuklyZAOKWm6ym0+pznxM+duysiJjttM2O7TuOruUDrmF+XZp5JgQxYo/
         LMkA==
X-Forwarded-Encrypted: i=1; AJvYcCVcR9/Ho4uAF5pC50Ad9CfnLFQQ0zATKiGf+e8QueJyAuj12VmnHEXznazEnleD0mCUQHH46Hna0BImDJLd2Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSSvpN+TtFy39rA+vq+JKrvfEY0FvNXYKqEjHYASrkhjX/CMR
	GIIc7gz2QNmZC+r/JzejFOqsxXSgIq4jpc0aS3Eb8kRcKb9IRzVVErAHUyf7JeckDls=
X-Gm-Gg: ATEYQzzGybV7NNSq2laMBw81xINc5n5a7jpo+0c2zaUgQrFbSgAtmkm4Mma7COYXsgQ
	hUrUnEGtI7BgDgkLKrBxsrD65vjI5MGLd9nKZpHiYxcHjsC+5oGzlFuUzt351gRREj59hWCN14X
	KF61fS9mc24ZzOGtjNidEW6X1Y4ZTK2jvx859E1g2GPBgA3DpGmn5E+qU0YPRca+CCO6AYs8aEa
	1Z7e6OQ55DM/bwFzJ6Xn7LW22JkJZ5/bAH0GcP2atY7yH0NP7ienjVFMB0YQX7EFjA3Sn34KVLf
	KHnM0p6t4thFrHI8quut856fO0uM2lNKgSt36SzV74siWMteUjm2YB71FFKDxx31bwQZOh9+6+2
	O5BHzjjXNuvluvAk1Zl1QyplGziCR9TH0nZH8HVYOdYLJmCwvbAPQ42yDYUmLJOTorsIbV4J6iL
	VBNru5J8J54NwYtACFIUEIFuEkaRoupKMlGVyiuleha2fNWL4Jivm7opAk//J6YtYZGJBH
X-Received: by 2002:a17:906:7314:b0:b97:23c7:2b54 with SMTP id a640c23a62f3a-b972e61897bmr85765466b.49.1773216261981;
        Wed, 11 Mar 2026 01:04:21 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de0bd42sm37527166b.9.2026.03.11.01.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 01:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 09:04:20 +0100
Message-Id: <DGZSPC64B8K5.3HBPHWMWXR482@fairphone.com>
To: "Conor Dooley" <conor@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Marcel Holtmann"
 <marcel@holtmann.org>, "Johan Hedberg" <johan.hedberg@gmail.com>, "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>, "Andy Gross"
 <agross@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 Bluetooth
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com>
 <20230421-fp4-bluetooth-v2-4-3de840d5483e@fairphone.com>
 <20260310-maritime-silly-05e7b7e03aa6@spud>
In-Reply-To: <20260310-maritime-silly-05e7b7e03aa6@spud>

On Tue Mar 10, 2026 at 7:02 PM CET, Conor Dooley wrote:
> On Fri, May 12, 2023 at 03:58:26PM +0200, Luca Weiss wrote:
>
>> +&qup_uart1_cts {
>> +	/*
>> +	 * Configure a bias-bus-hold on CTS to lower power
>> +	 * usage when Bluetooth is turned off. Bus hold will
>> +	 * maintain a low power state regardless of whether
>> +	 * the Bluetooth module drives the pin in either
>> +	 * direction or leaves the pin fully unpowered.
>> +	 */
>> +	bias-bus-hold;
>> +};
>> +
>> +&qup_uart1_rts {
>> +	/* We'll drive RTS, so no pull */
>> +	drive-strength =3D <2>;
>> +	bias-disable;
>> +};
>> +
>> +&qup_uart1_rx {
>> +	/*
>> +	 * Configure a pull-up on RX. This is needed to avoid
>> +	 * garbage data when the TX pin of the Bluetooth module is
>> +	 * in tri-state (module powered off or not driving the
>> +	 * signal yet).
>> +	 */
>> +	bias-pull-up;
>> +};
>> +
>> +&qup_uart1_tx {
>> +	/* We'll drive TX, so no pull */
>> +	drive-strength =3D <2>;
>> +	bias-disable;
>> +};
>
> I recently made some changes to pincfg-node.yaml to detect if there's
> conflicting properties used, and these got detected. Should these not
> do what has been done on the msm8998-xiaomi-sagit, and delete the
> inherited bias-foo from the dtsi?
> &blsp1_i2c5_sleep {
> 	/delete-property/ bias-pull-up;
> 	bias-disable;
> };

Yes, you're completely right.

In the final dtb qup-uart1-{cts,rts,rx,tx}-default-state contain two
bias-* properties, this must be wrong.

Thanks for pointing this out, I'll prepare a patch soon!

Regards
Luca
