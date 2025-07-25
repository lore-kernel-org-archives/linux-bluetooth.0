Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E62D3734
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436399; cv=none; b=OeNWn2iHgt8dzBjYDzv8dX46Lpd/tgclZcS3cZMH67gBkDZvI3OQv3vhlJYPmKrtIFCkPu1DD2kbRAoeMj+aJfSVJJ3Vk0z4Kqs+8XRj9BtEH3cjwvUK2fccoXCLKQETMkHL1Be/4FivvYPANORzXzVj44cYtI5JSaoiFn3xGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436399; c=relaxed/simple;
	bh=xS1vnzoHDIToS9sm4bxT9cJtGbk/fCZiRwM07zsv8j0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fR6uqvUHsGRzW0ZhsTy6W8k3tQF0I4V74LPFgB8cjEV7s6bjO//Cv/ccnvBcyD97K/oew9FUJe3HVkC0yzan8HaHwDsPg6Lh6+8M6314vNXDWVPFqEuaRRcU732Oh2+lX19K+PQjAu0qv7vljC64RA4VN5ZFpEQo/wdckyaKBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur5Ooqj2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur5Ooqj2"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313f68bc519so1484056a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753436397; x=1754041197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8ei+fNJF/alnGktBS64V5xzuL0E2FOVh57vFO0SHoMk=;
        b=Ur5Ooqj2sQ7jYgDO0JTPQrFmMPeuwgnV9Bt+L1VtxBgvYihRgf5AKUgTGjdY+/Gt2e
         1FAPIm4ThsQA0m7UOOE9QhIay9mV16S9pEL9i851gz0GISKoRPtzTsBcmBspn33BInCu
         9uvDJ6Fv2re6eeZAAEJCMa1aUYRyStqTw3qkVKE60HQw4d2dd+lGhzMn4pUoQagr5z15
         3qjJa0QG08KUB1KAsKK2Lbiw+kz/09gIpdU3kc8slUGb907/dbuFNH3Zq4dAgd1I8i2R
         wrhbaRP+5Y4EASnlNj8AuPWEyjaBEeUBC94AYL3QWIThLchwx732+5liI9jsoC3S4bUc
         gTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753436397; x=1754041197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ei+fNJF/alnGktBS64V5xzuL0E2FOVh57vFO0SHoMk=;
        b=t4d7he3+Rc6KYnAETOURGy6blXLhj4RNda3ohKCnZANFAv0zVR0xQuk9Dsl6+C/5c0
         6/uP1XLij6oy6jdjvyfQCxFKcNPAUzJJFZ2FXPa8Stp7dhwCShwpDNLxqSQeAWqNo5SZ
         8srEWZwlN2Q2qU7jYQBSW6nrMk5ZY7rauKTL/9eGYrhfDDF+p2T97ceWGCa4tZ7e+E4v
         eaO+tDQlf5nOwkwWc1aHP9VNpsZIIQan0aLRP//qW2kqIdnqMvKSp87ph/SgPu5nQyl4
         Wr5aYcDl5XLau6qgArrMRG3SFiciLTv/S5BgLeTc48QOZM2e8oM77+OCcuShD1itsYb5
         sL9Q==
X-Gm-Message-State: AOJu0YxmK1PaF4m2gSCkD+cdZhvBocOirJQBe9D2phzTOkj9W+/9HMsf
	c6lwOhm2asFwqhO4E/UiBmKTC5JLq6JQEBXru/5x7gFpVg5bSDsh1CgNoTcpQQ==
X-Gm-Gg: ASbGncvM1eiLIO+keoKFWVOETunCoVouNknLhGsGnJe+oc4HlX0Ebi6QmReFC1kt3/A
	NvOxrJ2F0ACzoI79+zZwb1Ae3m/WkIOzeXpGqH9tlxaq8y/HcQGKM6/SQMAFiYm+SjUZXTgbN86
	B608VzH9PAf7R4yr8DWGz+b0glvQkqr7zrD6q6/6vP20KRME+pgSBs+ZcmgXID1CDuD9erqHX6J
	CqiHCz0+3T7fjoh6QnIGDq8C+G3Y5pbsXAEByiX26p/JPOZHgjpYb/xwOyfWQmu8ShuBcDU1Qwy
	7u+d6giSG3y2QAwGEgUhXcFiqgXLehuXqhUm5EEFLGDoS4+5C6XxTcQ1MwC8Ee0ixApbSf3DQUm
	Up8BdD7yac0UA9+iLA09bj7XO50YlnA==
X-Google-Smtp-Source: AGHT+IFinqFsoWDdj9ciroGuxAtr9K33wq9kh2yumnEQpJny7GxetdWacVtd4RaDaWuCF1S6gbywkg==
X-Received: by 2002:a17:90b:35cb:b0:31a:9004:8d36 with SMTP id 98e67ed59e1d1-31e77a01370mr1912220a91.20.1753436397065;
        Fri, 25 Jul 2025 02:39:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.127.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6631a358sm3148153a91.22.2025.07.25.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 02:39:56 -0700 (PDT)
Message-ID: <688350ec.170a0220.27546c.2008@mx.google.com>
Date: Fri, 25 Jul 2025 02:39:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4165601908318329215=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: Bluetooth: btintel_pcie: avoid unguarded 64-bit division
In-Reply-To: <20250725090651.2495984-1-arnd@kernel.org>
References: <20250725090651.2495984-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4165601908318329215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985878

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.74 seconds
CheckAllWarning               PASS      26.41 seconds
CheckSparse                   PASS      29.88 seconds
BuildKernel32                 PASS      24.13 seconds
TestRunnerSetup               PASS      474.09 seconds
TestRunner_l2cap-tester       PASS      24.68 seconds
TestRunner_iso-tester         PASS      44.39 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      131.31 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         PASS      14.81 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      13.65 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.29 seconds
IncrementalBuild              PENDING   0.48 seconds

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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.205 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.962 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4165601908318329215==--
