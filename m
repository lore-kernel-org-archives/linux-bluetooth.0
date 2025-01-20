Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDF1E3784
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385027; cv=none; b=kzKcXlDrEcZqB/yT4Q3He8rgTk8o1cPmUFjuuZ+HiQFcUsXJ0h4YzfQxdDQHTDiyRMJ5DDZu9+yy3geNE/39L9GeY3Rr0ot23MNViyxaFSkP5J14wwl1XiWuvphEalPQ4a2y4EokKsvJ0Iy2eeYALT27QgCKKLlMAGBwW+GLzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385027; c=relaxed/simple;
	bh=2AVE7bCTyhD4Ej87J+2MnK1XTjsmjJJZF1ydeCBpEvY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hK/3Z6ZpT8lbnlVPuqIIAB4tIPNnGKPzKWXFGW0obu79/ZBGi7oNkwJJzxoDhWbgpFrZRvK89+65GeMh3VhuZaqAe/fYgDK9An0b421OQos0VHsEcXse1z8oNNU0yNYMkq1gxCpZuZHo8M05YCj4WJoIHsUyG/cswz/44jx0uDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiWPAc1h; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiWPAc1h"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e1b11859a7so18800256d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 06:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737385024; x=1737989824; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOC/1UIQp/fo5HuIDh8p8xEn2xHg9FLGO3pnLqMRDnA=;
        b=GiWPAc1hgmRcJzJScsAB36E8bBXiaFKjbByHdfZZJ2bcsKoOzBK9mP4o9y8cF9spTg
         AFdlrR3vxo51JlX7atHqU5GDneauuxpJd9DaIylL8NvNmQ3wiH2+il1+Nizm+S1yWnP+
         xblPdabRDAG+w6heB7m0lQa0bOpz9i5jHjp5Ab1HB4Q6bFNsSg4/8aa1c00CFUF2PtMe
         kCKmVG3agVVnCxyWELAR8GwyLDP68VriYv+Cm94eZtDUznJkoB6X/lVzATXzihIJlVWB
         IjF0s/Fl/ppa0ppGMyQ2eT2W0DUGfWOLEnTx+r14BaXkHXSTFpL+rzzj5W8f4ncade6h
         9pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737385024; x=1737989824;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOC/1UIQp/fo5HuIDh8p8xEn2xHg9FLGO3pnLqMRDnA=;
        b=hyvHR+rds2zLdPPZSFuIc6gM0ydfQP97ZVUH0P0/TCzby+JCknQwcb+Yig+LyK66iC
         TnoTCEk0boIEwd7cow7lteAJ1t2Hr7V1bnOicTCZu35AmEpO0HvMZFREUXii26LsoVzD
         WReMpRQ6UVNWD6M6oayW0gK/CH6VoiRG9eE//Z3eozghCQi3uciAri/LhXhnoqO3ZMi4
         RhuMcjgdhUpmoTqQ75OP+iBke1zPp/auJXRrB4mQobAZyecQNzsAJlXKf+ACCsKxqFXp
         2AwmswTX0rQca5O6zfKnzx3r++2/flGTT2U4Czhmi59KOV5DX8CHlykz9qIQEUOYtvDu
         lCBw==
X-Gm-Message-State: AOJu0YxGlANUHU9Cmg0mVwW8g/y3RuBg1+l1RKydYaSWidnh2Zi2giPo
	qdRLI+5YAntQ2puJmCsZLVT2MfrBmQVBkxtsN+zR/9y4CBU3c2rwgslrVQ==
X-Gm-Gg: ASbGncs8kbawvAigTEit7Uiy+RgI3twNrVq+WiA9SbwEeFwD5OZ/hd2cW4qKwTSx2lK
	zE8k6mM/ELcIVAa+jZ8OjVWvPks1KiOpNxl5cWQofi7rG4lYRKfYHQBm7LMhW6XWyt1Z/DWelf2
	neIP6roM8HYx1XsG8ULzXveT53EVu6Uqup/bCr7T/tP3HbhRLkw6U3rOlyVEDdWKOIiNHhDhZl8
	IqEnmHmmoOw5qHpALWESVx9vlV+i2bIc140r2enSU9kxP5SFaoEaN3TiXJQlGZZC4z8JBTJnw0=
X-Google-Smtp-Source: AGHT+IGi8qxutTX0aQj0XsO6mDImyqqJavZ7mt2fZTagSUfqxzezYq6yjzyOt2f3wfAen4Iyab7ACQ==
X-Received: by 2002:a05:6214:410:b0:6d8:9d81:2107 with SMTP id 6a1803df08f44-6e1b216c866mr224536186d6.20.1737385024523;
        Mon, 20 Jan 2025 06:57:04 -0800 (PST)
Received: from [172.17.0.2] ([20.42.10.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd39c3sm41931956d6.81.2025.01.20.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:57:04 -0800 (PST)
Message-ID: <678e6440.0c0a0220.ef8c7.f97c@mx.google.com>
Date: Mon, 20 Jan 2025 06:57:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7149296007636575846=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Fix glitches seen in dual A2DP streaming
In-Reply-To: <20250120141946.2690063-1-neeraj.sanjaykale@nxp.com>
References: <20250120141946.2690063-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7149296007636575846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926954

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.58 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      30.31 seconds
BuildKernel32                 PASS      24.19 seconds
TestRunnerSetup               PASS      428.24 seconds
TestRunner_l2cap-tester       PASS      20.49 seconds
TestRunner_iso-tester         PASS      30.09 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        FAIL      121.16 seconds
TestRunner_rfcomm-tester      PASS      7.64 seconds
TestRunner_sco-tester         PASS      9.47 seconds
TestRunner_ioctl-tester       PASS      8.00 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.65 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.201 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.131 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7149296007636575846==--
