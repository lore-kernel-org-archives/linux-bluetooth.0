Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE1184
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783209821; cv=none; b=ZVKM4Mm4E6QmpoVJgEUrJ6jnW1eZukPTTlApJed0EAAnO3j6xIOTvwt6mC1eNBw2u2j4T1OorKd4Prb6j9x8EJlaECd5TAVvHEa4cqNXhSZ5pOWoxsC4UQWm4hXEyse8S1sWb9xsn/pMJsyhkfx7sHnc/v2+YzJKoyCotYBpHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783209821; c=relaxed/simple;
	bh=XCfkBgl8CCTM02VcJyS/1rFjT/S7M7SkLBrhs8Sbxsg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sMVw7XvwyZAmLaNGLJOUWstfudm1Ud1RFl4Ibs9F8Zxv83CIfsneF+AxoajNrW8JrfHQVBggQssoB3lvfgMF9M7AW4ibELsyfogggdyRL1l8C4RVQRP1divrYPF9bDXHp1ApTZLyzgPFvdGWmU5TMKz9GcL8jK/DJXxQYCmiYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwiy3qAL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwiy3qAL"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e663c828dso98710385a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jul 2026 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783209819; x=1783814619; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yhj3Aw36mheUroVRk1tC1eVUPNL55VCz1KFf41BRpdM=;
        b=Fwiy3qALqxn6jWJhWgB7E2CrrrxNV5EvddzQWd0NVyGwb97viaBpOB8PigdDCJAf1v
         1mfit21d3mwWdHIBQ/rKSzYgc0VnL0fI6ME3aPZ38dieZ5Z476s3TDv3Xb0jJBtcjXn+
         RaYV91STM/I2UaZkuPdfQo7jYNxm8eqteJHc+TNGaCxhO+elEzNiaCVBGboBVV6BlqhG
         4TRcq/7O97mcdXtpO5x0334ekOFpI57kvdOWNm91vpPYz1PH0Hj3jHO3MvZqVbjEZfP6
         lQNEV5a9/A27RX1r2a14SZZ6UJIwlpvqWCbuA2jcVklTF0rSZxtYQPr7jOLpr7FJID13
         p0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783209819; x=1783814619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhj3Aw36mheUroVRk1tC1eVUPNL55VCz1KFf41BRpdM=;
        b=pkrL10kAoggfzTTM83VUhwjldt51nqMgGtli+Bcj2zddU+mE4GN7A5MeZpAYx/jVL5
         UqZBGz4iAPiKAeavQqldywOZksrUHt73aFD09qbuViPTqBzrYAgxjqOmWqKE13rly00h
         WsL+TM2AabJywOTpzl1n2mV1WxaRscbK2xsYbI2UJK08AVZUEh5gSlkkG4DNHDbX6hMz
         /ymDWRsFnCSW2WNONLXFqZ3jvaM3W94zmrlomYiLm8/dgfAQMbLdHhzEnwkfm0ZpSAA2
         1ghNJFxr/yO6n8cDM/eghgCtpfW7ZVrS1VZ7WRLKVQrTZOJc4iyrhpZLgVUBHmQM65EF
         szzg==
X-Gm-Message-State: AOJu0YywzrBOdqZY0k732kgd5mQo3/ksgaUNaEAGOuu+SxO6ZWvjs4du
	PDoR3mubgtGUQ6hbvqxMPruB6ZSSSCFaQaDaEZev9LlPOnFsGL0f1GnAKAPsjg==
X-Gm-Gg: AfdE7ck/0ykXCFQp6Bwne8mBi3nQ9bBaIOx7yHXji9kQaT8drViAkjgPdrBpXNKd+8y
	tlQ3k7WarP1AXzuGZYWGrALOW3H0qVsqHMC6ItTSwn88ZzAIlZ6LK81Rl8H2bPsVkSLfm0f+MVV
	f3mW3YbvH2nKBtTWz0W2dtykFZavnpQZv6ph35a4FLudJs779Pzz1Jm1xhV55s9Cs5XbARHHBKO
	WeF12JRv6J9KHzO/gFzwjZ7vtcJJHxL+oGemfnMH0F20iwyhoqChus5T1c9u09m1Y5Hp8B5UBCI
	IPuXCbzOniEKqdqqlXAlAvCk61Mh98zDgFtdq1cDyI6EM6wualCMKnnoei7J4bOqUwBVgy1Jcxd
	S6e8rzkS9NNB5Aamd3F9P3Buh4IbYXZNl2WnYY1vvWEt6uRzEb8No6ZPzRw7JWMO/qbTtZ0D5PU
	pUzDbmmTYhRTxW/QEJ+Y2lrGymc8Db
X-Received: by 2002:a05:620a:2552:b0:92e:7075:941 with SMTP id af79cd13be357-92e8b2a02bbmr1203519285a.13.1783209819265;
        Sat, 04 Jul 2026 17:03:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cce037sm516232885a.38.2026.07.04.17.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 17:03:38 -0700 (PDT)
Message-ID: <6a499f5a.0aaa7f3a.1daa5a.014e@mx.google.com>
Date: Sat, 04 Jul 2026 17:03:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1791147971083208524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cito@online.de
Subject: RE: Bluetooth: btusb: Add ASUS USB-BT540 and USB-BT600 for Realtek 8761CU
In-Reply-To: <20260704231312.340274-1-cito@online.de>
References: <20260704231312.340274-1-cito@online.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1791147971083208524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121637

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.40 seconds
CheckAllWarning               PASS      27.82 seconds
CheckSparse                   PASS      26.51 seconds
BuildKernel32                 PASS      25.30 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      457.52 seconds
IncrementalBuild              PASS      23.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add ASUS USB-BT540 and USB-BT600 for Realtek 8761CU
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14664151.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/397

---
Regards,
Linux Bluetooth


--===============1791147971083208524==--
