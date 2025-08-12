Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3B283FFF
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005473; cv=none; b=pBm0jPKn9fqknF+hnylWuUxcW7c+rHIXkNdEc8LWraLPpu+s+88TTXYXDBtxEPCOpWN8PVImCkEOhGdVLdOCysqWwHfu5vpgCObV5kjBVcezIBeJjtqDz+Ffjf4iVEe8DGkVMl55qdWalqoRUHWqKkUBDlt/UIO3p1UK+DsfWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005473; c=relaxed/simple;
	bh=9e+mi44LyQzUi9g+M2esgSLaauNpGgpyYIxgZE9b50s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Oulnorm/GM/e/fGiBkfHcnsRUrjP5/PDstRxj91oSMfNS8dgZSkJV4fY7VV+Itl+m+1EshuDdtrHGQfEMS9mMiAaNMAnL8TrDg923FpkbY3Ij9U+mEraMCD4JhUYgVou7riJ5YPHjrTRBRz/oATkMlY5LnilCbjt7CHwQt4DNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLEve2To; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLEve2To"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88105a23088so207985739f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755005471; x=1755610271; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8vi7onrxLZmwsMEjFXBzDpvxAa1mzeDFjYHiIjfEnjk=;
        b=MLEve2ToHbMiyjLKeQkoucjWHCkoByAkLQuYhdhFB4BI/erlSMFpWdIR5DS1/P61yd
         hzEEkkXsFfoqyECPLl0l7WY60bQDkCwqVI9ZUyUJCxVDpFDxYNZeeN2nrSA3MAnK+odx
         YRAGHEwk902GvAJMTQmJRqRctoILfn0ci2JGh/Bcp4UqRwSmAkBbUQiWN/QUmW6fqNEM
         9r+51WDSc8/H3F/xBSyDUh/uDLsSu6t3XrohyxGLJGrGExphQyaS35VNQz8oK6aJ9RcE
         3IkAtRePgtyImor04Y9fafFi0PHma1TRqeSb2ft0dY6bEsc/3t9wsF5BRJJI17hjaBCo
         asGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005471; x=1755610271;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vi7onrxLZmwsMEjFXBzDpvxAa1mzeDFjYHiIjfEnjk=;
        b=aTkltodB9ExOzvJEauXLNz1spydn64LMdBeSDJHWLpyt34Ti1GWHTsZKkrEzhc3zCc
         Js0fgJEAvaKCcmGZxUrcG22/Bufq5YLxxbebfHlS3yKWKV7cdD/NTVZiD6KRmjU5tSdV
         DQQiv/lMa0DZHOcuAw6KHNIvHjLYrFLoTOZ/y9RPE3tKsnI81DSfmebH20JWA4vgBUpm
         aMc9DqppVy0gPAcQJpR17P2J0pjES2ViprQJ95mdjjg4qvK1ABtSSHmKal27xztdxW7F
         u2qZgSKDUVT95AIwspe7mUKc0WpwdVGflZa8pNzKL3sssB+6zchf2poR3Y+1fQ44VTo2
         B6bw==
X-Gm-Message-State: AOJu0YwJPzMUtv9dfo6ZhSSUoUa5yvoFl59BqSoKsuFJpzfP8ASMbW5F
	BKEuV7MvuxODzZd1CKufxMPtCLNKcP6gXALMr1iczgYGmBfdL6j0d1mOltC3cQ==
X-Gm-Gg: ASbGncudFsXUrlmKsp+uPkrLb3U5BXwUR4bPRqywpRW8lkgh002g4gFFWgZh4NUphPE
	fAg3QOJa5dZm6DoTKULoawhG5MxzZtoxWeHGjLVLNnZJ1GkeCH4nnQ5HGZqcaxquEMVVhX7RFS2
	m9ENby2jM38uIDFHZvYWSh4DbCH7I3oAudvIcPDs4OTb3pL6Xyxu990AYaGi51/yKzpv4SG5kf7
	1LKVeMt/87a+mVK+KvcjNy7N5kTnScSesuEW7Fa7G6qVmFfOs2RZj7IgGKdL2aJB4MgRza6lT7c
	n64nTZ8qSQHTtPXUsO0a33LJaw9eIHjPydEEe8v6Cpg8teP1NOup8cB5FYBWNV7dKY3rmtC4r1c
	7qJeGSVc7jA6J5c5njykCwwTxRgR2Nw==
X-Google-Smtp-Source: AGHT+IE1stLqnBgBrEfWJ3m6Hr0mBX6w9khSvPUNskEDw8RDUAgxqO4FhqUlMwIqoD5XrmsBSkEIAA==
X-Received: by 2002:a05:6e02:1748:b0:3e5:4842:c522 with SMTP id e9e14a558f8ab-3e55af97299mr53027015ab.10.1755005471072;
        Tue, 12 Aug 2025 06:31:11 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9ce8256sm2943193173.100.2025.08.12.06.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:31:10 -0700 (PDT)
Message-ID: <689b421e.050a0220.935ac.4a3d@mx.google.com>
Date: Tue, 12 Aug 2025 06:31:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7948847871522153868=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, guanwentao@uniontech.com
Subject: RE: Bluetooth: btintel_pcie: Remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
In-Reply-To: <20250812124308.2504833-1-guanwentao@uniontech.com>
References: <20250812124308.2504833-1-guanwentao@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7948847871522153868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990541

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.24 seconds
CheckAllWarning               PASS      26.59 seconds
CheckSparse                   PASS      29.96 seconds
BuildKernel32                 PASS      23.97 seconds
TestRunnerSetup               PASS      488.91 seconds
TestRunner_l2cap-tester       PASS      25.24 seconds
TestRunner_iso-tester         PASS      37.59 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      130.58 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         PASS      14.78 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.26 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.140 seconds
Set Device ID - Power off and Power on               Failed       0.120 seconds
Set Device ID - SSP off and Power on                 Failed       0.116 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.089 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7948847871522153868==--
