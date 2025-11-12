Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9A2F83C0
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936888; cv=none; b=La4ViDfyaW/KV7SkVv0JxM53JCrbNaxVAePSCmMYY36gDDVRcBEcUIBZue3omq0sImBol8l9gXpp03NhIRPKxX6pkMt2Lj80A27G04AmEG6QDv46p7NsYptkSRKEJ4FvUPl79uzI5qBPzJDDsb8TIlPkoieEkTaQ0r+erg61gZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936888; c=relaxed/simple;
	bh=lHtnD7/AEblE43vF/3/09jynEeqcVjDk7zSPtjPssbI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=khjQnxYkT1tZRluuEWoYEIoIj68bHvnEkcqWHfV+O3lW/FbU0SeGsAdqG54HZ/YrmDs9DzV9z6+YuY8NAU3nKM/1qN6P9omVXgVFyGfQm9xVNdIvm5c5lZSzyYZcO4QahP+pnsepFpAOeBhTFEvE4sCM3GguOTUd7IxhBqmD+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8mHDGcB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8mHDGcB"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso382791a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 00:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762936886; x=1763541686; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SwfTXFJcAUkG9LIth0n7NZji2USvUw20AvjlcWHF7cU=;
        b=j8mHDGcBvYIahdwAgeKJE8W5mQxwjxhB5kCGn7yjSakSOY9Gsi4c5jeyCA48YZkJuZ
         7M3WBgSAMLWoB9ikiwFIsxjo6S5bcgTsQdmKS5iMeV/GtmtcRFmH2s18RyWUZV/Lwibb
         Zg5diGKTsHDICTAv3BvAYajH1Iq0uEhucpV7KrDyGiycjVhqa0Ojertsj5YH7oi3YDFn
         nCTPYgnCObJ3q6H53KWYmlDNf95TXY4uKE3kfEirkevuz6JtwfpD2GfIj41AihNbLINZ
         gHTm5qM9Xcv4lktcu2qTBIsAMX7zwzgUBmn1Qdf0X/9/r+TWxmj98YKGCf0hD9X0otwx
         1qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762936886; x=1763541686;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwfTXFJcAUkG9LIth0n7NZji2USvUw20AvjlcWHF7cU=;
        b=Tn0pLRVCw+toaiRkCjXfELVp/MvUulFUCLq2VoSEHXYLll/KDUd7FVFyTj/VVdsSM6
         GlqvuKR+ktaA2jQX7EqlLSbIc7y/TArURwEOC1ARa80FUSLhA/aZ3KasnDzmn26yyqYw
         DfPAUQ8yb8F1rvliyAr/0QYT8TtN531uhfDl9/gq/GPHzklqGoNVAa6ZITrfydBNqBme
         R/XCgABfeWn/Ovze8U9JEzdf8xkI8BCKts2gIX0WrsQakoah9d+aAo+7tWE6bEh67LZK
         riCzjqQTjUeg/s+FJRxzeZZ7TvRt9iu/4sC+t4JqXyWkHpuckuB4azSXRiq93s+pGtYq
         aqZw==
X-Gm-Message-State: AOJu0Yzo7nZy3cw4TuDAsa3MJ7MC46GXtpOpOvY9uQYcOCBHZe5B5pxK
	Qv6Ycop++roC+W6IX1/J/DnyOW9WQ66g6sguPMVRKImaWvmWUDIYfasSzUSAfg==
X-Gm-Gg: ASbGncuNaqm175dhj/IwsvLj6DQSw86dsoKKFbj3tdt2/MG+XbkOBHu2cxE0OO+wPeZ
	AUMn/dAA3faus+EzH3PQ2YnxQAll8XxXNpjaIwPmPBD6KD4c2Jb5qzpcnMP+Dwr6DY2HevwLswu
	qkrpp3n1wVVwVWDMXLfXZpQCI1hP4GFdiL6+KhiHX2Cs5s9S4J04ezT8no8j2j1dav5ogE5Wv7/
	mHxTtbQ4AI4SD0e8C1lPTq95cJsqXcCOOK6YYz+wBgq3bH306k/alK4wjpE71OAk0a+cjNvfJH6
	hNBxkgewszsLvQituQrGPPWpQMN4HWQmfdOlqV1+Gm525R+R9UTNi3v0wSyOb21qs3ZDii7Dp/k
	jI4xNqXYzbftqtmWHTo9hRFlTp2f2cCnL1yOviJZPrvB1KyqY6eqdSJHHix7qrBAS19zk0+SXqF
	bxNl18
X-Google-Smtp-Source: AGHT+IGV49Ta4NLWel16gVnGmRQ9H/g5Te0ZqhArSJRHm4ab13xcPcheiwt/H3zYH3nMZCnNgroJ+A==
X-Received: by 2002:a17:90b:1646:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-343dde1030cmr3020372a91.6.1762936886401;
        Wed, 12 Nov 2025 00:41:26 -0800 (PST)
Received: from [172.17.0.2] ([52.159.229.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e0766493sm1792085a91.19.2025.11.12.00.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:41:25 -0800 (PST)
Message-ID: <69144835.170a0220.120a2b.46f2@mx.google.com>
Date: Wed, 12 Nov 2025 00:41:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4843764424659543041=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] Bluetooth: btqca: Add WCN6855 firmware priority selection feature
In-Reply-To: <20251112074638.1592864-1-quic_shuaz@quicinc.com>
References: <20251112074638.1592864-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4843764424659543041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022363

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.77 seconds
CheckAllWarning               PASS      27.97 seconds
CheckSparse                   PASS      31.95 seconds
BuildKernel32                 PASS      25.03 seconds
TestRunnerSetup               PASS      501.13 seconds
TestRunner_l2cap-tester       PASS      24.11 seconds
TestRunner_iso-tester         FAIL      43.27 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        FAIL      118.50 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.31 seconds
TestRunner_ioctl-tester       PASS      9.87 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PENDING   1.07 seconds

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
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.195 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.968 seconds
Mesh - Send cancel - 2                               Timed out    2.003 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4843764424659543041==--
