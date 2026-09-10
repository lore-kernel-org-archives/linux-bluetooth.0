Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CC59D607
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066890; cv=none; b=awXs99NXIVxfYrlGykebW/n7JnuG1P2fdivaPSBSkluShMvxnTLPB4LlxZ0Ptsl0iqpKFv8JDNMe1facqWXEUyAQ84R1yXD8CyeDhUm+1IW0BYVhAWImWuRH/hN3+BeOmrt69Nr2Ru60ezGQULWpwuPIZPZ/pLdKB1AzONAcXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066890; c=relaxed/simple;
	bh=ay3WAHatcOWiv+mHK3Q80fXI8ltDqLpGOvzx2KHTjQs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n2hCBa8tYIDtrbqxrZ4J8FN7dNWOxB2aEtZ99PSDcUzIG9WhlGfbMYYZvP8T+CwXbJ6pwnxmHgnhX8V/mKbGYcS2kWUV9TqO3b3XMw4UUaQvA6hA8A3aWiwLWaqocPSVArF5EFsEx0CrYhsAaoLQX5RxPWAWZH4ki1/WUX7N/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OawEsy3p; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OawEsy3p"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7fd8ecf2ef3so24854a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066867; x=1789671667; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lMy3YDzAnkxVWS8igYaeVAXRgaa3umUHsEw1+nhBmKU=;
        b=OawEsy3pCAXj+LWQZ+ZArkrSO/bBzj5I60kU6T1msmqZVZdi1AcUGSPfoMLvDD2WbJ
         bM7Vef3EXCYl40rCdXNUc/h95Ay/eAZl3aOmSM4aToGUATYy41sfb6gr7Rq1p7jh+lXP
         2kO9a1VTNAdi5WFO4DcMJAiTv5LmExPcvrwHfBDqdP6Y3g3rdaTmnkuj7k3SVCcqScS2
         m6ONj8uVOIEvltTnDm9jMSEGnBZvZMM8rjz4ovEJCugCKj3rJ9lyyKwq5LSCchID9a80
         xcKi+FfEqXCtklpptr4w4k9QSXt4phHbSpnSAlVYtETR+5gMdrMw6BcOyuRsJSvCII0k
         83rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066867; x=1789671667;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lMy3YDzAnkxVWS8igYaeVAXRgaa3umUHsEw1+nhBmKU=;
        b=n87iT2i4lVQOdz5s0ERDCzLJJmw8GggpBPuRP3qYo3AJBwO7groKu7BPQh7PAuoBWE
         xnb1bHUq3muow04gbBb42p0MVwdS2j63FCLZ8h96ApkG06VuZnD4B5ScRA4YPvSqM9qF
         PgQPqhC3JdK7B4I1ldQ7xpNgTD/kTfFsnSedrqwG+ZFkHGrxFdlke1dkJSH0z/IJmtbg
         YPTbsX772h1vj53w9+qSBVOkz5IQEGuYuSWe1eIFDQRx/aj9PfUXKOxCu1x/k7tBVlCd
         h9HBAGI1rNgW2cGm6BAZWh+sTl4CDTdPBWfTNLceFjtNub73RdMEToXC1++0XXaLQEAj
         1GqA==
X-Gm-Message-State: AFuF++l1AdD76Lh44V3cl0VKOc2VR23h6FL5mUGAQ+kiOWvRs+t1Q1Zp
	MSN+0S/hBfL0N2e2iFzLQEg8DORTSm1/0I3R8k1bl+b7TKWWKhyOkGR7S5DL5w==
X-Gm-Gg: AYBFou2ODwDJLvbPUQruwak8wAwgVvYp8XOTYrfBsbvdpt4/mwKTAyic61zIycc98oP
	DDEHcidt4TsC3OM0NJJI5F0DWHZqYJy+Ssyq68n5p63uE8YQR3eJw2Ijl5HSoZPVWovYdDrwx0r
	vWXysXWWsE0nZ7p9iPhbXgcML1XT+gjfC35HyrNfa8bDrMXuT6xJZ0dNnry2rxeF2RE110gzVfs
	J6t9bruAbzzbZpmdBBq1VJ9PzTbqhW00CAG0edzjtMH9dI8p0x/BoU0sCW+V/x7em459JjAZrV1
	m89J3czVGL/9hJeHPoA0nXqWE3lHqh9K/rvr+aKgaJbb6rLaDDk9j6VkitIHIQjfhPTQRIdyTmI
	4dEUliueRc/JjlqF2NtvOqUZKFRiP1D+SAji0MkJRmhlPzqQTyi8NloO7fbSYPmFNAHnR8dhYmg
	CGfoFiLY2+A3TALM1J47d+WGsFq+V7u09sn0iVDi7zjL2SmNsykch0WNB/QoVTxGe+UJxtqtzkU
	fe+1xHQ
X-Received: by 2002:a05:6830:7310:b0:7f9:555:1df1 with SMTP id 46e09a7af769-803df5571b3mr465613a34.13.1789066867407;
        Thu, 10 Sep 2026 12:01:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.242.183])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f66fda4esm302480a34.16.2026.09.10.12.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:01:06 -0700 (PDT)
Message-ID: <6aa2fe72.eac42b64.1fb192.4ea4@mx.google.com>
Date: Thu, 10 Sep 2026 12:01:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3590566434056246794=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alishmery18@gmail.com
Subject: RE: Bluetooth: SCO: avoid deadlock in sco_conn_free()
In-Reply-To: <20260820174633.1570398-1-alishmery18@gmail.com>
References: <20260820174633.1570398-1-alishmery18@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3590566434056246794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1149255/

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.40 seconds
CheckAllWarning               PASS      33.64 seconds
CheckSparse                   WARNING   36.94 seconds
BuildKernel32                 PASS      30.41 seconds
CheckKernelLLVM               PASS      33.98 seconds
TestRunnerSetup               PASS      787.34 seconds
TestRunner_sco-tester         PASS      22.54 seconds
IncrementalBuild              PASS      27.72 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures


https://github.com/bluez/bluetooth-next/pull/739

---
Regards,
Linux Bluetooth


--===============3590566434056246794==--
