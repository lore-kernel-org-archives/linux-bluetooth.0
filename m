Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518496;
	b=0qDb+/lWt3zDUOO7PlBDroHC4qMlex0o35C63ZADxDgTTLvvB297Uay/dik5l9AzLA4Q
	 OstJMHkWdUHkrKMG8gJh18NTk4rwFIHAaDoqthjkKl4eQIFg7WjjMFoqdBtjcdjJVTBOx
	 EANftK3g76XXsf9b6ghEiUu4J83Wp1tPf/HfDV6nMTscedQQkh/OzG3iMLmnWC9gho7m1
	 9clrl3wLKTc1FiDFsnsnVKU6ugcJzMjeB5JFrmTBLcWI1vJ5YzNWMCLWxG7X6FiBC2fPZ
	 lcmPPll5gHz4l7ZCRB9wBlgdY6SefegkOXHXY0PHrCzUy8Jc/Ls55akZAdPWAHMnvWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=q8EWvZ211PRCHbXIpeuQ0wVN9d2pq1rbrls3X+U84MM=;
	b=QS9QmoZh3WsYTINCWcEEnIN5ByfH+oqyUY9PvMlRXSsoWOE6oCq9bzjNZb7DxtnfMCwp
	 b0IqJWoDk2rLgXBJL+uoe/6MUsIcM6oh0T1pIXdQCqAt4zJFAfRIbG4Agrw8XSbsK6kdw
	 SYTydDRg7G98e8akLmBdyjAAWqx/3lJAWbq2lTWvLWYqqxHAHOB0XjFWO6nKoc3fzu/bS
	 hy9BawDfUmY6hWNQw07tji5Go8TJg93+UIQpxraiNyG28MLysgNSE3d45m7HnWleUIac1
	 /3jAoNrO/nRAIu7E54rq9aCM1fAjArrD1sV1AdMQUUzTy1lqeCdF8qbF7BzJsmelkDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OaPWuzSY;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62834606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 17:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62834606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OaPWuzSY
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e942864693so15694395ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792518496; x=1793123296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q8EWvZ211PRCHbXIpeuQ0wVN9d2pq1rbrls3X+U84MM=;
        b=OaPWuzSYeK6AJzwJugq+F0vaLWfpQMU9gMXtPeMHUyqCXNE0iPFOlNQ2yCMv2ODkGz
         JABFnKc6cO/Z9iUNlgs5+aEW5qk2qch9FSN7rSgvgJd/TF7Ax325HjJ+BVP/MWl9H2cG
         xklZWnwsYoYpWU0MSaGK/p+thojj3+xn3qZkaDXTCtHJ2QaruDGSTPl0e1fsjQf33lRY
         B0NF4DESw5sq58WIlENdUH/Y8tCI8JUg2dg089DrFwL1Z8L0rZ/cEd5H//3P6tRfrtUS
         trnUO0ooXvORiFNX4brcRdCnMgHqdlx0L/YvbYmK4lG05H2tKqByIrv66jPRwYjVMzYf
         x4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792518496; x=1793123296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8EWvZ211PRCHbXIpeuQ0wVN9d2pq1rbrls3X+U84MM=;
        b=N6Gl26V4+aVT0SaICboyexroybJn8DAk7mUYQLYWl79sWRRcbQ+zFvvDEeoOhnpFho
         RkdlparWIoNCN08NJ8pLYYoCg/7/v2V0u9qJwgguHxBkgWRW13bkFjilZduyGQIATJaM
         z2iVSLTfj+wMNAvQlj7OPX4wrFOdCOJNhllCoqJarwBEUNBgP2h7INNn2WjsFJSYMCTi
         wJqt6ZKY6Vk83b6PMcGdRx51loaycGghQKjH0JiBzHpNHOXz6ZCwcnQfvaDCteKvayd3
         hTeXGXZOyKx3S1x6f625VfAKdUMBsfY/BQGdNOonSXFrM7XEL2xdJt+3KOrXZPuSry6w
         4CeA==
X-Gm-Message-State: AFq9FYKIHb33edOm3fkqELw3NSxuj2q97jfLVavWcAI0iDyYznMePblZ
	8Axqk5pme3DB6cvDdvpJGtzlDYjh8xWNwYovvn71F+fDsr8U2xuitX+8jS7I9g==
X-Gm-Gg: AYBFou0ZXoJoEezGtC1GWp1J8FknF2buyt2DX+yXs9An7tUVOCbQiP1fOY+Ljrca4Tk
	LkGK83gm4Sc+Pk9mFePxsc6tt9k3hwKuhgK40bbk+dmj4VjjqzjYr+lt/JI9bbn1x7hXg+eUfm+
	a88414iFZbik4qItk8IYrQYBO68QBZauTowSHqqZET2sp1traUT/06rviRTOV8+EKBGJLXzNLT0
	vv5ooqLrYVG4aNj//2MWVwOxinj76UcVgSUZhq7o7+1+46quyMs3MMARSVeyZdYx84LmYBXJ+VT
	6ZzGH19/SYdzyKS9mKm+cEAe2MmCR0UjxJ0Los2S8w2OQNuV3YCM84/kdExHgoJuHdMNY8mTb4+
	USwOXG4EgOfM2rbfuIiJhu2usQVVNX27C/U56WgUYHglMc4dTSOUy5rrLOWfP8NQose19ZEiDUH
	ra39rc0XQfwpcuwv9hFMPqGAgS7DF5GG59uF1OX3sxMSmyiVLRy9eCcTIamhrr5GsCaE7io/vxm
	Qcn
X-Received: by 2002:a17:903:1210:b0:2e9:776f:66b3 with SMTP id d9443c01a7336-2e9a68431a7mr119037975ad.2.1792518495630;
        Tue, 20 Oct 2026 10:48:15 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.44.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada70sm1767985ad.72.2026.10.20.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:48:15 -0700 (PDT)
Message-ID: <6ad7a95f.8aebd4a1.2633bb.668d@mx.google.com>
Date: Tue, 20 Oct 2026 10:48:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8905062255214326329=="
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
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: Bluetooth: hci_core: Fix queuing disc_work while workqueue is drained
In-Reply-To: <20261020145320.115333-1-deaner92@yahoo.com>
References: <20261020145320.115333-1-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8905062255214326329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1189822/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.22 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      28.55 seconds
CheckAllWarning               PASS      32.74 seconds
CheckSparse                   PASS      35.40 seconds
BuildKernel32                 PASS      28.75 seconds
CheckKernelLLVM               PASS      32.49 seconds
TestRunnerSetup               PASS      686.98 seconds
TestRunner_l2cap-tester       PASS      12.52 seconds
TestRunner_iso-tester         PASS      10.62 seconds
TestRunner_bnep-tester        PASS      3.08 seconds
TestRunner_mgmt-tester        PASS      88.22 seconds
TestRunner_rfcomm-tester      PASS      4.46 seconds
TestRunner_sco-tester         PASS      5.55 seconds
TestRunner_ioctl-tester       PASS      5.24 seconds
TestRunner_mesh-tester        PASS      5.46 seconds
TestRunner_smp-tester         PASS      4.27 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.34 seconds
IncrementalBuild              PASS      27.30 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_core: Fix queuing disc_work while workqueue is drained

41: B2 Line has trailing whitespace: "    "
45: B2 Line has trailing whitespace: "    "
51: B2 Line has trailing whitespace: "    "
57: B2 Line has trailing whitespace: "    "
61: B2 Line has trailing whitespace: "    "
66: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/969

---
Regards,
Linux Bluetooth


--===============8905062255214326329==--
