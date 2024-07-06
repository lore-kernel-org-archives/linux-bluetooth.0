Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388231C687
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jul 2024 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720308789; cv=none; b=EWWKtlOlu8huc66Sh7wqa0JulItcaFdtTT1OYfT1YANQhTE/SOdftCPY8gBKo55KmJf5suYR917Pm7Fs9+pqFi73ublijbDjqmC0G+KC+hdkX/9BD//hxRTBw6jBtg+9RZp8PHNeyEjzcXznipui1v5WMfviJdr0RSJ3vFzYFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720308789; c=relaxed/simple;
	bh=q0Hqu7kiSGgikxhL1HA5AGdSLKBve/HksUdMBFB1Dw0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iOjM4zH6k0g7jMx3lqHlX16/nIEgPSrLgYVwH2QIOSpwrLLuXDv02sKCtOVVY1jjre2K6/aJMbbrVZSCfrWOe0fmb5EU6kD/kB73NOd4NxXwsCKs06LIqgR9yrcS9Cabm8sVZxNPa2vfK/K9qF6pMf8uQjwxKIOwTDYtf4O6QE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV+N+SdV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV+N+SdV"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79c06169e9cso195623085a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jul 2024 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720308787; x=1720913587; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h39tmj1l9hfdnMGVDVTyVYfgopeipS9QL8tBHJDkmHE=;
        b=VV+N+SdVUHkgALJ5W3ZrFXw9dEhsGeLzoQ65xde8jchqSXDy2CtUHqbzslwmJ6hBAQ
         Y57ZO9PcadeSShOD0l7QAA3KHCiL6dseiOQR4NDS4UJhw8ICDsIVPAIq+y3WJojMoZZu
         cVcp5tQ1kQPVjJbRkjX9M2ybJGy/a6JLi+yu49AAT0iFgZIingLHJwNDQbQRZBSCoyIj
         7VudaQS73XD4bvDksJoqToXeYi32Engx1PF78u+3S62lUI5SKZWfbGswxzLvfJbGt/NH
         TIPF4jP6wJnn/w7Zt2Y2MgkLkaS9Xu2UjSkb7eRE3MdZFwsdtV7Di8tT78t1qfm/0pTV
         Mu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720308787; x=1720913587;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h39tmj1l9hfdnMGVDVTyVYfgopeipS9QL8tBHJDkmHE=;
        b=b27YRtvk+7Axt0Dx3qejxMMX2qCoHIhehSA84JlBJCKMdmDnHT4aagwvDW0XOWsD8r
         jK4CiP1cmBN6y+RcMxqPdT8I/30AmfbLmt7pmp6leFjQ9qGLDHo3YoGIGX0xgbaPXDXj
         U+DTxjfpMEyyIRp8b9ALY85V3otNGBDBbpuTy7I+YACVRYP+IN+XKuI232U1Zp+HprDX
         3RU9U7f192vXWvwkCg1AUunIzhavGEulDHdjaE33Ckf3VgGDnBcTiHL+SX8zvRt1BmR/
         kIRzti6ZTpNKCsMc5TeAug1caY8muiQIKT8p2fRVqX4RheSeGNSJx+jUlLtMg+oOHhD8
         kNmA==
X-Gm-Message-State: AOJu0Yxpg8AgUgg6kS1QJnYvE2I1bJARRu83ej9HGwC9PC0OhuQqP0bO
	ldApfRM4ZIQKbZNUnvaR51fLTyd2NobpxzJrZGKhkSjxC7FH+XijOSgOBQ==
X-Google-Smtp-Source: AGHT+IEz83Aw2BdOlf//PWF8m01a1nKX6sRgHtmsmRXpqMJmDgAE2FlxjyGc3quTgdhwmnXJV/+urA==
X-Received: by 2002:a05:620a:3883:b0:79e:f75d:e8bf with SMTP id af79cd13be357-79ef75decc5mr549147785a.42.1720308786917;
        Sat, 06 Jul 2024 16:33:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d890e99d4sm700873785a.43.2024.07.06.16.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 16:33:06 -0700 (PDT)
Message-ID: <6689d432.050a0220.192f5.a2d7@mx.google.com>
Date: Sat, 06 Jul 2024 16:33:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5892960737396286551=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [v2] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
In-Reply-To: <20240706225124.1247944-1-iam@sung-woo.kim>
References: <20240706225124.1247944-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5892960737396286551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869029

---Test result---

Test Summary:
CheckPatch                    FAIL      0.85 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.03 seconds
CheckAllWarning               PASS      32.33 seconds
CheckSparse                   PASS      37.80 seconds
CheckSmatch                   PASS      102.95 seconds
BuildKernel32                 PASS      28.77 seconds
TestRunnerSetup               PASS      524.00 seconds
TestRunner_l2cap-tester       PASS      20.16 seconds
TestRunner_iso-tester         PASS      32.93 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      114.05 seconds
TestRunner_rfcomm-tester      PASS      7.37 seconds
TestRunner_sco-tester         PASS      15.05 seconds
TestRunner_ioctl-tester       PASS      7.93 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      27.85 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#86: 
CPU: 1 PID: 2000 Comm: kworker/u9:5 Not tainted 6.9.0-ga6bcb805883c-dirty #10

total: 0 errors, 1 warnings, 0 checks, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13725924.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (199>80): "Code: 08 48 89 ef e8 b8 c1 8f fd 48 8b 75 00 e9 96 00 00 00 49 89 c6 48 ba 00 00 00 00 00 fc ff df 4c 8d 60 70 4c 89 e3 48 c1 eb 03 <0f> b6 04 13 84 c0 0f 85 82 06 00 00 41 83 3c 24 02 77 0a e8 bf 78"


---
Regards,
Linux Bluetooth


--===============5892960737396286551==--
