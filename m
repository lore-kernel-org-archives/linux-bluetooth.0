Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417B351C3C
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588927; cv=none; b=lJJqyMrh4shGHrN2yxxcY95PBLzsOoVyLEsDB5vd6ugIlsobJP0bzTkRyk7BvzvNYLy+L3uf3fD8bE+Ki3ss0UnuWPC7sCtzoAyrQeKQldT3+2F2DPFDZnrc+f66v+IgVPkUeKUGyuZJn3qnJ+wTJbAmvlJdD3MMd6rgrD7vOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588927; c=relaxed/simple;
	bh=1ZdwMZl5wgLiMr+vkNA+FBgsX8sYoDIWtINXmxR8LK8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LMNq442hPQ7OELbm+YxZh+oEooC7HjhkLLfkrE0AVsbHxWfFGBFlKfFZouksUvcV/nClU7UCdALTSHGF4ZhK2rss6VhhvghI0WROkqxR20oJb1vL54gPDgGJhyQwJ3JywVNKkXfgH0/mEzfrVmK9tNqohKVF7sAkCeJu85hwlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVxoK81V; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVxoK81V"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c08df8513so9451611cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783588925; x=1784193725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t/cqQV0M6qAyKLDwpc3P5mQU52epGW9Pg6fD27WHqxA=;
        b=SVxoK81VzZoylqOoifNnj4dXzru1lLXNopl43/bsvXceDg2Ewpma6+3CGJ09dtZ6Sp
         +0/jdwQ8OovvA6itGTWUpenkGzyu5CzIuL4w5Co9C+2ypoUcxLiGsdce14S/XIUwhuuh
         4huAHoO+nwFAkVztAazdPyQtsGKdGWdsibC9PhmFyL28NWU8esyYVBVFRcfvlpgb0VK9
         I4+rbSk7aj6qRww/i8yXRfHCAAyaY2zN1+Pzf6Wgbeg2BazczasQHcsh8twW9Dr9hJUg
         piErdrgSwdIWQxivBWMkmLtocf9IiNOZ/7j/NucMpruLPVYoeGSmmQlcNhI3beJ2yuXC
         rYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783588925; x=1784193725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t/cqQV0M6qAyKLDwpc3P5mQU52epGW9Pg6fD27WHqxA=;
        b=OLfuOs//BFce2tM+xYPHyryIHoQUVXlw5Fx+xXf9881x/zRqqKuUjxaVgi780w52NY
         No+6r+miGzwen3TGwNEF/Kb9ItHDvXFEYgDUYJ+EbwYBLIOA0rocfCRn8P1uXGiOkpT8
         5euwK3rfnREyMkQeApYr783Am0xlnfy8/BKJgSnj5/Gp/RH7mUAoBIUcY3osuV3Jw4kQ
         bL6bo8DuSMIGsKdVew8B1QkaoOlOSCPbHZFPVTUAmhNhmnwe062Q34ZrtoiTimDR1LVf
         GsQfnfLrwF+uTnoDe5T4ZLH5PhxuOaDRYnWcI8/o+D92SfGQNGNVHVwujdFHZiyxhYco
         44JA==
X-Gm-Message-State: AOJu0YykqU1SIqjOPLFwpcsrkzVxQuO8bpzwrZDPDZYbckhaLq7LA78G
	n+t78OFpXU+AZniEkw0E006gfgmCIBRYkTnGu/ASMYOXTQ6kvRz4B5mRbITvnQ==
X-Gm-Gg: AfdE7cknf2dF5feh/6Dw54Q/vTELvyRkUrmP2+5BtHgC2lYoXQ7IQHPKu4eI1fAR3Nl
	TfddWShBp+T1SMP1EJAKYhNmVeKwyxzDTJuXLo2npfBgEu1mez3OYYHxQPIxQhPafgBvB6uv2dC
	wBpL9x+DACxZuWmusQlYO7u7ZqOdIPOhG0PPgtm/xA2urNPw1tTVmijhAloa9nSxvXncbXHznAE
	9wDqgx0SOumH0ZuN0H2e8nm9pSqEeciRIU3U25PLECSystqi2nJjkv5W3acRhgRWO4RZ1v3cxYS
	zd/6BcVaAZZQfQx+FLQNIOSXmQAv2erjOWtEN3RmHukVllMHZSLfYsyW4r15fnidOoJlr4tRD3y
	QsJS3mO2poqw7//8Smc03uB5gAHQdq6k5xYX2+df1WBX6zFSTPPaqeqCpDwbbHuMztDzRuKEZwC
	p6Ihd2d5B4F66d3r2X8bgVWg==
X-Received: by 2002:ac8:5741:0:b0:51c:7b12:11fc with SMTP id d75a77b69052e-51c8b4214a6mr76908761cf.74.1783588924684;
        Thu, 09 Jul 2026 02:22:04 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d688sm162592111cf.17.2026.07.09.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:22:04 -0700 (PDT)
Message-ID: <6a4f683c.344b9575.13590b.baf2@mx.google.com>
Date: Thu, 09 Jul 2026 02:22:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2472925334944508451=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 294305068@qq.com
Subject: RE: Bluetooth: MGMT: Add length check in confirm_name
In-Reply-To: <tencent_3C5C860091EDE98DB4B649EA03E82587A607@qq.com>
References: <tencent_3C5C860091EDE98DB4B649EA03E82587A607@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2472925334944508451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124368

---Test result---

Test Summary:
CheckPatch                    PASS      2.59 seconds
VerifyFixes                   PASS      0.18 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      28.05 seconds
CheckSparse                   PASS      28.63 seconds
BuildKernel32                 PASS      25.20 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.03 seconds
TestRunner_mgmt-tester        FAIL      208.06 seconds
TestRunner_mesh-tester        FAIL      25.12 seconds
IncrementalBuild              PASS      24.14 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.128 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/416

---
Regards,
Linux Bluetooth


--===============2472925334944508451==--
