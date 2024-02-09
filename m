Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45764D112
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490765; cv=none; b=bCJrtNxNjW5AkBND8y5uVNaqjOJWRefI0cRkClplXdGKMARCiNDT6kNQOeN72FvyxL+YFXu2IwASTXgdHB03gcwQrTEYmsHBjvzt2cqy7GfiCx31b8cT9C7mp8s7O2mlyYjmNJkNrBPhtPjAjES9cOXKUaXa5B2JauUYaLq8Dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490765; c=relaxed/simple;
	bh=ihLeAQ+prGPKRU1BzULXdv9iXBAP9o8R5sctkKF1c/s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DDI91uigpBQIV6DG0q/BSUKbV0qbCe8A346293nF8udtRP6bGCQbwhGVNBBHIOKzP6yfrLnU7FezL7ab0dX5b3HUPUEZF0sP8OdqgCEL4x9FAIH5GxQLaiwXQExItFPI8bhkgCzHlEYuVqlLvekZ3bPSnlDly0OKxPxH2Bta3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm+JULDX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm+JULDX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d71cb97937so10430715ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707490763; x=1708095563; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox3jmXWpbwX642MbUv/L+truprZ/MBKMbzlv61nIaDo=;
        b=mm+JULDXbyL2ij4ab3y6kJLV8OdPxdHbnQfEH1SxRG7QBGLi5z54Cmf/pvQxzBufI3
         ZO4Ho/qhL6R+gCgyXBz3PkTeyLGaxkWDqgfPoWZQOzJ7X1WCBEw0+TKL4Y+aixOq2Sc8
         xkAXKHDzUq7+tansr/t0z7t3N6xE/8mTwm8t4Dfviq00MJdCzYaoxkmpkEGvr7E8ET9C
         P3YtoOtWjXD4lhc3FVdN/ZPBUMlFq5kpob0F+etjmf+66UAP/qdX7TyCOAN8kq+26H2Y
         yAQMtXgSLDQxtKTdL6jK49lone/+4VYu4weqQZmpSwNAW1DFRTAdrvbMtH5cGNPYEdH7
         P0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490763; x=1708095563;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ox3jmXWpbwX642MbUv/L+truprZ/MBKMbzlv61nIaDo=;
        b=t9mOU9DfPmx4e9LpC3PHN2iczfwwqPRsPYcuXADghqTJam779S1kr0v/cJ0sKwqbAl
         He44fDBEQiSSfR9wBguWFm+M6ys+3T5fVj1OKfk9K5CUGgzf4KPwDPtMTfhUiS4cR4q/
         XIvo/GVICzx2EAUROBPQLtLLb1HtRHe5VxZyH8yx6p2/AV+RGMHA9R6MWcFy59YPHLLo
         JcRfy5SGh429GXAoSC3tq3ITdkZ3lmIiNa1nwTMkXUqQpbOPAOBtk+JD8x+k7v2eVS0z
         fJVU2TY0QNyldhzF1thjZv1rufRZpMeAABiMMQgmcyDoJ11RuIGlqCSJiGJ67nUnXmyP
         2c1A==
X-Gm-Message-State: AOJu0YyyJeLtxSW45RRCGQKpjKJvc26f3B4j3h2WI0Shn7/qLT2T6f8l
	R/T6IVSWSo3HhGcAWxxhZyQactPYaePGBPhUWgdqJc8QS3Lp5LYwTHqT3qs/
X-Google-Smtp-Source: AGHT+IHaWWemiwuA17f4dxIl36boGLiv65bJBxp+muxvG7wUirM03k8jIovvhUWn8AcR0Fz0YL9cQA==
X-Received: by 2002:a17:903:2291:b0:1d8:d73b:794f with SMTP id b17-20020a170903229100b001d8d73b794fmr2094147plh.56.1707490762606;
        Fri, 09 Feb 2024 06:59:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnnQQ6FEO85QhzNscJOcvNZSiIS+/IIMgiWqW2gXK4MxAgvaj83l5/xpGg1xyIFcwU6wdH/BhFRXU0G/Z2Il2dPlMYiw==
Received: from [172.17.0.2] ([20.171.70.50])
        by smtp.gmail.com with ESMTPSA id jx4-20020a170903138400b001d9602f3dbesm1627192plb.24.2024.02.09.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 06:59:22 -0800 (PST)
Message-ID: <65c63dca.170a0220.dbce5.5608@mx.google.com>
Date: Fri, 09 Feb 2024 06:59:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5709917721428322214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
In-Reply-To: <20240209141612.3554051-1-luiz.dentz@gmail.com>
References: <20240209141612.3554051-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5709917721428322214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824664

---Test result---

Test Summary:
CheckPatch                    FAIL      1.32 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.87 seconds
CheckAllWarning               PASS      30.53 seconds
CheckSparse                   PASS      36.04 seconds
CheckSmatch                   PASS      98.66 seconds
BuildKernel32                 PASS      27.08 seconds
TestRunnerSetup               PASS      516.58 seconds
TestRunner_l2cap-tester       PASS      18.22 seconds
TestRunner_iso-tester         FAIL      131.89 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        FAIL      166.48 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      7.85 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PASS      25.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#97: 
Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequentially")

total: 0 errors, 1 warnings, 0 checks, 53 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13551351.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       6.208 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 5, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.111 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.115 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.146 seconds
LL Privacy - Remove Device 1 (Remove from AL)        Timed out    2.494 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.691 seconds


---
Regards,
Linux Bluetooth


--===============5709917721428322214==--
