Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA13B8D40
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905972; cv=none; b=rcDmCojAOi36lnxQaCZwePIlHYnWDPd/MaIqndp3C8zYVN5Kaqjyt6qARajOx7w4qAnXMvCNSOEI+4qLNMFBFW/3xECa7HcpIEB6cNA4lfZCWN01yJX+l+Sncq1yecG40FNgOQOh7/VteqXB+yk8t7/39yaP4SmvQo1KzcAduxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905972; c=relaxed/simple;
	bh=dOXPxe368eMTGuB7Fmw3UzXLgtkGhFxr/aq6v8I/Bxw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cM5CQM16Vv02AZ+tKrRRo73pv+o/bX2SU95/MshkH644pB3jtqStBXig74Fz41a/UfbUHZzrfFp8LggS5mJD9WOgEKXDKB1cemclpKQTW150Lhb/oc4H5RCKnC818SyMzetKch2uaWlURoyG5BqWOOSHYw404JMSFCLxxzz/PKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qOkgcIWA; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOkgcIWA"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f0167e59a3so3793556a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788905970; x=1789510770; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r9ZjTMXX7VLviaHR27Q4b+69D+Cnl/mziz9fV4vYtqc=;
        b=qOkgcIWA+V9bBNGsK3pu4Ycl/fwRkRYT12lkdp+Gr/dbsOhHaQiXZk1/eizg9htFnr
         hbvNRmnDcMO17E/JZsCX2LI/inFrY/8I8ummjg97rlN2jC6/V03NTew39MTbftmvU1lB
         BQJHD+5uj8C4FGGLpffCzWoZS1z/pe+Z3BEritg3Yr4fWqU93bguyv3mYcDa1rd1ZXCo
         a3jUoCasXMSmbGZ8ToTYBZLOWTls29cyvquxIFpu1hRsAZ6ljLC4AGhiSh1TiNfNSJII
         wDBDhSe+ofuElPl2tpc1v8Ux5uEuqk+1CRamFrpb14Q9N66b+tmgayxncIYrOKlLRyDb
         BKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788905970; x=1789510770;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r9ZjTMXX7VLviaHR27Q4b+69D+Cnl/mziz9fV4vYtqc=;
        b=L46Pf5OA1gWYFi/lkbzXhYx23E6YkwFUdba+BxGh1V90DjhWNeZU2ck/1xMRWrdWXN
         xu9nyRteCOfVteNi10whVElUAFvhHAchte/MYjvfj+co1pf4OOmVeubWdhVOBkzQ8aKD
         oF7IyoWdN3ZfdY67E5qKZ3qsgKS5srOauHP3avWQJERZN7x4yIJZh4f/Is1HDBc35PvX
         XY/SXEVKhZIT4xtqI177fszqKmJY50OdpgmDEoNtGXB/dq1OAxGtpxQAVeWJuV+tRoQm
         lbCwDFB49JKAbbuzFudQ7m+RLQUEwU9k2FXMJi08KDleeooA29riDSgwAPd9Usybs8Bm
         zMiA==
X-Gm-Message-State: AFuF++mdMjw7YOIAum1gZOpbDscCmLP4hEmP4SCNvy9sb90NouaeGDav
	bXlhzBXvo+aDy3C9n0QUsebIKY182LFgPL9DRI5Ros2BMEJo9u2T7Fxt/YPwbl/d
X-Gm-Gg: AYBFou27xZ5EAvIIu44Llxj/KzajndvgapKuVGzWGExu4OIdS2BSa1hnKgSVR1/JqCc
	fBleogerF0OcTpSBGYFFh3mstYylDpx0S7/jQN1FqXrDmSKzQCU2K8y5YdWVOsROpsm81ewbbNf
	iRJ8WaG0XS6oqSJ035Pp9aT/tDV4HSCsQ8N1W7DlB0xxrlCltI5x3F1sgw282+mEhLy3pusqnCu
	6DpzALrJ7ErCBE7RQIxksKWYX77T25pOfdgKcSjGTzE4HNvrkzXThF5NiFUZsYRmm4KZlJXtrXH
	bs0ZlpwMhaB8JeWb82nhbPidccsyaYT1RfryEIOAzEMaY5dg7EcBJAoMy7GurFMiRMxr+Kjdd8J
	7Bl5WKOiCTeJ4j64o9KZfPuQ2hVP6s+ddqVpfcBNpo/+aUN6apBD5Kr2FIC2ZbeGdXVag1Uq3GS
	o4XbyOX3Is38q3wT4mPSkaIS/UsrGitx1Z3RcUB0Nwg/blU8CvZEppb5PXoMSYU3wNooY=
X-Received: by 2002:a05:6830:2641:b0:7fa:ab72:9e01 with SMTP id 46e09a7af769-7faab72a85fmr17555883a34.25.1788905969988;
        Tue, 08 Sep 2026 15:19:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.214.133])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7aef680sm16203049a34.26.2026.09.08.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:19:29 -0700 (PDT)
Message-ID: <6aa089f1.6b931ad5.8783.c687@mx.google.com>
Date: Tue, 08 Sep 2026 15:19:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4787442392283579959=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: [v2] Bluetooth: put the peer's on-air address on air when we cannot resolve
In-Reply-To: <20260908-for-upstream-le-connect-on-air-addr-v2-1-2ae9fa066ec8@podgorny.cz>
References: <20260908-for-upstream-le-connect-on-air-addr-v2-1-2ae9fa066ec8@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4787442392283579959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160841/

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.01 seconds
CheckAllWarning               PASS      29.77 seconds
CheckSparse                   PASS      28.69 seconds
BuildKernel32                 PASS      26.31 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      479.16 seconds
TestRunner_l2cap-tester       PASS      78.58 seconds
TestRunner_iso-tester         PASS      108.18 seconds
TestRunner_bnep-tester        PASS      19.36 seconds
TestRunner_mgmt-tester        FAIL      220.30 seconds
TestRunner_rfcomm-tester      PASS      25.94 seconds
TestRunner_sco-tester         PASS      32.05 seconds
TestRunner_ioctl-tester       PASS      27.56 seconds
TestRunner_mesh-tester        FAIL      26.23 seconds
TestRunner_smp-tester         PASS      24.35 seconds
TestRunner_userchan-tester    PASS      20.78 seconds
TestRunner_6lowpan-tester     PASS      24.68 seconds
IncrementalBuild              PASS      32.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: put the peer's on-air address on air when we cannot resolve

98: B2 Line has trailing whitespace: "--  "
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
Read Exp Feature - Success                           Failed       0.240 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.488 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.984 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/725

---
Regards,
Linux Bluetooth


--===============4787442392283579959==--
