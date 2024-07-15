Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6B18E75D
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051769; cv=none; b=ja8WK45lF9robUGoUa8Bne2Ys/2+UE7nYP87sZUht2Tbito8YC0+mhQDI4sLpFnDwD8xzQwgVWSVBrzb11oYwBzRLllEpa49fTzSomdGhRF2jdVTj7lu1ZnPOkZlMah0i81HPVLOwB3fNNuvDZ5lOoEOAvw9IzZFtegrjgIHZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051769; c=relaxed/simple;
	bh=bFfVPAx2FlUnlozD4rqd8fm1zpOfw6gmIK7m8y/1tHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxA31UEQcX6vxZelG5/+H/Qt/B4YkBGE9vWZk/u0Tc4JmDt5EbSRqFgxfjMvybjUeeh69LOJitPkP+1OORtxxwvP86+rBd0v2RD0fZYR6InsybwpZ/1iOAjufp9RObEL6kA8HpzkTe5gN+4ibmUCP2b0Ole4fPhfLPi0k6H1G1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VckmF9LA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VckmF9LA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66108213e88so11450037b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721051767; x=1721656567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RA1IZPWVo6ohqXGHAjDNLvDb7ueOxWGeXQQfV/F8Kg=;
        b=VckmF9LANyatWSYc263xsUb1dE8YaZd0+OHrKdBVypEhlZyTt/28QtQu0NN8SiLsko
         aDFkuPul2M801zOgD/kJL6eY+lL89146fdgpoV47AnllbmmINMmaam/HYwqSK3U/lF4g
         xSvi6amEI68xqa2ZGuN0MOks2VG10yCm/EDvhXLstuiiAz/CKhtD7w3aIYjrDAes68Hu
         kf8tkPe3WKhEA/HYy6mXjI0HrlhKdkK3XE+XEW7eg4Y8ispGFVhYhlxmXevafBuvYepa
         WLb47ZGkuyAkN3PSe5Mh13+agJX0MTee5HR5kxjZrMJ3pcCm7QV/whRPq6oZJZzZdiYR
         RjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051767; x=1721656567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RA1IZPWVo6ohqXGHAjDNLvDb7ueOxWGeXQQfV/F8Kg=;
        b=VE0XhbYK+/7thsJQKor0mFnmacveKlpufVIPedfbIzUORT0YA9RJFeYAtgbY8gCmyK
         0ooSxudz4W7TKG0p3+Q539bmpkGnP0bnKB8L6Q7Y6XziEC/439uXWZXecydgf9gzjByB
         P1+HIXGH7bVQ8pFkyxJXSzCMjYg4YBlIzAz8jq974hdnlZdihza2D3oJhpoNEIya0+27
         BbizASK3QBEJLw6Vs7qsSqMyf5aYeXtRpPrf33NUQKuTG79P65HEBMQf9LCYAm+g7TNT
         NdtFpc4b7glVeflDYUl5lboUBNLvz50LNwHJ3cGcG9JHmcB3M9w1ys6RERIojRuklpuq
         ej4w==
X-Forwarded-Encrypted: i=1; AJvYcCUr/HQjYZbSNyIgYzESSlBFmmvKikyagXx7lWI0duLr0UzmARN/SddhHrx3Os0w6q/iIMw5kJqAx7KlbBCq1N40BobLdqsgwDAF4SsZzhCb
X-Gm-Message-State: AOJu0YzYK4vnbuBKJ3O8wPfMx7uMdSx09YRdKSI//HVPlW5v/wj3Pgs3
	LcSViRHuNTcPdYz0W4B2oMloHBj5C2/IrdeuzhGDGacAaZOYVoRvQlRYPR9UTCD0wxDMe4S8ATL
	e1Y+ax3HVoIZcsSMwU/UdfTlL2NPyB4gNr62cYw==
X-Google-Smtp-Source: AGHT+IH8Fq8sJFyAFjhvFfVJKLzJiAL0sfiMFBS9QPy9MR14k7PHxaNSoHG8a5OwITL00/vzZC9olfgQjDEoFeOZGqc=
X-Received: by 2002:a0d:f6c3:0:b0:650:a5cf:ef5b with SMTP id
 00721157ae682-658f0ebd21emr207164357b3.43.1721051767156; Mon, 15 Jul 2024
 06:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
In-Reply-To: <20240715064939.644536f3@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 15:55:56 +0200
Message-ID: <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> >  - qca: use the power sequencer for QCA6390
>
> Something suspicious here, I thought Bartosz sent a PR but the commits
> appear with Luiz as committer (and lack Luiz's SoB):
>
> Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets") committer Signed-off-by missing
>         author email:    bartosz.golaszewski@linaro.org
>         committer email: luiz.von.dentz@intel.com
>         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core")
>         committer Signed-off-by missing
>         author email:    bartosz.golaszewski@linaro.org
>         committer email: luiz.von.dentz@intel.com
>         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Is this expected? Any conflicts due to this we need to tell Linus about?

Luiz pulled the immutable branch I provided (on which my PR to Linus
is based) but I no longer see the Merge commit in the bluetooth-next
tree[1]. Most likely a bad rebase.

Luiz: please make sure to let Linus (or whomever your upstream is)
know about this. I'm afraid there's not much we can do now, the
commits will appear twice in mainline. :(

Bart

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/log/
