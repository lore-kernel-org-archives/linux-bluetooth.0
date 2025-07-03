Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759F253B58
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551725; cv=none; b=TW++jzQXQpo0/mi5K1Z+5OzX1XOjpYPlxWfg9GVU2DJyR49qMybfoU7wmZuNtXC82hoc1ZMTNbN4WfdNXkojT0/61JBCYn/Rv6s5EfolOqFZo0/Izv/Codalv3mtL0AMeqMSFAiEKe0CSzdYGN2QDh+gHujDB+AUzst/K3/014s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551725; c=relaxed/simple;
	bh=x5P39Z2VMxSvkTT3fT1w4uhxlZEnxWb06TBUio62dYY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NY9JLPuAukLeRIKZC7Q2v+8Brujpxycn5BlW+VpWIXY70PUmDVe1qdhrvVMYgK42J1dGCHdx1WxeG0H4LOMcREqSUCclWjLsIgvVtMueVCfs0HRugB00wDyL86+CbGFeo66HzvgHcdFOeA9LJ0pEJMIdIP3KuMZVNbt0Jb3P9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lskct8PG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lskct8PG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73c17c770a7so6912177b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751551722; x=1752156522; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gpvv3IboLRv8vNmtCdvYyXPpcHvmZzLzwYIi9zWSL4g=;
        b=lskct8PGiZKA+KnuWvopY2C4Llc/esTE7Xf0bNT/QkvH96a3z1ImWltbOj9j6Z5YwB
         sc4DXbmcgtDL0fMgQKVh5A6wADhlgcZyThLKR+vdDsxh9S7B2pwtyjinhDfhduTcfnre
         NOa6YDXE1AsLihAXL2sSJiNHjc08NeUUz8L8EQYojJSjuPAQbrJQ0qQ3p3JsDC5vHu3P
         96GeAyDAzaQPBDe3Oviv9WTKCKwiuHtL9YBJTrklkr+MtK7zcR95as1jUJ3DPvQ0bKl4
         Cmb03TGsFb42F0Fn4coRocezzqWI4KcwWcQUCk/CYAORWQnolqITSLiNRwPp4MZO+0MB
         LWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751551722; x=1752156522;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpvv3IboLRv8vNmtCdvYyXPpcHvmZzLzwYIi9zWSL4g=;
        b=bzzusUZZSqfnXsgN2dp1e1NPA0D/BcSyCny6hREDzdoS4yJFqstgYyD31/HQVnXVcV
         sGWyH1y5uwL43zGRhsTLAZBkn5UDhcTFJPfGVEPMoAbhLoULQtB6iqu0k/w2WL6AfRTY
         7WjASjw8KuoQvaBxSBB5ctVUBshM95AHKevWw67yHXPnqXOf2vx6jZXpCjPLpvAqHOs5
         QJIZjg5Tq4lgwqRs0OG1dDZeufBSfpbIteZS7Pq3Za5UTWuaAItRcp1/ahVLx7i9SkAX
         czl+yHwGvYtPd7PSkL3wqfqmxc1CtMEDVWb1FqIoicTxY6Zq9SamblpfuWx3+HUzKjn3
         jF9g==
X-Gm-Message-State: AOJu0YwSQJmk9t/xM+/Y3C3RvvSCnpfV/2HLcavnqNKWZcEoU1XTwD1q
	tZdBfsmIugDX6vu2MAudD1tM4HCv/+bFR6vAy4SXF8cqn3KBXCbipuGCD5I8jQ==
X-Gm-Gg: ASbGncvv5YJMZrTUijNOxY3KcB3jpQ8MxeLv1e1TlOPlPmv7kn3Igi3731XmLbgS82w
	q6hcZZQPn2yPr3rZNi4vQ8CxiGCtDUekb6+sXWyvNY+xi5yTawfxirr0R8dExVsSSnZnvm9C//N
	9MMrE7G/kw/XELr/GX7payMhLbpne5z5M7hZfevMFrcXlNgOD4Uh2LNRM9Il6pEuI/VEbQZfsT9
	UDJ+WFJfWnTwG0qn412CMEasPwmkJffNfgY664kV3cd2q8ccAMB0KSZMDU96qqtefpkeZkrq/6G
	ml/IpbnCln6J/zeSlUsLHVbODSe0LELVUtd5cj+CW9wfv4cAJhXy927aH6eX9G9kYnjV
X-Google-Smtp-Source: AGHT+IElyjf8fB4GnhTOsHa8lAGkPvHDaWva6VPvU5WhZmolOq4eB/FqlDI0Ze0nG5vmwc8NnjDdNA==
X-Received: by 2002:a05:6a21:33a4:b0:21f:419f:9019 with SMTP id adf61e73a8af0-222d7e8340fmr12168555637.21.1751551722463;
        Thu, 03 Jul 2025 07:08:42 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.176.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3008e2esm15454526a12.16.2025.07.03.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:08:42 -0700 (PDT)
Message-ID: <68668eea.630a0220.12ae4b.7dec@mx.google.com>
Date: Thu, 03 Jul 2025 07:08:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0325347960564532253=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] Bluetooth: coredump: Add hci_devcd_unregister() for cleanup
In-Reply-To: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
References: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0325347960564532253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978641

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      24.12 seconds
CheckAllWarning               PASS      26.78 seconds
CheckSparse                   PASS      30.23 seconds
BuildKernel32                 PASS      24.15 seconds
TestRunnerSetup               PASS      471.77 seconds
TestRunner_l2cap-tester       PASS      25.05 seconds
TestRunner_iso-tester         PASS      46.34 seconds
TestRunner_bnep-tester        PASS      5.85 seconds
TestRunner_mgmt-tester        PASS      129.71 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      14.72 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        FAIL      11.80 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.128 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0325347960564532253==--
