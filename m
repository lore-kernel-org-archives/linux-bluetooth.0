Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D23B71A4
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784135114; cv=none; b=nuP7fnK1NvVFrBEmzHIaeGn6WWjq8+UFxUoiiVRXYK3Gq6nkj3fTDGqirIg70Zp0asIRmsb+3Pf64h963tXjD/l0DeAP9vo+jj8Xs0HCLq0p/wexJ3Frweu6GlXKj+4tc9GDOSXl9zxouW21tYBqsAxJOzmJ2q6rUZHI/9XFeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784135114; c=relaxed/simple;
	bh=FjwZndJEPmQo/86jj8iRhJIvSk+ULQ5eK2/PSrnTCuM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EoLyvHdf8xshnBcBjReFZvL4RR/hcuzv2K1ZTrf0xZ2w5KGRSHSOkJ4VgyGUWiKYgQG3eMQgioOw2ibxI7VXV43EyKaGwwIZLWSDP2voUmdgH5yc0b9lpOUgnWtRKBvtVSKCFYAtfsAnmNd4W7BN6FtjbuZQ19oBkp+v/t+Gn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZyDhBOV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZyDhBOV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so5820808a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784135112; x=1784739912; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L/JztD0IAzPSBm8FPHw+cG2uKgozsuHfV0eRJ0EcxL0=;
        b=dZyDhBOVj8GmklYqG2mFhwkYK5FNOy6IqUOBT/oTZoHX2bAVJdYtAm2Q7jsKKw7aae
         AF3VCx74ByTBYd1inbXtUfrYcuY755cLgjj7+HkCMlHgnmIKTzGzmZdXw9pFyAhte/4v
         l87jyPaPRW6CiWk4oAWrep2bW+r2w53RyPKqhFs9BmcQgU3qrzqXQ2VrY19PjBwh06PM
         brzeHrL2b0mgIQGhe3//WEza2Vo+KR86mjHtQkGJNHVHUS3g5/xkxKmQ21XQq6Z9+OOJ
         HwlsUXS6AKKo8VenDaqMNjXZfDrQY2hp42Vp/ayTl312EfUkq+K4fcFlZVRRZ0mzWeuN
         ys6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784135112; x=1784739912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L/JztD0IAzPSBm8FPHw+cG2uKgozsuHfV0eRJ0EcxL0=;
        b=YhcNV9pX0Mem1/ocvIMWOYXovlTsd7iskKSfgOfJ4s9YiucrwLluZwtl3/+HB3lOod
         m6KadyHqQpPeFgDRD7X/eRbSbkU3ypXVKJQRW+nzfjmkI7n2X5fl9KBgNsyP95dAJLl1
         ISvvyBVa143AR/Ym3ZNQSwhEDtdbhMZwTVVAodTnZZQq5VBo2R6Wvsq1xOL3UAnZ+DG2
         Xcz3nXV8FpWOIN5bjeYvKuNy8ut4uu9YTZaJAZkih56gNKcjR4OZgqSZRGsU89D4PO9+
         jV62QyRA5iqwIGDJTHA6qDKK0JFYN7hDvjZccZg8tVQhVgXc6xSZf15mjvhfvh8s8LvC
         8GqQ==
X-Gm-Message-State: AOJu0YxUDvaXW7IS0OTSoX5FVQh0nr1w/ox3TRklR5UIBoCHst1FqnRd
	fDUFhgbpXYvEa/jtRtUTG7fEuFB5tHZIw2+Ill8t9Bi+DoZdTc8HMFOTnpjHiw==
X-Gm-Gg: AfdE7ckIjhDhCx2sEyBQZpCfRwCw9gckqQrsTYctNgdwjZ4z5e2U+R+jVdXISs/lZBW
	3RcyDqh8o4JUaFFP2cQ8RXWKpfPrIyLpPxqjmHNx2mqAssouO2ZgELqDirOZJ9sDmz8yB0AEj8U
	iiPB+RxtjrO4uzpA5TUNmhRdePJpUcfFjWeaJJKSRlK0ptueVndG/wlwsOOHMoO49SgJgR2gPvf
	tKVXa08sJfiJOqMu3X7hvbl1vqNusdmP7oSIxshreM/XXT9f79NdKr9VUA0Uv0ZqyVuK15TiW3R
	953+BMp+8/7OECzrmkEwGSH/TmSLFkDVw6rTkCl9qVhVA6sBf10oRFImCFpXdL2gcX25NUuzft7
	ipYj5X1/6MlV0hlg45WCuTsojEmnkBBjUPTCmVzAAzEv0qO2zcm/e7BGVD6TvZYo08DKa0yL+I9
	IFGTj70SJe46q3dRKhl/aOn3uKiFf4BA==
X-Received: by 2002:a17:90b:2e0e:b0:38e:11ba:992e with SMTP id 98e67ed59e1d1-38e2a06c078mr3090468a91.35.1784135111427;
        Wed, 15 Jul 2026 10:05:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.250.210.73])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6a714csm2808545eec.14.2026.07.15.10.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:05:10 -0700 (PDT)
Message-ID: <6a57bdc6.0c05e68e.b358c.d718@mx.google.com>
Date: Wed, 15 Jul 2026 10:05:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8362239991162101353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: support unified decoder coredump format
In-Reply-To: <20260715155401.605564-1-chandrashekar.devegowda@intel.com>
References: <20260715155401.605564-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8362239991162101353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1128275

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      20.58 seconds
CheckAllWarning               PASS      22.33 seconds
CheckSparse                   PASS      21.18 seconds
BuildKernel32                 PASS      19.55 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      360.81 seconds
IncrementalBuild              PASS      19.97 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/445

---
Regards,
Linux Bluetooth


--===============8362239991162101353==--
