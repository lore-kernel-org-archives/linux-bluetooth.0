Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7513823A2
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864660; cv=none; b=fXcjucoKuAPl8TJ+wkpCXkGkDpLd1jIg3mPc5/JRTdHqUphzkXyKxyjxw7s44ndhFleS4D1sAI9ottme9WiiVTWfF0EE6JHsu4JVS/bTT2Px3LjPf4DJSyCT3tM/t3MZsK0D+RkaM6EhW1PXZKsjIyURBSUW992f/PNdipOjWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864660; c=relaxed/simple;
	bh=fKSF8pzEMf4QAy0lGBTclAV9vz3vznJXW70/aPT4oU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8xVC5/t3oRqQPrU3x5wbvOQgYQwYFO9+cejkU5AcmJzmftpoCmEt1eZNBRaW2HoOLchgV2TTli1N4zMxaeIuoDTam1VMwc3NS0CSCVw5EzDZetqwyfTmuBIlDFj0a8L+xI3CWCFCRwSuj+iDtRqayyiQfiseKxR0SGfmOkEpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ACZj6wQt; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACZj6wQt"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-789e70d7c07so255386985a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864655; x=1711469455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfOND8/B1sy+/Pxonj2Y99N5MbJN54ZzelPtBRESoQk=;
        b=ACZj6wQtlMqTdVwXJum25tZRyuTmVxudPJltxtfEhZK9w65jlcpxig4KYeJUtoeFgF
         fLS4tnuZt17nLYG13RJlYstBIryk1v/GM8GEHTpV9O2sAObgfcpkOuSh/aITtaDYXGLt
         pGFCXiWp+qujniZRuX4XcsKVxNgWy5auPjltg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864655; x=1711469455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfOND8/B1sy+/Pxonj2Y99N5MbJN54ZzelPtBRESoQk=;
        b=SDVbLBzy2dzCj3Ur5k5wdvC55FxgMQcV6jVePXPwnhdbEO5WzzGzkMzqAwTicQ43GD
         A61gB1Ucvjr178OeWcbOV7vz4B65wS5cBpmSoj/UDYbcUBY9PR8VuMvnm7V/XYgDVoEv
         2OUqADjM/+/zRQMHjAk80NC8M8HYXVaGTBm3og1jrDZ0tkIkBusIIQERsc/jyJmF/Slb
         940l/SSkR6L4ghrJ98WeasdXR2fof/jOCCnjQV3SpwQleIH6FOOdebuwNc7cvdCUoT/C
         JTQRhhg00bmdgMKNABCXJSaLyBvwqVV1lMyUbAoxrGuUt2x0pQyXL+mrp+/QNAH2mNRV
         Qv0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUwkbdHqNGLw/IioSlMIGzh3+jw3o1ehR+rjK4rXeAogqPP3vBwXiUC7Orgb3FqNIqumJPXqJNsO20HqFG+76pa0I3uoSH2wQytVZG+vin
X-Gm-Message-State: AOJu0Yz5spxGpqWlQCqTUwm8U2TJGQAaI62oLRMZ99RbwpVPW0cYB8iL
	kHBF94mNnB1/JGEHaJdUxETmsJz8IHpLWqHI08A6g6Xu+gALZx3/15uzG/o02Ulrs6GwVt/1G5I
	=
X-Google-Smtp-Source: AGHT+IG1flYTt7y7vphX2x8Q+e+htZlm7mVS9ymziFe3AJmFcCzpMBy8xuNYjgZycgGRHGYb3xU7Zw==
X-Received: by 2002:a05:620a:4003:b0:789:ec18:6996 with SMTP id h3-20020a05620a400300b00789ec186996mr13644517qko.26.1710864655447;
        Tue, 19 Mar 2024 09:10:55 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a111500b00788622ebf52sm5229826qkk.85.2024.03.19.09.10.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430d3fcc511so264321cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOfuBiXU/TwNSP2C4yD7bW6U8MdyonGIf26MPxCOcXaDTq9XlvgfoFj5x7gloqXg/Jfrd1Whg+nx4zGc8BSnloit42KwrfQmksu9JpKmBz
X-Received: by 2002:a05:622a:1648:b0:430:e26f:4bfb with SMTP id
 y8-20020a05622a164800b00430e26f4bfbmr262803qtj.19.1710864653792; Tue, 19 Mar
 2024 09:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-4-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Message-ID: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:30=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> device address in big-endian order when setting it using the
> EDL_WRITE_BD_ADDR_OPCODE command.
>
> Presumably, this is the case for all non-ROME devices which all use the
> EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> use a different command and expect the address in little-endian order).
>
> Reverse the little-endian address before setting it to make sure that
> the address can be configured using tools like btmgmt or using the
> 'local-bd-address' devicetree property.
>
> Note that this can potentially break systems with boot firmware which
> has started relying on the broken behaviour and is incorrectly passing
> the address via devicetree in big-endian order.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device addres=
s")
> Cc: stable@vger.kernel.org      # 5.1
> Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Personally, I'd prefer it if you didn't break bisectability with your
series. As it is, if someone applies just the first 3 patches they'll
end up with broken Bluetooth.

IMO the order should be:
1. Binding (currently patch #1)
2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
3. Bluetooth subsystem patch handling the quirk (currently patch #2)
4. Qualcomm change to fix the endianness and handle the quirk squashed
into 1 patch (currently patch #3 + #4)

...and the patch that changes the Qualcomm driver should make it
obvious that it depends on the trogdor DT patch in the change
description.

With patches #3 and #4 combined, feel free to add my Reviewed-by tag
as both patches look fine to me.

-Doug
