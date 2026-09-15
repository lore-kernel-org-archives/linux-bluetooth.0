Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F74ACC9B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494246; cv=none; b=MqivS0UrCkR7QJo4K8tjhFiDeKfFE89URJ3kzfWAjTdSdqJCKec1+8VgTxX27/cAwd9gN3r2PZYztO60/rGzTLN6xUTtrlcqwDRnOBInLL9GL8924ZifdOUIuF8tftCO3YNi+59on3+FX61k0OcbP0jIdkzRi2tetea2TZMs+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494246; c=relaxed/simple;
	bh=x26ha+PS2KOrkwY3mi97eaH5y0zzEN0YQwaXI/XBRMM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p/Uufq6nfPZN9upYO33szpg1fe8tZew4qDR3THKVRfKKELRsikJ0VORkM4yxsKxE2a3hkA3wKDIq89isxhS+RmjvzYORvuBXKTeMnFxixtfapi+DHj9AHSA4QCgv+KsvythXeUNuUCNrLJlWluqKZUoTv2XNI+3StZ0Mn0xVURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfZCUPnE; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfZCUPnE"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cd4631090so12209436d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494237; x=1790099037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t1O3sz0KX+99olqKkKFoNYoAH6HS7zeXFvY7nI+BLeE=;
        b=NfZCUPnEOZjkgDJVxHeb5A+evXgd2HChx8vQ+/WZ+dw2iZE4XXkP+NULFty1nqnKaI
         z5pX/oJBlWDESWsDcOsi5JCmSxQ4aHDGf7yAml3WgI14VHyaQ4G2BjZQnnlRibjUVuzb
         TUoza99FtRWi+8CwQbo7/HhFLHOzZnuOfBulhOFhjfFlI3X/vPgmwv4aJZGaXHsv5sag
         JCu4/UaHRh4LlxRgeot7vlsGm53JGfYFcUfBgmfInp4pSFghfZzycjcJrXufMndmg0+2
         pslDfJnMK00dRceqYshQHJ+ObbEeAnz6+dryrmrJBEI+LgOCLPiKY4YtiODTr1q6WVlL
         DWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494237; x=1790099037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t1O3sz0KX+99olqKkKFoNYoAH6HS7zeXFvY7nI+BLeE=;
        b=Q4VdcTvQrc4jI+cGqbyqsTl7R/jxYhmc9HUdBIrNCjyMA6SvIxVktJyqV+syDYDFMh
         2Bx72v5OETZVI7x28tMK5PdyGZZ5v9Dip+Cf1Xc9HJsGcwRNKwdYb3s3vpkIkKP5SYEM
         FzrmYejMM4r42vc35ODawMulWJ4HyNNzn8BnLgehR1NEtZZMZnoWQHR5YR9Pw7CceV2m
         9ra89Gns+Vf0vOZFqQdi6yLfmzRCN4dX3AOcHfcRd5h8kycedoTtyEzBD6O+OkpJBvYT
         nyMchLmvMMti1vn+rSb4YuXb6Kpp1EWuth7CoI0eNLschMCMdWYB0qVnW8k20yAYbFwZ
         pUxA==
X-Gm-Message-State: AFuF++nJ4jw3LDyE10HzHZpE4iDf6OmUhFjlIyRQX7iMOB5h1FYP2Hky
	3AjVVaP7doT+EUAZGpElNYR2FVgML3+lup/YwAiF1+rwZAlbHyoiVVtarsC0kg==
X-Gm-Gg: AYBFou3VKgPwSm70cAyHu0o9CZutpyQZV1QoFIK/6W9qGl0EAHXTJlK/H5OsQwfB8PN
	w1/V4iIGxNX3pfYZNBukknF30yPqLZUCrHb7Fi0+mECzgZfCa1dic0hdrLT0yV5V1UzpOkvq7hq
	5yfGZqHo+esZx11TUR+0w2hTeMaksmJ8KxwDkvzybxWQM28YvDvHckKldEs0ypBPhAkCIJmptMU
	3NRw7+90P4GXXaTJjhdJ+zNAdYzLujSzgVZNNqXC51MtatInAR2LYQhGu6GKx5QMn9+ooqps7Bn
	Kds/pb7EevYypqI+NNhunlCAg/N4uaODkqHUEQfhFnbmFbc9bj6GtGwHAMfnQPmG66UT2ShPxs9
	aKwMS2p3E6yqK3n4gsrs0USss5en2mTtSqy1T2eBVxAoorSi3l0zkbL2qaTv3CHecQxIZ8wHxbj
	EGg9Vw8AsAke/Hp7a7H4aRRwwM3OnHqQMYABMJLxYmZsqE9y72IrG6pHDwszYmTJDm7nn6kXc6I
	jFeQGU=
X-Received: by 2002:a05:6214:85c2:20b0:912:35b7:8a9a with SMTP id 6a1803df08f44-91235b78b87mr37272736d6.20.1789494236594;
        Tue, 15 Sep 2026 10:43:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.223.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be609dcsm3919316d6.15.2026.09.15.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:43:56 -0700 (PDT)
Message-ID: <6aa983dc.d84cfa41.20622f.52b2@mx.google.com>
Date: Tue, 15 Sep 2026 10:43:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4622670060352489813=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: [v2] Bluetooth: mgmt: fix race in read_unconf_index_list()
In-Reply-To: <20260915155952.3104711-1-qwe.aldo@gmail.com>
References: <20260915155952.3104711-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4622670060352489813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165728/

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.77 seconds
CheckAllWarning               PASS      33.94 seconds
CheckSparse                   PASS      37.81 seconds
BuildKernel32                 PASS      29.75 seconds
CheckKernelLLVM               PASS      35.40 seconds
TestRunnerSetup               PASS      818.19 seconds
TestRunner_mgmt-tester        FAIL      9.09 seconds
TestRunner_mesh-tester        FAIL      7.86 seconds
IncrementalBuild              PASS      28.25 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/773

---
Regards,
Linux Bluetooth


--===============4622670060352489813==--
