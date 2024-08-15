Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F621714CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725868; cv=none; b=ETtHRDQ5IGx3ZdgV6ykbRrV/va5nX5HcBQ2+Fm55bESQyoHVb7tFJtEhnP4pyvHaN2YMoLZlrTaRpCgz0f2Mb19vLfYYyjp9Ma1g5cLdKvH3rF2e48qaNnuxntQpS2JYxt6WV2fbhNGqK3BwoHvXabheZYrqbLYCteTB3s67Scg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725868; c=relaxed/simple;
	bh=GT8PGOSe7AUf5wUUxMJDpN0F01cuiFwxg0EVhP82AtQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pR39Xo/pBPg4uw7CIM/BZxIN93WbU9cNM0OPsxBCc6qose8EmZTbbGyBz1aWTM12ZAeiHZyBK7JYmrxnoPWEyf/ZyOFaiVs7lyqz3eRP+tW6UTsGFeWD0ohXvLlhCrjP237RuClrXp/Cc/lQGgGMd9H4TGZM7temCnk78MxCZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm9B5uTD; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm9B5uTD"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5e1c86b83so532718eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 05:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725865; x=1724330665; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nXgRiFDM4//7RmW1xvDIk4YDY+fqAfCZ6vd7pMEfDxs=;
        b=jm9B5uTDp4Y+4G0L7k+ODp+NSE8Fs1dBltqbUUz7WsYEvO75q5gLBEva4bhj/Fb/qv
         FEgHQDCOmeZt73cjCr41tqFrQ/Au6Pd+M6pzd0slU+wG95aaL4H7sgfiEgLraJ9LZSjA
         R/ThfokEncS9iqfQJdnxu752J71koPancUAj7rcbAq2N9wLGOhJ5w7WecvWxv18u/RmJ
         LJmIRBd70vtcf7HKRQF+k11ChBkB53SGb/deTUO00NJ7hD4yqd9tjZWM1ry3lQ0SRZIQ
         EwijXmlvo/7RmrzeweP1zAG2VDRf8Mt8R6vQQEFgKTcc2Rj1JpjFNL14VlwSKFNgrfYO
         uBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725865; x=1724330665;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXgRiFDM4//7RmW1xvDIk4YDY+fqAfCZ6vd7pMEfDxs=;
        b=wVkjQRY5yys1C0GlMf4klh077WNFDvYESuBYopGWcqv0iUMne0GLBCK94dHL5xQVmK
         DDA0hKXI5MDshMs+Nux0PL0HZf8v37YWwmxrIN8wh6An+08so29b9F50NMFnhKCPr+A1
         3Ix7F0SUUPXtH1WflUZ7pxvQIHttdWcW5SRNzO9TAytHO7eV9rKm/rGZGT5qSWSYeBK0
         7QCZGOfO1YXQFRb6wt0DH9r4Xg4X8xGp8uxtCem26+Dg2WPjQ0hp7FeyDS6GBG0aZJFe
         WEGxi7WwsIyxxVpbAhzKMsoJfZcbDRwa98XxzBWSto6+6DQTJn2d0boqMvoS0WU2+MX2
         MhGQ==
X-Gm-Message-State: AOJu0YxJ2EMjJH1gDzlobPfZZTyRM0g+Ji/85HNAbVkN5iw89O/p+oFR
	hQlz2Y/pAwa30IbPOpI6iTm7J0VPz/HUrlclTXuiZKnI8bXbl5IihrOsVQ==
X-Google-Smtp-Source: AGHT+IEtpnS7x869Q7lp41SsNlpnf1Mljj9rh40qmTkNPFqHNi04kRbwm4PMRbJAPC+nSbBoPl0fjw==
X-Received: by 2002:a05:6359:410d:b0:1ac:ed54:224d with SMTP id e5c5f4694b2df-1b1aab56a74mr721901555d.11.1723725864887;
        Thu, 15 Aug 2024 05:44:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff06a25bsm60171985a.54.2024.08.15.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:44:24 -0700 (PDT)
Message-ID: <66bdf828.050a0220.33278.1bbd@mx.google.com>
Date: Thu, 15 Aug 2024 05:44:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4194014235563274294=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, griffin@kroah.com
Subject: RE: Bluetooth: MGMT: Add error handling to pair_device()
In-Reply-To: <20240815115100.13100-1-griffin@kroah.com>
References: <20240815115100.13100-1-griffin@kroah.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4194014235563274294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=879977

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.83 seconds
CheckAllWarning               PASS      32.48 seconds
CheckSparse                   PASS      38.47 seconds
CheckSmatch                   PASS      103.32 seconds
BuildKernel32                 PASS      29.29 seconds
TestRunnerSetup               PASS      531.73 seconds
TestRunner_l2cap-tester       PASS      20.33 seconds
TestRunner_iso-tester         PASS      35.43 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        FAIL      114.42 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      15.23 seconds
TestRunner_ioctl-tester       PASS      8.10 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      7.01 seconds
TestRunner_userchan-tester    PASS      5.14 seconds
IncrementalBuild              PASS      28.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: MGMT: Add error handling to pair_device()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#118: 
hci_conn_params_add() never checks for a NULL value and could lead to a NULL

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#123: 
Reported-by: Yiwei Zhang <zhan4630@purdue.edu>
Cc: Stable <stable@kernel.org>

WARNING: Invalid email format for stable: 'Stable <stable@kernel.org>', prefer 'stable@kernel.org'
#124: 
Cc: Stable <stable@kernel.org>

total: 0 errors, 3 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13764703.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.573 seconds


---
Regards,
Linux Bluetooth


--===============4194014235563274294==--
