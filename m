Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9232ED45
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704966; cv=none; b=aotguOOjHSPzA63sy0dIwsvQLO4NAHpt2US2Boh/I0gE5vAvqNPZ2YvKCkntnzFjbDazPtuap0Iq0SDMpMWPb2eqWC3elWHRRQhTkujnUThNvdUW/X5ISiLjDPQMxcLZoVH0b5qfDsUkD3FFneF3Xd2tDCstfl2va26jtVH8S3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704966; c=relaxed/simple;
	bh=fISq639A9LEzQDlEn/5UvYkEqYIZeG97xiheL6xSBXU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLakbnK0ChbDp6Xzyco3fUIVaWylZXi6xMq5rbnIJlX8e6jyJk1aBTzJ+aIIkjcHukjib4DnnWPlE6EWhWXXLsHY4wVbUiueuHVrXJ6p71s99pBZj9oTip5c5Ws2zXGWRzGF0Rvr1Fo9yMZg48eWWgJtaLBCvWCDMqctTyPaeuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJdyUGTG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJdyUGTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534F2C116C6
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767704966;
	bh=fISq639A9LEzQDlEn/5UvYkEqYIZeG97xiheL6xSBXU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=hJdyUGTGi4JrRurrhrZzjHrEuK34deM84azP9bkypK4HlcIWL4R+X5BDH805n3sOt
	 J5UOrOcX1ckQFntovzKMkT1SArO9SFxeMeBuCfRB8LV7Tu5/jQUeLZP70S5NnmOi2L
	 DaDqNxSog4VQbQ0GYR2VhYnj8gZDGizLOMmkqvx7S07E/hBO26KxSauJFiGy6qSNzA
	 1a8Tk8NAjAfX1H3pkFtP03J/ToofvHgy5gyYJ/LEtc1seGABnUrL/hroJboaAzgSrq
	 KXP1D8waC36vGos9dYw5VIpW6/U8Yu2NvMUIFSa+NdQCFMnNa8hzP0gtckQ4j/A7Yp
	 ia+KAP2DJWavA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so556217e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 05:09:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8EnFsN3OCha7q4P+EVax93HFqhE22Nl0Hhz4vXPZtkumAIRFUnSGwgoPc6tKLWUu4MZRa4WA0440ukdRHQWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4ViMBvJfF7Y5mwKQ11UOVj9MgrPc2131eF0FwvPWAqqTcDrg
	I314yu1FhMBoctOeji+0CT7UWEqr6YgTwgqWZY7oO+wpxkMdsz5boSTQVoR3DaC8uocdUa7SPpz
	luiEogTzDttw1AKJow7FGsQNRtCBwWhSjQEpR/p61Lw==
X-Google-Smtp-Source: AGHT+IHRukwdqKvEDykEIcv4i2AMDuw4pNrSE+/ODj5JY69Wt/H3UuDG2Ps3I5fST4AD9rEd1A/zXorE+YIQSAYcApY=
X-Received: by 2002:a05:6512:2350:b0:598:ee62:32de with SMTP id
 2adb3069b0e04-59b65257e39mr1144393e87.24.1767704964026; Tue, 06 Jan 2026
 05:09:24 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 07:09:23 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 07:09:23 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260106031223.499706-2-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106031223.499706-1-shuai.zhang@oss.qualcomm.com> <20260106031223.499706-2-shuai.zhang@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 07:09:23 -0600
X-Gmail-Original-Message-ID: <CAMRc=MeLKk2wozObDrmqJ8WV2Y1bBuBOA+eCuLA+5c3aJn2r9Q@mail.gmail.com>
X-Gm-Features: AQt7F2qSe8qqxCbMknJMuoZMsqatRYfXrhM5sFgyxi0gh86SrK8kF_GBimoJMns
Message-ID: <CAMRc=MeLKk2wozObDrmqJ8WV2Y1bBuBOA+eCuLA+5c3aJn2r9Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] Bluetooth: btqca: move WCN7850 workaround to the caller
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 04:12:22 +0100, Shuai Zhang
<shuai.zhang@oss.qualcomm.com> said:
> WCN7850 will first attempt to use ELF_TYPE_PATCH,
> and if that fails, it will fall back to TLV_TYPE_PATCH.
>
> To code uniformity, move WCN7850 workaround to the caller.
>
>

Stray newline but this will be fixed by b4.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
