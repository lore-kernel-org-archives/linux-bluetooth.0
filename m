Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053BA3E6DF5
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974091; cv=none; b=bFjcHHsWIxqJbxEnAywbZ1+M2uRPBgh7SS2xLsOwo1/FL/cW2YNJZ4jLU/jzNASya6xvXqMb2REHwljLPoIVolNSpumrMa/XXVsBM++HiSEDD9ERAR3ZQPx0r0Xo1dHd4RpjGr3icfUbwuUyAX3F5X37cytnUk0ZWAmhqzvXE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974091; c=relaxed/simple;
	bh=yb83Td55xp54WnwXH3BbtnceneW5sBcKLth+m/WkIwA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s+jabNG1aiqILDed3ZyJIfUz/mm+WAvVjur4laJVmfbkEdqPA7JHjnSSdFNDA4sLKLzbFnh/CsGvKvxqHsufXmgDTzk4OQGkdw3w+ne8OjjDpH2UvH5cGUOJoXuZd9+iiTAjT9G/eVbaBmH06vlR3VlYbbnrVgzXhsbDhctNR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLK11BhE; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLK11BhE"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-34bb8b31647so35558eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790974087; x=1791578887; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zqbMmxDGCUT6PyJBxQ5lmNaR/1qLP4baNfdiE8w26BA=;
        b=SLK11BhESEbkvMIz25fPPDogsQhHEOerWaFimmptTv4bx0ZXjGdK4gD+vBHZIdGCdH
         N+FkEU3ea6gMbiKvXKjiK1O9BojO+LdQ6198Cua7JpT0cOQSqsPCO7oZVfYh3kwP2hu2
         SD3tn8iihy7Tj4RG14x3NyZyuqq3SD7dWBGchhMBFjQK1jcaLWNSlxInyynouk9SA5i0
         ZYHBG4Qt0MC5fPUNRYpYNnHgdEbtYFtQVDpFm0OGpIcmdXUtHENtacKp3Ogi27l8eI9q
         hUiR2/jiyGH+a9QYhmbC13FOdurlFNOu+6+0RbOl3rshTqF3jqN9MbnUPpeYYduzMmJ0
         SYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974087; x=1791578887;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zqbMmxDGCUT6PyJBxQ5lmNaR/1qLP4baNfdiE8w26BA=;
        b=xvwnaskxpzkJLE6VZRlkN333RvYOqqic+DqSNm2DH+N8SqUAvDfeL9QB5Ypm47ZneX
         Ucw9JhO91xRDwL0+msa9fYzHNLKrtuOzyCgv6Cyvs7CoZrH5u25Tg1CyIYq//trP3e3x
         Z/Bq0dAfKBYLRpBV1EIcAPv3j6DJB+YLR2NcMwXT519mbteuNoH67ALqxLJyA/yolxVn
         /TkEVXArszuioaMXo6j+hZEnBn9YPzAFPTWEviS4kYg09sJypNtR1yat4b6e5XujY6Ux
         vWE+Hr7o9/2Jt98O00enRs+QuYujJzItbYbxEkLO+uVpV8tjsYN2kxSYijxh/yOW8O1n
         qa3Q==
X-Gm-Message-State: AFq9FYJXjme7yG53M6vP2pAdOfnXaGn8j3adcDTTCfdhN7GxM1mlNyzB
	xRsAWerVfOnHa9+/kv2aQ7leI/zxZKZ8BsU40CZ73wspBB1oQAwfIIeEeoNNepr7
X-Gm-Gg: AYBFou1rNB3DjEcpDO2JnZ/THk/Yhou+F7UIufsj7hcTcj18Ze1nqyw2phYTBKMw6Mh
	zmnhmQK+kBaO0lVMlKH93Kx4lSZrdPIVhDl30K9l3OrybEG1832sguaWrWiJIwGxAVxrwCevMtB
	vQJdxlIqEf/ooyu0nRUWBqmrOhrYnuwHjEvfXLtHygo+lgIhQFaoUH6JpYVtmg7i7SWU7ZuU0r4
	7BmqHiHDQsLD5iYByr4xXEkDDsfXjSm2m2DNvs4ff49mOQWRSPMOdroDKCBv1OknrsHmGxcJ979
	jHsWgqAG36p+CNYdhQe0FefemwePdAAbJORsTgF91FR1VvvMi0n4TKzpQvP6CjZL/oJGkz8mTdl
	EEbC5ViY55ormky1IoE5ePtxZcfZ4D/UChLNe2Odtz8KqDuwPnrdKA8iy0m4vy0N/CiVCzd36xL
	M4T2Bfla5yX35QIrbP+sTUFJYx+JLul+t8+THnEszpZqnWS+KZqdFIqvV36x+xm1Etpamd/sSxg
	uJyXGQyXEiEqtNgaqA=
X-Received: by 2002:a05:7301:5f18:b0:33e:d4ae:e10e with SMTP id 5a478bee46e88-35111552a86mr702495eec.40.1790974086323;
        Fri, 02 Oct 2026 13:48:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.202.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd5620sm8787737eec.21.2026.10.02.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:48:05 -0700 (PDT)
Message-ID: <6ac01885.996d28e9.b50d3.e84b@mx.google.com>
Date: Fri, 02 Oct 2026 13:48:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6939172605858989224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v6] Bluetooth: hci_conn: hold a reference for LE connection timeout
In-Reply-To: <20261002174658.3596771-1-nicoyip.dev@gmail.com>
References: <20261002174658.3596771-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6939172605858989224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178509/

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.69 seconds
CheckAllWarning               PASS      33.33 seconds
CheckSparse                   WARNING   36.32 seconds
BuildKernel32                 PASS      29.54 seconds
CheckKernelLLVM               PASS      35.12 seconds
TestRunnerSetup               PASS      798.47 seconds
TestRunner_l2cap-tester       PASS      12.55 seconds
TestRunner_iso-tester         PASS      14.67 seconds
TestRunner_bnep-tester        PASS      3.07 seconds
TestRunner_mgmt-tester        PASS      61.41 seconds
TestRunner_rfcomm-tester      PASS      4.48 seconds
TestRunner_sco-tester         PASS      5.60 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        FAIL      7.81 seconds
TestRunner_smp-tester         PASS      4.29 seconds
TestRunner_userchan-tester    PASS      3.16 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      27.99 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.396 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/853

---
Regards,
Linux Bluetooth


--===============6939172605858989224==--
