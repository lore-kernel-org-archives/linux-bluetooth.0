Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA85223DE7
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805275; cv=none; b=h83OptQ4AlcsFQ4uH8Xf+W+z/hBe53FIg7+9sdPaJXLUK27ShqZHnndh2+nmVkg3LU/1N7wdJ43h6BFItaf+fuss+4iWwoYe4hgGmN+ZwmloZwJzvVuuSIlfftfivXKaCDMTfGx9j4AAaaKqPS8c6/nlXgs9i573ipBdcLm7q3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805275; c=relaxed/simple;
	bh=snrXB6Ob1KKDbXxaiTiukE6OWX0rQvg70ZRbpytK5Ck=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lG1r2RkYvOXiX3qAQSEYvsB4eK1HfM0J5wRNPbYBlMZZcizdnlNA7q+SAjvQNQr9tSyQNx1yiMHDDsebQXF26nbgXOdaMKP4rMKgovanog42xVrUR8FMBQ5p9HGHb4ulO+HHkOyZK60yK/pdpveak5tyZd+uuyrp8LZEnpR6ZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt/8XMz/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt/8XMz/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f255eb191so1332790a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753805272; x=1754410072; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XHTL6S1tgOCcCdBMIj3v4Na7RelVn4dk0Usm9rPv8JA=;
        b=Bt/8XMz/Eq+V7TU46hSpUJrZTwF8IAVDclivaDMBaheOhBtxvsB8tq50Vm/B6gzegn
         yv2ul0tccWKpse8hcgdoIjW0+qZfVTOHDs72AMI/BEGCuKDJGUSmqMhDIsvxz3wVwUuY
         GTU3uQBoy8Pao9JIr9aORWlHmsn/ZSmI4ak/h7p+E8MAKwdJslYG9FMkJgYyshDarcke
         FpZCH0tS/Qx9en/wFfUNhaa0RXzeITIguNP9vT+7p2eOT4jG+iZXOEXJ7i7DA0z4Y8i/
         6tPUM4+zSAst9cJGjX/4ZcHQUZpWNX0UgDS3QnK5jX3VMTwODrwr1sanDjmgNcmhn8+I
         Lkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805273; x=1754410073;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHTL6S1tgOCcCdBMIj3v4Na7RelVn4dk0Usm9rPv8JA=;
        b=Wu23BMX+lGpAQ0myv5vqGJ8DAG5t8VCEi/hjBCUzXM3yDwtoKIjtPBPuAqcEWbKZp+
         V875CBNXhib5qzT+bYt8Ov1ldM8CGkc7mFX/am7Awr072t+nQsp7Gop7hKtWgzS5VDkw
         HObdIvnoRQzS5EzcIdskCCuOzuBQQ0qTPyZEiL80yM28qq8xribFt+qT59k280f/NXp6
         UDcRmVyPmkZW+kXhrpyzIgckAWQFGUZEx+Y+GTDHDWM2d2AzIpzo8l1MClqcbErbysTc
         VXLos6xwxcfkmEUnlrr89/rgwHXH1fPO8WCtwmtB+ZcDQ91GFHSHO4IMRDByvqzKFEx5
         fn8Q==
X-Gm-Message-State: AOJu0Yx/MgSIhq7Cg69wbsnmqggsDCo0lH+8PrWkEw8zYIuGDOJkZtZ/
	gkjsC8QNqg+ZP8p47C08yDVTmW4/E78gfNu9xXvDk4yLTQxX8syv6TyDP5u8Kg==
X-Gm-Gg: ASbGncshkqdOcMtdJ01s+eWYQjU+b5C+03HuDr0dQquYzRsl5KBYtP8N8Tbj6jRiuas
	+bfnKGvVHwGIqWXZBhZJBxvyzsyf7WAbFVLUz5wlq3tdV3yD58grzPT/TzGzyDG1xiivtjMqp/j
	EuzhhWALwG48jn80wWQGK+6jPnycYbmodWk76MptuLauubdiw044xznDvNS8HdH1abdpu9vHAwj
	pDQqWYeaZQno1BPJZ61bFs/jQGI1b4uf+596Yqg7OQ98YqeQZnVW2LKZcnExNof7cgq0PKHPpIF
	N80d8Aii5nTZB+6+Jpx/B27NTrFBKo9w+przUbHk5VQUWV/o0OwptK/eBH8S3bsj3JOIKyhxYFi
	iDLMxWsDKu2x59yFItEGDpybSsVRJFQ==
X-Google-Smtp-Source: AGHT+IGFU7dxKs140MzJuoU7bIZEl/aAL4m6+Eeb7aav39U9WHGsXWsgqUJCsfUG0yq6YIEhY1e1AA==
X-Received: by 2002:a17:90b:4c49:b0:31f:4aab:3b25 with SMTP id 98e67ed59e1d1-31f5dd88fd8mr96595a91.1.1753805272457;
        Tue, 29 Jul 2025 09:07:52 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.11.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31efc2f579asm4924717a91.30.2025.07.29.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:07:52 -0700 (PDT)
Message-ID: <6888f1d8.170a0220.df296.0605@mx.google.com>
Date: Tue, 29 Jul 2025 09:07:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6242677706991983389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: Bluetooth: btintel_pcie: fix CONFIG_PM_SLEEP check
In-Reply-To: <20250729152743.2394727-1-arnd@kernel.org>
References: <20250729152743.2394727-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6242677706991983389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986771

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.37 seconds
CheckAllWarning               PASS      26.83 seconds
CheckSparse                   PASS      30.58 seconds
BuildKernel32                 PASS      24.33 seconds
TestRunnerSetup               PASS      485.71 seconds
TestRunner_l2cap-tester       PASS      24.99 seconds
TestRunner_iso-tester         PASS      37.95 seconds
TestRunner_bnep-tester        PASS      5.93 seconds
TestRunner_mgmt-tester        FAIL      128.69 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         PASS      14.76 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        FAIL      11.64 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
IncrementalBuild              PENDING   0.75 seconds

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
LL Privacy - Set Flags 4 (RL is full)                Failed       0.278 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.057 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6242677706991983389==--
