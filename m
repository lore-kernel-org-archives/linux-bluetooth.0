Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE471E51EE
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592030; cv=none; b=LuXP6lKM09+F0E1D0KrdH7ETO4zaP33F2EYcxKukKFdwxyeBsaeF850fmM44NnbPjZlXdkjS4hZincDMlHxRskGP51rTv9q6PN0XK8YQcS7WoEgPBKJL58eoMxol5+0Cy8OOmyJrlH9kgcU3s5T5DeytpTr+ort4rFQZiakH7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592030; c=relaxed/simple;
	bh=lHxWjrhhXYiHHf13ZrAFhlCcnIWrN9emXHTGL7/Nc64=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rmi5TJqRFQCj5NoeZ9hnUVfN+QmqnJJH7T6tEC5IjcJMuxY/5icoetlIPhMJ5kUvukJ6XFFAPnAqrjIrTFd81uQZ/vdHaCmIHUP0LyrVgwLZ0dNMElj7yKOxlYqLRxx/MX1xP+W8WPKzcRQezxGKlFahhLAsAkJsjTnEDUjvOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyMIQbZm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyMIQbZm"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e63d4b05so3338378b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752592028; x=1753196828; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CYFW95a5nhsvF7+UAvrHRdA9zXe9kd2/AwbX/S4V+Qw=;
        b=FyMIQbZm1HE1Qy2qZty/yZlzosrsCBpNSl3DHlpBTOdVkI0MFmUNRHfVb8cYeWltEa
         k1cucQZSee6WQKVbjBHtT3juOF3A8+WQF2eKocz9ThQfH8XDmOPFdufHs4aazCyN6qiX
         yMbmgZKqUaCVVD+/++szVkpKUalsxpF1gf2+PxGmoeEyKCjyICEasBe3Rv1ZnzgysZ9T
         /ggaPXH4L5zW4yNXiuzm7okbtVQhlbCqPI+p2zLBt/8eBSMsMHgvODuWrYcjXTKmxdCH
         a8rFxAdPnuQLg1GqUOIRNNmJwJFawdnHqOIQVnE+qxKyqAMLxnTX/McqD5166uDqDGjj
         KrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592028; x=1753196828;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYFW95a5nhsvF7+UAvrHRdA9zXe9kd2/AwbX/S4V+Qw=;
        b=bi+a3Kw6oh534qoU22Vvndkp55NAdSeViC3EjR2ALsmEe2+ZbCq95OSfbMmo+zcvCB
         C2suHUxXXZlfoHLypr6FIwyduAW97Lwg7J8JBhjhlSF1e98bXWi/WNnFngOBd9s0xy+S
         Nly05KEend1pJgwJOyz/t64Nq2hxeNxCN5jmcRWdnlBO8jg52x/X1GwWFPyOlppVEqxj
         mTxLOmlZojIU7JKcolNtw6aEHQ79dpdRz0NO9vHQIflzcPaR/elhzsb0KrYeUpXadKPv
         /+7Shvf04Vq2usOOYSSPBTYqUFKixZlQdocOQ9mUURgkuDhvWhFnD0MFVU5ciDpI5ZUt
         XX7Q==
X-Gm-Message-State: AOJu0YyYYkEgtxalsTBf3a7cgxz9Mz7iP2hoXCD2pD9NRyk7e8WKrk+u
	idgZVEn1lNiUARO3h/qOVL1E/Qz4vZC1IAnaTfj8J2jmndXUzPbXxFm/Vshdog==
X-Gm-Gg: ASbGnctS3W5tGAUW4FTXqppEStHEBt2/8pUucNpOOTDqP0EVBve2RiQUjipA4+GMPl4
	tG1HdMu3KwoFV+kw53uLwwZkaFsMiutYJRzSYiWh8FExJ2X8DgSP5oaXmmJbRMVWWfD0Z3JO99H
	PDEEPoWUBnqczW1o7kE5oOOuUFTEohezh8tUuAiXD4THSv51bhjv23WNS/xAdqwf2yOX5Nyjnk8
	YQykdXU/UMyPFh4rnOyKUaAhXqUBSJM4jMsBllMWLan71m0NGzkpwWiWmvfjOMcb0Vl0C1jmbSt
	x61jWD0mvtcY+LVgFsg87neoDYzEbXc9sVYaAklA251P+aOx/LXPvg3wf1mhXnACUuuQwUenA82
	4Z0OS3xJxeP7KbTUdG2RbW+CSjV4dhXM=
X-Google-Smtp-Source: AGHT+IFIUpAF8ieGKH/yacae5XOpBnUeqhaN0x6pZ8g7TpQpjw0TZzBnKg/O3hdSTX+KnK1Mxvg00Q==
X-Received: by 2002:a05:6a00:92a8:b0:74c:efae:ffae with SMTP id d2e1a72fcca58-74ee03a19acmr19974577b3a.5.1752592027380;
        Tue, 15 Jul 2025 08:07:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.192.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm10692371b3a.76.2025.07.15.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:07:06 -0700 (PDT)
Message-ID: <68766e9a.050a0220.145ccb.2f54@mx.google.com>
Date: Tue, 15 Jul 2025 08:07:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4660565292002729923=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: btusb: Sort WCN6855 device IDs and add one more ID
In-Reply-To: <20250715-q_newid-v1-1-8a1120c61fc9@oss.qualcomm.com>
References: <20250715-q_newid-v1-1-8a1120c61fc9@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4660565292002729923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982572

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      27.40 seconds
CheckAllWarning               PASS      26.87 seconds
CheckSparse                   PASS      30.41 seconds
BuildKernel32                 PASS      24.16 seconds
TestRunnerSetup               PASS      473.37 seconds
TestRunner_l2cap-tester       PASS      25.15 seconds
TestRunner_iso-tester         PASS      38.54 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        FAIL      132.36 seconds
TestRunner_rfcomm-tester      PASS      9.31 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      12.41 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
IncrementalBuild              PENDING   0.78 seconds

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
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.167 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.208 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.111 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4660565292002729923==--
