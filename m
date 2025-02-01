Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A314A0A4
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738414069; cv=none; b=hw/G6sNwmEQH8EjJxV4Wg1Xm1R3Ygynj9WmasZV2rPJlOL9+F2wxg7akFlaZnqDebNcAKPRvfaAe8y94XJJX69c0BF58vAysTWOXlEOM3eJ9icFh/Ttt/0nszROYXViWnUC3CBb6U/ktalWxpZpgxS8fT85+yf3pEdZbZFch/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738414069; c=relaxed/simple;
	bh=4RZ7OWUNYW5slaMOvnaTZEv0LT0QnKX108Pvk3JR9fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfrJ0lxVWH1QjDVtDwVX209RhyuZ11sLWBI9e+xoTpTBuXQtMtLf0SmeKQwt20rm7uqJO0bLQXoQXId56gUvK++PvXo7CUE0BsJf/oPCs5ifDltz5BssJhl/i5USDmea5B9YgcVwAKn5skPO7A8IEyds6RHm6CG4oQsBe383/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dR9aU7Ab; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dR9aU7Ab"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-543cc81ddebso3304806e87.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 04:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738414065; x=1739018865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7U/QY0AwysjlkyJl/K85+VbcTx0/u5THnr6ChZjWiM=;
        b=dR9aU7AbxafwVrprWCUJ8NE/NHf8HV50uNkOdlz+V4sapnL5kQFmO6pEk87IXsE13s
         yc82VvDgDH8wYrR7yqJxt4R0TiLadmO6TOOGspSFN/qA343nXTnLh4qVjuapTD7v8Vzl
         vk4X7llsCDKpsYLsQQXZn68c5eqTrcUD69pa9Ul+7n0Wq7yC+oOF2wS9QV4mkIIfTp8v
         Soe2t8Fufd62LqavaXWA+cG0jROTGxzaKv7i7kXYV82mDQ3Yl/tuwvnfWDtmiUdUb7aO
         nu7qoWqW19JJPaJzeC6ycfLvqWW2tLO38F2sQS5j93z63vBtHQPPuvDvoMzjiII/Lpl0
         qPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738414065; x=1739018865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7U/QY0AwysjlkyJl/K85+VbcTx0/u5THnr6ChZjWiM=;
        b=mpSaQCgVQEv4afDvYOBlsowWrofKw/i1cZttoBkGNuouqPeU0Z79Y/Mul5iTWFGhjU
         fhC4a3NfunpJcXvV/mNu4XhJuV4BiPZXJv01cFSbLfkAddZnHh7t8j7gILSSSb2c2is+
         bl56FiULKaQsM0PRijl0AGvZ+kLQaTkGbn4ywn0HbWQdbqqFTTWDChj+VDSXwZBFWZ/b
         sLY/AKihuLQuTlPlA4pc0tQRMXDWhz8EUTLpv1iADy8EgjIdcAhfYclwg682rzua6bCg
         MaXiupEwqwvujGST8PMKnpERHfkg+aA5sA+HlxGOPxYQQojI5COV/ymu9dTrmuI4b6ej
         mVEw==
X-Forwarded-Encrypted: i=1; AJvYcCURq5qz1pLQVwyR6rQAhl0vtXM0jLYJQj04OxVv+0rBACUsGCYVVbXB8Yh2OovlJA6Q2lawQWvhpNYhyvPOReA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXWw0QPtuC2fiHc/R7hGH7MHHp9szhWFbhnchhzXRL40wuZyHs
	KimD2KTGHleLMeU777CVFPIMz9BZZJEY9bwwVV3oGsyVfc7nwyuBt+cx1aGZRTE=
X-Gm-Gg: ASbGnct99CB0daiRiOYl9fgMi0xmaev2Csu8eCKC0H8N1i4SBlJrSdYe85EKLKge5al
	HbYJaiiB7EvB95ORuXKYiLC2k9LoCcY/tvp80XDWQaHZ/70qkIaMLrMNRXPSnFJT/hI/HSth6dC
	r41fTNG7TP1IqhdxvFQ3bXx5iKmZ6R6PayHwRFod41vSH2AkAWNydPDOt7ZHlPrtgk//iQP2GFQ
	aqFDc97JJVxAO5IO6PM6XwjN4Yw/9VTU3bqnJIN3th+h8ykFI6jW1EEnPHsvb+SLQN1XT+MJemO
	QMRar+9NjJehEgk1bsc421v/y4bLM3ZarI1ORtu6iL8y85Yx6MoyfCYdvjcIVpXaNdhhNoo=
X-Google-Smtp-Source: AGHT+IEy2qDiVDwdoHC9BRZ37NSRP2KIMWzIo3wkTY5DJjgfWOTjn3aNna7i19+0q/ldZYCNWbFmWw==
X-Received: by 2002:a05:6512:234c:b0:542:29ec:d5be with SMTP id 2adb3069b0e04-543e4be0016mr4629444e87.10.1738414065247;
        Sat, 01 Feb 2025 04:47:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb06desm741428e87.145.2025.02.01.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 04:47:43 -0800 (PST)
Date: Sat, 1 Feb 2025 14:47:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: qca: add WCN3950 support
Message-ID: <whxrzliiyqsceodr452u7xf7zlo326vygiknpiydq67vp2le7f@kggswwh4hbef>
References: <20250201-rb1-bt-v1-0-ae896c4923d8@linaro.org>
 <20250201-rb1-bt-v1-2-ae896c4923d8@linaro.org>
 <13d5026c-3274-4b90-b941-22f08a8ebdc4@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13d5026c-3274-4b90-b941-22f08a8ebdc4@molgen.mpg.de>

On Sat, Feb 01, 2025 at 01:15:29PM +0100, Paul Menzel wrote:
> Dear Dmitry,
> 
> 
> Thank you for the patch.
> 
> Am 01.02.25 um 10:18 schrieb Dmitry Baryshkov:
> > WCN3950 is another example of the WCN39xx BT/WiFI family of chips. It
> > requires different firmware files and has different current
> > requirements, so add it as a separate SoC type.
> 
> Is the firmware publicly available already? (In patch 4/4 you write, it is,
> and I found it [1].) I find such information helpful in commit messages, and
> also the firmware names:
> 
> •   qca/cmbtfw12.tlv
> •   qca/cmbtfw13.tlv
> •   qca/cmnv12.bin
> •   qca/cmnv13.bin

Ack, I will add it.

> Do you also have a datasheet name to review the vregs?

I have it, but I don't think it is public.

> 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/bluetooth/btqca.c   |  9 +++++++++
> >   drivers/bluetooth/btqca.h   |  1 +
> >   drivers/bluetooth/hci_qca.c | 25 +++++++++++++++++++++++++
> >   3 files changed, 35 insertions(+)
> 
> […]
> 
> The rest looks good.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=421017641e6a6ef389190ac3edf67885183f3de0

-- 
With best wishes
Dmitry
