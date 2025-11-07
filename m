Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5E32B993
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529839; cv=none; b=PM2UMT2sBP3cDbHNjLiN7CxYgI/04bp/M3oBTAERA9T8Zm/CnnplTKS+F7lijJCPuPOJJK91AWHkA5lOX5bR7tb8nvQ9MPECr6b3Vw+fNke7K6X11oAvZm+KnCcqzxHGQhNopMOfukJfOVp+oTHXsEtnwA8hZTHmncI7IOJRLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529839; c=relaxed/simple;
	bh=YAtagVcx34LiTu2Em+AG4zrD5yn9L45QqXjTBIFCHBE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLufzb6hHBlKRl3KCxApLrFU6d8pGDqEW/GQBYmkYKtm5YnkMfszI4enurqM11AchGc/xdgona9tguZH7xvS8CO2SsOVRzBkJXo4QROFvdhMa0FG6ryLemQIDy2WugkVD3mPH0KrmPAequ1/mfq9GMfdSoVOxd8sthTfurF+EOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FZ/RnJ6f; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FZ/RnJ6f"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-58b025fce96so777355e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762529836; x=1763134636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTtcdT44O12GZqFLnS478W/Jpk+0DJ3d4h0jXmuqd2w=;
        b=FZ/RnJ6fWpPxXrB2+fvFJJZde+Vmv7M2WbHBwXXnJsLl529BoFWAb/F6fQUuE1SMkG
         EIDp94UvQU7xiUsXn7yVYAum3qPN9Tug63tdpkbry6XmHbMfgBXeBA3QgUza9AJrt8gr
         NTC7yy01wLjCDZ0AHLPZcSIB+LZckQIF7HRckGGC7cKh9mj3kwz0irNlIHEp0p0MqzsO
         tbHrFwWwjeGJQSjNn9c2wNbMD4S03m+6QSp/6EPzr+nebdXVL7fJ/t2V2+JBDWg+U7/w
         nYKQncAVBWHvguzUVBU7dXgs4mr1Qt6Ttq5uffS4VjbqXz65x8VnMoGmSsYm1vJkMR0v
         g/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529836; x=1763134636;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTtcdT44O12GZqFLnS478W/Jpk+0DJ3d4h0jXmuqd2w=;
        b=guSy/iAicxm2v8f6xDrwyteW8k/T97NJ5R4TtJjfJ4r6NjuBfaySNTQWl1w3mnZuA+
         uG2jP0KWlXPX3RB7He/OpAYWaAS/AlGbcNQHL7SJG57+eg0SK4ctA+afyiD25373cpuk
         SMYLr27Gd9bRenD++gaDICZ2Ve0PVxCVSzKmc327P/CyBakVxKg/HqlVC9hkL9bXL1ao
         qA4QT4KPV8Arc23Kap47dmG7MhaVBpwuL1IyXcyChbLARXONK0J1qFz1EIgiCK4sRiyl
         wIRDJ60OzN9SolFxw6V1OIzbl6qkpWOL8P0Ls+NUjMTMeXQMieFREU6t17OwtsVkkOg6
         pk1g==
X-Forwarded-Encrypted: i=1; AJvYcCU3qzMqtDDuxXjhTrvvJmmWU/E9mv0lKnU9ZXK97+/dIfDO/tUqI5KR23Qr1GLJbvlw+jYHow0y9kTTnV2On3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFn0DUem/VmdeYbA9n6OATfAS6EEeDAu+JNrnTxDxt6dQOIWKo
	H7AHE/3TZE5miI8DFYMWRQLebGLjgjb2YNHm1X2TpcTHN+L9mkD8igGLFJxwOgpS6vPrwv55JsV
	viy5dkx1Dspo6HP+zRre5RwuDLN6sHoRapSBeqbhHKA==
X-Gm-Gg: ASbGncuwQ7CCNkA4SLnmPXL6LMIeL62gxhyakEU08bgcrfyTi1fsdBNSCZonXt9TPz2
	KO2A/SZPSKXF9rlKeRnaALMKmZIzEVR9aqvI9+Qgcmqv993+WuNtigQwDbaqKl2XBW87R6AbGAN
	ABqkAAax2e+3/SWyYn7Y1Kfh0Ha8SCa1AW77raQVKUufmgqhPmgcQPwTr73PtLgkUPtTzFbSRjj
	fndY9/3dGHXadf6/eLLtoHICsMiLFcVI0DLNkF/8VW2HEk6WWQ9jSLqpLF2UG9gX+1+Th/6fUm5
	41dMD8j8fhxUZD8=
X-Google-Smtp-Source: AGHT+IFIQWLvyizEJkA6WQQPfls6s2Ke/GDQq2r3QKt0gm0TI4N21r92bi9oP4EBFVG7CQqpb1Qa/kmwxqVMsaEgQbA=
X-Received: by 2002:a05:6512:114f:b0:57e:c1e6:ba8 with SMTP id
 2adb3069b0e04-59456b689ecmr1167747e87.12.1762529836073; Fri, 07 Nov 2025
 07:37:16 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:37:15 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:37:15 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
Date: Fri, 7 Nov 2025 07:37:15 -0800
X-Gm-Features: AWmQ_bm8xW_kPpRTsH9WNw3ymMoDp75e2yehSkvO8IUPn-NE_tXci0xOQuXb2kk
Message-ID: <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	quic_chejiang@quicinc.com, quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.com> said:
> This patch series fixes delayed hw_error handling during SSR.
>
> Patch 1 adds a wakeup to ensure hw_error is processed promptly after coredump collection.
> Patch 2 corrects the timeout unit from jiffies to ms.
>
> Changes v3:
> - patch2 add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>
> Shuai Zhang (2):
>   Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup
>     during SSR
>   Bluetooth: hci_qca: Convert timeout from jiffies to ms
>
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
