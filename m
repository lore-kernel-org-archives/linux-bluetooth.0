Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C63B3C0C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565039; cv=none; b=H69K9CSLiQqsYLfzFH/IUW29vsL+iem85YsNNNyCfRU12g7yO6Xum+wEd/ZAKMeS/T2kH7Qran5o/gHERLgHewwrmNOrH58qaG/CNnmGVRXumQpB1SRpds5DqnJi0zZZXWc5nVW7nT/DkRNZ0219nNJb7RCX5nVaLc4WEE+tCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565039; c=relaxed/simple;
	bh=PfQVsweOVY8q0zVO/86wSNJt1czQShucDM/McOaa4Y4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sOu+zELMR432BXN90QUGty0Prt/CybJZsZ+EE/NxWT2LEeXI8xwjRvAgSzV3XpKRP832ryD3RspsP3/rEx0La5eqeora6ANt37qzSCceS+EXs3dyqXl8UI2LS0pliV3b6VV8TsPLx3EdZyqziNQ6rHW+3K3Q5ZNxOAvR1RxwPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkmzZsIN; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkmzZsIN"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfdac74050so596668685a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775565037; x=1776169837; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LiF3T9JlLwXmlHcZgP3arwRoE29/KtsdxI8PiO++/cg=;
        b=MkmzZsINCBJOyoHLnvnSSHUtMR0gRxsjTjaRq555hN7O2TD4HBut7FNrlaEsbFdI3g
         9EkmtSKHe2sPt/Jw63Jk1ii0g77j1DwxRGuDm2msQ5UGwfOQB6Cd7U+1rQQGFwgscRQl
         mdatiMfnZXYIHgT4YirisaCaqp+zeTpepwmE3yX/GRlOXFtMDlfXq5ojow11CfWRVAMq
         8DeLbVqIn9nv0MlZ9mtw7R51yqRttaZ4z5jgb6nRTFf03lZ3RLe2jxclZqGCEMXdKY3J
         GjjBuD5zp0VsuPEr2vQIJjHSKKb1SQmTondGOkCMeFbuYiPiljqpX9l4O/EEyKG/NiCL
         fLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565037; x=1776169837;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiF3T9JlLwXmlHcZgP3arwRoE29/KtsdxI8PiO++/cg=;
        b=C+dZEUDBvt/4EZix/sIWPIe3Do9XDovdeAiDim+tUHQzoSW0WakuGeJq4M5IzqpQMW
         l3lUl80UTKCYeNzq4D/HlQqPWsz7NZzoQ3KDK4AYg0hAafl2/HlR3T4j4irjOiHlDRkr
         pCuJLHDxboT0N51wp/EN5ckSzTjg3oJz7qKsu7UbLuN2+wc7r2ORuD1lhMtGol1BU8Xj
         4NDI2oHZ0NfzJ7dUY82ziKlQsNEnX7M0HBa2n96n3u57nn05+fgmqqNpbnEiMISJFJ/V
         wmpCwipLga/43UqQ6/QmNgmRhoQbXbswJ61lEW/G2FtlwmKhbC4Bjcq2AYrhJbiRiokh
         HnYQ==
X-Gm-Message-State: AOJu0YxG3RTUq5ZD62IP+TXpLC6P6KyW6+9nWHYe6+PDslQfjpvfaZ/l
	sNoVctH8Aamv4avFX5HIfLZ+1GVPaHifGzL6N9duLnb7O8stERQkMKjZvy40tw==
X-Gm-Gg: AeBDieud5Bjv/SPYw5j8Vz2Eg7AOVH0g++II0lXePsVcqBKg2B3rrqFifzaApZ08+5y
	1UW222uS+wBJObIoIrSI98/GiEK1tIO7zhRbonKyvml+ob9TWjTCvkloNVeTuOMQOZFwqZhERB8
	44u+/7z+7yNjyQplgo482EbzxpJj1Bpn28zsCeVrc2AETzwkDJ9TrDN4cK4DjnMRy1HAwcEs3J7
	O54GVQoQY1d5ZNm6oVL1OTaQfLGMgtLtyH9D+63MN0x6JQRSlRcJpDuFrUpeV2k5oouSwPjIGMd
	PdaIwVex2PFQbEaZ2rKA4KGXbY/BwT7DwnepeWQnXVw5IlUk7LWG1X8nflvN743Vz0tlClHM3rh
	qssj2I8ALvea3MTaEtSCdzgwGJHOVxMyF/Aly3kDOeRixcWLZCy84EW6JdELqcsI24yX2RB8uWr
	K8i5ok1BplbdV+7qNWvD9GyzbCwwWskMVP3TFE0U092Q==
X-Received: by 2002:a05:620a:2844:b0:8cb:4d18:bb53 with SMTP id af79cd13be357-8d41ec0dfe6mr2343433885a.64.1775565036506;
        Tue, 07 Apr 2026 05:30:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.119.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5a6764esm1350206685a.13.2026.04.07.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:30:36 -0700 (PDT)
Message-ID: <69d4f8ec.050a0220.c64e0.8f48@mx.google.com>
Date: Tue, 07 Apr 2026 05:30:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8449304564358802206=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btmtk: add event filter to filter specific event
In-Reply-To: <20260407114851.3087886-1-chris.lu@mediatek.com>
References: <20260407114851.3087886-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8449304564358802206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078124

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.90 seconds
CheckAllWarning               PASS      29.05 seconds
CheckSparse                   PASS      28.90 seconds
BuildKernel32                 PASS      25.66 seconds
TestRunnerSetup               PASS      573.77 seconds
TestRunner_l2cap-tester       PASS      28.14 seconds
TestRunner_iso-tester         PASS      44.53 seconds
TestRunner_bnep-tester        PASS      6.49 seconds
TestRunner_mgmt-tester        FAIL      116.25 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         FAIL      14.51 seconds
TestRunner_ioctl-tester       PASS      10.54 seconds
TestRunner_mesh-tester        FAIL      12.59 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   1.00 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    2.619 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8449304564358802206==--
