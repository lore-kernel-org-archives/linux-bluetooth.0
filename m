Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB331A288;
	Thu, 17 Jul 2025 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722727; cv=none; b=k0Y7mT/4sIVsVcSHpOjvTJcoW+4ii4kflpVO8dxzmGcytaRlGjnGT77JPqYZ0wcEpYTorG+QeYoIEKAIJpJ/tojiLqChAU2bgMUc07D7585xkV9EYkxVMFVkaxemkFfOWaybotBV4bXDjgfqGvjuC/s5/Nu6Jo3E9lOUeEcqc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722727; c=relaxed/simple;
	bh=8dj4E+QB66Tlv+gvETYptGv59YF5FxUWf3w+R31dx+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YBkyWTOZl6R8jrhyi/+UveIX3etnBV7zF+zyxO/h/+WOWNNgOyJRmhaOyfCJkIm6uIFIk+1KyDtjPqc3w+jTcrWrUdlROj/w5Y4hUkYlEECvMZXwicrfDuBaeD/QnHvl3GCW3+ms4H0FU4mpd4FrwasGF8AlV92dbvbjWVe0o34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaPv90Jt; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaPv90Jt"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e2e3108841so61866685a.3;
        Wed, 16 Jul 2025 20:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752722725; x=1753327525; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JB/WFQlA0jCkOwSJEmW/hh1XjsjNXRICpj6/1cDFGMQ=;
        b=NaPv90Jtw8y0E9qQGvRLy9yG0MnVwikAM++cYcmBtjNUekNP0sKqba3V/9jS0sAHPP
         sJ7km6jzDDb/A1ycDYDwY7kGw0IaoM8Zlp2HNu7q3pfD93IKO/nWP/rbffMmg8xdnMXj
         HWLr1S6GHGFg3knp9cF5kDNmIwglLo5JJNXe/E1h8jzchCtPd/XkLpQBrwKXlFGfdwGK
         HOVYh8fNKupZz0UeVTu/Jbgf34DvvHgN82jp/GC1vvNWLioqXGJ1mB4bK59YhvHBB+lg
         3KbU/pI15SvhS4KUOgwcy7FRICy0GJj6chZ7h2KupSCx8LgFyNuzin6M1fz4jeSZ6l6J
         G8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752722725; x=1753327525;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JB/WFQlA0jCkOwSJEmW/hh1XjsjNXRICpj6/1cDFGMQ=;
        b=ZZcrHlbsSRgNU4nM4urN3H8S1P+eUdk2utZXS1lEk3INDd09lofTFKEN9zw3lywGX2
         k/Z6Mdls406PhYWqHXcARq44xZ3vV4r7k+gPtfL/6ZngnRQ6g958BI68F7qZedcgW8Ho
         r4OqZfMTsNUzSg+FTgPRafQFB7Y0J3pnWVz5/k+LqBAdlaq1VYHajkYGqe1oK3kqeEfn
         50HWDANfBLxoVyX9H66dQqOmuQe0Z+imS1az5B8Sq5F7IyAbjl5iMmK4qE2G3PCGXgNO
         SLysLaDuOVFQ5Uq7HVTaM8aR9xqkd1OOC6z8P7AHOXfZwvMZtAqFm5/KHJNW8LptLyVm
         Iunw==
X-Forwarded-Encrypted: i=1; AJvYcCUwWUbqSzQrg00hMjM1HjX0smYLeFI/jLMPTQTKK5K7pQsjfPM50YWX1WNq3CFLWPKx79jwRdLSB/nBt32S@vger.kernel.org, AJvYcCVDaghb9EcsfMFaIvkRAibM9wvNvb9dCImubK+eIQPnE9ERwX/kaeSBWcmekMQ00WNZUSqgRW0Lc5aHALcyQ8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQnAheQREuXbD0c5bxVvaKEk//NEv9wU9Fvkmxyzei3cODzF9
	HQu0Z+TWJS0+/Xg8dryhblWk0YRh8aBGU+bHQFiWC0Ca2s6DTonTUM9R
X-Gm-Gg: ASbGncthzGPGMGQxTbt9e/4y6Fq7WDnkzUW9wW8vdMaHkw38+EQN+W3EkVSa8UbM42y
	9lO2AGptH5MrUJgM9fKqTAgqh9OJ9JyCoxQGtvpsXJjLq7ZRsChM0hjK4yapu2uwV6yltCXWIyk
	LroHuqIp1sUI/Su+AJ1jFrP2qouNP+ybkJL6OJGCtW7IqigqiObmAMwTPNu9e9Gp64XBzgI6+vh
	CIDGwW1YpS+rdN1DCpj+f55iyvmqSyRalMrXYKADMiePGYipHB26h1wxtdjom1MMxtixI7g/t/l
	hvOifn3GeVb3Ptto1nXTg2zVGE+ExVRZyWyJCGgUfOrd9H755rHL6KG1HA3cHFHV0AEOWBysvON
	E5BEVD76RzgMfBg==
X-Google-Smtp-Source: AGHT+IEo+lfL8ajZCliPovuPSaxPxdWcDZODn2O2ltpJHFtmulHepLI92psUjfl8dnnJKOhNvOvZGw==
X-Received: by 2002:a05:620a:40d6:b0:7dc:471:3a6c with SMTP id af79cd13be357-7e34334a203mr899531185a.1.1752722724582;
        Wed, 16 Jul 2025 20:25:24 -0700 (PDT)
Received: from pc ([196.235.182.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e3443d830bsm169726185a.25.2025.07.16.20.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 20:25:24 -0700 (PDT)
Date: Thu, 17 Jul 2025 04:25:20 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] Bluetooth: btintel_pcie: Drop pci_set_drvdata(pdev, NULL)
Message-ID: <aHhtIL3jyVbCEMqh@pc>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Drop pci_set_drvdata(pdev, NULL) in the remove function of the pci
driver since it is useless, the data is not accessible when the driver
is removed.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e1c688dd2d45..28fa4ca3199a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2339,8 +2339,6 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	btintel_pcie_free(data);
 
 	pci_clear_master(pdev);
-
-	pci_set_drvdata(pdev, NULL);
 }
 
 #ifdef CONFIG_DEV_COREDUMP
-- 
2.43.0

