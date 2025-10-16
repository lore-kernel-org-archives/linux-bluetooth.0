Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEB24A06D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596925; cv=none; b=Wm4czvMKn+DDU07PwzWycob57QTZkb9XL6ub2ITMXsEcbWlKJ3JFnroo87VS3EIX+OD+ToE5xwfKWjQ6Z+8d8breZhDkd5EU3X/9pB4ZsyQEACZQa06/o2l2wOzw7O8TcTYDPfq6TaoFnFhhzM1A3sqAeRqPum4VkLDERmdr3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596925; c=relaxed/simple;
	bh=jlBVib1g9oNtIrmPoqp3cCSNOvlFaUpXrvcjfUGK/Ks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IvDAEt+mtXMprdxpWMZqGb011njgtGs9PaLpgrJdYrsV20PwORuMLL+eAunWdoSBY3ux07y/NM2+ibNSTagl3dv+RXjAZlkVreBs8J3+XkdCiSL4fw2OdwtM8C9dicQIXz7/4y8/sf9R2TS3BOnWQMvt67F3ykcD303HUXHC7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H24B6BbR; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H24B6BbR"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550a522a49so303648a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 23:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760596922; x=1761201722; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MWeGi8BGa298I2VSMgIupxGZfJdK1/p/GAhCbq3HElw=;
        b=H24B6BbRXxfQqed982HCFTr4nI+0A91ZKnHPhNWThKbU4sOVdiBHYCi5RF4j7xM6nf
         IePNgwXTxjH3UecE/V2Z6q08jphkWuvr/8qpzoBHAbQNrGLJf3ATj8E1KatLT3F/YJvP
         N8Q6SYHfDpUT5HTzC8lI/otHiUJZ08KIiIGs+bmnrljknIhw9gd5HnGvF17dZ7mmrURP
         NmcPtexn/ouEVj3LoBneKQDzTzhAh4eOz2x75VvN8NdGbOc/jzQ6gSCM3uZVDCzbajGL
         nmYs6eYe6den0VmAvWVtjvEoyH8TjlHBph8Zgf4yuN1+EqTGM+It9HwvUuOLr6phU+9K
         Vyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760596922; x=1761201722;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWeGi8BGa298I2VSMgIupxGZfJdK1/p/GAhCbq3HElw=;
        b=kQm3DE2huXdf1ljDukMnmUv0BounSKEQK9Sq15Qycwz2WtV0PeAPzlXumId0R61iPb
         kmc6/Z1xqemWxwbLMiqx4jXfDie/c7cLpryayJLyhXbCCxqP8+kau1B8RBbPeW2lWaBE
         5P1Qub0G4t4o6lOGP5zfa++mRRvirY9pLqevt8jh+P9B46onGZvlI+0flCv2pz5XZX6g
         XO9DLhOZZVEJqgrxLauOh9MWY1VKdYz0QDWFc9BSqnkmwQWfzox/7swrVSbKAMqN6/0q
         tG4FLj99KZLwaA+DchSuONbJaZSCvKRJSgnxXhRyy4p/lEeDPulZTx9dK7YS9kXGUgA/
         9oVA==
X-Gm-Message-State: AOJu0YwIxFtMXk1BFPKen9rXqM3qAvqM7Q4WsI0NW1yuqojSD2CiYhLk
	1fJm280iVlE4k/91C7H374DKje9iw9OB3wxjdVlztUTDgY3FKtj7AmERBFqbBA==
X-Gm-Gg: ASbGncvbaFTfV+9ZTJUfpSn0lhwmfxiu/NuI5wNnJ2hnrCy/lvSbNtAJ3bj5hTIwg8y
	eAYdXT0O47KAcqQXBKgi+JgQ0oPcb6Ve6TuQvCdmJDnj39vteZi3NPHMcBuwTIWglU/9+KQJtYK
	vTxVRhUA/426V9QU7Ost5iNHIm936riibBYxppmwIK8Xi2diEOIaKLh/SLy5FH7AmkkyNuS6emP
	wAvc9bqMtGaIgkKVqtPHUBdyHvK0SkInuXhTbmUv3JLL/pf4y3Vb0RgIk5MCaKZ8q/uR8T4LySO
	MxVYr/oiwcZDU0ByuC5QnA2z14DIey+s6rRxmrbNbQkMj3NMYbAIyuROWorQg+S+Y1dNLt2EZLT
	X8zjV7+EfsJ5y/WTrbagzOX7NpDGc21+cUv2O/7gCo1TvcfjCM5bOVl0dToUdTIQ9QjwGcYYckt
	vB2ivupsy3BAvLSlcupg==
X-Google-Smtp-Source: AGHT+IHCxkpwLm0ccoeT0/hG/O9L3WtvgxoOUk4DeQwDoR8g8gG/QCkEViThq8WHnQ0xrWcV+/YMTg==
X-Received: by 2002:a17:903:41c9:b0:24f:dbe7:73a2 with SMTP id d9443c01a7336-290272c1a81mr458293485ad.31.1760596922514;
        Wed, 15 Oct 2025 23:42:02 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.160.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099310a6csm18062085ad.8.2025.10.15.23.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 23:42:02 -0700 (PDT)
Message-ID: <68f093ba.170a0220.369d8a.68fa@mx.google.com>
Date: Wed, 15 Oct 2025 23:42:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4549020580643442297=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Add support for smart trigger dump
In-Reply-To: <20251016055755.2587652-1-kiran.k@intel.com>
References: <20251016055755.2587652-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4549020580643442297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1012167

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.40 seconds
CheckAllWarning               PASS      26.82 seconds
CheckSparse                   PASS      30.46 seconds
BuildKernel32                 PASS      24.46 seconds
TestRunnerSetup               PASS      488.24 seconds
TestRunner_l2cap-tester       PASS      24.47 seconds
TestRunner_iso-tester         FAIL      44.55 seconds
TestRunner_bnep-tester        PASS      6.18 seconds
TestRunner_mgmt-tester        FAIL      127.07 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.39 seconds
TestRunner_ioctl-tester       FAIL      10.54 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.41 seconds
IncrementalBuild              PENDING   0.69 seconds

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
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Pair Device - Legacy Success 1                       Failed       0.214 seconds
Pair Device - Sec Mode 3 Success 1                   Failed       0.169 seconds
Pair Device - Legacy Reject 2                        Failed       2.168 seconds
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 26 (92.9%), Failed: 2, Not Run: 0

Failed Test Cases
Connection List                                      Failed       1.066 seconds
Connection Info                                      Failed       0.141 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.852 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4549020580643442297==--
