Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664447;
	b=bJVXh2wh1Icy9yNXDEH29Z+VuyhJyIXfytMqL0oQb+s81ZxzYTqn4tIZtwdbuYhqhjKx
	 SSi4/JStyadZ2/7UHjyOCSDflPdZpAejmsLPyPoAK+K+TvytGjGRbXg/z4Bu133IVutZa
	 LPrm1xv4ViuSazmNlPObSsbVcP3Oh9zmtj1Lt65HUsYlgx/NM9IkMQdZoHHzET9VNso3a
	 3ly5bC3Z/XxVXwx66WIfxLHm7i/lwm173vKVO9IFNh2m+fqq4FjqJxiIHcpy66k4dudUR
	 BfsAJmUhRA+BDs+0ORHUVmf+RZMghnERStW5Zl0e6vyrCQcs2XUaFkIGr6/hjylcQLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=jzfbg9KzmkYOgPiaCIXO6LOxVG+4f0A/g8uf98oqBZc=;
	b=rNpuqmmxPkql1jdue2scTOQd0uV4beBg5SP+Dn/MwA6QAS9hXpOA2StTbnJmTjJgK1Kw
	 4Viqg5EvTgcIRJRwkRTFkpqB2YmerJzzvobp+o6r0yL7oZl9XxBLm3nV//eFK7esYsGhA
	 Ciu5nWFOc4jEbAt4yyPFOCkeOwdOTkw4KtwH8FZ/3bOACjKsoLTPGC2hB64FTa82SC5VT
	 enmHJk9jlRF/ydVZyI6aJh1oPw4Le0ol85Dp2b6gLCfqnWygCVyrXrvXYwlNqezV82+/N
	 96oOuw6xgNeFzMKHRMo3Ck5XCaha7ZPhBtvVatk+YYghWLzamuQAecUCma9LPIvyxZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bW5CawAM;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A51606A32E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 03:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2A51606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bW5CawAM
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so3768111a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 19:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664446; x=1796269246; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jzfbg9KzmkYOgPiaCIXO6LOxVG+4f0A/g8uf98oqBZc=;
        b=bW5CawAMy9ifkeuukygQtPQ71LzlbbpmLXS6FO1g8pegfGLs7EF3wFjXFvb3tZ8Vl3
         q6CZEpYyCalSnsb0csMOn2wEMzdzngTBo7Wy56pP4220sM8JrG72QWvxnYy2XTtrddXn
         8yHYMsd+VBdmp8Xxxj/uPDFRLYk/9FsAHEcbt40134+nbOS04Q/IBYaDe3hJH+mn7oBc
         3iFkzZ90/PVFOMwHAIIKMZCnzUnIB+n+8Dm34yTM3sYhCIJIF12AaP/zprjB1CZlO5Ic
         tIv25qmEuXh8HvNjt8D151VkkjJkQ4HQHN8LJiqUwkNLDhR5d7FFE4Qxt27kHDbTMGFg
         K2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664446; x=1796269246;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jzfbg9KzmkYOgPiaCIXO6LOxVG+4f0A/g8uf98oqBZc=;
        b=zcsG6iwHMvu78uQje40Q8UzVHaZdqKujh6t04EDiMs55lhsjQsrVvThK2lVtWMdQ6u
         RkZtJ3M4YRp19K8X78EP6UnMIHI4Lu01AqZ2ZIOeUT7EbMpcm9Pe+BXJ0o489d8jk6eT
         WEKUiw0Xlf7t0KFfEz9WUoUOe04c2L38Z6lXdkOpiAHFWFYDt4nu2kCwcCQrUA63VLFz
         CtgVcYDF8r2LjgnMd+pzQbadTfF27xGcyz4Agr0dlsAenViWvBvJW8Lda6Xzqaf0ekiP
         SGCMQt8w+9WtnRrhaBv09xE/+/yGX4nW0t0cKtlkT8wGLCRqx6IsUu5QxgWmwk12f/cm
         xBwQ==
X-Gm-Message-State: APuU4Z+u2F4UdX3K7DJD7IGrzwFmOVxTePYNAEEXJ8/7VNqcdedbQatE
	eBTN4C/l8r5ZEQXmylVmexJNV/DpQZSc1JmASNThoIUl/FwB0kR9hPfhxCvyqw==
X-Gm-Gg: AZFdTZfswhtyZSn0v0tkyut+JWxla+GcU5ogcFPCwA5FYQFcgzqgwwcohu/BmRcHGyc
	Bny0Nf3VRqaOhVJ+BskypJhjGygloFKPFTjWwLVZflLT9SLNp+tGADUAd96ue4Uio2sOEDxGYpN
	iquODVJMB/y7zanu/9F8rPLw2XpJ0EvJJfjLhewx/x+ZCW8EZ4C3+GjE8kYZcLX93MbYv6fIgcl
	64Zvf0LbLq1R73lmP6+YtTy7DI1X+mnY/bHuuXKguWRRPFyOwsIkDbmNMTW/caDycp2S977Ri9Y
	lUfM6LofueoRrwa4/tB9ks8VRjOUTbUedqmVx8DSDyVQU8rvbuYr89cE2e0wb7wIw1Um0PZ2Pk9
	gvuXBlUEA8rdpkjblNcpWkeRI40Ti9WdInJkb4axw2OGqTJ6QmLDwDXRCWzzH/lbhJxSieZVNN3
	qaQ6jHjpYdkTxlQE5Hpg/QDLWNKXwEF1v7bwY63YSr93Cb3BgLwZTBGnuF4k91Teruxjh+AHKfC
	IjVyX4vDa1iIeLyRrePAngORGNNBjxUEPER7HzuBE/po6UNPjsuZzEYMxuAD5Izmb7nHjYXgoX8
	66bGg3PANzaUjZ3lagbx8osq8rWvYilW6HLm1w==
X-Received: by 2002:a17:90b:2f8c:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b41c93fac6mr12809300a91.30.1795664445987;
        Wed, 25 Nov 2026 19:40:45 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-95.us-west-2.compute.amazonaws.com. [3.42.157.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm35556341a91.8.2026.11.25.19.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:40:45 -0800 (PST)
Message-ID: <6b07aa3d.8b4f3826.80158.2947@mx.google.com>
Date: Wed, 25 Nov 2026 19:40:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4365368507818160749=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v14,1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
In-Reply-To: <6aff9cb5ebb1f1512734d5ecdac876a2cc0c86bc.1795650070.git.github.filter194@slmail.me>
References: <6aff9cb5ebb1f1512734d5ecdac876a2cc0c86bc.1795650070.git.github.filter194@slmail.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4365368507818160749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222694/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.04 seconds
GitLint                       PASS      0.15 seconds
SubjectPrefix                 PASS      0.04 seconds
BuildKernel                   PASS      20.00 seconds
CheckAllWarning               PASS      23.08 seconds
CheckSparse                   PASS      24.55 seconds
BuildKernel32                 PASS      20.45 seconds
CheckKernelLLVM               PASS      21.50 seconds
TestRunnerSetup               PASS      482.98 seconds
TestRunner_l2cap-tester       PASS      13.70 seconds
IncrementalBuild              PASS      19.11 seconds



https://github.com/bluez/bluetooth-next/pull/1231

---
Regards,
Linux Bluetooth


--===============4365368507818160749==--
