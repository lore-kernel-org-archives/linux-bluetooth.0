Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3545FFAE
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293401; cv=none; b=cOxk932rV5WuoLNx5FI4cZTbIPkSaBEykFmtY+smw2/g2aORz4R/3ZRTKT6C8ZIvjC6GQicgwbqMhtWGoVw2apbHnZXS8sFGt+qzOXl4FmxxjrDOI2sUspHsduJG21IEHLmOUVqceKBwkA/BBRV56pWD2mtwSMwkh44+UOi00ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293401; c=relaxed/simple;
	bh=3hvmRmJSVu59D7dPFGOOhVl1YqcMQ2YY9rLQb0vNmtg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cc7z5nhN2zYD+1A6ezun/EC9Iu65e4aCvUORs4P2iP+gMP2TzFlsRNUY5WCqErOnR5ZvZq3Nvub44krEeZHlUTZrHVUD0fSTGyVPRgJpz77cO15IeUid8yOENFqwZDfpRnbe+Oikwl2YB/vdgZ1M4hjw30KR6F+BDrlnkurGujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKCClMhH; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKCClMhH"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e55b62640so29089185a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788293396; x=1788898196; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y4ZZsjHr6YcmyfH9QFDFfp3Q7Y6lQtp2VZjxy8udIso=;
        b=oKCClMhH0+5S2pr6rKlRT3t7MBpzacvtKUsSWU7Bby0YZxLvVtqQEPQ/5q1EBoCFj1
         uJ6fbGRu0+Yg8YHF8IklUR6GlWJkZh9HTAX9NIZy4295GfG+SwBHIBdyqlkLHs/R4X1+
         N+Amre+NhzIrHp9VzlLiJDMNw4aYos2a0VQKZ9+VsGCSuljQF6GtgUuJegAYuWof6LAN
         9bYThURWnXCw9TJn+rqXbKK37Zm5dxNdigZfhmqKatdDmdHDh3hsf8dBRzEMuW+Z1gra
         jCH88WE1kz1Mcdr09G+x76YdwgXd1N4uFLgAIZO5cTVx9vBss+T/lD0DY5f4n3WU0T+n
         wRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788293396; x=1788898196;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y4ZZsjHr6YcmyfH9QFDFfp3Q7Y6lQtp2VZjxy8udIso=;
        b=cWIjlfxJmfJr0bk4b42oe+TeOQYMrgsYlkwxbhIeg7xEvBdlusXzqiO62DMf6fpTsz
         W+WgZZtuHH5ATsnWkYBCgjgVMXljHvUJl6tiPmHzPNEV8QFgdal++ruzCuKXaQaGWcMw
         MHQiq5D/1qj5mrHnUpvHmcpslQB/8DnsqczZco73qkftO2OPAi5bArt29bRSZYtig6PN
         wagP0O+UkR6JPuijSlZBGXFiV6YfTqIe6s8FSBkXkVqsnGhuqt1Hvwo9U0bW0TSJD5l0
         NvhE1tUn6yxzWbJ/HNaQmi7grVGBsJM/4m1Wgh18h6vME9HnuidwGF/Ti+BwXyvExqR2
         V+rg==
X-Gm-Message-State: AFuF++lldM0K14eSy3KxNByn6N0zrFLnaWIJ/YzoFFybrMTZr6uM9nch
	SROIVnjf5HSY+9QMpb5MRquPIzTAGY2O1t+vgSWtrz4rIpnPgVQr6YWh3qqRSw==
X-Gm-Gg: AR+sD13jnWKXHMTR/cuN1puVl6dchWAvCdjNJvGDkbCSBVZDedxmtYqRRdwLGPCLgAF
	W5tVf0Oy9099334NWtu82czYZY1zO26uKPR3+KtykYmTC7BTQpwSb3Od4EjzU9t3AqGYVqBOqmJ
	0wQnQ2fI+6YKcFQ0qr6KM6hwHg7sGKFF1T5Rl/m5G9YnMCXMWVMAZJcuPHufnCTWH547i64wDrr
	tM/5EfyjLWDBZp1nuOF3I91YHpwprQaW88wkHA9oZrSeEDZfEnz4WxF30F9NVyysBXVApZ5Xjih
	AYljkZlwgEtrYE78bHtkElu2Pviz3u+cg2LeCVzwk7VgKHGzPFdWvKkBZa0iujgtTskTNxbbovd
	o3S/hJWdq7O/WgffCoTkEKGPsUhKpURwSkFVUxMl7jEJvfp2lgjBrTOEKg+M1WYupOPks+de9dA
	Wn2bFwIp2rcU9opunExIDqzk3uir5FMpthKPTx1LSo0AuZYZ8p8imSUKwTTg35qlMQjnxlGw==
X-Received: by 2002:a05:620a:6e1c:b0:939:990:c943 with SMTP id af79cd13be357-9395ebe7a8cmr125370485a.32.1788293395791;
        Tue, 01 Sep 2026 13:09:55 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.101.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f1876f1sm24617285a.14.2026.09.01.13.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 13:09:55 -0700 (PDT)
Message-ID: <6a973113.f0689485.10c6d1.4c12@mx.google.com>
Date: Tue, 01 Sep 2026 13:09:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5045037245298755536=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i@rong.moe
Subject: RE: [v3] Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
In-Reply-To: <20260902-btmtk-ryzen-remote-wakeup-v3-1-8a733d0edd7c@rong.moe>
References: <20260902-btmtk-ryzen-remote-wakeup-v3-1-8a733d0edd7c@rong.moe>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5045037245298755536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155578

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
VerifyFixes                   PASS      0.58 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.28 seconds
CheckAllWarning               PASS      30.10 seconds
CheckSparse                   PASS      28.72 seconds
BuildKernel32                 PASS      26.31 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      479.32 seconds
IncrementalBuild              PASS      26.71 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform

1: T1 Title exceeds max length (82>80): "[v3] Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/682

---
Regards,
Linux Bluetooth


--===============5045037245298755536==--
