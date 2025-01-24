Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D723A0
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711174; cv=none; b=BY9zipwAuBu4AIN2FTh3SV2eVSLR0KIVw/l1E8sxIFM766h7k74tMlGjvPtw3cOhEwejcExRDS1QBmo4Lexfchzekwb02ZUV+DpPFNYhnhC+LOzuLdwBNXlufmUn+hJWmxOpwoUZzpbDWndJS+xgyKFCdY3iG9PfnSTTsDz1Ij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711174; c=relaxed/simple;
	bh=/mh9H3oAlbn8BAI54Oc/iSXG8do/JnDOk1KjfMT7fXo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HpBaFiBPNU3Pd6siVKbfeQy4KI9B8Z7y4u0x9jrl+VV+lNgOQtHFikWXer88yEeajDjz1N8CUWcPdwIWTu+14tXoxcWqDQYJKDxKrjtAGo7WQQsxL6egOghI9e3eODMtfTE/1htMv4cGh/jDvNqTBgYjnRCxKEjb1q1b4LlX2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxQ1tlvV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxQ1tlvV"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso33633225ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737711172; x=1738315972; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C2VyV5hfLzkbLfIpQyyEhDFfMCq5jdZj1DMSFjoLRrE=;
        b=NxQ1tlvVBr+aA4txUG9M+XV21pTI1TYnEiJS89dPZnNDulRfzUTxiZRLTt3+XJLNss
         i78oQFtjqeI1Wjyld9VLPa60jmymKYGeuuZqlyFDrcCxKo/1Cyknx1vv/vpHvT8i6KQp
         MoTzY2w9lv0gOXqgcl7B78TOsPMaParhl+/ry5I4tOYXFxjgCC3hdK4lDhbnj4OPYwdY
         CB7dmgLDQViXnmYNrWX1OT3P1vn64TJ5ClhWqRKte5O7Qf5M9yAaCXM+/tVjvok6+r9n
         zhYbKb+mU7Zxx/14JRxVZMGhnzYDrVbCNSwSbpiyj9P5uelb9RNyC2oA1KmihBhSoL+X
         Evbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737711172; x=1738315972;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2VyV5hfLzkbLfIpQyyEhDFfMCq5jdZj1DMSFjoLRrE=;
        b=LV9EwKntLpeB5Ca9ZZuylTcYbZwQQUYLfEy8ZZJ5Xu5j3fYa5ow9cboQP1URpiTuhd
         yzqBVb83ZUcaMKgh+L2p2SYsxOmf5/px7BoNL1uu4aGCw0OsYt9Mzyra8aJPSMpMbc7L
         8bF0SaV8YI5063CHKpBhrjgRVuqemFsOhTWQtaIr62sH4XKlm09S22oWhxt7Bo2g1a0L
         tHHGdOQjxQKwbv2XzP3xazV0thIauwMkkPxuktTTM12txV/zeC5dbKGU71UcmnN2spDs
         1Wour43ncgN3/el/oZaShBwm3eZ/39QQurQjvDY4W9dd4I46WJ/PNSEpmfX5Er4yNhQx
         rWSw==
X-Gm-Message-State: AOJu0YwMgApEwF7pu2SH4xIHRqU2zgUyhf4hl2+RI56Gr/w7m6pmZL/y
	wxGvisalrerQetTyyhbNFBpqYH/JX6Dqio7VZtyAEnGm7lmLLOic1zTuig==
X-Gm-Gg: ASbGnct17b/NNy4Xuua9pfMArp6dr3+XlXtdyRSlze8a6ODyaVbHx88EeYW+BUzCKKF
	X15A+iGIU0d5x5e0K3yks2+g9JImHAmt2gBXGRZQCqZ7Fk4Ok/UPZiUM0oaU17QObA9VAUbW0+A
	OHuOZKRweOc4vtZBunQgz2C85Cm7LMip9Y4b8BgfbCajTI+s4vHSpQ7W50df7v28GP5NYLgVzGi
	Gq57yvMZ1o4QLjmKek9qRhoo66baC7laOp83ymZFGjiGD05b86ov9VPIas3e11sTUwv5dFOHYoC
	hKia3FsPQg==
X-Google-Smtp-Source: AGHT+IGjOx+oxi+5cjJYcI8g45LTRyVcZ8UEAhJURuYGfiXs0xZJ6ErRxsyvnJBaaq1xznWxwRrCVg==
X-Received: by 2002:a05:6a20:9149:b0:1e5:ddac:1ed7 with SMTP id adf61e73a8af0-1eb2147ea8dmr43424141637.12.1737711172519;
        Fri, 24 Jan 2025 01:32:52 -0800 (PST)
Received: from [172.17.0.2] ([20.169.1.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c550sm1421575b3a.135.2025.01.24.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:32:52 -0800 (PST)
Message-ID: <67935e44.620a0220.3d51df.6b2b@mx.google.com>
Date: Fri, 24 Jan 2025 01:32:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5328436084486421059=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v3] Bluetooth: btintel_pcie: Support suspend-resume
In-Reply-To: <20250124144527.3159972-1-chandrashekar.devegowda@intel.com>
References: <20250124144527.3159972-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5328436084486421059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928080

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.56 seconds
CheckAllWarning               PASS      27.12 seconds
CheckSparse                   PASS      30.93 seconds
BuildKernel32                 PASS      24.67 seconds
TestRunnerSetup               PASS      436.03 seconds
TestRunner_l2cap-tester       PASS      20.94 seconds
TestRunner_iso-tester         PASS      38.48 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        FAIL      122.88 seconds
TestRunner_rfcomm-tester      PASS      8.10 seconds
TestRunner_sco-tester         PASS      9.77 seconds
TestRunner_ioctl-tester       PASS      8.41 seconds
TestRunner_mesh-tester        FAIL      6.43 seconds
TestRunner_smp-tester         PASS      7.16 seconds
TestRunner_userchan-tester    PASS      5.18 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.142 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.172 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.112 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5328436084486421059==--
