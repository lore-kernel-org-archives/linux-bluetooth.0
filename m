Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0F405AA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541532; cv=none; b=AG2KYDulQcqgZktkfnyxGO5FzNEmSHaYjAreTkhuZIMf0QoeEV9TyEMEGMB0OlDJWWhoRsTTZdQxEEaO3dSGk7AYeQQ9xHkIrbGIxsFDxNdxgr0uoid9MlCqykH7nXDjnG1rMtkZLU0JRBSP02MHQOn8UBrgZ1zUY1w8JiPEo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541532; c=relaxed/simple;
	bh=zsUaw83lhsNtqGFhyv1ezU6U6WpFN1dN1k6P2lWpi6Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e/xCccMxumTS4bvy7NryAPLH0Q7WSYgS407iXC8sPPI7Sxolih0yBclhUmvkmldH26EAY1rBBGBHNgEZSiopa7xTN6S3baeiPD1lJk9vmVhejqBofcPYisGtJK4B0/DPXBcsVlwSgFM8WGL7fY2dSKZ3FYb+ejYbsUBKcLlRj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz5W5ISa; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz5W5ISa"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899fb2b94c1so13544106d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774541530; x=1775146330; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W7iBIo5K/iPWiYQ/r1GtW9yXWWja04E0RFyoXrL3ZSk=;
        b=Uz5W5ISa9BSYo7ncs0oS5/YC7IXzjn81VdNuneOT6xNhzdpneulnFoeYtrux0fte5P
         +9dOR6Jnj3k9aBwHIEU8RnU1xCYaLy9E+qX2YPEZYmGNPMDInj8z9JN1/a789MhSgyxI
         DXpRz/jo+hKJxvXS/PLmAVjrXOk44Hj8kW79FBwVfmwkeAB1IFZZ8QSYrBbkDs1ON+YV
         dW2kjOu2kL+0fqFEsH6g1+7yG/YyGECKu0KDZZcCQ2CdaswAcCbn/eUHJfDEz+u0zyKg
         sxFyrN2XMrP2wcxgkU9D6a8j5FlvzF/xrpPQO6Fu90wcRYhUjssdd6lEBwSywtCdWe0s
         WeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774541530; x=1775146330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7iBIo5K/iPWiYQ/r1GtW9yXWWja04E0RFyoXrL3ZSk=;
        b=assJKDXYi8ZWdHOX9jRuQKdT6B1RL5I3pLEc0o0POuKKSduoNTo0h8UohAjoTMbL4p
         Yh7dDsSa39HhkPHm4Xc4zgAXgPeypa54RhNM63aU4WWfuYO4FlFaq6K8xHbYPq0c6Cfc
         8oc3YqFb8s9MJfWk5MzPxxzzNx4JFh1GmRRRmQsDIho5FzesYonb5ZzDWzZma2h56hW5
         Z98cBZ34fb69Cc7b0ksk/+nfVueD6uLGhTKQYZ1Qntm1tDVqDMMC+nUaJuapLQIEN0dt
         +EflKbQ3O88jELZ1WLQbu4rCfU17aFw5ZqRRT+eWFRtjLmWupaJ/yxPxzlsJGkxpuKsI
         M+lg==
X-Gm-Message-State: AOJu0Yz2OEUpSQQ++mmuQw6fMxZ+raPa87SPBZjl6mjYStdyj0vf1/lI
	lGLFNCMg/LJ4zP9mraW34UzxmeYohQUv5TgeyRXsADOvXzVFz9O9VTmnV7fxVA==
X-Gm-Gg: ATEYQzxpqPeEFaR8jT4YI0pURKsfnC4yB0aS9Gsv2EkJYK+SDZbfpXvNTc1UqG7fquC
	cnGn5H+5qMLHujzeOq/WEyWgLF7VgSU+66v8IUSJXyGOuVWth1gDXh3/9t7Wih53Z1Ii7iQfXS8
	gNCQnEE/Y2qTc3V3ZoMJ7NFlOK1ggJVSxtM0RNOTwdJVunKx4NaRRt0PgRse3zM33/EOCxa34W7
	KdVMzzbfwU53Iwwr+mcKu2hQhvnkOt4yQF+c7xNKc/FJkuM8Nm/9hT6aZZhJjDO/G8dIMAN9ZWH
	Fbna3Vz6D5/uKJOWKVhQpVcBGxxk+WiHDjU0DAqqko288U+EJll9uJtF4JCQLMP/u2i2G4IJlWt
	wXG3gJblocX7Y8W16PWbklxh7Lu5LUu4IgH8Wy1Fj6Otvrq3i6eouKp1IcazhBt66K+nPbBFik7
	IxgozQvDOV9YAhYHyvme1/SofrWMXLtrhO
X-Received: by 2002:a0c:f104:0:b0:89c:c8af:34a1 with SMTP id 6a1803df08f44-89cc8af3777mr79470516d6.42.1774541529595;
        Thu, 26 Mar 2026 09:12:09 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.101.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd589a409sm26034486d6.16.2026.03.26.09.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:12:08 -0700 (PDT)
Message-ID: <69c55ad8.0c0a0220.3d36a9.fbbf@mx.google.com>
Date: Thu, 26 Mar 2026 09:12:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3371814335616289303=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, security@1seal.org
Subject: RE: [v4] Bluetooth: hci_event: move wake reason storage into validated event handlers
In-Reply-To: <f0d72bf42b33441991665b23e293c879.security@1.0.0.127.in-addr.arpa>
References: <f0d72bf42b33441991665b23e293c879.security@1.0.0.127.in-addr.arpa>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3371814335616289303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073007

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.93 seconds
CheckAllWarning               PASS      29.14 seconds
CheckSparse                   PASS      27.62 seconds
BuildKernel32                 PASS      25.54 seconds
TestRunnerSetup               PASS      572.12 seconds
TestRunner_l2cap-tester       PASS      27.69 seconds
TestRunner_iso-tester         FAIL      33.02 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      112.10 seconds
TestRunner_rfcomm-tester      PASS      9.31 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        FAIL      11.58 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
IncrementalBuild              PENDING   1.18 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.835 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3371814335616289303==--
