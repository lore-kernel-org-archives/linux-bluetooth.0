Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8035972
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414512; cv=none; b=Eta00A01jq93tVarEmqWH01B8fmPAXD3C/FHUvYzD8AHXeXRo9L5Mg5+3sGskP3rzovyzxFnW0mb1QqX6w5IFCQR5209WrSwnawuijAS+TBaowrZCcDZWZ3OyV8LhlyJfYK9TXlB9zS0646zDtODQUZmzYwQAhlvs8FOXw+Z/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414512; c=relaxed/simple;
	bh=U/k8jKmpkWTYI9Xd4lb9azuuMeKQUw3KhMXa0WqmwdM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AM/93IM+gH128JosjnoHJrS7B0XyAgix/ZyfXv6QJNS5Q9mz9IPN6HH11f3mFT2h58PLG1giUbBGQjl+IVTo4FP20D78rec6Ut8auCXT4Z35eAtutyDEO35/mP0bAw4Lx+qPKG6e1YLk0eVGJDQPfIYxNU7X/Xaaqg5dMa/swlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIJ0lYbs; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIJ0lYbs"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so12826955ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753414508; x=1754019308; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jA5Va0wF8JZ+okakZH6JNuIMxz8khrVgLtKoU48Iw9U=;
        b=aIJ0lYbsycVzs7TB55pzuARLBPfZOqWCJgV4dxz19jocpJZ1AeV9uuVgLKnUGI5ic+
         iT2gZ/QkLs1oN00Mj8s35UI7PBDotnNfitCYdldpY7xgaZN5pFFxWQPHEPLUPX42gEZb
         iZVAakJ9z3HxFnLgD3aUtm8JQODrh2AZZb+6jZyRwDYe+J8/ndmXqvcDwnzSPcxLflQM
         PPBL9d6rnsjwPQMNgjIQML3ZEnHnx09JpkXnGR5uFQZfRAkXmE7mbm2pZIByP3KyxaxH
         8lE9h+g0+5tfWKRxTSzZCXLwybCJiAIHl00Qc08jQPXPRPVyVr8qA8D/RkOlGEDTtPhf
         K19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753414508; x=1754019308;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA5Va0wF8JZ+okakZH6JNuIMxz8khrVgLtKoU48Iw9U=;
        b=Dl8q8Yn9WnQ08JdkRzo+tX0Sfu21AoOGTZ1c+KYt9kRPznCHNzCr8QDTUs5ev5UoOP
         U7XbdYqmkaRIRImC+FH0Bs+tsQWNy+K6SdWaou2EdfgZw0bu2r9/FYu51lbEMVrlmh0A
         FL/AZCSr1YKtwgIGUaCjfhfHiJOuN17XqF2JaNH8QlJt73m43/Rsst632jZCia7SjIWc
         wtZROyZT9e5RtSQ7SrHXQk0AXHtKHFWcm2L9ydM6oleXf3Ll7MeXaCZXNd7FIs/Kv7oV
         6bctJgKY+iGgCgfm7gEFMgznOETsoBZ4LJElFeUACHkmUkq5hJyVmdxS/mt9E8J9syrQ
         TKCQ==
X-Gm-Message-State: AOJu0YwpfhM8dP/U3uxVx4FFSHvEHqknngvBRikb18sUlQqjzEG1gqkv
	ltJ0aPyj4dH21+JFPjjR1QYZPmIM2GLut95OeUeBUcwJzuJF5fbZMpftCcFHDw==
X-Gm-Gg: ASbGncvTnL7aDxJUz5SxpJwesC5oBRR7D9X4K9i9zNUIbDV+cNE0jRJ7BUo5tNmv8lA
	PRbBDwUUHfv35oHBhdzND6pGraGVRURlEtmL1EjSKAHpn2LDP4yamFzfD+BbIpdPMkmc2yrkDxQ
	KyT1KEhysXV8yz2XeUY/E2HUNXcVJWIZfqgJo2scBP0aA9xzFDsi9OjaHTwiIyu7GxqfE8RSg08
	hSpa+u/CVsUBisF3Tc9t848o9zwJhjlKespRzHgXB4BrLoJtSQ/kVeehrNDK+p8F2BqDSOTlZzN
	jPJ5Pxn6MdM1/x10V+REunvkvYbEdFaBASNWUepWmyvx3CC9QW9bEqiq8n8Q5jTGQnGyTBrwD4j
	Wug6Y8qWVzyuSIdiCSOPDIvr/4G3Y
X-Google-Smtp-Source: AGHT+IGREd5kk8wZYzKcYwshE2ypxGzwpTLSraVVWvlKnkGppjMOzlatGumSjm4/dmcTKbXViH45+w==
X-Received: by 2002:a05:6e02:258c:b0:3e2:9bc2:8be7 with SMTP id e9e14a558f8ab-3e3c52e6b0fmr2488485ab.10.1753414508438;
        Thu, 24 Jul 2025 20:35:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.139.83])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508aebf91e0sm793517173.102.2025.07.24.20.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 20:35:07 -0700 (PDT)
Message-ID: <6882fb6b.050a0220.362fe4.1353@mx.google.com>
Date: Thu, 24 Jul 2025 20:35:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8585759768029222984=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel_pcie: Add Bluetooth core and platform details
In-Reply-To: <20250725033134.1351301-1-kiran.k@intel.com>
References: <20250725033134.1351301-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8585759768029222984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985792

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      24.07 seconds
CheckAllWarning               PASS      26.46 seconds
CheckSparse                   PASS      30.81 seconds
BuildKernel32                 PASS      24.47 seconds
TestRunnerSetup               PASS      487.14 seconds
TestRunner_l2cap-tester       PASS      25.63 seconds
TestRunner_iso-tester         PASS      39.38 seconds
TestRunner_bnep-tester        PASS      6.02 seconds
TestRunner_mgmt-tester        PASS      129.10 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         PASS      15.17 seconds
TestRunner_ioctl-tester       PASS      10.44 seconds
TestRunner_mesh-tester        FAIL      12.35 seconds
TestRunner_smp-tester         PASS      8.97 seconds
TestRunner_userchan-tester    PASS      6.25 seconds
IncrementalBuild              PENDING   0.94 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.677 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8585759768029222984==--
