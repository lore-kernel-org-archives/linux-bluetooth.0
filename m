Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D28266F0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308791; cv=none; b=X5GdNeQ8QT21MIKp215O3WSW3j+mTSQsJSHgZDTNGbIxwDRqn54H2bHw2WLW8Q8517KLtelGV6MPKOnUvlPp6ha+sQoPwAY0aIY0oJHxJ5l9sFnTVZyTTw004SxpOi9nUod7RIgicgq/q9/wuaFtNZ2jESEmynG+0BShrAfgUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308791; c=relaxed/simple;
	bh=v+NotQmkypHRHE+nHTFJOTzrbxnNJ6Og8Bo7qTcrXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG30afzUNFLJj+JUqGy9UusYadLl74tct7Qb5pDipXMoLe3XI4YkDuYt8kaiczcldI1d/hfQ1t75MD5CpYN2+/XbBdUyToBGaSr8QuOOEaKuyk0SSY6AcCBAKG6XbtP70b/cQHbSADscuiHRVUf1393U0FayPgXVGH9bO0uER7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SuTXjTZ1; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuTXjTZ1"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5b22d35268so5314156276.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739308789; x=1739913589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8vMpnOzz24XlelaJjtEfRnOqqAth0NeggjrcIGJFxfY=;
        b=SuTXjTZ19A00FUPjfW5OIYpo1Pj7eXvnzezX2PSBJxCZFMy3+xCG+hWTjB2jaEIDpp
         r1yomxBrNYd9IoPPc573d51xwZSGdEHbMvAHDMCw7RfK13I/BObzcJIoy2n75sXqpNaM
         rq1gakYpbMsWWRVB0K3XKyMbl18OZDuNSZgiGThJsLH63GB7eyz+7nF9ynT1GX+x96d4
         e5Qihpk/If7a0cWz2lTQy7yHbFLmS7phf/SbiTVUlrWVReoVlWTBxmutO3hhnPVBF+6F
         TqqFHR2art6vHV1f6BHNGY0t4rm2RVQReGSXdSkfsgB6IaXy1Z0Yd5pN0r7KmEswCkkD
         3HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739308789; x=1739913589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vMpnOzz24XlelaJjtEfRnOqqAth0NeggjrcIGJFxfY=;
        b=HD/ZApjgJdoWh7NuGPKeAoeE634APoIK+6Mftafd0SHCz6uYCKkyJTYa5kYJwYebL0
         cwtZNlFKq8k3vfRpqVbdVgU6pQQXw2TIpUq5eZvTaPvlsa12sNPIgZTzAPItsdV6VSex
         +UU3VpDprtswdhFDMUISqXRJZmagf5Q9SGCnx4duninST9ygjjj3MnPaC27Ns1rSz9AW
         q8ak4g4Dgc47iOZPVHiH2paMnhOCZ10tkUXZBgXRxeJWXTUUbkDl8VTHw2X/d4O7iQ5c
         +wh6fKWbXJMzzoU0f6LXs5i+c9sQlLg6P45gmu0ACF51PPA+VYbMZTc1WcgEA7hITOBe
         8U6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8T0SfWlAMqvKbrv7DzZLrYap16uTMHjTWi/EX6YmpxqWcFNseaoCp79YhALSxbMB9QfmkFMoH5GK/lBvaqC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZQHzUKQm6gpmr8o8xrvdB3D7YFJYidSVZ4wDQyi84eKjTIKk
	F9dGZ3T6tmCG0b6BkCf2VXdm0U7KkRyrI6xJSOXqNOK7vudyeLcUUb1gK0lBZIbxJSXXRiom7cs
	yt8LXvJ07yQl7U7KIQSg6R5haxxd8S+ik7EHnkw==
X-Gm-Gg: ASbGnctMslQoiiW9zn2E21p/qbZpH6JDlYG9ignbG3SRN5+QP0D0541W8xNfU3SLJsJ
	RAhQsfNfz1ZtSSBI9KNoMfOWDpGe3pgPehmXeQ59E/oyxExp6UHmslRQhB+78MKVR6981Zjrrri
	1wKnH8IxHPPwKxTxu1LsgYinxFcvsv
X-Google-Smtp-Source: AGHT+IH9PQWCcTuU3a/WUrp8QtPQgxzfoa0eG9D03GuXuge0++Qcj4dBm/Lk+WFXHD1fsOGrWKTo04Qt3z/nEYlknZk=
X-Received: by 2002:a05:690c:638a:b0:6f9:88ba:aa5d with SMTP id
 00721157ae682-6fb1f194f3dmr12585947b3.9.1739308789048; Tue, 11 Feb 2025
 13:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org> <20250207-rb1-bt-v4-6-d810fc8c94a9@linaro.org>
 <6e5bb2f7-a23b-4fab-914b-e67911eaf408@oss.qualcomm.com>
In-Reply-To: <6e5bb2f7-a23b-4fab-914b-e67911eaf408@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 11 Feb 2025 23:19:37 +0200
X-Gm-Features: AWEUYZlP4_dHB7Swwx_XD496R58hsBttKN3cXZEWV8-yu1YbBT4qWLOogarYxpE
Message-ID: <CAA8EJpq504V48qqSX0mzxCffUkq_xpu_UE+qubB46A7zon=0iw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: qrb2210-rb1: add Bluetooth support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 16:52, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7.02.2025 9:41 PM, Dmitry Baryshkov wrote:
> > Add support for the onboard WCN3950 BT/WiFi chip. Corresponding firmware
> > has been merged to linux-firmware and should be available in the next
> > release.
> >
> > Bluetooth: hci0: setting up wcn399x
> > Bluetooth: hci0: QCA Product ID   :0x0000000f
> > Bluetooth: hci0: QCA SOC Version  :0x40070120
> > Bluetooth: hci0: QCA ROM Version  :0x00000102
> > Bluetooth: hci0: QCA Patch Version:0x00000001
> > Bluetooth: hci0: QCA controller version 0x01200102
> > Bluetooth: hci0: QCA Downloading qca/cmbtfw12.tlv
> > Bluetooth: hci0: QCA Downloading qca/cmnv12.bin
> > Bluetooth: hci0: QCA setup on UART is completed
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
>
> [...]
>
> > +&uart3 {
> > +     /delete-property/ interrupts;
> > +     interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> > +                           <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
> > +     pinctrl-0 = <&uart3_default>;
> > +     pinctrl-1 = <&uart3_sleep>;
> > +     pinctrl-names = "default", "sleep";
> > +
> > +     status = "okay";
> > +
> > +     bluetooth {
> > +             compatible = "qcom,wcn3950-bt";
> > +
> > +             vddio-supply = <&pm4125_l15>;
> > +             vddxo-supply = <&pm4125_l13>;
> > +             vddrf-supply = <&pm4125_l10>;
> > +             vddch0-supply = <&pm4125_l22>;
> > +             enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
> > +             max-speed = <3200000>;
>
> I suppose we don't need a power sequencer for this smaller,
> tightly-integrated-via-snoc chip?

We can (and should) have it in a longer term. Currently none of
wcm39xx chips have a powerseq implementation.

-- 
With best wishes
Dmitry
