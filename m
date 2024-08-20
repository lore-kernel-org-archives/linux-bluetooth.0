Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1343ACB
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724132356; cv=none; b=TXuGjuETRS34xTGXeUTwQQHPTPN8uzIr+yBRMRdlF+NUxhJAdLSRYxKOmgNjK6r/u9p3Osf+BgG8+L5oPik0sb349GaM18DK9OHb4RLl1um9Uxyn4YglQNmRv4XmupnR4AtW+5gDiMMWClo8GjQhGotPoWNuoxD9CFwtZUH/QlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724132356; c=relaxed/simple;
	bh=t+LpIXKGCrqJqbWVoIT+Uo5iI1ghaTsY7Kr/MrUvnRA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A1pPKJy4K3zHrNTvHlhRJhurmqCXCAThAfrbXPMOVpfTBu2j8Yh1N7V9wXjyy5nI5SELrgMmGoVxuWyWphXvGkc5q2wAScvfKXWtvJ0PxccuiBErpSTqXEGiHuH3ZXIm4hfpFKrOtzP6CduCKKvLhuTOlSK1c70Jmaw4oAtkZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJcFAFRi; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJcFAFRi"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f52cc4d3beso1735103e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 22:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724132353; x=1724737153; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t+LpIXKGCrqJqbWVoIT+Uo5iI1ghaTsY7Kr/MrUvnRA=;
        b=DJcFAFRiO46snum42VRsPiJMSmXTJJcPH5OSJ3XfKNgBfd3rAEnTKX09yHOCzX/9/p
         /mul8Ku/9tD+i3d78PHW+cCLTS2Rk+xULfMvynIg34chd2/mvqQYoPx/u5775NCdaT4b
         CzuQA5HeGAlPpwQ82pwAAf3CEv/wZi0RTbQiQZuOzCcUWNQRpALpj9AkrFisA2vbCWnL
         cBrZWCcP/XpR+NHVf3RD2U/s+15mkD14q+uNaL1Y+z9k3AoQt+VjK5Fkp2qMPfZE7ee0
         OtY97pqEUj7UBMh0dpnuVUdssqPRPJTM2e3HbEoyQ/cFm+069rSrg/5hMAudvMvy3QSl
         n7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724132353; x=1724737153;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+LpIXKGCrqJqbWVoIT+Uo5iI1ghaTsY7Kr/MrUvnRA=;
        b=X15judBvwicYWWkE+vBLJgb2ESA2KnEgwD+SCWCU9imGLck/s5amlWYGYaR0nYDeKc
         woWvSb8CMplz8EHnbW4ARVgDl/QgHrcynq47SiKgrPK4GjCiV7gFmgU92aLAD/02lCC8
         ZVwtCjSf5y4hf4kUwhRCL+z6l0OSToJUq7nrY/2Sjv9pyFGFINBWJeicIoVdrw74JKeE
         uwmLCgEYPIyMAkJEvnYBPf4JGbQbT0QGk1Jtb5E7KGEvzfMN248qA5maItrpeYxNgAv7
         Vzyu9fBsspPcbH11DyrYMmlX8E8rxISbo2jtznn+J6MVydxFdtlHw/2weVNGC7PHzUii
         u/IA==
X-Gm-Message-State: AOJu0Yx9uCcmrs1aH7p2hTF802ApOXsxdgsQozLoV4ZG5P9MAD1z10LR
	HYK7Ft+g0tL462MgmXVlpBrK7gaV71LfTc2dMm7FGlPgKH5CAAhugCFkCg==
X-Google-Smtp-Source: AGHT+IHfF7KAXS7sXwr0kHYFOA9g4D/LnvTxQcA77kWBhCQAMarpJqhcsR9lb8KCU56uIoBUHOqF7A==
X-Received: by 2002:a05:6122:20a8:b0:4d3:36b9:2c26 with SMTP id 71dfb90a1353d-4fc6c9fa8b1mr16141779e0c.14.1724132353066;
        Mon, 19 Aug 2024 22:39:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.53.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff35c3sm47260061cf.33.2024.08.19.22.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 22:39:12 -0700 (PDT)
Message-ID: <66c42c00.c80a0220.2b3d4d.3064@mx.google.com>
Date: Mon, 19 Aug 2024 22:39:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2705335584746645146=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [V2,RESEND] Bluetooth: btrtl: Add the support for RTL8922A
In-Reply-To: <20240820051635.25049-1-max.chou@realtek.com>
References: <20240820051635.25049-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2705335584746645146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btrtl.c:1286
error: drivers/bluetooth/btrtl.c: patch does not apply
error: patch failed: drivers/bluetooth/btusb.c:540
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2705335584746645146==--
