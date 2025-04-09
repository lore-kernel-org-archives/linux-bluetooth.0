Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591FE1D63C5
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191348; cv=none; b=GxKVBix1DhDNvqveIDE021cBykapZh8CtSk6yIMhbLFapY2TwIdg2Yf2amCD5ib514OE2Oy2FSTrEXm1LpkxuC7aXwsSEiFFwWsfhEPfkPxPA/sNvknigqzn4gTA5YdBTElHzsMZwxkbXP6ukOzTeML4gckWI3f6ETHxRd+iUZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191348; c=relaxed/simple;
	bh=f2k692oz7zfMTdANwUyW4hLEgE9j4k29ktxYtMYAYYE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G2BlbJLhndDK/tB+ivsZICXObRztdyIVW/iU87/hd2Woqymi5ftq/hIPzdAK+TdTukpXelf0sgjRsIgrHz4+bhtZvdHGjiA3eRsEfNwz4Ie38sFH/76GijhQothvuIM1VllLhsOXrCpMmusKPlsDSAv2Mqdl5NwFEiM00Gf7Cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfZl/sPe; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfZl/sPe"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5e2fe5f17so647689885a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744191346; x=1744796146; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kqCkVGyxBSQC3LGPk3KFAUZ4/oddCBH9sOrq3LHBxck=;
        b=CfZl/sPeJC8AlsOkgjbFvLZBZhomGrTGY3dp9/nyk8hGD1/xISVxqO9IGGXfhUtziD
         0vmbHxfQ2NK5z2o8bw12//sU45VyBL2enlk616oGFBzKK8V3BUy9hnzPqTBxzZdErOGj
         QggHHETljJjXNR6fROEjhRYf2lvWu0virITv86Kj8X96Oxao5dzYyszdnXRqyFC8AYKv
         LYY6v03D+SKgm6YpFAgCEE2ItD4CukfpyM9HuAczPeqoEM7yebJiO7V40E8zJQFOQx4t
         sI/AX2QctyfXk79hTxu7esSpjpZgG3iaIgYLqK+wXkKoyInJcT/uwXlXOR1BtaAAnkyw
         kCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744191346; x=1744796146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqCkVGyxBSQC3LGPk3KFAUZ4/oddCBH9sOrq3LHBxck=;
        b=EqS0xMIxSfJRVBNLEPLr15W7dAV14BB+MlQY2L1Sa0+XF+9qTQuFZB2Q336CbFSu+Q
         1zfxqcj+AFA0N0guxPfhcvJ+/gtjBQxWprpzLwR5ivmb5J6Rj58oEvYKuxkr9rGbkcOt
         LJ9hSkC5drk68ZGY4K5Gz6bDN9txrslkbGtuC1h/eDs2O0Gd8ZBZfnXczn7dKVVpTCck
         5JhV8n13OybX5b68hOAlMptiOekNJsQpRzV3j/I15uJyDJHabpKGs1GHAXruZex9sI5P
         UIfkGbIn5+nz/xy1cprW93xYgjqaWq8wcL1tD9bOsIDN8ZshObdppVo8ebkMn3JVncSC
         gadQ==
X-Gm-Message-State: AOJu0YyqOf4C/M2vm6Ekj85+d9lJxzCWJsl7VytzYN86YlrgJ6YrCzd/
	H73KcHhUqLF5TJK3uKIJrdaUQRrmo1GX+l5G51Oqq0RNGX4aQcxeVIfe+w==
X-Gm-Gg: ASbGncssb5CzbIDjhwsv4IZLQfDXKP7iArV3E8pt/thV6t750UHvf88byREKLXj0yEY
	U8nCC8E6A+kNHO37Rrc/s5mBAik2qiO7uaGL2QZUFCuqUFs6zQto4W9Jku6SwnlTcCz73v4i3Kq
	2Uaw5X6vFIcfNAAayY84Kh4tU/Ve/tN7ElzqkBJ+ipD2gRJVeo1akrr6Wio0EJLH/xvQc+/CT46
	ugXXMRKrxIyGR4w1CFj8LXpjqMkI1mpNeuBEm9x1znWMHa5GZQSukYN3mY9LztW1q5giWrwt+e+
	r9QQr9oIv69vHE41Inqtq1gJvLaQOpSbtLM334Gc8uDeOrca
X-Google-Smtp-Source: AGHT+IHKl5TYU3MpqoPkrfKOzlaxjELx7VBm36rl0yKtGOUWBtLhf5xj65LZfSVn/+yph2dwGOrroA==
X-Received: by 2002:a05:620a:280d:b0:7c5:4711:dc56 with SMTP id af79cd13be357-7c79cc48d26mr292170385a.48.1744191345945;
        Wed, 09 Apr 2025 02:35:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.223.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a11e6bddsm51206885a.96.2025.04.09.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:35:45 -0700 (PDT)
Message-ID: <67f63f71.050a0220.2d8420.0dc7@mx.google.com>
Date: Wed, 09 Apr 2025 02:35:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1099775767060679989=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v2] Bluetooth: l2cap: Check encryption key size on incoming connection
In-Reply-To: <20250409085307.635819-1-frederic.danis@collabora.com>
References: <20250409085307.635819-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1099775767060679989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951461

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      16.01 seconds
BuildKernel                   PASS      24.82 seconds
CheckAllWarning               PASS      49.78 seconds
CheckSparse                   PASS      30.48 seconds
BuildKernel32                 PASS      25.75 seconds
TestRunnerSetup               PASS      475.60 seconds
TestRunner_l2cap-tester       PASS      23.29 seconds
TestRunner_iso-tester         PASS      30.81 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      122.30 seconds
TestRunner_rfcomm-tester      PASS      7.74 seconds
TestRunner_sco-tester         PASS      12.57 seconds
TestRunner_ioctl-tester       PASS      8.34 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      26.73 seconds
TestRunner_userchan-tester    PASS      5.52 seconds
IncrementalBuild              PENDING   0.53 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.134 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1099775767060679989==--
