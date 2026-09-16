Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFF366060
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538765; cv=none; b=fjiQmNMQBjZcxVK4JrnwU5RXZgMYbmplh3vlBV1ZMSbEy8nOAJCABbq9FjnU1cpImZ62kdos+xUhTba+9EEMQFVGTBO4O0F4IISVzqA0L8J5fPGWNNCxAwlm00GkOML9BymMyiR3LdARtOMU5K82a36WRi+VS4ZC35FT/F3RYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538765; c=relaxed/simple;
	bh=icMFXM64o+RcEzCTHdR7ofUbgqK9bz/oVhHMm34L3AQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jvTC4Yw/Uy5fr9zT7CGtrLHeVtJhdpzQm/cDvLs4O1VA2hR38DdMCoQtx9LjwyAYqE2Ty+ncky0BPQQ2XHTM5hEvgNqkhJxbiS1raryLOOfCqFbfLQHMGtrtunnzOSvOsAMM/dlt7xkB082a4AfJheDVRDDf76tShPWOyzbK968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnCuqRq1; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnCuqRq1"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c79fso282022a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 23:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538763; x=1790143563; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KcJnoLQb2mnd/WNDLcERMdQNGU6ayebQ9368DFgK6FQ=;
        b=YnCuqRq1qbxrAy5XwlLsYFhBCY32TjT2YmPFqI+jnvaCeuEYVQPNDkqLugaC2CueBi
         BS0Miz8AGM11Xyyp0S/Kw6qalF8v5goEF4lkSjmeRkCuoXw5huWrHUyXjti1FUoVzecG
         zSyF1KmZPthwPBFM5aW9e5a6tUGJ1mKAqSKUFVHzxXTV/5HqqKQglK8dcgcr5BE1r0lC
         tpprDD4wK/miCA6wazbICAt7/HRZq2RBRX2X5n3NbGdhgc84RlEWcMxpraUT0+G1INNH
         GbbXFxpB799yhvD3yMoz/d9MPtd5pMkQTt5i21sqq6h+mbCCaSfhZUbzk+Vd9GioNqnl
         tt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538763; x=1790143563;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KcJnoLQb2mnd/WNDLcERMdQNGU6ayebQ9368DFgK6FQ=;
        b=uhG1QQbMRMergFcT0xbYAMZauLbVcvDrVFEnePaTMYitbzDzRXVinVdPp0JzToJXbH
         AyEUbZbopfAO0ZoPHtzwQV5WtVhHdGyolqzcMwN+0gadviA4FeQ75w0tmrWFUg+JhGrb
         pNsYr8tDi7HKhZdYDTstFoAIWyaPY3uH+jNkDpA+Sd+puWhFagbyuIOZKgv5p7vgftJC
         VMdWA5VxKpVFVgZ/qrhgbp/B21bpDys6hfFJHUCRMhf1v2IuNlIjWTKdQIXiL34helCp
         G0hFJcrWaCl0dexfsDaeXz1X7GfXh1plM0cetPcZEo8cBSDL4Pmnum5d+wcywXRLxYZM
         /gwA==
X-Gm-Message-State: AFuF++nvgFcsJwSw5i1k9CufxglD2i3EP6l57we6Msh7JDOpDOGxMHbC
	9uE5/1LVVi2bl2yQvWAYPYBMLH1G7GzJ/UnlSI+bekQXgAlS8jBBCr68bIr/qQ==
X-Gm-Gg: AYBFou3qzYwpq7yBvzVYu7gUzmcOxJpO7BH+l/q0Q7GaOuX2fTvBGsbhzsNI5a4B45H
	WkMfHEo7GcTvuZTFaOY21mPAo31/aenxrrlAktq7UR3uyxq6T83zHFhSfQ6Qvrtbp+kAgDSkl6W
	T6NoB+/HWA2jx6GNZqEC8lWhyO70bTBKpaI7eNpGR27Pb9O/3sQWsaYiiaLIXGnP50CqnneMYT/
	Dgpb6tE6cyNJK8zBSTCAwWm7SYPpvdjoVspiJiN7wn7KBLEGWKdYuGGsJ0k/7BZq4s+T5lvdduy
	DP+XLoV2YrBaQA2vFvAKLzE8lUJbk/OZ5+otjG8z3bvnFKBHyqSdV3k9B6YLdtoly+O9Jrprxy8
	xTqXxAb/Av8x911U5MkmNWVBazjFhDmldbDV95cntByNVzSZNXAuBd+niXz2C0WrD+4m7G0GYig
	ejr/rAkWwYOiC1l2U3mqxNj82iHUxWfqnMdWMpUWV01iviQ41TH6hUSJUDkg3fL1E+nUdA8I8nU
	iGM35E3fUx9sPMDWiQ=
X-Received: by 2002:a17:90a:d444:b0:39e:b0b:4d1a with SMTP id 98e67ed59e1d1-39e1e2e50eamr3736709a91.6.1789538763415;
        Tue, 15 Sep 2026 23:06:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.217.200])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cacce6sm3824237c88.1.2026.09.15.23.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:06:02 -0700 (PDT)
Message-ID: <6aaa31ca.54e42a5c.3b22cc.8022@mx.google.com>
Date: Tue, 15 Sep 2026 23:06:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6347216585597991289=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btnxpuart: Simplify ACL handling and fix skb leak
In-Reply-To: <20260915-misc_fix-v3-1-31fab8976ac1@oss.qualcomm.com>
References: <20260915-misc_fix-v3-1-31fab8976ac1@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6347216585597991289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1166013/

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.56 seconds
BuildKernel                   PASS      26.24 seconds
CheckAllWarning               PASS      31.20 seconds
CheckSparse                   PASS      33.19 seconds
BuildKernel32                 PASS      26.67 seconds
CheckKernelLLVM               PASS      30.04 seconds
TestRunnerSetup               PASS      673.08 seconds
IncrementalBuild              PASS      26.61 seconds



https://github.com/bluez/bluetooth-next/pull/780

---
Regards,
Linux Bluetooth


--===============6347216585597991289==--
