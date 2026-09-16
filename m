Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847D481665
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556077; cv=none; b=tICElcDnRs5n+sPr6l2/E6d7pzGEKno3J16vCf62FxtZ0OQjl1p7ter6WLnShwQCM5iS8n/oXAmbTqQfHfpWv7W2O4KrQLTvHqgQw3zm26snQmkcgpWbqbN9aVfXphSaCeQ4W9+0wE3TRl+0nlMcTwgWAbDwZ6vyUFWG12giH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556077; c=relaxed/simple;
	bh=ovuz9WpigGgKXl3HNoP+6mI2BZ5l3xdh5LHPseexCz0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EZwmG45ECGehwrfT3IJF6KrZge9Ds/aUw+lHxDLh6OULNlIbvY8S9snw36evAxq0DhdRLJLDqBzBjMfnH9Rv/fJc/QkTKKii2tuINI9QqTDV2N0umQECiADNisgIO+e5I9W6L8VGU+HRbCwEQ5JbGevJoYr3VaKeNZE3sCoFHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1hQXKip; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1hQXKip"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-80199394f52so494817a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789556051; x=1790160851; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zulfadzv/SnUcYQDwaPiCgRbJC+jSR8d09Sz2c9lBcA=;
        b=o1hQXKipCwoRO7lO1guZRZcNRhfxpA2nVGF49klUcmcJxpbAAgIeg2+jiipVnVL0cU
         bRb4cyG6GUN3bQWoHby8zMtyCnndATjdCts5u/GZxHK5S3Q+Qo0sNi/b8z4Tl2I1mkBd
         mEJ/tVlincrvTGhGNTV8vsJHV4wi0QeZjIuT9JpNhIhVpRLjJW6tqcD1gn/RsPBvym/3
         /Iq+ECEcP4uSTSGwGsyqCKuF+J4wKnCIYJ8BWU7YOfcatD/HcWWg315rjOCtFdC/CWYd
         FJdE5d+dGjaX6FUg6kZmyZInAnCEmgWaIvPayve8PH6Vpfsdx2vOHMahxMQvSp16SjyD
         8BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789556051; x=1790160851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zulfadzv/SnUcYQDwaPiCgRbJC+jSR8d09Sz2c9lBcA=;
        b=jecwFgsqK6Rit3jS6j4oN+x8kULpEm6N+1MRHPWkONyYMhMSZ9r4FOzNE8PN7ecXja
         CzbpisYse/v0jYmIG/hiSlTl8yHUGq6aWGABZTDQtptxitaw8T8RzNuDzuTKmoeWAH+9
         CHG+mdSoVKR1qqCmQYGoRUMrVCGDCBGXLLSfGGTqyA+cNoScHHBVe6etX/ThboYacLN3
         A2OsSA5rZTsMYluazsvFgrWpGhxuTCkLO+P8AQpqAr6gP62g/f6B+j9wvkg7csLpt7iQ
         9y+NUd+cSK9Uv/Eqs/wzZUKXErjUu5LShLJIXjusrq+uQhaBCVE0tqBVWijICfGrvFi2
         nEIg==
X-Gm-Message-State: AFuF++nrMs3CsRkmr/DzjLLgY7UVOqdrsTE9YZrb2FZTiw84/eG/lsmx
	TXMtYXlZ+faczEJp9lMQPeksquSdq6FxxRyat42evXC7W0iQUjKHng7O/Gw9iQ==
X-Gm-Gg: AYBFou2xvCHNCEUAeVzEnCmCSRmgb2YL8WeS2EPmvuyAWTWZrRBx7gaAw4sC9dKoGKJ
	dQofe+kLGhmnrZISxYtwAfN2QmbQDPbtrHo6IrTTnXQonuuEX/k+U7p+9TgGlnhqR1OR24uEjw3
	XSJiM40oG2DQ/ccy6KvCiZmMMNYCK45jh0ViIFYy2R7IH0HDKrS8OiURpwfBnmuxDmfO+T7uJV3
	RawUEgqGOLaO4sLHmzd5WN14Ouprr47IWRgW/xwnWgq5+PXqN6UA3z09LZ3XAMvtuuD+j3axxSs
	Ln7lfrToOjHEaOpqkueYimqQVKjv7ytAmYMAUmKKs58xE0sEbHrj2SldmUldymazFIS5alUwvjt
	iQeLHmOSwMIzjW4TF6EUCQeU/MSobsgoKcscZrcp91ODVazLQTsYlnozgZnT6xA6RuWlTs5T08u
	NGSbYYllTKNxMeeBFj76AGjBJ+F2ymxaeSaqP/cW8LzqvUOsBixfXI0GHZ7HLN2yNuru9VjoQkA
	rD+K65mBJPeO5D3q/8=
X-Received: by 2002:a05:6808:4f11:b0:4b2:8ee8:8a38 with SMTP id 5614622812f47-4ca46878257mr2814169b6e.0.1789556051246;
        Wed, 16 Sep 2026 03:54:11 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.224.121])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ca23cbaf6asm2082342b6e.12.2026.09.16.03.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 03:54:10 -0700 (PDT)
Message-ID: <6aaa7552.8a922079.27013f.aa03@mx.google.com>
Date: Wed, 16 Sep 2026 03:54:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0853872518138574674=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: [v4] Bluetooth: hci_sync: pause advertising for the scan address update
In-Reply-To: <20260916100206.3062073-1-valentin.kindschi@fiveco.ch>
References: <20260916100206.3062073-1-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0853872518138574674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1166333/

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.71 seconds
CheckAllWarning               PASS      31.65 seconds
CheckSparse                   PASS      34.36 seconds
BuildKernel32                 PASS      27.89 seconds
CheckKernelLLVM               PASS      33.42 seconds
TestRunnerSetup               PASS      726.62 seconds
TestRunner_l2cap-tester       PASS      16.64 seconds
TestRunner_iso-tester         PASS      44.72 seconds
TestRunner_bnep-tester        PASS      3.09 seconds
TestRunner_mgmt-tester        FAIL      60.30 seconds
TestRunner_rfcomm-tester      PASS      4.40 seconds
TestRunner_sco-tester         PASS      7.56 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        FAIL      7.81 seconds
TestRunner_smp-tester         PASS      4.30 seconds
TestRunner_userchan-tester    PASS      3.14 seconds
TestRunner_6lowpan-tester     PASS      4.36 seconds
IncrementalBuild              PASS      26.44 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.019 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.462 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/781

---
Regards,
Linux Bluetooth


--===============0853872518138574674==--
