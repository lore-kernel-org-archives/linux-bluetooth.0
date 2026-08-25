Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9839061D
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667542; cv=none; b=CVn8dmZV7hN23tv90QqyovmCROPMJEWyxEMAV3zOCg18TeVDWED7uykE8TGSuOBLrtxGM1Q/o4osBgXJ2p9yMAWTIf4SNqcX24AWfoyoyH6hP1jeVRAWM84pLEEYiRvRXPk8fvND98wBNERtDgrZWG5U1FOej6xE2X13A9KtQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667542; c=relaxed/simple;
	bh=6WdTzz1cpU92E99oEgJO5fWa3nXdp6mKz4j064uPH7I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oWW1RTC19HjVoC5rgLx6slbLOPdHFcum9q4wLrP54aL90XPShS2MXXFn2C8eVXGZk8cb8La6+yhJ70SJnMQOS/WdwnFoL7wAbqqV0LAdKahqIcaLxyHIJeeoPcflJDjcuyZGVS1a1bT/8tZYXBDqhkQMYJ6CoFdS10IcYZODsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3e2LYb9; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3e2LYb9"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-448b0ff4a57so6595966fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787667540; x=1788272340; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZwrOUUK8xsQhIQt2urTv/KaLjvGUaUx8/ABBIHksfJE=;
        b=B3e2LYb9r2EIGToa2Dj4dBWutOVBHOMDwZG3S7CtULxNHOB+QsVALIqe5Iq3qqnQMo
         cBzky61+QBoptD15yx9wyGX9h1hLpbuLAdv3EZtqZSIc3FxLAXfPiME3U66qzH1GCknv
         46qI4xYwpHbnyIuBrFwnNv70HwETUHm5iB3HsWdO6AM0q75/POz/5FchpDQyAf+2DZA2
         wFN90+DjT69CaELayQzdMKIO+H41K1fGgdm6viJJ2XfEMAhgAeHaORVFDg5DuKGBP/yv
         zNWUHgwEu9mmqy1SIqYexlpoY/nhYtmpzpM5BzJeBMguVCdd4m/ZW3Nrr9LluVB4cJUL
         cdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787667540; x=1788272340;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZwrOUUK8xsQhIQt2urTv/KaLjvGUaUx8/ABBIHksfJE=;
        b=f1Ax0h8scZHKDusOYg2P7MQrckO2gSZOxeFWroNsf18pGfR2W0rgdmzNkj/jmT63LS
         WYC4xcyGaZ9lE36Cgph1zER2pORrjUOy4YmsMQ8FstDQofqvR2U/GgLqZmB8H3gb7LSI
         E9Zz6IRobgXrtWIl5xXHwD3EYKo7z9UNEfExRAhBRYZijwe9CK9Yj6pHflEOiEY7ICXc
         vezipQxl5LB0oZCAG7jf+QU5Bl3gGBkGphJWX1TUZ2lAq5iO5fQ9uqfJS36kFO+AGHj2
         t7tIJ2lOAl+Eed7SvZ1xuP0m1T9p1Y/Rasrx9g/brFIa/N0jEqtTgZ2x4yJfx3pWmkCi
         wHzg==
X-Gm-Message-State: AFuF++nBHHvhKBpu4fi7ST5gFPXN01NKGeCQb6DhCv/V0WkdOdfOanZA
	xfC0s+qQy2EI/we0fLqjWFRw0hWBi/ih1m5l3IRAB34iHF1REVITYMhleg4yOA==
X-Gm-Gg: AR+sD1085elAk2vDv2wE1WoZl2eRmVgyERWNr1PY4wThsKIc51dNBl32WOOM3LDg0Kd
	+VjKqOuKJ/ANzSnR2A6TZCk8GmLTkYsJ9s8bDdS7UgtqLVjhxdFRBrmMyMbTcBNjiGnlN6eMGs9
	zpxs8z2SdWEUOEFB+D0iLh86ZwJstPjfKR+MoJdnIXPImaMcSVUq/yGFA+cyVK0nGxS21nFU3MY
	xWxTTjSrY2iB82FyzuifEnW58uKSPKoUCLPOoI51neN3DHuRmJ8fctxrR+qrM5YoJN6qkSIvwYP
	P51hjAjn7FsqD7hrhJV1veM3EXViHZju3ozpPNLAeBwDSJbKn6k2LgNIruXPtlbdyIhPdIsqqZ6
	C4enrHeHssvRWZ3V9SCAhsF2nQ80c/+tCXZv9CC0YCZY8Z3kF0GSP2A+SkjcLm6084X/E/O19Fx
	PpAKMGrqAFHwYz4msvx9/TBmu1rft8mtYqjCpztQnJ0QjAD9NCRq3fJgt/cmfal9m16IrhlA==
X-Received: by 2002:a05:6820:169f:b0:6b1:695b:c5c7 with SMTP id 006d021491bc7-6b1904bb3b2mr5485571eaf.23.1787667539959;
        Tue, 25 Aug 2026 07:18:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d2d1esm38789939eec.17.2026.08.25.07.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 07:18:59 -0700 (PDT)
Message-ID: <6a8da453.b12cec6a.88f59.1ee5@mx.google.com>
Date: Tue, 25 Aug 2026 07:18:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4400493617742104843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: [v3] Bluetooth: Fix code style error
In-Reply-To: <20260825122207.101868-1-deaner92@yahoo.com>
References: <20260825122207.101868-1-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4400493617742104843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151528

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      28.53 seconds
CheckAllWarning               PASS      35.29 seconds
CheckSparse                   PASS      29.87 seconds
BuildKernel32                 PASS      26.98 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      509.27 seconds
IncrementalBuild              PASS      25.91 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/652

---
Regards,
Linux Bluetooth


--===============4400493617742104843==--
