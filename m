Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80837BE64
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611168; cv=none; b=Q+ju/0WQmVo/y60dtkUzvh2lTRWhXHS8+Wl8S1iL5dMlUfOfWJNXIanv5bplW+HOa1rAAonpyadH2ZvspDB7dqnKzAbDs6qYFSc/dCIYE7grEFzdGOMxXeZAbv+MCU4k0UCgefWwXk0Mbhz0A/znr6VP1aLGt6swUVGWlvdT0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611168; c=relaxed/simple;
	bh=TDAiSiJazToZHYNr6Dh0DeIoBUlqtiGdDjSOQFitbU4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q94CP4Hr37PbcOG8b1pdIgK5SBY28kb42+ngj0AHDtAvOnUEJH6QZr/r1J8VLNoogKNJ0BAp+5oehfDGf+MJI6MzRjyRCFXVK81jV5/0DRz2E56kaB+FAxL5DDIZ6BE7XbezErKEbci8/r83Z2EnwDX3JZIRGXvjzbYAak+EdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3Lf+ckt; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Lf+ckt"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfc1aced74so337954385a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774611164; x=1775215964; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G3l2T+hQeL9yWXzzQUIlDsq3vjyfM7fDAelidd9GUEA=;
        b=W3Lf+cktJSUmKay403V97OBrxdpU2HhX0l+WCb0aJUg/0lQFi1SM8D876viw4vDB1I
         DKzh3MCWe679Xfg2pqv5IDWsTEEAIfupOUA4w4IfHh/Bf0vBy25FdEfpstOzpqAV+1n1
         KeQ6S97FVw6cEKJP92vwOnICElix3T+g87Gz4/dml6Rom66bpSpVMOyUa/ppQx1usC6e
         3gufVSnwW2NhqlBuySGAYd3nabBWrNkQTd9QSEU+dt4v1j715NncqE2xzyJSVY9fCJwk
         NJexjV74IdfAQcEGF/8GuqA5VrjF4R+hkfPgMZsWc/TRcXt5ZA2h+8wEl5FZSsvav5m9
         hQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774611164; x=1775215964;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3l2T+hQeL9yWXzzQUIlDsq3vjyfM7fDAelidd9GUEA=;
        b=fjea4281QU2Z4eLIOQ80RlvamuQ6a531jCT5E+eWyCNRISlMb2vj/uNoSGfcdAm1xv
         MQXTvbhm56Ykqy6pvZ8VrDNRf+lfDgqxb4EThmB2iRQctG5lQe7pjlLkzZ6V1S6xe1Vu
         V9X5PEhc9G7EiBNRKDkBttIiLvO7GP/HM2w0MhfeqJ/Bk2nuBc5RfeQ5YnP2hwiM5+kF
         VclG3RiDb1HeCRhZ2TbCHC5Tn/kgOOpEdqVS/CqeR7T/O9myHJqa5Yc0SZScZI+eTeuQ
         43LOO4SQISKmffvvAmS7QdCwdN03eOAMUtxnh9KAe7+MpLddrvPiNM/He2/IyhAtQSiW
         O/Jg==
X-Gm-Message-State: AOJu0YwCwNB02lYQVZUMZcDknvmfCT8f0WnJIx92z4OHdLnCtIWaDGv8
	dEVvZ+prCiBpXojpuvOJGhKNODavF7GEdghtfvP/mKz0tl3S/t0DgYUGouw9Pg==
X-Gm-Gg: ATEYQzy33+EncazKn74dr11GUVdmIQJzqU8EMZibvu8eUF93+Wll6nqYZDLYWRIME1r
	GBB2B/VuXf8CccGCsDvgrxqj0nyReVoYrww/DEYoC0ljbIGS/vtd9bwuay4kOlq2yUooxv125C0
	gT0I3YdBiC540GAeFW+VWtVoWr97zAS3WWY43dDVrwsx94n33Kby+i9/w76lUBUYoXDlkOrfePR
	4JeqbCZmr+bWjY+d7N5ov+zIO/ejQ964oAgsWh79juP+rsh5MnRCkXxZT1/KMQzXl9aICJfXoJQ
	8RthPdCVeXlj/u61x6uhIkrWsHR8fORsoo3qIrDKklnN8uJzbLaRycF5wwGkgeN9tqY8sjPQ8dZ
	1amMSrrxD0E7vG4PQNlFzZBTe7asAslkocY2RbMvdkliOwLQ1yVQFH7+/UkBl66hzr418iXdZ5M
	+q/sNH+kHA5IJRQR7VNemZlsPtWD7W
X-Received: by 2002:a05:620a:17a4:b0:8ca:105a:298f with SMTP id af79cd13be357-8d01c7fc3b5mr255088885a.68.1774611163778;
        Fri, 27 Mar 2026 04:32:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3d5b7dsm453118185a.18.2026.03.27.04.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 04:32:43 -0700 (PDT)
Message-ID: <69c66adb.050a0220.1310d0.6d83@mx.google.com>
Date: Fri, 27 Mar 2026 04:32:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1672797038768284456=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jonathan.rissanen@axis.com
Subject: RE: Bluetooth: fix race during h4 bluetooth initialization
In-Reply-To: <20260327-hci-init-fix-v3-1-1b54bad4ef0f@axis.com>
References: <20260327-hci-init-fix-v3-1-1b54bad4ef0f@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1672797038768284456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073500

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      25.13 seconds
CheckAllWarning               PASS      30.16 seconds
CheckSparse                   PASS      26.52 seconds
BuildKernel32                 PASS      24.27 seconds
TestRunnerSetup               PASS      519.71 seconds
TestRunner_l2cap-tester       PASS      27.44 seconds
TestRunner_iso-tester         FAIL      33.49 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      110.54 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         FAIL      14.16 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
IncrementalBuild              PENDING   1.04 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.927 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1672797038768284456==--
