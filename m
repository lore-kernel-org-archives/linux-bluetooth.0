Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51D2594B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945335; cv=none; b=LKy4xP37Mhzz7RLrKHK4eT7ojwzcoU7zDGLHMPcW9EOtGC4IoUYfHhe32jSXEreJaRBdXT3wDodPBSZoBOor31eXE/8yvYzEgsUMiMx4FVUPTTbbh1FBV6EGL0idiGw/z6+7ciLXlzNaO4cao1OibHNOCqgCPA7u8wAej2EkETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945335; c=relaxed/simple;
	bh=saI+TJ4WwQAKgDdrklhcfnFFyZMNGfi+r+nYwnAQ5lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErYlwW+vNT6DJEd52u9pHNuqcma2OLSvqdXfv/rS9mD7QyKU1Q1MpXPWqCsaRZc/L8/O8hTaU777oWMCrjV+dPclbC3lxw9zm374dIablXJgIILwyURAho9aUxSI8H1aPoARq4G4IXISzR86OZZH5thZVmPVub1wfiHgv+6juOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BHXkqup9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHXkqup9"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so3758954e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733945332; x=1734550132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNVz/ArW/lLNjVQfl87+kX9B15NlodHN27QuCLAE0kw=;
        b=BHXkqup9Y/cmRamG56yF+N9RKYHjpfdvEZA40eLUkK4wV74ALF7+EX3b+Mq/wa66W8
         xGmeGp1cD+f2QWkkm5R6RjjDyINZ+fmcB8m5U3nAKDkJObjt47InkBlZYnQrXShUdOkS
         DQ8cr+iPdpFeYiLR5yFworFlJKZ9ePZrMPI4HxoX0QSDCoMA1Nv9oq2//POsxzWndCKs
         DydgprNCHQ23jWUDIuCl82DMHnt+sLh/rEFKI+1M9RVYsoWVKovXsJMcbEgp+Kg8KjGa
         pLhdPyLWEgIBeoLwmsWPgzAbdVYLfKuXCtivx6eSlH00GjLjdoeelow20g+NeVgOM80y
         pgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733945332; x=1734550132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNVz/ArW/lLNjVQfl87+kX9B15NlodHN27QuCLAE0kw=;
        b=MhZde7Ac0/rSyk+TX2uCm6xGS7oUVtQXlDKPpfzLyBKmWBXO2PTVfHGfFXjGR4taQU
         0a7VWMTDSW7DUB7cWqy6iCtnI4lvRRhbgSn+qR008D728CFB5loXBfYZuU4q1O+zOsuq
         NoccJ7MsgGEGYqfO5A+Y0HC+QqVTP5o0zrlbXSH+mojkHUmpmrtgOnmtWPcRUDdTSJyj
         +S2Q4zzkysmy/zDO7BFbXzBA1KgBGsK9tbGisVf+7zbn9j1kcYr9V3MTnYH1ngdYJSFI
         9qa/80kVkYPTV6tzitEW99d48jBG3M8dZTZl4pk6s0falr2NxPiyaG2Kipa7jH/3z6BZ
         b4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXlK0oZQLym/3jZYfnS6Vg60r6CTcv51olJv0KTSOHWTq55VU7XgJqCjXr35aie0PvVgZyUjmwFrEuXmHbuB9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytasm1/O/BUq/w2sUeEZXgWzIsGJFJP6xf/BoHAZXqKidf0dgF
	YBKqMCIi3WowLHfy3Rnr1hWliYbhI5rkNblwYIl2smoaaIAnRfXu7NiCD7FPHbhRWgOMkQ5iluT
	ghp0=
X-Gm-Gg: ASbGncur8TGbqukKlo0BGZbh1ZuxCTttgcZAV6Ru/wA3etcKW30/f8mvhcYsnj/kQ7D
	w9LA1oc5pvaqRTmqrJ43qPZliUWpFz5M5HkWzr1SJK+y2BtKyKwV5KvriPevD1IjTS3KmMfvsl6
	i8Rk9C9tDEePB7k78KuyN34p2qgtGdhYFHFnhKgmIn0CbFNCwXgzYx+bmMCKYD+U9IVKBncsWor
	bUFe0HphvFbfjdE/VoOccLEOAa3P2WkBOe2olxM52VlhlcRjsCoy44GKZD24L+hrlcG5vqHM7wn
	pKmSmOnJ+MYnAe3+ODiENVGKB0F6JyPvuQ==
X-Google-Smtp-Source: AGHT+IGOfbXPT4dn2jZV1RKLOlrX7K+m2akt+BVMHTUk1WVTQ0bQV6RFUx4RBGUDnQfN4dhyAyjPRA==
X-Received: by 2002:a05:6512:1391:b0:53e:20af:db96 with SMTP id 2adb3069b0e04-5402a5d3993mr1464865e87.10.1733945331546;
        Wed, 11 Dec 2024 11:28:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e2fbbb0c0sm1773317e87.191.2024.12.11.11.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:28:50 -0800 (PST)
Date: Wed, 11 Dec 2024 21:28:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_jiaymao@quicinc.com, 
	quic_shuaz@quicinc.com, quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: Re: [PATCH v4 1/4] dt-bindings: net: bluetooth: qca: Expand
 firmware-name property
Message-ID: <dukhhbf22w2hcr32jtjuvminpuzgi3a3tkkux7pd32j4d4gzkx@mvgckzd22she>
References: <20241210151636.2474809-1-quic_chejiang@quicinc.com>
 <20241210151636.2474809-2-quic_chejiang@quicinc.com>
 <vbwg7djb4me6i4ow2q74ltqjxvkxeulhzyq4n6ak7aifhtf36f@x66pjje2iu6u>
 <62afbaea-67b1-4572-9e78-d1dbe5fae20a@quicinc.com>
 <f818f089-0490-42da-9aee-1a7006c11978@kernel.org>
 <65fd0932-4519-44ac-ba9d-55ee97b43233@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fd0932-4519-44ac-ba9d-55ee97b43233@quicinc.com>

On Wed, Dec 11, 2024 at 06:16:44PM +0800, Cheng Jiang (IOE) wrote:
> Hi Krzysztof,
> 
> On 12/11/2024 5:48 PM, Krzysztof Kozlowski wrote:
> > On 11/12/2024 10:39, Cheng Jiang (IOE) wrote:
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> index 7bb68311c..2782d2325 100644
> >>>> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> @@ -101,7 +101,10 @@ properties:
> >>>>    max-speed: true
> >>>>  
> >>>>    firmware-name:
> >>>> -    description: specify the name of nvm firmware to load
> >>>> +    description:
> >>>> +      If one item is present, specify the name of the NVM firmware to load.
> >>>> +      If two items are present, the first item specifies the name of the NVM,
> >>>> +      and the second specifies the name of the rampatch firmware to load.
> >>>
> >>> Don't repeat constraints in free form text. Use proper constraints so
> >>> you can validate your DTS. And then actually do validate your DTS...
> >>>
> >> It seems unnecessary to add this description, so I will drop this change. Is that okay?
> > 
> > You need to list the items and describe them. See how all other bindings
> > do it.
> > 
> The firmware names are not fixed strings; they vary depending on the chip, board, or platform.
> 
> How about the following description? Thank you!
> 
>   firmware-name:
>     $ref: /schemas/types.yaml#/definitions/string
>     description: |
>       List of firmware names. The first item is the name of the NVM firmware
>       to load. The second item is the name of the rampatch firmware to load,
>       if present.
>     minItems: 1
>     maxItems: 2

I think this is better:

firmware-name:
  minItems: 1
  items:
    - description: NVM firmware to load (extend the desription)
    - description: rampatch (extend the description)

> > Best regards,
> > Krzysztof
> 

-- 
With best wishes
Dmitry
