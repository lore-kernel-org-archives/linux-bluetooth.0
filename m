Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47331F099C
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785475106; cv=none; b=FzBP2H6fGLfsMesE5D7M6CGKGIW1OFH3tfV7umFyEHEa5Ym3YLpYG45gmRWDp1dBm6KWCgBPuyg5q7wszumD2UNZ/E03QkQ+yHRFivkSNgyfw7npZlSmA01ox3AA+wQw5ykBKss3ecO99kMKjLvX2xQ76DFxE2pxxWLViiRTc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785475106; c=relaxed/simple;
	bh=6Of3Jdbm5glnf8qWjJOHAtEcy97Pwctb270wCI1tWWI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UGZaCiE5p0ObrlZ1oLqqmqgVQWxILeWXe04WaEpT1B6T0XKlvokVYuY1o1NSfCaNLcdxlRi10mhqMAPdnoh3vv36KqBXONnVoe9F/2H2bbf+TqHdweQAJmfL7im868IT/4MvwnsSmNhJtN5tL5F2TIXXPnz/az85EhYFWc7UcxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaER8sQf; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaER8sQf"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e602d2c0fso97348085a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785475104; x=1786079904; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kOcTp/5BLdACSZm0V1fobG/rv8cfG5Q5F0KAGedLY18=;
        b=WaER8sQfpZZWyu8G4tLBKhLiEsISpAbtm4/7S7308BMOILA/Os8a4XfMXl9u5XAmg8
         1yxuPidXKogpcn8v+ekEX0SRUJEIXb1WUAMuE8xcyI6GfE3l09gv7Q5wC1tDE8y4AJ1h
         QMqXMpKVBMKv1PuYLRr+dfT6EStrr8XtiE9NQeoPxGklPcTBoSSsTBlGMD9CFpiqFyd3
         80nqC7PrNKudU+oABSDJz/1gC7v9OGgRoEF8XlbxW5IRdWBbm6WreyfFxdBLQ7FX4v0Z
         vP8oJTjuF6vkXF7bdgLhlvcF+A2xHHDUFfwaXnbnQxnihzA+RpZ2burOnGU7ZA/lqhMK
         K4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785475104; x=1786079904;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kOcTp/5BLdACSZm0V1fobG/rv8cfG5Q5F0KAGedLY18=;
        b=pDuS3VuazhcKJHOuNqUV0EtgW5A4QrQrl3gXMEvtCo4PVdPPN2T66parx1mVgntEYb
         2SDi+RKiZEVRcs5A2fuu5+2fmokgy5YzD9pBfppGMjOkbgB2j3YiPUN40BgfD5ax+W6c
         ZyXFkMlz1ZIM5IFDTXqcjvq4WNDpqHPKq+E0ysTf4uQsjlDod/khoUFoWlSQUgqOyCE/
         OX933zOj6viDyxEmhhc8Ix0MMGSLpgNd2a2Qzy0OHJwB5/UyJiBcysP0gaZzsp7Rsxcp
         uw7DXwUn31VF6YZpuEgywjLDl9Hgjsxsl8VZmgHV3/CTvYJang2VCKR3x1G186ePFSoE
         ShJw==
X-Gm-Message-State: AOJu0YyjwTc4XEvXKSIjT7ZYL13bpKO0GKPqMkyiXAlaXHfnMbWAEwxx
	GjC5VTWCQgPQjIQ2UrBBHQM01n88XPi/JBhG58VcsWaRl+4L6MBnpeIkdeTEWA==
X-Gm-Gg: AR+sD11N0+KsXkaOK7XN3t+JWgro8TYKngvIvgzOMQ14nfB6zY9N506u7UQuoXTFpYJ
	7sOZM9mRkyNGNkafEabtQ4ekZFthrsCYi+LUlQIFS+mPpHL3TrX+yCZdntcne1vxpqEX7ojn0dR
	6rBBvXIQqe4oOteswR0TJcH0VEqTJO+W4dzKNPguGTQSv/lt+s2Cvmbkkqphatih+gUbEhhf3Zu
	//hbNKAHlNK4D0xI/lQGyE52e9XystTQSx6O/iEVA1vbPAIfc/8mGTwB2j/VNbYzKoh8MryN+dh
	EU+yCYb4wTo0/s2KD1uZFd095OaIe4frRq1Uu8UmWfkWVpVoN85CreO+ztcaRxBw6kBffWuIvv9
	tVTH8o7ox86N6VNHqeufeUK0S80mCl3NPIeYprt5Grvwbrm/rj8sDdqRCKrS7bPApGOKvr/8IiM
	Y7pxpL65idQCaj+krIg5H8vLBVsZYEi7i/C/IVXz+B+oNbYfVpTlEyDCAs3CDXuKIPdRcxYw==
X-Received: by 2002:a05:620a:708d:b0:934:8f0a:c68e with SMTP id af79cd13be357-93497427602mr41423385a.5.1785475104517;
        Thu, 30 Jul 2026 22:18:24 -0700 (PDT)
Received: from [172.17.0.2] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-934971a5b69sm33931985a.40.2026.07.30.22.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:18:24 -0700 (PDT)
Message-ID: <6a6c3020.0ea1c686.2163fa.ec6d@mx.google.com>
Date: Thu, 30 Jul 2026 22:18:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4166971711103936745=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: mgmt: always reply when a queued mgmt command is cancelled
In-Reply-To: <20260731042920.2431343-1-shuai.zhang@oss.qualcomm.com>
References: <20260731042920.2431343-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4166971711103936745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137868

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      25.80 seconds
CheckAllWarning               PASS      28.43 seconds
CheckSparse                   PASS      27.16 seconds
BuildKernel32                 PASS      25.36 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      472.56 seconds
TestRunner_mgmt-tester        FAIL      227.65 seconds
TestRunner_mesh-tester        FAIL      27.03 seconds
IncrementalBuild              PASS      24.56 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 488 (97.4%), Failed: 3, Not Run: 10

Failed Test Cases
Set Low Energy on 6.2 - SCI Setting                  Failed       0.364 seconds
Read Exp Feature - Success                           Failed       0.244 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.468 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.681 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/521

---
Regards,
Linux Bluetooth


--===============4166971711103936745==--
