Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C839E190
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282443; cv=none; b=WQJeuFBWMaFB2iiZAxJDB8was71r+K0UvzodxpWMq47z59ceSsRfXXrHrOI1aV3hiGz8Q3jLjEoqs7+1dbRBQf7kHOFyLolmeybjtT1VZflK3uw4p4GQ7twqPbqQyXb5AcgBC6AY3UDRhNyqBgCLLu61DEVRqbHKcao6Pq8QNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282443; c=relaxed/simple;
	bh=BPYpNUUYSQ61Alf1v1TDwLS8T1FhJg+E5V2Gwg2eBmE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CjkrfLDGKdQgz7iojNuySpARhtZQLsFgmcmAMcvhiLMV9XTo3zZIpOABCKfi0qNp/VFRODp7+T1snwI2zlMoqNx6Rc+4O17BS1KHuWThiXZOZg+N/rhVQESRddYO80ny9TPOJWoNmLxDLjPo2YwHwdR+Nz0lEoOHlTEf4SfALug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDlCdf/k; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDlCdf/k"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so46094a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282441; x=1788887241; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KXNHsUr0RZEzET4epQem9MiDYvhtFA6TwVbQYq/W2nU=;
        b=kDlCdf/kksbC0PTa41ne+eGXkh0CkpjiXTJ8oNOLN2in2yR5MSmbA6aC1Ks6YABDqu
         Rau8tKTj5Dj0YBroCuTTXHUduNEMsEIDVNwajH8ECJkx6f7wipoB4jx26wU8WC5IZSyq
         uhXkzWE8VkNfI1nrpVn4YTJMSvdvMHiYX9DIzZrHA4JTdesIN/Q33fQprJgttYDmGQr/
         a3zCRybvXW/GFhXIFcPxNo1FabHQHPd2lBgVb4WTQt4fgACQpgp+ldLfuytJAWQFDh+I
         fD5bK17XHUquQHYFaA8ZbdtrbQl85ZxjhgB/OTZbjQD3p1bOwhHsGt48cCkiOy9zvBx3
         CmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282441; x=1788887241;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KXNHsUr0RZEzET4epQem9MiDYvhtFA6TwVbQYq/W2nU=;
        b=VurvDGnu+VNhGJW5exHOzPZ/3SGdO+5seIyelkDqgiFpbUJHXF2sPKYCevcrBhR4+x
         Doz0Jl7TDX8udYoeMFsvql1PVJCkxrtDmmkqF1BJlo2MDX55Up1FCIUTWvgsh6uqowkc
         kYFK5li1NuApScJGyBFUiA9vd3qQNpVEpzPsvkID9/7rjR6cC1VLmMYXaG38KrgZ0SSm
         Q47aKe6WCXmRnyATzUq8SZa6zEv8/XTX+ZLoDczsT9g2v7nUlkc5It+Z/wpBM50u5TMt
         rWmZoxRg6PhsWNbzaNw9urgiAXRifI+TWT6rwb7dpivLkBrQVo3jVGvsgvfV9+HQJzQh
         /1pw==
X-Gm-Message-State: AFuF++lEwngBtSTI1Ugn414Qg7bLws+Ei52UPrH8yzLk9sjevGHlesai
	AKGEsWW3lBpSlfGoP+ujrc/OaaZmJPwQNcv4/BUUs1Vk88v6Bx8xPusvrxc6WQ==
X-Gm-Gg: AYBFou0Ii094HmIsE6UPfPd/1dCCGr0liIJRsVeLQ+RHaEgMoeiHTN4ax7kZlr6OhSH
	NCOBo7qVQ279tdvj0Se3ahGZ+Y+LuMkQtONBoHA1aQC8j8WzKuxNRitfsbMiEWguRbTVoz9qyH5
	+8HDqPZhYT53aVgCQtNmp9deZZTg7soqPYRfuG96eMOGlXtRbe07yG+S7VmVttUkDzqUWSccog+
	smDC5DZPvTC5ZgDUHVkP2jg8Io5AX7hQSzd3/Tz3jqzmCOFu7d4XJJchFskd5M2ENklQ/djSzav
	fO0qIWst8lEfhyinopFDfF8IpxrUnulMle6Fr1maq1zR9f5LupGqCZaf065a/HBVly6F2ra6sPE
	CTmfe7BdmlaVVBofG4yF3hWvuS8vI5GWt2YxrvGWCNTQs4/cnPWAhlAv8vyYXsj+sUeor5Rbgb7
	uvtH9rsnrXrZ0GFrTlSDKqEpMRsoIaiCn3D+1vJSYJ+cgzmZB1q+kR3zsoNGRcHFCR6Ew=
X-Received: by 2002:a17:90b:314e:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-398c3ca354fmr28397234a91.18.1788282441396;
        Tue, 01 Sep 2026 10:07:21 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784857sm38677026eec.3.2026.09.01.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:07:20 -0700 (PDT)
Message-ID: <6a970648.557772ff.f1661.edb2@mx.google.com>
Date: Tue, 01 Sep 2026 10:07:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6022001436303627869=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lee@kernel.org
Subject: RE: [v2,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
In-Reply-To: <20260901154427.3991920-1-lee@kernel.org>
References: <20260901154427.3991920-1-lee@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6022001436303627869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155482

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.57 seconds
CheckAllWarning               PASS      31.59 seconds
CheckSparse                   PASS      29.62 seconds
BuildKernel32                 PASS      27.44 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      510.88 seconds
TestRunner_mgmt-tester        FAIL      233.06 seconds
TestRunner_mesh-tester        FAIL      26.88 seconds
IncrementalBuild              PASS      26.40 seconds

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.262 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.732 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/681

---
Regards,
Linux Bluetooth


--===============6022001436303627869==--
