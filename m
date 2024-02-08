Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B78002D
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413681; cv=none; b=LBya5Y/BPSeReHEpMHrXnU2s5QzO4/I1F4bjI9W2sws0EvqKsUBlBB4TRUIbmHMFd+wmbHdmrHpKuOAqzK8rr6/UwpACahR8plV1s6lwmhPB8+sE2gjB4/OuhDicEWfJRdmHnSxk42imJ4WOrdh+S7T3mwQhJFShJ4vj46vm6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413681; c=relaxed/simple;
	bh=WTqWlLgtx9eJLI9MX8L2+EaSdDVDeiVNmNr2e3oJUCc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mZyHCbdmu0LBVbd0125ufVlmw9AOPxGlxX6Ly6n5eYh92ieNS1pO8OLWX5HRhiyYoZ+Kt/1tCjfkEyBCWwhRAPl3VEquLwLqGPdYyyMCUimrvaQnn26bnlp7X+TummhegbKUYLexehM+uaR4G0jFJ34pQ6CdCIG3GYSDj40yiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI+4vm5q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI+4vm5q"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1398308a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Feb 2024 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413679; x=1708018479; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VVlglGdSpefclcIRc2rd8gQ2GNOm8Q5bTWYtney5mT4=;
        b=ZI+4vm5qqABO2Fme6lZ3TkZAIiXB5dWeGg5Pkl93PCRslcraAwIql3HbIA1cae68Jy
         2Xw6Ra2g4u8GPQbww3Zd+6AF8UANBagA9gA80SRMRk77F7kYjwS2F6rDcdO9uF6lBPwt
         qjhX270OhoRSuvy0HxNO1WWgwcYtThZj9Do/DoiOe3rr2bMXrCPSPIFvWEz+amMjDS/n
         INuar/ZL92m3zt5SqDOG3SJjQYudPqTWVWpG6+wc7ViabLPtvBDUPQoky6r+WIohrVUn
         1UL41q2NQnvAkQnnE1gLZavnDfeGxRolWn4WHORvGm7Iv1fxNdy4X0A68JIc/Dns8NWU
         h9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413679; x=1708018479;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVlglGdSpefclcIRc2rd8gQ2GNOm8Q5bTWYtney5mT4=;
        b=uwEPPWxabBpT9NBUMHiXApKwyklhm97dRqWPTJfmrcS83WXpqLQq6gJn1/mIzaCHlY
         pt89wi8IUiAtYHEZhbvTwtNS8ZmjV9QOI+92BBXOXDBWHvk7QYkcgmia1mpfpkGme9Aa
         IYomBoF2pWmNEWXDXB+GZPjHP48JvRMhxPimkUpOqjAyge+beKh9CxIn7Kfd3cOJZSGA
         rg1Sn5R+3TTjs99Wvelh9wxW3iiYIM6oZFw6AUQyJtxQwn6sTKxQSakVdn9/oRvwA4of
         Wpk5Sr0aOeCm5/o6SNC27V/ITP771fdfG3h7WFB3Wu4dpxdXzRMgHCsfLui3KifnW2HH
         Gr5g==
X-Gm-Message-State: AOJu0YyR5+r0X9crBcLLstesh8zB4BKr+gB2ZkFNNgqFZnEdd27vm0Zp
	7/Lncw/zPZHAldgmNruu4sonktXoRcMkVWDVy1UxMt1VH6YKJZgsCqMSIkST
X-Google-Smtp-Source: AGHT+IGH5/pNZJzu8Jb7gZken1Gf0SO3tP7e0+fyiM4igDQ22HmWmxqniTWiBW4L0cfV00xJxGI3Ig==
X-Received: by 2002:a05:6a20:9149:b0:19c:748c:3e45 with SMTP id x9-20020a056a20914900b0019c748c3e45mr327626pzc.8.1707413678920;
        Thu, 08 Feb 2024 09:34:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUu96G9MpjhsYr1YleKCQSSyD2zIEgoavJzy/JPJO6nXcZH6Y4ySuRZpxxXYNORTZZIrv/EguQw/QnRzSY
Received: from [172.17.0.2] ([52.157.3.103])
        by smtp.gmail.com with ESMTPSA id ks7-20020a170903084700b001d94a3f398esm4339plb.141.2024.02.08.09.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:34:38 -0800 (PST)
Message-ID: <65c510ae.170a0220.e93a8.0091@mx.google.com>
Date: Thu, 08 Feb 2024 09:34:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0789402121237836015=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
In-Reply-To: <20240208164017.26699-1-brgl@bgdev.pl>
References: <20240208164017.26699-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0789402121237836015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824386

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.94 seconds
CheckAllWarning               PASS      30.43 seconds
CheckSparse                   PASS      36.13 seconds
CheckSmatch                   PASS      97.84 seconds
BuildKernel32                 PASS      26.85 seconds
TestRunnerSetup               PASS      499.91 seconds
TestRunner_l2cap-tester       PASS      39.72 seconds
TestRunner_iso-tester         PASS      30.92 seconds
TestRunner_bnep-tester        PASS      4.94 seconds
TestRunner_mgmt-tester        FAIL      174.03 seconds
TestRunner_rfcomm-tester      PASS      7.44 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.93 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PASS      26.04 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 4, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.114 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.115 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.142 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.147 seconds


---
Regards,
Linux Bluetooth


--===============0789402121237836015==--
