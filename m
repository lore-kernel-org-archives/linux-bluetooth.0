Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB218DB35
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485234; cv=none; b=TwAJHLOt7+DYZFqkYfJXOqkb5HF66HmwI1kSFHa4oMEoAO83nD3YAt7FKmLhYQL0FQjwIqoMQhhdMgv0Lf2gzR4eDZkhUPSxaRlbzXFgo/OLikPU2IHhYtaMHwR9mvghPJrQUQuQrHy1fkfRpBz+fokJFKc1cQp5djHc41R64+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485234; c=relaxed/simple;
	bh=BVrsXhEukAfvnVEKJThiVfbFviY2DZkLsN4jOHvfF+E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BtpPVJUtKLrN+p/8jrot5++j7QPjd5tee7El3HZ9P3Pwvu1uTtXBJY33SQCCH5mU/b4lzVn/8RBiMRUrWiH9xQA+8Df5nZvFtieCZpu5g05lpWWcoYOUtlDXOvSx/1cq1cYta++Tn1uAkeOhIdLvo5NYYitzqs2WH0Ts+afN3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDh+7xTG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDh+7xTG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso220660b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 19:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762485232; x=1763090032; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d9im3NtSizsOL6FMN71zT68U1kJwU0tMUyZWzCq2Iso=;
        b=gDh+7xTGHSQi+2dHOZjidPlaUJXpq2hywAVFAANioz0KUkn8ovY5t6EBga/tCpk++P
         jeqZh4gdZoR8osqC3yjenFjQnnAi8TyuDqj1JetTU+4UmqIVABnbikMnnRU2ARQlCaz4
         sU+RaYe+43a0FwNcKJLjWsqSMtJ8vhrHqiDIaTOpkxaAJfwXm5hz6MiSHWl88ZZijv8v
         /OOJHvRid0Hb93Vuo9q8PfBC8FnMp/cRxXJMvRZuE70c6DVj5tAkJ16YHzfjqWHmSZ9e
         943Yrs0ZCE0f5yBHN9GFxPYIHLKu1IOFxdz9tPCqaR5qtbJf0RbvmCRn8Q0y84K3IF11
         Q16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485232; x=1763090032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9im3NtSizsOL6FMN71zT68U1kJwU0tMUyZWzCq2Iso=;
        b=dfgTWlTbrOi9UpzzrAtPXiTF8u31FJ4912KfXuXSCdiXN7J2gHPwmVFrVG9G7esyCP
         PGy8TNN4J637DkZuwotDGSkPqYrW8g0KffzOFoGO/IE/HOvbguf5b1RQxjzFxl0PbZem
         6PlK2iPbeshkZRBsr6cejeYaBaS+VYmfwrPJ76fEO454NZOkQQxvjCNPQNdVz92L5CId
         5rdkoYYTw8OV1PbfDhFC4QHegupMvDpVZ8dBbq0zT+hADjEL6dM737dS4spJun5Gy4RN
         obWkwTSrOrbx8HXLZUVMVjgvoqaF2OOPNUs2R4QPZUL3HqFerhGBmaCvmB45AQowpjHs
         /5qA==
X-Gm-Message-State: AOJu0YxTY+eFVC1TfPEWjRh6b+vLhzB7esEAd/11q0hGZSYoWkL6S2Qb
	6YLQqdZuIOoLcPyxA9boA+fXce9WlFJjOGifF4cJo1ibxvHO3wAxmmQ1SyN5LQ==
X-Gm-Gg: ASbGncupcwmj92CCQ5c8JMZale2SZeXNx6233/U/ZvtH0R81lG/W6mFAbZp4lBsdhd1
	h7UndDbUz4KomCC5IHM7w/ff6PLLTFRpQQKuk7C3RIE1BK05MT12aM4Hy9Ahf0YkYB9yo/y76mb
	ymqrZInBqQWn4vRF+6QxNnthKz0av1nyZHpQFnBs/5fFENBf/gLWSn5G7E3klVUIgd1FyunSE5T
	KRZklW0wRE1QN54ZF3QZ3OfYqBZePQdmPbI8jlRY4YL3Yeqyrngw/D0zGGLi+3zqSDPYWNI9hLV
	Ml+z8IjstpnIKHGNCB3M38i+QC7Vt+9T1OAVlkOBLWzqtzwGwaXpex69ukjRYoQ3E+5nu0KZ4HH
	gmxLn5Uc98fdhoKwSOAYl5yaZ8nmQmIWBU8srZJrLx/MXxFLSlfGxCCIi1AzcTY8sDUlN4SSFoO
	p7vqDiQEk=
X-Google-Smtp-Source: AGHT+IGZbSKjNhBbCT9i7DcpF7yow7TqflK9DcZFnlXoDW7dH5t6lnNGxX9C2B5CL+mP9al9mVlA0Q==
X-Received: by 2002:a05:6a21:328e:b0:32d:a91a:7713 with SMTP id adf61e73a8af0-3522a36dc4bmr2470947637.40.1762485231729;
        Thu, 06 Nov 2025 19:13:51 -0800 (PST)
Received: from [172.17.0.2] ([52.159.247.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59de7sm1088937b3a.65.2025.11.06.19.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:13:51 -0800 (PST)
Message-ID: <690d63ef.050a0220.e438a.4ab8@mx.google.com>
Date: Thu, 06 Nov 2025 19:13:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4997949213401874530=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: Bluetooth: use memset avoid memory leaks
In-Reply-To: <20251107022102.266003-1-13875017792@163.com>
References: <20251107022102.266003-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4997949213401874530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020713

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.97 seconds
CheckAllWarning               PASS      26.99 seconds
CheckSparse                   PASS      30.71 seconds
BuildKernel32                 PASS      24.37 seconds
TestRunnerSetup               PASS      492.94 seconds
TestRunner_l2cap-tester       PASS      23.54 seconds
TestRunner_iso-tester         PASS      65.55 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        FAIL      108.37 seconds
TestRunner_rfcomm-tester      PASS      9.05 seconds
TestRunner_sco-tester         PASS      14.11 seconds
TestRunner_ioctl-tester       PASS      9.68 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.25 seconds
TestRunner_userchan-tester    PASS      6.41 seconds
IncrementalBuild              PENDING   0.61 seconds

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
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.097 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.149 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.189 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4997949213401874530==--
