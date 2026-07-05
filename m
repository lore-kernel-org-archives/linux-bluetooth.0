Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18825B0BC
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783249041; cv=none; b=THxiCzIop81RReCOO+aSY7G8TAFOsEu4EWWAaoyoqwAmsY6wUomEl9MvZCDF1tuQeOmm6JVKvYmfsYdSDqADgDTpDb8W3Q3xq6dhZUvOub/v2qIyNtFVS+0wUT/HKTw1KFjGLobX9417pTMRJ8I43oEbkARH9eyPce2F0pc4gvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783249041; c=relaxed/simple;
	bh=nPjAqtWZmEusxn3SdfSIDwDv7Aj2e1JW7/aShffJdGU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SXHz6js2LBfrdgbV7lHpCjASsrpgEizmv4kwd5ojKlJAJ/p1eiZuco89OU8x1lPj4wyvjpfJngNO/DlkKVZ8FUJqpkU6Xc2mqLmlSvRC1+l36+4DIlDWdLel+rUDQlEAZRSi94oJjbPqoSq3atcUF1Mjp03hjzVL30ttFwY/GsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sknvzpuH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sknvzpuH"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c21495722so10727631cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jul 2026 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783249039; x=1783853839; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YkWBrUu86QYGXfJNz3e9M4wMO18V/t+TgeKkJZ7TFiY=;
        b=sknvzpuHIJszG16hk1ij/So0hE6nmZ1sGovPp1Q5S5k4OqQYkK4qHH8S8hZx8ObPHN
         /0vN/46XuTKuZEj/vEU97rtJ2zayph7SSFiQNfqhhJ7TdBebaCnPa5nqPNhF4stTdOnN
         ilk5zQzpLltWWruGVIMv4sFFspl4/DXogQxRW7QF6gjWBfTDPPHI+HDVQwQzmC9K4dRa
         VQupIH4Iy1SqKSn2LNk6XYFdCZ8xBZN2cg/f3pxr2o5Mje3i8VTYK7RFPfZtrtZ0nLwG
         TwzEtaQYhTYC+lPEYcyXDOEp0b8/mX33+1iySyAhomo0JI1/0X9xGZIN9wGZd6rj7a1C
         eWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783249039; x=1783853839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkWBrUu86QYGXfJNz3e9M4wMO18V/t+TgeKkJZ7TFiY=;
        b=GDr4EwKdPVXg08PysjqGThMjYGG13F8e8YtkE1IC9Gt0FjmlWWVIVLqbykjTLy561k
         v4hXS4XI/lBB31430ZkgFy3Z51gRaEjERBhTdhRrfP4bK6UqI+8E6X5Zs4ZmlbLokElx
         RXiy3XviJJu1JX1ope5QAnDJEWTwEeSuBRIHm0YbK8gg9I3EgmT3XeUB09nLALVCFeUJ
         7f18i69VvQWb5tq93fsSk/Ddv3Skx3R8NbtZII3qrs1Rx8dYGzs9Zt6P1nNgdQFmaeSA
         M1uWUF5k14R9yJAF6vpoNOpJn9VkRd18RReHebTAT/mDMixM/MmZw6SVhdQHi/gK6WJt
         GNlQ==
X-Gm-Message-State: AOJu0YxXtvr7MBVUDSvo57T9IlyWi5H5d0Caz1jCAPTk6Cx37QqDNwl5
	Rzpce/svQajiJ+8S5HTPjoyrYohaQFiS+to2PX5Rj9HiqIEfIUrjVwdWYRZRhA==
X-Gm-Gg: AfdE7cnM/Z+59TIgAUy42omUAy0CEsj/srLUOJ8ClrUsR7etEM56JnxiWmav0kPKo2z
	DWfvtPcl1JAJsByNrFb7VgZQjzm8c8IwTggIHiz+ErLxC7w4tpfhROwqo1QDOK3X9j5bLLcZgW4
	FOKB9ZNPuJ13Qa3qxPy5Pl+WjqlLKU3NiLK0dGQA1SArnG48Hd37t7+xvIOmh14Etm4x9NPbgtV
	RFRSWE9DRumgmBcd0jcVBvgKvF1nWcRdpfxgHZSCJMtzkLV8lkZ2gArHDAIQS3E7gLzVGo2X0P3
	NpvEJeL16FetFAl6NVEDODpuhXQbcqtik7mZuaff/4vouaqWArkMPhA0lie7hJ1XRwVbbh2BV1U
	vi3+DKw+3guZ2BO6KGnIeeaZBchPaBSZg+cdQqYXBMbuicA0yJFuJRElo+DK/JQaeTv8zpwcbvs
	0oAAaoluyXNKF2LJsodgk=
X-Received: by 2002:a05:6214:5f10:b0:8e9:f5de:d605 with SMTP id 6a1803df08f44-8f74d0af34dmr91331886d6.50.1783249039115;
        Sun, 05 Jul 2026 03:57:19 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de93a1sm104691986d6.34.2026.07.05.03.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 03:57:18 -0700 (PDT)
Message-ID: <6a4a388e.d0999061.39a55a.2099@mx.google.com>
Date: Sun, 05 Jul 2026 03:57:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4335259375971642995=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cito@online.de
Subject: RE: [v2,1/2] Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
In-Reply-To: <20260705092857.27050-2-cito@online.de>
References: <20260705092857.27050-2-cito@online.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4335259375971642995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121736

---Test result---

Test Summary:
CheckPatch                    FAIL      0.68 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.99 seconds
CheckAllWarning               PASS      27.90 seconds
CheckSparse                   PASS      26.49 seconds
BuildKernel32                 PASS      24.34 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      452.51 seconds
IncrementalBuild              PASS      23.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14664419.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/398

---
Regards,
Linux Bluetooth


--===============4335259375971642995==--
