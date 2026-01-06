Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545EB3168F7
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705289; cv=none; b=LkSyHGf2eBD1aGWA8HjbDzJGRtZufHZs5isoq9m7k9LJ0Vd7Xp0CE97pfgiwjHF+KbRbKGEf9l80KaWAIrb2RRFz7NkKRi8BAIvM1aYO2LKCWXe6vKBAgFWUvzoZ1sT4hFMVZugFtCXnrahi38ac7ViGCyORtF+gHalWIE1lsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705289; c=relaxed/simple;
	bh=XEcY2upxWwXPboM1OMJJpo3JWYfcppRAEThk5NM9hx4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONG841fCvdIIpsfF7qFqBAuZaBWL2fVXnWwTuBbAjyYyZEhCWCDFTO6p+f4te/3n1ZjMXI4Fr7vktc96ddv9dC0reQQQsUJNaoEi+bHR3n4SduJ1MmG5K23W0/Mff8Z5ZKQz005f+NqJqI9lWvTdtYZeZlxvfXYYvPoGK9Fofe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyH9+Ifm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyH9+Ifm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E429FC4AF0E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767705288;
	bh=XEcY2upxWwXPboM1OMJJpo3JWYfcppRAEThk5NM9hx4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=ZyH9+IfmbKI90UVEOJTqr+spQ5WCQq5C6b1xWE8Cmr3xlmvVRxv26yy2b+A8AKaEW
	 xmSL6Zc+3pnyKk1TaQ3Rfhxb2VOXYYuESz1RG02/Wp+chphvaZOa7SHSxzcusWOHyP
	 bfQQ3wG9rHf1LhIsw70tD5zfbLXLBrXC5fJ4mn7Kea5gjVOa0zFDoA2lf7vYU/6xxv
	 LXRdqEXwfyNfG3GawSijafMetyO7xczOahNaq3rGTCEkLNevKY3GsE8nDCuqSYafeX
	 NOMgHwWxeK58djJVRke1FAsst70jPd1g2t4yAZOzqOiTVEZYACtnAgK6sZMZSgyfZ8
	 q2nKEwYKUFkMQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59584301f0cso1138029e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 05:14:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMmoF2et6Zp8SQYBOY8SsfPWWz/QChjjZ5nvHIJhS9EDt4WwIrRTr8056dPOp0ENd7MvBiYtERkCtYQpb9f4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdsJFtlzy5s/bNt62QvCeMNO1XreBWRP4zQNTbvA/BelJ4+oj
	LYv76CbAH4sbRelRskEsabv8eC/4gjesgfUsO1T4x/zObAHcyBX2n11HW+SAWx1ZuqZADh/dl6p
	jleqdQJEB7J06WQ7fUE16H2Zcubgz9p3R9Hm5xCjHCQ==
X-Google-Smtp-Source: AGHT+IF9KyzAqY2KwwizAqtATrziY/RjrqWsSe4vnSR5MeXH6pboV72zdfMtPAhRGdSn/wr0kDgu4UxYd/GGGXM6ZX0=
X-Received: by 2002:a05:6512:2246:b0:598:de13:609a with SMTP id
 2adb3069b0e04-59b6525df64mr1030049e87.37.1767705287542; Tue, 06 Jan 2026
 05:14:47 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 07:14:46 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 07:14:46 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260106043503.534557-2-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106043503.534557-1-shuai.zhang@oss.qualcomm.com> <20260106043503.534557-2-shuai.zhang@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 07:14:46 -0600
X-Gmail-Original-Message-ID: <CAMRc=MfJymJ6Xnk9xpmq5kVJpTzAAZJsv0M70ZVzvhSBXRYZ_A@mail.gmail.com>
X-Gm-Features: AQt7F2p2WXxmBiIoGG0KfkfQNJ5OzsMQQMUzQT_gRTr5iJINL0CYeKnMvtABkdM
Message-ID: <CAMRc=MfJymJ6Xnk9xpmq5kVJpTzAAZJsv0M70ZVzvhSBXRYZ_A@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] Bluetooth: btqca: move WCN7850 workaround to the caller
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 05:35:02 +0100, Shuai Zhang
<shuai.zhang@oss.qualcomm.com> said:
> WCN7850 will first attempt to use ELF_TYPE_PATCH,
> and if that fails, it will fall back to TLV_TYPE_PATCH.
>
> To code uniformity, move WCN7850 workaround to the caller.
>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
