Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5DE378D8C
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122515; cv=none; b=CcU//2L8B+WSjkr67NEWkIwy/0YaDpbUE1j2jqFQXdEc3TfNO9NZNs6V1FbCLxA8db2n5p7u2cZ0t1D0rNu8tt9+SlQGgNTqnV39Ir/g0DSEuF1n2ZyEJQY82DQq5dvL4OG+Biewie2NEE5PyS+0N3kdVvUvNqV9v/Gqw14JgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122515; c=relaxed/simple;
	bh=48PorZIsEgIX9BqGJVCnGCA30b+JTiIC5HEhs3Zo59A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KAdRk56U344g42TDtuIac/Y2vAVo4wuvZfPdeh8MsZJPoanlgScXC57VVpx0+5HyZ1BBK/cVDA3b30FOpdGp85DU0m2+KuovCZMrdWBeiEF0ciDTBbv5vf5XvWYpGKkdZu81wZs5nGIfPMZDvyjHnomjZLZrgq1lPDuX1V4jV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmF0rn+P; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmF0rn+P"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e512a9a6bso171021585a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122513; x=1786727313; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ToQgL+mLrHlV6DlH1oGDZL1+Y/MYW2228CulsZCV80Y=;
        b=PmF0rn+PLnbvv66l9gvkdidP6P8vM+Sunlued2ydE1yaB2XZyAGS1Gs1ecynBzkfq4
         8cc4sJL7K2TiOW4a7xs+2cKihx8nG9VKk/tAiAYqag1eXGi00itiWE8zo3/zFL8zxB9X
         SvQgvggFaxJ5993JofEi9UOSB4cY/2RdQxDKeFpsubqIcvw+K0UIp3qx4+nFLwQ8/thd
         9ssV8Adkkyb0F6IkXOuShaxR/CyTiaMrli2EfDfoaji6ly6/DRbFnYoT0rwL8hfb0WwW
         xiUXCy/xB7uy2vCUF81Ho34GStTimIsKv1dM9IjMj7cy5T4zvRyrj3PT6LBSS0HbDVYg
         YatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122513; x=1786727313;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ToQgL+mLrHlV6DlH1oGDZL1+Y/MYW2228CulsZCV80Y=;
        b=hNPhDmasesh0eHes2ymco+jiwlpNuoI6H7qDSa/h1lyhmEOcSMhOWU9yg+DDJ9M2As
         jtDZdyrgyCNxGBvcG6SJA8Uc3Mkx9nSlcYw54sQ9cMz4iU2xrU7+lQQVRaw6Gf9U8LvJ
         1q1Y/Tjiz2icvr7AdBhaVBuw4hKenyMUQKn54U7Lp37jwtiJwDdSiGBn8L7lCD3ha64C
         G/h1+oe+3vLKuA4/0gz7cRe6pZnVhvuy5wf/vSr4NUWhIopcgrBvIRBfTTFXKVk+DJNq
         bKiE+/IzggfKU1DlygUgrlZikSy/hOsCaH436gliCM4XJAqO+bgKad4CCDl5509qQ+Hs
         X0ow==
X-Gm-Message-State: AOJu0YyXgclA0mJDFUyoqX7NoeoNWoRLwHjdl+PwoQSNaQDoqAP3YU+f
	M1i7M5Ub9JnXkw7REr2iDMiR89KUeUh+eun6yJ2NViIc/D7UCuiIkmq+WhFMKTQP
X-Gm-Gg: AR+sD13KN9S0bW1lBCkqzdTfRnlSDZLtd6xbDOghZgTq2Jci42NJp942xpphpESUDFb
	1KV5mBwBcn5kliEcVybNM3mTxElJ4/DzvfajhdwmGAt2RgQQDJmxeAx51v+dWPNSJvzqqAcR3ix
	2jzRsxn0k4Po5NNEi/4/mYhUwsEbiWJYQqdgdmRoAP9FV+o6lEV0+v1OeeKUfh9N7w8u6hrNUVy
	6WNX52Stuksm5/+3cSET7bTG0zr7e/tNACIc1l1bMN7u6n+D00jj1GhVt7z25vlfxn3nTdaTcLB
	DEZN36QxRay2NrjRONpTBmGHClyqEqhHv66j50A4P3h/9FMV9rNUzSt01h2OEnTlWtWsKgVEH2J
	udc07M9Z4wxEY1bpoSyucCm+9SBQ+nj9U8eXG7KG2JtLmUTY1AJXKmCCljRsf7NprYKOBOapew9
	OK7F/wMk+dzW0R0y6osDpBJODcZFQWJmjwV8Ev9QlWI1T9vZZoiv6agITaaxQKAiYMDj1M
X-Received: by 2002:a05:620a:414b:b0:915:fb92:d599 with SMTP id af79cd13be357-93649229898mr2050652285a.25.1786122513313;
        Fri, 07 Aug 2026 10:08:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.214.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e0c17fasm192073885a.21.2026.08.07.10.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:08:32 -0700 (PDT)
Message-ID: <6a761110.35b683e3.9ad91.ef84@mx.google.com>
Date: Fri, 07 Aug 2026 10:08:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4851676791171461974=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, igor.skalkin@oss.qualcomm.com
Subject: RE: Bluetooth: virtio: improve RX handling
In-Reply-To: <20260807160325.1921-2-igor.skalkin@oss.qualcomm.com>
References: <20260807160325.1921-2-igor.skalkin@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4851676791171461974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142326

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.66 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      25.38 seconds
CheckAllWarning               PASS      28.10 seconds
CheckSparse                   PASS      26.78 seconds
BuildKernel32                 PASS      25.05 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.99 seconds
IncrementalBuild              PASS      27.38 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/550

---
Regards,
Linux Bluetooth


--===============4851676791171461974==--
