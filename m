Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3A3A9636
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194360; cv=none; b=f/wpa+hq1Dmf5DqkIhvKF3IXYHtcmLIUo9ChT09OIc1OS/UJLIWZ/HeiIS8O96g3Uj62HieSmyN+T46gE7AjFvDjvnxjmLU4+O2YTfKMt0LwxIH1lL1xY89FauVwh08Mw+oZtVSPl5o8hhkofA/1i7248lbdFdHXzC+Xo9v6Tus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194360; c=relaxed/simple;
	bh=JSloXPBo3IiJyYL9BKohEh4L3eaIIKlXOGBtzPOEYE0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RXhByyIaxm1x+HwoiDgSudSL4uGt/g/JtdSaZYS9ft92UyoJJUQ2iZR3kaOcV/bpLLaHWdD06uCRnar0Tb1/gEcXtubEpTO/Aq14cEKwqfHZc0ykDj0ATpttBrJrrlHpA+7hSO/b3LT4aD2aDYZV7ko8ngnfDusBaKmXyuLeMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwDnREPB; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwDnREPB"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-139b914bab6so2226187c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782194359; x=1782799159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JSloXPBo3IiJyYL9BKohEh4L3eaIIKlXOGBtzPOEYE0=;
        b=DwDnREPB3mtUSZ8CnoAjCkwrYa0AbMZDoqKb1P42KMyqYfKF8yAZw4xkU9oJ3nyfyp
         0cSDac4fbF8/YldQRnNtwLbtjwpc7/uygNKeLw82gap9QKDvh5wfrrF7ptTWta5HKyxu
         6YtlXSEoYgxKO6Rb4lSTn/baEfEOSj2U7jrCYiDcyZxg1BJv5js5KqW7OlRuuYvnZ5em
         lPXG30ZlOjQkss8qZkFMwRxtld5GsTUDLjcFpU8zPF/BdA8WWBUbukeA8hECfKB1E2+I
         EJPaECDiS4nJ0CyaJ/Rlwm3M+3T/17eMs5gUxSjRObz7SigSqChQZGjXAh9NYxERX9u4
         EH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782194359; x=1782799159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSloXPBo3IiJyYL9BKohEh4L3eaIIKlXOGBtzPOEYE0=;
        b=krKyeaKU1icSnaHWl/Aug0vUqt5SBiY8077J0tXoy02WRXNI8zxn3dUMCz1rac2RlD
         GyJ3wtSHAuoMa4Z7TdxtthdxH2gyEjU6EaOa4s1D9T1Qrmr7Z4rsN6xJSzo4F9MCRzpx
         ChHkta9J5h88dwjqoRFOrfN9JM9SZ9VG/OLsor8XVTn+R9hI/yza3vbEWMLsiC8r7gy8
         ElJSkgZsV1vx3cFfPYUmy+5FAr8TgEezShDQA32y+UuKA5g2oi/NW98wdvr38Mx+wfMV
         rnmrEl2yboBHIq8wShkUZHouds8kxLoqnN7Uah4A/tqY7ZrnAdEHOGS04ElFjCD3Irsm
         aA1Q==
X-Gm-Message-State: AOJu0YzZgw8B/nGT7WHocv5fWYnzCmyFLNc71LWa5wH8gQ78dBosfaI9
	WjoDsrWDw7xA7sL6n7OyUMOPxoZODRDWDESKelu9cp0SCweAqAemINsvn2NDsQ==
X-Gm-Gg: AfdE7cnO2CMqac8K8RkY+1jLZBn/rUS9S4EiFvtTtV0HkLdCqh0PYZtFLeCRW0/Xwh8
	WTvHAL+Y5CUdb7Bt0kVFK2pqFBrRLknsaab3DgHzadycAkvB+N6v+vUKKraYBiYD/iHgzDVbz85
	UeWHxo9oBpufU7bncezvo6BaNAdT5Bxl5QUsquv7I1e9v0gXkugR4FVtAiesgiEc+XGyY/JpnZr
	hp5aX19hzyfrN9LFKUnilKkOwa6z+vj6M7QQ594t0ExtdPdqGwcfXS3PVEsZMWm1zqm40k+LEet
	RvoLbtEgXd8SYGe//dWlhc0CLOSZF66aCKn3uMKlM6i7m+TBsFK9oohXC7kCtcgFzs6mhAu0Lu6
	21xPpQ2sc097IBe+G31PjJz6vxbLx3SQ4XAZwgfGjjAL5WLXQbaCoYuQ9Iif9FPlFD9uEWlzOxw
	AZhZF8aeX3ypBaVIPArA==
X-Received: by 2002:a05:7022:4a6:b0:139:ba7d:84a2 with SMTP id a92af1059eb24-139c6f439ddmr691954c88.21.1782194358715;
        Mon, 22 Jun 2026 22:59:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.20.28])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcc5f14sm11977928c88.6.2026.06.22.22.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:59:17 -0700 (PDT)
Message-ID: <6a3a20b5.7d41f3a1.30d65b.be20@mx.google.com>
Date: Mon, 22 Jun 2026 22:59:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4992126362517205767=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sherry.sun@oss.nxp.com
Subject: RE: Add PCIe M.2 Key E connector support for NXP i.MX boards
In-Reply-To: <20260623030736.1421537-2-sherry.sun@oss.nxp.com>
References: <20260623030736.1421537-2-sherry.sun@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4992126362517205767==
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


--===============4992126362517205767==--
