Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2838F63D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279199; cv=pass; b=g2LMV5UXB+8+Riy6rBukoF+mJHJf97QBza5Ecwq3mNkV8hhOKa9GF4StfvMqbG9j55vuiGL4KRMh64G0YuHYo4nBj2ORoveJ+OoXM+0i1X9pRfph0V5pawvnydBoU+wrThJBEmGfdt2EFSvCeaGaS3GgNm26mdfjTVTLFH6v6qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279199; c=relaxed/simple;
	bh=XmooFYO7MJjwuHLWtjcDdWHx87YsWZvV+Cm4GZY+JDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxuiRQjUi2CNk3Dl7INlk9P3XjOuAR6aqb7G2f74jmOwYpa0BvzbUB2WLj9UAuv/S35g2iJJXwjHUHhhYwC7FV0NGe2gsZp42q5+4Ymo3czwU4ZwJy2hn8csjF7+w9eNkMd42qsxhZ2TY//qWNXmr3W/TAs5P0HUgwa1ZUI0lNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTdOWnab; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTdOWnab"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66043ecf6b3so1158210d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 08:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781279197; cv=none;
        d=google.com; s=arc-20240605;
        b=aQthz6sdDh0i+xdVChb/ANKPPSjV7F6WngYaDVyD3wgbB4XNjNj9O7wqXw3PaUv4W2
         z4vVhN64dpk1D5uUrabB1UWTkL2ypy2IZ1F+m5yMMskGCWiHqL/IWqyOWkNuKVqIST/z
         jGbvL2CWO8bdwUf9VSH2+AZtZQGbCj7KSRuNk+N5xWtKm4vMIveVQpDbiwebcOpI9OUy
         t6xuNOPa1+p5tihB+gzVjp1qthnb3lyGbKh6q+W7XICCXdkT6OFiB4TIUq/OrHdRt1jL
         IOoG7J/AaMDAzle3wI7+sjJaJOB40x68nJ2s3zobBxc42Mfk4Z1tvxswpIH1upBItISG
         DVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6+TDJXVkZEdcmhC7QL7gnqoMVbu8ebFypn+5HhBnCM=;
        fh=FYWc07wuvmzopGlOXu87xEX/q/1ubHYuR3pHyqyfglg=;
        b=Z4qAFS0Ky7w70Oso4RjthFvPclFeaAlcchSgAo5LMrzsCpI5yzLFOSVOMHS6oUeCZ4
         vjJm+VscRIDX+qrnvu20MFh9tFYbTLpFFfI/P//5ofdDWqjDzpcS88zBDreqF+QfQ3M0
         ckUSItScdYrjWU9Hno8hm6FVx+vLBkuNm/14iDvXhl+If6CqxGVLiI7vXomM8Qjh7BS/
         O2Yn6M5P8OZnb1Z/AKmjWU2D3ZQE7aefeL8NQvzSFL5l4dVB8KzFjs7FJUyiMwyTjx3Q
         lD06O4tFpGBeJR5226/vhm1AgUVIXySpNFAwZw5qa0Kobz5NTk7FL6IAOpw2fOgEGNil
         WA0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781279197; x=1781883997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6+TDJXVkZEdcmhC7QL7gnqoMVbu8ebFypn+5HhBnCM=;
        b=sTdOWnab2g/nh1baVfJVf0+ExYOqQkbNl5HV6c6yysAx848lONEk7gji7UUw0eNKEW
         o7kps/V46c3oCV93vWiFfICAnW9P717fSvdTkhAIiAqS0Tp9xSymDxh3R5vJtXW1k1ay
         M0ysBRooR/T8j3ywyOmOKbMkXAQnqbTNvILRo5gaTS97d1skNh4u+qOK3d101FBtYkEw
         PjjRHvmHhcsN5pCWiNoikggYRCivOyYBtGmEFJC8ZeOSxlgGHQ7DfYFKPwjjUqcTaxhB
         GXKXJknq4PtqUkxAmcK4lZ+EqVwlXgNs2ST1uOj5ghTFA2W9fFbTNcXD5gga/3vRN3vD
         GLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781279197; x=1781883997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6+TDJXVkZEdcmhC7QL7gnqoMVbu8ebFypn+5HhBnCM=;
        b=SJn0n9GiSLoNPPzFvcnDrZysB2EyOLkS9eekdcr/lTfwuQkc5NSsOyHnE449awFI2Q
         87CaLpAgwhgEIVKtgpfLqwpBLKxqvcndwSi5AULED+ZKUwZhl3HY3ERCyWbh1hb8xuSr
         BSzpk9bsshLFnbXGX37R+xX9s3EVGmMJHsz7QMOgU3cvciDkwNXxDq2gT3g9utTsl/PV
         lbLcWf8U+mSJd+A7xv0QiMeL6sjFua5XyNyDUOzX1HoYQXiXrF0BosiRu2JPobpWPYyU
         /SfUIT5hk34clWVJUwH4Fy4xMlNyXwyKgpPRlzXh/tuKeKyHaraLSctc3EwH5SEsgMq6
         5oWw==
X-Forwarded-Encrypted: i=1; AFNElJ/YUCTHVXXEjedsQmKUynPIxLuRbYO30ZU1R+PC4rJwppY6v3dBGKh2j7XKLDtzCZEuLvqlDG8hCGTmrXiT0gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCUyhYA8pKLWk/aJ2Q7uhf1nIAMKZPulWqmeGaT1v6lFb0CCX
	ZlwuFmWlwjSEsPYEVQ2nUAK8Ch2ElNUCGlYTucHcYnT8RUdvJaYNj5D/z4xGgyfGkhGw1gufzLs
	bH8XKzGHed6OimCpp11jWMs8JVHiv0vk=
X-Gm-Gg: Acq92OF5eBFRPZBBEG1FJsK2x8NQiH9h6EVZK7e2igKzpKBtq1QR55cylpF7pVdMexk
	Xy+ZSPjd8ka7CnU8DB2HTbZa5GnkKKS4X22m0gqyebyqJf3I0OqBqPqCDl7YjIbVXI7AVqDQEUZ
	DEI10Eb/Cm+QY2NsrNaStFmMrJZXutyRsHA21/zs6ewoOh2j8OXb7mxiCujjuovVxZDwEP7sRyF
	MPg4euMj0PvzABEWox/BH7Lv8dC8mw0y3plLtIOY3PataijUzzc+34/V3uAI2t9/my/HCXo0Tdw
	6AuNtm+BQzrs6uyuvQqEbc3FCHh1Nj4vB/ZJvYSQnk9VzX+2DFw0P7qvCkRxwWQY18lcvQ==
X-Received: by 2002:a05:690e:419b:b0:65c:7129:5c66 with SMTP id
 956f58d0204a3-662782d4c92mr2935747d50.41.1781279196694; Fri, 12 Jun 2026
 08:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-2-393322b27c5f@fairphone.com> <DJ757RE8OYHO.2XEXNTLVIJ497@fairphone.com>
In-Reply-To: <DJ757RE8OYHO.2XEXNTLVIJ497@fairphone.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Jun 2026 12:46:24 -0300
X-Gm-Features: AVVi8Cc-RlrekTPykssUtkucAEzJ495V9LRVQKNsNE6WJFZ19JGNTXkFLsVH6_4
Message-ID: <CABBYNZL_FmgjOKP-rNzc6e=m8oHdzN=7cLbvLqcHi1Otpa8puQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: bluetooth: qcom,wcn6750-bt: Document
 WCN6755 Bluetooth
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Koskovich <AKoskovich@pm.me>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,

On Fri, Jun 12, 2026 at 11:33=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.c=
om> wrote:
>
> Hi Luiz,
>
> On Fri Apr 3, 2026 at 3:52 PM CEST, Luca Weiss wrote:
> > Document the WCN6755 Bluetooth using a fallback to WCN6750 since the tw=
o
> > chips seem to be completely pin and software compatible. In fact the
> > original downstream kernel just pretends the WCN6755 is a WCN6750.
>
> Could you please pick up this patch (or provide an Ack if you want Bjorn
> to pick this up with the rest of the series).
>
> Regards
> Luca
>
> >
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  .../devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml     | 10 ++=
++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn67=
50-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-b=
t.yaml
> > index 8606a45ac9b9..79522409d709 100644
> > --- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.y=
aml
> > +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.y=
aml
> > @@ -12,8 +12,14 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -      - qcom,wcn6750-bt
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qcom,wcn6755-bt
> > +          - const: qcom,wcn6750-bt
> > +
> > +      - enum:
> > +          - qcom,wcn6750-bt
> >
> >    enable-gpios:
> >      maxItems: 1
>

Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

--=20
Luiz Augusto von Dentz
