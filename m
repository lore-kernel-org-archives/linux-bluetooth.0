Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDD182BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523035; cv=none; b=tlpLPEDU1tTpUdNSAK/3V9jRQq3F0dwuMhSnz2p2Cmy/c19vc22ieWQBMj77DB9U8AQmI0cYtrgfnr+Tg6Yh3LIE5CX2upfEv8jEfvTYNMEFLodNYeUq2L1iJ4Bdlcbfv0OhHCllsoctJBE9JzAu3aiEtTLedlG5YxT9v/xJh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523035; c=relaxed/simple;
	bh=o1n58MDu/BVQPMhUZEqL/Fd5hH0CoUaEX6SSjW36LJk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nz6VHhUDdjsgSjMChVAEQJmg7MSJOFhNZ+g6k5ncaOezEbqzD1aobIrK38gyj9ReddkoqMJdLACsVFF5mfUZovhwNSukWHRsyxnRM+Ex7osDYz3CYCVlOBsqzfqrEWdOzTlWuUnhw9gaphtKahoD8FSrRBP0d5ITzd/V7diC6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZt+Z1Xy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZt+Z1Xy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so29527666d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745523032; x=1746127832; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi6s5DEABXdeBBYHKvTO1hDNDItbqOBnHn+oQjCoFBU=;
        b=gZt+Z1XyLBmRmlfEUs7LnbhWfcb75ISKWe1Ryyh0Rtm6bOHOTcCtg/o1+jz60xVsOu
         3HHvq+qF3KXGo6wOg945cIf9yIUcFxfPswqFJZCYvglAd3E4FySfXi9cY0iwUQtNGJvR
         LO/12PEdB8o1iLSOwKcA+2nE9t9R7AJ5Amtkk8W4E7lk44O2BJTHuuX1FcHBDGK4JSjQ
         wutkR6d8fyxRM4fq1TnyfaxnM1pnX8vfxKRhLk+ssfjJdFBQZ12n1Y/42dPeD3rAjVxq
         7frVjQU4ZQz1MxXj0UBW6A0I3xv9u3BlIo+01SJ3Lf8ZyCAqBKIhp9KzvrbW989LNE9W
         uAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745523032; x=1746127832;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi6s5DEABXdeBBYHKvTO1hDNDItbqOBnHn+oQjCoFBU=;
        b=cH7cwvyynAz9QD88nF9k2w99nIP2bTuHNC2fHV6qV4yjIyzthr5SyAmx54NMW9RWoR
         5jSnO3q68u+Vu2nllToHpNvM4r9rVUbPOOUtWtFyesDxI3we5NO/qzlbIjkO1HfKLf+f
         tYx99AykVeEAp3ADm22LMGkox64ioZ+D1PwCn56TDPR25cVRtmgMOg8OoJOlqG5AjSOM
         GB7A6lkSPGiqte7dxsL/7FPyw+Vlc3tA77SbvhXZyzoCNCmZVJUbDag5iaozXMRQQdGJ
         qmBhNPstz4vm1qeBfrA6U5175B0JagtIesjMLpzJjNQrLUBRT5GTQ6pds3damwvw3pVD
         Vceg==
X-Gm-Message-State: AOJu0Yymx2wdwjt3mTAd5KP/V0IcGEltlg6+VZq5XIXAH3yMSR1xHahE
	dEGvr+LpZlKEb2h6vAT6hS0lfTA0Ksl2qHPoXpPk7F8yurIwW/6ey2Ecbg==
X-Gm-Gg: ASbGnct30QVM3PTSFx9b4o3nxukoWYvaHPYKUQaZcLFByyGmhwKWkGW6W+1sW1mgOPQ
	HK2zCgDG9FY6wKIO1FQy1UJ94FHycLPNC13cPrLjF/BOvL11HPFDJh+4Fv07c3ACE6u/NH1fUB2
	6uEmYzsebM1tAWTa/xhJhHSTqC1l7XwHafAFqTFuUoMVUenoa/fx544+XXQBVJDW8T3f3QhTb7s
	riw2YtUNhID1vayCwzf0K59dJDJs2j1mJIdVprMAPA97ORgoKdaIGA47/0L98DMrM1WOyODs9KW
	neTu6rdFzLLor8XXwe/dq6WCwdo0QiZ7nEHJA0+NPxxCROOD
X-Google-Smtp-Source: AGHT+IEIJczqdOpF4gDgSch1UUTEtY/UL8oVHKTThKgfGY93sTyt6PFohId2ZhyYyD/OxoA0hcGeDQ==
X-Received: by 2002:ad4:5dc5:0:b0:6d4:287d:b8d9 with SMTP id 6a1803df08f44-6f4c0f67934mr54910586d6.2.1745523032439;
        Thu, 24 Apr 2025 12:30:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c09688c0sm12866836d6.54.2025.04.24.12.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:30:32 -0700 (PDT)
Message-ID: <680a9158.d40a0220.3d5dac.6a92@mx.google.com>
Date: Thu, 24 Apr 2025 12:30:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6429190253348969001=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: copy RX timestamp to new fragments
In-Reply-To: <66d361ea708bec460cb214662421cc9295ee2c7a.1745521149.git.pav@iki.fi>
References: <66d361ea708bec460cb214662421cc9295ee2c7a.1745521149.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6429190253348969001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=956731

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.17 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.92 seconds
CheckAllWarning               PASS      27.08 seconds
CheckSparse                   PASS      30.64 seconds
BuildKernel32                 PASS      24.16 seconds
TestRunnerSetup               PASS      462.09 seconds
TestRunner_l2cap-tester       PASS      21.15 seconds
TestRunner_iso-tester         PASS      31.21 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      119.15 seconds
TestRunner_rfcomm-tester      PASS      7.87 seconds
TestRunner_sco-tester         PASS      12.52 seconds
TestRunner_ioctl-tester       PASS      8.32 seconds
TestRunner_mesh-tester        FAIL      8.45 seconds
TestRunner_smp-tester         PASS      7.28 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.88 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.185 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.140 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.123 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6429190253348969001==--
