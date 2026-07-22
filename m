Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE7346E6D
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784682287; cv=none; b=jQF4NoevDCV8uf0UPNPB7mn6WzrOQVffDZO8UKOpiwCgT84m5J00fzsyNYQm+vQFvz1RDKOJvHB2F1riaUX8VVJlTryCWiNAOVErQebJgrGGEO0NUkfiluHgIjjOlXtugEnE8ka4UoQIeWdu+R5sZvKZ7VRPFx5GrUvBjcqoZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784682287; c=relaxed/simple;
	bh=kecp9iIyPzIYTtGqjlPcM+9ObwUZhuaRjF8iPbnwslg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MtYgdhYsIgMumrXDESzFIuHenks+pkGhhWdKNoSP31OTH65CcuZP6jGb1xhigN6wkdwy8KQfNbZXgJWoWYeI01A2FPBSqk0b+axy/fapIzslvmkoTCi+MMd9HfMcjIjHgCGr0H714FlQUswXKc2PEn8s4JBcIXogBNsNQqA926w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPPcDr1r; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPPcDr1r"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfbe05683so109595331cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784682285; x=1785287085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kecp9iIyPzIYTtGqjlPcM+9ObwUZhuaRjF8iPbnwslg=;
        b=lPPcDr1rAfTP5kL7F3aXwsUyQpnvxQbZnMp5s+ZHr5ufLzuYRGu8rhxAimWmcBuVkK
         GA7zj2vh52Y8Nbl5LPKsqwGzDioEnMtb2MjJa59iTSpZm+kV6uu3LxiWlWt9pmjwnWHK
         MGZNjXgAJWOMqyHzvU4uyPq4OlgEN11m9L1qU+0VnE/Pgi7J8BHG+nPth3aueudUixYe
         CEgpLjx66JdFVY4pxLzYIqEhcca7Woxpf7FT1mcTh/L7/hIi14EXkgfxVSxV0dLO+Wpl
         Q4Yp/AWKzEI1WhvHyi7cCeOHjPZr6TgBHOWceGa/Uj98ciSlJODuAY4mL3VmN8l+gPp6
         5ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784682285; x=1785287085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kecp9iIyPzIYTtGqjlPcM+9ObwUZhuaRjF8iPbnwslg=;
        b=hOCSK1pwpqSbaoyBhwNSf5Z9oA00lohRFXKf+ch51F73RD8iPO6v7MnV7e/F8q0F3p
         +wm6SRKnyxapdd890fi8EenIq0UqI1KHQUOWSiPhgDKCA66VFu0fDh95glOJXbearjiY
         U5FZEImnAMjN1K+4OkOuXomaBPHgsAWSyj+Xlod6l+TVb+PimtScOncvfakq4duA4RMu
         4X6t6kI8IRRmMpMWpu4lY72K1Z6uVvH5Nw9F/Majy8cbDfv/+WIYbDUFWlktGoR96UqY
         YzKwJGanNo78+PWRcwaWmKfeiAtMda7qI1PnHPEGgYFVV3YRQP9ZJBm49XyQDUliaKdC
         2Beg==
X-Gm-Message-State: AOJu0YzDYMQqOihI9IbnA+JgUAyznl1P2QtUMFM6dz62en8JJdpM7qjx
	LnkiXBtNfemEoyXxmVAOwPWz1vOViKAPYkkU+R0K8W1CMkHJxr/GPa0cAySNvA==
X-Gm-Gg: AR+sD10wC+4uOqgrhkVycGjjK3xhyIcqr/yEIjwpcaASPV1Ve3cL8GMryuZ2y21mG2O
	Zf3/bH1eQicqOkNTNvcuYGHjfLwA26/uEjAZVR3f295i8ZXLAXgi0xXV3DBdcLHu5d1jhyNze7P
	XgzXsDeg6ejXm7BTXuAFbbbB6B3Ao54KdQHCWj7iBmEwybkghFz8cpcTZZcDplcmX/HV1SKumfp
	Hckp7uTwqjk4kcKYqOBlqPWFUzcC6CBuLM+jIzZuJFGUf9IwYCbSlCwrkw4bA3SQuNIny81QgrG
	m/xg5IND2Dc4VOI7RyoMEEXvxaFNPEPi13opOY9MgSrWBtU9pouT5wTvyFEKd1d8IK1D5dHN7Bz
	jFYFvB7emxGpAMrpizoknSGBgi/otkgxIsdussgUAzZNMgMgtVgHlAWOCd/SwunKxbN2rZFWERL
	IhNxpFYlx9
X-Received: by 2002:ac8:58d5:0:b0:516:e974:6f72 with SMTP id d75a77b69052e-5213e082509mr205792541cf.50.1784682284869;
        Tue, 21 Jul 2026 18:04:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.62.207.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa0ef54sm8710586d6.39.2026.07.21.18.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 18:04:44 -0700 (PDT)
Message-ID: <6a60172c.ce53cff3.307de8.6f60@mx.google.com>
Date: Tue, 21 Jul 2026 18:04:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6965598145432948596=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v3] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for PLDR
In-Reply-To: <20260722001434.804931-1-chandrashekar.devegowda@intel.com>
References: <20260722001434.804931-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6965598145432948596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2781
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6965598145432948596==--
