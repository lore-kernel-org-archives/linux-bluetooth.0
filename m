Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8B3F0744
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082670; cv=none; b=aDJXq1AlfBmon1+eBgKlm6cY/aI7vSqcteSF8J5OOGF7FfGRDGMIuj7fPm7jFQ43r04Qkcm34Jp3px6FsnfL1WypIwFfo4Rl6Az17tvcARgAmPgPJ2YoP0I9kKHwDSlmStvvf3qNAYFdTVknQHMFTnsNbohQNkXvkO7k6N3LaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082670; c=relaxed/simple;
	bh=n3JSG2gQK7WeBfgMWET2sPC0XwQfFv3mBtKquu40Wj0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=povF5buxfMcH9sLAd4nBratWFhnlQqsCAr3wQqP7YbbK1f21duk/ipKsgbRf7tgfwFLmG0jbmO7DEZbA4IwOByBCrAyCAeHC12s8GxL4lHkHUZROPv03vMkqYZZC745OhbPPjg5+Q6bgB3T7rbali5wO2mPO8MhCaTpOd67qylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TArGCHUp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TArGCHUp"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5352a876d5aso68913381cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792082658; x=1792687458; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VVe8Mql7M2IvxmZlc3r1WTNh5qpk6ISTZJg+KXBk4bo=;
        b=TArGCHUpBuJNZYp6duIhdp8cNa1YeBc4PWIyvn4utyRcFKzh7FmVY7HvN85VHzWnZJ
         Y9d3MmN1MkF//zkdhLTu8VyVhicByhyBGTORKSiXQqqRiiV1m3/i4v6miMnUlqrMRcWK
         dUr3PW1CMNZBMHINJS87+sN/xeChgHjEpfISg4RrShgY9Yb5mA6NxjZaLF3Bj5KQwXsv
         qAx+DLKggDV7MFQ7i0EW0DxFpeb9loj4PyQ3KkbHK8bByXOEvf5zCoQhrEzoit97+oYA
         RcmnFABp4QI5rpIz7eHaQd+WFVLGMB6daauAhROJMpHHqBtSG3NIH9QFCdDzD8VIXzEn
         o6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082658; x=1792687458;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VVe8Mql7M2IvxmZlc3r1WTNh5qpk6ISTZJg+KXBk4bo=;
        b=vwIlr6AaXfIIxE3PZvEjRFX61YDintSlZzR6MR19sthzj7Wfzm5geSoW2FhzXDPH2E
         A9ixhYUAnNnK4gE13ZWrpHrSpPIdRWu499VNGHzA8HJ9pmNRj/uPnulwr6E4IwBmgz4j
         sTQE+2Q0hveJ8eKOhLnueNdkm3BJDlWUKQzzAu85GbbzYBShSJnekMH3/YDm2dXaigS7
         Vm2Dy5GA8Wh3wZsBSnCDPkJ2HEeHlFwk0tYMX3RZpIr6kWxHYPcAxsiJBoE2ap2GBFzH
         lRzVYA0y0WrRBNz9v7PCVdJVkd6zH7mZwd1U8j9YsSCQcXuzKasBFWv2X0GBcN5ivfdS
         /gnw==
X-Gm-Message-State: AFq9FYJHfT90gMWky1mD2aDu1Kx0VMBBoOpJL8CnIzP5p5sHN6R3Ffc8
	btqFEOVofUHYJdUuOJLNTeZTQ4WczfauvpEHPzY+cdZKReHwoo3itUmz2IhurQ==
X-Gm-Gg: AYBFou3os/IdwyC1Mg0EnfkRZ4ydyhYeSshnJVEf4Z5xOHTwFqJ45so43meqnqZ9kiL
	r+FHU75ZY3+PfC0KDjzBIBtNkeMhSa8k0ICOrzHwp980PImN0P0f0a7AIlyFCNWJFnp7cVwcC7p
	La571M5H4giJXPAJKNtdR+Kf4kkclCQPdmg9TzDfUuD5QvEpLlgdF6wVDtsBR3LNy26GeeJl5+1
	XD9PQXKGBZUIF/BIwPgwaOMg4QhKPeZmtju8PExB6eJpXoUSRrE9NKkS0hup4Mj6Mqf/12JDWat
	GTrcgPrdljqiHoO7wD9ST2FY2bdXPN+MmiThSqKQIIZtU2b4if94tj7HqjjuqpPKRE/rW24AO1L
	WstM+YH8rlJJcOfFveMMeDINNGGqM5CY1ovnNGkq+LZoYl3aMqsb06xpOCQV4xcuS2PX2uCLUpV
	JIjE6ouvm2wACD9sGu4Xhi3hV7ByvEPRpHPFauKS349Uh+ZpZrspCN9bfscWd2qLu8GVLG2o2Wo
	iuo
X-Received: by 2002:ac8:598a:0:b0:535:1683:5a71 with SMTP id d75a77b69052e-5359fb584a2mr311848181cf.38.1792082658308;
        Thu, 15 Oct 2026 09:44:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.239.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53624a20116sm7868331cf.13.2026.10.15.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:44:17 -0700 (PDT)
Message-ID: <6ad102e1.39dfa124.3a46e3.ba2b@mx.google.com>
Date: Thu, 15 Oct 2026 09:44:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3040528631548110768=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20261015-block-as-nvmem-v11-1-f890ac74f87d@oss.qualcomm.com>
References: <20261015-block-as-nvmem-v11-1-f890ac74f87d@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3040528631548110768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186538/

---Test result---

Test Summary:
CheckPatch                    FAIL      7.86 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      2.40 seconds
SubjectPrefix                 FAIL      0.85 seconds
BuildKernel                   PASS      30.53 seconds
CheckAllWarning               PASS      34.72 seconds
CheckSparse                   PASS      38.10 seconds
BuildKernel32                 PASS      29.57 seconds
CheckKernelLLVM               PASS      34.95 seconds
TestRunnerSetup               PASS      715.75 seconds
TestRunner_l2cap-tester       PASS      12.52 seconds
TestRunner_iso-tester         PASS      10.73 seconds
TestRunner_bnep-tester        PASS      3.19 seconds
TestRunner_mgmt-tester        PASS      87.65 seconds
TestRunner_rfcomm-tester      PASS      4.52 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        PASS      5.56 seconds
TestRunner_smp-tester         PASS      4.38 seconds
TestRunner_userchan-tester    PASS      3.24 seconds
TestRunner_6lowpan-tester     PASS      4.45 seconds
IncrementalBuild              PASS      89.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v11,3/7] block: implement NVMEM provider
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#241: 
new file mode 100644

total: 0 errors, 1 warnings, 194 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14892105.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/948

---
Regards,
Linux Bluetooth


--===============3040528631548110768==--
