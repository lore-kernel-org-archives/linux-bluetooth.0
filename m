Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401237EFE4
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460828; cv=none; b=sleZo2riKim/RQyM5HzPtLrcAyoVs4JRvVkwYFfgGpqAVhPiUARrtMWdDV6a28tKx0J2zwOm5WTyENNpEW1KTWyUc86uToRf09xjYvT0gv6S4ERWT01jjmbONUq+8ky/ghk2yO+d5ptJN7sTDMD8eyuwKP8w262MpGML//nrnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460828; c=relaxed/simple;
	bh=4Pq5s/W6T9so+Saptk9A0jmA2D4tQBeKpLlrzeje4IA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=keV4WOfPN9d1eyy/C+aY+vPWBy/lBKFNVokHVb/av//mETofiJ8Ug3rayQxJpko2GiUTPN46CDd5dhUcE/abXQRLfiHKpPRglOZ7NysgBbYZCL9qEy0vSaYRembHXZUkN2GWm+fEwDDe+aRDNoC1YArNaaJNk0PapaX4DgxsfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itmAocWo; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itmAocWo"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90e828b309eso3291566d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788460826; x=1789065626; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5e2EvsQmofairvcNY1MGYQ1U98le10i6Sqb1OB7qlhM=;
        b=itmAocWoT6IeDlfCZGslrBXqjzLxL1Nk+CKhJbK1+HR77cuYdu7l5Dfv318hW5IRgq
         SvCOcGfZfrq9da5vBRi6HycuoW73yCx1NPUxd8mLpkNNM/+0Q0rysgJA2ppMsDV3jN7V
         YzuHM2XppFmBeua/VVexNp3TXZhHs4itD4OWcoe0Hzmg5OzKrwG7zAEN1xzn59ZkSI6O
         ShCke9Ko9nc3CDxj2JpikUTNHd/B/5y82zTuL7C6COmTFI8+hydWyJOy3JgI6Z9BeJjc
         fGo0v0lGSftqBOC82TBBAr+y3nsj90IKpxA26Tbf9pGDJcBzMh6o9Ov+R/NivVjBQ6sW
         1XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788460826; x=1789065626;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5e2EvsQmofairvcNY1MGYQ1U98le10i6Sqb1OB7qlhM=;
        b=IDtT6GzpCpCihMXP4N24XmAbbDm9DopLgCOF0o74QdT1EZckDH2R90UIp7zh0tI+9p
         yHvkdcvx5I62MWILNAFc57b4hDk59z+h34CzbsOjV3dPSlqE8YK+niS2wZpI251Lqgu8
         47KEEssLEmwwOpnz3PKMZXds0+RveVL38wPXpQcqOGjJK3Mw0WwNIblBUESvzdbo+nhV
         jHx0eAV9MtTcuyUELOBlWTZF+FTbx9MWUoOAwWEFTx2pu7tCyk9En1SrAuqxC9u7q+V9
         U41r9Otj1U953O8o4dTe9NaPybnm2l36Ye1OVL9N098wsqiWUEp7J9rRL2L2p1uTABXO
         YQOg==
X-Gm-Message-State: AFuF++kpS//gqHr6F8RA9GVMSltOTjPO4NUKVrbWI0vKg7rUPDrKjMT+
	1TB4RGbWkBildTKVfeRHXKXgjM/4dlF1/xvX7/4tvFFGjUMw+5LDiIAKSN9L+Q==
X-Gm-Gg: AYBFou3AzTWQREtr71STc66vi5CIH0h+CRwP+bMMa4RXxQafVcQFo9nehlmg5xR2CdV
	7b49P+gXRPnrfi0wq0HHxuwtsSYndR6+VEB8Ab/K97UzXAiBdKpnie8GmG2kCiPH2sZF3H1GTxB
	8Eh4UFzBiMTutnpp0DePpgKCI7si29tQ/OEABRNike5qHlHZ7T5NHhWUw0+yA7Lm47aBkcQv4DR
	oO6R8oCy7irbmC3McIA763O0X5ob7t/Rf9kCSglTid+4EYhP2076lvLex6/i6tFJz98wbhq9ilb
	8bwSzcKSqqrlkUO8JWqIplmApM5Z5l05WSB3pYNFAcfvs0cWOJAfxnOowkXqhyJLMQ4GbGqvQCy
	fTrX0GDKrz3Q+N33WVHbpAJpbDQtsCocwI/yvfc9MeRP+zHyamoxOtC45KoG2RDSMA0qQDEVLMx
	OcoxwKufLJy/CA0OF7QK4V87i959DxxAgvBp3wZMNwDqgte7qKWerv0qtmBo/SdRKv1Q==
X-Received: by 2002:a05:6214:62c:b0:90c:e3b5:85da with SMTP id 6a1803df08f44-9103eec280emr15619986d6.0.1788460825861;
        Thu, 03 Sep 2026 11:40:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.222.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040647715sm896036d6.10.2026.09.03.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:40:25 -0700 (PDT)
Message-ID: <6a99bf19.a40fb949.f1a41.3b57@mx.google.com>
Date: Thu, 03 Sep 2026 11:40:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8806587957177466084=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vladimirkondratyev2@gmail.com
Subject: RE: [v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
In-Reply-To: <20260903153521.130258-2-vladimirkondratyev2@gmail.com>
References: <20260903153521.130258-2-vladimirkondratyev2@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8806587957177466084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157226

---Test result---

Test Summary:
CheckPatch                    FAIL      0.97 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.99 seconds
CheckAllWarning               PASS      29.40 seconds
CheckSparse                   PASS      28.36 seconds
BuildKernel32                 PASS      25.69 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      474.96 seconds
IncrementalBuild              PASS      24.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#113: 
operation to abort on Intel Lunar Lake hardware. The system immediately resumes

total: 0 errors, 1 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14788135.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

6: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0"
7: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1"
8: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2"
9: B1 Line exceeds max length (98>80): "  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/697

---
Regards,
Linux Bluetooth


--===============8806587957177466084==--
