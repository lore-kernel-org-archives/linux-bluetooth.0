Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A18409100
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597643; cv=none; b=CR1FMFIiwT5OczX3j84+4dAHsabKFQ238s0Q9JqNdvDc2BbK17hz/UXyCFra4qXuDRlLMu2y7TJx0/JUyK6Z30SYGJvKaKcUSMGbtafhZR74LWG+KQ+YDP5i3Yae5Rs9fFQGAgQUmjfIRahLFsG36LOxU8MUWHvcvuNr34eQRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597643; c=relaxed/simple;
	bh=/COlRRXaoH9NNlgjVg/+LPmx9BQ4x4p4lGUaPrCNATs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ahFAsWUjYDhiTzP5OmP/uUmy2hLXWJyk/GZnIa/ylqooEyvIXzptf6Z7ScX9em9/bH6X3hK94Rk4uBr6Pacp2demYI30RpBv/pU4GgzE9ml9lOShBpTwTfAri23YAI4dYwdD6mzOAZoxhfAP9VGZi2smJgqpTzyAMAyowCvUhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwLeHQND; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwLeHQND"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84847f60deeso737215b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783597641; x=1784202441; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/COlRRXaoH9NNlgjVg/+LPmx9BQ4x4p4lGUaPrCNATs=;
        b=mwLeHQNDHUZHjZAJCPi7artPjbpa6y7AQn9X9xpMRGtJ0H4ITcapGaE0Ixr+j3eNxB
         d4QvVZ08AiexEO0dEhzqxOzjjFXl6LOrnR4TkwnD3Gd7ywq3yc5gOVWICmzf0s4lhLL5
         7QAg3yiQ7/038HX+g7gUlrqM6siRWttPBsorZhQ1c83yOIErrK4gRvl9SoMcSgP5PKLn
         N9WS+rlqd6ZV1KzX1MEydaEAsB3G8ZaUdTeXW2Lfvq49NGD/lQPNyox+cdAc6Tk63PS6
         +PrAu/bp6WPU8FkABMvKUWUV0xqH1eNAA2DEurmCquX/jRwYt3Roc0nfCbXXze+fil0U
         6xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783597641; x=1784202441;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/COlRRXaoH9NNlgjVg/+LPmx9BQ4x4p4lGUaPrCNATs=;
        b=sQkAWvs8P52w1usOyajnBj6bOGBIasrNjEgOKkuqug1/D/pQy0490HEX7IClvbFniL
         4cxqAvSXGuq/fqVB8TRXShiyvREqCMXAfHGBXEHys8LLHcvxvxC4nWWoA/NLXA76P74J
         9rPXORsh5P9mb+Tlz8WDOH8wjqMGRAcQ7NiDEHUu6fmsxpn6mTrFWzczarbrEdzAz+nw
         qE1RDcPCk56/qovN3Xv/x99kHEXf4/cPnxD057ytLPCzb6V8XN789X9nEHh3fAMYFhWz
         j7JyxOxEbcXyOHRRD5PbMLdmoPk0kITsooVCd8RWMFjZ0po/HiwHiOQpC/XNZqqpI4cE
         Z0tw==
X-Gm-Message-State: AOJu0Yz/xGI14YKIyNRrGM/SxIT8h8BVoC0iCjEbhRDh9aMzfF3+k2a4
	uXEAmjU9cTAwGNy4zH42ChradsovOYhEGOW90ij4A72LZFGS3D95fyq9l3FhZvOS
X-Gm-Gg: AfdE7cm1ju2SfqYfdP6TZu027YK6v1UQgy9T6dNTx/0pMxNbS58ZBn24bZAEF2epCf/
	/pWBRG5NRIuHwrq3IJW4uFVpnpIZUxRUlflm7BTMa9+iimXxxUFEKwk2KahX7Q85uY6UvmJqaLs
	rj0hQfleu3isyEtThvLWmaeXRlvC2Au1f/sMj4rLIZvVev4fqYwCjeE0T+y0N5P1BXaWKwFvmjk
	sG+47pTYjjzoaBukbBxUolHR2O9+IeS71WwRD+9zJqzcA/lxTaTmY9SrlzXtqF6SO6DMKwrUoWA
	4V0NNfy0qisxyq/mqNkCXj9+mYbHCX4Eu1EdskFV3mFNDbOV1J0oc8/jtRVaCmoIqexs64c+xI9
	t4PEtwMZxxWp4kgEbUCRQKU1ars4zzYwzqSL/9xPLkf6WIVcdGIZug3J9xFJHGFKtLkMJU9txop
	6RdkPhI3O6PtK3J/hdfg==
X-Received: by 2002:a05:6a20:d81a:b0:3bf:a8fa:a7b1 with SMTP id adf61e73a8af0-3c0d6c6f129mr3311876637.37.1783597641108;
        Thu, 09 Jul 2026 04:47:21 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.70.58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483941csm31028138eec.7.2026.07.09.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:47:20 -0700 (PDT)
Message-ID: <6a4f8a48.e9d484b9.15e549.7642@mx.google.com>
Date: Thu, 09 Jul 2026 04:47:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6607473248918696179=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sherry.sun@oss.nxp.com
Subject: RE: Add PCIe M.2 Key E connector support for NXP i.MX boards
In-Reply-To: <20260709101555.3034853-2-sherry.sun@oss.nxp.com>
References: <20260709101555.3034853-2-sherry.sun@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6607473248918696179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/pci/controller/dwc/pci-imx6.c:1382
error: drivers/pci/controller/dwc/pci-imx6.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6607473248918696179==--
