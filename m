Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450327E060
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251364; cv=none; b=Lpq7gK0O6Pe1gcSMR0YFUxEjZp4i69dp0ZTi0i0PWyBO8XIiIc94hLHMI5lh+hbnEWqhMpM6qZc5orQefMLgwMGH7jjpiblmrfSWG6S/IVVpRvSBg7LCnKjjvJLa/puV4ovxwhKiwI3o6ZVXYk2xVzdA/LXKojt1/YOOApilZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251364; c=relaxed/simple;
	bh=djx46A/t4g9tFTNKTkwprP+1rBHg+hljQCYzR5C8ROA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrVUNaTNHGv8CJDu8nLNp6PH7AH6EQmnIUHZ6q2v0aplE6NlWD4vwrTOpO1mqOBLOgfzKI1DHqOOEPQdviPyDGJtWYPRI3ZWG5lo5bIlSWtS/Btg6w9TjDTa6yYxrO76G02bXb7nnnTsxLSmBjWLTxMRxDewjj2y/Llu9SM+7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uLj1JFNa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uLj1JFNa"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-594285c6509so1073305e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 05:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764251360; x=1764856160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=djx46A/t4g9tFTNKTkwprP+1rBHg+hljQCYzR5C8ROA=;
        b=uLj1JFNaKbDfbxo09KGuxHCMyfKejpCJ1WTapAbhCouqWGf7nWZMdnozs59WqDSOOe
         pKh+xItKdnpSkz+ie4zbDtWnGqjhIUj5iJcN4GZc3r9OWWFjUDbtmIDFnDxS7kQs52N5
         o7zRwL9XMpj0ovWUukkXhdxO+Oom/eQ0xP1Bqhns1G3+RLZvbuTMbuE9wi0OoxAuFS/a
         PPG6CyfX81DIu4rzuUmZ0n2d7PklxBj89vNtazQQpqPzyAkP9MVXbw8pmaXbiQRlQAok
         Je2FL5kvoXJ0r70ZgvakShfVpiV4HBUa4RGJc9S0isAgm4GJ9jVZ2ODpt7XqWEIKhhNw
         jhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251360; x=1764856160;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djx46A/t4g9tFTNKTkwprP+1rBHg+hljQCYzR5C8ROA=;
        b=ZMryPbhjnelhFeSdJ7CoL35RBZXLdAaq1VN73NGSUASSNNeoOGx6VjsvVxuC+G43yn
         wGiweCiyIJeMn9erSQ7lB4qZAHXfcs13UKqpjMG6ATl8ZcJj6Z6nZf5tSCEp2NzumE+k
         v/NLB4IkfCIBJ+TovEw/rfGY0KG9HE5FmI4RwepeIiC/8BlGr+a0VE+b7Xo1RxSPVGtp
         bg0Z9uS76aZvmaUUI+xHEVF8p9USSXMbhtjC/T55MhW4m8e85w5hdvrmh2fMumFSUljy
         G6gH+I72FSJI95GmrZBkXjdXLsEDusFL67sBSH77kYB7XAy6JRFiKMdWg2oFJi5jZh/J
         gfrg==
X-Forwarded-Encrypted: i=1; AJvYcCUkD+Pzunw6+C9fo40eLnCrdeTzk/Dg1zWEg3Dr5jpGpX4+OBLIqu1L5C5eDsedv3j78twZvHNJjZlfHA7vFag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGiVBDnbUzq2EgBQOgOKJlHmyrirLZsUUTGCrdjubAalv3BIjM
	T8mmWoRWyERnuNPUH4h27sM8NqrhfBWN5Rk6D+MUqf+FcpIbt1YaOsgUSHiX/NbMFpbuZQcID5Y
	ivwV+ukGiN6I/PTPPq1lwQdZ1GpErr9AafMiLcZ9fAg==
X-Gm-Gg: ASbGncsA30dhv5jer3o6wjJaUot4shiL6EY36c2VYTJ5TGHzf56QQR624WUn9K6pAvz
	k58bK8aV09ygf3heRo77yFu6AkrniNJYfyPQz7FoNFk2ScFrR/JcJspXwyjmOGeJgBtaGSHU2fO
	34OxeFkuSQImoW9tJanWmLqxMrSxy7z/z620HdjyRse8mxNIdcDdcfjgJVvg5E6E6WF5vWDhZYr
	5ptprWjzhrIlpavfPUPrj1Hup27xatswTBOKs9zB3Yr2ljL9hcMJkU8fbUA/FyZii3nwMMd7G81
	/dIaFvZ6u51BlaoOVx/6xLBDrJM=
X-Google-Smtp-Source: AGHT+IH+CDUfKujPpotwtmLcmyLVWHWVuqtFgSXM/kqLIDQE6VNVNZAmDKJw5gKN9s8jiNvQgCQtNi8buZoDHFa0ulg=
X-Received: by 2002:a05:6512:800c:20b0:596:a540:c95f with SMTP id
 2adb3069b0e04-596a540cb59mr5729287e87.19.1764251360301; Thu, 27 Nov 2025
 05:49:20 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 05:49:19 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 05:49:19 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251125-pci-m2-e-v2-9-32826de07cc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com> <20251125-pci-m2-e-v2-9-32826de07cc5@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 05:49:19 -0800
X-Gm-Features: AWmQ_bmLrPADj6DoaQnC1ZJGmDNpk5NRcjPDulR-pWqLbapX0f-JV3TGd0Beet4
Message-ID: <CAMRc=McQO4OKra4S+goHsrq75HJbO1U=pfOg_8RrGFxNwy_-pw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] Bluetooth: hci_qca: Add support for WCN7850 PCIe
 M.2 card
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 15:45:13 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> The WCN7850 PCIe M.2 card connected to the UART controller exposes the
> 'WCN7850' serdev device and is controlled using the pwrseq framework.
>
> Hence, add support for it in the driver. It reuses the existing
> 'qca_soc_data_wcn7850' driver data.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
