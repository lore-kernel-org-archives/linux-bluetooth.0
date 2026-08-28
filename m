Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BAA3A9DA3
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955849; cv=none; b=D65QOdOgATORHi/GvxT9LQ99JUJM19XsR/CcamDCwWbkOzq0wHnqHAdlNY+SmMTkj1/RRorM9EsMbxhBynqaCP7M8k4F2DMuZipTB3ng6OQWw8QvneJUZDUaKkG50ZoKM4KsqF1erTXS4VbJN60rMcX+zuHQla4uuVXGVWj5QSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955849; c=relaxed/simple;
	bh=ySQjv0yl/QRVnIzU9w9ndPBva4QRG25WxjWN2OD/VTg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KknqCzsmt/j+x+E0satR5bJv+0e8zNM64PsUa7Hk2PBC1wTgXgnOLICspNSAtGedmRhl+Ap+Z2cavAfOSs+nXnLtw94BKKwEW2ChkD/yYBsA2eBd0SnxalmQPJvNgfWRsakSy9B1dKlO5wV507QVymq/OyroiGbinZFXbgofnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUM7mRw5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUM7mRw5"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca80d708489so1053772a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787955834; x=1788560634; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ptcB/0jjZw72ZhtG41DwsvINjBX35vlpMnSoDnZ1+PM=;
        b=EUM7mRw5PscEbrBVVY0laALzGkxBVeZFSswJRh09KvQqzdDo2nHte8iCYg2G0JAgkl
         rWIZVETTPVD35NFKAdskLqjV1tNMTk+w51DgFjmATZHxMffXTojfstFUXUOeWvfL1ZyZ
         QlJyV6kcsoPruB01swhlBXkW4CFIl6xzCTEVrE8S7+s1J0T0Ja7iHBrfLWraqaIap0Qz
         1zFPE61YkMDTF2cbyeEuQaZudyOjjuRvRs9sYJyDe3Wp9EniYpyPPNPn/jMx8dnwzFnm
         IZg1S8HCAU/opbaQApnBwR6+c4bd5ztSP091LOkx5epYloFCYsL3gI3oncR2EheDd/Gs
         YB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955834; x=1788560634;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ptcB/0jjZw72ZhtG41DwsvINjBX35vlpMnSoDnZ1+PM=;
        b=mzuLAyNopvXaTcgx9l/L8hgtl8iAuHDHj56XM7bXL/5cpxQ5C9qttbCKk0lR1j3pgi
         65Uz5NxDbl8dwjn1psEcSSoExUtEA1H8GkkbG6vxoYWwKz3FF7CvHBYPrnvss/cR6MBU
         d1VpauQSjaV3p66BRoiNK7GH3McxxbKq9vK0v3AHA2qleaiz7KSKIOlFhciEeHutQmgk
         XOUM9GhPuVfaUHhSFt+LtMHK+JOyhcwa33DrbAcbXc3WABwqsHvQbBotEJ1pGeZiWnn/
         Zf3D4PTNlIl1y5LawnnNyGCqcDEUnWXyioe6HdxMew4XZd1eU4fnmbTEDWZuCHr5/gjh
         x/lQ==
X-Gm-Message-State: AFuF++kMwPkdwKp1Lf4Xrtqeks2gvzA/RiS61qdkWDXEGKOlGQLcyITe
	efC2Gzh40nPr/K0RnD7fmIleexyYTTZoO59ZZRBluB7DdSbk71ET74FYXqdTFg==
X-Gm-Gg: AYBFou3KPyWXZCO0dnc3lZh/v8FGRx4Q6WHc2wNOXfXIUsFM6YY8UUEwwCjaAoFpiQA
	78d4GxtmuFcJNeco1qRHD3bscZneKH7Xl1aYdoY5KlQGILoFXVyflruTQ30nLsg8gLiZT36BJ6v
	+SAlLSkoJv5x6iBi9A6TUgkax2SoLM96NMLSPOU9mDuLmG7KdTkxr0KDvn58Z18rOPts1D2X5O7
	4UyONr/p6GLKzWC3FMfT/5BMbNufVbBvNG+dLZN7R7mwk1lSGfA3+udVaS3EFQ30k+gRmR6RQo4
	aWSddc2U3DQwoiNpSQcBNCwV0Pqte6E7H3+e8eYW+KRduId5HTFEUX39cpI9rN0kGiGIVB9VG/d
	csvpG9YDEPJpDrYQ3aN8QLBM43kaVJvaKF+h7y2w7k/PCkgsxHWBKm4LtUe4gMSH1XhtL/P7fy9
	lmywSEzFt3sKcgZqcw4rxQncyRdMZW9mkII96x1Xq2jhJuJnoukDEkjh60otxQT9De31w=
X-Received: by 2002:a17:90b:56c6:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-3989b309324mr2564657a91.2.1787955834525;
        Fri, 28 Aug 2026 15:23:54 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.142.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc58d51sm4279336a91.15.2026.08.28.15.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:23:54 -0700 (PDT)
Message-ID: <6a920a7a.028a0eea.e64f9.50da@mx.google.com>
Date: Fri, 28 Aug 2026 15:23:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1867140771942772406=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: Move H:4 reassembly into the Bluetooth core
In-Reply-To: <20260828201306.593974-1-luiz.dentz@gmail.com>
References: <20260828201306.593974-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1867140771942772406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153424

---Test result---

Test Summary:
CheckPatch                    FAIL      2.44 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.53 seconds
CheckAllWarning               PASS      30.43 seconds
CheckSparse                   PASS      28.92 seconds
BuildKernel32                 PASS      26.63 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.25 seconds
TestRunner_l2cap-tester       PASS      64.88 seconds
TestRunner_iso-tester         PASS      114.18 seconds
TestRunner_bnep-tester        PASS      19.21 seconds
TestRunner_mgmt-tester        FAIL      220.15 seconds
TestRunner_rfcomm-tester      PASS      25.35 seconds
TestRunner_sco-tester         PASS      31.40 seconds
TestRunner_ioctl-tester       PASS      26.35 seconds
TestRunner_mesh-tester        FAIL      25.91 seconds
TestRunner_smp-tester         PASS      24.79 seconds
TestRunner_userchan-tester    PASS      20.76 seconds
TestRunner_6lowpan-tester     PASS      23.14 seconds
IncrementalBuild              PASS      27.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] Bluetooth: Move H:4 reassembly into the Bluetooth core
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#327: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 419 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14774101.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Read Exp Feature - Success                           Failed       0.243 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.967 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/662

---
Regards,
Linux Bluetooth


--===============1867140771942772406==--
