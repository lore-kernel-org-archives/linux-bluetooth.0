Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA4146A91
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416001; cv=none; b=ehUw19jvOG2dBhfdoc0GfS43WVaDODO7trejAs5pC8SldBg++UyTKnjPYmXTdgEjFjkoaB9R4c85WChPrnO0i4nvnicKLT+mW/DMLwtxkUh/YIyIJ2Bsdqy8xR4ulT3q/EI6n4yTn4OJOnhvn4rKSlkHLvUZPow5INOis9qSKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416001; c=relaxed/simple;
	bh=YOJPhPBNVLdaAo1qYLiUsZbTsEXU/hUCe/QbH6GPyik=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsBylNW1OPyZmxYE/mqYC+06iEugombtL7LvIj26ksz2xsVAArYJ+S1EamMwYzJqJlzLDMuegMvoESSBbvw9SCfvP2doTU6+bpYorT8cX3yOucCWDZrt7ANhG39YKz7CxBnk3gO62tlZw5pPTKcvo5XAy5Bx9ytD2lLT0CUDKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L5GcUjJr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L5GcUjJr"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792bd1f5b38so438684585a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 15:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716415998; x=1717020798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0yw445eZNI0Ov1C5uvraWYm6H31vdS3UWaoIxWyhXI=;
        b=L5GcUjJrFeUdcxV4ha764df4rDhFOP/Zyn5OCkKUO/K9ZFWN+7MjaRv94T6wEphgaP
         /EeTtP5oeha0pfLS0niZ/sRO6SMgTwqrcATJhd9JyBq9rZmTJN5KbmE+RZFqIJKdD2zB
         JX29Yryf828EdBbgp14K2zR6ln1cRK0PKP6KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716415998; x=1717020798;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0yw445eZNI0Ov1C5uvraWYm6H31vdS3UWaoIxWyhXI=;
        b=gshaBVTheoSut0QfcfMPzzjMBoNTpMunWWOex6pLBDWiYYZPyDIcOWillXbH5VS/iC
         P4dkjWEQc2d+FMQtKQ8gkDMCsT/LK7vVYwygp/L8emv5s1FBZpMREy5iFSF5zHQT3p8V
         QZ63QjZWOgRG/ZLV4H+XBg0NOeDS8vuIJP5a5xEx5Oje1mIKKvAam77HMgovWxPi3nfP
         zyOlKFkiWWCniYSWhtFc6zMIhBN64EoY1Zy0o6WugFsa+s0DCca+YbgcjCN+E4q+XHfS
         dD9wOHOZG2Rvd92qkkR0VaoWI7qMF9n+4ijee7rlEdO5R0kBhxadPo+2g+2CUiq/jd97
         xfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5E6t5eG1XqG1VzqDimFDoF9Bt1QyxxdCYBZ+O5yRRsGvXYxY0yqVaQoB8IXRxD1xeKNEH/IYiHpzC5GRfBMDqWMxX8X5DeXgnbcNyCWmY
X-Gm-Message-State: AOJu0Yw6Heu/j63+fDMiR1FAO+7T6UlSIZEvRmMbPTMK04iRT+TpZWil
	Sm0QtOVo9Ac5zkAKjUH982oguG1TzivtxISSxiVlWAHdeAETfxhXJ6e30rUOCo5/ZmoXBImnM4D
	8zsjOe/3nIxInFPr1yCU1kWVHH1VXfhHqdvCJ
X-Google-Smtp-Source: AGHT+IGmjkCQXz+RTwsJXVyVlj1mN5OAUd57w+Ue3ubYg935P8+YuFTsLQDxZ8hiJZB/4tzj2HzSG+4eVqOwa3dZ3wg=
X-Received: by 2002:a05:620a:5648:b0:792:d51f:2d38 with SMTP id
 af79cd13be357-794994d058cmr317259785a.77.1716415998216; Wed, 22 May 2024
 15:13:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 May 2024 18:13:17 -0400
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 22 May 2024 18:13:17 -0400
Message-ID: <CAE-0n50=p-XvueHV9m9c_1H-XwsJgEMTNNi1OFi=aUzNC-s65g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Douglas Anderson <dianders@chromium.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: Guenter Roeck <groeck@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Douglas Anderson (2024-05-17 17:02:46)
> On systems in the field, we are seeing this sometimes in the kernel logs:
>   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
>
> This means that _something_ decided that it wanted to get a memdump
> but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
>
> The cleanup code in qca_controller_memdump() when we get back an error
> from hci_devcd_init() undoes most things but forgets to clear
> QCA_IBS_DISABLED. One side effect of this is that, during the next
> suspend, qca_suspend() will always get a timeout.
>
> Let's fix it so that we clear the bit.
>
> Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
