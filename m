Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221E1C8FD6
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330621; cv=none; b=p9HTMY9qGtmuucaJveev1mFmM9+paC4i/2pglXDXNeDVgnpU1GW7aHrB6KtHwHVHdWMl3qY99TRF64TGqv2ki9sr0tSFjh3B3C/c4eSQSBVUU2vXmPP9emnS9GKTMX6xRlEf7qwdYWOZ3sjS3hu12R9NHv4UICRY1QhAFw1zglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330621; c=relaxed/simple;
	bh=J0UDzvmwCpM8med66yUkCjl1emJlIJWvdMbksKTkU7A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D37ZLJCX/w4apy2+KPza1Y6xl9kARLjO444p6sBsuwDPBaIxr35l0bxQFxGExiAzJy9rw+Ox3guU3to28W+iC+5vWQ+wcUJqsoIOA6TtnYVFsOzNsN+vxOmvWFNAhPH6C+pIL0vf0kOQ5ij6wObamefrAZCboGxw189nv/FDWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9FQjXaX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9FQjXaX"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e2362ea655so15358616d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738330619; x=1738935419; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BKR9KO+iYAJ7VfqIZ278KsayvFjsyW+Idl8FDhKJHCo=;
        b=g9FQjXaXEPmPLu7NSpx43op1ww/0ti7Q7aCw8KSBY1FXP3Hl9jAuiPndoiZ6JKQJOR
         SEfUWAIQ+Z/42A8ysB50sk/5e4W1HFDNA8909gYUsffApZ9lEiToCwesukSTqhpo15kj
         r6CYG86yawLeMGmU8pc69xYl/IhvRUlpDp9Yr/WNifn4HAJDULMtZoTq4JakGBuEnWV0
         8fvnMtihu3oFgowvhNaQS+s5fcSs47sVel9iTPyvU/I/e7N3YtFmRvU5d6+hpnuIktzb
         cIO8gwbzjP+I4tFhQ7khfMtr4ND4VcPqMudv0JEjjigY1m4sWG3nNJkn4FhTyjy6Wj50
         SBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330619; x=1738935419;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKR9KO+iYAJ7VfqIZ278KsayvFjsyW+Idl8FDhKJHCo=;
        b=ZF7UoxT57K330nnDKJTR2qWtzrWZBk5Bnj8RKRouH0qAa2lRzzbLObM7Mpja0NDQAr
         3mn2f7GBfR1yo6xbUkAStLOhtASDjwPvyXSaYj3I8Hvdwyqr8zfvCk4D2FZMtLkudBbe
         3LwAZVn4gVObABslDRdVa2WQue8Ru0jn+2pKFXE8057DVGPIfV0tfI9Zqnw1qHSNQw9V
         oYuHsKhB9ZwHXu0g47/0RtXOMGBBsESgYlB2FU8TsaGMMT4LyjvfF6ISdTDDLl8K1hpI
         DdVTODvGCI5AwYCez3ykKj9W+VUwPxD8js4k4JrpCgToqQV/xF5PXEDYp+LPKz8PQS14
         JORA==
X-Gm-Message-State: AOJu0YyE+btjCOhT+8jQEZjMb15aWA7Thx15gCxve+NnrmfMKch0mKJP
	A7tdc7i0Le8+fIqLKnlLVDGrKemSsFEuQ9x4Id5pI6MMgD46m3LCy9tF5A==
X-Gm-Gg: ASbGncvLn/bODP/xxdbe/OnWXgrGMuw2u9Xun2c8XntBDpt4s7D1yLyt3cXldMP8KSj
	eRljS97YpFgPL9EQH7znUpes1BnzOk4k5Prcbs25QKC0RmInKPfQ4htCOH+SMgjyBXj7E2vnyU/
	wyupwiWbfFmPdglHCkABEvz4pcpEv8SfdCta2wvQXF8KlYgfawbrkMnPTqAuvYFcw9SCp1bWX0d
	5ztILzcYcnhn8RbYgymu56SHiLTvjQGVwaKI6yctZwwp7OF6VbwXZEB8Mx1EwZD6GFKpVgXhTkh
	BkQszCuVfxy5WxrouktM
X-Google-Smtp-Source: AGHT+IGCLvWErxIlqTEJtvBD8eIeP37FWldiHqyXtBYy8BJ0WY4Z87ie0FjNSGl/WyskPdrWV2K4Dg==
X-Received: by 2002:a05:6214:2628:b0:6da:dbf0:962a with SMTP id 6a1803df08f44-6e243b8fc5bmr136003156d6.9.1738330618729;
        Fri, 31 Jan 2025 05:36:58 -0800 (PST)
Received: from [172.17.0.2] ([20.246.78.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f3e27sm18111766d6.17.2025.01.31.05.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:36:58 -0800 (PST)
Message-ID: <679cd1fa.050a0220.a5386.6a7b@mx.google.com>
Date: Fri, 31 Jan 2025 05:36:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0253573194032500232=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Fix a potential race condition
In-Reply-To: <20250131130019.1648758-1-kiran.k@intel.com>
References: <20250131130019.1648758-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0253573194032500232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929500

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.84 seconds
CheckAllWarning               PASS      27.66 seconds
CheckSparse                   PASS      31.43 seconds
BuildKernel32                 PASS      24.99 seconds
TestRunnerSetup               PASS      435.65 seconds
TestRunner_l2cap-tester       PASS      20.58 seconds
TestRunner_iso-tester         PASS      29.82 seconds
TestRunner_bnep-tester        PASS      5.21 seconds
TestRunner_mgmt-tester        FAIL      120.43 seconds
TestRunner_rfcomm-tester      PASS      7.67 seconds
TestRunner_sco-tester         PASS      9.45 seconds
TestRunner_ioctl-tester       PASS      8.22 seconds
TestRunner_mesh-tester        PASS      6.16 seconds
TestRunner_smp-tester         PASS      7.14 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.47 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.194 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.148 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.148 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0253573194032500232==--
