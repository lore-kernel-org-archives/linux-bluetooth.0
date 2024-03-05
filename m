Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA365EC2
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649156; cv=none; b=i3bemghAILUMojhbqLrKBJbs+oMqGYUYZKOMavCF2srsnQ66AbJYSHDzYVJbm0qxbLKGkSTtmZ2UEZUnD/yDOBpyZVjSqXMCxqA+FhQfhwl0RHRCWR5cujFYNB2EXvRC0Ux7Qq6tAzsjpdx6aICoswOgWQLtOC1A9H8tlCNH0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649156; c=relaxed/simple;
	bh=WMWzela+QS0NUtUvJrZg1JSdssvrWS45DwxY0OVSC4Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BjrEdn8tnsSxXx9ZEliuweBLphz0x8awfd3NWpWXoCe+5ewte/IXe2/DxnEpI/V5aGoHTf3csQUto2gflxq0dREWSDfmoU0l0+ytCWA0+yfl6Eze/8a54Onl031837wv6HN4iWFrlLHSoU6ZQIKWbxNeg05Tu6si9E0iyVJj//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZdI0+eb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZdI0+eb"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42e323a2e39so48218091cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2024 06:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709649153; x=1710253953; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MUqKStn1Y54bP5L84iyxa0E5Y/1Vr4x9HURDDQ68Z54=;
        b=EZdI0+ebqGLoA0zjVJnBILYvw8ntXbcXXvGmwlZlSYww+vGM0bN3M17RUcz+IsRzan
         Dvi/hdmXf2XBOSummGqbOODsJ+jSSTN4PgMMTJz6JzxeQOHRhTDUxwtgdlWJKrW7LIay
         tEqoAtSEsG/ecjICZxNjgmRLcNnj9hkBCdLWMQfDF938K65Qa0lxVpKbFIWnJxk2MEqA
         h4isTOgC/IccJwOF4Yk5i193TUhfKZ2asyrWlL++OcuXQLJk7kkTO0sskFGXKztRksKy
         r0atk0bzayOuk0xFs35gxLJ/u1StnxOSKbsBxT64R6JT1aiJSHorVx3KsTMXm2MY1pUQ
         mQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649153; x=1710253953;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUqKStn1Y54bP5L84iyxa0E5Y/1Vr4x9HURDDQ68Z54=;
        b=FxhuC9NI0XWChprZmL6JEneSWfPKTmhqYvBudViLJFEgvsbrGZx4UiT/rCCrDeQ0UQ
         MMiM3y1MJt8Du2bApV7L8xL9jL03KO4VLURVKbOYLf/ZAQaxm7JhGtsqLnjTEXCVigho
         Te4uBtoNA9EIJAjlspobagRNm8i4Mc+HCRNUO32j/KdtZKyeDSy9ONs7oKVxekpiJZsw
         MJmrN8Qv07cpeP0BSCfYYsX4EfnOYrJrQntc14mAtEGgsmPyREr14lDRdXeOCprIfcX9
         XqlVYFfkIoxbT3kEnfrAV+bd6618kBY+Wt6QPiDfa2elkfrwpyegJLRvTPcUW2aRV1PE
         UMdw==
X-Gm-Message-State: AOJu0YzapbzAV3rqLEK+VhqzhOtsD6r1PPz/IK5j6u4DnLVxPbHF8XCG
	u4F/kPpuoIQ4Zevm2uCi2K/HP+uDDAbkUyd2yHRKHNWpAxnEhN+Q7jV4RfH+
X-Google-Smtp-Source: AGHT+IEcHVGqA+Og5qNGrXVDxiuTEjWQk5LKp8z2/g70je/jVtj8CofDpEJgZrRd8JqU1BqPDnNEGQ==
X-Received: by 2002:ac8:5f46:0:b0:42e:6b2f:e7 with SMTP id y6-20020ac85f46000000b0042e6b2f00e7mr3217019qta.26.1709649153635;
        Tue, 05 Mar 2024 06:32:33 -0800 (PST)
Received: from [172.17.0.2] ([20.55.126.41])
        by smtp.gmail.com with ESMTPSA id e12-20020ac8598c000000b0042ee2bda028sm2860435qte.54.2024.03.05.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 06:32:33 -0800 (PST)
Message-ID: <65e72d01.c80a0220.42f4e.a76c@mx.google.com>
Date: Tue, 05 Mar 2024 06:32:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8622509846246408331=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: iso_listen_bis fixes
In-Reply-To: <20240305140939.5090-2-iulia.tanasescu@nxp.com>
References: <20240305140939.5090-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8622509846246408331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832552

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
GitLint                       PASS      0.62 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      28.06 seconds
CheckAllWarning               PASS      30.78 seconds
CheckSparse                   PASS      36.42 seconds
CheckSmatch                   PASS      99.56 seconds
BuildKernel32                 PASS      27.63 seconds
TestRunnerSetup               PASS      504.40 seconds
TestRunner_l2cap-tester       PASS      20.25 seconds
TestRunner_iso-tester         FAIL      37.26 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      110.92 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      17.06 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.22 seconds
IncrementalBuild              PASS      31.97 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 115 (98.3%), Failed: 2, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.186 seconds
ISO Connect2 Suspend - Success                       Failed       4.211 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============8622509846246408331==--
