Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1731194C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531329; cv=none; b=PAl0NDWojHTW4i8z5irwSgV6cblKVbydORLSTAFtV+ZOd/zbXvx6rh7pwo17jUcP9KqCAfS+NE38+F2lWQ4MRbGz3wVD6eVriTIKh8xbaqVJ/E+X/CZIbobJmCpnmNPt8WtKYZGPDUCS28v2k6PydM3onbYem+EU3/IaMSs1+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531329; c=relaxed/simple;
	bh=t2/uLIYlgBY8QhA0y3tdPR8UsRaYKgjCYuTH1QqioQQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K72ri6+g4NA17oGvlQMDDs7oyhcCxenPJgyqNNXVT4d6Db8k3zM2JPlRanCN2W6g80Vz89f/u0ZNYek3DUmTvtqXmMyRWEFBKhhI/F4b0Awujq2mhXXXKM0vaHZjq/m4lXYr6J0kTkcMpQpmlNuAJNCpmRvZD88HHuyhf+zwNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASr1wMQ7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASr1wMQ7"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d00cf835b7so132123585a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774531327; x=1775136127; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uFDjso7umbbUqBX4IAt4+s47ts3/pGhvEzAXi1OKdGc=;
        b=ASr1wMQ7FV7gjPwLXkutCOwgMQwHLg6GRnRPCSPINaiVqdr/Ibtr2E+pdRcZJ5hB+p
         BkrCi39vjs+IpWV0t8G5z+DMrF2PGW/bv1NGNZiTO+Pr8gKhn8hzPy3MzD+dTLwaG2dM
         0APqefeZoWeN9bpY3LeCQV8Gt6ZJSQKG05R+4+QpSZ/HH2bh8xXZTQ7GoACYdDqQFnB+
         +GKQuUA8yDzJseNXq5vM92GXkmbTSdxHWXBsRL6m5nvUWpTFvKZdbNmersAqUZi0SVvX
         YDbTWlp1zL3cRoiB3kP+yKNEuRtmCV4hFfcFSj8Bf8Llmy95i4P39MvXeGzUHgoF+TMW
         x2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774531327; x=1775136127;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFDjso7umbbUqBX4IAt4+s47ts3/pGhvEzAXi1OKdGc=;
        b=gScHQGa9yIYkKr+V16JKnUISOnqvNy/L3QKbD9ErYFdjuLurBTiYOP1fhKorx6TYCG
         4qFZtDkvVnuI1yjmcGiW3PxHlOqvq6Vik5kGjBAhKVttVNX1CEh8nS1lSq5msRqVcE4V
         Nx7zoremZriiENxd9VUJZE+IM79MDLB7WVPM6NIQgq+2mid3R+j9+z6VmmIEhFGa70Mw
         6pfVz+BYaMDwfPQJeSAoxBKdW6WCiQsPAqzggFN3fgzr6NWLD3U3GixXdGIYsbdb73sE
         LJwWcjKZ+nxAH/yDnkANM1ac3GoClVNjk95W/nJHpNvZY+MXcS2LDMNjvrE6LiKhF88F
         VRSA==
X-Gm-Message-State: AOJu0Yzn3StWNREw3CiyjyV7xUT3/29YT0UT/DTNalyjWZYsu0e6OUvF
	VBqlNFfVH48SxCyyXdCHoovnhZfRB7jg1gOI3vuZ4G2Dk2aXCHN74LQhVs6XSA==
X-Gm-Gg: ATEYQzxDf2+iujrvhWW0qVXWloLbVRe5Hi5CYarW8RZf5D1cRhUY0lKQhKdq5BmzoiQ
	ADZTR5666sx2AMp8uldCdmq2UHU4P3LZTBPvKo5Y5HlzwrAAKmCRA6s8IK+grz1feZ0ZVf7yRJc
	9jgfroyNYrKSPUTzCobzD6oa9wdpt2XyavtQ/i1cIAbTx/JQl/aXPBZT6mAwoPfzhqhNDrWNEAJ
	d+MAQtDD19aUdonMPp4/48aI9s9C7AH59o3AA5sTZ+HGSKAcUdidlYAWelh3moDIcYGiaOQtCxh
	3abAz/He9GZAa+4PCfwXvb7+vgIE4JG3zTnfoPOBux0VbPYzGKxrNLeodr3xzIEcWK3HXd4tiEw
	QB+wVcYa40NA+L3ucWUcSBmdaBPX+EF+fWppN9Cqe3O4CT2v+u0K4JjCUFc3vChfdwbaHXVcLFn
	ODefiAMA+/gvt5X8/wtQj66053pEwnmMiZuKIISJ8ziw==
X-Received: by 2002:a05:620a:290d:b0:8cf:c4d7:df8 with SMTP id af79cd13be357-8d000f3b1a4mr984340585a.17.1774531327184;
        Thu, 26 Mar 2026 06:22:07 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.116.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3c3a18sm257826285a.12.2026.03.26.06.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 06:22:06 -0700 (PDT)
Message-ID: <69c532fe.050a0220.209e41.ca44@mx.google.com>
Date: Thu, 26 Mar 2026 06:22:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0917059897826924803=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: SCO: fix race conditions in sco_sock_connect()
In-Reply-To: <20260326122842.13664-1-zzzccc427@gmail.com>
References: <20260326122842.13664-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0917059897826924803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072938

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.65 seconds
CheckAllWarning               PASS      28.94 seconds
CheckSparse                   PASS      27.81 seconds
BuildKernel32                 PASS      25.66 seconds
TestRunnerSetup               PASS      571.81 seconds
TestRunner_l2cap-tester       PASS      28.22 seconds
TestRunner_iso-tester         FAIL      34.43 seconds
TestRunner_bnep-tester        PASS      8.59 seconds
TestRunner_mgmt-tester        FAIL      114.33 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.46 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      12.49 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.733 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0917059897826924803==--
