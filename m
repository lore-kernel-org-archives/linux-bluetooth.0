Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8F45039
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786169310; cv=none; b=N1XrlASlWrNBK2YnCdcQBWNhj+9QieL/K/rb8utsdy2JMR/f7Dr6a3BUdy20HIFVTdPnji1617bPj6nbG46LEHNITuaLIA/PqTXL4AdZ8X8rOeSdKZ/2rL18LktRXK0OUG+m9rf5K1xjrVv8+TvPP07M9qTXDbCG8WmDCQF8PqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786169310; c=relaxed/simple;
	bh=PQkhG0JLdLkAxWchgp5XDyFIP+865tfRgogKH1BoJ/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EYqXdMAz7UnlWQ6DI6WYSkCgGdzzKQznO/eX4PdL6XDEOTTXaVzkWE07uZhCHz4Jb1RH3yYe7s28HQciymVnhf8kuiWpFKaInvpAcxPcPcKzKAZXMBmkCfeO/zdSfMOthrSiW6FeyodLhtCF9gdV8uG7AYU1bc85wTJq4M/tvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOXd+fuC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOXd+fuC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so302963a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786169309; x=1786774109; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XF2uio8COHBL9QFu9Y/o+jrhjqnP284MtxubPtMm3aM=;
        b=pOXd+fuCmB4XV1KOLTQ6nQ/WFm+6B8GWMKQKyK78i42spFWaq4iBHvKEIjavh6EI46
         hH031OoX53I0kNCVolXw7vou+PhFzWzruneZ3RcjRBCnivK4bulwDDVav21HOeyz6qp6
         9+WjHalJBABkLotoVZJQrzMcMlWs85iI4aLAsywIPR1Di1CeX9HMNYwJb3tmItQIKreN
         hCsU8lawhlv/vcycom8F+dQEq1AQX1FWMGlLAScH7YXhJMts7iRFUgL2/5Ti5r9QIhox
         FvKWY6ysnwOUS/YLOC2zk0Gjp79UXsQjz+7A/1IC1rIJf60m++ZgJFBFfSyoEnya1AVn
         k4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786169309; x=1786774109;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XF2uio8COHBL9QFu9Y/o+jrhjqnP284MtxubPtMm3aM=;
        b=gCR7V5saOOHeGuLCprFTzFEQZNkU+0kfkp5UqByDB5D25hSnbazU7IA3HDVFeYRneT
         E6lKaqC0rD10F/WK9vUSa2P6Z+TUBQPo77vIAoTSgd/Kd+DjPQGPdjLs8FmukgdHa0x9
         vUz24D8sRSzTPVBai0bPXHCbBD1bExLPesJbTmf8xcD8EVW1alRENiqRYqT6OO7xgmU1
         M3yOz+8AknMDZ8sePhYYY1eFyQqjRyydR/d1Vox8N6RufTSprYVHE8b6/C6GbKstBwHZ
         k9afqyEYozmJa2qy/rAOSdyj6fS/0kgkYMaZeQwL8PhdxuHG4DnOazlb5Kp0/Phc9dYu
         oAMA==
X-Gm-Message-State: AOJu0Yy9hnaBXelv/cRej0Lo6HtzhkbIuljOEjQnYGs0N9ELZ3xHsqRz
	cyIGi/fu5uFzN7+M+kYa4ynQvmBQwJEB9SExEhaymsulACtXorz7hLVnb94ryw==
X-Gm-Gg: AR+sD122QNMJtOK9X/gU3+SY2Ny0a6t9PiyykCoE3eSgxYyvo3WF8/3mYPXtpg6W9g0
	hS4XMorHfZmM2wSY+tYmkj91srYJmVriuw0cayWvIfy7XZIVVd3qbwm3BsYzLvJvWj+e2rcDIba
	M6zvkC3TRHX5w8DnW9byCeqgGWTwD14t6AuiKn3WEUhRDqeMGqA2sX4OKMcct+NYTBwh++lHvF+
	ZjSZmhzOnmyyxPlXEIbUFZRM2mfd0LB8j1Bhe60yuA0Ox3r8gYTm1bk75XL5IPDlr0wMyoZQLQg
	Lbb8T6lPi2Q2a6dZVzy65PXzWbtbYvK+ED4UTqHV1blDTPTTrApxu0Bu9ltMejHuyx08La0EaU1
	/HXkxi1Bo0GDKUEoI4QSNjFrofVqLI4+kJO0CiruKx2dRbZlynsdxhKAmp1fgvcexWFZoBFb+dN
	MCCUBTvav9hDcRp7f0ccWDNvJpa1CFVsqpMroT39fwMlDW4e0UV0+mkcmuCMItRGJj
X-Received: by 2002:a17:90b:4fc9:b0:38e:740f:9764 with SMTP id 98e67ed59e1d1-3903c5f6477mr29760385a91.18.1786169308854;
        Fri, 07 Aug 2026 23:08:28 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.76.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm23541256eec.18.2026.08.07.23.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:08:28 -0700 (PDT)
Message-ID: <6a76c7dc.4b9e17a8.129179.c13d@mx.google.com>
Date: Fri, 07 Aug 2026 23:08:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5397898618265264557=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lgs201920130244@gmail.com
Subject: RE: Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
In-Reply-To: <20260808051532.2553947-1-lgs201920130244@gmail.com>
References: <20260808051532.2553947-1-lgs201920130244@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5397898618265264557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142532

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      21.06 seconds
CheckAllWarning               PASS      23.27 seconds
CheckSparse                   PASS      21.81 seconds
BuildKernel32                 PASS      20.67 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      372.68 seconds
IncrementalBuild              PASS      19.44 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/555

---
Regards,
Linux Bluetooth


--===============5397898618265264557==--
