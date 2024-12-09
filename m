Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E9130AC8
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741751; cv=none; b=ojuYJDOJNzqZg7GquniCUCw3q/ZQoNsYJJzpsrsfOmDv9kiEAVtxh5YNgs0O0Z2HKn+M7OCYmBd9HS83/DQvP8z6ryMgbTAeLp4oQxTLwZVBPCIlpK0jwbfoIdOw7q4NSybv5bVqhFgswZHEGIxWp2HifHQ0HefVkhqn2t0N2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741751; c=relaxed/simple;
	bh=Xe7YOVzi9kvbx8uEipw3Wuf1ZhGmA1yZ/T7HslD20u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYVNomdTmLvHL/aRDs7tnJaozq6xrpJFPXDwmvFjtGdlo9MCtAeVuWPb+3+4Dx0ZPqwzdnrn/5exJ/fpXycsPJPiZk/KFvCft9Ly2bODZT0LKrQiSGqZ1ABqeouHbBtpoeXSn85Fu/nLKbfCi2UMEQqcA9O0kFkRFhIN9te96Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EUiW4KxQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUiW4KxQ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53f22fd6887so1574639e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 02:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741748; x=1734346548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DL2ZHmUNmFO5TpvkHQf7MxbmOutPZRuUQkKbzuBLT88=;
        b=EUiW4KxQNQrPyubf61Z0n4mL4M6NEYMldaMK+gdod4T1vlR1zZgb0FcOW/g+RJ+JhW
         Jgbha31AgueITPJ8p7JdwQBn58rTZFTRVbIpRPCWVAl0LEcIUnitAQc/krhdoSHZvW1W
         +e2LQ7PSX1XWXoG0i7oslUfDjRfbqAcunXRCCdTD++M5qBZJN/YWtMY5oA0EY3qxfDP5
         WIHNTEnXdzRoB2a3Ga3rdsKeE80pxgT/1JiLvYEa2lwHDcB3jv+vUkvR5h1mhaYq493Z
         rOEfKsCMCl48pAWwGtOV2aUosA6LI2MV3qqrxCkbqrmVP9gblkGgTLsPCcuK0KcbkqLX
         KHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741748; x=1734346548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL2ZHmUNmFO5TpvkHQf7MxbmOutPZRuUQkKbzuBLT88=;
        b=Al9xzImF0d/CD3dZizMduErIAeU1EPVdqKUbgo5JHbOUC5B5NYD6mBzz9HioEPZmcX
         Qr7vcYJPEog/n3DZNNSA7txviZ2ZpskSyoOhQoUhnOEQ9ijalu5dhSJPMBS3/s3VfxV3
         yJ3zsbv+0S4TeLEGtmyujM1srrjWzTK3HDdWmoBUU0uKl7HvDwf+7pw5AP+Fjhp4MIIF
         tMWBQcfSa+BjytU6RKjGVCo8z+K1WDV1d6OoYGbffapDYlxiMUWXamKq448/w6Gl+F80
         vh7qhCvnrXr6WGoZZJhpM5vEBLJOm1/8y0lY5nLnGossQ8pkarbi7cr8K4/Hh2lHQR9s
         0Iiw==
X-Gm-Message-State: AOJu0YzMnQUbgouszlAW7GpvgPSp3/7jeUXBMrBR/QPd74IpuDfOsnas
	BUCU+ni9c08nGyHJARvLMmcJgSTKWH4Ku/Z1LMiPsuF4erTJTIErZm+prwosBjBBdlnJ80uhrMb
	usq3dnw==
X-Gm-Gg: ASbGnctZAZ9NvPfdYcLydSfA791WPXI4xYVwpN42YgFO7Tj4/wDKnANbdew48YYLhaM
	2rStZsFQDsMWCwFe0Vuki1LLczrWGoUF12VebBksM4Zck8lYcJ/UiBg7yXtlwtqESI2EU2qw4fJ
	WXqSUzcEmllTF4IQQvNOkx12Fs2HSmPAWddYqrfXgrXX0aDSjFsupCScpIYAmj+u+CW35sYuJtR
	j6ck3OR6/Iisv7qq3qisVUPgeKbwY+ObtNLZpgG8Anjt2jovno8CzUuqUAQhKTfSaDojWorXqUP
	fW6ZMDaLw7wyc5Mco5CY0UtBFrpCjw==
X-Google-Smtp-Source: AGHT+IGimnY8RTXZsEZcmitkeMUiEJxqI3PGMl2jYmGgbel4Q8konxq5+hj5BPMKaTAtLGUv0F0Scg==
X-Received: by 2002:a05:6512:52a:b0:53e:368c:ac4f with SMTP id 2adb3069b0e04-53e368cacb3mr3825723e87.9.1733741747966;
        Mon, 09 Dec 2024 02:55:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e301cffd8sm979549e87.204.2024.12.09.02.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:55:46 -0800 (PST)
Date: Mon, 9 Dec 2024 12:55:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: quic_janathot@quicinc.com
Subject: Re: Enable Bluetooth on qcs6490-rb3gen2 board
Message-ID: <vfe3mez2chdg4gwy24avt23zwkboczb22kwnaydbhanmcog6tu@ze36gczcrxlx>
References: <20241209103455.9675-2-quic_janathot@quicinc.com>
 <6756caae.c80a0220.267135.41e9@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6756caae.c80a0220.267135.41e9@mx.google.com>

On Mon, Dec 09, 2024 at 02:47:10AM -0800, bluez.test.bot@gmail.com wrote:
> This is an automated email and please do not reply to this email.
> 
> Dear Submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

Dear BT maintainers. What is the current base for the CI tests? Should
it be updated to v6.13-rc1?

> 
> ----- Output -----
> 
> error: patch failed: drivers/power/sequencing/pwrseq-qcom-wcn.c:272
> error: drivers/power/sequencing/pwrseq-qcom-wcn.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
> 
> Please resolve the issue and submit the patches again.
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 


-- 
With best wishes
Dmitry
