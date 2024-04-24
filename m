Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CA15B996
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967229; cv=none; b=j/i9an7Tor1Q1IOKnOsqPPCDtlt1npqTLbzFEzWgTvqHK9R9Z9uemKVFGatPz0BVh31PcgSjAV5VNarhYMTvHtwXm4RRzNxtNf7lz8Xwa061M633EEt+v27bmoNSvTLsImyWzrNGGFOzjhPU2EvYE8FDHDrzLZ8/6V4sBTr1LHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967229; c=relaxed/simple;
	bh=MYOzFxs2llR0nkq7YUtvBmPawWdZDm6cWulC35wwveY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGtFQRKyNMpTh5k6wylH1obEnrgsaX3M+5IfZpfsDo1cNJh2iwImeAdG+ZH3RmIquCB5XSk+wURGt8oVtF9KQ83PIMrJy41BP9wO3G6GvHNJWKNhpVTUGj8p5ZS/ZycN+V1BgTpNE1jImmXA75mm/tLNHKRG82iiplgo7r796ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uTJbxFyA; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTJbxFyA"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc71031680so6462775276.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967227; x=1714572027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYOzFxs2llR0nkq7YUtvBmPawWdZDm6cWulC35wwveY=;
        b=uTJbxFyASL9EI5GN0P+D6FXboha2BhSUL+k5yGtY0FnrC4q9iN5ZqnW0M/x5h6DrUH
         OC6jY0BgGEacySk+s3BWmgIX6rqHxfxHzhkFZr1spGi051VGZPxQOJ5OaaY5b5IVRdCG
         nUSbOTPHKrRpd7ZfzcXHEr4aH46G1qFGo/pnzSKIjY3lAovWdj7NP1AUpLWN4So8B4Sm
         j+fhxmi4mLFqBhh35q6NSg6AOiHkdLFzqZb7sKDRQY9nFGcg89hva9gykRMRZB2gyWFq
         oBTE4nbFsUMUIg6vetyCP2Ns7ejj0vUhnohEpA8+9Vzh22nmxiKhAOBotGx2sLLaAGTZ
         YvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967227; x=1714572027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYOzFxs2llR0nkq7YUtvBmPawWdZDm6cWulC35wwveY=;
        b=klJPulYLqcab5leK33IzEdI/4Se+TCoJeIk/3Lp2ulBW0ndGC6drd+yX+vt2jDdexU
         bT7sD3LYewUfgkbp+Vh0l3Z+DixwerqbxI7hh1La/fHLrQz9NFzB3rksg+4/S0n4z+nI
         VE9C+4iI1awk8hq0fyJQqHaWnOwmjZynDP0u71Gle/LSI/iTu8X6XdSOteFQ/Cp5P1xJ
         EB9HniI+aepAx3sTJpLQwwbhtZasRgwauIw1MMh/aAIDkGa940eWS5LGlsWn+rWaD111
         ZmMLihjXy5VgMRDMv5y/RC8+/2LkETlJfNA3SCi0nknxSQq9AB+xKiC9lA1/d7wcldmI
         BrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVN6u+PGA3pg+tDGVvH+8BktHRa+GM869dmE9YxuBrFh+JPMIiW1lidiGSrQasDv1QX2ebNPTktH05XIw1UUGu8B6Co7veVLTyXsuvdfz5
X-Gm-Message-State: AOJu0YyEEtjd0RMWTyW2/x+LCjblQthHMUNuqQXfXNu18jjjk7u2JOvi
	7c+6kEPxDhT60kqS1oLXo20fTWVmdbCQyWW5PUs1eTBORW4lR8TMLF/pXFmPoGHoowmcvtPfgKr
	EaiF5jkkk/yd+0BXWUoxPS1H0YLJzJbMdccxKXQ==
X-Google-Smtp-Source: AGHT+IHHYW0Tjimt0cnDpvMY/Me5aqWrTzcqLAji1jCHzJp5hhTGSX/HmO3cAaYrda7VrgDUxufgXWypZpjwA1W/ij8=
X-Received: by 2002:a25:c551:0:b0:dc7:4b0a:589 with SMTP id
 v78-20020a25c551000000b00dc74b0a0589mr3118312ybe.55.1713967226951; Wed, 24
 Apr 2024 07:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org> <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org> <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org> <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
 <CABBYNZJLCPaLTaFEfeTEn+2FpxLS8Z-W2kT1ry4jKB_W=XYNjA@mail.gmail.com>
 <CACMJSeuWQE4t2KDCRP7n-DeHN9Ndn1bE_KCRc-X2kmM9L2i7_Q@mail.gmail.com> <38736db8-eec4-4ebd-b4c4-4b404cea6e42@quicinc.com>
In-Reply-To: <38736db8-eec4-4ebd-b4c4-4b404cea6e42@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 16:00:16 +0200
Message-ID: <CACMJSev8=gBCw9o-ur87fMMj9K=ZWY-ECzxZjyvERYQ8P=VS7A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Wren Turkal <wt@penguintechs.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	regressions@lists.linux.dev, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 15:53, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>
> >>>
> >>> Please slow down here. Zijun's patch works and Bartosz's patch does not.
> >>> I don't think Zijun means any ill intent. I am replying to Bartosz's
> >>> patch right now.
> >>
> >> Ok, that is great feedback, so I might be picking up the Zijun v7 set
> >> if we don't find any major problems with it.
> >>
> >
> > Luiz,
> >
> > Please consider my alternative[1] also tested by Wren. Zijun's usage
> > of GPIO API is wrong.
> >
> why is it wrong ?
>

I have already told you that at least three times. But whatever, let
me repeat again: gpiod_get_optional() returns NULL if the given GPIO
is not assigned to the device in question OR a pointer to a valid GPIO
descriptor. Anything else returned by it is an error and the driver
must abort probe().

Bart
