Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A471381EBA
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844560; cv=none; b=czchNTVQKtc/B5UN9RtZZbbkAgw4Hbr75awe2Tbf8zbBr6wqOkbyolTP8q9oznccrEJxBFWz3uYNUZUemM4K4divxL0SsK2mtwHCGYl1bcj2KNCZOnRAtm2lg6CMl2BU2wmXEhv+7xvroNiRq8lcQrAXTdFeDdZAbSrgxm6vqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844560; c=relaxed/simple;
	bh=JMrX60vsjws1peEwLB1B5ngA1OgzMUwTyHK8kEh6QXI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u8xrRv0LF+BAY/ZVyJU6lpDeFXK6Z03jiUehYSA/ZgS/cpacsK0KOBa8AmA6xa4YIRrXtE2hX2+ZfT9TS1onSvyq3CI8VUwrsJ1TaLIYXIKDNrn7se8/+3roQ/omk+81nmA2dLb7Cq9x849aI5qOUorGR315D08rX/0y7neXofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg2AWOxC; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg2AWOxC"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so39428086d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844558; x=1786449358; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JMrX60vsjws1peEwLB1B5ngA1OgzMUwTyHK8kEh6QXI=;
        b=fg2AWOxCTWjemNtLoyvHXEdEyJUjy2W1LjoLglacWJ/JO2mbxG33amXygNI2RXkZY3
         qJBREfkFVAM2GExpgpaNsJqQNMdJ3LG+YJr5gy4xU+m3yCYaUjBrmTWXuDxKt8jEDgDl
         sCFH/Da4Jz1D3LUF+rdbzONUhb3Sm7Vsv8/oWJYyHP5nciZIhfgjcim1wJZiJr/b+HMN
         oKEAw6WZYBte8KtNXoh4kEufTveRLjF9Jnxy6Gy5niBWI4So5Z6y9vl97i2BeXhEMeN5
         d0Srivw+Dm2Z7Wj8idZqBiTOjaMhFMtvywasykcLxZgjRH2Ng4Vg9XD4Edt3QjRxvLgI
         PzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844558; x=1786449358;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JMrX60vsjws1peEwLB1B5ngA1OgzMUwTyHK8kEh6QXI=;
        b=WHQHyN8PVmmuvdmo+YS04ePXno15qZWrZJhYmPt66dabbcm8NLR/htxILI9nUUh1Ck
         /WFvM+nz2wa+oKj5JoQSlo26q+7Tf69KoIdm3NNw6WDxN5pXl4TbosfpkIkFPLMUWs9j
         pRRPG6Tb4p6Gb/UzZ84BvhE788Hqqk729vI4ppYPz6bhC3kSKHuRUgSKb/1ay9HVykA0
         831DDHcNagWPMXX79nzFeEsDtz++Q0FZ2ddYXEepAX5sBLojAKH9O4f1/6fIOIcSex0a
         a1/lRnSlql+fXXHVkaaLW1nx3U1AYKrSKCxGLk4sQnOAN9ipxPziGkbLWSB0uCMsddyz
         rylA==
X-Gm-Message-State: AOJu0YyvI30H8RZSi7jeE8rFSm0OWlQsKVxaW0d3w1LP8Z4UwCZsLESA
	qK4kZ38e0DMoyJ+/WXiHcFhLlhN6wTKDK5GLEPufAhrVBIilY0whg0J3OMuyJw==
X-Gm-Gg: AR+sD13Jjw6VWtEjl0ft1LEsyUxFxUg1GDRPOLZBHsrTenFFXq9MH3oiyUCFq1P8ROd
	TDyZx2oKJWGPG1BPQbOKK1ebZpdxrOcpmPLrZsBBs/iBwd9TFIq/EfqO+2u//CK4wpopNVnbsW2
	JirkP96e9gGdd+Yl+YvM83whKsYPQTQax+Tgw3Hdyo7cgDOLG0NbUNJIwOBkKcJgzd4KiXPZFXL
	yFxZdLc5BZdJQlgymcoxcdfjI3ZQCD6Z0n5UXitFpJfbmPR59HTEaYgUDBosdKTSHaDFzolWL3t
	JDHvZbT5V2SG/yjMUwTg6QW8SS0vPishxCure+A1WOTCq4ThV2AM9T+0/hzyjEcCj8QcbGjQWn8
	YtEDBvG3FPy/uyTxJvFMPKLJ+HkYp5c50pwE0uGRBjwEI6Wyvu+QJJWArnb5GVTCm56Gkrh2Sol
	tMtzEwpQIZK6aTfSKMcvZs/c8afOMMetoLp+CGt3+1E9tpDlnLBuHc5lCqS0gIYedcuuM=
X-Received: by 2002:a05:6214:4404:b0:8f3:9586:c179 with SMTP id 6a1803df08f44-9084966dd33mr310126286d6.17.1785844557656;
        Tue, 04 Aug 2026 04:55:57 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.126.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434bdde2sm97651456d6.22.2026.08.04.04.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 04:55:57 -0700 (PDT)
Message-ID: <6a71d34d.03d33f19.ee369.380f@mx.google.com>
Date: Tue, 04 Aug 2026 04:55:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3189893297278724719=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean@starlabs.systems
Subject: RE: Bluetooth: btusb: clear remote wake on idle Intel ACPI paths
In-Reply-To: <48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean@starlabs.systems>
References: <48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean@starlabs.systems>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3189893297278724719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:1026
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3189893297278724719==--
