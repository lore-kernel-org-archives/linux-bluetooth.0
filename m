Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3963A2475CF
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890338; cv=none; b=YLN5ym1pko2lRusQJTb4V2+AATGUF7Z6sEwdi4phuvVlE8yZBwZIpPtkLT5FdiEJZdfEgDYYOPqJbghwdb9IouAVjsx5pQwaN2iFvSo8kkHHOc8xSE4cmlr0aiu6gMDpQ1nbzJHWQ/OXUkAfhyLbZdBH+vh+tZ4035UbJNmAXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890338; c=relaxed/simple;
	bh=qazqZqAi5jBRldBWpL0uK6p0Y1VorzcfU6s6A89EF34=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u+QeQNlkpM6xAt4VtXguRpRkPZtJzvs0D42vVBAmidITmI4SmOUnxU3Jl4jZzKkf7OHxZQpevJ2qltT23fxq50tPGcwg1gsulIEujAPo1W9c/oZpiRlui0wLXbkd/MZY1Xvl8qACRU03GL6C2GvXpcz7esmicpng+Zcoz3bf7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSDFYdjV; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSDFYdjV"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398c066106cso1609901a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789890336; x=1790495136; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BsAHpUKKDeg0oPedvtOraJiAoBgqdi7ag3A38Pq2Y9Y=;
        b=iSDFYdjVdA6d8odMnGaqsaJLldrm6YcPqFDOikgYlKWYDIJ+MgVRAKoDZjCQ2d4u10
         /tPzMGgK9AtQg7ILXnIhAi6O7y72JO19qGwwFz6ad4AHrMREIy5ar5HiQEn4Cvdc/x0q
         ECEjKKB2S2upgWQBlEAADURjJqBikmD4+Hy0t7UmFCt7f/sW330oU2rwTWReMhvBBdAV
         gXWTskYGSuBRpgCXpYgfMaCxcnjmvLqaoVSiER0HoDHSI6PF8c6OVQmMDbp580+VK7H/
         qYsm87y85YkyLWRNxEFzdceiWY/oWdxuY2o6/6Y8UwuFtNjd6K3h717DGTh4TDOcpQf3
         4CGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789890336; x=1790495136;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BsAHpUKKDeg0oPedvtOraJiAoBgqdi7ag3A38Pq2Y9Y=;
        b=HfI/Rv0T/dH95UoRXrxggoQAEmoqkKYZ3U1Twc0r/lbRgOD1ovOX5unBbaTRM2XqYK
         tWutN4OhET+yUrdPju3reFG42ObsxL/z3SsgVSYNveWK0mwddHooDHirq8TdZn+1Mw0N
         dpie7zCvjRS2MQ37G5CbCe5g8nESRF3rwu5sFZ9S6KzDFA17X6OS/AtuX1QapRWV6wAj
         JKMciUfsl5MXU/vv2gb4Jk/sWCJfvizsCrWyr37CgdwFZF4ZrIGE0UeADUKJknXzN0Bc
         LGMNR02zx/j2k7sLit6OtZjp1iKSvJhTKNhl9v10jF53e3SN5qpE7vrJQlWJOLz2Pxaw
         OOQA==
X-Gm-Message-State: AFuF++nGP9/9VSK47CB3ZM2DnsnBFGD6ySxuuoLlmPV0ehw31oDlsCax
	Iv32QJ+baz9mJLrILbvT/Kf4oiA0sLkmNZcgmBjnteyzVNIOaXZvRpz0+oF1VQ==
X-Gm-Gg: AYBFou229i7Iw0wIFm45Ls6EFB5FL2ugcwKt7ctmu/6pOoBzsuFEbcHqLYK6QJqMUeo
	QRLQ0SvGIuk1hdmP379bgYg2lARL79qmdrTBReddtiVEQmmV/JEnGMgOaliVTe0/Eh7ahKOLOFQ
	XmTt+hrx/0MCdsmluufS6uAW7rIXYPfh6HOjSU4yDQUf5RC6xZa64O3GxMBUBJHQZzmyCcriAXx
	61CIZ51setFUgNRBqlwfsqt5sP3Rs9zH0E9rfCwdYNdz4nVCkBMgcPSQgetdRjCewXeDpq+XKK5
	tyN39keTqt3OnILVqfNSNpI3pYIkwaiMZpZ3MhWqX/LRF0P17V5EhUnbc7KzHnospvC2rii3KHZ
	ays0u9DWroljI8t8G9C7yTCZcqkXKdloojsmP+ulYb22dvhKgnWsGHgIaZp4d4JkYNi8EwFfvT4
	sqZURL3berqDPPBG0T8BB9R4oXHh29815/GV2M0RIdTGvsIEBGFUkttVL+vDE5xB+OS2McNluNp
	0pwjA==
X-Received: by 2002:a17:90b:1c84:b0:39e:6c68:1556 with SMTP id 98e67ed59e1d1-39e6c6832bamr6615383a91.30.1789890336437;
        Sun, 20 Sep 2026 00:45:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.32.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55e71a4sm10226629c88.13.2026.09.20.00.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:45:36 -0700 (PDT)
Message-ID: <6aaf8f20.b153898d.368131.aa97@mx.google.com>
Date: Sun, 20 Sep 2026 00:45:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5236618896912510619=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, peng.fan@oss.nxp.com
Subject: RE: net: protocol: use assign_bit() where applicable
In-Reply-To: <20260920022745.3145847-1-peng.fan@oss.nxp.com>
References: <20260920022745.3145847-1-peng.fan@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5236618896912510619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169532/

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 FAIL      0.07 seconds
BuildKernel                   PASS      29.53 seconds
CheckAllWarning               PASS      33.56 seconds
CheckSparse                   PASS      36.16 seconds
BuildKernel32                 PASS      29.34 seconds
CheckKernelLLVM               PASS      35.53 seconds
TestRunnerSetup               PASS      792.80 seconds
TestRunner_l2cap-tester       PASS      16.65 seconds
TestRunner_iso-tester         PASS      28.88 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        FAIL      61.53 seconds
TestRunner_rfcomm-tester      PASS      4.47 seconds
TestRunner_sco-tester         PASS      7.61 seconds
TestRunner_ioctl-tester       PASS      4.76 seconds
TestRunner_mesh-tester        FAIL      7.79 seconds
TestRunner_smp-tester         PASS      4.49 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      29.04 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.022 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.379 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/804

---
Regards,
Linux Bluetooth


--===============5236618896912510619==--
