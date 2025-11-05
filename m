Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721072F9DB7
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347087; cv=none; b=E/nEYO8AtExqcwZi3o7+fPV2hI1vORSol0Mb0Lcnn2vF858F29Z7D2ebwlZ6zp5WkpCjjZ3XL0BosFQLyWcGMmp5pSxbWJFCZEoGFUeNanO3hWIFqe8bZIrs46DeejH2ZlT6zW9ebCFzkpDjiBG0o93uQYrxftkVl6bQTZaMPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347087; c=relaxed/simple;
	bh=nbVz4I/04jfMd42Eu26atKBswUEVQywT1uZFCxPht6Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GVbLaT+xebl79wJcfyeltxdt/AfzDeHqWCGx5i1eKWA8YopWFrDtDE+BFNiNUyylHJXPJvuDLqj0eOFFuXEsi2azIDzdtQ2LrAnbxrDHPCjAKiPH16KgkQ0WmkU6sq5IT4v6lm7/1IKgg3KZPA66GIqQq4fHBc0YDkLurHJwwVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTRGR1RH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTRGR1RH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34003f73a05so938637a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 04:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762347086; x=1762951886; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rj841m/G01iJKYbGC66zwflnQBC3eNdJJH9bnQjAG9s=;
        b=MTRGR1RHwH8oflr/c15Ko8VaOh3BBKVsXQ9OR3O5IVEEXmPWTRLJ0A9b4MMpQxk0Ng
         iET1Sq76wwIng73JvygS7zOFuoOxl/UtV+YwotadWskOfOGXm+UnggS7Pz+XgK6UNuM2
         k9og9mB3TIHNd/PolLOowtC3E81GFs5xJawKbnNktzzwTQPfnWMIFZqb8/05+Wt+qvzD
         aOpiIZkYFAG18uljKJef4z7tp5xFimpMZazuWkGGKOOSupK29af2WgJnjXyc7CGeWpMf
         95pv7OC3paUp9IKf5kL/XIhKKsytjZYegVkOoyhdTRO6s/l/ZRMtM96DrlL4YKN5Y5Nx
         oxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347086; x=1762951886;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rj841m/G01iJKYbGC66zwflnQBC3eNdJJH9bnQjAG9s=;
        b=wgw1EFCRGzaN3iphM9pkPjOB48gfEfciDgUOFWNdCKGiRObWoOzLchGDYQkTbFxfIK
         EW9woLH/0raIjweR3SRcfE37H3s8W/hYsE0wZT22yTCH2AiSEfJpssFLCwSj3RT0mpOy
         yc1MsQfkdyZ9EqfEmWzW7Ecx3PH5MhnYubu+WHMFOcvNeLLBbVAA2CVVcyhuj3pWPwP9
         TU6OX6Sfd1rZw5QtuenxdixPijjGbamFBYdI2ccdwLiHAmgpRQc4euxhHmtrHCX1vC7i
         q/Lh4SbqZj91hAIH92tZ/FkuuylNbfM9t/UkuygvUkCmtbd4EJHrtl7Pu8iJvDSeNS18
         HLrQ==
X-Gm-Message-State: AOJu0Ywk2L146yRXiGyRQmj3qC4NTTZPbh7r523VRFMDW24IOLWO5dCi
	PMY70q6MNHMBM8j4+X4G5CdqBKvQAIQaxPDwWo9Vk+HQuvVBgkt58euvIPLjtQ==
X-Gm-Gg: ASbGnct5GKDEjbHHCO2uemujRkq91j8gmFzMt7v/BR5o2JAOvn5tCqi+limLA7/fzHZ
	5QFJouulfGM67xXMA3lH8+HvBWrq2UaxJQkIGH+BxgJny1+a8S14x1loe4S/NKlfrDuUhueptX0
	7lWihJlpEQInVLagHDiCtbtV2OwrSaL5Z3lVX4bzA2Qwy+EkjGP0VEVBVxLOzQBDpin4soGEZp6
	pNsP7JObNLD+OASmgaCeSo0D4SzZfoMaGbrZDIydhULio89W8kcU8npyAmC8TGhS2Dj05zC9EUT
	/Qp5T+SHHvdslrTEXhDgZbgnS9j9BV4bqIzIT3v6TbAZck6h0vfSTIhCLVd6F2ERhNB1Y/08EXA
	3tVLiUxpM2YQuYPqPsqzjlfFJ6zawLXdk5lChmggifSbkAQod2n7ptaakKthjb6zEu39ocjyHSf
	E8Zdc=
X-Google-Smtp-Source: AGHT+IHwp8dx/Bc5Jbb8KRuWdRD6a7Hml/mdfukFftOmmQGnLV+11+jvJepIT0r1j0lmfGI3SBHMrA==
X-Received: by 2002:a17:90b:3842:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-341a2e4b286mr4119809a91.15.1762347085430;
        Wed, 05 Nov 2025 04:51:25 -0800 (PST)
Received: from [172.17.0.2] ([68.220.60.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2987e95sm5434615a12.13.2025.11.05.04.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:51:24 -0800 (PST)
Message-ID: <690b484c.630a0220.1dbdfa.629d@mx.google.com>
Date: Wed, 05 Nov 2025 04:51:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3267582310291762948=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v2] Bluetooth: btrtl: Avoid loading the config file on security chips
In-Reply-To: <20251105120204.458231-1-max.chou@realtek.com>
References: <20251105120204.458231-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3267582310291762948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019859

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.17 seconds
CheckAllWarning               PASS      27.24 seconds
CheckSparse                   PASS      30.83 seconds
BuildKernel32                 PASS      24.65 seconds
TestRunnerSetup               PASS      492.14 seconds
TestRunner_l2cap-tester       PASS      23.33 seconds
TestRunner_iso-tester         PASS      95.34 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      118.52 seconds
TestRunner_rfcomm-tester      PASS      9.09 seconds
TestRunner_sco-tester         PASS      14.24 seconds
TestRunner_ioctl-tester       PASS      9.71 seconds
TestRunner_mesh-tester        FAIL      11.74 seconds
TestRunner_smp-tester         PASS      8.40 seconds
TestRunner_userchan-tester    PASS      6.38 seconds
IncrementalBuild              PENDING   1.11 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.380 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3267582310291762948==--
