Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C243C13E5
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832532; cv=none; b=FcWlXy4hdoXtVb2u0C7BwyY8qV7CMsYGcbhQZEUEM7LM3PTAODYmJfV01MUVYTHIFO8kHA+CCQ55qRoWseUp/7QMXmxs3hT2SrUtXwJyKiYzfvEqSarmLI7Ac3UL/cP0ad5EkO2R99M0+RWJ5VoVU1//yRaG7w7P853tGCbRKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832532; c=relaxed/simple;
	bh=VFqieVMzd+EcJpAVrpGHHnIehZjHGMzHNdNkCon/bbM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BW2KwO4Kfn13S/hdkgYUwQf1H8yfWOBhBRuaAguSO8pfCbaHS1fJg96y4CVukxWfjKb9OQ5TgMntS3qTOU5P900MEb/8mBcGwGiTUfWmOLSMBs0z0yhZ3eAcakr92okokDdmo0OCSY5PoQaRDiRJ4Liwe3//L43UuK3BD8fjO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywhrutpw; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywhrutpw"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3044857f09aso6600046eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779832531; x=1780437331; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ht8H0hmvsoJPFRIKu+VP8qmi4gBGfPyQNtHlDnk+wvc=;
        b=Ywhrutpwbf0vOMaIJSKeAkJqA5sXgu7KX3OpCGS3yD4AQnweosC1z7vB/SsWe25lBu
         MTraUo6tj9NPzxPmh6Ixqph8K1vlT8zLx2bS3C5rOv1SREA7pWG1Ga2H0OBBfdP2g8aT
         uxtVHrnlveiUcpWWVyT80jS8w+vlw+Dmqkd0D3CIsZRVe/5dclMAZlPnojArK61Tffdx
         sxVHzP/zr5i5dImO3xG2tuJw6zAEMY+4XREdJWh6ghR4fpiWm4ypaEQjI6gIiwvVDeNn
         7tm68tzkUlhrOMxWptOQmQ7sftRSWAhXUlHkgF29/gO1rk6jasWrDgR/OOdMOzceWP+O
         auHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779832531; x=1780437331;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht8H0hmvsoJPFRIKu+VP8qmi4gBGfPyQNtHlDnk+wvc=;
        b=AQxzDNOlPhVp0SZ+Vhzgcg7QeerhkjFRME6SO72KhzE/BgZJ3h190AFgXOKJvBxGQs
         XDadS2a0qAfJsffJh/biPpd6ra6x7WlHo2gDfRYu0J659IFaUSNMHCKzZQi/d+KSjQq+
         mSZpa3lypRT9Sn61s+avMzmu/Yei4viNMcyMzVX0t3ZXDbudvHz66PItxETVYg6EKuVU
         tpJrYMxnigPxRtLKfEOkbC/nxDT2nY2FmUoPJr4eJmLLPflCmLZqqLx72GPaxseVrCMm
         /Q6hY6zKBupkK9YDerC/fntHaxPx2IpGeOf9SG6C3E3VougoNyzqJJhpiP/njpWBvvwy
         xY9g==
X-Gm-Message-State: AOJu0YxdIt/VsdGl14ZKyovqOtIcJ0LwgpU+VrWagoQH0DwONK/6LQQX
	RfSxUc7YCtEC0NBCIRHu8JbJtr1qpR4Hf3UgrN3vcazs6xWbTpL/lGPZHDJOiQ==
X-Gm-Gg: Acq92OFSOMGG5vJzpCYOFsGQuMMuDcYl25zlcg/3ql/BxM+W4OrlOHvA23l41Mh+861
	ItfRTETnSXTGNmtnpaqI5HnrTLn5ku7DJ7ovLL/cUVcAfwVzVd5ivKK9mJX1sgAD0mKKjZVR+vU
	d1ZACJlWgTZnUcAcCE2ZMFjwRSmB1GceeGJOeRaQmUgbbvEglA6ksRC02EG3EdRqTi1ylCYVa5B
	Iol1RwmnhFDx5UZlFgA8ALjxzcMKB1ds4LTUl3F4XsVSMTdTRT394H/gGUc45IvZELL0LgtWr1o
	RoDunYJGqwvLtpfdqEdwYAPRTHBxawzoXs5yr+ASKDmf8R+0D3Ik9/V5Zhw+UK0c9voM2eteHhi
	E9iU59xnzwyqcKUgI/9OJc4oE6ik6QO3wKg5nacehdCCoIh+8OFvUayp6vWqtniz7LzJhu1Fmuo
	g0jNk8SV7m42bc/nlQRUTvx/nnLR/ub8A=
X-Received: by 2002:a05:7300:b104:b0:2da:1874:f3bd with SMTP id 5a478bee46e88-30449051bd3mr9590081eec.16.1779832530348;
        Tue, 26 May 2026 14:55:30 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.243.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4afdsm11530185eec.5.2026.05.26.14.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:55:29 -0700 (PDT)
Message-ID: <6a1616d1.d5797644.332336.a18b@mx.google.com>
Date: Tue, 26 May 2026 14:55:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1861303322895062938=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, doruk@0sec.ai
Subject: RE: [v2] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
In-Reply-To: <20260526194816.65669-1-doruk@0sec.ai>
References: <20260526194816.65669-1-doruk@0sec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1861303322895062938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1101233

---Test result---

Test Summary:
CheckPatch                    FAIL      0.57 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.63 seconds
CheckAllWarning               PASS      29.79 seconds
CheckSparse                   PASS      27.65 seconds
BuildKernel32                 PASS      25.96 seconds
TestRunnerSetup               PASS      576.60 seconds
TestRunner_l2cap-tester       PASS      60.69 seconds
TestRunner_iso-tester         PASS      82.77 seconds
TestRunner_bnep-tester        PASS      20.17 seconds
TestRunner_mgmt-tester        FAIL      225.21 seconds
TestRunner_rfcomm-tester      PASS      26.55 seconds
TestRunner_sco-tester         PASS      33.64 seconds
TestRunner_ioctl-tester       PASS      26.47 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
TestRunner_smp-tester         PASS      23.88 seconds
TestRunner_userchan-tester    PASS      20.88 seconds
TestRunner_6lowpan-tester     PASS      23.41 seconds
IncrementalBuild              FAIL      4.17 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 035c25007c9e ("Bluetooth: hci_sync: Fix UAF in le_read_features_complete")'
#121: 
This is the same class of bug as the one fixed by commit

total: 1 errors, 0 warnings, 0 checks, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14596093.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.271 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.993 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

error: patch failed: net/bluetooth/hci_sync.c:6700
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


https://github.com/bluez/bluetooth-next/pull/247

---
Regards,
Linux Bluetooth


--===============1861303322895062938==--
