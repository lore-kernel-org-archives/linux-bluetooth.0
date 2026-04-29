Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE873BED18
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466506; cv=none; b=etUswQdDRBTcundQtYV2YIOq/hErL3XAjJBZFt1MI1SfxU8X3AfsQCnfgeJqIgJ5pYOqQ/diWX8/zjnsL4KIyZ7dqnR/RXdrjLpAxlhufz37rUuymK2V1M49CbtPYn8mlQH7FAbgPfd5ojPwElRCZL3a99Qadmer6TeOEv4QrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466506; c=relaxed/simple;
	bh=SPqBXrk69a4uVWnY+sodTJ8WgCgZ6PSTkrRUZkpcK7c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LlL6fEt8GWKTbS0WdQDM/YGP7QGrK0Dj0N1RLt7lTaeEbWDnOhgKlgZGuf0y3h+P+5L89bB5tTlcQcm0DxJgxmkdZ685RdE/ERb0l03gk5LymJwKNwe4UxshhYZgSgcW6DEzJ7ZvBjQY3mNjAYHPm2E1xrWRHhOrmEyDXIXl+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSrFDDMt; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSrFDDMt"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40efc77933fso8038096fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466504; x=1778071304; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GEnbvq3kenFF7sdHQ0fLO9cAkqpZtY9RfhseOwYyGZ8=;
        b=YSrFDDMtb30IPcMAemVfI7CyiDYn7TCs0D1JSNLzT3z/r2ouoiNhr4yy1TpfVgHwpN
         XFOu5rEZ+TxZ3y6TCR4WKwWbLznbpBYV8peZjhw4FiaJq+T4MBP5pW7kmwKUrQLtJwHM
         VhZgaXTzAzqMFrmV4VloI61Ny2T3MVjKqaFfWebdv43vbGsHDHsZ/NKzG2jqwIiv20zh
         jFw5ZwyHssq3J+Y7LeVsZCdRpJ+fomE7DcHj6JFlOpVCdyxSvGtsauDY1HSWwCGQQAVj
         wCqmzeDTR/5Mk4bPJYUYhlOfR11LBV2imq+XRJACBN7G/vqWKZZXUQXgJ6SActiNWRn1
         ZoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466504; x=1778071304;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEnbvq3kenFF7sdHQ0fLO9cAkqpZtY9RfhseOwYyGZ8=;
        b=GsMDC2rWwcREbORs4VHUAd/c2CjwJyPsh0aurR8qggMcQKCLFTolpM+K+BaeXzTU18
         Fg+aHLImzyZpwEyYn+iFqsVcBUGxI54fhfgqltjHYpyGYDvRxeAphzNbraszqcwOdyU/
         S5u4GsoZPUXKLSqzNOVx8U6Vbflgo60EeCie5MM4on3C1S9Lw0x9Xq12LcOOPg/8wYwf
         Pv5ygMB0CLhK+dJswIDcrGJNL6WeVV0fpkF5kgzzqhg9WE+yA4y12Q2YvJMFtQ2MYl5c
         hLa87yfg7AqyDw6zoQ7JqS7WiBjAhZ+WQ+nKzXqORv6tuxkqSM77G6gIraIXn2Qcyq1B
         UhTg==
X-Gm-Message-State: AOJu0YwLlOaSp5YTFqhNeyrd8KfT2WCpB2whJZOVnhBl0KxoWSTP8sis
	8DsC8lMWy+NbE/mVxD/9DaSJvZBVrzBpJqFlPQ8E99HbJQ3gnsQRGxn0sQoruQ==
X-Gm-Gg: AeBDieu1/QMysliVK/XN0WMZEE8+qG6IcTYfh0PvsgryQ3fLRlPLONhjTuM73L8Eqqz
	RYnVl3WBAjxqx0iEdQqVzK5zew1zixnCVXKnyXkWbF4wgwm1jPCjX4QzrzjCLwcfwJTAa+kX2ME
	+pbfDrRuKVw4xrw+uBLqiBftUj+80qaucwuxAg40X0vIb92qwE1jvDFQwjYOTfABZqUjVXj0RQ+
	tqL2XgRWxN7OY6kr4YYMFc/M7RNPNq5Hhyz2F/9ENQEEMnT1ewPt43pysfI3mz4wMSZcKx13a8l
	UMQJYQO3ceTSz7d2XmECyt6V3KlxcP1xXkHV1+42aWRLuldgm4faVD/aaseKcNZXDLpPeTolai9
	iDuubytjzC4eDAAxsPLHamu3pPVo348p7PDkLhOpuMFhEPTGi0TRUDemFq1CfClw4cKEt+nUxUS
	V4ybe3XkGppdoxBFXkkmlwLb5F1ZDZciJR6hLjDfov
X-Received: by 2002:a05:6870:d113:b0:42f:b6d5:c127 with SMTP id 586e51a60fabf-433f3a180f6mr3809856fac.21.1777466503664;
        Wed, 29 Apr 2026 05:41:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.19.200])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4340e987d73sm1852881fac.14.2026.04.29.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:41:43 -0700 (PDT)
Message-ID: <69f1fc87.050a0220.f0e90.fe0b@mx.google.com>
Date: Wed, 29 Apr 2026 05:41:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2764150197427753901=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] gatt-client: Fix use-after-free caused by reentrant client teardown
In-Reply-To: <20260429114806.2337081-1-jinwang.li@oss.qualcomm.com>
References: <20260429114806.2337081-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2764150197427753901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087435

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      20.12 seconds
BluezMake                     PASS      587.78 seconds
CheckSmatch                   PASS      319.98 seconds
bluezmakeextell               PASS      163.68 seconds
IncrementalBuild              PASS      595.61 seconds
ScanBuild                     PASS      903.06 seconds



https://github.com/bluez/bluez/pull/2084

---
Regards,
Linux Bluetooth


--===============2764150197427753901==--
