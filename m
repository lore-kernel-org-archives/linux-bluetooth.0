Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BDC2E7BA6
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926629; cv=none; b=lC0eXhgysOBZoOPndeBpohX8Wv0mo2aQzaJBum0IgNlEqFegjWM0A1Tzb+NRolw78AHphjphzx54UjHcIdKKy1r7BO9sAhhil11TBDsjTqj8UbTSITsoJ5pQVVCDe8YoFxeUz0PsTjV/MEQp5pfe0JNzFMnUDApCfD45yPvkZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926629; c=relaxed/simple;
	bh=M03PW5PptiwD2zlQFJ18z0DOeOBJIH0aMGrOBPBZk/o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bLDWX1mVOL+2k3WxEpU90cTl1IbCPk7LofpjPBakU/mXmbVSDiuDHObjC4IzIaDXUAMoEgmqwVd57vNxc3+ptVw00+1Eo0zBAnFobsxP3HNOjfvW0/8+0ZrzzgJec+XJoHKFtQeyl0YC1HnLw5GNRf8y2S3O8WBeqH/Gaf6ivT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHmLPk90; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHmLPk90"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24014cd385bso49089525ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754926627; x=1755531427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y5oJsT98WoczK9ww4hF7nclJYnvXnTffTce1OOQe2vs=;
        b=CHmLPk90AH9tTuLaqN8ATLBvheIJzCBzkAxY+t2S9zeuasn4Ky+tMAiSSkiJdiljq7
         yCnvNlnP9zL6E1A02n6b6a/BklRm5Wtt06MzXsCiFxziNbBgKQp10tLIREWNVPzpsTsm
         dq9wLZJi6nmxw0K3EIGJQJCgt7IpMQNEl1MY5jTXJI/4vgI3u/Jo1Jm3dJQCpj+R2XSe
         EBkeR9q01OLFm0kxk39kGypLaVGtMDZA3wvrLpP+e8T4/X6AZmLJeK54BrzG+Zl2baZi
         IXzDfHgWygT7LDCVWRir0JPUo9TVNlTvxynDLi3imuFqw/qRLB4Nms4ndlxlHJ8h3vBp
         dApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926627; x=1755531427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5oJsT98WoczK9ww4hF7nclJYnvXnTffTce1OOQe2vs=;
        b=s8wrrN9fWYYZ+buUSd78PezQcYHokUTo8gfkR7LHecmMw/OAaja0Qmyz884geHPpUq
         GikJajVIZdONbVRontxZbFx3yFm6sbTfAAHUjrcrb1MzHsc0ScorEre+Z/9sbVVIp2ep
         w9guoFNGAeiueaUbawfNxLCFySOBjoMYr5JJKlhVPr0yZBWQJEU/faZcJdmDOQxvcT+p
         wWjX/cZZibvTCXcuma0LFwcyxz93eAQiDDmEZfynmuCgzxkWG63i3zNB1g23d5RtRJGs
         cUc+XPK+f5Q85xnHEPp5jTFTt49J1K+dfF7fl6GFvRAu4E8g5fQuQa/b2bdS3LQ3seAs
         lGuA==
X-Gm-Message-State: AOJu0Yzg1UcSo1chtFammD+663nacNvUOuS8c/zbOwXbbyWFSrEKt2ZT
	uaPQhOF3w43tjpk4vxhV67n+9yc4O2Bagpv5HLvPS6vsV3Z46GHGnzDRQxHfXQ==
X-Gm-Gg: ASbGnct84Tdhz/TR4ZOus/GIzLUHlAzQ2Vi/P7/MxlGQSKkBxxw9R9DvTWXQNqElc3l
	HHnTH2AxDt1WThV9sNgb4XbrjnBPmL6ytxrCtMIEBT+rB1N54nkbIPOpQsIPgj+VuIXB4vsDXUH
	5Zm+iHRnoCDHHCAYEUFZjLtt+c6+hbnx0/qQJkIHslecGVFj5RUh+75QK6D3e/RYtxkzFBa2e9t
	iPs64LtqUI38jmPk8qrlpDC3Q8KHU62+HN72q4yxY4ck5FSI0IeC0559qYDeH/DVFxKBWpRJ8eu
	tKI4gkGqHDzWQfHBdxusXqdxLbcYPgwOtXTLOCt2Kr1WV+XfJCBXo05BCxPiCRw9A4KPT74n0Cp
	gEj+/1WXUIrrrRgSHLidlOfK1GkM7gXUQp4xicQ==
X-Google-Smtp-Source: AGHT+IEcUjRvuN+chlIhT+aDYonpj1adufXjRLm9oLleKxw9+Ktkly7tvhpkkKbhoCd0SJnmeoDH8A==
X-Received: by 2002:a17:902:d4c1:b0:234:e655:a632 with SMTP id d9443c01a7336-242c225f5edmr197870265ad.51.1754926627163;
        Mon, 11 Aug 2025 08:37:07 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976ca5sm276882315ad.100.2025.08.11.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:37:06 -0700 (PDT)
Message-ID: <689a0e22.170a0220.bedd4.d9be@mx.google.com>
Date: Mon, 11 Aug 2025 08:37:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8123610585646797259=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: [RESEND] MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
In-Reply-To: <20250811150400.86926-1-brgl@bgdev.pl>
References: <20250811150400.86926-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8123610585646797259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990091

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 FAIL      0.46 seconds
BuildKernel                   PASS      24.45 seconds
CheckAllWarning               PASS      26.52 seconds
CheckSparse                   PASS      29.78 seconds
BuildKernel32                 PASS      23.86 seconds
TestRunnerSetup               PASS      473.92 seconds
TestRunner_l2cap-tester       PASS      24.93 seconds
TestRunner_iso-tester         PASS      37.12 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      126.24 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
IncrementalBuild              PENDING   0.55 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 481 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.126 seconds
Set Device ID - Power off and Power on               Failed       0.126 seconds
Set Device ID - SSP off and Power on                 Failed       0.122 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.151 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.188 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.114 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8123610585646797259==--
