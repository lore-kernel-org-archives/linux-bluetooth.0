Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A73F86F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300471; cv=none; b=jBe+xg7qRBuhTnjfWxgG0+tiVuOiaazLVaulw19kxJKtGPFmpAWQJfBycoTI13fjldYF3UlDIh2NbNuB7Znfb4ZGNJHmtA8VC1bfOssN88E27gzdHn4NhPb4Znae59qACxg4cKpT2h4yE3Fqv3lAolMsJQagF5dCxU0jux1NR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300471; c=relaxed/simple;
	bh=HpVBxOBVJ7lPpHZ8nE9uz0naHYC17hO564xtdmW1wF4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hX9JsDaPUumsAV8sPDo78B/2wmAMCLQKbDpQX+6tXie3cPjZYHVwRm7gP1gGa3z8w7pf++Vztg9UoQWvdIf0WfO0TZSq3QpwmYzFfY6SOqJ70cgP54meepXGJ5dFyCdPFmu8dS4GJR9shs9R5qsKxtg/qAIdWmp+PE8kBdsVvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOqkSbnY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOqkSbnY"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9144163319fso458306385a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779300469; x=1779905269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eIVmiqQ0iq5APZmZK4mtW6h+QeYst7lBfu0bJBuzPkA=;
        b=nOqkSbnYOk5hGyAYm9y46vwzERaRuLYShzbwmf6K27w9vmAz6dkbgBLIjNG1yOJ+b4
         xYNgo216SB60EjNZXK7EVwthMfkX0yMdsEZjoJyFR6BvkMZkfQzQhcdgNnqQ6dfRQUiK
         iYkOblqdtbKC3ySMI8tnmVjc/7AtZWTeRg6VH9GrtUBYH31WUc05YR928CLMefUKVmP1
         M7TMGjLdsHzNLZ4dVOW9Oau+3bGzbofBeYsfiNIf0mXg6vG3OFQyqEBGGQ7S89zpZoSl
         N4zjDSFIFKSH8B8d/THrldafpPBxZ16jZetzahupsMnu2Pxj8EPq5NBJWUb4U6gAPsfc
         H72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300469; x=1779905269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIVmiqQ0iq5APZmZK4mtW6h+QeYst7lBfu0bJBuzPkA=;
        b=IpgBRA1x9G5XJFFAR2Sx0QzBY537SbOhZ+ET09g6NWiM+S+b7kI+y3nkkl2eeZCERr
         BXGtmJKzaGjbrrpw79qVefA5pp/NjuVhCyZzVOCDJ9dPG29iViQoMrLcu0R5LzJ7cyVP
         uybQ/6f8lNWaEnIHL+HH9pjnedgCrkUZiE0DQaR33270M9X/0dhZ099XJe0wbqloCfjk
         Pv9ZRuEztiE1EsVS6w1/I+dl8mol1hs5ksWw+n6ZNvtfb++asmlrhDTNXiZbQpzBfLHe
         XT3Lt2/4upZSPNxxV8Zkk3yOYRWO5G62B0mn5dNTp2XkuD1UCSjGUqspOwWn5RAaOqD6
         p4iA==
X-Gm-Message-State: AOJu0YxD3Syk6nZ3fzAha8k8l3fRl3wX11WifT53+rXHFiPqJ3+wG0vg
	0iADBDqJrTyFbsZVMaFQRS0hmFzEU/DeTiOq9hzdKMskpMZp2ImkY3U9Yyn5mQ==
X-Gm-Gg: Acq92OEZgWODdx6vBMiDTUwYS+eyT86rFgI8qhMrJ497qRCgWAOd7Cgjk9RNsQfz3ux
	v3psWc+bGJkIK8eNXw0RLdaGPJswX/WVTFOLyuOv2Plzssx+rTlMPztAS4p/Rq/7ZpzFGEL7WIv
	VIewgh+hc2qg7hiK/uvsW5gr+K59/BI0Fc++AB7LplvnmOZmnLM5HZcSPKh+7Po9Xoxf79f0TQg
	rp4qpErV8KdoeLZsISzlerUboiK8yM1Ewu6bRyA4p1fNLuAXpQIrlQfz2tfQYIyQ+sux8WHjZu9
	hl+0rcZtTjRdbqTLLU8dwQQnlADCt+kKm0hOMRR2ASyh8PPdQf0Uarr4/F+Dwu6bKu5Hr9J5PmO
	8VKAyGaXWFUxclyeaG1Zvg8DLTp+DJQ5b59Pki55jLY4KwM6B3JSBZqD8/PsdsQlPcv7xkpZFRS
	VaM5bXpuaZMpZEvcH0M64nhZUAwqM0vSguFF7v9hQhsqE=
X-Received: by 2002:a05:620a:230e:10b0:912:1206:ddc2 with SMTP id af79cd13be357-9121206e0demr2581622385a.5.1779300468524;
        Wed, 20 May 2026 11:07:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.118.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc9363fcsm2220403685a.27.2026.05.20.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:07:48 -0700 (PDT)
Message-ID: <6a0df874.d5dfaa90.2d665d.e3d1@mx.google.com>
Date: Wed, 20 May 2026 11:07:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6909692098589880518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260520162030.2842543-2-oss@fourdim.xyz>
References: <20260520162030.2842543-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6909692098589880518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098163

---Test result---

Test Summary:
CheckPatch                    PASS      1.67 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.93 seconds
CheckAllWarning               PASS      27.79 seconds
CheckSparse                   PASS      26.40 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      521.38 seconds
TestRunner_l2cap-tester       PASS      376.22 seconds
TestRunner_smp-tester         PASS      17.96 seconds
TestRunner_6lowpan-tester     PASS      50.91 seconds
IncrementalBuild              PASS      24.22 seconds



https://github.com/bluez/bluetooth-next/pull/221

---
Regards,
Linux Bluetooth


--===============6909692098589880518==--
