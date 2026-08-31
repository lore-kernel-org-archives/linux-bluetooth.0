Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4203B47FF
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158471; cv=none; b=e48rJejWJjiwiv64lv+QhCcsIorlvOnZvecFzzGdQEifbH0JV2DaA+MIe/9qeCerDymtivVLlIEd/pP6gTNHEK4e8rGVR/wuDYWKViOKTMF6I3O6l/btyRVepsV1SgXoEgG4yaRcKjFjvI52IIeOxlIZTZYQcZiD0GaFDExiAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158471; c=relaxed/simple;
	bh=AvcbDqGB+zfKZ27Q4B87/3mzoMD2ukAD3ZopNqrxiJI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EJYO7OYc5EEZeqQc/4kg7TRFenmXzdAk6Tfc/JjSpndQ7iWn5bnvwzGcMSSe3FlJoqZlZi3fY6SKTRY7e48YZqG7OcCDJwAJcjRIClpX3Ic3iyyh/8LfhSOg8c4/5qjrngb50zzGVUgvd85aJ9I45RI9stiXm2Fw8iNJa8bzEFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUfdTylZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUfdTylZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d91ff7d9acso5164195ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 23:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788158469; x=1788763269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ijVwVHrNZ5EaB8nXNdFTG0mnRUzmSZ0S0DB5rMN5+t4=;
        b=ZUfdTylZq2upX/2pZQlTdGQU15+ctjQWe29FlGL5p71MYEDmG3GhrOZuX9qAXwmYNS
         +n0dC9D/td0xPbUg+LRBGK5D5orqcWKRwCjOLAUkPkEftBFaNkCWDQCefiyUF5iVwD+9
         X0L3haH+JXBjI74ZD/r8Z/nvLgARONwDWFAXognXVrelVciL5NFqULZHKsZvqKbSmqkT
         nOEbkUw6IkEA4gbBR/yV4RSvb0zNZW42Kvtx3+4FZLuIFVUbJtex31Z45Sl2VevkUIyh
         EnZAhzqQQKv7kUAMGlzAFXyfWHIdEIe2isrHIsHWgkhBjy081k9BSXgJ7dYQRvtNbERS
         FYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788158469; x=1788763269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ijVwVHrNZ5EaB8nXNdFTG0mnRUzmSZ0S0DB5rMN5+t4=;
        b=QWigPRwjZ7Fh62u2jYk+odn3o4ZYZHDeQu3pna6/dkw4ffY9tiOJp5wiWautdQN0G1
         tXxjhBsiwqW97dtiX/QX9ffNMroBkEebxJkRF9myDtD4oHRiQNagnibDYzKMFWb41s96
         OOqbBATrRfSVL9UY5X7anAzVGz49zadebujjLnOKG6xiFFy7lZ+E2axw1WqRsnV9+T5F
         wDcFeJbyrZ8/+xMQzUlo+27mfBf2POyF6ojYv+48HYXxQOxd8RYi99dIzog6VVgOHikE
         AlAT4MwwprqbR/esKIvxCc0SXpZUxmnEODr3rs5iBdjxbfcEQ1fip3ZpbYu7uoOlt38d
         6/+Q==
X-Gm-Message-State: AFuF++mrPb0I5/v/0TGraGf6Cl3j48ZfaoNr9olIPKsdcGhIgHzLXYqO
	7v32z42/Az3fvo8r+Nh8OmjrzlKSuNI5vwwsV3DOjkRDbvsBEr5KCDn6KrAK9A==
X-Gm-Gg: AR+sD13S6EQeP4jfztPz/ks81stsxlwS2CfsqUvAyF5WoNbvobXK49KmcDkGdIQ387U
	wEDKeHWfembdxcM3vZMdMrHbn3bT9N/R2V+UsAp0J5Atw+t6nPpoPLmpT5f/zMSb3/efPjYPgeH
	7OQQ+1Z3ZeFc9N6d6cWNdt76T4ZuBiUrRhoWSIlwLcEPV8LH815e0i6mX1FZxPUKVpSBU6Cs0pT
	H26EwT7BAbEZX66Y7lbeNn6m1eAoajwoGXZzBEaYMRL+noZQF6t63Q0vBI7VGSbu/myXg2nwXiA
	288P1itKdpk0OevXwxT3Arl0uVj3otaNxwUCMvklk72fBL+jbhbBScu+FIsMTmvDcB+5sgr0f1M
	dkDbZJUBQI3m9ew74caEMvnzOYJkN3PJdJMQwMQmXfFhetPf45l0bwpLNp9iFsz5LB+yOBA1v/Z
	8UHzjHEqvpHmHC8KMOYvquSyGFKPsvIt/nrNd/jjI6SE+Sl1d/r89IoWUmJ4h6s0UxRq3b
X-Received: by 2002:a17:903:1a27:b0:2d8:d4d3:3fbb with SMTP id d9443c01a7336-2d8d4d34074mr252410075ad.15.1788158469078;
        Sun, 30 Aug 2026 23:41:09 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.167.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b26fd7edbsm15497830eec.5.2026.08.30.23.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:41:08 -0700 (PDT)
Message-ID: <6a952204.7b32ee26.e8bf0.8889@mx.google.com>
Date: Sun, 30 Aug 2026 23:41:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6194797634128334409=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
In-Reply-To: <20260830-btusb_qcc2072-v2-1-5c0e0c9dd98b@oss.qualcomm.com>
References: <20260830-btusb_qcc2072-v2-1-5c0e0c9dd98b@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6194797634128334409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154112

---Test result---

Test Summary:
CheckPatch                    FAIL      7.74 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.92 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      28.98 seconds
CheckAllWarning               PASS      31.99 seconds
CheckSparse                   PASS      30.60 seconds
BuildKernel32                 PASS      27.89 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      527.19 seconds
TestRunner_l2cap-tester       PASS      71.10 seconds
TestRunner_iso-tester         PASS      108.50 seconds
TestRunner_bnep-tester        PASS      20.19 seconds
TestRunner_mgmt-tester        FAIL      238.88 seconds
TestRunner_rfcomm-tester      PASS      27.38 seconds
TestRunner_sco-tester         PASS      33.32 seconds
TestRunner_ioctl-tester       PASS      27.83 seconds
TestRunner_mesh-tester        FAIL      27.18 seconds
TestRunner_smp-tester         PASS      25.21 seconds
TestRunner_userchan-tester    PASS      20.77 seconds
TestRunner_6lowpan-tester     PASS      24.84 seconds
IncrementalBuild              PASS      53.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,3/4] Bluetooth: btusb: Build the driver from multiple source files
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#174: 
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0

total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14776343.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#471: 
new file mode 100644

total: 0 errors, 1 warnings, 4812 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14776345.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072

8: B3 Line contains hard tab characters (\t): "       USB I/F	|	   internal link	|"
9: B3 Line contains hard tab characters (\t): "BTHOST --------	|---- PERI -------------- BT	|"
10: B3 Line contains hard tab characters (\t): "		|_______________________________|"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 495 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.276 seconds
LL Privacy - Unpair 1                                Timed out    1.960 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.064 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/670

---
Regards,
Linux Bluetooth


--===============6194797634128334409==--
